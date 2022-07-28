(define-module (python-extras)
  #:use-module (gnu packages) ;; because of complaints in /var/log/cuirass/evaluations/1.gz
  #:use-module (gnu packages base) ;; because of findutils
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages time) ;; python-pytz is here
  #:use-module (gnu packages python-check) ;; python-coveralls is here
  #:use-module (gnu packages databases) ;; python-sqlalchemy is here
  #:use-module (gnu packages python) ;; python-testpath to figure out python version, ;; because of complaints in /var/log/cuirass/evaluations/1.gz
  #:use-module (gnu packages check) ;; python-pytest
  #:use-module (gnu packages monitoring) ;; python-prometheus-client
  #:use-module (gnu packages xml) ;; python-defusedxml
  #:use-module (gnu packages python-web) ;; python-terminado
  #:use-module (gnu packages sphinx) ;; python-sphinx
  #:use-module (gnu packages textutils) ;; python-pandocfilters
  #:use-module (gnu packages python-crypto) ;; python-certifi
  #:use-module (guix build-system python)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages moreutils)
  #:use-module (bash-coding-utils)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages libffi)
  ;;#:use-module (bcu-channel python-extras-2)
  #:use-module ((guix licenses) #:prefix license:))

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
   (license license:expat))) ;; wrong license

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
  (license license:expat)))
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
  (license license:expat)))

(define-public python-jinja2-3.0
  (package
    (name "python-jinja2-old")
    (version "3.0.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "Jinja2" version))
       (sha256
        (base32
         "1mvwr02s86zck5wsmd9wjxxb9iaqr17hdi5xza9vkwv8rmrv46v1"))))
    (build-system python-build-system)
    (arguments
     '(#:phases (modify-phases %standard-phases
                  (replace 'check
                    (lambda* (#:key tests? #:allow-other-keys)
                      (if tests?
                          (invoke "pytest" "-vv")
                          (format #t "test suite not run~%")))))))
    (native-inputs (list python-pytest))
    (propagated-inputs (list python-markupsafe))
    (home-page "https://jinja.palletsprojects.com/")
    (synopsis "Python template engine")
    (description
     "Jinja2 is a small but fast and easy to use stand-alone template engine
written in pure Python.")
    (license license:bsd-3))
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
     `(("python-pytest" ,python-pytest)
       ("python-testpath" ,python-testpath)
       ))
    (inputs `(("python-testpath" ,python-testpath)))
    (propagated-inputs
     `(("python-bleach" ,python-bleach)
       ("python-entrypoints" ,python-entrypoints)
       ("python-defusedxml" ,python-defusedxml)
       ("python-ipython-genutils" ,python-ipython-genutils)       
       ("python-jinja2" ,python-jinja2-3.0)
       ("python-jupyter-core" ,python-jupyter-core)
       ("python-mistune" ,python-mistune)
       ("python-nbformat" ,python-nbformat)
       ("python-pygments" ,python-pygments)
       ("python-testpath" ,python-testpath)
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
                      ;; TODO: try replace 'install and use flit
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
               (copy-recursively "testpath" dir)
               ;; (chdir dir)
               ;; (invoke "flit" "init")
               ;; (invoke "flit" "install")
               )
             #t)))))
    ;; (native-inputs
    ;;  `(("python-flit" ,python-flit)
    ;;    ("python-pytoml" ,python-pytoml)
    ;;    ))
    (propagated-inputs
    `(("python-pathlib2" ,python-pathlib2)))
    (home-page "https://github.com/takluyver/testpath")
    (synopsis "Test utilities for code working with files and commands")
    (description
     "Testpath is a collection of utilities for Python code working with files
and commands.  It contains functions to check things on the file system, and
tools for mocking system commands and recording calls to those.")
    (license license:expat)))

(define-public python-testpath-flit
  (package
    (name "python-testpath-flit")
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

    (arguments
     `(#:tests? #f ; this package does not even have a setup.py
       #:modules ((guix build python-build-system)
                  (guix build utils)
                  (srfi srfi-1))
       #:phases
       (modify-phases %standard-phases
                      ;; TODO: try replace 'install and use flit
         (delete 'build)
         (replace 'install
           (lambda* (#:key inputs outputs tests? #:allow-other-keys)
               ;;(chdir dir)
               (invoke "flit" "init")
               (invoke "flit" "install")
               ))         
         )))
    ;; (native-inputs
    ;;  `(("python-flit" ,python-flit)
    ;;    ("python-pytoml" ,python-pytoml)
    ;;    ))
    (propagated-inputs
    `(("python-pathlib2" ,python-pathlib2)
      ("python-flit" ,python-flit)))
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
   (version "0.2.20")
   ;; (source (origin
   ;;          (method url-fetch)
   ;;          (uri (string-append "file://" (getenv "HOME") "/src/nbdev-org-babel"))          
   ;;          (sha256
   ;;           (base32
   ;;            "7jm7324mbxljmn9hgapj66q7swyz5ai92blmr0jpcy0h80x6f26r"))))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (commit "66079a59aa9ee5e4479bdce597aac0f42f7fb565")
           (url "https://github.com/methuselah-0/nbdev-org-babel.git")))
     (sha256
      (base32
       "0krdpc6zbdljriw6s80g08fywy0d1nq8wi3q07v3qs0b6rfz68n4"
       ))))
    ;; (source
    ;;  (origin
    ;;   (method git-fetch)
    ;;   (uri (git-reference
    ;;         (commit "8dd94a02ece4098c324b335f1b73523894cce3f1")
    ;;         (url (string-append "file://" (getenv "HOME") "/src/nbdev-org-babel"))))
    
    
    ;;   (sha256
    ;;    (base32
    ;;     ;;"044qfcryhjc5axrskibyp19cjlwlqzrnl59w048bh45w6bjvrpki"
    ;;     "144qfcryhjc5axrskibyp19cjlwlqzrnl59w048bh45w6bjvrpki"
    ;;     ))))
    ;;(method url-fetch)
    ;;(uri (pypi-uri "nbdev" version))
    ;;(sha256
    ;; (base32
    ;;  "1ya9q3b3fya03hhqi3y5cipcr534xky47n3y2y6rzv5xay0ipy6j"))))
   (build-system python-build-system)
   (arguments
    `(#:tests? #f           ; this package does not even have a setup.py
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
      ("moreutils" ,moreutils)
      ("findutils" ,findutils)
      ;; since we don't have python-testpath properly packaged, we need to add this stupid thing:
      ("python-pip" ,python-pip)      
      ;; to be able to run make docs_serve which starts the jekyll website you need bundler and jekyll, but instead we need to install them via ruby's gem
      ;;("bundler" ,bundler)
      ;;("jekyll" ,jekyll)
      ("ruby" ,ruby)
      ;; libffi is needed for jekyll that gets installed via bundler and Gemfile in the nbdev docs folder
      ("libffi" ,libffi)
      ("python-pyyaml" ,python-pyyaml-5)))
   (home-page
    "https://github.com/methuselah-0/nbdev-org-babel")
   (synopsis
    "Writing a jupyter notebooks library entirely in emacs org-babel")
   (description
    "Writing a jupyter notebooks library entirely in emacs org-babel")
 (license license:expat)))

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
       ("python-testpath" ,python-testpath)
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
       ("python-testpath" ,python-testpath)
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
       ("python-ipykernel" ,python-ipykernel)       
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
    (version "3.8.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "uncompyle6" version))
        (sha256
          (base32
            "053hh6mmllzwl7ndlf8fkiizr3yp6h4j4zhqg0z1zz3dixhk61k2"))))
    (build-system python-build-system)
    ;; according to CircleCI definition tests are done in a special (and doesnt even work as of 2020-06-04 anyway)
    (arguments '(#:tests? #f))
    (native-inputs
     `(("python-click" ,python-click)
       ("python-nose" ,python-nose)
       ("python-unpyc3" ,python-unpyc3)
       ("six" ,python-six)
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
    (license license:expat)))

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
    (license license:expat)))

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
    (version "6.0.4")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "xdis" version))
        (sha256
          (base32
            "1f7zmr1dzfsw2gdzvnb8qfd2if2h7yjxnvfzbcgk7a0fz8y4bi8v"))))
    (build-system python-build-system)
    ;; you are supposed to modify the test phase here and give it python setup.py ['xdis', 'xdis.bin', 'xdis.codetype', 'xdis.dropbox', 'xdis.opcodes'] according to the build log failure, but no time for that currently...
    (arguments '(#:tests? #f))
    (inputs
     `(("click" ,python-click)
       ("six" ,python-six)))
    (home-page
      "https://github.com/rocky/python-xdis/")
    (synopsis
      "Python cross-version byte-code disassembler and marshal routines")
    (description
      "Python cross-version byte-code disassembler and marshal routines")
    (license license:expat)))

(define-public python-pyficache
  (package
    (name "python-pyficache")
    (version "2.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pyficache" version))
        (sha256
          (base32
            "0m33nsznbad21z330pdxwqjsby9w5ykih8bwfj369vs47w9331xc"))))
    (build-system python-build-system)

     (arguments '(#:tests? #f))
     ;; `(;; network tests so disabling
     ;;   #:phases
     ;;   (modify-phases %standard-phases
     ;;     (add-before 'check 'set-home
     ;;       (lambda* (#:key inputs outputs #:allow-other-keys)
     ;;         (setenv "HOME" "/tmp"))
     ;;       ) ) ) )
    (native-inputs
     `(("python-nose" ,python-nose)
       ))    
    (propagated-inputs
      `(("python-pygments" ,python-pygments)
        ("python-xdis" ,python-xdis)
        ("python-xdis" ,python-six)
        ("python-click" ,python-click)))
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

(define-public python-term-background
  (package
    (name "python-term-background")
    (version "1.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/rocky/shell-term-background/archive/refs/tags/" version ".tar.gz"))
       (sha256
        (base32 "1a3pchxwqv23b78m58abkb47z9bh769pw3kvcmwf04f3zbg83465"))))
    (build-system python-build-system)
    (home-page
     "http://github.com/rocky/shell-term-background")
    (synopsis
      "Check if terminal has light or dark background")
    (description
      "Check if terminal has light or dark background")
    (license license:gpl2)
    )
  )

(define-public python-trepan3k
  (package
    (name "python-trepan3k")
    (version "1.2.8")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "trepan3k" version))
        (sha256
          (base32
            "15868c3z7l5x8nlq84979i87szscg99d23k53vm4r6wljc598ryy"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f))
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
        ("python-term-background" ,python-term-background)
        ("python-xdis" ,python-xdis)))
    (home-page
      "http://github.com/rocky/python3-trepan/")
    (synopsis
      "GDB-like Python Debugger in the Trepan family")
    (description
      "GDB-like Python Debugger in the Trepan family")
    (license license:expat)))

(define-public python-pandoc
  (package
    (name "python-pandoc")
    (version "2.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pandoc" version))
        (sha256
          (base32
            "07kfzq2f35lnmnqz8mjcqa3m296r5a8i8fng2q7h2q975wjywqyh"))))
    (build-system python-build-system)
    ;; python setup.py test fails with "error: [Errno 2] No such file or directory: '/tmp/guix-build-python-pandoc-1.0.2.drv-0/pandoc-1.0.2/pandoc/definitions/1.16.hs'" so disabling it.
    (arguments '(#:tests? #f))
    
    (propagated-inputs `(("python-ply" ,python-ply)("python-plumbum" ,python-plumbum)))
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
        ("python-testpath" ,python-testpath)
        ("python-pandoc" ,python-pandoc)))
    (home-page "https://github.com/ahrenberg/nbcorg")
    (synopsis "An nbconvert orgmode-exporter")
    (description "An nbconvert orgmode-exporter")
    (license license:expat)))
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
   (license license:expat)))

(define-public python-pygments-github-lexers
  (package
    (name "python-pygments-github-lexers")
    (version "0.0.5")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pygments-github-lexers" version))
        (sha256
          (base32
            "0cz14clcc9z4pn79ll8hp3xzgsrfjscak5zfsvlgrz6ngkkmgjma"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-pygments" ,python-pygments)))
    (home-page
      "https://github.com/liluo/pygments-github-lexers")
    (synopsis "Pygments Github custom lexers.")
    (description "Pygments Github custom lexers.")
    (license license:bsd-3)))

(define-public python-sphinxcontrib-github-alt
  (package
    (name "python-sphinxcontrib-github-alt")
    (version "1.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "sphinxcontrib_github_alt" version))
        (sha256
          (base32
            "1x9af78vamjjcdrrhiah3wg613jv7gm8yh9vvqfrmf4vam6mimyg"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-docutils" ,python-docutils)
        ("python-sphinx" ,python-sphinx)))
    (home-page
      "https://github.com/jupyter/sphinxcontrib_github_alt")
    (synopsis
      "Link to GitHub issues, pull requests, commits and users from Sphinx docs.")
    (description
      "Link to GitHub issues, pull requests, commits and users from Sphinx docs.")
    (license #f)))

(define-public python-zipfile36
  (package
    (name "python-zipfile36")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "zipfile36" version))
        (sha256
          (base32
            "1bdf4bqj6h4h3inak9mp6csf4f3mrvy6zxrxwxzly4gsykfqv2m7"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f))
    ;; Fails with: File "/tmp/guix-build-python-zipfile36-0.1.3.drv-0/zipfile36-0.1.3/test/badsyntax_3131.py", line 2
    ;;     € = 2
    ;;     ^
    ;; SyntaxError: invalid character in identifier
    ;; command "python" "-c" "import setuptools, tokenize;__file__='setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\\r\\n', '\\n');f.close();exec(compile(code, __file__, 'exec'))" "test" failed with status 1
    (home-page
      "https://gitlab.com/takluyver/zipfile36")
    (synopsis
      "Read and write ZIP files - backport of the zipfile module from Python 3.6")
    (description
      "Read and write ZIP files - backport of the zipfile module from Python 3.6")
    (license #f)))

(define-public python-pytoml
  (package
    (name "python-pytoml")
    (version "0.1.21")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pytoml" version))
        (sha256
          (base32
            "1rv1byiw82k7mj6aprcrqi2vdabs801y97xhfnrz7kxds34ggv4f"))))
    (build-system python-build-system)
    (home-page "https://github.com/avakar/pytoml")
    (synopsis "A parser for TOML-0.4.0")
    (description "A parser for TOML-0.4.0")
    (license license:expat)))

(define-public python-flit-core
  (package
    (name "python-flit-core")
    (version "3.0.0")
    (source
      (origin
        (method url-fetch)
        ;;(uri (pypi-uri "flit-core" version))
        (uri "https://files.pythonhosted.org/packages/0e/b9/040baf94b40c80081bbecbd90365a5d7765a1c07e31b6c949838cc4c93d1/flit_core-3.0.0.tar.gz")
        (sha256
          (base32
            "0bbw84r33gwi0xyp7m8dzp2dzpjs4harj3l5wrbxkmp2awh0ard4"))))
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
               (copy-recursively "." dir)
               (copy-file "PKG-INFO" (string-append dir "/flit_core/PKG-INFO"))
               (copy-file "pyproject.toml" (string-append dir "/flit_core/pyproject.toml"))
               (delete-file (string-append dir "/PKG-INFO"))
               (delete-file (string-append dir "/pyproject.toml"))
               ;;(invoke "touch" (string-append dir "/__init__.py"))
               ;;(copy-file "unpyc3.py" (string-append dir "/unpyc3.py"))
               )               
             #t))
         (delete 'check)
         (delete 'test)
         )))
    
    (propagated-inputs
      `(("python-pytoml" ,python-pytoml)))
    (home-page "https://github.com/takluyver/flit")
    (synopsis
      "Distribution-building parts of Flit. See flit package for more information")
    (description
      "Distribution-building parts of Flit. See flit package for more information")
    (license #f)))

(define-public python-flit
  (package
    (name "python-flit")
    (version "3.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flit" version))
       (sha256
        (base32
         "14q8qa48bli2mniznc8b54qkwvhbik4kw99y01fi5gzzl620zzml"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f))
    ;; (arguments
    ;;  '(#:phases
    ;;    (modify-phases %standard-phases
    ;;      (replace 'check
    ;;        (lambda* (#:key inputs outputs #:allow-other-keys)
    ;;          (add-installed-pythonpath inputs outputs)
    ;;          ;; ============= 20 failed, 110 passed, 2 skipped, 1 warning in 4.47s =============
    ;;          (invoke "pytest"))))))

    (propagated-inputs
      `(("python-docutils" ,python-docutils)
        ("python-flit-core" ,python-flit-core)
        ("python-pygments-github-lexers"
         ,python-pygments-github-lexers)
        ("python-pytest" ,python-pytest)
        ("python-pytest-cov" ,python-pytest-cov)
        ("python-pytoml" ,python-pytoml)
        ("python-requests" ,python-requests)
        ("python-responses" ,python-responses)
        ("python-sphinx" ,python-sphinx)
        ("python-sphinxcontrib-github-alt"
         ,python-sphinxcontrib-github-alt)
        ("python-testpath" ,python-testpath)
        ("python-zipfile36" ,python-zipfile36)))
    (home-page "https://github.com/takluyver/flit")
    (synopsis
      "A simple packaging tool for simple packages.")
    (description
      "A simple packaging tool for simple packages.")
    (license #f)))

;; from here down there are additional packages for the sake of python-flask-rest-jsonapi

(define-public python-pre-commit
  (package
    (name "python-pre-commit")
    (version "2.8.2")
    (source
     (origin
       (method url-fetch)
       (uri "https://files.pythonhosted.org/packages/48/15/c65d94201c865857570286ab272212655ce5b601246c10ef2b39742f6109/pre_commit-2.8.2.tar.gz")
       (sha256
        (base32
         "1rkaiddmlpwqabvgg41bgyi6nq6hy8ql94vyr2p1p6abafdvqplh"))))
    (build-system python-build-system)
    ;; AttributeError: module 'pre_commit.resources' has no attribute 'empty_template_setup'
    (arguments '(#:tests? #f))
    (propagated-inputs
      `(("python-cfgv" ,python-cfgv)
        ("python-identify" ,python-identify)
        ("python-importlib-metadata"
         ,python-importlib-metadata)
        ("python-importlib-resources"
         ,python-importlib-resources)
        ("python-nodeenv" ,python-nodeenv)
        ("python-pyyaml" ,python-pyyaml)
        ("python-toml" ,python-toml)
        ("python-virtualenv" ,python-virtualenv)))
    (home-page
     "https://github.com/pre-commit/pre-commit")
    (synopsis
     "A framework for managing and maintaining multi-language pre-commit hooks.")
    (description
     "A framework for managing and maintaining multi-language pre-commit hooks.")
  (license license:expat)))

(define-public python-marshmallow-jsonapi
  (package
    (name "python-marshmallow-jsonapi")
    (version "0.23.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "marshmallow-jsonapi" version))
        (sha256
          (base32
            "14zzzhpfz7pyc65nnzwzr0mh6c68zzhv810bv6vj3by485vzbfy5"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-marshmallow" ,python-marshmallow-3.2)))
    (native-inputs
      `(("python-faker" ,python-faker)
        ("python-flake8" ,python-flake8)
        ("python-flake8-bugbear" ,python-flake8-bugbear)
        ("python-flask" ,python-flask)
        ("python-mock" ,python-mock)
        ("python-pre-commit" ,python-pre-commit)
        ("python-pytest" ,python-pytest)
        ("python-tox" ,python-tox)))
    (home-page
      "https://github.com/marshmallow-code/marshmallow-jsonapi")
    (synopsis
      "JSON API 1.0 (https://jsonapi.org) formatting with marshmallow")
    (description
      "JSON API 1.0 (https://jsonapi.org) formatting with marshmallow")
    (license license:expat)))

;; since we need a more recent python-marshmallow to satisfy python-flask-rest-jsonapi
;; to let python-flask-rest-jsonapi and python-marshmallow-jsonapi both be installed (need the same version of python-marshmallow-jsonapi)

;; (define-public python-marshmallow
;;   (package
;;     (name "python-marshmallow")
;;     (version "3.0.0b14")
;;     (source
;;      (origin
;;       (method url-fetch)
;;       (uri (pypi-uri "marshmallow" version))
;;       (sha256
;;        (base32
;;         "1digk3f5cfk7wmlka65mc7bzsd96pbsgcsvp6pimd5b4ff9zb5p3"))))
;;     (build-system python-build-system)
;;     (propagated-inputs
;;      `(("python-dateutil" ,python-dateutil)
;;        ("python-simplejson" ,python-simplejson)))
;;     (native-inputs
;;      `(("python-pytest" ,python-pytest)
;;        ("python-pytz" ,python-pytz)))
;;     (home-page "https://github.com/marshmallow-code/marshmallow")
;;     (synopsis "Convert complex datatypes to and from native
;; Python datatypes.")
;;     (description "@code{marshmallow} provides a library for converting
;; complex datatypes to and from native Python datatypes.")
;;     (license license:expat)))

(define-public python-marshmallow
  (package
    (name "python-marshmallow")
    (version "3.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "marshmallow" version))
       (sha256
        (base32
         "012xqn9q1m4wvq4sg73m20ahbkhg0hbgz74n61irigi7yz56mbcp"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-flake8" ,python-flake8)
       ("python-flake8-bugbear" ,python-flake8-bugbear)
       ("python-mypy" ,python-mypy)
      ("python-pre-commit" ,python-pre-commit)
      ("python-pytest" ,python-pytest)
      ("python-pytz" ,python-pytz)
      ("python-simplejson" ,python-simplejson)
      ("python-tox" ,python-tox)))
    (home-page
     "https://github.com/marshmallow-code/marshmallow")
    (synopsis
     "A lightweight library for converting complex datatypes to and from native Python datatypes.")
  (description
   "A lightweight library for converting complex datatypes to and from native Python datatypes.")
  (license license:expat)))

;; python-flask-combo-jsonapi needs ==3.2.1
(define-public python-marshmallow-3.2
  (package
    (name "python-marshmallow")
    (version "3.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "marshmallow" version))
       (sha256
        (base32
         "1w18klwj0z9bqxj252qpj1hz8l46nl27sbc89rkajc7mln73wbws"))))
    (build-system python-build-system)
    (native-inputs
     `(("python-flake8" ,python-flake8)
       ("python-flake8-bugbear" ,python-flake8-bugbear)
       ("python-mypy" ,python-mypy)
      ("python-pre-commit" ,python-pre-commit)
      ("python-pytest" ,python-pytest)
      ("python-pytz" ,python-pytz)
      ("python-simplejson" ,python-simplejson)
      ("python-tox" ,python-tox)))
    (home-page
     "https://github.com/marshmallow-code/marshmallow")
    (synopsis
     "A lightweight library for converting complex datatypes to and from native Python datatypes.")
  (description
   "A lightweight library for converting complex datatypes to and from native Python datatypes.")
  (license license:expat)))

(define-public python-flask-rest-jsonapi
  (package
    (name "python-flask-rest-jsonapi")
    (version "0.31.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "Flask-REST-JSONAPI" version))
        (sha256
          (base32
            "10lyradvlmzyay9qjwp93jvn808fn7rxms5ciad64xaxnxmd3qb7"))))
    (build-system python-build-system)
    ;; some tests are failing at the end
    (arguments '(#:tests? #f))
    (propagated-inputs
      `(("python-flask" ,python-flask)
        ("python-marshmallow" ,python-marshmallow-3.2)
        ("python-marshmallow-jsonapi"
         ,python-marshmallow-jsonapi)
        ("python-six" ,python-six)
        ("python-sqlalchemy" ,python-sqlalchemy)))
    (native-inputs
      `(("python-coverage" ,python-coverage)
        ("python-coveralls" ,python-coveralls)
        ;; added after failed test
        ("python-pytest-runner" ,python-pytest-runner)
        ("python-pytest" ,python-pytest)))
    (home-page
      "https://github.com/miLibris/flask-rest-jsonapi")
    (synopsis
      "Flask extension to create REST web api according to JSONAPI 1.0 specification with Flask, Marshmallow                  and data provider of your choice (SQLAlchemy, MongoDB, ...)")
    (description
      "Flask extension to create REST web api according to JSONAPI 1.0 specification with Flask, Marshmallow                  and data provider of your choice (SQLAlchemy, MongoDB, ...)")
    (license license:expat)))

(define-public python-flask-combo-jsonapi
  (package
    (name "python-flask-combo-jsonapi")
    (version "1.0.5")
    (source
      (origin
        ;; (method url-fetch)
        ;; (uri (string-append "https://github.com/AdCombo/flask-combo-jsonapi/archive/" version ".tar.gz"))
        ;; (sha256
        ;;   (base32
        ;;     "12iylwwnli5gfxy05jng1s8w6plh2025wghbqbap88cdcabskm54"))))
       (method git-fetch)
       (uri (git-reference
             ;;(commit "ba69aea83de7784a1aa5536357c18fde6d4211cc")
             (commit "35a5e35de8c94fd5d9d24492c8b00f6cb2ea5e4a")
	     (url "https://github.com/methuselah-0/flask-combo-jsonapi.git")))
       (sha256
        (base32
	 ;;"1rbk0nrdkclq7ipbzjr7hvvhd6vpsn91zfgy5s9sz45qcyfgmmrf"
         "1cchnhb50fciic4kgipdrc201c8l38wf5066lkdjd3mk25awvf26"
         ))))
    (build-system python-build-system)
    ;; some tests are failing at the end
    (arguments '(#:tests? #f))
    (propagated-inputs
      `(("python-flask" ,python-flask)
        ("python-marshmallow" ,python-marshmallow-3.2)
        ("python-marshmallow-jsonapi"
         ,python-marshmallow-jsonapi-22)
        ("python-apispec" ,python-apispec-4.0)
        ("python-simplejson" ,python-simplejson)        
        ("python-six" ,python-six)
        ("python-sqlalchemy" ,python-sqlalchemy)))
    (native-inputs
      `(("python-coverage" ,python-coverage)
        ("python-coveralls" ,python-coveralls)
        ;; added after failed test
        ("python-pytest-runner" ,python-pytest-runner)
        ("python-pytest" ,python-pytest)))
    (home-page
      "https://github.com/AdCombo/flask-combo-jsonapi")
    (synopsis
      "Flask extension to create REST web api according to JSONAPI 1.0 specification with Flask, Marshmallow and data provider of your choice (SQLAlchemy, MongoDB, ...)")
    (description
      "Flask extension to create REST web api according to JSONAPI 1.0 specification with Flask, Marshmallow and data provider of your choice (SQLAlchemy, MongoDB, ...)")
    (license license:expat)))

;; python-flask-combo-jsonapi requires marshmallow-jsonapi==0.22.0
(define-public python-marshmallow-jsonapi-22
(package
  (name "python-marshmallow-jsonapi")
  (version "0.22.0")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "marshmallow-jsonapi" version))
      (sha256
        (base32
          "0rfnagv76f0pwvdcc0604r78nphi7a7b6d5fjga2va522lydah27"))))
  (build-system python-build-system)
  (propagated-inputs
    `(("python-marshmallow" ,python-marshmallow-3.2)))
  (native-inputs
    `(("python-faker" ,python-faker)
      ("python-flake8" ,python-flake8)
      ("python-flake8-bugbear" ,python-flake8-bugbear)
      ("python-flask" ,python-flask)
      ("python-mock" ,python-mock)
      ("python-pre-commit" ,python-pre-commit)
      ("python-pytest" ,python-pytest)
      ("python-tox" ,python-tox)))
  (home-page
    "https://github.com/marshmallow-code/marshmallow-jsonapi")
  (synopsis
    "JSON API 1.0 (https://jsonapi.org) formatting with marshmallow")
  (description
    "JSON API 1.0 (https://jsonapi.org) formatting with marshmallow")
  (license license:expat)))

(define-public python-apispec-4.0
  (package
   (name "python-apispec")
   (version "4.0.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "apispec" version))
     (sha256
      (base32
       "12n4w5zkn4drcn8izq68vmixmqvz6abviqkdn4ip0kaax3jjh3in"))))
   (build-system python-build-system)
   (native-inputs
    `(("python-flake8" ,python-flake8)
      ("python-flake8-bugbear" ,python-flake8-bugbear)
      ("python-marshmallow" ,python-marshmallow)
      ("python-mock" ,python-mock)
      ("python-prance" ,python-prance)
      ("python-pre-commit" ,python-pre-commit)
      ("python-pytest" ,python-pytest)
      ("python-pyyaml" ,python-pyyaml)
      ("python-tox" ,python-tox)))
   (home-page
    "https://github.com/marshmallow-code/apispec")
   (synopsis
    "A pluggable API specification generator. Currently supports the OpenAPI Specification (f.k.a. the Swagger specification).")
   (description
    "A pluggable API specification generator. Currently supports the OpenAPI Specification (f.k.a. the Swagger specification).")
   (license license:expat)))
(define-public python-towncrier
  (package
    (name "python-towncrier")
    (version "19.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "towncrier" version))
        (sha256
          (base32
            "15l1gb0hhi9pf3mhhb9vpc93w6w3hrih2ljmzbkgfb3dwqd1l9a8"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-click" ,python-click)
        ("python-incremental" ,python-incremental)
        ("python-jinja2" ,python-jinja2)
        ("python-toml" ,python-toml)))
    (home-page
      "https://github.com/hawkowl/towncrier")
    (synopsis "Building newsfiles for your project.")
    (description
      "Building newsfiles for your project.")
    (license license:expat)))

(define-public python-flake8-docstrings
  (package
    (name "python-flake8-docstrings")
    (version "1.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "flake8-docstrings" version))
        (sha256
          (base32
            "05rpdydx1wdpfm4vpqmwq130ljmrjg17xa06cpm6fwvbxk3k2nix"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-flake8" ,python-flake8)
        ("python-pydocstyle" ,python-pydocstyle)))
    (home-page
      "https://gitlab.com/pycqa/flake8-docstrings")
    (synopsis
      "Extension for flake8 which uses pydocstyle to check docstrings")
    (description
      "Extension for flake8 which uses pydocstyle to check docstrings")
    (license license:expat)))

(define-public python-flake8-quotes
  (package
    (name "python-flake8-quotes")
    (version "3.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "flake8-quotes" version))
        (sha256
          (base32
            "0ph5s6lxgpzz4an0ax6s5xjqypqmngwr5b1i0h9pqhzghplic49z"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-flake8" ,python-flake8)))
    (home-page
      "http://github.com/zheller/flake8-quotes/")
    (synopsis "Flake8 lint for quotes.")
    (description "Flake8 lint for quotes.")
    (license license:expat)))

(define-public python-flake8-polyfill
  (package
    (name "python-flake8-polyfill")
    (version "1.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flake8-polyfill" version))
       (sha256
        (base32
         "1nlf1mkqw856vi6782qcglqhaacb23khk9wkcgn55npnjxshhjz4"))
       (patches (search-patches "python-flake8-polyfill-flake8-4-compat.patch"))))
    (build-system python-build-system)
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             ;; Be compatible with Pytest 4:
             ;; https://gitlab.com/pycqa/flake8-polyfill/merge_requests/7
             (substitute* "setup.cfg"
               (("\\[pytest\\]")
                "[tool:pytest]"))
             (when tests?
               (invoke "py.test" "-v")))))))
    (propagated-inputs
     (list python-flake8))
    (native-inputs
     (list python-mock python-pep8 python-pycodestyle python-pytest))
    (home-page "https://github.com/pycqa/flake8-polyfill")
    (synopsis "Polyfill package for Flake8 plugins")
    (description
     "This package that provides some compatibility helpers for Flake8
plugins that intend to support Flake8 2.x and 3.x simultaneously.")
    (license license:expat)))

;; (define-public python2-vobject
;;   (package
;;     (inherit (package-with-python2
;;               (strip-python2-variant python-vobject)))
;;     (native-inputs `(("python2-setuptools" ,python2-setuptools)))))
;; (define-public python2-vobject
;;   (package-with-python2 python-vobject))

;; (define-public python2-dateutil
;;   (package
;;     (name "python2-dateutil")
;;     (version "2.8.2")
;;     (source
;;      (origin
;;        (method url-fetch)
;;        (uri (pypi-uri "python-dateutil" version))
;;        (sha256
;;         (base32
;;          "11iy7m4bp2lgfkcl0r6xzf34bvk7ppjmsyn2ygfikbi72v6cl8q1"))))
;;     (build-system python-build-system)
;;     (arguments
;;      `(#:python ,python-2
;;        #:phases (modify-phases %standard-phases
;;                   (replace 'check
;;                     (lambda _
;;                       ;; Delete tests that depend on "freezegun" to avoid a
;;                       ;; circular dependency.
;;                       (delete-file "dateutil/test/test_utils.py")
;;                       (delete-file "dateutil/test/test_rrule.py")

;;                       ;; XXX: Fails to get timezone from /etc/localtime.
;;                       (delete-file "dateutil/test/test_tz.py")

;;                       (invoke "pytest" "-vv"))))))
;;     (native-inputs
;;      (list python2-pytest python2-pytest-cov python2-setuptools-scm))
;;     (propagated-inputs
;;      (list python2-six))
;;     (home-page "https://dateutil.readthedocs.io/en/stable/")
;;     (synopsis "Extensions to the standard datetime module")
;;     (description
;;      "The dateutil module provides powerful extensions to the standard
;; datetime module, available in Python 2.3+.")
;;     ;; The license was changed from the three-clause BSD license to a dual
;;     ;; Apache 2.0/BSD-3 variant at 2017-12-01.  Some code is only available as
;;     ;; BSD-3 still; but all new code is dual licensed (the user can choose).
;;     (license (list license:bsd-3 license:asl2.0))))

(define-public python-pep8-naming
  (package
    (name "python-pep8-naming")
    (version "0.11.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pep8-naming" version))
        (sha256
          (base32
            "0937rnk3c2z1jkdmbw9hfm80p5k467q7rqhn6slfiprs4kflgpd1"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f))
    (propagated-inputs
      `(("python-flake8-polyfill"
         ,python-flake8-polyfill)
        ;; added python-flak8 to fix tests
        ("python-flake8"
         ,python-flake8)))
    (home-page
      "https://github.com/PyCQA/pep8-naming")
    (synopsis
      "Check PEP-8 naming conventions, plugin for flake8")
    (description
      "Check PEP-8 naming conventions, plugin for flake8")
    (license license:expat)))
(define-public python-semver-2.13
 (package
  (name "python-semver")
  (version "2.13.0")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "semver" version))
      (sha256
        (base32
          "0gsyyzvhz60c03wvsk16z1564bxflp1j1227mizgbhz15rrf43zs"))))
  (build-system python-build-system)
  (arguments '(#:tests? #f))
  ;; to fix tests we need virtualenv and python-tox, but we can't
  ;; install all python versions anyway, so disabling tests instead.
  ;; (propagated-inputs
  ;;    `(("python-virtualenv" ,python-virtualenv)
  ;;      ("python-tox" ,python-tox)))
  (home-page
    "https://github.com/python-semver/python-semver")
  (synopsis
    "Python helper for Semantic Versioning (http://semver.org/)")
  (description
    "Python helper for Semantic Versioning (http://semver.org/)")
  (license license:bsd-3)))

(define-public python-prance
  (package
    (name "python-prance")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "prance" version))
        (sha256
          (base32
            "0ffpfny3z8v3g0drirm27qafafbbvbc4h5k8v7yiwirnh0vn9v46"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f))
    (propagated-inputs
      `(("python-chardet" ,python-chardet)
        ("python-pyyaml" ,python-pyyaml-5)
        ("python-requests" ,python-requests)
        ("python-semver" ,python-semver-2.13)
        ("python-six" ,python-six)))
    (native-inputs
      `(("python-bumpversion" ,python-bumpversion)
        ("python-flake8" ,python-flake8)
        ("python-flake8-docstrings"
         ,python-flake8-docstrings)
        ("python-flake8-quotes" ,python-flake8-quotes)
        ;;("python-pep8-naming" ,python-pep8-naming)
        ;; to fix tests we add python-pytest-runner, however it still doesn't work so disabling tests.
        ("python-pytest-runner" ,python-pytest-runner)
        ("python-pytest" ,python-pytest)
        ("python-pytest-cov" ,python-pytest-cov)
        ("python-sphinx" ,python-sphinx)
        ("python-towncrier" ,python-towncrier)
        ("python-tox" ,python-tox)))
    (home-page
      "https://github.com/jfinkhaeuser/prance")
    (synopsis
      "Resolving Swagger/OpenAPI 2.0 and 3.0.0 Parser")
    (description
      "Resolving Swagger/OpenAPI 2.0 and 3.0.0 Parser")
    (license #f)))

(define-public python-apispec
  (package
    (name "python-apispec")
    (version "4.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "apispec" version))
        (sha256
          (base32
            "12n4w5zkn4drcn8izq68vmixmqvz6abviqkdn4ip0kaax3jjh3in"))))
    (build-system python-build-system)
    (native-inputs
      `(("python-flake8" ,python-flake8)
        ("python-flake8-bugbear" ,python-flake8-bugbear)
        ("python-marshmallow" ,python-marshmallow)
        ("python-mock" ,python-mock)
        ("python-prance" ,python-prance)
        ("python-pre-commit" ,python-pre-commit)
        ("python-pytest" ,python-pytest)
        ("python-pyyaml" ,python-pyyaml)
        ("python-tox" ,python-tox)))
    (home-page
      "https://github.com/marshmallow-code/apispec")
    (synopsis
      "A pluggable API specification generator. Currently supports the OpenAPI Specification (f.k.a. the Swagger specification).")
    (description
      "A pluggable API specification generator. Currently supports the OpenAPI Specification (f.k.a. the Swagger specification).")
    (license license:expat)))
(define-public python-mysqlclient
  (package
    (name "python-mysqlclient")
    (version "2.0.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "mysqlclient" version))
       (sha256
        (base32
         "0cn4lw40z1piqab27r4sb9x9y8z67v6mcv71xyp5n5cg01yfmszn"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f))          ;XXX: requires a live database
    (inputs
     `(("mysql-dev" ,mariadb "dev")))
    (home-page "https://github.com/PyMySQL/mysqlclient-python")
    (synopsis "MySQLdb is an interface to the popular MySQL database server for Python")
    (description "MySQLdb is an interface to the popular MySQL database server
for Python.  The design goals are:
@enumerate
@item Compliance with Python database API version 2.0 [PEP-0249],
@item Thread-safety,
@item Thread-friendliness (threads will not block each other).
@end enumerate")
    (license license:gpl2)))

;;python-nbcorg
;;python-pandoc
;;python-pydotplus
;;python-nbdev-org-babel
;;jupyter-next
;;python-nbconvert-5.6.1
;;python-defusedxml
;;python-testpath-0.4.4
;;python-trepan3k
;; should load uncompyl6 which should load unpyc3
;;python-nbcorg
;;python-unpyc3
;;python-bash_kernel
;; python-flit-packages below
;;python-pygments-github-lexers ;; OK!
;;python-zipfile36 ;; OK!
;;python-sphinxcontrib-github-alt ;; OK!
;;python-pytoml ;; OK!
;;python-flit-core ;; OK! BUT PROBABLY NOT INSTALLED CORRECTLY!
;;python-flit ;; NOT OK to run!
;;python-testpath-flit
;;python-flask-rest-jsonapi
;;python-marshmallow-jsonapi
;;python-flask-combo-jsonapi
;;python-apispec-4.0
;;python-marshmallow-jsonapi-22
;;python-marshmallow-3.2
;; python-mysqlclient
;;python-prance
;;python-xdis
;;python-uncompyle6
;;python-pyficache
;;python-notebook-next
;;python-pep8-naming
;;python2-vobject
;;python2-dateutil
;;python-jinja2-3.0

