(local fennel      (require :lib.fennel))
(local repl        (require :lib.repl))
(local {: manager} (require :lib.activity-manager))

(global pp (fn [x] (print (fennel.view x))))

(fn love.load [args]
  (repl.start)
  (manager:error-activity :game.act.error)
  (manager:load-activity  :game.act.main))

(fn love.draw        [] (manager:proxy :draw))
(fn love.keypressed [k] (manager:proxy :keypressed k))
(fn love.update     [d] (manager:proxy :update d))
