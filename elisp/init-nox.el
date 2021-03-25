;;; init-nox.el --- -*- lexical-binding: t -*-

(straight-use-package '(nox :type git :host github :repo "manateelazycat/nox"))

(dolist (hook (list
               'js-mode-hook
               'rust-mode-hook
               'python-mode-hook
               'ruby-mode-hook
               'java-mode-hook
               'sh-mode-hook
               'php-mode-hook
               'c-mode-common-hook
               'c-mode-hook
               'csharp-mode-hook
               'c++-mode-hook
               'haskell-mode-hook
               ))
  (add-hook hook '(lambda () (nox-ensure))))

(with-eval-after-load 'nox
  (add-to-list 'nox-server-programs '(js-mode . ("/usr/local/bin/typescript-language-server" "--stdio"))))

(provide 'init-nox)
