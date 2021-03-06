
(configuration-layer/declare-layers '(osx
                                      better-defaults
                                      ibuffer

                                      org
                                      osx

                                      html
                                      (shell :variables
                                             shell-default-position 'bottom
                                             shell-default-shell 'eshell
                                             shell-enable-smart-eshell t)
                                      (clojure :variables
                                               clojure-enable-fancify-symbols t)
                                      clojure
                                      emacs-lisp
                                      markdown
                                      org

                                      auto-completion
                                      syntax-checking
                                      version-control
                                      (git :variables
                                           git-gutter-use-fringe t)
                                      github))


(spacemacs|use-package-add-hook smartparens
  :post-config (sp-use-paredit-bindings))

(spacemacs|use-package-add-hook cider
  :post-init (setq cider-refresh-before-fn "user/stop"
                   cider-refresh-after-fn "user/go"))

(spacemacs|use-package-add-hook magit
  :post-init (setq magit-repo-directories "~/workspace"
                   magit-repository-directories-depth 2))

;; TODO: projectile-known-projects
;;       add all dirs in ~/workspace

;; TODO: possibly add cider-reset fn and keybindings

(mac-auto-operator-composition-mode)

(setq dotspacemacs-whitespace-cleanup 'changed)

;; (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
;; (add-hook 'clojure-mode-hook #'aggressive-indent-mode)

(setq tab-always-indent 'complete)

(defun magit-denv-section ()
  (let (denv-clean (eval (= 0 (call-process "denv" nil "*Messages*" nil "check"))))
    (progn
      (insert "Env:      ")
      (if denv-clean
          (insert (propertize "clean" 'font-lock-face '(:foreground "green")))
        (insert (propertize "dirty" 'font-lock-face '(:foreground "red"))))
      (newline))))

(with-eval-after-load 'magit
  (progn
    (remove-hook 'magit-status-headers-hook
                 'magit-denv-section)
    (magit-add-section-hook 'magit-status-headers-hook
                            'magit-denv-section
                            nil
                            'magit-list-branches
                            )))
