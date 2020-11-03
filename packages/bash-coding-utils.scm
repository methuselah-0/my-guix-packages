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

(define-public ctypes.sh
  (let (;;(commit "9d43f1bc4958ac136786f8c3b82cd3aa50713f49")
        (commit "091e64421507c3502b38b1b88d78b12b4269e80e")
	(revision "0.0.1"))
    (package
     (name "ctypes.sh")
     (version (git-version "1.2" revision commit))
     (source (origin
	      (method git-fetch)
	      (uri (git-reference
		    (commit commit)
		    (url "https://github.com/taviso/ctypes.sh.git")))
	      (sha256
	       (base32 "1wafyfhwd7nf7xdici0djpwgykizaz7jlarn0r1b4spnpjx1zbx4"))))
     (build-system gnu-build-system)
     (arguments
      '(#:make-flags (list (let*
	 		       ((output (assoc-ref %outputs "out")))
	 		     (string-append "PREFIX=" output)))
        #:phases (modify-phases
		  %standard-phases
		  ;;(delete 'configure)
		  ;;(delete 'check)
		  (add-after 'unpack 'autogen
			     (lambda _
			       (let*
				   ((bash (assoc-ref %build-inputs "bash")))
				 (chmod "configure" #o777)
				 (invoke "bash" "autogen.sh"))))
		  (replace 'patch-source-shebangs
			   (lambda _
			     (let*
				 ((bash (assoc-ref %build-inputs "bash")))
			       (for-each make-file-writable (find-files "." ".*"))
			       (substitute* (find-files "." ".*\\.sh")
					    (("#!/bin/bash")
					     (string-append "#!" bash "/bin/bash\n"))))))
		  (replace 'configure
			   (lambda _
			     (let*
				 ((bash (string-append (assoc-ref %build-inputs "bash") "/bin/bash"))
				  (source (assoc-ref %build-inputs "source"))
				  (output (assoc-ref %outputs "out")))
			       (setenv "SHELL" bash)
			       (setenv "CONFIG_SHELL" bash)
			       (invoke "sh" "configure" (string-append "--prefix=" output)))))
		  (replace 'install
		  	   (lambda _
		  	     (let*
				 ((output (assoc-ref %outputs "out"))
				  (bash (string-append (assoc-ref %build-inputs "bash") "/bin/bash"))
	 		          (install-dir (string-append "PREFIX=" output)))
			       (setenv "PREFIX" output)
			       (invoke "make" install-dir "install")))))))
     (native-inputs `(("pkg-config" ,pkg-config)
		      ("autoconf" ,autoconf)
		      ("zlib" ,zlib)
		      ("automake" ,automake)
		      ("m4" ,m4)
		      ("bash" ,bash)
		      ("libtool" ,libtool)))
     (propagated-inputs `(("libffi" ,libffi)
			  ("bash" ,bash)))
     (synopsis "Cthulhu")
     (description "ctypes.sh is a bash plugin that provides a foreign function interface directly in your shell. In other words, it allows you to call routines in shared libraries from within bash. ctypes.sh makes it possible to use GTK+ natively in your shell scripts, or write a high-performance http daemon.")
     (home-page "https://github.com/taviso/ctypes.sh")
     (license license:expat)))) ;; wrong license

(define-public guile-bash2.2
  (let ((commit "678e06df1e9f786ba87b47b18fa5c041eb0e3e86")
	;;(commit "23a8cc4")
        (revision "1"))
    (package
      (name "guile-bash-2.2")
      (version (string-append "0.1.6-" revision "." (string-take commit 7)))
      (home-page
       "https://gitlab.com/methuselah-0/guile-bash")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
		      ;;                      (url "git://localhost/guile-bash")))
		      (url "https://gitlab.com/methuselah-0/guile-bash.git")))
                (sha256
                 (base32
                  "1dipzbyy3jlc3d40v5vbf4a9vlw6fyv4b03hfvj94iy3papji5sn"))
                (file-name (string-append name "-" version "-checkout"))))
      (build-system gnu-build-system)
      (arguments
       '(#:configure-flags
         ;; Add -I to match 'bash.pc' of Bash 4.4.
         (list (string-append "CPPFLAGS=-I"
                              (assoc-ref %build-inputs "bash:include")
                              "/include/bash/include")

               ;; The '.a' file is useless.
               "--disable-static"

               ;; Install 'lib/bash' as Bash 4.4 expects.
               (string-append "--libdir=" (assoc-ref %outputs "out")
                              "/lib/bash"))))
      (native-inputs `(("pkg-config" ,pkg-config)
                       ("autoconf" ,autoconf-wrapper)
                       ("automake" ,automake)
                       ("libtool" ,libtool)
                       ;; Gettext brings 'AC_LIB_LINKFLAGS_FROM_LIBS'.
                       ("gettext" ,gettext-minimal)

                       ;; Bash with loadable module support, for the test
                       ;; suite.
                       ("bash-full" ,bash)))
      (inputs `(("guile" ,guile-2.2)
                ("bash:include" ,bash "include")))
      (synopsis "Extend Bash using Guile")
      (description
       "Guile-Bash provides a shared library and set of Guile modules,
allowing you to extend Bash in Scheme.  Scheme interfaces allow you to access
the following aspects of Bash:

@itemize
@item aliases;
@item setting and getting Bash variables;
@item creating dynamic variables;
@item creating Bash functions with a Scheme implementation;
@item reader macro for output capturing;
@item reader macro for evaluating raw Bash commands.
@end itemize

To enable it, run:

@example
enable -f ~/.guix-profile/lib/bash/libguile-bash.so scm
@end example

and then run @command{scm \"$(pwd)\"/example.scm}.")
      (license license:gpl3+))))

(define-public guile-bash2.0
    (let ((commit "49099fe6a592aa3b8001e826b939869fe5811785")
        (revision "0"))
    (package
      (name "guile-bash-2.0")
      (version (string-append "0.1.6-" revision "." (string-take commit 7)))
      (home-page
       "https://gitlab.com/methuselah-0/guile-bash")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (commit commit)
		      (url "https://gitlab.com/methuselah-0/guile-bash.git")))
                (sha256
                 (base32
                  "1cwyf7sd0chrfmfipkvaph5gf70hck6fj36sxcc4ncin49xlxv0l"))
                (file-name (string-append name "-" version "-checkout"))))
      (build-system gnu-build-system)
      (arguments
       '(#:configure-flags
         ;; Add -I to match 'bash.pc' of Bash 4.4.
         (list (string-append "CPPFLAGS=-I"
                              (assoc-ref %build-inputs "bash:include")
                              "/include/bash/include")

               ;; The '.a' file is useless.
               "--disable-static"

               ;; Install 'lib/bash' as Bash 4.4 expects.
               (string-append "--libdir=" (assoc-ref %outputs "out")
                              "/lib/bash"))))
      (native-inputs `(("pkg-config" ,pkg-config)
                       ("autoconf" ,autoconf-wrapper)
                       ("automake" ,automake)
                       ("libtool" ,libtool)
                       ;; Gettext brings 'AC_LIB_LINKFLAGS_FROM_LIBS'.
                       ("gettext" ,gettext-minimal)

                       ;; Bash with loadable module support, for the test
                       ;; suite.
                       ("bash-full" ,bash)))
      (inputs `(("guile" ,guile-2.0)
                ("bash:include" ,bash "include")))
      (synopsis "Extend Bash using Guile")
      (description
       "Guile-Bash provides a shared library and set of Guile modules,
allowing you to extend Bash in Scheme.  Scheme interfaces allow you to access
the following aspects of Bash:

@itemize
@item aliases;
@item setting and getting Bash variables;
@item creating dynamic variables;
@item creating Bash functions with a Scheme implementation;
@item reader macro for output capturing;
@item reader macro for evaluating raw Bash commands.
@end itemize

To enable it, run:

@example
enable -f ~/.guix-profile/lib/bash/libguile-bash.so scm
@end example

and then run @command{scm \"$(pwd)\"/example.scm}.")
      (license license:gpl3+))))

(define-public guile-bash-parallel
  (let (
	;;(commit "8556ab01664ec56f858481b2445c17f33e3e995f")
	;;(commit "ab2d683")
        (commit "6b83df7")
	(revision "1"))
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
                  "0jl9chgfslsclx1gh3m71b4ybqc52sknn7qlvjqy4knklmgbwjch"
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
                               (share (string-append out "/share/guile/site/2.2")))
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


(define-public libxml2-xpath0
    (let ((commit "6c7a378117ad7c5300b99161b4a7ce4e2df61bc6")
	(revision "0.0.0"))
      (package
       (name "libxml2-xpath0")
       (version (git-version "1.1.1" revision commit))
       (source (origin
	        (method git-fetch)
	        (uri (git-reference
		      (commit commit)
		      (url "https://gitlab.gnome.org/cykerway/libxml2.git")))
	        (sha256
	         (base32 "1w4npcwyywypxfiggjqgw6l8yh0jasah8k96fv5xg0h3l4nvp4wx"))))
       (build-system gnu-build-system)
       (outputs '("out" "static"))
       (arguments
        `(#:phases
          (modify-phases %standard-phases
                         (add-after 'install 'move-static-libs
                                    (lambda* (#:key outputs #:allow-other-keys)
                                      (let ((src (string-append (assoc-ref outputs "out") "/lib"))
                                            (dst (string-append (assoc-ref outputs "static")
                                                                "/lib")))
                                        (mkdir-p dst)
                                        (for-each (lambda (ar)
                                                    (rename-file ar (string-append dst "/"
                                                                                   (basename ar))))
                                                  (find-files src "\\.a$"))
                                        #t))))))
       (home-page "http://www.xmlsoft.org/")
       (synopsis "C parser for XML")
       (inputs `(("xz" ,xz)
                 ("autoconf" ,autoconf)
                 ("libtool" ,libtool)
                 ("m4" ,m4)
                 ("pkg-config" ,pkg-config)
                 ("automake" ,automake)))
       (propagated-inputs `(("zlib" ,zlib))) ; libxml2.la says '-lz'.
       (native-inputs `(("perl" ,perl)))
       ;; $XML_CATALOG_FILES lists 'catalog.xml' files found in under the 'xml'
       ;; sub-directory of any given package.
       (native-search-paths (list (search-path-specification
                                   (variable "XML_CATALOG_FILES")
                                   (separator " ")
                                   (files '("xml"))
                                   (file-pattern "^catalog\\.xml$")
                                   (file-type 'regular))))
       (search-paths native-search-paths)
       (description
        "Libxml2 is the XML C parser and toolkit developed for the Gnome
project (but it is usable outside of the Gnome platform).")
       (license license:x11))))
;; should work for guix commit 45ee3fde877ef39dca8382efbbb320c4062637c2
(define-public myphp
  (package
    (name "myphp")
    (version "7.3.6")
    (home-page "https://secure.php.net/")
    (source (origin
              (method url-fetch)
              (uri (string-append home-page "distributions/"
                                  "php-" version ".tar.xz"))
              (sha256
               (base32
                "0r51aiff2abbr3d2swhvja0wm56sjxzqbciabcvvq3m3v9kqkz7y"))
              (modules '((guix build utils)))
              (snippet
               '(with-directory-excursion "ext"
                  (for-each delete-file-recursively
                            ;; Some of the bundled libraries have no proper upstream.
                            ;; Ideally we'd extract these out as separate packages:
                            ;;"mbstring/libmbfl"
                            ;;"date/lib"
                            ;;"bcmath/libbcmath"
                            ;;"fileinfo/libmagic" ; This is a patched version of libmagic.
                            '("gd/libgd"
                              "mbstring/oniguruma"
                              "pcre/pcre2lib"
                              "sqlite3/libsqlite"
                              "xmlrpc/libxmlrpc"
                              "zip/lib"))
                  #t))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags
       (let-syntax ((with (syntax-rules ()
                            ((_ option input)
                             (string-append option "="
                                            (assoc-ref %build-inputs input))))))
         (list (with "--with-bz2" "bzip2")
               (with "--with-curl" "curl")
               (with "--with-freetype-dir" "freetype")
               (with "--with-gd" "gd")
               (with "--with-gdbm" "gdbm")
               (with "--with-gettext" "glibc") ; libintl.h
               (with "--with-gmp" "gmp")
               (with "--with-jpeg-dir" "libjpeg")
               (with "--with-ldap" "openldap")
               (with "--with-ldap-sasl" "cyrus-sasl")
               (with "--with-libzip" "zip")
               (with "--with-libxml-dir" "libxml2")
               (with "--with-onig" "oniguruma")
               (with "--with-pcre-dir" "pcre")
               (with "--with-pcre-regex" "pcre")
               (with "--with-pdo-pgsql" "postgresql")
               (with "--with-pdo-sqlite" "sqlite")
               (with "--with-pgsql" "postgresql")
               (with "--with-png-dir" "libpng")
               ;; PHP’s Pspell extension, while retaining its current name,
               ;; now uses the Aspell library.
               (with "--with-pspell" "aspell")
               (with "--with-readline" "readline")
               (with "--with-sqlite3" "sqlite")
               (with "--with-tidy" "tidy")
               (with "--with-webp-dir" "libwebp")
               (with "--with-xpm-dir" "libxpm")
               (with "--with-xsl" "libxslt")
               (with "--with-zlib-dir" "zlib")
               ;; We could add "--with-snmp", but it requires netsnmp that
               ;; we don't have a package for. It is used to build the snmp
               ;; extension of php.
               "--with-iconv"
               "--with-openssl"
               "--with-mysqli"          ; Required for, e.g. wordpress
               "--with-pdo-mysql"
               "--with-zlib"
               "--enable-bcmath"        ; Required for, e.g. Zabbix frontend
               "--enable-calendar"
               "--enable-dba=shared"
               "--enable-exif"
               "--enable-flatfile"
               "--enable-fpm"
               "--enable-ftp"
               "--enable-inifile"
               "--enable-mbstring"
               "--enable-pcntl"
               "--enable-sockets"))
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'do-not-record-build-flags
           (lambda _
             ;; Prevent configure flags from being stored and causing
             ;; unnecessary runtime dependencies.
             (substitute* "scripts/php-config.in"
               (("@CONFIGURE_OPTIONS@") "")
               (("@PHP_LDFLAGS@") ""))
             ;; This file has ISO-8859-1 encoding.
             (with-fluids ((%default-port-encoding "ISO-8859-1"))
               (substitute* "main/build-defs.h.in"
                 (("@CONFIGURE_COMMAND@") "(omitted)")))
             #t))
         (add-before 'build 'patch-/bin/sh
           (lambda _
             (substitute* '("run-tests.php" "ext/standard/proc_open.c")
               (("/bin/sh") (which "sh")))
             #t))
         (add-before 'check 'prepare-tests
           (lambda _
             ;; Some of these files have ISO-8859-1 encoding, whereas others
             ;; use ASCII, so we can't use a "catch-all" find-files here.
             (with-fluids ((%default-port-encoding "ISO-8859-1"))
               (substitute* '("ext/mbstring/tests/mb_send_mail02.phpt"
                              "ext/mbstring/tests/mb_send_mail04.phpt"
                              "ext/mbstring/tests/mb_send_mail05.phpt"
                              "ext/mbstring/tests/mb_send_mail06.phpt")
                 (("/bin/cat") (which "cat"))))
             (substitute* '("ext/mbstring/tests/mb_send_mail01.phpt"
                            "ext/mbstring/tests/mb_send_mail03.phpt"
                            "ext/mbstring/tests/bug52861.phpt"
                            "ext/standard/tests/general_functions/bug34794.phpt"
                            "ext/standard/tests/general_functions/bug44667.phpt"
                            "ext/standard/tests/general_functions/proc_open.phpt")
               (("/bin/cat") (which "cat")))

             ;; The encoding of this file is not recognized, so we simply drop it.
             (delete-file "ext/mbstring/tests/mb_send_mail07.phpt")

             (substitute* "ext/standard/tests/streams/bug60602.phpt"
               (("'ls'") (string-append "'" (which "ls") "'")))

             ,@(if (string-prefix? "arm" (or (%current-system)
                                             (%current-target-system)))
                   ;; Drop tests known to fail on armhf.
                   '((for-each delete-file
                              (list
                                "ext/calendar/tests/unixtojd_error1.phpt"
                                ;; arm can be a lot slower, so a time-related test fails
                                "ext/fileinfo/tests/cve-2014-3538-nojit.phpt"
                                "ext/pcre/tests/bug76514.phpt"
                                "ext/pcre/tests/preg_match_error3.phpt"
                                "ext/standard/tests/general_functions/var_export-locale.phpt"
                                "ext/standard/tests/general_functions/var_export_basic1.phpt")))
                   '())

             ;; Drop tests that are known to fail.
             (for-each delete-file
                       '("ext/posix/tests/posix_getgrgid.phpt"    ; Requires /etc/group.
                         "ext/sockets/tests/bug63000.phpt"        ; Fails to detect OS.
                         "ext/sockets/tests/socket_shutdown.phpt" ; Requires DNS.
                         "ext/sockets/tests/socket_send.phpt"     ; Likewise.
                         "ext/sockets/tests/mcast_ipv4_recv.phpt" ; Requires multicast.
                         ;; These needs /etc/services.
                         "ext/standard/tests/general_functions/getservbyname_basic.phpt"
                         "ext/standard/tests/general_functions/getservbyport_basic.phpt"
                         "ext/standard/tests/general_functions/getservbyport_variation1.phpt"
                         ;; And /etc/protocols.
                         "ext/standard/tests/network/getprotobyname_basic.phpt"
                         "ext/standard/tests/network/getprotobynumber_basic.phpt"
                         ;; And exotic locales.
                         "ext/standard/tests/strings/setlocale_basic1.phpt"
                         "ext/standard/tests/strings/setlocale_basic2.phpt"
                         "ext/standard/tests/strings/setlocale_basic3.phpt"
                         "ext/standard/tests/strings/setlocale_variation1.phpt"

			 ;; Should probably be reenabled
			 "ext/curl/tests/curl_basic_010.phpt" ;; Test curl_error() & curl_errno() function with problematic proxy
			 "ext/mbstring/tests/mb_ereg_search_named_subpatterns.phpt" ;; Testing mb_ereg_search() named capture groups
			 "ext/openssl/tests/openssl_encrypt_ccm.phpt" ;; openssl_encrypt() with CCM cipher algorithm tests

                         ;; XXX: These gd tests fails.  Likely because our version
                         ;; is different from the (patched) bundled one.
                         ;; Here, gd quits immediately after "fatal libpng error"; while the
                         ;; test expects it to additionally return a "setjmp" error and warning.
                         "ext/gd/tests/bug39780_extern.phpt"
                         "ext/gd/tests/libgd00086_extern.phpt"
                         ;; Extra newline in gd-png output.
                         "ext/gd/tests/bug45799.phpt"
                         ;; Different error message than expected from imagecrop().
                         "ext/gd/tests/bug66356.phpt"
                         ;; Similarly for imagecreatefromgd2().
                         "ext/gd/tests/bug72339.phpt"
                         ;; Call to undefined function imageantialias().  They are
                         ;; supposed to fail anyway.
                         "ext/gd/tests/bug72482.phpt"
                         "ext/gd/tests/bug72482_2.phpt"
                         "ext/gd/tests/bug73213.phpt"
                         ;; Test expects generic "gd warning" but gets the actual function name.
                         "ext/gd/tests/createfromwbmp2_extern.phpt"
                         ;; This bug should have been fixed in gd 2.2.2.
                         ;; Is it a regression?
                         "ext/gd/tests/bug65148.phpt"
                         ;; These tests should not be run (disabled because
                         ;; GD_BUNDLED = 0)
                         "ext/gd/tests/bug77198_auto.phpt"
                         "ext/gd/tests/bug77198_threshold.phpt"
                         "ext/gd/tests/bug77200.phpt"
                         "ext/gd/tests/bug77269.phpt"
                         ;; TODO: Enable these when libgd is built with xpm support.
                         "ext/gd/tests/xpm2gd.phpt"
                         "ext/gd/tests/xpm2jpg.phpt"
                         "ext/gd/tests/xpm2png.phpt"
                         ;; Whitespace difference, probably caused by a very
                         ;; long store path
                         "ext/gd/tests/bug77479.phpt"
                         ;; Slightly different result (NULL instead of false),
                         ;; but the bug report suggests the issue was in
                         ;; the bundled gd, not upstream.
                         "ext/gd/tests/bug77272.phpt"
                         ;; Expected invalid XBM but got EOF before image was
                         ;; complete.  It's a warning in both cases and test
                         ;; result is the same.
                         "ext/gd/tests/bug77973.phpt"

                         ;; XXX: These iconv tests have the expected outcome,
                         ;; but with different error messages.
                         ;; Expects "illegal character", instead gets "unknown error (84)".
                         "ext/iconv/tests/bug52211.phpt"
                         "ext/iconv/tests/bug60494.phpt"
                         ;; Expects "wrong charset", gets unknown error (22).
                         "ext/iconv/tests/iconv_mime_decode_variation3.phpt"
                         "ext/iconv/tests/iconv_strlen_error2.phpt"
                         "ext/iconv/tests/iconv_strlen_variation2.phpt"
                         "ext/iconv/tests/iconv_substr_error2.phpt"
                         ;; Expects conversion error, gets "error condition Termsig=11".
                         "ext/iconv/tests/iconv_strpos_error2.phpt"
                         "ext/iconv/tests/iconv_strrpos_error2.phpt"
                         ;; Similar, but iterating over multiple values.
                         ;; iconv breaks the loop after the first error with Termsig=11.
                         "ext/iconv/tests/iconv_strpos_variation4.phpt"
                         "ext/iconv/tests/iconv_strrpos_variation3.phpt"
                         ;; Expects "invalid multibyte sequence" but got
                         ;; "unknown error".
                         "ext/iconv/tests/bug76249.phpt"

                         ;; XXX: These test failures appear legitimate, needs investigation.
                         ;; open_basedir() restriction failure.
                         "ext/curl/tests/bug61948.phpt"
                         ;; Fails on recent curl https://bugs.php.net/patch-display.php?bug_id=77493
                         "ext/curl/tests/curl_basic_009.phpt"
                         ;; Expects a false boolean, gets empty array from glob().
                         "ext/standard/tests/file/bug41655_1.phpt"
                         "ext/standard/tests/file/glob_variation5.phpt"
                         ;; Test output is correct, but in wrong order.
                         "ext/standard/tests/streams/proc_open_bug64438.phpt"
                         ;; The test expects an Array, but instead get the contents(?).
                         "ext/gd/tests/bug43073.phpt"
                         ;; imagettftext() returns wrong coordinates.
                         "ext/gd/tests/bug48732-mb.phpt"
                         "ext/gd/tests/bug48732.phpt"
                         ;; Similarly for imageftbbox().
                         "ext/gd/tests/bug48801-mb.phpt"
                         "ext/gd/tests/bug48801.phpt"
                         ;; Different expected output from imagecolorallocate().
                         "ext/gd/tests/bug53504.phpt"
                         ;; Wrong image size after scaling an image.
                         "ext/gd/tests/bug73272.phpt"
                         ;; Expects iconv to detect illegal characters, instead gets
                         ;; "unknown error (84)" and heap corruption(!).
                         "ext/iconv/tests/bug48147.phpt"
                         ;; Expects illegal character ".", gets "=?utf-8?Q?."
                         "ext/iconv/tests/bug51250.phpt"
                         ;; @iconv() does not return expected output.
                         "ext/iconv/tests/iconv003.phpt"
                         ;; iconv throws "buffer length exceeded" on some string checks.
                         "ext/iconv/tests/iconv_mime_encode.phpt"
                         ;; file_get_contents(): iconv stream filter
                         ;; ("ISO-8859-1"=>"UTF-8") unknown error.
                         "ext/standard/tests/file/bug43008.phpt"
                         ;; Table data not created in sqlite(?).
                         "ext/pdo_sqlite/tests/bug_42589.phpt"

                         ;; Small variation in output.
                         "ext/mbstring/tests/mb_ereg_variation3.phpt"
                         "ext/mbstring/tests/mb_ereg_replace_variation1.phpt"
                         "ext/mbstring/tests/bug72994.phpt"
                         "ext/mbstring/tests/bug77367.phpt"
                         "ext/mbstring/tests/bug77370.phpt"
                         "ext/mbstring/tests/bug77371.phpt"
                         "ext/mbstring/tests/bug77381.phpt"
                         "ext/mbstring/tests/mbregex_stack_limit.phpt"
                         "ext/mbstring/tests/mbregex_stack_limit2.phpt"
                         "ext/ldap/tests/ldap_set_option_error.phpt"

                         ;; Sometimes cannot start the LDAP server.
                         "ext/ldap/tests/bug76248.phpt"

                         ;; Bug #76909 preg_match difference between 7.3 and < 7.3
                         "ext/pcre/tests/bug76909.phpt"
                         "ext/standard/tests/file/disk_free_space_basic.phpt"
                         "ext/standard/tests/file/lstat_stat_variation8.phpt"
                         "ext/standard/tests/file/lstat_stat_variation9.phpt"
                         ))

             ;; Skip tests requiring network access.
             (setenv "SKIP_ONLINE_TESTS" "1")
             ;; Without this variable, 'make test' passes regardless of failures.
             (setenv "REPORT_EXIT_STATUS" "1")
             ;; Skip tests requiring I/O facilities that are unavailable in the
             ;; build environment
             (setenv "SKIP_IO_CAPTURE_TESTS" "1")
             #t)))
       #:test-target "test"))
    (inputs
     `(("aspell" ,aspell)
       ("bzip2" ,bzip2)
       ("curl" ,curl)
       ("cyrus-sasl" ,cyrus-sasl)
       ("freetype" ,freetype)
       ("gd" ,gd)
       ("gdbm" ,gdbm)
       ("glibc" ,glibc)
       ("gmp" ,gmp)
       ("gnutls" ,gnutls)
       ("libgcrypt" ,libgcrypt)
       ("libjpeg" ,libjpeg-turbo)
       ("libpng" ,libpng)
       ("libwebp" ,libwebp)
       ("libxml2" ,libxml2)
       ("libxpm" ,libxpm)
       ("libxslt" ,libxslt)
       ("libx11" ,libx11)
       ("oniguruma" ,oniguruma)
       ("openldap" ,openldap)
       ("openssl" ,openssl)
       ("pcre" ,pcre2)
       ("postgresql" ,postgresql)
       ("readline" ,readline)
       ("sqlite" ,sqlite)
       ("tidy" ,tidy)
       ("zip" ,zip)
       ("zlib" ,zlib)))
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("bison" ,bison)
       ("intltool" ,intltool)
       ("procps" ,procps)))         ; For tests.
    (synopsis "PHP programming language")
    (description
      "PHP (PHP Hypertext Processor) is a server-side (CGI) scripting
language designed primarily for web development but is also used as
a general-purpose programming language.  PHP code may be embedded into
HTML code, or it can be used in combination with various web template
systems, web content management systems and web frameworks." )
    (license (list
              (license:non-copyleft "file://LICENSE")       ; The PHP license.
              (license:non-copyleft "file://Zend/LICENSE")  ; The Zend license.
              license:lgpl2.1                               ; ext/mbstring/libmbfl
              license:lgpl2.1+                              ; ext/bcmath/libbcmath
              license:bsd-2                                 ; ext/fileinfo/libmagic
              license:expat))))                              ; ext/date/lib

(define-public prips
  (package
    (name "prips")
    (version "1.1.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://devel.ringlet.net/files/sys/" name "/" name "-" version ".tar.xz"))
       (sha256
        (base32 "1a33vbl4w603mk6mm5r3vhk87fy3dfk5wdpch0yd3ncbkg3fmvqn"))))
    (build-system gnu-build-system)
    (arguments
     '(#:make-flags (list "CC=gcc")
       #:phases (modify-phases
                    %standard-phases
                    (delete 'configure)
                    (delete 'check)
                    (replace 'install
                             (lambda _
                               (let*
                                   ((bin-dir  (string-append %output "/bin"))
                                    (bin-file (string-append bin-dir "/prips")))
                                 (mkdir-p bin-dir)
                                 (copy-file "prips" bin-file)
                                 (chmod bin-file #o700)))))))
    (synopsis "Tool that prints the IP addresses in a given range")
    (description "Prips can be used to print all of the IP addresses in a given range. This allows the enhancement of tools only work on one host at a time (e.g. whois).")
    (home-page "https://devel.ringlet.net/sysutils/prips/")
    (license license:gpl2)))

(define-public bash-coding-utils.sh
  (let (;;(commit "5ead530")
	;;(commit "a4cb5d8a")
	;;(commit "2aed113")
	;;(commit "4cb80cb")
        ;;(commit "6519644")
        ;;(commit "f8d5f27")
        (commit "7046374017733531b823ff9db063e583a3e469ef")
	(revision "1"))
    (package
      (name "bash-coding-utils.sh")
      (version "v0.1.3")
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
                  "1slyhxy9z3iiz3hy6hiyls0cphgjn967vgy3dvx0fjnn99wi5kpm"
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
                           ("ctypes.sh" ,ctypes.sh)
                           ;;("bash-ctypes" ,bash-ctypes)
                           ("curl" ,curl)
                           ("expect" ,expect)
                           ("gawk" ,gawk)
                           ("grep" ,grep)
                           ("guile" ,guile-2.2)
                           ("guile-daemon" ,guile-daemon)
                           ("guile-bash2.2" ,guile-bash2.2)
                           ("guile-base64" ,guile-base64)
                           ("guile-csv" ,guile-csv)
                           ("guile-bash-parallel" ,guile-bash-parallel)
                           ("ipcalc" ,ipcalc)
                           ("jq" ,jq)
                           ("libxml2-xpath0" ,libxml2-xpath0)
                           ;;("myphp" ,myphp)
                           ("php" ,php)
                           ("netcat" ,netcat) ;; for pydaemon
                           ("orgmk" ,orgmk)         
                           ("pcre/bin" ,pcre "bin")
                           ("prips" ,prips)
                           ("python" ,python)
                           ("python-yq" ,python-yq)
                           ("python-lxml" ,python-lxml)
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

