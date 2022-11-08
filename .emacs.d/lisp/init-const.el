(provide 'init-const)

(defconst *is-mac* (eq system-type 'darwin)
  "if system-type is macos")
(defconst *is-linux* (eq system-type 'gnu/linux)
  "if system-type is linux")
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt))
  "if system-type is windows")

(defconst *my-orgnote-dir* "c:/Users/NicEu/OneDrive/Documents/_00PersonalDocuments/OrgNote/notes")
