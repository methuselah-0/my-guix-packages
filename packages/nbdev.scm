(define-module (nbdev)
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
  #:use-module (gnu packages flex)
  #:use-module (gnu packages python) ;; python-testpath to figure out python version, ;; because of complaints in /var/log/cuirass/evaluations/1.gz
  #:use-module (gnu packages check) ;; python-pytest
  #:use-module (gnu packages monitoring) ;; python-prometheus-client
  #:use-module (gnu packages xml) ;; python-defusedxml
  #:use-module (gnu packages python-web) ;; python-terminado
  #:use-module (gnu packages linux)
  #:use-module (gnu packages serialization) ;; python-sphinx  
  #:use-module (gnu packages sphinx) ;; python-sphinx
  #:use-module (gnu packages textutils) ;; python-pandocfilters
  #:use-module (gnu packages python-crypto) ;; python-certifi
  #:use-module (guix build-system python)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages markup)
  #:use-module (gnu packages jupyter)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages moreutils)
  #:use-module (gnu packages python-science)
  #:use-module (bash-coding-utils)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages libffi)
  ;;#:use-module (bcu-channel python-extras-2)
  #:use-module ((guix licenses) #:prefix license:))

(define python-tornado python-tornado-6)
(define-public python-nbdev
  (package
  (name "python-nbdev")
  (version "2.3.7")
  (source (origin
            (method url-fetch)
            (uri (pypi-uri "nbdev" version))
            (sha256
             (base32
              "0w8qgnqiqd9ry1cpvmfgyn3h1sp01dk3ryr5lfsx230zm8qimy84"))))
  (build-system python-build-system)
  (propagated-inputs (list python-asttokens
                           python-astunparse
                           python-execnb
                           python-fastcore
                           python-ghapi
                           python-pyyaml
                           python-watchdog))
  (native-inputs (list python-black
                       jupyter
                       python-matplotlib
                       python-nbdev-numpy
                       python-nbdev-stdlib
                       python-pandas
                       python-svg.py))
  (home-page "https://github.com/fastai/nbdev")
  (synopsis "Create delightful software with Jupyter Notebooks")
  (description "Create delightful software with Jupyter Notebooks")
  (license #f)))
(define-public python-execnb
  (package
   (name "python-execnb")
   (version "0.1.4")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "execnb" version))
            (sha256
             (base32
              "1w06jbdrpmv0b3hbfk2z22q36nnfmk207nx1wwhmpw206azi5n6b"))))
   (build-system python-build-system)
   (propagated-inputs (list python-fastcore python-ipython))
   (native-inputs (list python-matplotlib python-pillow))
   (home-page "https://github.com/fastai/execnb/tree/master/")
   (synopsis "A description of your project")
   (description "This package provides a description of your project")
   (license #f)))
(define-public python-fastcore
  (package
   (name "python-fastcore")
   (version "1.5.27")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "fastcore" version))
            (sha256
             (base32
              "0wgjxvqky33710y50477q5369pdwv73sz6wr4lg2a5wxaqsnpdn6"))))
   (build-system python-build-system)
   (propagated-inputs (list python-packaging python-pip))
   (native-inputs (list ;;python-jupyterlab
                        jupyter
                        python-matplotlib
                        ;;python-nbdev ;; should not be needed
                        python-numpy
                        python-pandas
                        python-pillow
                        python-pytorch))
   (home-page "https://github.com/fastai/fastcore/")
   (synopsis "Python supercharged for fastai development")
   (description "Python supercharged for fastai development")
   (license #f)))
(define-public python-ghapi
  (package
   (name "python-ghapi")
   (version "1.0.3")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "ghapi" version))
            (sha256
             (base32
              "004grr15hjshwvlzhr8wmj7mpjsz8hqaj27agcj1n9hj5hx4810q"))))
   (build-system python-build-system)
   (propagated-inputs (list python-fastcore python-packaging python-pip))
   (native-inputs (list python-jsonref python-matplotlib))
   (home-page "https://github.com/fastai/ghapi")
   (synopsis "A python client for the GitHub API")
   (description "This package provides a python client for the GitHub API")
   (license #f)))

(define-public python-nbdev-numpy
  (package
   (name "python-nbdev-numpy")
   (version "0.0.330")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "nbdev-numpy" version))
            (sha256
             (base32
              "1vj8wz2hwrgap79xix3z133vsl91fc1py1hln8rlw9p3d5sz5hfy"))))
   (build-system python-build-system)
   (propagated-inputs (list python-packaging python-pip python-wheel))
   (home-page "https://github.com/fastai/nbdev-index/tree/master/")
   (synopsis "nbdev docs lookup for numpy")
   (description "nbdev docs lookup for numpy")
   (license #f)))
(define-public python-nbdev-stdlib
  (package
   (name "python-nbdev-stdlib")
   (version "0.0.347")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "nbdev-stdlib" version))
            (sha256
             (base32
              "04wkw172xggqs3i17syqw7927f6l0l5jd8747gffbjcnpgxd3c4d"))))
   (build-system python-build-system)
   (propagated-inputs (list python-packaging python-pip python-wheel))
   (home-page "https://github.com/fastai/nbdev-index/tree/master/")
   (synopsis "nbdev docs lookup for the python standard library")
   (description "nbdev docs lookup for the python standard library")
   (license #f)))

(define-public python-svg.py
  (package
    (name "python-svg.py")
    (version "1.4.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "svg.py" version))
              (sha256
               (base32
                "0149m9qdk274knpz80vdj3adp9mbr27gr0ihwffqlxi9h9rpj6gr"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda _
                      (invoke "flit" "build")))
                  (replace 'install
                    (lambda* (#:key inputs outputs #:allow-other-keys)
                      (add-installed-pythonpath inputs outputs)
                      (let ((out (assoc-ref outputs "out")))
                        (for-each (lambda (wheel)
                                    (format #true wheel)
                                    (invoke "python" "-m" "pip" "install"
                                            wheel (string-append "--prefix=" out)))
                                  (find-files "dist" "\\.whl$"))))))))
    (native-inputs (list python-flit python-flit-core))

    (home-page "https://github.com/orsinium-labs/svg")
    (synopsis "SVG drawing library")
    (description "SVG drawing library")
    (license license:expat)))

(define-public python-jupyterlab
  (package
   (name "python-jupyterlab")
   (version "3.4.7")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "jupyterlab" version))
            (sha256
             (base32
              "07ii4mpf2j3lns2hszxnn42b20yx2c06xwnz47lz4fhfk2q8mi2d"))))
   (build-system python-build-system)
   (arguments '(#:tests? #f)) ;; recommendation is to use tox
   (propagated-inputs (list python-ipython
                            python-jinja2
                            python-jupyter-core
                            python-jupyter-server
                            python-jupyterlab-server
                            python-nbclassic
                            python-notebook
                            python-packaging
                            python-tomli
                            python-tornado-6))
   (native-inputs (list ;;python-build
                        python-check-manifest
                        python-coverage
                        python-jupyterlab-server
                        python-pre-commit
                        python-pytest
                        python-pytest-check-links
                        python-pytest-console-scripts
                        python-pytest-cov
                        ;;python-tox
                        python-requests
                        ;;python-requests-cache ;; only a docs dependency?
                        python-virtualenv))
   (home-page "https://jupyter.org")
   (synopsis "JupyterLab computational environment")
   (description "JupyterLab computational environment")
   (license #f)))

(define-public python-nbclassic
  (package
   (name "python-nbclassic")
   (version "0.4.4")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "nbclassic" version))
            (sha256
             (base32
              "1v5gh31xx6q51ncik1v4mj80n156b59rz9h2gig6zz2y5jngpi7n"))))
   (build-system python-build-system)
   (arguments
    '(#:tests? #f)) ;; 3 failures due to that the urlencode_unix_socket method doesn't exist anymore
   (propagated-inputs (list python-argon2-cffi
                            python-ipykernel
                            python-ipython-genutils
                            python-jinja2
                            python-jupyter-client
                            python-jupyter-core
                            python-jupyterhub
                            python-jupyter-server
                            python-nbconvert
                            python-nbformat
                            python-nest-asyncio
                            python-notebook-shim
                            python-prometheus-client
                            python-pyzmq
                            python-send2trash
                            python-terminado
                            python-tornado-6
                            python-traitlets))
   (native-inputs (list python-coverage
                        python-nbval
                        python-pytest
                        python-pytest-cov
                        python-pytest-tornasync
                        python-requests
                        python-requests-unixsocket
                        python-selenium
                        python-testpath))
   (home-page "http://jupyter.org")
   (synopsis "A web-based notebook environment for interactive computing")
   (description
    "This package provides a web-based notebook environment for interactive computing")
   (license license:bsd-3)))

(define-public python-appdirs
  (package
    (name "python-appdirs")
    (version "1.4.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "appdirs" version))
       (sha256
        (base32
         "0hfzmwknxqhg20aj83fx80vna74xfimg8sk18wb85fmin9kh2pbx"))))
    (build-system python-build-system)
    (home-page "https://github.com/ActiveState/appdirs")
    (synopsis
     "Determine platform-specific dirs, e.g. a \"user data dir\"")
    (description
     "This module provides a portable way of finding out where user data
should be stored on various operating systems.")
    (license license:expat)))

(define-public python-requests-cache
  (package
    (name "python-requests-cache")
    ;;    (version "0.9.0")
    ;; d68abdda316b19a37c6217f38b098f0e811d6e15
    (version "d68abdda316b19a37c6217f38b098f0e811d6e15")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/requests-cache/requests-cache")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1lv3wq2j908ygkvry2qzyv4zcxbmx4k583ba03c7p82xmn86syas"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda _
                      (invoke "flit" "build")))
                  (replace 'install
                    (lambda* (#:key inputs outputs #:allow-other-keys)
                      (add-installed-pythonpath inputs outputs)
                      (let ((out (assoc-ref outputs "out")))
                        (for-each (lambda (wheel)
                                    (format #true wheel)
                                    (invoke "python" "-m" "pip" "install"
                                            wheel (string-append "--prefix=" out)))
                                  (find-files "dist" "\\.whl$"))))))))
    (native-inputs (list python-flit python-flit-core))
    (propagated-inputs (list python-appdirs
                             python-attrs
                             python-boto3
                             python-botocore
                             python-bson
                             python-cattrs
                             ;;python-furo ;; docs dependency only
                             python-itsdangerous
                             ;;python-linkify-it-py ;; docs dependency only
                             ;;python-myst-parser ;; docs dependency only
                             python-pymongo
                             python-pyyaml
                             python-redis
                             python-requests
                             ;;python-sphinx ;; docs dependency only
                             ;;python-sphinx-autodoc-typehints ;; docs dependency only
                             ;;python-sphinx-automodapi ;; docs dependency only
                             ;;python-sphinx-copybutton ;; docs dependency only
                             ;;python-sphinx-inline-tabs ;; docs dependency only
                             ;;python-sphinx-notfound-page ;; docs dependency only
                             ;;python-sphinx-panels ;; docs dependency only
                             ;;python-sphinxcontrib-apidoc ;; docs dependency only
                             python-ujson
                             python-url-normalize
                             python-urllib3))
    (home-page "https://github.com/requests-cache/requests-cache")
    (synopsis "A transparent persistent cache for the requests library")
    (description
     "This package provides a transparent persistent cache for the requests library")
    (license license:bsd-2)))

(define-public python-furo
  (package
    (name "python-furo")
    (version "2022.9.29")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "furo" version))
              (sha256
               (base32
                "1g8d8w982d5lcx5xc0d1w8g2lvh3im7kidfyq84kcqlwc92q28yl"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda _
                      (invoke "flit" "build")))
                  (replace 'install
                    (lambda* (#:key inputs outputs #:allow-other-keys)
                      (add-installed-pythonpath inputs outputs)
                      (let ((out (assoc-ref outputs "out")))
                        (for-each (lambda (wheel)
                                    (format #true wheel)
                                    (invoke "python" "-m" "pip" "install"
                                            wheel (string-append "--prefix=" out)))
                                  (find-files "dist" "\\.whl$"))))))))
   
    (native-inputs (list python-flit python-flit-core))
    (propagated-inputs (list python-beautifulsoup4 python-pygments python-sphinx
                             python-sphinx-basic-ng))
    (home-page "")
    (synopsis "A clean customisable Sphinx documentation theme.")
    (description
     "This package provides a clean customisable Sphinx documentation theme.")
    (license #f)))

(define-public python-linkify-it-py
  (package
   (name "python-linkify-it-py")
   (version "2.0.0")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "linkify-it-py" version))
            (sha256
             (base32
              "0bxgdik69df2s6vl2zmd2i9fb0k2aravy4rqzardigh615468r27"))))
   (build-system python-build-system)
   (propagated-inputs (list python-uc-micro-py))
   (native-inputs (list python-black
                        python-coverage
                        python-flake8
                        python-isort
                        python-pre-commit
                        python-pytest
                        python-pytest-cov))
   (home-page "https://github.com/tsutsu3/linkify-it-py")
   (synopsis "Links recognition library with FULL unicode support.")
   (description "Links recognition library with FULL unicode support.")
   (license license:expat)))

(define-public python-myst-parser
  (package
   (name "python-myst-parser")
   (version "0.18.1")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "myst-parser" version))
            (sha256
             (base32
              "0v949icnl53vg920qhwa1k2djv6sl4dxmyb4dvfm6c61n95pycbr"))))
   (build-system python-build-system)
   (propagated-inputs (list python-beautifulsoup4
                            python-coverage
                            python-docutils
                            python-ipython
                            python-jinja2
                            python-linkify-it-py
                            python-markdown-it-py
                            python-mdit-py-plugins
                            python-pre-commit
                            python-pytest
                            python-pytest-cov
                            python-pytest-param-files
                            python-pytest-regressions
                            python-pyyaml
                            python-sphinx
                            python-sphinx-book-theme
                            python-sphinx-design
                            python-sphinx-pytest
                            python-sphinxcontrib-mermaid
                            python-sphinxext-opengraph
                            python-sphinxext-rediraffe
                            python-typing-extensions))
   (home-page "")
   (synopsis
    "An extended commonmark compliant parser, with bridges to docutils & sphinx.")
   (description
    "An extended commonmark compliant parser, with bridges to docutils & sphinx.")
   (license #f)))

(define-public python-sphinx-automodapi
  (package
   (name "python-sphinx-automodapi")
   (version "0.14.1")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinx-automodapi" version))
            (sha256
             (base32
              "1jdvfpgzws8vdqhb2zayy8aynx98840nrpvmvgk7a64hwbww1yd2"))))
   (build-system python-build-system)
   (propagated-inputs (list python-sphinx))
   (native-inputs (list python-codecov python-coverage python-cython
                        python-pytest python-pytest-cov))
   (home-page "https://github.com/astropy/sphinx-automodapi")
   (synopsis
    "Sphinx extension for auto-generating API documentation for entire modules")
   (description
    "Sphinx extension for auto-generating API documentation for entire modules")
   (license #f)))

(define-public python-sphinx-inline-tabs
  (package
   (name "python-sphinx-inline-tabs")
   (version "2022.1.2b11")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinx_inline_tabs" version))
            (sha256
             (base32
              "0wyx7wmq2kk97j0fw9hvcdazr241a4diin05gyqcq1gcf8ki9fdg"))))
   (build-system python-build-system)
   (propagated-inputs (list python-furo
                            python-myst-parser
                            python-pytest
                            python-pytest-cov
                            python-pytest-xdist
                            python-sphinx))
   (home-page "https://github.com/pradyunsg/sphinx-inline-tabs")
   (synopsis "Add inline tabbed content to your Sphinx documentation.")
   (description "Add inline tabbed content to your Sphinx documentation.")
   (license #f)))

(define-public python-sphinx-notfound-page
  (package
   (name "python-sphinx-notfound-page")
   (version "0.8.3")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinx-notfound-page" version))
            (sha256
             (base32
              "0cj30bjfzv2vbailhwrfb3mbj47psyzfn2sl6k188sq2h0r40a7p"))))
   (build-system python-build-system)
   (propagated-inputs (list python-sphinx
                            python-sphinx-autoapi
                            python-sphinx-notfound-page
                            python-sphinx-prompt
                            python-sphinx-rtd-theme
                            python-sphinx-tabs
                            python-sphinxemoji
                            python-tox))
   (home-page "")
   (synopsis "Sphinx extension to build a 404 page with absolute URLs")
   (description "Sphinx extension to build a 404 page with absolute URLs")
   (license #f)))

(define-public python-url-normalize
  (package
    (name "python-url-normalize")
    (version "1.4.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "url-normalize" version))
              (sha256
               (base32
                "1clrr7xc1qlxph0v90w7ag6x2246izka0n8w7aw6fan5183klgfj"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f))
    (propagated-inputs (list python-six))
    (home-page "https://github.com/niksite/url-normalize")
    (synopsis "URL normalization for Python")
    (description "URL normalization for Python")
    (license license:expat)))

(define-public python-sphinx-basic-ng
  (package
   (name "python-sphinx-basic-ng")
   (version "1.0.0b1")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinx_basic_ng" version))
            (sha256
             (base32
              "1c59nmxzqxga8lc42krd1yb9k3kir0l1wy462wq2lifrrk9lndw9"))))
   (build-system python-build-system)
   (propagated-inputs (list python-sphinx))
   (home-page "https://github.com/pradyunsg/sphinx-basic-ng")
   (synopsis "A modern skeleton for Sphinx themes.")
   (description "This package provides a modern skeleton for Sphinx themes.")
   (license #f)))
(define-public python-uc-micro-py
  (package
   (name "python-uc-micro-py")
   (version "1.0.1")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "uc-micro-py" version))
            (sha256
             (base32
              "15mmznkpks2yn2n3pgngq1i7jvzj101230iczvfl6c23g7mg9kdp"))))
   (build-system python-build-system)
   (native-inputs (list python-coverage python-pytest python-pytest-cov))
   (home-page "https://github.com/tsutsu3/uc.micro-py")
   (synopsis "Micro subset of unicode data files for linkify-it-py projects.")
   (description
    "Micro subset of unicode data files for linkify-it-py projects.")
   (license license:expat)))
(define-public python-markdown-it-py
  (package
   (name "python-markdown-it-py")
   (version "2.1.0")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "markdown-it-py" version))
            (sha256
             (base32
              "1nh75i72584r70alhqc479gys04s5m5g3vq601yf2njbs7z5jzng"))))
   (build-system python-build-system)
   (propagated-inputs (list ;;python-attrs
                            ;;python-commonmark
                            ;;python-coverage
                            ;;python-gprof2dot
                            ;;python-linkify-it-py
                            ;;python-markdown
                            ;;python-mdit-py-plugins
                            python-mdurl
                            ;;python-mistletoe
                            ;;python-mistune
                            ;;python-myst-parser ;; optional dependency, removed due to loop
                            ;;python-panflute
                            ;; python-pre-commit
                            ;; python-psutil
                            ;; python-pytest
                            ;; python-pytest-benchmark
                            ;; python-pytest-cov
                            ;; python-pytest-regressions
                            ;; python-pyyaml
                            ;; python-sphinx
                            ;; python-sphinx-book-theme
                            ;; python-sphinx-copybutton
                            ;; python-sphinx-design
                            python-typing-extensions))
   (home-page "")
   (synopsis "Python port of markdown-it. Markdown parsing, done right!")
   (description "Python port of markdown-it.  Markdown parsing, done right!")
   (license #f)))
(define-public python-mdit-py-plugins
  (package
   (name "python-mdit-py-plugins")
   (version "0.3.1")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "mdit-py-plugins" version))
            (sha256
             (base32
              "0hclvs9widcrx8aiialw5waj4xpy3cl43pggjvz08vkx96c35h9z"))))
   (build-system python-build-system)
   (propagated-inputs (list python-attrs
                            python-coverage
                            python-markdown-it-py
                            python-myst-parser
                            python-pre-commit
                            python-pytest
                            python-pytest-cov
                            python-pytest-regressions
                            python-sphinx-book-theme))
   (home-page "null")
   (synopsis "Collection of plugins for markdown-it-py")
   (description "Collection of plugins for markdown-it-py")
   (license #f)))
(define-public python-pytest-param-files
  (package
   (name "python-pytest-param-files")
   (version "0.3.4")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "pytest_param_files" version))
            (sha256
             (base32
              "0gc9nsqizrjapjnbcs1bdxfcl69dpmwbpd9sssjidgcikm7k433c"))))
   (build-system python-build-system)
   (propagated-inputs (list python-black python-pytest))
   (home-page "")
   (synopsis "Create pytest parametrize decorators from external files.")
   (description "Create pytest parametrize decorators from external files.")
   (license #f)))
(define-public python-sphinx-book-theme
  (package
    (name "python-sphinx-book-theme")
    (version "0.3.3")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "sphinx_book_theme" version))
              (sha256
               (base32
                "05v2b8kjaari8c8y9xnflfzy5ip0d211y7zfiazxdihlzw465hqf"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda _
                      (invoke "flit" "build")))
                  (replace 'install
                    (lambda* (#:key inputs outputs #:allow-other-keys)
                      (add-installed-pythonpath inputs outputs)
                      (let ((out (assoc-ref outputs "out")))
                        (for-each (lambda (wheel)
                                    (format #true wheel)
                                    (invoke "python" "-m" "pip" "install"
                                            wheel (string-append "--prefix=" out)))
                                  (find-files "dist" "\\.whl$"))))))))

    (native-inputs (list python-flit python-flit-core))
    (propagated-inputs (list python-pydata-sphinx-theme
                             python-pyyaml
                             python-sphinx))
    (home-page "")
    (synopsis
     "A clean book theme for scientific explanations and documentation with Sphinx")
    (description
     "This package provides a clean book theme for scientific explanations and
documentation with Sphinx")
    (license #f)))
(define-public python-sphinx-design
  (package
   (name "python-sphinx-design")
   (version "0.3.0")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinx_design" version))
            (sha256
             (base32
              "1fpg9h61i6755cw3b6pmrfxzahg83si2alfs3gq7xcsmmqgzm0vi"))))
   (build-system python-build-system)
   (propagated-inputs (list python-furo
                            ;; python-myst-parser ;; removed cuz only optional dependency
                            python-pre-commit
                            python-pydata-sphinx-theme
                            python-pytest
                            python-pytest-cov
                            python-pytest-regressions
                            python-sphinx
                            python-sphinx-book-theme
                            python-sphinx-rtd-theme))
   (home-page "")
   (synopsis
    "A sphinx extension for designing beautiful, view size responsive web components.")
   (description
    "This package provides a sphinx extension for designing beautiful, view size
responsive web components.")
   (license #f)))
(define-public python-sphinx-pytest
  (package
    (name "python-sphinx-pytest")
    (version "0.0.5")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "sphinx_pytest" version))
              (sha256
               (base32
                "13d3psm5vyb8rdj0mhnpn5m09k8xdaszcxdpng52fpz9sw8pngk7"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda _
                      (invoke "flit" "build")))
                  (replace 'install
                    (lambda* (#:key inputs outputs #:allow-other-keys)
                      (add-installed-pythonpath inputs outputs)
                      (let ((out (assoc-ref outputs "out")))
                        (for-each (lambda (wheel)
                                    (format #true wheel)
                                    (invoke "python" "-m" "pip" "install"
                                            wheel (string-append "--prefix=" out)))
                                  (find-files "dist" "\\.whl$"))))))))
    (native-inputs (list python-flit python-flit-core))
    (propagated-inputs (list python-pytest python-sphinx))
    (home-page "")
    (synopsis "Helpful pytest fixtures for sphinx extensions.")
    (description "Helpful pytest fixtures for sphinx extensions.")
    (license #f)))
(define-public python-sphinxcontrib-mermaid
  (package
   (name "python-sphinxcontrib-mermaid")
   (version "0.7.1")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinxcontrib-mermaid" version))
            (sha256
             (base32
              "0g19bnmfksjjn9z5si94hkd9nam51hj808dn4hld2sn81ssl12ma"))))
   (build-system python-build-system)
   (arguments
    '(#:tests? #f)) ;; disabling test which fails with posixpath.py, probably cuz we're in a limited guix build environment
   (home-page "https://github.com/mgaitan/sphinxcontrib-mermaid")
   (synopsis "Mermaid diagrams in yours Sphinx powered docs")
   (description "Mermaid diagrams in yours Sphinx powered docs")
   (license license:bsd-3)))
(define-public python-sphinxext-rediraffe
  (package
   (name "python-sphinxext-rediraffe")
   (version "0.2.7")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "sphinxext-rediraffe" version))
            (sha256
             (base32
              "0pbjkwmqc8q08bsk66panvpya831ycjq1ysdagyrznpzwpxcn7b5"))))
   (build-system python-build-system)
   (propagated-inputs (list python-sphinx))
   (home-page "https://github.com/wpilibsuite/sphinxext-rediraffe")
   (synopsis
    "Sphinx Extension that redirects non-existent pages to working pages.")
   (description
    "Sphinx Extension that redirects non-existent pages to working pages.")
   (license #f)))
(define-public python-gprof2dot
  (package
   (name "python-gprof2dot")
   (version "2022.7.29")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "gprof2dot" version))
            (sha256
             (base32
              "1i9y2d1vl4av8hwwvmh4phd7lgvpibc3y72iz768yq1npncd5d25"))))
   (build-system python-build-system)
   (home-page "https://github.com/jrfonseca/gprof2dot")
   (synopsis "Generate a dot graph from the output of several profilers.")
   (description "Generate a dot graph from the output of several profilers.")
   (license #f)))
(define-public python-mdurl
  (package
    (name "python-mdurl")
    (version "0.1.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "mdurl" version))
              (sha256
               (base32
                "1fn1hy35h9grggwqax90zcb52inlfxrxsm27vlqqz8zfyllkshdv"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda _
                      (invoke "flit" "build")))
                   (replace 'install
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (add-installed-pythonpath inputs outputs)
             (let ((out (assoc-ref outputs "out")))
               (for-each (lambda (wheel)
                           (format #true wheel)
                           (invoke "python" "-m" "pip" "install"
                                   wheel (string-append "--prefix=" out)))
                         (find-files "dist" "\\.whl$"))))))))
    (home-page "")
    (native-inputs (list python-flit python-flit-core))
    (synopsis "Markdown URL utilities")
    (description "Markdown URL utilities")
    (license #f)))
(define-public python-panflute
  (package
   (name "python-panflute")
   (version "2.2.3")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "panflute" version))
            (sha256
             (base32
              "1imv1y7z5r465sw614b7a8ka4f26g5njwljnd0wswnbw1gx374q0"))))
   (build-system python-build-system)
   (propagated-inputs (list python-click python-pyyaml))
   (native-inputs (list python-configparser
                        python-coverage
                        python-flake8
                        python-pandocfilters
                        python-pytest
                        python-pytest-cov
                        python-requests))
   (home-page "https://github.com/sergiocorreia/panflute")
   (synopsis "Pythonic Pandoc filters")
   (description "Pythonic Pandoc filters")
   (license #f)))
;;python-panflute ;;WORKS
;;python-mdurl ;;WORKS
;;python-gprof2dot ;;WORKS
;;python-sphinxext-rediraffe ;;WORKS
;;python-sphinxcontrib-mermaid ;; WORKS with tests disabled
;;python-sphinx-pytest
;; (define-public python-ablog
;;   (package
;;     (name "python-ablog")
;;     (version "0.10.29")
;;     (source (origin
;;               (method url-fetch)
;;               (uri (pypi-uri "ablog" version))
;;               (sha256
;;                (base32
;;                 "100waw56xw9518q9srm3n37i3r3l4wx2p18i93bkikx755ffhv5b"))))
;;     (build-system python-build-system)
;;     (propagated-inputs (list python-dateutil
;;                              python-docutils
;;                              python-feedgen
;;                              python-invoke
;;                              python-sphinx
;;                              python-watchdog))
;;     (native-inputs (list python-alabaster
;;                          python-ipython
;;                          python-myst-parser
;;                          python-nbsphinx
;;                          python-pytest
;;                          python-sphinx-automodapi))
;;     (home-page "https://ablog.readthedocs.org/")
;;     (synopsis
;;      "A Sphinx extension that converts any documentation or personal website project into a full-fledged blog.")
;;     (description
;;      "This package provides a Sphinx extension that converts any documentation or
;; personal website project into a full-fledged blog.")
;;     (license license:expat)))
;;python-sphinx-design
;;python-nbdev
;;python-requests-cache ;; fails

(define-public python-notebook-shim
  (package
    (name "python-notebook-shim")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "notebook_shim" version))
              (sha256
               (base32
                "119y4vbk3k8zv18fyywgf2bhbihrdxcy6hr1ba94h8nr6rxf95vq"))))
    (build-system python-build-system)
    (arguments
     '(#:tests? #f)) ;; network tests
    (propagated-inputs (list python-jupyter-server))
    (native-inputs (list python-pytest python-pytest-console-scripts
                         python-pytest-tornasync))
    (home-page "https://github.com/jupyterlab/notebook_shim")
    (synopsis "A shim layer for notebook traits and config")
    (description
     "This package provides a shim layer for notebook traits and config")
    (license #f)))

(define-public python-jupyterhub
  (package
    (name "python-jupyterhub")
    (version "3.0.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "jupyterhub" version))
              (sha256
               (base32
                "0sgvqzxsy2r9880yymiwrbcgwr2z1h8n2nzvcraybwqch2yzxk85"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f)) ;; tests need a node package configurable-http-proxy which we don't have
    (propagated-inputs (list python-alembic
                             python-async-generator
                             python-certipy
                             python-dateutil
                             python-importlib-metadata
                             python-jinja2
                             python-jupyter-telemetry
                             python-jupyter-server
                             python-oauthlib
                             python-packaging
                             python-pamela
                             python-prometheus-client
                             python-psutil
                             python-requests
                             python-sqlalchemy
                             python-tornado
                             python-traitlets))
    (home-page "https://jupyter.org")
    (synopsis "JupyterHub: A multi-user server for Jupyter notebooks")
    (description "JupyterHub: A multi-user server for Jupyter notebooks")
    (license license:bsd-3)))
(define-public python-jupyter-telemetry
  (package
    (name "python-jupyter-telemetry")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "jupyter_telemetry" version))
              (sha256
               (base32
                "052khyn6h97jxl3k5i2m81xvga5v6vwh5qixzrax4w6zwcx62p24"))))
    (build-system python-build-system)
    (propagated-inputs (list python-json-logger python-jsonschema
                             python-ruamel.yaml python-traitlets))
    (home-page "http://jupyter.org")
    (synopsis "Jupyter telemetry library")
    (description "Jupyter telemetry library")
    (license license:bsd-3)))
;; python-jupyterlab ;; WORKS but with kludges, like [W 2022-10-04 20:52:54.618 LabApp] [Errno 30] Read-only file system: '/home/user1/.guix-profile/etc/jupyter/lab'

;;python-nbdev ;; loops still

;;python-svg.py ;; WORKS
;; python-nbdev-numpy ;; WORKS
;;python-nbdev-stdlib ;; WORKS
(define-public python-jsonref
  (package
    (name "python-jsonref")
    (version "0.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "jsonref" version))
              (sha256
               (base32
                "15v69rg2lkcykb2spnq6vbbirv9sfq480fnwmfppw9gn3h95pi7k"))))
    (build-system python-build-system)
    (arguments '(#:tests? #f))
    (home-page "https://github.com/gazpachoking/jsonref")
    (synopsis "An implementation of JSON Reference for Python")
    (description "An implementation of JSON Reference for Python")
    (license license:expat)))
;; python-ghapi ;; WORKS
;;python-execnb ;; WORKS
;;python-fastcore
(define-public python-quarto
  (package
   (name "python-quarto")
   (version "0.1.0")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "quarto" version))
            (sha256
             (base32
              "05gd5p3jgjr9krw26slgmk5yz0sh36gam7zk7afmnkr0220rg96r"))))
   (build-system python-build-system)
   (propagated-inputs (list python-ipykernel python-jupyter-core
                            python-nbclient python-nbformat python-pyyaml))
   (home-page "https://github.com/quarto-dev/quarto-python")
   (synopsis "Python Interface to 'Quarto' Markdown Publishing System")
   (description "Python Interface to 'Quarto' Markdown Publishing System")
   (license #f)))
;;python-quarto
