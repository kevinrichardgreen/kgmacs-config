
;; EXWM initialization
;;  - TODO not working well with ivy yet, need to move away from config-default
(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  (exwm-config-default)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (setq exwm-layout-show-all-buffers t)
  (setq exwm-workspace-show-all-buffers t))
(use-package exwm-edit)
