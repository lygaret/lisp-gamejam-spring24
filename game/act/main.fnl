(local sti (require :lib.sti))
(local activity { :map nil })

(fn activity.activate [self actmgr]
  (set self.actmgr actmgr)
  (set self.map (sti "assets/farm-stage-map.lua")))

(fn activity.draw [self]
  (love.graphics.setColor 1 1 1)
  (self.map:draw 0 0))

(fn activity.update [self dt]
  (self.map:update dt))

(fn activity.keypressed [_self key]
  (pp (.. key 3)))

{: activity}
