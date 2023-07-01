(define-module (bash-coding-utils)
  #:use-module (gnu packages admin) ;; netcat
  #:use-module (gnu packages bootstrap)
  #:use-module (yad-full)
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
  #:use-module (gnu packages search) ;; after upgrade to latest master  
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
  (let ((commit "6ad0f98225331298f984e6e7e5907f7d212e94f3")
        (revision "0"))
    (package
      (name "pydaemon")
      (version (git-version "0.1.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (commit commit)
               (url "https://git.sr.ht/~methuselah-0/pydaemon")))
         (file-name (git-file-name name version))
         (sha256
          (base32 "17c5lzirj99l3bzr23f232pd091a6rhb1hghw8jx0sqnyf008clb"))))
      (build-system gnu-build-system)
      (native-inputs (list autoconf automake))
      (inputs (list coreutils netcat python socat util-linux))
      (home-page "https://git.sr.ht/~methuselah-0/pydaemon")
      (synopsis "Use python from bash")
      (description "With pydaemon you can pipe strings of python code to one
or multiple persistent python processes that keeps state, and get the results
back as strings.  Can be used over either of a unix or tcp socket.")
      (license license:cc-by-sa3.0))))

(define-public bash-coding-utils
  (let ((commit "25de0d50799243022ff2fe8b2b3fbb94edd1777b")
        (revision "0"))
    (package
      (name "bash-coding-utils")
      (version (git-version "0.4.0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://git.sr.ht/~methuselah-0/bash-coding-utils")
                      (recursive? #t))) ;; minor size submodule for docs
                ;; rendering - GPL3.
                (file-name (git-file-name name version))
                (sha256
                 (base32 "1b5qn1w5p8940xx00fwf31amc859kkaq4f792sdp25qkxss1srzf"))))
      (build-system gnu-build-system)
      (native-inputs (list autoconf automake findutils))
      (inputs (list bash
                    bash-ctypes
                    (list isc-bind "utils")
                    coreutils
                    diffutils
                    file
                    findutils
                    gawk
                    ugrep
                    guile-3.0
                    guile-bash-for-bash-coding-utils
                    jq
                    libxml2-xpath0
                    lsof
                    nmap
                    perl
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
                    util-linux
                    which
                    yad-full))
      ;; (propagated-inputs `(("bash" ,bash))) ;; the bash shell needs
      ;; to be the same version as guile-bash is compiled against,
      ;; without propagation this package won't work on foreign
      ;; distributions.
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

;;guile-persist
;;guile-stis-parser
;;python-on-guile
;;guile-bash-parallel
;;myphp
;;guile-bash2.2
;;guile-base64
;;orgmk
bash-coding-utils
;;bash-bcu
