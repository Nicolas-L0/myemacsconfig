(provide 'init-func)

(defun get-tomorrow-date()
  "get-current-time in %<%Y-%m-%d> format."
    (let* ((now (decode-time))
	   (tomorrow (copy-sequence now)))
      (cl-incf (nth 3 tomorrow))
      (format-time-string "%Y-%m-%d" (apply #'encode-time tomorrow))))
