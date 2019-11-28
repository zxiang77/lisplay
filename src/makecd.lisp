(defun make-cd (name maker rating ripped)
  (list :title name :maker maker :rating rating :ripped ripped))

(defun add-record (cd)
  (push cd *db*))

(defun print-db()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))

(defun prompt-read(field)
  (format *query-io* "~a: " field)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Maker")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]:")))

(defun save-db (filename)
  (with-open-file (out filename :direction :output :if-exists :supersede)
    (with-standard-io-syntax (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defvar *db* nil)
