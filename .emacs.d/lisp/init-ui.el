(provide 'init-ui)

(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful) ;;先加载主题，而后加载smartmodeline（跟随主题有变化）
  (sml/setup))

(use-package emacs
  :if (display-graphic-p) ;;在图形界面时生效
  :config
  (if *is-windows* ;;设置windows字体
      ;;if的ture部分，打包一系列代码
      (progn
	(set-face-attribute 'default nil :font "Ubuntu Mono")
;;	(set-face-attribute 'default nil :font "Ubuntu") ;;非等宽不适合代码和表格环境，适合日常，但以后再考虑
	(dolist (charset '(kana han symbol cjk-misc bopomofo))
	  (set-fontset-font (frame-parameter nil 'font)
			    charset (font-spec :family "WenQuanYi Micro Hei")))) ;;文泉驿微米黑 + UbuntuMono 好棒！目前完美配置！貌似是ubuntu的默认套装
;;			    charset (font-spec :family "WenQuanYi Micro Hei Mono")))) ;;文泉驿微米黑Mono在中文字体上无区别
;;			    charset (font-spec :family "PingFang SC Regular" :size 20)))) ;;老方法会导致字体无法跟随缩放
    ;; if的else部分
    (set-face-attribute 'default nil :font "Source Code Pro for Powerline 11")))


(use-package emacs
  :config
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  )

;;line number
(use-package emacs
  ;;:unless *is-windows* ;;windows开启行号后屏幕滚动时闪烁应用此项
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative)
  ;;(global-display-line-numbers-mode t)
  )
