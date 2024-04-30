(local fennel (require :lib.fennel))

(local  manager {})
(global activity nil)
;; global for hot-patch reloading support

(fn manager.error-activity [self path]
  (set self.error-path path))

(fn manager.load-activity [self path ...]
  (let [{: activity} (require path)]
    (when (?. activity :activate)
      (match (pcall activity.activate activity self ...)
        (false err) (print "error activating activity" err)))
    (set self.path path)
    (set _G.activity activity)))

(fn manager.safely [self f]
  (xpcall f #(self:load-activity self.error-path self.path $ (fennel.traceback))))

{: manager}
