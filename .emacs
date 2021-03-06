;;; package --- Summary
;;; Commentary:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;; Code:
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (diff-hl projectile helm fill-column-indicator company markdown-mode org go-mode go-playground gorepl-mode gotest php-mode phpunit web-beautify web-mode robe rubocop ruby-compilation ruby-electric ggtags flycheck magit neotree chess))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Emacs startup setup
(setq inhibit-startup-screen t) ;; Don't show emacs default startup screen
(tool-bar-mode 0) ;; Don't show toolbar
(menu-bar-mode 0) ;; Don't show menubar
(neotree) ;; Keep neotree open on every new emacs instance

;; Editor beauty
(global-linum-mode) ;; Show line number
(global-whitespace-mode) ;; Show whitespace characters
(global-hl-line-mode) ;; Highlight current line
(show-paren-mode) ;; Show matchin brackets
(setq whitespace-line 0) ;; Disable whitespace showing long line with different formatting
(require 'fill-column-indicator) ;; Show right margin line
(add-hook 'after-change-major-mode-hook 'fci-mode)

;; Development enhancements
(global-flycheck-mode) ;; Check errors for language
(projectile-mode) ;; Add project management support
(global-diff-hl-mode) ;; Enable diff hl mode to show git changes in buffer
(diff-hl-flydiff-mode) ;; Enable on the fly change for diff hl
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh) ;; Refresh on magit post refresh hook
(setq projectile-switch-project-action 'neotree-projectile-action) ;; Open project node in neotree if project opens
(global-company-mode) ;; Auto completion
(setq company-dabbrev-downcase nil) ;; Fix for company autocompletion downcase
(require 'helm-config)

;; Make ggtags mode global
(define-globalized-minor-mode my-ggtags-global-mode ggtags-mode
  (lambda () (ggtags-mode 1)))
(my-ggtags-global-mode) ;; Project tags declartion

;; Language specific setup
;; Ruby
(add-hook 'ruby-mode-hook 'robe-mode)

;; Personal enhancements
(add-hook 'after-save-hook 'whitespace-cleanup) ;; Remove extra whitespace after saving files
(global-auto-revert-mode t) ;; Enable auto update of all buffer if file changed on disk
(setq-default indent-tabs-mode nil)

;; Performance Improvement
(setq auto-window-vscroll nil)

;; Extra configurations

;; Enable web-mode for special files
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(provide '.emacs)
;;; .emacs ends here
