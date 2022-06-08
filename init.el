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

;; GC hacking: startup speed and gc-when out of focus
;; - set high gc threshold, runs startup, reset gc threshold to desired runtime value after init
;; - from here: https://github.com/seagle0128/.emacs.d/blob/24d17d3a36841c1c3c27c6ab26e4d3cb975095f3/init.el#L38
;; - Also sets gc to run when emacs goes out of focus! (describe-variable 'focus-out-hook)
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold 800000000)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after init."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold 800000) ; default value is 800kB
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'focus-out-hook 'garbage-collect))))

;; Set repositories
(require 'package)
(setq-default
 load-prefer-newer t
 package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
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
