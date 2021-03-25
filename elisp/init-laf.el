;;; -*- lexical-binding: t; -*-

(straight-use-package
 '(joker-theme :type git
               :host github
               :repo "DogLooksGood/joker-theme"))
(straight-use-package
 '(storybook-theme :type git
									 :host github
									 :repo "DogLooksGood/storybook-theme"))
(straight-use-package
 '(printed-theme :type git
								 :host github
								 :repo "DogLooksGood/printed-theme"))
(require 'joker-theme)
(require 'storybook-theme)
(require 'printed-theme)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;; No cursor blink
(add-hook 'after-init-hook (lambda () (blink-cursor-mode -1)))

;;; Nice window divider
(window-divider-mode 1)
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?┃))

;;; No fringe in minibuffer
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (set-window-fringes
             (minibuffer-window frame) 0 0 nil t)))

;;; Margin
(let ((margin 0))
  (add-to-list 'default-frame-alist (cons 'internal-border-width margin)))

;;; Transparency
(let ((alpha 100))
  (add-to-list 'default-frame-alist (cons 'alpha alpha)))

;;; No window decoration
;(add-to-list 'default-frame-alist (cons 'undecorated t)) ;; Mac emacs fullscreen problem

;;; Fonts
(defvar +font-family "Fira Code")
(defvar +ufont-family "WenQuanYi Micro Hei Mono")
(defvar +fixed-pitch-family "Source Code variable")
(defvar +variable-pitch-family "Source Code variable")
(defvar +font-size 16)

(defun +load-base-font ()
  (let* ((font-spec (format "%s-%d" +font-family +font-size))
         (variable-pitch-font-spec (format "%s-%d" +variable-pitch-family +font-size))
         (fixed-pitch-font-spec (format "%s-%d" +fixed-pitch-family +font-size)))
    (add-to-list 'default-frame-alist `(font . ,font-spec))
    (set-face-attribute 'variable-pitch nil :font variable-pitch-font-spec)
    (set-face-attribute 'fixed-pitch nil :font fixed-pitch-font-spec)))

(defun +load-ext-font ()
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :family +ufont-family))))

(defun +load-font ()
  (let* ((font-spec (format "%s-%d" +font-family +font-size))
         (variable-pitch-font-spec (format "%s-%d" +variable-pitch-family +font-size))
         (fixed-pitch-font-spec (format "%s-%d" +fixed-pitch-family +font-size)))
    (set-frame-font font-spec)
    (set-face-attribute 'variable-pitch nil :font variable-pitch-font-spec)
    (set-face-attribute 'fixed-pitch nil :font fixed-pitch-font-spec))
  (+load-ext-font))

;(+load-font)
(+load-base-font)
(add-hook 'after-init-hook '+load-ext-font)

;;; Theme
(defvar +after-change-theme-hook nil
  "Hooks called after theme is changed.")
(defvar +theme-list '(joker printed storybook))

(defun +change-theme (&optional init)
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  (let ((theme (car +theme-list)))
    (load-theme theme t)
    (setq +theme-list (append (cdr +theme-list) (list (car +theme-list))))
    (unless init
      ;(+load-font)
      (message "Load theme: %s" theme)
      (run-hook-with-args '+after-change-theme-hook theme))))

(+change-theme t)

(provide 'init-laf)
