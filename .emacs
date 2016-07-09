;;; Set up SLIME
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/sbcl")

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


;;; Splash Screen. It will always start SLIME by default
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'slime)

;;; Yes-or-No to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;;; column number mode
(setq column-number-mode t)


(load-theme 'leuven t)

;; Set Menlo Fonts  to mimic Sublime Text 3
(set-frame-font "Menlo:pixelsize=14")

;; Change key bindings
(global-set-key "\M-?" 'help-command)
(global-set-key "\C-h" 'delete-backward-char)

(put 'eval-expression 'disabled nil)


;; Add line numbering
(add-hook 'prog-mode-hook 'linum-mode)


;; Use Lisp editing mode in files *.lisp, *.lsp and *.cl
(set-default 'auto-mode-alist (append '(("\\.lisp$" . lisp-mode)
					("\\.lsp$" . lisp-mode)
					("\\.cl$" . lisp-mode))
				      auto-mode-alist))
