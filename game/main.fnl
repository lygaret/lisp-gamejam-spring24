(local fennel      (require :lib.fennel))
(local repl        (require :lib.repl))
(local {: manager} (require :lib.activity-manager))

(global pp (fn [x] (print (fennel.view x))))

(fn love.load [args]
  (repl.start)
  (manager:error-activity :game.act.error)
  (manager:load-activity  :game.act.main))

(macro proxy [name ...]
  `(let [method# (?. _G.activity ,name)]
     (when method#
       (manager:safely (partial method# _G.activity ,...)))))

(fn love.draw        [] (proxy :draw))
(fn love.keypressed [k] (proxy :keypressed k))
(fn love.update     [d] (proxy :update d))
