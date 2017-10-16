;;;; qtools-testdrive.lisp

(in-package #:qtools-testdrive)

;;; "qtools-testdrive" goes here. Hacks and glory await!

(named-readtables:in-readtable :qtools)

(defun main ()
  (let ((widget (#_new QTextEdit)))
    (#_setWindowTitle widget "Hello!")
    (#_show widget)
    (#_exec *qapplication*)))
