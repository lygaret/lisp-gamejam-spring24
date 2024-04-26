(local fennel (require :lib.fennel))
(local repl   (require :lib.stdio))

(global pp (fn [x] (print (fennel.view x))))

(fn love.load [args]
  (repl.start))

(fn love.draw []
  (love.graphics.clear 0.9 0.9 0.9 1.0)
  (love.graphics.setColor 0.2 0.3 0.5 1.0)
  (love.graphics.print "Hi Jon" 100 150))
