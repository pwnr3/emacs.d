;;; -*- lexical-binding: t -*-

;(straight-use-package 'dash)
;(require 'subr-x)

(straight-use-package 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
	(require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))
;(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
;(setq exec-path (append '("/usr/local/bin") exec-path))


(defvar-local +project-name-cache nil
  "Cache for current project name.")

(defun +in-string-p ()
  (interactive)
  (or (nth 3 (syntax-ppss))
      (member 'font-lock-string-face
              (text-properties-at (point)))))

(defun +in-comment-p ()
  (interactive)
  (nth 4 (syntax-ppss)))

(defun +set-no-other-window ()
  (set-window-parameter (first (window-list)) 'no-other-window t))

(provide 'init-util)
