;;; packages.el --- erlang+ layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Daniel Boroujerdi <dboroujerdi@Daniels-MBP.home>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

(setq erlang+-packages
  '(
    company
    erlang
    flycheck
    edts
    ))

;; additional edts config

(defun erlang+/init-edts ()
  (use-package edts
    :defer t
    :init
    (progn
      (when edts-auto-start-minor-mode
        (add-hook 'after-init-hook (lambda () (require 'edts-mode)))))
    :config
    (spacemacs/declare-prefix-for-mode 'erlang-mode "mn" "navigate")
    (spacemacs/set-leader-keys-for-major-mode 'erlang-mode
      "ni" 'edts-find-source-under-point
      "no" 'edts-find-source-unwind)

    ;; todo: copy rest of key binding over
    (evil-define-key 'normal erlang-mode-map
      (kbd "s-.") 'edts-find-source-under-point
      (kbd "s-,") 'edts-find-source-unwind)
    ))

;; configure

;; original erlang config

(defun erlang+/post-init-company ()
  (add-hook 'erlang-mode-hook 'company-mode))

(defun erlang+/init-erlang ()
  (use-package erlang
    :defer t
    :init
    (progn
      ;; explicitly run prog-mode hooks since erlang mode does is not
      ;; derived from prog-mode major-mode
      (add-hook 'erlang-mode-hook (lambda () (run-hooks 'prog-mode-hook)))
      ;; (setq erlang-root-dir "/usr/lib/erlang/erts-5.10.3")
      ;; (add-to-list 'exec-path "/usr/lib/erlang/erts-5.10.3/bin")
      ;; (setq erlang-man-root-dir "/usr/lib/erlang/erts-5.10.3/man")
      ;; (add-hook 'erlang-mode-hook
      ;;           (lambda ()
      ;;             (setq mode-name "Erlang")
      ;;             ;; when starting an Erlang shell in Emacs, with a custom node name
      ;;             (setq inferior-erlang-machine-options '("-sname" "syl20bnr"))
      ;;             ))
      (setq erlang-compile-extra-opts '(debug_info)))
    :config
    (require 'erlang-start)))

;; configure and erlang.mk layer using popwin

(defun erlang+/post-init-flycheck ()
  (spacemacs/add-flycheck-hook 'erlang-mode-hook))


;;; packages.el ends here
