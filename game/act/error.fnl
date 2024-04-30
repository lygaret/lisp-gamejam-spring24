(local activity {})

;; convert compiler's ansi escape codes to love2d-friendly codes
(fn convert-msg [msg]
  (case (msg:match "(.*)\027%[7m(.*)\027%[0m(.*)")
    (pre selected post) [[1 1 1] pre [1 0.2 0.2] selected [1 1 1] post]
    _                   msg))

;; error activity (for `safely` calls)

(fn activity.activate [self actmgr prev msg traceback]
  (set self.actmgr    actmgr)
  (set self.prev      prev)
  (set self.traceback traceback)
  (set self.msg       (convert-msg msg))

  (print msg)
  (print traceback))

(fn activity.draw [self]
  (love.graphics.clear 0.34 0.61 0.86)
  (love.graphics.setColor 0.9 0.9 0.9)
  (love.graphics.print "oh no! bad things!\n,reload the bad module and space" 15 10)
  (love.graphics.print self.msg 10 60)
  (love.graphics.print self.traceback 15 125))

(fn activity.keypressed [self key]
  (match key
    :escape (love.event.quit)
    :space  (self.actmgr:load-activity self.prev)))

{: activity}
