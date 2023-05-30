(define-module (bash-coding-utils)
  #:use-module (gnu packages admin) ;; netcat
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages file)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages lsof)
  #:use-module (gnu packages ncurses)

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

  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix monads)
  #:use-module (guix store)

  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 format)

  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system guile)
  #:use-module (guix build-system python)
  #:use-module (guix build python-build-system)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)  
  #:use-module (guix utils)
  #:use-module ((srfi srfi-1) #:select (alist-delete)))

;;(add-to-load-path (dirname (current-filename))) ;; because bash-coding-utils needs it - guix build bash-coding-utils will otherwise fail because it can't find the guile-bash-for-bash-coding-utils package).

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

(define-public guile-bash-for-bash-coding-utils
  (let ((commit "1eabc563ca5692b3e08d84f1f0e6fd2283284469")
        (revision "0"))
    (package
      (inherit guile2.0-bash)
      (version (string-append "0.1.6-" revision "." (string-take commit 7)))
      (home-page (package-home-page guile2.0-bash))
      (name "guile-bash-for-bash-coding-utils")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url home-page)))
                (sha256
                 (base32
                  "097vny990wp2qpjij6a5a5gwc6fxzg5wk56inhy18iki5v6pif1p"))
                (file-name (string-append name "-" version "-checkout"))
                (patches (list (string-append (dirname (current-filename)) "/guile-bash.patch")))))
      (inputs
       `(("guile" ,guile-3.0-latest)
         ,@(assoc-remove! (package-inputs guile2.0-bash) "guile")))
      (propagated-inputs (list bash))
      (arguments
       `(#:tests? #f
         #:phases (modify-phases %standard-phases
                    (add-after 'install 'install-guile
                      (lambda* (#:key inputs outputs #:allow-other-keys)
                        (copy-recursively
                         (string-append (assoc-ref outputs "out")
                                        (assoc-ref inputs "guile") "/share")
                         (string-append (assoc-ref outputs "out") "/share"))
                      #t)))
         ,@(package-arguments guile2.0-bash))))))

(define org-html-themes/methuselah-0
  ;; XXX Bundles jquery and several other .js ‘libraries’ — problem?
  ;; XXX A form of https://github.com/fniessen/org-html-themes but not
  ;; drop-in compatible (using that would break the BCU docs).
  ;; ‘Ideally’ we'd re-render them but uugh.
  (let ((commit "2889f7b867867dbaf6e059755e1f4e9bc0892332")
        (revision "0"))
    (package
      (name "org-html-themes")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (commit commit)
               (url "https://gitlab.com/methuselah-0/org-html-themes.git")))
         (file-name (git-file-name name version))
         (sha256
          (base32 "11zr7k8jqldaf6wx3yshiya7f8ryv4ms4bibghnxyrd45gknbnx9"))))
      (build-system copy-build-system)
      (home-page "https://github.com/fniessen/org-html-themes") ; XXX
      (synopsis "Export Org mode files to HTML")
      (description
       "The Org-HMTL framework provides cross-browser themes for exporting Org
documents to cross-browser HTML mark-up.")
      (license license:cc-by-sa3.0))))

(define-public pydaemon
  (let ((commit "dae2798a2c1caa56025c6da69c0d464f70d9c79a")
        (revision "0"))
    (package
      (name "pydaemon")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (commit commit)
               (url "https://gitlab.com/methuselah-0/pydaemon.git")))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1cbg48ljyjqw1vxcb0sqhg9cxx0vgs6ggsdg8yvj441s6gakp2sh"))))
      (build-system trivial-build-system)

      (inputs (list coreutils netcat python socat util-linux))
      (arguments
       (list #:modules '((guix build utils))
             #:builder
             #~(begin
                 (use-modules (guix build utils))
                   (with-directory-excursion #$(package-source this-package)
                     (mkdir-p (string-append (assoc-ref %outputs "out") "/bin"))
                     (copy-file "pydaemon.py"
                                (string-append (assoc-ref %outputs "out") "/bin/pydaemon.py"))
                     (copy-file "py-net-daemon.py"
                                (string-append (assoc-ref %outputs "out") "/bin/py-net-daemon.py"))
                     (copy-file "pydaemon.sh"
                                (string-append (assoc-ref %outputs "out") "/bin/pydaemon.sh"))

                     (substitute* (find-files (string-append #$output "/bin") "\\.sh$")
                       (("(flock) " library _)
                        (string-append #$(this-package-input "util-linux") "/bin/" library))
                       (("(socat) " library _)
                        (string-append #$(this-package-input "socat") "/bin/" library))
                       (("(nc) " library _)
                        (string-append #$(this-package-input "netcat") "/bin/" library))
                       (("( )(mkdir|cat|sleep|chown|id|kill|dirname) " all pre command _)
                        (string-append pre #$(this-package-input "coreutils") "/bin/" command " "))
                       (("(\\()(mkdir|cat|sleep|chown|id|kill|dirname) " all pre command _)
                        (string-append pre #$(this-package-input "coreutils") "/bin/" command " "))
                       (("(python3) " library _)
                        (string-append #$(file-append (this-package-input "python")
                                                      "/bin/python"
                                                      (version-major+minor
                                                       (package-version
                                                        (this-package-input
                                                         "python"))))
                                       " ")))))))
      (home-page "https://gitlab.com/methuselah-0/pydaemon")
      (synopsis "Use python from bash")
      (description "With pydaemon you can pipe strings of python code to one
or multiple persistent python processes that keeps state, and get the results
back as strings.  Can be used over either of a unix or tcp socket.")
      (license license:cc-by-sa3.0))))


;; needs to be install with guix build -L /path/to/this/channel or /path/to/this/channel/packages bash-coding-utils
(define-public bash-coding-utils
  (let ((commit "ce9e7a8910d7debe29a07b48aa0770913b1ecdaf")
        (revision "0"))
    (package
      (name "bash-coding-utils")
      (version (git-version "0.3.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri
          (git-reference
           (commit commit)
           (url "https://git.sr.ht/~methuselah-0/bash-coding-utils")
           (recursive? #t))          )
         (sha256
          (base32 "0hgj0fy66bj5kbjs02fvjp5n9a5sz32fk45rc3id2bs0b2k9jrnx"))
         (file-name (git-file-name name version))))
      (build-system trivial-build-system)
      (arguments
       (list #:modules '((guix build utils))
             #:builder
             #~(begin
                 (use-modules (guix build utils)
                              (ice-9 ftw)
                              (ice-9 match)
                              (srfi srfi-26))
                 (let* ((bash #$(this-package-input "bash"))
                        (bin (string-append #$output "/bin"))
                        (bcu.sh (string-append bin "/bcu.sh"))
                        (share (string-append #$output "/share"))
                        (doc (string-append share "/doc/" #$name))
                        ;; Everything but bcu.sh itself is only ever accessed
                        ;; internally by bcu, so put it all in share/.
                        (bcu-root (string-append share "/bcu"))
                        ;; XXX We should honour the without-tests transformation!
                        (tests? (not #$(%current-target-system))))

                   ;; Copy the ‘source’ to the output and replace submodules.
                   (let ((source #$(package-source this-package)))
                     (with-directory-excursion source
                       (mkdir-p (string-append bcu-root "/submodules"))
                       (for-each (lambda (file)
                                   (copy-recursively file
                                                     (string-append bcu-root
                                                                    "/" file)))
                                 (list "bcu.sh"
                                       "dependency_paths.sh"
                                       "bcu-test.sh"
                                       "docs"
                                       "src"))
                       (copy-recursively (assoc-ref %build-inputs "org-html-themes")
                                         (string-append bcu-root
                                                        "/submodules/org-html-themes"))))
                   ;; Patch absolute file name references.
                   (let* ((original-path (getenv "PATH"))
                          (shebang-inputs '(#$@(map (lambda (name)
                                                      (this-package-input name))
                                                    '("guile"
                                                      "python"))))
                          (shebang-path (string-join
                                         (map (cut string-append <> "/bin")
                                              (cons bash shebang-inputs))
                                         ":")))
                     (setenv "PATH" shebang-path)
                     (for-each patch-shebang
                               (find-files #$output "\\.(sh|scm|py)$"))
                     (setenv "PATH" original-path))

                   ;; Add paths to dependencies - defined in
                   ;; dependency_paths.sh, except the libguile-bash.so
                   ;; file.
                   (substitute* (find-files #$output "\\.sh$")
                     (("[^ ]*(/lib/bash/libguile-bash\\.so)" _ library)
                      (string-append
                       #$(this-package-input "guile-bash-for-bash-coding-utils")
                       library)))

                   ;; TODO: condense below substitutions?
                   (substitute* (find-files #$output "dependency_paths\\.sh$")
                     (("export BCUCTYPES=(ctypes.sh)" _ library)
                      (string-append "export BCUCTYPES="
                                     #$(this-package-input "bash-ctypes")
                                     "/bin/" library))
                     (("export BCUDIFF=(diff)" _ library)
                      (string-append "export BCUDIFF="
                                     #$(this-package-input "diffutils")
                                     "/bin/" library))
                     (("export BCUPING=(ping)" _ library)
                      (string-append "export BCUPING=/run/setuid-programs/ping"))
                     (("export BCUPS=(ps)" _ library)
                      (string-append "export BCUPS="
                                     #$(this-package-input "procps")
                                     "/bin/" library))
                     (("export BCUFILE=(file)" _ library)
                      (string-append "export BCUFILE="
                                     #$(this-package-input "findutils")
                                     "/bin/" library))
                     (("export BCUFIND=(find)" _ library)
                      (string-append "export BCUFIND="
                                     #$(this-package-input "findutils")
                                     "/bin/" library))
                     (("export BCUFLOCK=(flock)" _ library)
                      (string-append "export BCUFLOCK="
                                     #$(this-package-input "util-linux")
                                     "/bin/" library))
                     (("export BCUGAWK=(gawk)" _ library)
                      (string-append "export BCUGAWK="
                                     #$(this-package-input "gawk")
                                     "/bin/" library))
                     (("export BCUGREP=(grep)" _ library)
                      (string-append "export BCUGREP="
                                     #$(this-package-input "grep")
                                     "/bin/" library))
                     (("export GUILE_LOAD_PATH=(.*)$")
                      (string-append "export GUILE_LOAD_PATH=\""
                                     (string-join
                                      '(#$@(map (lambda (name)
                                                  (file-append (this-package-input name)
                                                               "/share/guile/site/"
                                                               (version-major+minor
                                                                (package-version
                                                                 (this-package-input
                                                                  "guile")))))
                                                '("guile-bash-for-bash-coding-utils")))
                                      ":")
                                     "${GUILE_LOAD_PATH:+:}${GUILE_LOAD_PATH}\"\n"))
                     (("export BCUJQ=(jq)" _ library)
                      (string-append "export BCUJQ="
                                     #$(this-package-input "jq")
                                     "/bin/" library))
                     (("export BCULSOF=(lsof)" _ library)
                      (string-append "export BCULSOF="
                                     #$(this-package-input "lsof")
                                     "/bin/" library))
                     (("export BCUNMAP=(nmap)" _ library)
                      (string-append "export BCUNMAP="
                                     #$(this-package-input "nmap")
                                     "/bin/" library))
                     (("export BCUPCREGREP=(pcregrep)" _ library)
                      (string-append "export BCUPCREGREP="
                                     (assoc-ref %build-inputs "pcre:bin")
                                     "/bin/" library))
                     (("export BCUPERL=(perl)" _ library)
                      (string-append "export BCUPERL="
                                     #$(this-package-input "perl")
                                     "/bin/" library))
                     (("export BCUPHP=(php)" _ library)
                      (string-append "export BCUPHP="
                                     #$(this-package-input "php")
                                     "/bin/" library))
                     (("export BCUPS=(ps)" _ library)
                      (string-append "export BCUPS="
                                     #$(this-package-input "procps")
                                     "/bin/" library))
                     (("export BCUPYDAEMON=(pydaemon.sh)" _ library)
                      (string-append "export BCUPYDAEMON="
                                     #$(this-package-input "pydaemon")
                                     "/bin/" library))
                     (("export BCUPYTHONVERSION=(.*)$" _)
                      (string-append "export BCUPYTHONVERSION="
                                     #$(version-major+minor
                                        (package-version
                                         (this-package-input
                                          "python")))))
                     (("export BCUPYTHON=python(.*)$" _)
                      (string-append "export BCUPYTHON="
                                     #$(file-append (this-package-input "python")
                                                    "/bin/python"
                                                    (version-major+minor
                                                     (package-version
                                                      (this-package-input
                                                       "python"))))
                                     "\n"))
                     (("export PYTHONPATH=.*" all)
                      (string-append "export PYTHONPATH=\""
                                     (string-join
                                      '(#$@(map (lambda (name)
                                                  (file-append (this-package-input name)
                                                               "/lib/python"
                                                               (version-major+minor
                                                                (package-version
                                                                 (this-package-input
                                                                  "python")))
                                                               "/site-packages"))
                                                '("python"
                                                  "python-elementpath"
                                                  "python-lxml"
                                                  "python-netaddr")))
                                      ":")
                                     "${PYTHONPATH:+:}${PYTHONPATH}\"\n"))
                     (("export BCUSED=(sed)" _ library)
                      (string-append "export BCUSED="
                                     #$(this-package-input "sed")
                                     "/bin/" library))
                     (("export BCUSOCAT=(socat)" _ library)
                      (string-append "export BCUSOCAT="
                                     #$(this-package-input "socat")
                                     "/bin/" library))
                     (("export BCUTREE=(tree)" _ library)
                      (string-append "export BCUTREE="
                                     #$(this-package-input "tree")
                                     "/bin/" library))
                     (("export BCUWHICH=(which)" _ library)
                      (string-append "export BCUWHICH="
                                     #$(this-package-input "which")
                                     "/bin/" library))
                     (("export XDG_DATA_DIRS=(.*)$")
                      (string-append
                       "[[ -e /run/current-system/profile/share ]] && "
                       "export XDG_DATA_DIRS="
                       "/run/current-system/profile/share"
                       "${XDG_DATA_DIRS:+:}${XDG_DATA_DIRS}\n"))
                     (("export BCUXARGS=(xargs)" _ library)
                      (string-append "export BCUXARGS="
                                     #$(this-package-input "findutils")
                                     "/bin/" library))
                     (("export BCUXDGOPEN=(xdg-open)" _ library)
                      (string-append "export BCUXDGOPEN="
                                     #$(this-package-input "xdg-utils")
                                     "/bin/" library))
                     (("export BCUXMLLINT=(xmllint)" _ library)
                      (string-append "export BCUXMLLINT="
                                     #$(this-package-input "libxml2-xpath0")
                                     "/bin/" library)))

                   ;; Symlink to bcu.sh from the output bin directory.
                   (mkdir-p bin)
                   (symlink (string-append bcu-root "/bcu.sh") bcu.sh)
                   (chmod bcu.sh #o555)

                   ;; Disable network and gui tests, and one test for setopts which
                   ;; doesn't work inside the Guix build environment.
                   (with-output-to-file (string-append bcu-root "/disabled_tests.txt")
                     (lambda _
                       (format #t "~{~a~%~}"
                               (list "ip_of_test_1"
                                     "setopts_test_4"
                                     "web_media_server_test_1"
                                     "web_api_server_test_1"
                                     "find_gui_test_1"))))

                   ;; Set up a minimal test environment & run the tests.
                   (when tests?
                     (setenv "PATH" (string-append bin ":"
                                                   bash "/bin:"
                                                   (getenv "PATH")))
                     (setenv "SHELL"
                             (string-append bash "/bin/bash"))
                     (for-each (lambda (test-input)
                                 (setenv "PATH"
                                         (string-append
                                          (assoc-ref %build-inputs test-input)
                                          "/bin:" (getenv "PATH"))))
                               (list "coreutils"))
                     (setenv "HOME" "/tmp")
                     (with-directory-excursion bcu-root
                       (invoke "./bcu-test.sh")
                       ;; No need to keep passed tests in the final output
                       (for-each delete-file
                                 (list "bcu-test.sh"
                                       "disabled_tests.txt"))))))))
      (native-inputs
       `( ;; org-html-themes is bundled upstream as a git submodule,
         ;; but we package it separately and copy it manually above.
         ("org-html-themes" ,(package-source org-html-themes/methuselah-0))
         ("coreutils" ,coreutils) ;; Needed for tests.
         ("pcre:bin" ,pcre "bin")))
      (inputs (list bash
                    bash-ctypes
                    coreutils
                    diffutils
                    file
                    findutils
                    gawk
                    grep
                    guile-3.0
                    guile-bash-for-bash-coding-utils
                    jq
                    libxml2-xpath0
                    lsof
                    nmap
                    perl
                    php
                    procps
                    pydaemon
                    python
                    python-elementpath
                    python-lxml
                    python-netaddr
                    python-yq
                    sed
                    socat
                    tree
                    which
                    xdg-utils
                    util-linux))
      (propagated-inputs
       `(("bash" ,bash))) ;; the bash shell needs to be the same version
      ;;as guile-bash is compiled against
      (home-page "https://git.sr.ht/~methuselah-0/bash-coding-utils")
      (synopsis "Functions and tools for software prototyping in Bash")
      (description
       "Bash-Coding-Utils is a library of Bash functions and wrappers that can
be useful when writing quick implementations of new programs.  It helps you
work with JSON, XML, API's and parallelization, and installs some helper
programs commonly used in Bash scripting.  Just run @command{. bcu.sh}, type
@command{bcu__}, hit @key{TAB} to see available functions and give any of them
the @code{--help} flag to see how to use it, or run @command{bcu__docs} for
the full HTML documentation.")
      (license license:gpl3))))

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
;;bash-coding-utils
;;bash-bcu
