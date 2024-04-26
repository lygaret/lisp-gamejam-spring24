(local fennel (require :lib.fennel))
(local repl   (require :lib.repl))
(local sti    (require :lib.sti))
(local cargo  (require :lib.cargo))

(global pp     (fn [x] (print (fennel.view x))))

(global assets (cargo.init { :dir "assets" }))
(global map    (sti "assets/farm-stage-map.lua"))

(fn love.load [args]
  (assets) ;; pre-load
  (repl.start))

(fn love.update [dt]
  (map:update dt))

(fn love.draw []
  (love.graphics.setColor 1 1 1 1)
  (map:draw 0 0))
