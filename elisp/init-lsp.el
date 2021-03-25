;; -*- lexical-binding: t; -*-

(straight-use-package 'flymake)
(straight-use-package 'eglot)

(autoload #'flymake-mode "flymake" nil t)

(with-eval-after-load "flymake"
	(define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
	(define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error))

(setq
 eglot-stay-out-of nil
 eglot-ignored-server-capabilites '(:documentHighlightProvider))

(autoload #'eglot-ensure "eglot" nil t)
(autoload #'eglot "eglot" nil t)

;(add-hook 'js-mode-hook 'eglot-ensure)
;(with-eval-after-load "eglot"
;	(add-to-list 'eglot-server-programs
;							 `(js-mode . ("/usr/local/bin/typescript-language-server" "--stdio"))))

(provide 'init-lsp)
