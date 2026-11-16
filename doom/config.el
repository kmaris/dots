;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kevin Maris"
      user-mail-address "kevin@example.com")

;; Disable "Really Quit Emacs?" prompt
(setq confirm-kill-emacs nil)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 16)
      doom-symbol-font (font-spec :family "Fira Mono" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; SEE BELOW theme set by auto-dark package
;;(setq doom-theme 'catppuccin-theme)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")
;; https://www.orgroam.com/manual.html#Setting-up-Org_002droam-1
;;(use-package org-roam
;;:ensure t
;;:custom
;;(org-roam-directory "~/org")
;;:config
;;(org-roam-setup))
;;(setq find-file-visit-truename t)
;;(org-roam-db-autosync-mode)
(setq org-agenda-files '("~/org" "~/org/daily"))
(after! org-roam
  (setq org-roam-directory "~/org"))

;; Read external changes before building or rebuilding an agenda.
(after! org-agenda
  (setq org-agenda-sticky nil)

  (defun my/org-agenda-refresh-files-h ()
    "Refresh agenda source buffers without discarding unsaved edits."
    (dolist (file (org-agenda-files nil 'ifmode))
      (when-let* ((buffer (org-find-base-buffer-visiting file)))
        (with-current-buffer buffer
          (when (and (not (buffer-modified-p))
                     (file-readable-p file)
                     (not (verify-visited-file-modtime buffer)))
            (revert-buffer t t t))))))

  (add-hook 'org-agenda-mode-hook #'my/org-agenda-refresh-files-h))

(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; My personal preferences
(setq global-ede-mode 't)     ;; Enable emacs development environment mode
(setq minimap-mode 1)         ;; Right-side minimap, like vscode
(setq company-idle-delay nil) ;; Use C - SPC (ctrl space) for completion
(setq treemacs 1)             ;; Left-side file tree, all the cool kids
(map! :n ";" #'evil-ex)
(map! :after evil
      :map override
      :nvm "C-h" #'evil-window-left
      :nvm "C-j" #'evil-window-down
      :nvm "C-k" #'evil-window-up
      :nvm "C-l" #'evil-window-right)

;; Refresh open files when they change on disk.
(after! autorevert
  (setq auto-revert-use-notify t
        auto-revert-avoid-polling nil
        auto-revert-interval 5
        auto-revert-stop-on-user-input t
        auto-revert-verbose nil)
  (global-auto-revert-mode 1))

(use-package! auto-dark
  :commands (auto-dark-mode)
  :init
  ;; Let the hooks below load the theme.
  ;; First list is dark mode; second list is light mode.
  (setq auto-dark-themes '(() ()))

  (defun my-catppuccin-dark-h ()
    (setq catppuccin-flavor 'frappe)
    (load-theme 'catppuccin t))

  (defun my-catppuccin-light-h ()
    (setq catppuccin-flavor 'latte)
    (load-theme 'catppuccin t))

  (add-hook 'auto-dark-dark-mode-hook #'my-catppuccin-dark-h)
  (add-hook 'auto-dark-light-mode-hook #'my-catppuccin-light-h)

  ;; Preserve delayed startup for daemon sessions.
  (defun my-auto-dark-init-h ()
    (auto-dark-mode 1)
    (remove-hook 'server-after-make-frame-hook #'my-auto-dark-init-h)
    (remove-hook 'after-init-hook #'my-auto-dark-init-h))

  (add-hook (if (daemonp)
                'server-after-make-frame-hook
              'after-init-hook)
            #'my-auto-dark-init-h
            -95))

;; Optional workstation-specific overrides
(load (expand-file-name "local.el" doom-user-dir) t t)
