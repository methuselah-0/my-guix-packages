(define-module (bash-coding-utils)
  #:use-module (gnu packages) ;; because of complaints in /var/log/cuirass/evaluations/1.gz
  ;; #:use-module (gnu packages algebra)
  #:use-module (gnu packages admin) ;; netcat
  #:use-module (gnu packages aspell)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  ;; #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages check)  ;; because of complaints in /var/log/cuirass/evaluations/1.gz
  #:use-module (gnu packages curl)
  #:use-module (gnu packages cyrus-sasl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages dbm) ;; after upgrade to latest master
  ;; #:use-module (gnu packages disk)
  ;; #:use-module (gnu packages ed)
  #:use-module (gnu packages emacs) ;; for orgmk package
  ;; #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gd)  
  #:use-module (gnu packages gettext)
  ;;  #:use-module (gnu packages gl) ;; this gives mesa which depends on llvm which doesnt build atm.
  #:use-module (gnu packages glib)  
  ;; #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)  
  ;; #:use-module (gnu packages gperf)
   #:use-module (gnu packages guile)
   #:use-module (gnu packages guile-xyz)
  ;; #:use-module (gnu packages hurd)
  #:use-module (gnu packages image)
  ;; #:use-module (gnu packages java)  
  #:use-module (gnu packages libffi)
  ;; #:use-module (gnu packages libunistring)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages m4)
  ;; #:use-module (gnu packages man)
  ;; #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  ;; #:use-module (gnu packages ncurses)
  #:use-module (gnu packages networking) ;; socat, ipcalc
  #:use-module (gnu packages openldap)  
  #:use-module (gnu packages pcre)  
  #:use-module (gnu packages perl)
  ;; #:use-module (gnu packages perl-check)
  #:use-module (gnu packages php)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages readline)
  ;; #:use-module (gnu packages sdl)
  ;; #:use-module (gnu packages slang)
  #:use-module (gnu packages sqlite) ;; after upgrade to latest master
  ;; #:use-module (gnu packages texinfo)
  #:use-module (gnu packages textutils)  
  #:use-module (gnu packages tls)
  #:use-module (gnu packages tcl)
  ;; #:use-module (gnu packages version-control)
  #:use-module (gnu packages web)  
  ;; #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)  
  #:use-module (gnu packages xorg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  ;; #:use-module (guix build-system ant)
  ;; #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system guile)
  #:use-module (guix build-system python)
  ;; #:use-module (guix build-system guile)  
  ;; #:use-module (guix build-system perl)
;;  #:use-module (guix build-system python)
  ;;#:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)  
  ;; #:use-module (guix utils)
  ;; #:use-module (ice-9 match)
  #:use-module ((srfi srfi-1) #:select (alist-delete)))

;; (define-public ctypes.sh
;;   (let (;;(commit "9d43f1bc4958ac136786f8c3b82cd3aa50713f49")
;;         (commit "091e64421507c3502b38b1b88d78b12b4269e80e")
;; 	(revision "0.0.1"))
;;     (package
;;      (name "ctypes.sh")
;;      (version (git-version "1.2" revision commit))
;;      (source (origin
;; 	      (method git-fetch)
;; 	      (uri (git-reference
;; 		    (commit commit)
;; 		    (url "https://github.com/taviso/ctypes.sh.git")))
;; 	      (sha256
;; 	       (base32 "1wafyfhwd7nf7xdici0djpwgykizaz7jlarn0r1b4spnpjx1zbx4"))))
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
;;      (license license:expat)))) ;; wrong license

;; (define-public guile3.0-bash
;;   (package
;;     (inherit guile-bash)
;;     (name "guile3.0-bash")
;;     (inputs
;;      `(("guile" ,guile-3.0-latest)
;;        ,@(assoc-remove! (package-inputs guile-bash) "guile")))
;;     (arguments
;;      `(#:tests? #f
;;        #:phases (modify-phases %standard-phases
;;                   (add-after 'install 'install-guile
;;                     (lambda* (#:key inputs outputs #:allow-other-keys)
;;                       (copy-recursively
;;                        (string-append (assoc-ref outputs "out")
;;                                       (assoc-ref inputs "guile") "/share")
;;                        (string-append (assoc-ref outputs "out") "/share"))
;;                       #t)))
;;        ,@(package-arguments guile-bash)))))

;; (define-public guile-bash2.2
;;   (let ((commit "678e06df1e9f786ba87b47b18fa5c041eb0e3e86")
;;         (revision "1"))
;;     (package
;;       (name "guile-bash-2.2")
;;       (version (string-append "0.1.6-" revision "." (string-take commit 7)))
;;       (home-page
;;        "https://gitlab.com/methuselah-0/guile-bash")
;;       (source (origin
;;                 (method git-fetch)
;;                 (uri (git-reference
;;                       (commit commit)
;; 		      (url "https://gitlab.com/methuselah-0/guile-bash.git")))
;;                 (sha256
;;                  (base32
;;                   "1dipzbyy3jlc3d40v5vbf4a9vlw6fyv4b03hfvj94iy3papji5sn"))
;;                 (file-name (string-append name "-" version "-checkout"))))
;;       (build-system gnu-build-system)
;;       (arguments
;;        '(#:configure-flags
;;          ;; Add -I to match 'bash.pc' of Bash 4.4.
;;          (list (string-append "CPPFLAGS=-I"
;;                               (assoc-ref %build-inputs "bash:include")
;;                               "/include/bash/include")

;;                ;; The '.a' file is useless.
;;                "--disable-static"

;;                ;; Install 'lib/bash' as Bash 4.4 expects.
;;                (string-append "--libdir=" (assoc-ref %outputs "out")
;;                               "/lib/bash"))))
;;       (native-inputs `(("pkg-config" ,pkg-config)
;;                        ("autoconf" ,autoconf-wrapper)
;;                        ("automake" ,automake)
;;                        ("libtool" ,libtool)
;;                        ;; Gettext brings 'AC_LIB_LINKFLAGS_FROM_LIBS'.
;;                        ("gettext" ,gettext-minimal)

;;                        ;; Bash with loadable module support, for the test
;;                        ;; suite.
;;                        ("bash-full" ,bash)))
;;       (inputs `(("guile" ,guile-2.2)
;;                 ("bash:include" ,bash "include")))
;;       (synopsis "Extend Bash using Guile")
;;       (description
;;        "Guile-Bash provides a shared library and set of Guile modules,
;; allowing you to extend Bash in Scheme.  Scheme interfaces allow you to access
;; the following aspects of Bash:

;; @itemize
;; @item aliases;
;; @item setting and getting Bash variables;
;; @item creating dynamic variables;
;; @item creating Bash functions with a Scheme implementation;
;; @item reader macro for output capturing;
;; @item reader macro for evaluating raw Bash commands.
;; @end itemize

;; To enable it, run:

;; @example
;; enable -f ~/.guix-profile/lib/bash/libguile-bash.so scm
;; @end example

;; and then run @command{scm \"$(pwd)\"/example.scm}.")
;;       (license license:gpl3+))))

;; (define-public guile-bash2.0
;;     (let ((commit "49099fe6a592aa3b8001e826b939869fe5811785")
;;         (revision "0"))
;;     (package
;;       (name "guile-bash-2.0")
;;       (version (string-append "0.1.6-" revision "." (string-take commit 7)))
;;       (home-page
;;        "https://gitlab.com/methuselah-0/guile-bash")
;;       (source (origin
;;                 (method git-fetch)
;;                 (uri (git-reference
;;                       (commit commit)
;; 		      (url "https://gitlab.com/methuselah-0/guile-bash.git")))
;;                 (sha256
;;                  (base32
;;                   "1cwyf7sd0chrfmfipkvaph5gf70hck6fj36sxcc4ncin49xlxv0l"))
;;                 (file-name (string-append name "-" version "-checkout"))))
;;       (build-system gnu-build-system)
;;       (arguments
;;        '(#:configure-flags
;;          ;; Add -I to match 'bash.pc' of Bash 4.4.
;;          (list (string-append "CPPFLAGS=-I"
;;                               (assoc-ref %build-inputs "bash:include")
;;                               "/include/bash/include")

;;                ;; The '.a' file is useless.
;;                "--disable-static"

;;                ;; Install 'lib/bash' as Bash 4.4 expects.
;;                (string-append "--libdir=" (assoc-ref %outputs "out")
;;                               "/lib/bash"))))
;;       (native-inputs `(("pkg-config" ,pkg-config)
;;                        ("autoconf" ,autoconf-wrapper)
;;                        ("automake" ,automake)
;;                        ("libtool" ,libtool)
;;                        ;; Gettext brings 'AC_LIB_LINKFLAGS_FROM_LIBS'.
;;                        ("gettext" ,gettext-minimal)

;;                        ;; Bash with loadable module support, for the test
;;                        ;; suite.
;;                        ("bash-full" ,bash)))
;;       (inputs `(("guile" ,guile-2.0)
;;                 ("bash:include" ,bash "include")))
;;       (synopsis "Extend Bash using Guile")
;;       (description
;;        "Guile-Bash provides a shared library and set of Guile modules,
;; allowing you to extend Bash in Scheme.  Scheme interfaces allow you to access
;; the following aspects of Bash:

;; @itemize
;; @item aliases;
;; @item setting and getting Bash variables;
;; @item creating dynamic variables;
;; @item creating Bash functions with a Scheme implementation;
;; @item reader macro for output capturing;
;; @item reader macro for evaluating raw Bash commands.
;; @end itemize

;; To enable it, run:

;; @example
;; enable -f ~/.guix-profile/lib/bash/libguile-bash.so scm
;; @end example

;; and then run @command{scm \"$(pwd)\"/example.scm}.")
;;       (license license:gpl3+))))

(define-public guile-bash-parallel
  (let (
	;;(commit "8556ab01664ec56f858481b2445c17f33e3e995f")
	;;(commit "ab2d683")
        (commit "6d13c37")
	(revision "3"))
    (package
      (name "guile-bash-parallel")
      (version "v0.0.7")
      (home-page "https://gitlab.com/methuselah-0/guile-bash-parallel.git")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://gitlab.com/methuselah-0/guile-bash-parallel.git")))
                (sha256
                 (base32
                  ;;"0dxfpi73m4l034vqf0xjkhfskyv9ip4kb439gw4829d0499fssad"))))
		  ;;"0afnsb4y3v8vpxa9x0nm0hp7ggyb1lik4lyvf3kw6qa7v27123gh"
                  "0n0x0nbpjsl8brpy7ajf2qpqlflvhqqryq451vflawaiaacpavml"
                  ))))
      ;;		    (url "https://github.com/guildhall/guile-csv.git")))
      ;;	      (sha256
      ;;	       (base32 "0wl9nkqvsl61jlx5r2yd27irvgg2lx108j0a17zry70gsv223i4n"))))
      (build-system gnu-build-system)
      (arguments
       '(#:phases (modify-phases
                      %standard-phases
                    (delete 'configure)
                    (delete 'make)
                    (delete 'build)
                    (delete 'check)
                    (replace 'install
                      (lambda* _
                        (let* ((out (assoc-ref %outputs "out"))
                               ;;(csvmod (string-append (assoc-ref %build-inputs "source") "/csv/csv.scm"))
                               (share (string-append out "/share/guile/site/3.0")))
                          (mkdir-p share)
                          (copy-file "parallel.scm" (string-append share "/parallel.scm"))
                          (copy-file "mapfork.sh" (string-append share "/mapfork.sh"))
                          )))
                    )))
      (inputs `(("guile" ,guile-3.0)
                ("bash" ,bash)))
      ;;(propagated-inputs `(("guile" ,guile-2.2)))
      (synopsis "Run bash commands in parallel from guile and read back all their output")
      (description "guile-bash-parallel is a lightweight way to define and run system commands in parallel. It allows you to read back to your guile-script the stdout, stderr and return code of bash commands as well as giving you an easy way to template the command argument patterns")
      (license license:gpl3+))))

(define-public guile-csv
  (let ((commit "8a5849537aa74c46ff6db1465a6dde90726e5492")
	(revision "1"))
    (package
      (name "guile-csv")
      (version "v0.0.5")
      (home-page "https://github.com/guildhall/guile-csv.git")      
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://github.com/guildhall/guile-csv.git")))
                (sha256
                 (base32
                  "0gkp4g9lh8a3la8k6d4syivjq1hr846l5zk87fzzfcc1sdiw8n5k"))))
      ;;		    (url "https://github.com/guildhall/guile-csv.git")))
      ;;	      (sha256
      ;;	       (base32 "0wl9nkqvsl61jlx5r2yd27irvgg2lx108j0a17zry70gsv223i4n"))))
      (build-system gnu-build-system)	
      (arguments
       '(#:phases (modify-phases
                      %standard-phases
                    (delete 'configure)
                    (delete 'make)
                    (delete 'check)
                    (replace 'install
                      (lambda* _
                        (let* ((out (assoc-ref %outputs "out"))
                               (csvmod (string-append (assoc-ref %build-inputs "source") "/csv/csv.scm"))
                               (share (string-append out "/share/guile/site/2.2/csv")))
                          (mkdir-p share)
                          (copy-file csvmod (string-append share "/csv.scm"))
                          )))
                    )))
      ;;(inputs `(("guile" ,guile-2.2)))
      ;;(propagated-inputs `(("guile" ,guile-2.2)))
      (synopsis "csv to sxml and the other way around")
      (description "csv functions for guile")
      (license license:expat))))

(define-public guile-base64
  (let ((commit "5ea24cb187739a53c932bf2531886a70b813e7b0")
	(revision "1"))
    (package
      (name "guile-base64")
      (version "v0.0.1")
      (home-page "https://gitlab.com/methuselah-0/guile-base64.git")      
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://gitlab.com/methuselah-0/guile-base64.git")))
                (sha256
                 (base32
                  "06h03ksyr12hsrxrx0gk2rpiwn4q9yxam68yzby45j4hxjq59hp5"))))
      (build-system guile-build-system)	
      (native-inputs `(("guile" ,guile-2.2)))
      ;;(propagated-inputs `(("guile" ,guile-2.2)))      
      (synopsis "Encode and decode strings to and from base64 encoding")
      (description "Encode and decode strings to and from base64 encoding")
      (license license:expat))))    

(define-public bash-coding-utils.sh
  (let (;;(commit "5ead530")
	;;(commit "a4cb5d8a")
	;;(commit "2aed113")
	;;(commit "4cb80cb")
        ;;(commit "6519644")
        ;;(commit "f8d5f27")
        ;;(commit "7046374017733531b823ff9db063e583a3e469ef")
        (commit "1644ff5")
	(revision "0"))
    (package
      (name "bash-coding-utils.sh")
      (version "v0.1.7")
      (home-page "https://gitlab.com/methuselah-0/bash-coding-utils.sh")      
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
                      (url "https://gitlab.com/methuselah-0/bash-coding-utils.sh.git")
		      ;; recursive needed for the guile-bash-parallel submodule
		      (recursive? #t)))
                (sha256
                 (base32
                  ;;"07yq0jsxnic00m3b3p91sq2h5s21wmfqqsbs68wvp4hin620j6a6"))))
		  ;;"00dvvln5ch2dn9mam88k48mkjlqgli29rp9bmag5y0xwra7kpg7f"))))
		  ;;"0nf7dsf8gh270qv1pavbxqs2vi7l5vrmgv7w7rd1i93kmdkcqv47"
                  ;;"126r2mik2cdwx2z7a1cy0fbq9zphqgg2759ay1pimlmybbhl3zrk"
                  ;;"0plhdcwvk41hask2pw0qxh2h7iz5px51857p83qj67al9h68v1nz"
                  ;;"1slyhxy9z3iiz3hy6hiyls0cphgjn967vgy3dvx0fjnn99wi5kpm"
                  "1a1zrr2w1iw3hkk0i54j8fmp1j1zvlhqmw7q6rpxxsh4bhfi6d65"
                  ))))
    (build-system gnu-build-system)
    (arguments
     '(#:phases (modify-phases
                    %standard-phases
                    (delete 'configure)
                    (delete 'check)
                    (delete 'build)
                    (delete 'patch-shebangs)
		    (replace 'install
                             (lambda _
                               (let*
                                   ((bin-dir  (string-append %output "/bin"))
                                    (src-dir  (string-append %output "/bin/src"))
                                    (gbp-dir  (string-append %output "/bin/submodules/guile-bash-parallel"))
                                    (oht-dir  (string-append %output "/bin/submodules/org-html-themes"))
                                    (pyd-dir  (string-append %output "/bin/submodules/pydaemon"))
                                    (sm-dir  (string-append %output "/bin/submodules"))
                                    (bin-file (string-append bin-dir "/bcu.sh"))
                                    (bash-full (assoc-ref %build-inputs "bash-full"))
                                    (guile (assoc-ref %build-inputs "guile"))
                                    )
				 (for-each make-file-writable (find-files "." ".*\\.(sh|scm)"))
				 (substitute* (find-files "." ".*\\.sh")
					      (("#!.*")
					       (string-append "#!" bash-full "/bin/bash\n")))
				 (substitute* (find-files "." ".*\\.scm")
					      (("#!.*")
					       (string-append "#!" guile "/bin/guile \\\n")))
                                 (substitute* (find-files "." ".*\\.py")
					      (("#!.*")
					       (string-append "#!" python "/bin/python \\\n")))
                                                                 
                                 (mkdir-p bin-dir)
                                 (mkdir-p src-dir)
                                 (copy-file "bcu.sh" bin-file)
                                 (copy-recursively "src" src-dir)
				 ;; (chdir (assoc-ref %build-inputs "source"))
				 ;; (invoke "git" "submodule" "update" "--init" "--remote" "guile-bash-parallel")
                                 (mkdir-p oht-dir)
                                 (mkdir-p gbp-dir)
                                 (mkdir-p pyd-dir)
                                 (copy-recursively "submodules/guile-bash-parallel" gbp-dir)
                                 (copy-recursively "submodules/org-html-themes" oht-dir)
                                 (copy-recursively "submodules/pydaemon" pyd-dir)
                                 (chmod bin-file #o700)))))))

      ;; (build-system trivial-build-system)
      ;; (arguments
      ;;  `(#:modules ((guix build utils))
      ;;    #:builder
      ;;    (begin (use-modules (guix build utils))
      ;;           (let* ((outbin (string-append (assoc-ref %outputs "out") "/bin"))
      ;;                  (bcu (string-append (assoc-ref %build-inputs "source") "/bcu.sh"))
      ;;                  (src (string-append (assoc-ref %build-inputs "source") "/src")))
      ;;             (mkdir-p outbin)
      ;;             (copy-file bcu (string-append outbin "/bcu.sh"))
      ;;             (copy-recursively src (string-append outbin "/"))))))
      
                   ;; 'install
                   ;;   (lambda _
                   ;;     (let*
                   ;;         ((bin-dir  (string-append %output "/bin"))
                   ;;          (bin-file (string-append bin-dir "/prips")))
                   ;;       (mkdir-p bin-dir)
                   ;;       (copy-file "prips" bin-file)
                   ;;       (chmod bin-file #o700))))))
      ;;(inputs `(("git" ,git-minimal)))
      (propagated-inputs `(("bash-full" ,bash)
                           ;;("bindutils" ,bind:utils)
                           ("coreutils" ,coreutils)
                           ;;("ctypes.sh" ,ctypes.sh)
                           ("bash-ctypes" ,bash-ctypes)
                           ("curl" ,curl)
                           ("expect" ,expect)
                           ("gawk" ,gawk)
                           ("grep" ,grep)
                           ("guile" ,guile-3.0-latest)
                           ("guile-daemon" ,guile-daemon)
                           ("guile-bash" ,guile-bash)
                           ("guile-base64" ,guile-base64)
                           ("guile-csv" ,guile-csv)
                           ("guile-bash-parallel" ,guile-bash-parallel)
                           ("ipcalc" ,ipcalc)
                           ("jq" ,jq)
                           ("libxml2-xpath0" ,libxml2-xpath0)
                           ;;("myphp" ,myphp)
                           ("php" ,php)
                           ("netcat" ,netcat) ;; for pydaemon
                           ;;("orgmk" ,orgmk) ;; considered an optional dependency
                           ("pcre/bin" ,pcre "bin")
                           ("prips" ,prips)
                           ("python" ,python)
                           ("python-yq" ,python-yq)
                           ("python-lxml" ,python-lxml)
                           ("python-netaddr" ,python-netaddr)
                           ("python-elementpath" ,python-elementpath)
                           ("python-on-guile" ,python-on-guile)
                           ("python-pip" ,python-pip)
                           ("sed" ,sed)
                           ("socat" ,socat) ;; for pydaemon
                           ))
      (synopsis "Prototype your program in Bash ")
      (description "Prototype your program in Bash using great tools for JSON, XML and an FFI for Bash that let's you call C functions.")
      (license license:expat))))

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
                               ;;(csvmod (string-append (assoc-ref %build-inputs "source") "/csv/csv.scm"))
                               ;;(share (string-append out "/share/guile/site/2.2/csv")))
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
      (propagated-inputs `(("guile" ,guile-2.2)))
      (synopsis "csv to sxml and the other way around")
      (description "csv functions for guile")
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
      (name "python-on-guile3")
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
;; (define-public python-yq
;;   (package
;;   (name "python-yq")
;;   (version "2.10.0")
;;   (source
;;     (origin
;;       (method url-fetch)
;;       (uri (pypi-uri "yq" version))
;;       (sha256
;;         (base32
;;           "0ims5q3kfykbyxdfwc3lsrhbcnpgdl56p5rfhpp8vhzi503jrbxb"))))
;;   (build-system python-build-system)
;;   (propagated-inputs
;;     `(("python-argcomplete" ,python-argcomplete)
;;       ("python-pyyaml" ,python-pyyaml)
;;       ("python-setuptools" ,python-setuptools)
;;       ("python-xmltodict" ,python-xmltodict)))
;;   (native-inputs
;;     `(("python-coverage" ,python-coverage)
;;       ("python-flake8" ,python-flake8)
;;       ("python-wheel" ,python-wheel)))
;;   (home-page "https://github.com/kislyuk/yq")
;;   (synopsis
;;     "Command-line YAML/XML processor - jq wrapper for YAML/XML documents")
;;   (description
;;     "Command-line YAML/XML processor - jq wrapper for YAML/XML documents")
;;   (license license:expat))
;;   )

(define-public python-coverage
  (package
   (name "python-coverage")
   (version "5.0.3")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "coverage" version))
     (sha256
      (base32
       "1vrg8panqw79pswg52ygbrff3wdnxarrd9qz6c64ah0c4h2cmbvp"))))
  (build-system python-build-system)
  (arguments
   `(#:tests? #f))                    ; PyPI tarball lacks tests
  (home-page
   "https://github.com/nedbat/coveragepy")
  (synopsis "Code coverage measurement for Python")
  (description
   "Code coverage measurement for Python")
  (license license:asl2.0)))

;;guile-persist
;;guile-stis-parser
;;python-on-guile
;;orgmk
;;bash-coding-utils.sh
;;guile-bash-parallel
;;myphp
;;guile-bash2.2
;;guile-base64
;;ctypes.sh
;; libxml2-xpath0
