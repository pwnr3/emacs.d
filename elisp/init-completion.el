;;; -*- lexical-binding: t; -*-

(straight-use-package 'yasnippet)
(straight-use-package 'company)
(straight-use-package 'selectrum)
(straight-use-package 'prescient)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'deadgrep)

(defun +complete ()
	(interactive)
	(or (yas/expand)
			(company-indent-or-complete-common nil)))

;;; yasnippet
(autoload #'yas-minor-mode "yasnippet")
(add-hook 'prog-mode-hook 'yas-minor-mode)
(with-eval-after-load "yasnippet"
	(let ((inhibit-message t))
		(yas-reload-all))

	(define-key yas-keymap [escape] nil)
	(define-key yas-keymap [tab] nil)
	(define-key yas-keymap (kbd "S-<tab>") nil)
	(define-key yas-keymap (kbd "TAB") nil)
	(define-key yas-keymap [return] 'yas-next-field-or-maybe-expand)
	(define-key yas-keymap (kbd "RET") 'yas-next-field-or-maybe-expand)
	(define-key yas-keymap (kbd "S-<return>") 'yas-prev-field))

;;; company
(setq
 company-tng-auto-configure nil
 company-frontends '(company-tng-frontend
										 company-pseudo-tooltip-frontend
										 company-echo-metadata-frontend)
 company-begin-commands '(self-insert-command)
 company-idle-delay 0.5
 company-tooltip-limit 10
 company-tooltip-align-annotations t
 company-tooltip-width-grow-only t
 company-tooltip-idle-delay 0.1
 company-minimum-prefix-length 3
 company-dabbrev-downcase nil
 company-abort-manual-when-too-short t
 company-require-match nil
 company-global-modes '(not dired-mode dired-sidebar-mode)
 company-tooltip-margin 0)
(autoload #'company-mode "company")
(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'conf-mode-hook 'company-mode)
(add-hook 'eshell-mode-hook 'company-mode)
(with-eval-after-load "company"
	(require 'company-tng)
	(require 'company-template)
	(add-hook 'company-mode-hook 'company-tng-mode)

	(define-key company-mode-map [tab] '+complete)
	(define-key company-mode-map (kbd "TAB") '+complete)
	(define-key company-active-map [tab] 'company-complete-common-or-cycle)
	(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
	(define-key company-active-map [escape] nil)
	(define-key company-active-map [return] nil)
	(define-key company-active-map (kbd "RET") nil)
	(define-key company-active-map (kbd "SPC") nil)
	(define-key company-active-map (kbd "SPC") nil)
	(define-key company-active-map (kbd "{") #'company-select-previous)
	(define-key company-active-map (kbd "}") #'company-select-next)

	(define-key company-template-nav-map (kbd "RET") 'company-template-forward-field)
	(define-key company-template-nav-map [return] 'company-template-forward-field)
	(define-key company-template-nav-map (kbd "TAB") nil)
	(define-key company-template-nav-map [tab] nil))

;; (setq tab-always-indent 'complete)

(require 'selectrum)
(require 'selectrum-prescient)
(selectrum-mode t)
(selectrum-prescient-mode t)
(with-eval-after-load "selectrum"
	(define-key selectrum-minibuffer-map (kbd "{") #'selectrum-previous-candidate)
	(define-key selectrum-minibuffer-map (kbd "}") #'selectrum-next-candidate)
	(define-key selectrum-minibuffer-map (kbd "[") #'previous-history-element)
	(define-key selectrum-minibuffer-map (kbd "]") #'next-history-element))

;; (require 'icomplete)
;; (icomplete-mode 1)
;;
;; (with-eval-after-load "icomplete"
;;   (define-key icomplete-minibuffer-map (kbd "}") #'icomplete-forward-completions)
;;   (define-key icomplete-minibuffer-map (kbd "{") #'icomplete-backward-completions)
;;   (define-key icomplete-minibuffer-map (kbd "[") #'previous-history-element)
;;   (define-key icomplete-minibuffer-map (kbd "]") #'next-history-element))

;;; deadgrep
(autoload #'deadgrep "deadgrep")
(with-eval-after-load "deadgrep"
	(define-key deadgrep-mode-map (kbd "w") 'deadgrep-edit-mode)
	(define-key deadgrep-edit-mode-map (kbd "C-x C-s") 'deadgrep-mode))

(provide 'init-completion)
