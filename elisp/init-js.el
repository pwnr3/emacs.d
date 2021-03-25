;;; -*- lexical-binding: t -*-

(straight-use-package 'js2-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'tide)
(straight-use-package 'flycheck)
(straight-use-package 'company)
(straight-use-package 'prettier-js)

(defun +setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
	(prettier-js-mode)
	(set (make-local-variable 'company-backends)
			 '((company-tide company-files :with company-yasnippet)
				 (company-dabbrev-code company-dabbrev))))


;; Javascript
;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(with-eval-after-load 'js2-mode
	(setq js2-indent-level 2
				js2-basic-offset 2
				js-chain-indent t
				js2-highlight-level 3
				js2-idle-timer-delay 0.1
				js2-mode-show-parse-errors t
				js2-mode-show-strict-warnings nil
        js2-strict-missing-semi-warning nil
        js2-strict-trailing-comma-warning nil
				)

	(add-hook 'js2-mode-hook 'flycheck-mode)
	(add-hook 'js2-mode-hook 'company-mode)
	(add-hook 'js2-mode-hook 'prettier-js-mode)
	(add-hook 'js2-mode-hook #'+setup-tide-mode)

	;; configure javascript-tide checker to run after your default javascript checker
	;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
	;(flycheck-select-checker 'javascript-eslint)
	)

;; Typescript
(with-eval-after-load 'typescript-mode
	(add-hook 'typescript-mode 'company-mode)
	(add-hook 'typescript-mode #'+setup-tide-mode)
	(add-hook 'tide-mode-hook (lambda ()
															(add-hook 'kill-buffer-hook #'+cleanup-tide-processes nil t)))

	(define-key typescript-mode-map (kbd "C-c C-t") 'tide-documentation-at-point)
	(define-key typescript-mode-map (kbd "C-c T p") #'+open-region-in-playground)

	(defun +open-region-in-playground (start end)
    "Open selected region in http://www.typescriptlang.org/Playground
                 If nothing is selected - open the whole current buffer."
    (interactive (if (use-region-p)
                     (list (region-beginning) (region-end))
                   (list (point-min) (point-max))))
    (browse-url (concat "http://www.typescriptlang.org/Playground#src="
                        (url-hexify-string (buffer-substring-no-properties start end)))))

  (defun +cleanup-tide-processes ()
    "Clean up dangling tsserver processes if there are no more buffers with
`tide-mode' active that belong to that server's project."
    (when tide-mode
      (unless (cl-loop with project-name = (tide-project-name)
                       for buf in (delq (current-buffer) (buffer-list))
                       if (and (buffer-local-value 'tide-mode buf)
                               (with-current-buffer buf
                                 (string= (tide-project-name) project-name)))
                       return buf)
        (kill-process (tide-current-server)))))

	(setq typescript-indent-level 2
				tide-completion-detailed t)
	;(flycheck-add-next-checker 'typescript-tide 'typescript-tslint)
	)

(provide 'init-js)
