;;;; qtools-testdrive.lisp

(in-package #:qtools-testdrive)

;;; "qtools-testdrive" goes here. Hacks and glory await!

(named-readtables:in-readtable :qtools)

(define-widget main (QWidget)
  ())

(define-subwidget (main button) (q+:make-qpushbutton "Click Me!" main))

(define-subwidget (main layout) (q+:make-qhboxlayout main)
  (q+:add-widget layout button))

(defun timestamp (&optional (universal-time (get-universal-time)))
  (multiple-value-bind (s m h dd mm yy day) (decode-universal-time universal-time)
    (format NIL "~[Monday~;Tuesday~;Wednesday~;Thursday~;Friday~;Saturday~;Sunday~] ~% the ~d~[st~;nd~;rd~:;th~] ~% of ~[January~;February~;March~;April~;May~;June~;July~;August~;September~;October~;November~;December~] ~% ~d, ~% ~2,'0d:~2,'0d:~2,'0d"
            day dd (1- (mod dd 10)) (1- mm) yy h m s)))

(define-slot (main button-pressed) ()
  (declare (connected button (released)))
  (q+:qmessagebox-information
   main "Hello World!"
   (format NIL
           "Hello, dear sir/madam.~%You are running ~a v~a on ~a.~%It is now ~a."
           (lisp-implementation-type)
           (lisp-implementation-version)
           (machine-type)
           (timestamp))))

(defun main ()
  (with-main-window (window (make-instance 'main))))
