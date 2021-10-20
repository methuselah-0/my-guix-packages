(define-module (bash-coding-utils)
  #:use-module (gnu packages admin) ;; netcat
  #:use-module (gnu packages aspell)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages cyrus-sasl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages dbm) ;; after upgrade to latest master
  #:use-module (gnu packages dns)
  #:use-module (gnu packages ed)
  #:use-module (gnu packages emacs) ;; for orgmk package
  ;; #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gd)  
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)  
  #:use-module (gnu packages gnupg)  
   #:use-module (gnu packages guile)
   #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages networking) ;; socat, ipcalc
  #:use-module (gnu packages openldap)  
  #:use-module (gnu packages pcre)  
  #:use-module (gnu packages perl)
  #:use-module (gnu packages php)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sqlite) ;; after upgrade to latest master
  #:use-module (gnu packages textutils)  
  #:use-module (gnu packages tls)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages web)  
  #:use-module (gnu packages xml)  
  #:use-module (gnu packages xorg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system guile)
  #:use-module (guix build-system python)
  #:use-module (guix build python-build-system)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)  
  #:use-module (guix utils)
  #:use-module ((srfi srfi-1) #:select (alist-delete)))

;; not needed anymore, since bash-ctypes is in guix master.
;; (define-public ctypes.sh
;;   (let ((commit "9d43f1bc4958ac136786f8c3b82cd3aa50713f49")
;; 	(revision "0.0.0"))
;;     (package
;;      (name "ctypes.sh")
;;      (version (git-version "1.1.1" revision commit))
;;      (source (origin
;; 	      (method git-fetch)
;; 	      (uri (git-reference
;; 		    (commit commit)
;; 		    (url "https://github.com/taviso/ctypes.sh.git")))
;; 	      (sha256
;; 	       (base32 "111n1kg1fzms5hns5s24ika05dm00kbhrdvn17hnx7g4k01hd7n4"))))
;;      (build-system gnu-build-system)
;;      (arguments
;;       '(#:make-flags (list (let*
;; 	 		       ((output (assoc-ref %outputs "out")))
;; 	 		     (string-append "PREFIX=" output)))
;;         #:phases (modify-phases
;; 		  %standard-phases
;; 		  ;;(delete 'configure)
;; 		  ;;(delete 'check)
;; 		  (add-after 'unpack 'autogen
;; 			     (lambda _
;; 			       (let*
;; 				   ((bash (assoc-ref %build-inputs "bash")))
;; 				 (chmod "configure" #o777)
;; 				 (invoke "bash" "autogen.sh"))))
;; 		  (replace 'patch-source-shebangs
;; 			   (lambda _
;; 			     (let*
;; 				 ((bash (assoc-ref %build-inputs "bash")))
;; 			       (for-each make-file-writable (find-files "." ".*"))
;; 			       (substitute* (find-files "." ".*\\.sh")
;; 					    (("#!/bin/bash")
;; 					     (string-append "#!" bash "/bin/bash\n"))))))
;; 		  (replace 'configure
;; 			   (lambda _
;; 			     (let*
;; 				 ((bash (string-append (assoc-ref %build-inputs "bash") "/bin/bash"))
;; 				  (source (assoc-ref %build-inputs "source"))
;; 				  (output (assoc-ref %outputs "out")))
;; 			       (setenv "SHELL" bash)
;; 			       (setenv "CONFIG_SHELL" bash)
;; 			       (invoke "sh" "configure" (string-append "--prefix=" output)))))
;; 		  (replace 'install
;; 		  	   (lambda _
;; 		  	     (let*
;; 				 ((output (assoc-ref %outputs "out"))
;; 				  (bash (string-append (assoc-ref %build-inputs "bash") "/bin/bash"))
;; 	 		          (install-dir (string-append "PREFIX=" output)))
;; 			       (setenv "PREFIX" output)
;; 			       (invoke "make" install-dir "install")))))))
;;      (native-inputs `(("pkg-config" ,pkg-config)
;; 		      ("autoconf" ,autoconf)
;; 		      ("zlib" ,zlib)
;; 		      ("automake" ,automake)
;; 		      ("m4" ,m4)
;; 		      ("bash" ,bash)
;; 		      ("libtool" ,libtool)))
;;      (propagated-inputs `(("libffi" ,libffi)
;; 			  ("bash" ,bash)))
;;      (synopsis "Cthulhu")
;;      (description "ctypes.sh is a bash plugin that provides a foreign function interface directly in your shell. In other words, it allows you to call routines in shared libraries from within bash. ctypes.sh makes it possible to use GTK+ natively in your shell scripts, or write a high-performance http daemon.")
;;      (home-page "https://github.com/taviso/ctypes.sh")
;;      (license "MIT"))))

;; not needed here anymore, as it's in a submodule and has been superseded by bcu__parallel / bashp.
;; (define-public guile-bash-parallel
;;   (let (
;; 	;;(commit "8556ab01664ec56f858481b2445c17f33e3e995f")
;; 	;;(commit "ab2d683")
;;         (commit "6d13c37")
;; 	(revision "3"))
;;     (package
;;       (name "guile-bash-parallel")
;;       (version "v0.0.7")
;;       (home-page "https://gitlab.com/methuselah-0/guile-bash-parallel.git")
;;       (source (origin
;;                 (method git-fetch)
;;                 (uri (git-reference
;;                       (commit commit)
;;                       (url "https://gitlab.com/methuselah-0/guile-bash-parallel.git")))
;;                 (sha256
;;                  (base32
;;                   ;;"0dxfpi73m4l034vqf0xjkhfskyv9ip4kb439gw4829d0499fssad"))))
;; 		  ;;"0afnsb4y3v8vpxa9x0nm0hp7ggyb1lik4lyvf3kw6qa7v27123gh"
;;                   "0wxfsqjy871nk4sgcrpxclr2n7l4c2r54hyd42fjx65gx4di1jnd"
;;                   ))))
;;       ;;		    (url "https://github.com/guildhall/guile-csv.git")))
;;       ;;	      (sha256
;;       ;;	       (base32 "0wl9nkqvsl61jlx5r2yd27irvgg2lx108j0a17zry70gsv223i4n"))))
;;       (build-system gnu-build-system)
;;       (arguments
;;        '(#:phases (modify-phases
;;                       %standard-phases
;;                     (delete 'configure)
;;                     (delete 'make)
;;                     (delete 'build)
;;                     (delete 'check)
;;                     (replace 'install
;;                       (lambda* _
;;                         (let* ((out (assoc-ref %outputs "out"))
;;                                ;;(csvmod (string-append (assoc-ref %build-inputs "source") "/csv/csv.scm"))
;;                                (share (string-append out "/share/guile/site/2.2")))
;;                           (mkdir-p share)
;;                           (copy-file "parallel.scm" (string-append share "/parallel.scm"))
;;                           (copy-file "mapfork.sh" (string-append share "/mapfork.sh"))
;;                           )))
;;                     )))
;;       (inputs `(("guile" ,guile-3.0)
;;                 ("bash" ,bash)))
;;       ;;(propagated-inputs `(("guile" ,guile-2.2)))
;;       (synopsis "Run bash commands in parallel from guile and read back all their output")
;;       (description "guile-bash-parallel is a lightweight way to define and run system commands in parallel. It allows you to read back to your guile-script the stdout, stderr and return code of bash commands as well as giving you an easy way to template the command argument patterns")
;;       (license license:gpl3+))))

;;     (license (list
;;               (license:non-copyleft "file://LICENSE")       ; The PHP license.
;;               (license:non-copyleft "file://Zend/LICENSE")  ; The Zend license.
;;               license:lgpl2.1                               ; ext/mbstring/libmbfl
;;               license:lgpl2.1+                              ; ext/bcmath/libbcmath
;;               license:bsd-2                                 ; ext/fileinfo/libmagic
;;               license:expat))))                              ; ext/date/lib

(define-public orgmk
  (let ((commit "8eb40637e8b2b5452b3d3d8d82b8836f2b60f5ef")
	(revision "1"))
    (package
      (name "orgmk")
      (version "v0.0.2")
      (home-page "https://github.com/fniessen/orgmk")      
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://github.com/fniessen/orgmk.git")))
                (sha256
                 (base32
                  "1pinzxk29k18mma1ay0y00z31xjhhjysaksaf54yb2fdv1fi47d0"))))
      (build-system gnu-build-system)	
      (arguments
       '(
         ;; according to make-file this variable is just added as a path from bin-dir.
         ;;#:make-flags (list (string-append "ORGMK_EL=../site-lisp/orgmk.el"))
         #:phases (modify-phases
                      %standard-phases
                    (delete 'configure)
                    (delete 'check)
                    (delete 'strip)
                    (replace 'build
                     (lambda* _
                        (let* ((out (assoc-ref %outputs "out"))
                               (out-bin (string-append out "/bin"))
                               (bash (string-append (assoc-ref %build-inputs "bash") "/bin/bash"))
                               (cat (string-append (assoc-ref %build-inputs "cu") "/bin/cat"))
                               (src (string-append (assoc-ref %build-inputs "source")))
                               (args (string-append "prependLines(){ { printf '%b' \"$1\"; " cat " \"$2\"; } >\"$2\".new ; mv \"$2\"{.new,} ; } ; prependLines \"(setq geiser-default-implementation 'guile)\n\" " (string-append out "/site-lisp/orgmk.el"))))
                               
                          (copy-recursively src out)
                          (chdir out)
                          (invoke "make")
			  ;; (substitute* (find-files "./bin" "org2.*")
			  ;;              (("\\. orgmk-init")
			  ;;       	". orgmk-init -y"))
                          
                          (invoke bash "-c" args)
                          ;;(invoke "make" "install" (string-append "BIN_DIR=" out-bin)) ;; (string-append "ORGMK_ROOT" out)
                          )))
                    ;;(delete 'validate-runpath)
                    ;; (replace 'install
                    ;;   (lambda* _
                    ;;     (let* ((out (assoc-ref %outputs "out"))
                    ;;            (out-bin (string-append out "/bin"))
                    ;;            ;;(csvmod (string-append (assoc-ref %build-inputs "source") "/csv/csv.scm"))
                    ;;            ;;(share (string-append out "/share/guile/site/2.2/csv")))
                    ;;            (src (string-append (assoc-ref %build-inputs "source")))
                    ;;            )
                    ;;       (copy-recursively src out)
                    ;;       ;;(mkdir-p out-bin)
                    ;;       ;;(setenv "BIN_DIR" out-bin)
                    ;;       ;;(chdir out)
                    ;;       ;;(system* "echo" "ORGMK_EL=../site-lisp/orgmk.el" ">" "bin/orgmk.conf")
                    ;;       ;;(invoke "make" "install" (string-append "BIN_DIR=" out-bin)) ;; (string-append "ORGMK_ROOT" out)
                    ;;       ;;(invoke "make" "install" (string-append "BIN_DIR=")) ;; (string-append "ORGMK_ROOT" out)
                    ;;       ;;(copy-file csvmod (string-append share "/csv.scm"))
                    (delete 'install)
                    ;; )))
                    )))
      (inputs `(("emacs" ,emacs)
                ("cu" ,coreutils)
                ("bash" ,bash)))
      (synopsis "export html and the rest from org-files via cli")
      (description "export html and the rest from org-files via cli")
      (license license:expat))))

(define-public python-on-guile
  (let (;(commit "fc0d7a9d21c841c0f86c3d2640e3989e335efa56")
        (commit "226d331")
        (revision "3"))
    (package
      (name "python-on-guile")
      (version (git-version "0.1.0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://gitlab.com/python-on-guile/python-on-guile.git")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  ;"1mfjyzpqkw9wpp143kdjbh0yr62i1ic38bws0b3hb3a1sx0l2vdk"
                  "16jbkxv65c6ajsy9wdk7ika3c5k6ad5fpx7xamjp773qxws5wayx"
                  ))))
      (build-system gnu-build-system)
      (arguments
       `(#:parallel-build? #f ; not supported
         #:make-flags '("GUILE_AUTO_COMPILE=0")   ;to prevent guild warnings

         #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'chdir
             (lambda _ (chdir "modules") #t))
           (add-after 'install 'wrap
             (lambda* (#:key outputs #:allow-other-keys)
               ;; Wrap the 'python' executable so it can find its
               ;; dependencies.
               (let ((out  (assoc-ref outputs "out")))
                 (wrap-program (string-append out "/bin/python")
                   `("GUILE_LOAD_PATH" ":" prefix
                     (,(getenv "GUILE_LOAD_PATH")))
                   `("GUILE_LOAD_COMPILED_PATH" ":" prefix
                     (,(getenv "GUILE_LOAD_COMPILED_PATH"))))
                 #t))))))
      (inputs
       `(("guile" ,guile-2.2)))
      (propagated-inputs
       `(("guile-persist" ,guile-persist)
         ("guile-readline" ,guile-readline)
         ("guile-stis-parser" ,guile-stis-parser)))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)
         ("libtool" ,libtool)
         ("guile-readline" ,guile2.2-readline)
         ("pkg-config" ,pkg-config)))
      (home-page "https://gitlab.com/python-on-guile/python-on-guile/")
      (synopsis "Python implementation in Guile")
      (description
       "This package allows you to compile a Guile Python file to any target
from @code{tree-il}.")
      (license license:lgpl2.0+))))
(define-public python-on-guile3
  (let ((commit "da7180a94d2add0873002c9b57dd393111d9781f")
        (revision "3"))
    (package
      (name "python-on-guile")
      (version (git-version "0.1.0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://gitlab.com/python-on-guile/python-on-guile.git")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1vwhzcb4k0k5k8spa59g07ylkvk4l4gi9nwhw1z6vwd0sc7iy0k4"))))
      (build-system gnu-build-system)
      (arguments
       `(#:parallel-build? #f ; not supported
         #:make-flags '("GUILE_AUTO_COMPILE=0")   ;to prevent guild warnings

         #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'chdir
             (lambda _ (chdir "modules") #t))
           (add-after 'install 'wrap
             (lambda* (#:key outputs #:allow-other-keys)
               ;; Wrap the 'python' executable so it can find its
               ;; dependencies.
               (let ((out  (assoc-ref outputs "out")))
                 (wrap-program (string-append out "/bin/python")
                   `("GUILE_LOAD_PATH" ":" prefix
                     (,(getenv "GUILE_LOAD_PATH")))
                   `("GUILE_LOAD_COMPILED_PATH" ":" prefix
                     (,(getenv "GUILE_LOAD_COMPILED_PATH"))))
                 #t))))))
      (inputs
       `(("guile" ,guile-3.0)))
      (propagated-inputs
       `(("guile-persist" ,guile-persist)
         ("guile-readline" ,guile-readline)
         ("guile-stis-parser" ,guile-stis-parser)))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)
         ("libtool" ,libtool)
         ("pkg-config" ,pkg-config)))
      (home-page "https://gitlab.com/python-on-guile/python-on-guile/")
      (synopsis "Python implementation in Guile")
      (description
       "This package allows you to compile a Guile Python file to any target
from @code{tree-il}.")
      (license license:lgpl2.0+))))

(define-public guile-persist
  (let (;(commit "b14927b0368af51c024560aee5f55724aee35233")
        (commit "751c8834b401e81b6ea058a05861ebaf0b659f9d")
        (revision "1"))
    (package
      (name "guile-persist")
      (version (git-version "0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://gitlab.com/tampe/guile-persist.git")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  ;"0z5nf377wh8yj6n3sx2ddn4bdx1qrqnw899dlqjhg0q69qzil522"
                  "19f8hqcax4v40858kx2j8fy1cvzc2djj99r0n17dy1xxmwa097qi"
                  ))
                (modules '((guix build utils)))
                (snippet
                 '(begin
                    ;; Install .go files in the right place.
                    (substitute* "Makefile.am"
                      (("/ccache") "/site-ccache"))
                    #t))))
      (build-system gnu-build-system)
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'patch-prefix
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (substitute* "src/Makefile.am"
                 (("/usr/local/lib/guile")
                  (string-append (assoc-ref outputs "out") "/lib/guile"))
                 (("/usr/local/include/guile")
                  (string-append (assoc-ref inputs "guile") "/include/guile"))
                 (("-L/usr/local/lib")
                  (string-append "-L" (assoc-ref inputs "guile") "/lib"))
                 ;; Use canonical directory for go files.
                 (("/ccache") "/site-ccache"))
               #t))
           (add-after 'unpack 'patch-library-reference
             (lambda* (#:key outputs #:allow-other-keys)
               (let ((out (assoc-ref outputs "out")))
                 (substitute* "persist/persistance.scm"
                   (("\"libguile-persist\"")
                    (format #f "\"~a/lib/guile/2.2/extensions/libguile-persist\"" out)))
                 #t))))))
      (inputs
       `(("guile" ,guile-2.2)))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)
         ("libtool" ,libtool)
         ("pkg-config" ,pkg-config)))
      (home-page "https://gitlab.com/tampe/guile-persist")
      (synopsis "Persistence programming framework for Guile")
      (description
       "This is a serialization library for serializing objects like classes
and objects, closures and structs.  This currently does not support
serializing continuations or delimited continuations.")
      (license license:lgpl2.0+))))
(define-public guile-stis-parser
  (let (;(commit "6e85d37ffc333b722f4413a6c648263701eb75bd")
        (commit "8d49401")
        (revision "1"))
    (package
      (name "guile-stis-parser")
      (version (git-version "0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://gitlab.com/tampe/stis-parser")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  ;"0v4hvq7rlpbra1ni73lf8k6sdmjlflr50yi3p1f24g85h77pc7c0"
                  "19ck4861zf2jyzabs3vszlds8g9vq3rrq2wmnvd8mlmnixfjgp6w"
                  ))))
      (build-system gnu-build-system)
      (arguments
       `(#:parallel-build? #f ; not supported
         #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'chdir
             (lambda _ (chdir "modules") #t))
           (add-after 'chdir 'use-canonical-directory-for-go-files
             (lambda _
               (substitute* "Makefile.am"
                 (("/ccache") "/site-ccache"))
               #t))
           (add-after 'chdir 'delete-broken-symlink
             (lambda _
               (delete-file "parser/stis-parser/lang/.#calc.scm")
               #t)))))
      (inputs
       `(("guile" ,guile-2.2)))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)
         ("pkg-config" ,pkg-config)))
      (home-page "https://gitlab.com/tampe/stis-parser")
      (synopsis "Parser combinator framework")
      (description
       "This package provides a functional parser combinator library that
supports backtracking and a small logical framework. The idea is to build up
chunks that are memoized and there is no clear scanner/parser separation,
chunks can be expressions as well as simple tokens.")
      (license license:lgpl2.0+))))

(define-public bash-bcu
  (let ((commit "7046374017733531b823ff9db063e583a3e469ef")
	(revision "2")
        (pyver (version-major+minor (package-version python))))
    (package
      (name "bash-bcu")
      (version "v0.1.5")
      (home-page "https://gitlab.com/methuselah-0/bash-coding-utils.sh")      
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://gitlab.com/methuselah-0/bash-coding-utils.sh.git")
		      (recursive? #t)))
                (sha256
                 (base32
                  "1slyhxy9z3iiz3hy6hiyls0cphgjn967vgy3dvx0fjnn99wi5kpm"
                  ))))
      (inputs `(("bash-full" ,bash)
                ("bindutils" ,isc-bind "utils")
                ("coreutils" ,coreutils)
                ("ctypes.sh" ,bash-ctypes)
                ("curl" ,curl)
                ("ed" ,ed)
                ("expect" ,expect)
                ("gawk" ,gawk)
                ("grep" ,grep)
                ("guile" ,guile-3.0)
                ("guile-bash" ,guile-bash)
                ("guile-daemon" ,guile-daemon)
                ("ipcalc" ,ipcalc)
                ("jq" ,jq)
                ("libxml2-xpath0" ,libxml2-xpath0)
                ("netcat" ,netcat) ;; for pydaemon
                ("nmap" ,nmap)
                ("orgmk" ,orgmk)         
                ("pcre/bin" ,pcre "bin")
                ("perl" ,perl)
                ("php" ,php)
                ("prips" ,prips)
                ("python" ,python)
                ("python-elementpath" ,python-elementpath)
                ("python-lxml" ,python-lxml)
                ("python-netaddr" ,python-netaddr)
                ;;("python-on-guile" ,python-on-guile)
                ("python-yq" ,python-yq)
                ("sed" ,sed)
                ("socat" ,socat)           ;; for pydaemon
                ("util-linux" ,util-linux) ;; flock command
                ;;("inetutils" ,inetutils) ;; ping command, but not the setuid verion
                ))
      (arguments
       `(#:modules ((guix build utils))
         #:builder
         (begin
           (use-modules (guix build utils))
           (let* ((bashfull (assoc-ref %build-inputs "bash-full"))
                  (guile-bash (assoc-ref %build-inputs "guile-bash"))
                  (out (assoc-ref %outputs "out"))
                  (bin (string-append out "/bin"))
                  (libexec (string-append out "/libexec/bcu")))
             ;; Everything but bcu.sh itself is only accessed internally by bcu.
             (mkdir-p libexec)
             (copy-recursively (assoc-ref %build-inputs "source") libexec)
             ;; Create a bcu.sh wrapping script manually.
             (mkdir-p bin)
             (let* ((binfile (string-append bin "/bcu.sh"))
                    (bcu-port (open-file binfile "a"))
                    ;; Some python libraries needs added to PYTHONPATH
                    (pylibsline (string-append (assoc-ref %build-inputs "python-elementpath") "/lib"
                                               ":" (assoc-ref %build-inputs "python-lxml") "/lib"
                                               ":" (assoc-ref %build-inputs "python-netaddr") "/lib"
                                               ":" (assoc-ref %build-inputs "python") "/lib/python" ,pyver))
                    (pathline (string-append bashfull "/bin"
                                             ":" (assoc-ref %build-inputs "bindutils") "/bin"
                                             ":" (assoc-ref %build-inputs "coreutils") "/bin"
                                             ":" (assoc-ref %build-inputs "ctypes.sh") "/bin"
                                             ":" (assoc-ref %build-inputs "curl") "/bin"
                                             ":" (assoc-ref %build-inputs "ed") "/bin"
                                             ":" (assoc-ref %build-inputs "expect") "/bin"
                                             ":" (assoc-ref %build-inputs "gawk") "/bin"
                                             ":" (assoc-ref %build-inputs "grep") "/bin"
                                             ":" (assoc-ref %build-inputs "guile") "/bin"
                                             ":" (assoc-ref %build-inputs "ipcalc") "/bin"
                                             ":" (assoc-ref %build-inputs "jq") "/bin"
                                             ":" (assoc-ref %build-inputs "libxml2-xpath0") "/bin"
                                             ":" (assoc-ref %build-inputs "netcat") "/bin"
                                             ":" (assoc-ref %build-inputs "nmap") "/bin"
                                             ":" (assoc-ref %build-inputs "orgmk") "/bin"
                                             ":" (assoc-ref %build-inputs "pcre/bin") "/bin"
                                             ":" (assoc-ref %build-inputs "perl") "/bin"
                                             ":" (assoc-ref %build-inputs "php") "/bin"
                                             ":" (assoc-ref %build-inputs "prips") "/bin"
                                             ":" (assoc-ref %build-inputs "python") "/bin"
                                             ":" (assoc-ref %build-inputs "python-yq") "/bin"
                                             ":" (assoc-ref %build-inputs "sed") "/bin"
                                             ":" (assoc-ref %build-inputs "socat") "/bin"
                                             ":" (assoc-ref %build-inputs "util-linux") "/bin")))
               (display (string-append "#!" bashfull "/bin/bash\n") bcu-port)
               (display (string-append "[[ \"$_BCU_SH_LOADED\" == YES ]] || { \nexport PATH=\""
                                       pathline "${PATH:-:}${PATH}\"\nexport PYTHONPATH=\""
                                       pylibsline "${PYTHONPATH:-:}${PYTHONPATH}\"\n}\n") bcu-port)
               (display (string-append "source " libexec "/bcu.sh\n") bcu-port)
               (close-port bcu-port)
               (chmod binfile #o555)
               (setenv "PATH" (string-append pathline ":" (getenv "PATH"))))
             (for-each (lambda (file)
                         (substitute* file
	                   (("~/\\.guix-profile/lib/bash/libguile-bash\\.so")
		            (string-append guile-bash "/lib/bash/libguile-bash.so"))))
                       (find-files out ".*\\.sh"))
             (for-each (lambda (file)
                         (patch-shebang file))
                       (find-files out ".*\\.sh"))
             ;; \"$GUIX_PROFILE\"/lib/bash/libguile-bash.so
             ;; (substitute* (find-files "." ".*\\.sh")
	     ;;   (("\"$GUIX_PROFILE\"/lib/bash/libguile-bash\\.so")
	     ;;    (string-append guile-bash "/lib/bash/libguile-bash.so")))

             ;; (lambda _
             ;;   (substitute* (find-files ".")
	     ;;     (;;("/\\.guix-profile/lib/bash/libguile-bash\\.so")
             ;;      ("libguile-bash")
	     ;;      (string-append guile-bash "/lib/bash/libguile-bash.so")))
             ;;   #t)
             ))))
      (build-system trivial-build-system)
      (synopsis "Prototype your program in Bash")
      (description "Bash-bcu contains bash functions and wrappers that can be commonly used when writing a quick implementation of a new program. It helps you work with JSON, XML, parallelization and installs the most commonly used \"helper\" programs used in Bash scripting. Just run @command{. bcu.sh}, type @ccommand{bcu__}, hit @command{TAB} to see available functions and give any of them the @command{ --help} flag to see how to use it, or run @command{bcu__docs} for the full html documentation.")
      (license license:gpl3))))
;;guile-persist
;;guile-stis-parser
;;python-on-guile
;;guile-bash-parallel
;;myphp
;;guile-bash2.2
;;guile-base64
;;orgmk
;;bash-coding-utils.sh
bash-bcu
