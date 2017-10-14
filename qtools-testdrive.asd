;;;; qtools-testdrive.asd

(in-package :cl-user)

(asdf:defsystem #:qtools-testdrive
  :description "Describe qtools-testdrive here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (:qtcore
               :qtgui)
  :components ((:file "package")
               (:module "src" :components
                        ((:file "qtools-testdrive"))))
  :defsystem-depends-on (:qtools)
  :build-operation "qt-program-op"
  :build-pathname "testdrive"
  :entry-point "qtools-testdrive:main")
