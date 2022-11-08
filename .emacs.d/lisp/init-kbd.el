(provide 'init-kbd)
;;存放键盘快捷键

;;用y-n替代完整yes-no
(use-package emacs
  :config (defalias 'yes-or-no-p 'y-or-n-p)
  :bind (("C-z" . undo)
;;	 ("C-S-b . recentf-open-most-recent-file"))
  ))

