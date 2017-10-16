;;;; qtools-testdrive.lisp

(in-package #:qtools-testdrive)

;;; "qtools-testdrive" goes here. Hacks and glory await!

(named-readtables:in-readtable :qtools)

(define-widget window (QWidget)
  ())

(define-subwidget (window text-edit) (q+:make-qtextedit))

(define-subwidget (window quit-button) (q+:make-qpushbutton "&Quit!" window))

(define-subwidget (window layout) (q+:make-qvboxlayout window)
  (q+:add-widget layout text-edit)
  (q+:add-widget layout quit-button))

(define-slot (window button-pressed) ()
  (declare (connected quit-button (clicked)))
  (format t "quitting")
  (q+:close window))

(defun main ()
  (with-main-window (window (make-instance 'window))))
