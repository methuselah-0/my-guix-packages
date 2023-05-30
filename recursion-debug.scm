;; This code snippet can help you find packages that causes recursion error and hangs the guix pull process of a channel, in particular when it fails on the "building package cache" stage.
;; 1. cd to channel directory
;; 2. replace "guixrus" with full path to your channel, like "/home/user1/src/my-guix-packages"
;; 3. launch guix repl -L $(pwd)
;; 4. copy and paste below code
;; 5. result should tell you which package is causing problem.

(use-modules (gnu packages)
             (guix packages)
             (guix utils)
             (ice-9 format))

(define %my-channel-directory
  "guixrus")

(define (in-my-channel? pkg)
  (string-prefix? (string-append %my-channel-directory "/")
                  (location-file (package-location pkg))))

(call-with-output-file (string-append (getenv "HOME") "/recursion.log")
  (lambda (port)
    (fold-packages
     (lambda (pkg lst)
       (format port "~a@~a inputs"
               (package-name pkg)
               (package-version pkg))
       (package-inputs pkg)
       (format port " native-inputs")
       (package-native-inputs pkg)
       (format port " propagated-inputs")
       (package-propagated-inputs pkg)
       (format port "~%"))
     #f #:select? in-my-channel?)))
