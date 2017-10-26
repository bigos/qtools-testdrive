(declaim (optimize (debug 3) (speed 0)))
;;;; qtools-testdrive.lisp

(in-package #:qtools-testdrive)

;;; "qtools-testdrive" goes here. Hacks and glory await!

(named-readtables:in-readtable :qtools)


(defun my-quit ()
  (let ((message-box (q+:make-qmessagebox)))
    (q+:set-window-title message-box "Notepad")
    (q+:set-text message-box "Are you sure you want to quit?")
    (q+:set-standard-buttons message-box (logior (q+:qmessagebox.yes) (q+:qmessagebox.no)))
    (q+:set-default-button message-box (q+:qmessagebox.no))
    (when (equalp (q+:exec message-box) (q+:qmessagebox.yes))
      (q+:qcoreapplication-quit))))

(defun my-open (window)
  (let ((file-name (q+:qfiledialog-get-open-file-name window "Open your first QT file" "" "*.*" ))
        (buffer (make-string 4096))
        (read 0))
    (unless (equalp file-name "")
      (setf *current-file* file-name)
      (with-open-file (in file-name)
        (format t "file name ~S~%" file-name)
        (setf read (read-sequence buffer in))
        (with-slots-bound (window window)
          (q+:set-text text-edit (subseq buffer 0 read)))))))

(defun my-save (Window)
  (let ((file-name *current-file*))
    (with-open-file (fs file-name
                        :direction :output
                        :if-exists :supersede)
      (with-slots-bound (window window)
        (format fs "~A" (q+::to-plain-text text-edit)
               :stream fs)))))

(define-widget window (QMainWindow)
  ())

(define-subwidget (window text-edit) (q+:make-qtextedit))

(define-subwidget (window quit-button) (q+:make-qpushbutton "&Quit!" window))

(define-menu (window File)
  (:item ("Open..." (ctrl o))
         (my-open window))
  (:separator)
  (:item ("Save" (ctrl s))
         (my-save window))
  (:separator)
  (:item ("Quit" (ctrl q))
         (my-quit)))

(define-subwidget (window layout) (q+:make-qvboxlayout window)
  (q+:add-widget layout text-edit)
  (q+:add-widget layout quit-button)
  ;; set layout as central widget of window
  (let ((appwindow (q+:make-qwidget window)))
    (setf (q+:layout appwindow) layout)
    (setf (q+:central-widget window) appwindow)))

(define-slot (window button-pressed) ()
  (declare (connected quit-button (clicked)))
  (my-quit))

(defun main ()
  (with-main-window (window (make-instance 'window))
    (q+:set-window-title window "Notepad")
    (setf *text-widget* nil)))
