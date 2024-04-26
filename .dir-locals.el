;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

;; it's a love project
((fennel-mode . ((eval . (let ((root (expand-file-name (project-root (project-current)))))
                           (setq
                            fennel-program (concat "love " root)
                            fennel-proto-repl-fennel-module-name "lib.fennel"))))))
