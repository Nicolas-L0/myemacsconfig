;; UTF-8 as default encoding
(set-language-environment "UTF-8")

(setq org-roam-v2-ack t)

;;==============================================================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(indicate-buffer-boundaries 'left)
 '(org-startup-folded 'content)
 '(package-selected-packages
   '(org-download org org-roam-ui org-roam-server org-roam-bibtex olivetti counsel swiper ivy modus-theme org-roam))
 '(size-indication-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:foreground "#2f4f4f" :weight normal :strike-through t))))
 '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "#696969" :strike-through t))))
 '(org-headline-todo ((t (:inherit modus-themes-variable-pitch :foreground "coral1"))))
 '(org-todo ((t (:foreground "coral")))))

;;==============================================================================================================
;;FONT
;;; If you want to know how to correct specify a font in Windows,
;;; invoke `eval-last-sexp' for (w32-select-font)

 (set-face-attribute 'default nil :family "Ubuntu Mono" :foundry "outline" :slant 'normal :weight 'normal :height 105 :width 'normal)
 (set-face-attribute 'variable-pitch nil :family "Ubuntu Mono" :foundry "outline" :slant 'normal :weight 'normal :height 105 :width 'normal)
 (set-face-attribute 'fixed-pitch nil :family "Ubuntu Mono" :foundry "outline" :slant 'normal :weight 'normal :height 105 :width 'normal)
 (set-fontset-font nil 'symbol (font-spec :family "Segoe UI Symbol" :size 11.0))
 (add-hook 'text-mode-hook 'variable-pitch-mode)

; (set-face-attribute 'variable-pitch nil :font "iA Writer Quattro S-13")
; (set-face-attribute 'fixed-pitch nil :font "iA Writer Mono S-12")
; (set-face-attribute 'default nil :font "iA Writer Mono S-12")
; (set-fontset-font nil 'symbol (font-spec :family "Segoe UI Symbol" :size 11.0))
; (add-hook 'text-mode-hook 'variable-pitch-mode)



;; 单独设置中文字体 Dell2017H
;   (dolist (charset '(kana han cjk-misc bopomofo))
;     (set-fontset-font (frame-parameter nil 'font) charset
;                       (font-spec :family "SimHei" :size 15)))
;; 单独设置中文字体 Sp4					  
(defun set-zn-font-sp4()
	""
	(dolist (charset '(kana han cjk-misc bopomofo))
		(set-fontset-font (frame-parameter nil 'font) charset
						  (font-spec :family "PingFang SC Regular" :size 28)))
)					  
;; 单独设置中文字体 R9000K					  
(defun set-zn-font-r9k()
	""
	(dolist (charset '(kana han cjk-misc bopomofo))
		(set-fontset-font (frame-parameter nil 'font) charset
						  (font-spec :family "PingFang SC Regular" :size 20)))
)					 



(if (string-equal (system-name) "NICOLAS9KK") (set-zn-font-r9k) (set-zn-font-sp4))



;;==============================================================================================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(load-library "org-roam-ui")
(package-initialize)
;; I suggest to keep these comment lines, too
;; below you will see customization automatically added by Emacs



;;==============================================================================================================
;; Let's assign C-z to undo here
(global-set-key (kbd "C-z") 'undo) ;Emacs default is bound to hide Emacs.



;;==============================================================================================================
;; My variable
(defvar my/orgnote-directory "C:/Users/Nicol/OneDrive/Documents/_00PersonalDocuments/OrgNote/notes")



;;==============================================================================================================
;; Adding images
(setq org-startup-with-inline-images t)
(setq org-image-actual-width 300)



;;==============================================================================================================
;; Org, Org-roam, Org-roam-ui, Org-protocol

;;; Tell Emacs where sqlite3.exe is stored
(add-to-list 'exec-path "~/sqlite-tools-win32-x86-3350500")

;;; Tell Emacs to start org-roam-mode when Emacs starts
;(add-hook 'after-init-hook 'org-roam-mode)
(require 'org-roam)

;;; Some important variables
(setq org-roam-directory (file-truename (concat my/orgnote-directory "/roam/")))
(setq org-roam-dailies-directory (file-truename (concat my/orgnote-directory "/roam/daily/")))

(setq  diary-file (concat my/orgnote-directory "/roam/daily/"))
(setq org-refile-targets
   '((org-agenda-files :maxlevel . 1)
     ("C:/Users/Nicol/OneDrive/Documents/_00PersonalDocuments/OrgNote/notes/roam" :maxlevel . 1)))

(org-roam-db-autosync-mode)
;(setq org-roam-db-autosync-mode t)

;; Configuring what is displayed in the roam buffer
(setq org-roam-mode-section-functions
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            #'org-roam-unlinked-references-section
            ))
 
;; Using roam buffer as a side-window
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))
									 
									 
;; Define key bindings for Org-roam
(global-set-key (kbd "C-c rn") #'org-id-get-create)
(global-set-key (kbd "C-c rrf") #'org-roam-db-sync)
(global-set-key (kbd "C-c rf") #'org-roam-node-find)
(global-set-key (kbd "C-c rcc") #'org-roam-capture)
(global-set-key (kbd "C-c rl") #'org-roam-buffer-toggle)
(global-set-key (kbd "C-c ri" ) #'org-roam-node-insert)

(global-set-key (kbd "C-c raa" ) #'org-roam-alias-add)
(global-set-key (kbd "C-c rra" ) #'org-roam-alias-remove)
(global-set-key (kbd "C-c rar" ) #'org-roam-ref-add)
(global-set-key (kbd "C-c rrr" ) #'org-roam-ref-remove)
(global-set-key (kbd "C-c rat" ) #'org-roam-tag-add)
(global-set-key (kbd "C-c rrt" ) #'org-roam-tag-remove)

(global-set-key (kbd "C-c rct") #'org-roam-dailies-capture-today)
(global-set-key (kbd "C-c rcd") #'org-roam-dailies-capture-date)
(global-set-key (kbd "C-c rcY") #'org-roam-dailies-capture-yesterday)
(global-set-key (kbd "C-c rcT") #'org-roam-dailies-capture-tomorrow)
(global-set-key (kbd "C-c rt") #'org-roam-dailies-goto-today)
(global-set-key (kbd "C-c rd" ) #'org-roam-dailies-goto-date)
(global-set-key (kbd "C-c rY") #'org-roam-dailies-goto-yesterday)
(global-set-key (kbd "C-c rT") #'org-roam-dailies-goto-tomorrow)

(global-set-key (kbd "C-c ru" ) #'org-roam-ui-mode)

;;; Template

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %? "
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
;(setq	org-roam-dailies-capture-templates
;			'(
;				("j" "Journals" entry
;				#'org-roam-capture--get-point
;				"* %? %U\n\n "
;				:file-name "daily/%<%Y-%m-%d>"
;				:head "#+title: %<%Y-%m-%d>\n#+roam_tags: daily\n\n"
;				:olp ("Journals")
;				:unnarrowed t)
;				
;				("i" "Ideas" entry
;				#'org-roam-capture--get-point
;				"* %? %U\n\n "
;				:file-name "daily/%<%Y-%m-%d>"
;				:head "#+title: %<%Y-%m-%d>\n#+roam_tags: daily\n\n" 
;				:olp ("Ideas")
;				:unnarrowed t)
;				
;				("t" "Todos" entry
;				#'org-roam-capture--get-point
;				"* TODO %? %U\n\tSCHEDULED: %T DEADLINE: %t"
;				:file-name "daily/%<%Y-%m-%d>"
;				:head "#+title: %<%Y-%m-%d>\n#+roam_tags: daily\n\n" 
;				:olp ("Todos")
;				:unnarrowed t)
;			)
;)
(setq	org-roam-capture-templates
			'(
;				("d" "default" 
;				plain (function org-roam-capture--get-point)
;				"* %?"
;				:file-name "%<%Y%m%d%H%M%S>-${slug}" ;;slug：大转小写、去特殊字符等操作得到字符
;				:head "#+title: ${title}\n#+roam_alias:\n#+roam_tags:\n"
;				:unnarrowed t)
				("d" "default" plain "* %?"
					:target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
										"#+title: ${title}\n")
					:unnarrowed t
				)
				("i" "inbox node" entry 
				"* ${title}%? %^{When?}U"
					:target (file "INBOX.org" )
										
;					:unnarrowed t
				)
			)
)
;
;
;;org protocol
(require 'org-protocol)
(require 'org-roam-protocol)


;; Start org-roam-server
;(defun launch-org-roam-server()
;	"This function execute server-start and org-roam-server-mode, and then launch edge.exe to open http://127.0.0.1:8080/"
;	(progn (server-start) (org-roam-server-mode)(insert " [[http://127.0.0.1:8080/][launch web]]")))
;	;(w32-shell-execute "open" "c:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" "http://127.0.0.1:8080/"))
;
;
;
;;;==============================================================================================================
;; org-roam-ui

(setq org-roam-ui-sync-theme t
      org-roam-ui-follow t
      org-roam-ui-update-on-save t
      org-roam-ui-open-on-start t)



;;;==============================================================================================================
;; org-download
(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

(setq-default org-download-image-dir (concat my/orgnote-directory "/roam/assets/images"))
(global-set-key (kbd "C-c vc") #'org-download-clipboard)
(global-set-key (kbd "C-c vl") #'org-download-yank)
;;;==============================================================================================================
;;; org-protocol, org-roam-graph, & org-roam-server
;
;(setq org-roam-graph-executable "C:/Program Files/Graphviz/bin/dot.exe")
;(setq org-roam-graph-viewer "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
;
;(require 'org-protocol)
;(require 'org-roam-protocol)
;
;(require 'org-roam-server)
;(setq org-roam-server-host "127.0.0.1"
;       org-roam-server-port 8080
;       org-roam-server-export-inline-images t
;       org-roam-server-authenticate nil
;       org-roam-server-network-poll t
;       org-roam-server-network-arrows nil
;       org-roam-server-network-label-truncate t
;       org-roam-server-network-label-truncate-length 60
;       org-roam-server-network-label-wrap-length 20)

;;==============================================================================================================
;; Ivy,Counsel, & Swiper
;; Enable Ivy mode in general

(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; Add Counsel and Swiper search functions
(global-set-key (kbd "C-c f r") #'counsel-recentf)
(global-set-key (kbd "C-c C-f") #'swiper)

;; Replace default "M-x" and "C-x C-f" with Counsel version
(global-set-key (kbd "M-x") #'counsel-M-x)
(global-set-key (kbd "C-x C-f") #'counsel-find-file)

;; Optionally, you can replace these default functions with Counsel version, too
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)



;;==============================================================================================================
;; Olivetti
;; Look & Feel for long-form writing

;; Set the body text width
(setq olivetti-body-width 120)

;; Enable Olivetti for text-related mode such as Org Mode
(add-hook 'text-mode-hook 'olivetti-mode)



;;==============================================================================================================
;; iSearch
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "%s/%s ")



;;==============================================================================================================
;; Optional additional aesthetic changes
;; Adapted from `sanity.el' in Elegant Emacs by Nicolas P. Rougier (rougier)
;; https://github.com/rougier/elegant-emacs

; About interface
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "Let's start org-roam-server by:\n(launch-org-roam-server)\n\n")
(setq initial-major-mode 'org-mode)
(setq-default indent-tabs-mode nil)
(setq pop-up-windows nil)
(tool-bar-mode 0) 
;(tooltip-mode 0)
;(tab-bar-mode 1)
(scroll-bar-mode 0)
(menu-bar-mode 1) ;menu bar is explicitly turned on for beginners. Change the value to 0.

(add-hook 'after-init-hook 'line-number-mode)
(add-hook 'after-init-hook 'global-hl-line-mode)
(add-hook 'after-init-hook 'save-place-mode)
(add-hook 'after-init-hook 'delete-selection-mode)

(setq org-catch-invisible-edits 'smart)
(setq org-fontify-done-headline t)
(setq org-hide-leading-stars t)

; Show paren
(add-hook 'after-init-hook 'show-paren-mode)
(setq	show-paren-when-point-inside-paren t
		show-paren-when-point-in-periphery t
		show-paren-delay 0.2)

;; Optional aditional aesthetic changes
;; Adapted from `elegance.el' in Elegant Emacs by Nicolas P. Rougier (rougier)
;; https://github.com/rougier/elegant-emacs

;; Line cursor and no blink
(set-default 'cursor-type t)
(blink-cursor-mode 1)

;; Line spacing, can be 0 for code and 1 or 2 for text
(setq-default line-spacing 1)

;; Underline line at descent position, not baseline position
(setq x-underline-at-descent-line t)

;; Show time on mode line  https://blog.csdn.net/liuhengloveyou/article/details/6569488
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)
(setq display-time-interval 60)

;; 高亮显示要拷贝的区域
(transient-mark-mode t)

;;==============================================================================================================
;; Set theme

;; (Optional) Setting `custom-safe-themes' to t.
;; This prevents Emacs from asking if it is safe to load the theme.
(setq custom-safe-themes t)

;; Automatically load the theme you like
;; I am using modus-operandi (light theme) here
;; There is also modus-vivendi (dark theme)
(load-theme 'modus-vivendi)



