(define-module (python-extras)
  #:use-module (gnu packages) ;; because of complaints in /var/log/cuirass/evaluations/1.gz
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages python-xyz)
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
       ("python-testpath" ,python-testpath-0.4.4)
       ))
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
   (version "0.2.18")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (commit "0a6ed44d953f231b1ec5e5e27712a49d7d6626f6")
	   (url "https://github.com/methuselah-0/nbdev-org-babel.git")))
     (sha256
      (base32
       "1k08baqddhar3qkm75rg39cg9h6v9vf5dy8c3iy1rb2sv7v3yk9z"))))
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
      ;; since we don't have python-testpath properly packaged, we need to add this stupid thing:
      ("python-pip" ,python-pip)      
      ;; to be able to run make docs_serve which starts the jekyll website you need bundler and jekyll, but instead we need to install them via ruby's gem
      ;;("bundler" ,bundler)
      ;;("jekyll" ,jekyll)
      ("ruby" ,ruby)
      ;; libffi is needed for jekyll that gets installed via bundler and Gemfile in the nbdev docs folder
      ("libffi" ,libffi)
      ("python-pyyaml" ,python-pyyaml)))
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
       ("python-prompt-toolkit" ,python-prompt-toolkit-2)
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
    (license license:expat)))

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
        ("python-testpath" ,python-testpath-0.4.4)
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
      `(("python-marshmallow" ,python-marshmallow)))
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
        ("python-marshmallow" ,python-marshmallow)
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

