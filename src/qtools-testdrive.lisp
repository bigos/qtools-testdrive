;;;; qtools-testdrive.lisp

(in-package #:qtools-testdrive)

;;; "qtools-testdrive" goes here. Hacks and glory await!

(named-readtables:in-readtable :qtools)

(defun my-quit ()
  (let ((message-box (#_new QMessageBox )))
    (format t "quit function ")
    (q+::set-window-title message-box "Notepad")
    (q+::set-text message-box "Are you sure you want to quit?")
    (q+::set-standard-buttons message-box (logior (q+::qmessagebox.yes) (q+::qmessagebox.no)))
    (q+::set-default-button message-box (q+::qmessagebox.no))
    (when (equalp (q+::exec message-box) (q+::qmessagebox.yes))
      (q+::qcoreapplication-quit))))

(define-widget window (QWidget)
  ())

(define-subwidget (window text-edit) (q+:make-qtextedit))

(define-subwidget (window quit-button) (q+:make-qpushbutton "&Quit!" window))

(define-subwidget (window layout) (q+:make-qvboxlayout window)
  (q+:add-widget layout text-edit)
  (q+:add-widget layout quit-button))

(define-slot (window button-pressed) ()
  (declare (connected quit-button (clicked)))
  (my-quit))



(defun main ()
  (with-main-window (window (make-instance 'window))
   (q+:set-window-title window "Notepad")
                     ))
