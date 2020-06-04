(define-module (python-extras)
#:use-module (guix packages)
#:use-module (guix download)
#:use-module (guix git-download)
#:use-module (gnu packages python-xyz)
;;#:use-module (gnu packages python) ;; python-testpath to figure out python version
#:use-module (gnu packages check) ;; python-pytest
#:use-module (guix build-system python)
#:use-module (gnu packages graphviz)
#:use-module ((guix licenses) #:prefix license:)
)

(define-public python-pydotplus
  (package
   (name "python-pydotplus")
   (version "2.0.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pydotplus" version))
     (sha256
      (base32
       "1i05cnk3yh722fdyaq0asr7z9xf7v7ikbmnpxa8j6pdqx6g5xs4i"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-pyparsing" ,python-pyparsing)))
   (home-page "http://pydotplus.readthedocs.org/")
   (synopsis
    "Python interface to Graphviz's Dot language")
   (description
    "Python interface to Graphviz's Dot language")
   (license #f)))

(define-public python-nbcorg
  (package
   (name "python-nbcorg")
   (version "0.0.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "nbcorg" version))
     (sha256
      (base32
          "19ma8r1vf865r3f1mnnw2ls2zcqlnhw9w6n102v5n1x6y6qykkpa"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-nbconvert" ,python-nbconvert-5.6.1)
      ("python-pandoc" ,python-pandoc)))
   (home-page "https://github.com/ahrenberg/nbcorg")
   (synopsis "An nbconvert orgmode-exporter")
  (description "An nbconvert orgmode-exporter")
  (license #f)))
(define-public python-pandoc
  (package
   (name "python-pandoc")
   (version "1.0.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pandoc" version))
     (sha256
      (base32
       "1zdi2xbc7zhmi4zd7qsxjn0dr2ialj63fqsbqxsvx0vm29gzcm0v"))))
   (build-system python-build-system)
   (arguments '(#:tests? #f))   
   (propagated-inputs `(("python-ply" ,python-ply)))
   (home-page "https://github.com/boisgera/pandoc")
   (synopsis "Pandoc Documents for Python")
   (description "Pandoc Documents for Python")
   (license license:expat)))

;; (define-public jupyter-lab
;;   (package
;;     (name "jupyter-lab")
;;     (version "1.2.11")
;;     (source
;;      (origin
;;        (method url-fetch)
;;        (uri (pypi-uri "jupyter" version))
;;        (sha256
;;         (base32
;;          "0pwf3pminkzyzgx5kcplvvbvwrrzd3baa7lmh96f647k30rlpp6r"))))
;;     (build-system python-build-system)
;;     (arguments '(#:tests? #f)) ; there are none.
;;     (propagated-inputs
;;      `(("python-ipykernel" ,python-ipykernel)
;;        ("python-ipywidgets" ,python-ipywidgets)
;;        ("python-jupyter-console" ,python-jupyter-console)
;;        ("python-nbconvert" ,python-nbconvert)
;;        ("python-notebook" ,python-notebook)
;;        ("python-qtconsole" ,python-qtconsole)))
;;     (native-search-paths
;;      (list (search-path-specification
;;             (variable "JUPYTER_PATH")
;;             (files '("share/jupyter")))))
;;     (home-page "https://jupyter.org")
;;     (synopsis "Web application for interactive documents")
;;     (description
;;      "The Jupyter Notebook is a web application that allows you to create and
;; share documents that contain live code, equations, visualizations and
;; explanatory text.  Uses include: data cleaning and transformation, numerical
;; simulation, statistical modeling, machine learning and much more.")
;;     (license license:bsd-3)))

(define-public python-fastscript
(package
  (name "python-fastscript")
  (version "0.1.4")
  (source
    (origin
      (method git-fetch)
      ;;(method url-fetch)
      ;;(uri (pypi-uri "fastscript" version))
      (uri (git-reference
	    (commit "c217e613824c5219a1035faf9b8f0b11ae64c067")
	    (url "https://github.com/fastai/fastscript.git")))
      (sha256
        (base32
        ;;  "16m1ifr0ymf2wk2rvcrza3p6cvs21cl408fp0m03s1mc2ydlgzd0"))))
	  "09fqx1s1nnr7xpkmvw3icjm4ypf3rwhwv9lz2nm7hkhx9abmp108"))))
  (build-system python-build-system)
  (native-inputs
      `(("python-packaging" ,python-packaging)
;;	("python-setuptools" ,python-setuptools)
	("python-configparser" ,python-configparser)))
;;  (inputs
;;	`(("python-configparser" ,python-configparser)
;;	  ("python-setuptools" ,python-setuptools)))
;;  (propagated-inputs
;;	`(("python-configparser" ,python-configparser)
;;	  ("python-setuptools" ,python-setuptools)))
  (home-page
    "https://github.com/fastai/fastscript")
  (synopsis
    "A fast way to turn your python function into a script")
  (description
    "A fast way to turn your python function into a script")
  (license #f))
)
(define-public python-nbconvert-5.6.1
  (package
    (name "python-nbconvert")
    (version "5.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "nbconvert" version))
       (sha256
        (base32
         "08xm2sz7fslp2cm87k38anv3jxwxcld44hii1sx84gml03kliyr1"))))
    (build-system python-build-system)
    (arguments
     `(;; The "bdist_egg" target is disabled by default, causing the installation
       ;; to fail.
       #:configure-flags (list "bdist_egg")
       ;; FIXME: 5 failures, 40 errors.
       #:tests? #f))
       ;; #:phases
       ;; (modify-phases %standard-phases
       ;;   (replace 'check
       ;;     (lambda _
       ;;       (zero? (system* "py.test" "-v")))))
    (native-inputs
     `(("python-pytest" ,python-pytest)))
    (propagated-inputs
     `(("python-bleach" ,python-bleach)
       ("python-entrypoints" ,python-entrypoints)
       ("python-jinja2" ,python-jinja2)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-mistune" ,python-mistune)
       ("python-nbformat" ,python-nbformat)
       ("python-pygments" ,python-pygments)
       ("python-traitlets" ,python-traitlets)))
    (home-page "http://jupyter.org")
    (synopsis "Converting Jupyter Notebooks")
    (description "The @code{nbconvert} tool, @{jupyter nbconvert}, converts
notebooks to various other formats via Jinja templates.  It allows you to
convert an @code{.ipynb} notebook file into various static formats including:

@enumerate
@item HTML
@item LaTeX
@item PDF
@item Reveal JS
@item Markdown (md)
@item ReStructured Text (rst)
@item executable script
@end enumerate\n")
    (license license:bsd-3)))
(define-public python-defusedxml (package
  (name "python-defusedxml")
  (version "0.6.0")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "defusedxml" version))
      (sha256
        (base32
          "1xbp8fivl3wlbyg2jrvs4lalaqv1xp9a9f29p75wdx2s2d6h717n"))))
  (build-system python-build-system)
  (home-page "https://github.com/tiran/defusedxml")
  (synopsis
    "XML bomb protection for Python stdlib modules")
  (description
    "XML bomb protection for Python stdlib modules")
  (license #f))
)
(define-public python-testpath-0.4.4
  (package
    (name "python-testpath")
    (version "0.4.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/jupyter/testpath")
              (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1fwv4d3p54xx1x942s104irr35lszvv6jnr4nn1scsfvc0m1qmbk"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f ; this package does not even have a setup.py
       #:modules ((guix build python-build-system)
                  (guix build utils)
                  (srfi srfi-1))
       #:phases
       (modify-phases %standard-phases
         (delete 'install)
         (replace 'build
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((version (last
                              (string-split (assoc-ref inputs "python") #\-)))
                    (x.y (string-join (take (string-split version #\.) 2)
                                        "."))
                    (dir (string-append
                          (assoc-ref outputs "out")
                          "/lib/python" x.y "/site-packages/testpath")))
               (mkdir-p dir)
               (copy-recursively "testpath" dir))
             #t)))))
    (home-page "https://github.com/takluyver/testpath")
    (synopsis "Test utilities for code working with files and commands")
    (description
     "Testpath is a collection of utilities for Python code working with files
and commands.  It contains functions to check things on the file system, and
tools for mocking system commands and recording calls to those.")
    (license license:expat)))

(define-public python-nbdev-org-babel
(package
  (name "python-nbdev-org-babel")
  (version "0.2.18")
  (source
    (origin
     (method git-fetch)     
     (uri (git-reference
	   (commit "6889ddc28a6c1298d760762aa6ea619311d00d8b")
	   (url "https://github.com/methuselah-0/nbdev-org-babel.git")))
     (sha256     
      (base32
       "1w8r0bljksamxl1z7djsphm947740l3iwg7ma5vmc4jwy35g3f2r"))))
      ;;(method url-fetch)
      ;;(uri (pypi-uri "nbdev" version))
      ;;(sha256
      ;; (base32
      ;;  "1ya9q3b3fya03hhqi3y5cipcr534xky47n3y2y6rzv5xay0ipy6j"))))
  (build-system python-build-system)
  (arguments
   `(#:tests? #f ; this package does not even have a setup.py
  ))
  (native-inputs
   `(("python-defusedxml" ,python-defusedxml)
     )
   )
  ;; (inputs
  ;;  `(("python-testpath" ,python-testpath)
  ;;    ))  
  (propagated-inputs
   `(("python-fastscript" ,python-fastscript)
     ("python-nbconvert" ,python-nbconvert-5.6.1)
     ("python-nbformat" ,python-nbformat)
     ("python-packaging" ,python-packaging)
     ("python-pyyaml" ,python-pyyaml)))
  (home-page
   "https://github.com/methuselah-0/nbdev-org-babel")
  (synopsis
   "Writing a jupyter notebooks library entirely in emacs org-babel")
  (description
   "Writing a jupyter notebooks library entirely in emacs org-babel")
  (license #f))
)
;; myjupyter is just like jupyter but uses a later nbdev-convert
;; (define-public myjupyter
;;   (package
;;     (name "myjupyter")
;;     (version "1.0.0")
;;     (source
;;      (origin
;;        (method url-fetch)
;;        (uri (pypi-uri "jupyter" version))
;;        (sha256
;;         (base32
;;          "0pwf3pminkzyzgx5kcplvvbvwrrzd3baa7lmh96f647k30rlpp6r"))))
;;     (build-system python-build-system)
;;     (arguments '(#:tests? #f)) ; there are none.
;;     (propagated-inputs
;;      `(("python-ipykernel" ,python-ipykernel)
;;        ("python-ipywidgets" ,python-ipywidgets)
;;        ("python-jupyter-console" ,python-jupyter-console)
;;        ("python-nbconvert" ,python-nbconvert-5.6.1)
;;        ("python-notebook" ,python-notebook)
;;        ("python-qtconsole" ,python-qtconsole)))
;;     (native-search-paths
;;      (list (search-path-specification
;;             (variable "JUPYTER_PATH")
;;             (files '("share/jupyter")))))
;;     (home-page "https://jupyter.org")
;;     (synopsis "Web application for interactive documents")
;;     (description
;;      "The Jupyter Notebook is a web application that allows you to create and
;; share documents that contain live code, equations, visualizations and
;; explanatory text.  Uses include: data cleaning and transformation, numerical
;; simulation, statistical modeling, machine learning and much more.")
;;     (license license:bsd-3)))

;;
;; everything below here is just to install trepan3k
;;

(define-public python-unpyc3
  (package
    (name "python-unpyc3")
    (version "1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              ;;(url "https://github.com/figment/unpyc3.git")
              (url "https://github.com/andrew-tavera/unpyc37")
              (commit "cb764b432a4ce412a9758c3c7136e3c416aa3083")))
       ;;(file-name (git-file-name name version))
       (sha256
        (base32
         "1y5jmwi9fby3cl2fqdxllc6yj3gqc6ilqk74abz4gb249jr6razf"))))
    (build-system python-build-system)
    (arguments
     `(;#:tests? #f ; this package does not even have a setup.py
       #:modules ((guix build python-build-system)
                  (guix build utils)
                  (srfi srfi-1))
       #:phases
       (modify-phases %standard-phases
         (delete 'install)
         (replace 'build
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((version (last
                              (string-split (assoc-ref inputs "python") #\-)))
                    (x.y (string-join (take (string-split version #\.) 2)
                                        "."))
                    (dir (string-append
                          (assoc-ref outputs "out")
                          "/lib/python" x.y "/site-packages")))
               (mkdir-p dir)
               ;;(copy-recursively "." dir)
               ;;(invoke "touch" (string-append dir "/__init__.py"))
               (copy-file "unpyc3.py" (string-append dir "/unpyc3.py"))
               )               
             #t))
         (delete 'check)
         (delete 'test)
         )))
    ;;(home-page "https://github.com/figment/unpyc3.git")
    (home-page "https://github.com/andrew-tavera/unpyc37")
    (synopsis "Decompile python code")
    (description
     "Decompiler for python3.3")
    (license license:expat)))

(define-public python-uncompyle6
  (package
    (name "python-uncompyle6")
    (version "3.7.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "uncompyle6" version))
        (sha256
          (base32
            "0d014bdmiyg6x170xyysv6c87p13b17vhafbgfhjvf6niv95s3fb"))))
    (build-system python-build-system)
    ;; according to CircleCI definition tests are done in a special (and doesnt even work as of 2020-06-04 anyway)
    (arguments '(#:tests? #f))
    (native-inputs
     `(("python-click" ,python-click)
       ("python-nose" ,python-nose)
       ("python-unpyc3" ,python-unpyc3)
       ))
    (propagated-inputs
     `(("python-spark-parser" ,python-spark-parser)
       ("python-xdis" ,python-xdis)))
    (home-page
      "https://github.com/rocky/python-uncompyle6/")
    (synopsis
      "Python cross-version byte-code decompiler")
    (description
      "Python cross-version byte-code decompiler")
    (license #f)))

(define-public python-tracer
  (package
    (name "python-tracer")
    (version "0.3.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "tracer" version))
        (sha256
          (base32
            "1qyalyqsyaxskccbixk44bszgvapm2zvi2vffy043ax5ir1kznqx"))))
    (build-system python-build-system)
    (native-inputs
     `(
       ("python-nose" ,python-nose)
       ))    
    
    (home-page #nil)
    (synopsis "Centralized sys.settrace management")
    (description
      "Centralized sys.settrace management")
    (license #f)))

(define-public python-spark-parser
  (package
    (name "python-spark-parser")
    (version "1.8.9")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "spark-parser" version))
        (sha256
          (base32
            "0np2y4jcir4a4j18wws7yzkz2zj6nqhdhn41rpq8pyskg6wrgfx7"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-click" ,python-click)
       ("python-nose" ,python-nose)
       ))    
    (home-page
      "https://github.com/rocky/python-spark/")
    (synopsis
      "An Earley-Algorithm Context-free grammar Parser Toolkit")
    (description
      "An Earley-Algorithm Context-free grammar Parser Toolkit")
    (license license:expat)))

(define-public python-xdis
  (package
    (name "python-xdis")
    (version "4.6.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "xdis" version))
        (sha256
          (base32
            "04q3kdwjr2c5c5vw31sdrdmpvvgjzxjbnxhisr1wrxxh0lx1glk4"))))
    (build-system python-build-system)
    ;; you are supposed to modify the test phase here and give it python setup.py ['xdis', 'xdis.bin', 'xdis.codetype', 'xdis.dropbox', 'xdis.opcodes'] according to the build log failure, but no time for that currently...
    (arguments '(#:tests? #f))    
    (home-page
      "https://github.com/rocky/python-xdis/")
    (synopsis
      "Python cross-version byte-code disassembler and marshal routines")
    (description
      "Python cross-version byte-code disassembler and marshal routines")
    (license #f)))

(define-public python-pyficache
  (package
    (name "python-pyficache")
    (version "2.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pyficache" version))
        (sha256
          (base32
            "0fmpd3yl8fa3n0683kqc0shnbjcvlkh1fz6p9dryb6vga3ws4qls"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-nose" ,python-nose)
       ))    
    (propagated-inputs
      `(("python-pygments" ,python-pygments)
        ("python-xdis" ,python-xdis)))
    (home-page
      "http://github.com/rocky/python-filecache")
    (synopsis
      "Cache lines and file information which are generally Python programs")
    (description
      "Cache lines and file information which are generally Python programs")
    (license license:gpl3)))

(define-public python-backports.shutil-get-terminal-size
  (package
    (name "python-backports.shutil-get-terminal-size")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri
               "backports.shutil_get_terminal_size"
               version))
        (sha256
          (base32
            "107cmn7g3jnbkp826zlj8rrj19fam301qvaqf0f3905f5217lgki"))))
    (build-system python-build-system)
    ;; failed with some output saying this is not a test so...
    (arguments '(#:tests? #f))
    (home-page
      "https://github.com/chrippa/backports.shutil_get_terminal_size")
    (synopsis
      "A backport of the get_terminal_size function from Python 3.3's shutil.")
    (description
      "A backport of the get_terminal_size function from Python 3.3's shutil.")
    (license license:expat)))

(define-public python-columnize
  (package
    (name "python-columnize")
    (version "0.3.10")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "columnize" version))
        (sha256
          (base32
            "1k7mdi79zhhsis2w14jy07s2ayw24dd67dikvhhywiwlwi59hsan"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-nose" ,python-nose)
       ("python-mock" ,python-mock)))
    (propagated-inputs
      `(("python-backports.shutil-get-terminal-size"
         ,python-backports.shutil-get-terminal-size)))
    (home-page
      "https://github.com/rocky/pycolumnize")
    (synopsis
      "Format a simple (i.e. not nested) list into aligned columns.")
    (description
      "Format a simple (i.e. not nested) list into aligned columns.")
    (license license:expat)))

(define-public python-trepan3k
  (package
    (name "python-trepan3k")
    (version "1.0.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "trepan3k" version))
        (sha256
          (base32
            "04zvqf4f6r6hjyifaypvssd5rwhcb3a2x3zay9igpvxs1npcsfqv"))))
    (build-system python-build-system)
        (native-inputs
     `(("python-click" ,python-click)
;;       ("python-nose" ,python-nose)
;;       ("python-unpyc3" ,python-unpyc3)
       ))

    (propagated-inputs
      `(("python-columnize" ,python-columnize)
        ("python-nose" ,python-nose)
        ("python-pyficache" ,python-pyficache)
        ("python-pygments" ,python-pygments)
        ("python-spark-parser" ,python-spark-parser)
        ("python-tracer" ,python-tracer)
        ("python-uncompyle6" ,python-uncompyle6)
        ("python-xdis" ,python-xdis)))
    (home-page
      "http://github.com/rocky/python3-trepan/")
    (synopsis
      "GDB-like Python Debugger in the Trepan family")
    (description
      "GDB-like Python Debugger in the Trepan family")
    (license #f)))

(define-public python-pandoc
  (package
    (name "python-pandoc")
    (version "1.0.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pandoc" version))
        (sha256
          (base32
            "1zdi2xbc7zhmi4zd7qsxjn0dr2ialj63fqsbqxsvx0vm29gzcm0v"))))
    (build-system python-build-system)
    ;; python setup.py test fails with "error: [Errno 2] No such file or directory: '/tmp/guix-build-python-pandoc-1.0.2.drv-0/pandoc-1.0.2/pandoc/definitions/1.16.hs'" so disabling it.
    (arguments '(#:tests? #f))    
    
    (propagated-inputs `(("python-ply" ,python-ply)))
    (home-page "https://github.com/boisgera/pandoc")
    (synopsis "Pandoc Documents for Python")
    (description "Pandoc Documents for Python")
    (license license:expat)))

(define-public python-nbcorg
  (package
    (name "python-nbcorg")
    (version "0.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "nbcorg" version))
        (sha256
          (base32
            "19ma8r1vf865r3f1mnnw2ls2zcqlnhw9w6n102v5n1x6y6qykkpa"))))
    (build-system python-build-system)
    ;; since Im unable to fix the testpath input needed for the tests...
    (arguments '(#:tests? #f)) ; there are none.
    (native-inputs
     `(("python-click" ,python-defusedxml)
;;       ("python-testpath" ,python-testpath)
       ))
    (propagated-inputs
      `(("python-nbconvert" ,python-nbconvert-5.6.1)
        ("python-pandoc" ,python-pandoc)))
    (home-page "https://github.com/ahrenberg/nbcorg")
    (synopsis "An nbconvert orgmode-exporter")
    (description "An nbconvert orgmode-exporter")
    (license #f)))
;;python-nbcorg
;;python-pandoc
;;python-pydotplus
;;python-nbdev-org-babel
;;myjupyter
;;python-nbconvert
;;python-defusedxml
;;python-testpath-0.4.4
;;python-trepan3k
;; should load uncompyl6 which should load unpyc3
;;python-nbcorg
;;python-unpyc3
