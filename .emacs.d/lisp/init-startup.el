(provide 'init-startup)

;;解决编码乱码问题
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; trick for less start time (设置垃圾回收阈值)
(setq gc-cons-threshold most-positive-fixnum) 
(add-hook 'after-init-hook #'(lambda () (setq gc-cons-threshold 800000)))

(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t
;      save-place-mode 1
      desktop-enable t)

(setq initial-scratch-message "
(org-mode)
")

(use-package emacs
  :hook
  (after-init . column-number-mode)
  ;(after-init . auto-save-visited-mode) ;;自动保存
  (after-init . fido-vertical-mode) ;;更好用的内置minibuffer
  (after-init . electric-pair-mode) ;;自动对称括号
  ;(prog-mode . prettify-symbols-mode) ;;字符支持
  ;(prog-mode . global-visual-line-mode) ;;软换行显示
  ;(text-mode . flyspell-mode) ;;语法检查
  ;(org-mode . flyspell-mode)
  (after-init . save-place-mode)
  :config 
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "%s/%s "
  ))
