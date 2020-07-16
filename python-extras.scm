(define-module (python-extras)
#:use-module (guix packages)
#:use-module (guix download)
#:use-module (guix git-download)
#:use-module (gnu packages python-xyz)
;;#:use-module (gnu packages python) ;; python-testpath to figure out python version
#:use-module (gnu packages check) ;; python-pytest
#:use-module (gnu packages monitoring) ;; python-prometheus-client
#:use-module (gnu packages xml) ;; python-defusedxml
#:use-module (gnu packages python-web) ;; python-terminado
#:use-module (gnu packages sphinx) ;; python-sphinx
#:use-module (gnu packages textutils) ;; python-pandocfilters
#:use-module (gnu packages python-crypto) ;; python-certifi
#:use-module (guix build-system python)
#:use-module (gnu packages graphviz)
#:use-module (bash-coding-utils)
;;#:use-module (bcu-channel python-extras-2)
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
       ("python-defusedxml" ,python-defusedxml)
       ("python-jinja2" ,python-jinja2)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-mistune" ,python-mistune)
       ("python-nbformat" ,python-nbformat)
       ("python-pygments" ,python-pygments)
       ("python-testpath" ,python-testpath-0.4.4)
       ("python-pandocfilters" ,python-pandocfilters)
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
     #:modules ((guix build python-build-system)
                (guix build utils)
                (srfi srfi-1))
     #:phases
     (modify-phases %standard-phases
       ;;(delete 'install)
       (replace 'build
         (lambda* (#:key inputs outputs #:allow-other-keys)
           (let* ((version (last
                            (string-split (assoc-ref inputs "python") #\-)))
                  (x.y (string-join (take (string-split version #\.) 2)
                                    "."))
                  (dir (string-append
                        (assoc-ref outputs "out")
                        "/lib/python" x.y "/site-packages")))
             (mkdir-p (string-append dir "/nbdev"))
             (copy-file "nbdev/nbdev_build_docs_from_org.sh" (string-append dir "/nbdev/nbdev_build_docs_from_org.sh"))))))))
  (native-inputs
   `(("python-defusedxml" ,python-defusedxml)))
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

;; (define-public python-ipython
;;   (package
;;     (name "python-ipython")
;;     (version "7.9.0")
;;     (source
;;      (origin
;;        (method url-fetch)
;;        (uri (pypi-uri "ipython" version ".tar.gz"))
;;        (sha256
;;         (base32 "103jkw18z7fnwdal1mdbijjxi1fndzn31g887lmj7ddpf2r07lyz"))))
;;     (build-system python-build-system)
;;     (propagated-inputs
;;      `(("python-backcall" ,python-backcall)
;;        ("python-pyzmq" ,python-pyzmq)
;;        ("python-prompt-toolkit" ,python-prompt-toolkit-2)
;;        ("python-terminado" ,python-terminado)
;;        ("python-matplotlib" ,python-matplotlib)
;;        ("python-numpy" ,python-numpy)
;;        ("python-numpydoc" ,python-numpydoc)
;;        ("python-jedi" ,python-jedi)
;;        ("python-jinja2" ,python-jinja2)
;;        ("python-mistune" ,python-mistune)
;;        ("python-pexpect" ,python-pexpect)
;;        ("python-pickleshare" ,python-pickleshare)
;;        ("python-simplegeneric" ,python-simplegeneric)
;;        ("python-jsonschema" ,python-jsonschema)
;;        ("python-traitlets" ,python-traitlets)
;;        ("python-nbformat" ,python-nbformat)
;;        ("python-pygments" ,python-pygments)))
;;     (inputs
;;      `(("readline" ,readline)
;;        ("which" ,which)))
;;     (native-inputs
;;      `(("graphviz" ,graphviz)
;;        ("pkg-config" ,pkg-config)
;;        ("python-requests" ,python-requests) ;; for tests
;;        ("python-testpath" ,python-testpath)
;;        ("python-nose" ,python-nose)))
;;     (arguments
;;      `(#:phases
;;        (modify-phases %standard-phases
;;          (add-after 'unpack 'make-docs-reproducible
;;            (lambda _
;;              (substitute* "IPython/sphinxext/ipython_directive.py"
;;                ((".*import datetime") "")
;;                ((".*datetime.datetime.now\\(\\)") "")
;;                (("%timeit") "# %timeit"))
;;              #t))
;;          ;; Tests can only be run after the library has been installed and not
;;          ;; within the source directory.
;;          (delete 'check)
;;          (add-after 'install 'check
;;            (lambda* (#:key inputs outputs tests? #:allow-other-keys)
;;              (if tests?
;;                  (begin
;;                    ;; Make installed package available for running the tests
;;                    (add-installed-pythonpath inputs outputs)
;;                    (setenv "HOME" "/tmp/") ;; required by a test
;;                    ;; We only test the core because one of the other tests
;;                    ;; tries to import ipykernel.
;;                    (invoke "python" "IPython/testing/iptest.py"
;;                            "-v" "IPython/core/tests"))
;;                  #t)))
;;          (add-before 'check 'fix-tests
;;            (lambda* (#:key inputs #:allow-other-keys)
;;              (substitute* "./IPython/utils/_process_posix.py"
;;                (("/usr/bin/env', 'which") (which "which")))
;;              (substitute* "./IPython/core/tests/test_inputtransformer.py"
;;                (("#!/usr/bin/env python")
;;                 (string-append "#!" (which "python"))))
;;              ;; This test introduces a circular dependency on ipykernel
;;              ;; (which depends on ipython).
;;              (delete-file "IPython/core/tests/test_display.py")
;;              ;; AttributeError: module 'IPython.core' has no attribute 'formatters'
;;              (delete-file "IPython/core/tests/test_interactiveshell.py")
;;              #t)))))
;;     (home-page "https://ipython.org")
;;     (synopsis "IPython is a tool for interactive computing in Python")
;;     (description
;;      "IPython provides a rich architecture for interactive computing with:
;; Powerful interactive shells, a browser-based notebook, support for interactive
;; data visualization, embeddable interpreters and tools for parallel
;; computing.")
;;     (properties `((python2-variant . ,(delay python2-ipython))))
;;     (license license:bsd-3)))

;;
;; python-ipywidgets-next is just like python-ipywidgets but uses python-widgetsnbextension-next
;;

(define-public python-ipywidgets-next
  (package
    (name "python-ipywidgets-next")
    (version "7.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ipywidgets" version))
       (sha256
        (base32
         "15sww2mvnkqlvx55gwa82v05062a8j1xpncnqna4k9sl53hgcig9"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f )) ;; testpath problem it wont be found when running python setup.py test command either way
    (propagated-inputs
     `(("python-ipython" ,python-ipython)
       ("python-traitlets" ,python-traitlets)
       ("python-testpath" ,python-testpath-0.4.4)
       ("python-widgetsnbextension" ,python-widgetsnbextension-next)))
    (native-inputs
     `(("python-nose" ,python-nose)
       ("python-pytest" ,python-pytest)))
    (home-page "https://ipython.org")
    (synopsis "IPython HTML widgets for Jupyter")
    (description "Ipywidgets are interactive HTML widgets for Jupyter
notebooks and the IPython kernel.  Notebooks come alive when interactive
widgets are used.  Users gain control of their data and can visualize changes
in the data.")
    (license license:bsd-3)))

;;
;; python-widgetsnbextension-next uses a later nbdev-convert and adds python-testpath to native-inputs
;;

(define-public python-widgetsnbextension-next
  (package
    (name "python-widgetsnbextension-next")
    (version "3.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "widgetsnbextension" version))
       (sha256
        (base32
         "1ismyaxbv9d56yqqqb8xl58hg0iq0bbyy014a53y1g3hfbc8g7q7"))))
    (build-system python-build-system)
    ;; error: Could not find suitable distribution for Requirement.parse('testpath')
    ;; adding it doesn't help...
    (arguments '(#:tests? #f))
    (propagated-inputs
     `(("python-ipykernel" ,python-ipykernel)
       ("python-testpath" ,python-testpath-0.4.4)
       ("python-notebook" ,python-notebook-next)))
    (native-inputs
     `(("python-certifi" ,python-certifi)
       ("python-nose" ,python-nose)
       ;;("python-testpath" ,python-testpath-0.4.4)
       ))
    (home-page "https://ipython.org")
    (synopsis "IPython HTML widgets for Jupyter")
    (description "This package provides interactive HTML widgets for Jupyter
notebooks.")
    (license license:bsd-3)))

;;
;; python-notebook-next is just like jupyter but uses a later nbdev-convert
;;

(define-public python-notebook-next
  (package
    (name "python-notebook-next")
    (version "5.7.4")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "notebook" version))
              (sha256
               (base32
                "0jm7324mbxljmn9hgapj66q7swyz5ai92blmr0jpcy0h80x6f26r"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda _
             ;; These tests require a browser
             (delete-file-recursively "notebook/tests/selenium")
             ;; Some tests need HOME
             (setenv "HOME" "/tmp")
             ;; This file contains "warningfilters", which are not supported
             ;; by this version of nose.
             (delete-file "setup.cfg")
             (with-directory-excursion "/tmp"
               (invoke "nosetests" "-v"))
             #t)))))
    (propagated-inputs
     `(("python-jupyter-core" ,python-jupyter-core)
       ("python-nbformat" ,python-nbformat)
       ("python-nbconvert" ,python-nbconvert-5.6.1)
       ("python-prometheus-client" ,python-prometheus-client)
       ("python-send2trash" ,python-send2trash)
       ("python-terminado" ,python-terminado)))
    (native-inputs
     `(("python-nose" ,python-nose)
       ("python-sphinx" ,python-sphinx)
       ("python-requests" ,python-requests)))
    (home-page "http://jupyter.org/")
    (synopsis "Web-based notebook environment for interactive computing")
    (description
     "The Jupyter HTML notebook is a web-based notebook environment for
interactive computing.")
    (properties `((python2-variant . ,(delay python2-notebook))))
    (license license:bsd-3)))

;;
;; jupyter-next is just like jupyter but uses a later nbdev-convert
;;

(define-public jupyter-next
  (package
    (name "jupyter-next")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter" version))
       (sha256
        (base32
         "0pwf3pminkzyzgx5kcplvvbvwrrzd3baa7lmh96f647k30rlpp6r"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f)) ; there are none.
    (propagated-inputs
     `(("python-ipykernel" ,python-ipykernel)
       ("python-ipywidgets" ,python-ipywidgets-next)
       ("python-jupyter-console" ,python-jupyter-console)
       ("python-nbconvert" ,python-nbconvert-5.6.1)
       ("python-notebook" ,python-notebook-next)
       ("python-prompt-toolkit" ,python-prompt-toolkit)
       ("python-qtconsole" ,python-qtconsole)))
    (native-search-paths
     (list (search-path-specification
            (variable "JUPYTER_PATH")
            (files '("share/jupyter")))))
    (home-page "https://jupyter.org")
    (synopsis "Web application for interactive documents")
    (description
     "The Jupyter Notebook is a web application that allows you to create and
share documents that contain live code, equations, visualizations and
explanatory text.  Uses include: data cleaning and transformation, numerical
simulation, statistical modeling, machine learning and much more.")
    (license license:bsd-3)))

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
        ("python-testpath" ,python-testpath-0.4.4)
        ("python-pandoc" ,python-pandoc)))
    (home-page "https://github.com/ahrenberg/nbcorg")
    (synopsis "An nbconvert orgmode-exporter")
    (description "An nbconvert orgmode-exporter")
    (license #f)))
(define-public python-bash_kernel
  (package
   (name "python-bash-kernel")
   (version "0.7.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "bash_kernel" version))
     (sha256
      (base32
       "0w0nbr3iqqsgpk83rgd0f5b02462bkyj2n0h6i9dwyc1vpnq9350"))))
   (build-system python-build-system)
   (arguments '(#:tests? #f)) ; there are none.
   ;; test failure is:
   ;; /gnu/store/gmirjfdn99fg1x7r6jlw4mk5gkaypgs6-python-ipython-7.9.0/lib/python3.8/site-packages/IPython/paths.py:67: UserWarning: IPython parent '/homeless-shelter' is not a writable location, using a temp directory.
   ;;   warn("IPython parent '{0}' is not a writable location,"
   ;; error: [Errno 13] Permission denied: '/homeless-shelter'
   ;; command "python" "-c" "import setuptools, tokenize;__file__='setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\\r\\n', '\\n');f.close();exec(compile(code, __file__, 'exec'))" "test" failed with status 1
   (native-inputs `(("python-ipython" ,python-ipython)
                    ("python-ipykernel" ,python-ipykernel)
                    ))
   (propagated-inputs
    `(("python-pexpect" ,python-pexpect)))
   (home-page
    "https://github.com/takluyver/bash_kernel")
   (synopsis "A bash kernel for Jupyter")
   (description "A bash kernel for Jupyter")
   (license #f)))
;;python-nbcorg
;;python-pandoc
;;python-pydotplus
;;python-nbdev-org-babel
;;jupyter-next
;;python-nbconvert
;;python-defusedxml
;;python-testpath-0.4.4
;;python-trepan3k
;; should load uncompyl6 which should load unpyc3
;;python-nbcorg
;;python-unpyc3
python-bash_kernel
