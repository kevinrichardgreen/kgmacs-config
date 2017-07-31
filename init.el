;;; init.el --- kgmacs configuration

;;; Code:

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
(use-package org
	     :pin org
	     :ensure org-plus-contrib)

;; Tangle configuration
(org-babel-load-file (expand-file-name "kgmacs.org" user-emacs-directory))
(garbage-collect)

;;; init.el ends here
