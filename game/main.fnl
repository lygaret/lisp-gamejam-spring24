(local fennel (require :lib.fennel))
(local repl   (require :lib.stdio))

(fn love.load [args]
  (repl.start))

(fn love.draw []
  (love.graphics.setColor 0.4 0.7 0.9 1.0)
  (love.graphics.print "Hi Jon" 100 150))
