(defun +add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (expand-file-name dir user-emacs-directory)))
    (add-to-list 'load-path default-directory)
    (normal-top-level-add-subdirs-to-load-path)))
(+add-subdirs-to-load-path "elisp")
(+add-subdirs-to-load-path "themes")

;;; Personal configuration may override some variables
(let ((private-conf (expand-file-name "private.el" user-emacs-directory)))
  (when (file-exists-p private-conf)
    (load-file private-conf)))

(require 'init-defaults)
(require 'init-straight)
(require 'init-gc)
(require 'init-laf)
