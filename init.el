;;; init.el --- kgmacs configuration

;;; Code:

;; Do NOT use any x-resources
(setq inhibit-x-resources t)

;; Bug fix introduced in emacs 25.3
;;  http://lists.gnu.org/archive/html/info-gnu/2017-09/msg00006.html
(if (version< emacs-version "25.3")
    (eval-after-load "enriched"
      '(defun enriched-decode-display-prop (start end &optional param)
	 (list start end)))
  )

;; Set repositories
(require 'package)
(setq-default
 load-prefer-newer t
 package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package t))

(setq-default
 use-package-always-ensure t)

;; Use latest Org
(use-package org)

;; Tangle configuration
(setq custom-safe-themes t)
(org-babel-load-file (expand-file-name "kgmacs.org" user-emacs-directory))
(garbage-collect)

;; Dashboard needs to be out here because starting with --load
(use-package dashboard
  :ensure t
  :config
  ;; (setq dashboard-banner-logo-title "")
  ;; (setq dashboard-startup-banner "/path/to/image")
  (setq dashboard-items '((recents  . 25)
                          (bookmarks . 10))))
(dashboard-insert-startupify-lists)
(dashboard-refresh-buffer)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:family "Bitstream Charter")))))
