;; -*- geiser-scheme-implementation: guile -*-
;; INFO: make sure to add job.guile and mcron & in ~/.profile

(define non-sorted-packages
  (list
   "cowsay"
))

(specifications->manifest
 (append (list "hello")
         non-sorted-packages))
