;; https://gitlab.com/alexjgriffith/min-love2d-fennel/
;; Copyright Alexander Griffith, 2019, licensed GPLv3

;; minor cleanups, reorganization
;; Jonathan Raphaelson - april 25, 2024

(local fennel (require :lib.fennel))
(require :love.event)

;; This module exists in order to expose stdio over a channel so that it
;; can be used in a non-blocking way from another thread.

(fn prompt [cont?]
  (io.write (if cont? ".." ">> ")) (io.flush) (.. (tostring (io.read)) "\n"))

(fn looper [event channel]
  (match (channel:demand)
    [:write vals]
    (do (io.write (table.concat vals "\t"))
        (io.write "\n"))

    [:read cont?]
    (love.event.push event (prompt cont?)))
  (looper event channel))

;; This module is loaded twice: initially in the main thread where ... is nil,
;; and then again in a separate thread where ... contains the channel used to communicate with the main thread.

(match ...
  (event channel) (looper event channel))

{:start
 (fn start-repl []
   (let [code    (love.filesystem.read "lib/stdio.fnl")
         luac    (love.filesystem.newFileData
                  (fennel.compileString code) "io")
         thread  (love.thread.newThread luac)
         channel (love.thread.newChannel)

         ;; fennel.repl is a table with a __call meta
         ;; partial lets us call it in coroutine.create
         coro (coroutine.create (partial fennel.repl))
         options {:moduleName "lib.fennel"
                  :readChunk (fn [{: stack-size}]
                               (channel:push [:read (< 0 stack-size)])
                               (coroutine.yield))
                  :onValues (fn [vals]
                              (channel:push [:write vals]))
                  :onError (fn [errtype err]
                             (channel:push [:write [err]]))}]

     ;; kick off the coro, which will yield waiting for a read
     (coroutine.resume coro options)

     ;; kick off a love "thread" which pumps messages through the coro
     (thread:start "eval" channel)
     (set love.handlers.eval
          (fn [input]
            (coroutine.resume coro input)))))}
