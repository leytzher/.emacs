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

;; Browse CLHS locally:h
;; Search is done using C-c C-d h
(load "/Users/leytzher/quicklisp/clhs-use-local.el" t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;; Setup ERC client (chat)

(require 'erc)

;; joining && autojoing

;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
  '((".*\\.freenode.net" "#emacs" "#lisp" "#lisp-es" "#clnoobs" "#lispcafe" "#lispweb" "#lisp-lab")
    ))

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?

    (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "foo" :full-name "bar"))))
      

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch) ;; ERC


;;; Configure stock ticker
(stock-ticker-global-mode +1)
(setq stock-ticker-symbols '("aapl" "goog" "fb"))
(add-to-list 'stock-ticker-symbols "^GSPC")
(add-to-list 'stock-ticker-symbols "CLX16.NYM")
(add-to-list 'stock-ticker-symbols "^DJI")
(setq stock-ticker-update-interval 600)
(setq stock-ticker-display-interval 1)
