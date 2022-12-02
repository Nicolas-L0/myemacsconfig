(provide 'init-package)

(use-package restart-emacs)

;; --启动耗时测量--
;; 使用方法：
;; M-x benchmark-init/show-durations-tree or M-x benchmark-init/show-durations-tabulated
;; in brief M-x b-ta
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

;; 删除空行
(use-package hungry-delete
  :defer t
  :bind (("C-c da" . hungry-delete-backward)
	 ("C-c de" . hungry-delete-forward)))
;;  :hook (after-init . hungry-delete-mode))

(use-package drag-stuff
  :bind (("<M-up>" . drag-stuff-up)
	 ("<M-down>" . drag-stuff-down))
  :hook (after-init . drag-stuff-global-mode))

;; 强化搜索三剑客
;(use-package ivy
;  :defer 1
;  :demand
;  :hook (after-init . ivy-mode)
;  :config
;  (ivy-mode 1)
;  (setq ivy-use-virtual-buffers t
;	ivy-initial-inputs-alist nil
;	ivy-count-format "%d/%d "
;	enable-recursive-minibuffers t
;	ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

;(use-package counsel
;  :after (ivy)
;  :bind (("M-x" . counsel-M-x)
;	 ("C-x C-f" . counsel-find-file)
;	 ("C-c f" . counsel-recentf) ;;以前是 C-c fr
;	 ("C-c g" . counsel-git)
;	 ("C-h f" . counsel-describe-function)
;	 ("C-h v" . counsel-describe-variable)))

;(use-package swiper
;  :after ivy
;  :bind (("C-s" . swiper)
;	 ("C-r" . swiper-isearch-backward))
;  :config (setq swiper-action-recenter t
;		swiper-include-line-number-in-search t))


; 自动补全
(use-package company
  :config
  (setq company-dabbrev-code-everywhere t
	company-dabbrev-code-modes t
	company-dabbrev-code-other-buffers 'all
	company-dabbrev-downcase nil
	company-dabbrev-ignore-case t
	company-dabbrev-other-buffers 'all
	company-require-match nil
	company-minimum-prefix-length 2 ;;最小补全起始长度
	company-show-numbers t
	company-tooltip-limit 20
	company-idle-delay 0
	company-echo-delay 0
	company-tooltip-offset-display 'scrollbar
	company-begin-commands '(self-insert-command))
  (push '(company-semantic :with company-yasnippet) company-backends)
  :hook ((after-init . global-company-mode)))


;; 语法检查 （Emacs自带Flymake，但Flycheck更优）
;(use-package flycheck
;;:hook (after-init . global-flycheck-mode)) ;;全局启用
;  :hook (prog-mode . flycheck-mode))  ;;仅编程模式下启用

;; 功能包
(use-package crux
  :hook (after-init . recentf-mode)
  :bind (("C-a" . crux-move-beginning-of-line)
	 ("C-c ^" . crux-top-join-line)
	 ("C-x ," . crux-find-user-init-file)
	 ("C-S-d" . crux-duplicate-current-line-or-region)
	 ("C-k" . crux-smart-kill-line)
	 ("C-c f" . crux-recentf-find-file)))

(use-package which-key
  :defer nil ;;不延迟启动
;;  :config (which-key-mode)
  :hook (after-init . which-key-mode))

;; show ivy minibuffer in the frame center
;(use-package ivy-posframe
;  :hook (after-init . ivy-posframe-mode)
;  :init
;  (setq ivy-posframe-display-functions-alist
;	     '((swiper . ivy-posframe-display-at-frame-center)
;	       (complete-symbol . ivy-posframe-display-at-point)
;	       (counsel-M-x . ivy-posframe-display-at-frame-center)
;	       (counsel-find-file . ivy-posframe-display-at-frame-center)
;	       (counsel-recentf . ivy-posframe-display-at-frame-center)
;	       (ivy-switch-buffer . ivy-posframe-display-at-frame-center)
;;	       (t . ivy-posframe-display-at-frame-center)
;	       )))

(use-package flymake
  :defer t
  :hook
  (prog-mode . flymake-mode)) ;;错误提示

(use-package hl-line
  :hook (after-init . global-hl-line-mode))

(use-package recentf
  :config
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-items 25))

(use-package whitespace
  :ensure nil
  :hook ((prog-mode markdown-mode conf-mode) . whitespace-mode)
  :config
  (setq whitespace-style '(face trailing)))

(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode))

(use-package org
  :defer t
  :config
  (setq org-catch-invisible-edits 'smart)
  (setq org-fontify-done-headline t)
  (setq org-hide-leading-stars t)
  (setq org-startup-with-inline-images t)
  (setq org-image-actual-width 300)
  (custom-set-faces
   '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "#696969" :strike-through t))))
   '(org-done ((t (:foreground "#2f4f4f" :weight normal :strike-through t))))
   )
  (setq x-underline-at-descent-line t) ;;下划线下移
  )


(use-package org-roam
  ;:defer t
  :after org
  :hook (org-mode . org-indent-mode) ;;auto virtul indention
  :init
  (setq org-roam-directory (file-truename (concat *my-orgnote-dir* "/roam/")))
  (setq org-roam-dailies-directory (file-truename (concat *my-orgnote-dir* "/roam/daily/")))
  (setq org-agenda-files (concat *my-orgnote-dir* "/agendalist.org"))
  (org-roam-db-autosync-mode)
  :config
  (setq org-roam-db-gc-threshold most-positive-fixnum)
  (setq-default line-spacing nil) ;;行间距
;;  (setq org-agenda-time-grid t)
  (setq org-roam-dailies-capture-templates
	'(("." "default" entry
           "* %? "
           :target (file+head "DAILY.org"
                              "#+title: DAILY\n#+filetags: :personal:\n"))

	  ;;;Thanks to @nobiot
	  ;;;https://org-roam.discourse.group/t/org-roam-capture-templates-function-to-move-to-point-in-file/2784/4
	  ("r" "daily review" plain
           "# 今日回顾\n%?"
           :target (file+head+olp "DAILY.org" ""
				  ("Dailies" "%<%Y-%m-%d %a>"))
	   :empty-lines-after 2
	   :unnarrowed t)
	  ("p" "daily preview" plain
           "# %<%Y年%m月%d日 %A (第%W/52周 第%j天)>\n# 来自昨天的私语\n%? \n# 今日计划\n| item | plan time | actual use | done? |\n|------+-----------+------------+-------|\n|      |           |            |       |\n# 今日回顾\n"
           :target (file+head+olp "DAILY.org" ""
				  ("Dailies" "%<%Y-%m-%d %a>"))
;;				   "%(get-tomorrow-date)"))
	   :empty-lines-after 2
	   :unnarrowed t)
	  ("w" "weekly template")
	  ("wr" "weekly review" plain
           "* 本周回顾\n%?"
           :target (file+head+olp "DAILY.org" ""
				  ("Weeks" "%<%Y-W%W>"))
	   :empty-lines-after 2
	   :unnarrowed t)
	  ("wp" "weekly preview" plain
           "*** 来自上周的反思\n%?\n*** 本周目标\n*** 本周计划"
           :target (file+head+olp "DAILY.org" ""
				  ("Weeks" "%<%Y-W%W>"))
	   :empty-lines-after 2
	   :unnarrowed t)
	  ;;;waiting to modify
	  ("m" "monthly template")
	  ("mr" "monthly review" plain
           "# 来自上周的反思\n%?\n# 本周目标\n# 本周计划"
           :target (file+head+olp "DAILY.org" ""
				  ("Months" "%<%Y-M%m>"))
	   :empty-lines-after 2
	   :unnarrowed t)

  	  ;;;waiting to modify
  	  ("mp" "monthly preview" plain
           "# 来自上周的反思\n%?\n# 本周目标\n# 本周计划"
           :target (file+head+olp "DAILY.org" ""
				  ("Weeks" "%<%Y-M%m>"))
	   :empty-lines-after 2
	   :unnarrowed t)
	  ))
  
  (setq	org-roam-capture-templates
	'(("." "default" plain "* %?"
	   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
			      "#+title: ${title}\n")
	   :unnarrowed t)
	  ("i" "idea node" plain ""
;;	   "** ${title} %^{When?}T %^G\n%?"
	   :target (file+head+olp "daily/INBOX.org" ""
				  ("IDEA" "%<%Y-%m-%d %a>" "${title} %T      :idea:"))
	   :empty-lines-after 2)
	  ("s" "slip node" plain ""
	   :target (file+head+olp "daily/INBOX.org" ""
				  ("SLIP" "%<%Y-%m-%d %a>" "${title} %T      :slip:"))
	   :empty-lines-after 2)
  	  ("n" "note node" plain ""
	   :target (file+head+olp "daily/INBOX.org" ""
				  ("NOTE" "%<%Y-%m-%d %a>" "${title} %T      :note:"))
	   :empty-lines-after 2)
	))
  
  (setq org-roam-mode-sections  ;;what to display in the buffer
	'((org-roam-backlinks-section)
          (org-roam-reflinks-section)
	  (org-roam-unlinked-references-section)
              ))
  (add-to-list 'display-buffer-alist  ;;how to display the buffer
               '("\\*org-roam\\*"
		 (display-buffer-in-direction)
		 (direction . right)
		 (window-width . 0.314)
		 (window-height . fit-window-to-buffer)))
  :bind(
	("C-c rf" . org-roam-node-find)
	("C-c ri" . org-roam-node-insert)
	("C-c rb" . org-roam-buffer-toggle)

	("C-c ran" . org-id-get-create)    ;;add -node
	("C-c raa" . org-roam-alias-add)   ;;add -alias
	("C-c rar" . org-roam-ref-add)
	("C-c rat" . org-roam-tag-add)
	("C-c rra" . org-roam-alias-remove)
	("C-c rrr" . org-roam-ref-remove)
	("C-c rrt" . org-roam-tag-remove)
	
	("C-c rgt" . org-roam-dailies-goto-today)
	("C-c rgd" . org-roam-dailies-goto-date)
	;("C-c rgY" . org-roam-dailies-goto-yesterday)
	;("C-c rgT" . org-roam-dailies-goto-tomorrow)
	("C-c rgb" . org-mark-ring-goto)  ;;go back to the last node after click

	("C-c rcc" . org-roam-capture)
	("C-c rct" . org-roam-dailies-capture-today)
	("C-c rcd" . org-roam-dailies-capture-date)
        ;("C-c rcY" . org-roam-dailies-capture-yesterday)
        ;("C-c rcT" . org-roam-dailies-capture-tomorrow)

	;;;("C-c rrf" . org-roam-db-sync)
	)
  )
	      
(use-package org-roam-ui
  :after org-roam
;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t)
  :bind(
	("C-c ru" . org-roam-ui-mode)))

;;Olivetti - Look & Feel for long-form writing
(use-package olivetti
  ;;:config (display-line-numbers-mode 0)
  :hook (org-mode . olivetti-mode)
  :init (setq olivetti-body-width 150)
  )







;;; https://emacs-lsp.github.io/lsp-mode/page/installation/
;;(use-package lsp-mode
;;  :init (setq lsp-keymap-prefix "C-c l")
;;  :hook (C-mode . lsp-deferred)
;;  :commands (lsp lsp-deferred))

;;(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

;;(use-package lsp-ui :commands lsp-ui-mode)(use-package )








;;; init-package.el ends here
