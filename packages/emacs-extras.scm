(define-module (emacs-extras)
#:use-module (guix packages)
#:use-module (guix download)
#:use-module (guix git-download)
#:use-module (guix gexp)
#:use-module (gnu packages emacs-xyz)
#:use-module (gnu packages check) ;; python-pytest
#:use-module (guix build-system emacs)
#:use-module (gnu packages graphviz)
#:use-module ((guix licenses) #:prefix license:))

(define-public emacs-flycheck
  (package
    (name "emacs-flycheck")
    (version "32")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/flycheck/flycheck/")
             (commit version)))
       (sha256
        (base32 "0dx6wqxz1yfp4shas4yn6abqc8bz21ks3glcyzznm3xspjdaq21s"))
       (file-name (git-file-name name version))
       (patches (list (string-append (dirname (current-filename)) "/0001-flycheck.el-fix-finding-the-currect-filename-when-in.patch")))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-dash))
    (native-inputs
     (list emacs-shut-up))
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'change-flycheck-version
            (lambda _
              (substitute* "flycheck.el"
                (("\\(pkg-info-version-info 'flycheck\\)")
                 (string-append "\"" #$version "\""))))))
      ;; TODO: many failing tests
      #:tests? #f
      #:test-command
      #~(list "emacs" "-Q" "--batch"
              "-L" "."
              "--load" "test/flycheck-test"
              "--load" "test/run.el"
              "-f" "flycheck-run-tests-main")))
    (home-page "https://www.flycheck.org")
    (synopsis "On-the-fly syntax checking")
    (description
     "This package provides on-the-fly syntax checking for GNU Emacs.  It is a
replacement for the older Flymake extension which is part of GNU Emacs, with
many improvements and additional features.

Flycheck provides fully-automatic, fail-safe, on-the-fly background syntax
checking for over 30 programming and markup languages with more than 70
different tools.  It highlights errors and warnings inline in the buffer, and
provides an optional IDE-like error list.")
    (license license:gpl3+)))                     ;+GFDLv1.3+ for the manual

(define-public emacs-flycheck-pycheckers
  (package
   (name "emacs-flycheck-pycheckers")
   (version "0.15")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	    (commit "56965c0ef5d45bcef90093360718c6967ce4ef39")
	    (url "https://github.com/msherry/flycheck-pycheckers.git")))
     (sha256
      (base32
       "0dfsqgvmnikza9g3wjq1sclflr640wkh37b3lm9g7r74wrrk8waz"))))
   (build-system emacs-build-system)
   (propagated-inputs
    `(("emacs-flycheck" ,emacs-flycheck)))
   (home-page
    "https://github.com/msherry/flycheck-pycheckers")
   (synopsis
    "multiple syntax checker for Python, using Flycheck")
   (description
    "Copyright Marc Sherry <msherry at gmail dot com>

This package provides a way to run multiple syntax checkers on Python code,
in parallel.  The list of supported checkers includes:

- pylint
- flake8
- pep8
- pyflakes
- mypy (for both Python 2 and 3)
- bandit

This is an alternative way of running multiple Python syntax checkers in
Flycheck that doesn't depend on Flycheck's chaining mechanism.

Flycheck is opinionated about what checkers should be run (see
https://github.com/flycheck/flycheck/issues/185), and chaining is difficult
to get right (e.g. see https://github.com/flycheck/flycheck/issues/836,
https://github.com/flycheck/flycheck/issues/1300).  This package assumes
that the user knows what they want, and can configure their checkers
accordingly -- if they want to run both flake8 and pylint, that's fine.

This also allows us to run multiple syntax checkers in parallel, rather than
sequentially.

Quick start:

Installation via MELPA is easiest:

    M-x install-package flycheck-pycheckers

Then, in your `init.el':

(global-flycheck-mode 1)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))

Start editing a Python file!

For more details on using Flycheck in general, please see
http://www.flycheck.org/en/latest/user/quickstart.html.  The error list
(viewable with `flycheck-list-errors', bound to `C-c ! l' by default) shows
a unified view of all errors found by all checkers, with line and column
information where available.

flycheck-pycheckers can run over any Python file right away, without needing
to set up virtual environments or driver scripts.  You will simply need to
ensure that the checkers you want to run (pep8, mypy, flake8, etc.) are
installed somewhere on your PATH where Emacs can find them.

Alternatives:

* Other Flycheck-based checkers -
  http://www.flycheck.org/en/latest/languages.html#python.  Some are
  officially part of the Flycheck package, and some (like this one) are
  external plugins.

* Flymake - https://www.emacswiki.org/emacs/FlyMake.  Flymake is an older
  syntax-checking minor mode for Emacs, and is generally less supported and
  featureful than Flycheck.

Configuration options:

_You can use this package without needing to get into these details at first
-- they are intended for power users and those needing more customization._

There are a number of options that can be customized via
`customize-variable', which all start with `flycheck-pycheckers-`.  These
include:

* `flycheck-pycheckers-args' - general arguments to pass to `pycheckers.py'.

* `flycheck-pycheckers-checkers' - the set of checkers to run (pylint, pep8,
   mypy, etc.).  Can be set in `.pycheckers' files with the variable
   `checkers' as a comma-separated list of checker names.

* `flycheck-pycheckers-ignore-codes' - a set of error codes to universally
  ignore.  These can be set more granularly (e.g. per-project) using the
  `.pycheckers' file described below.

* `flycheck-pycheckers-max-line-length' - the default maximum line
  length.  Can be overridden via `.pycheckers' file.

* `flycheck-pycheckers-multi-thread' - whether to run each checker
  simultaneously in its own thread, for performance.

* `flycheck-pycheckers-venv-root' - a directory containing Python virtual
  environments, so that imports may be found.

Additionally, a `.pycheckers' file may be created in a directory to control
options for every file under this directory.  These files may be logically
combined, so a project may have one set of options that may be selectively
overridden in a specific subdirectory.

Example .pycheckers file:

    [DEFAULT]
    max_line_length = 120
    mypy_config_file = ci/mypy.ini

Variables that can be set in the configuration file include the following.
Note that these are implemented as modifying the values received by
`argparse' in the `pycheckers.py' script, so running `bin/pycheckers.py
--help` is a good way to find other options that may be specified.

* `max-line-length' - the maximum allowable line-length.  This is a good
  option to place in a project-specific directory if you have a personal
  line length preference set by default via
  `flycheck-pycheckers-max-line-length', but also work on projects that
  follow different standards.

* `checkers' - a comma-separated list of checkers to be run for files under
  this directory.  If, for instance, pep8 should not be run on a directory of
  auto-generated code, this option can accomplish that.

* `ignore_codes' - a comma-separated list of error/warning codes to ignore
  for files under this directory.  Replaces the current set of codes
  completely.

* `merge_configs' - whether to keep traversing upwards when parsing
  `.pycheckers' files, or stop at this one.

* `extra_ignore_codes' - a comma-separated list of error/warning codes to
  add to the current set of ignored errors.  This can be used to make
  certain directories conform to different levels of syntax enforcement.
  For example, a directory containing auto-generated code may omit various
  warnings about indentation or code style.

* `pylint_rcfile' - the location of a project-specific configuration file
  for pylint

* `mypy_config_file' - the location of a project-specific configuration file
  for mypy

* `flake8_config_file' - the location of a project-specific configuration file
  for flake8
")
   (license license:expat))) ;; wrong license
;;emacs-flycheck-pycheckers

