;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2012, 2013, 2014, 2015, 2016, 2018 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2012, 2013, 2014, 2015, 2016 Andreas Enge <andreas@enge.fr>
;;; Copyright © 2013, 2017 Cyril Roelandt <tipecaml@gmail.com>
;;; Copyright © 2014, 2016 David Thompson <davet@gnu.org>
;;; Copyright © 2014, 2015, 2016, 2018 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2014, 2015 Eric Bavier <bavier@member.fsf.org>
;;; Copyright © 2015, 2016 Sou Bunnbu <iyzsong@gmail.com>
;;; Copyright © 2015 Leo Famulari <leo@famulari.name>
;;; Copyright © 2015 Eric Dvorsak <eric@dvorsak.fr>
;;; Copyright © 2016 Hartmut Goebel <h.goebel@crazy-compilers.com>
;;; Copyright © 2016 Christopher Allan Webber <cwebber@dustycloud.org>
;;; Copyright © 2015, 2016, 2017, 2018, 2019, 2020 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2016, 2017 Nikita <nikita@n0.is>
;;; Copyright © 2016, 2017, 2018 Roel Janssen <roel@gnu.org>
;;; Copyright © 2016 David Craven <david@craven.ch>
;;; Copyright © 2016 Jan Nieuwenhuizen <janneke@gnu.org>
;;; Copyright © 2016 Andy Patterson <ajpatter@uwaterloo.ca>
;;; Copyright © 2016 Danny Milosavljevic <dannym+a@scratchpost.org>
;;; Copyright © 2016, 2017, 2018, 2019, 2020 Marius Bakke <mbakke@fastmail.com>
;;; Copyright © 2017, 2018 Julien Lepiller <julien@lepiller.eu>
;;; Copyright © 2017, 2020 Thomas Danckaert <post@thomasdanckaert.be>
;;; Copyright © 2017 Jelle Licht <jlicht@fsfe.org>
;;; Copyright © 2017 Adriano Peluso <catonano@gmail.com>
;;; Copyright © 2017 Arun Isaac <arunisaac@systemreboot.net>
;;; Copyright © 2017–2021 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2017, 2018 Alex Vong <alexvong1995@gmail.com>
;;; Copyright © 2017, 2018 Ben Woodcroft <donttrustben@gmail.com>
;;; Copyright © 2017 Rutger Helling <rhelling@mykolab.com>
;;; Copyright © 2017, 2018 Pierre Langlois <pierre.langlois@gmx.com>
;;; Copyright © 2015, 2017, 2018, 2019 Ricardo Wurmus <rekado@elephly.net>
;;; Copyright © 2017 Kristofer Buffington <kristoferbuffington@gmail.com>
;;; Copyright © 2018 Amirouche Boubekki <amirouche@hypermove.net>
;;; Copyright © 2018 Joshua Sierles, Nextjournal <joshua@nextjournal.com>
;;; Copyright © 2018 Maxim Cournoyer <maxim.cournoyer@gmail.com>
;;; Copyright © 2019 Jack Hill <jackhill@jackhill.us>
;;; Copyright © 2019 Alex Griffin <a@ajgrf.com>
;;; Copyright © 2019 Gábor Boskovits <boskovits@gmail.com>
;;; Copyright © 2019 Pierre Langlois <pierre.langlois@gmx.com>
;;; Copyright © 2019 Guillaume Le Vaillant <glv@posteo.net>
;;; Copyright © 2020 Pierre Neidhardt <mail@ambrevar.xyz>
;;; Copyright © 2020 Nicolò Balzarotti <nicolo@nixo.xyz>
;;; Copyright © 2020 Tanguy Le Carrour <tanguy@bioneland.org>
;;; Copyright © 2020 Lars-Dominik Braun <ldb@leibniz-psychology.org>
;;; Copyright © 2020 Guy Fleury Iteriteka <gfleury@disroot.org>
;;; Copyright © 2020 Michael Rohleder <mike@rohleder.de>
;;; Copyright © 2020 Vinicius Monego <monego@posteo.net>
;;; Copyright © 2020 Vincent Legoll <vincent.legoll@gmail.com>
;;; Copyright © 2021 Sharlatan Hellseher <sharlatanus@gmail.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (galera)
  #:use-module (gnu packages)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages cyrus-sasl)
  #:use-module (gnu packages dbm)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages language)
  #:use-module (gnu packages libedit)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages logging)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages onc-rpc)
  #:use-module (gnu packages parallel)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-check)
  #:use-module (gnu packages perl-web)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rdf)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages regex)
  #:use-module (gnu packages rpc)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages valgrind)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix bzr-download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system ruby)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system scons)
  #:use-module (guix build-system trivial)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match))

(define-public wsrep-api
  (package
   (name "wsrep-api")
   (version "26")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/codership/wsrep-API/archive/release_v" version ".tar.gz"))
            (sha256
             (base32
              "05351bsmfs0v8xrdy4vk04kx8m1a3qq2xy0xpijvzgj230igklwc"))))
   (build-system cmake-build-system)
   (arguments
    `(#:configure-flags (list "-DCMAKE_BUILD_TYPE=Release")
      #:tests? #f))
   ;; (modify-phases %standard-phases
   ;;                (replace 'install

   ;;                               (lambda* (#:key inputs outputs #:allow-other-keys)
   ;;          (let* ((out     (assoc-ref outputs "out"))
   ;;                 (dev     (assoc-ref outputs "dev"))
   ;;                 (lib     (assoc-ref outputs "lib"))
   ;;                 (openssl (assoc-ref inputs "openssl")))



   ;;           (substitute* (list (string-append out "/bin/mariadb-install-db")
    ;;                              (string-append out "/bin/mysql_install_db"))
    ;;             (("basedir=\"\"")
    ;;              (string-append "basedir=\"" out "\""))
    ;;             (("\\$basedir/share/mysql")
    ;;              (string-append lib "/share/mysql")))

    ;;           ;; Remove unneeded files for testing.
    ;;           (with-directory-excursion lib
    ;;             (for-each delete-file-recursively
    ;;                       '("mysql-test" "sql-bench"))
    ;;             ;; And static libraries.
    ;;             (for-each delete-file (find-files "lib" "\\.a$")))
    ;;           (with-directory-excursion out
    ;;             (delete-file "share/man/man1/mysql-test-run.pl.1")
    ;;             ;; Delete huge and unnecessary executables.
    ;;             (for-each delete-file (find-files "bin" "test$")))
    ;;           (mkdir-p (string-append dev "/share"))
    ;;           (mkdir-p (string-append dev "/bin"))
    ;;           (rename-file (string-append lib "/bin/mariadbd")
    ;;                        (string-append out "/bin/mariadbd"))
    ;;           (rename-file (string-append lib "/bin/mysqld")
    ;;                        (string-append out "/bin/mysqld"))
    ;;           (mkdir-p (string-append dev "/lib"))
    ;;           (rename-file (string-append lib "/lib/pkgconfig")
    ;;                        (string-append dev "/lib/pkgconfig"))
    ;;           (rename-file (string-append lib "/bin/mariadb_config")
    ;;                        (string-append dev "/bin/mariadb_config"))
    ;;           (rename-file (string-append out "/bin/mysql_config")
    ;;                        (string-append dev "/bin/mysql_config"))

    ;;           ;; Embed an absolute reference to OpenSSL in mysql_config
    ;;           ;; and the pkg-config file to avoid propagation.
    ;;           ;; XXX: how to do this for mariadb_config.c.in?
    ;;           (substitute* (list (string-append dev "/bin/mysql_config")
    ;;                              (string-append dev "/lib/pkgconfig/mariadb.pc"))
    ;;             (("-lssl -lcrypto" all)
    ;;              (string-append "-L" openssl "/lib " all)))

    ;;           #t))))))


   
                  
   ;; (native-inputs
   ;;  `(("bison" ,bison)
   ;;    ("perl" ,perl)))
   (inputs
    `(("boost" ,boost)))
   (home-page "https://mariadb.org/")
   (synopsis "wsrep-api")
   (description
    "wsrep-lib needed for Galera")
   (license license:gpl2)))

(define-public wsrep-lib
  (let (;;(commit "9d43f1bc4958ac136786f8c3b82cd3aa50713f49")
        (commit "a93955ddeef5989505cbb3a9f8bb124341462569")
	(revision "0.0.1"))
    (package
     (name "wsrep-lib")
     (version (git-version "1.2" revision commit))
     (source (origin
	      (method git-fetch)
	      (uri (git-reference
		    (commit commit)
		    (url "https://github.com/codership/wsrep-lib.git")
                    (recursive? #t)))
	      (sha256
	       (base32 "0ryf63yfscl8happ1kw32z59z1f0nm0bz88cx97fyd4vsqbfv99h"))))
     (build-system cmake-build-system)
     ;; (native-inputs
     ;;  `(("bison" ,bison)
     ;;    ("perl" ,perl)))
     (inputs
      `(("boost" ,boost)))
     (home-page "https://mariadb.org/")
     (synopsis "wsrep-lib")
     (description
      "wsrep-lib needed for Galera")
     (license license:gpl2))))

(define-public mariadb
  (package
   (name "mariadb")
   (version "10.5.6")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://downloads.mariadb.com/MariaDB"
                                "/mariadb-" version "/source/mariadb-"
                                version ".tar.gz"))
            (sha256
             (base32
              "1i257h0zdypdfj5wkg6ck9pxlkph0jvjs92k22pjr6gnx5lxs1gz"))
            (modules '((guix build utils)))
            (snippet
             '(begin
                ;; Delete bundled snappy and xz.
                (delete-file-recursively "storage/tokudb/PerconaFT/third_party")
                (substitute* "storage/tokudb/PerconaFT/CMakeLists.txt"
                             ;; This file checks that the bundled sources are present and
                             ;; declares build procedures for them.
                             (("^include\\(TokuThirdParty\\)") ""))
                (substitute* "storage/tokudb/PerconaFT/ft/CMakeLists.txt"
                             ;; Don't attempt to use the procedures we just removed.
                             ((" build_lzma build_snappy") ""))

                ;; Preserve CMakeLists.txt for these.
                (for-each (lambda (file)
                            (unless (string-suffix? "CMakeLists.txt" file)
                              (delete-file file)))
                          (append (find-files "extra/wolfssl")
                                  (find-files "zlib")))
                #t))))
   (build-system cmake-build-system)
   (outputs '("out" "lib" "dev"))
   (arguments
    `(#:configure-flags
      (list
       "-DBUILD_CONFIG=mysql_release"
       ;; Linking with libarchive fails, like this:

       ;; ld: /gnu/store/...-libarchive-3.2.2/lib/libarchive.a(archive_entry.o):
       ;; relocation R_X86_64_32 against `.bss' can not be used when
       ;; making a shared object; recompile with -fPIC

       ;; For now, disable the features that that use libarchive (xtrabackup).
       "-DWITH_LIBARCHIVE=OFF"

       ;; Disable the TokuDB engine, because its test suite frequently fails,
       ;; and loading it crashes the server: <https://bugs.gnu.org/35521>.
       "-DTOKUDB_OK=OFF"

       ;; Ensure the system libraries are used.
       "-DWITH_JEMALLOC=yes"
       "-DWITH_PCRE=system"
       "-DWITH_SSL=system"
       "-DWITH_ZLIB=system"

       "-DDEFAULT_CHARSET=utf8"
       "-DDEFAULT_COLLATION=utf8_general_ci"
       "-DMYSQL_DATADIR=/var/lib/mysql"
       "-DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock"
       (string-append "-DCMAKE_INSTALL_PREFIX=" (assoc-ref %outputs "lib"))
       (string-append "-DCMAKE_INSTALL_RPATH=" (assoc-ref %outputs "lib")
                      "/lib")
       (string-append "-DINSTALL_INFODIR=" (assoc-ref %outputs "out")
                      "/share/mysql/docs")
       (string-append "-DINSTALL_MANDIR=" (assoc-ref %outputs "out")
                      "/share/man")
       (string-append "-DINSTALL_SCRIPTDIR=" (assoc-ref %outputs "out") "/bin")
       (string-append "-DINSTALL_BINDIR=" (assoc-ref %outputs "out") "/bin")
       "-DCMAKE_INSTALL_LIBDIR=lib"
       "-DINSTALL_PLUGINDIR=lib/mysql/plugin"
       (string-append "-DINSTALL_INCLUDEDIR=" (assoc-ref %outputs "dev")
                      "/include/mysql")
       (string-append "-DINSTALL_DOCREADMEDIR=" (assoc-ref %outputs "out")
                      "/share/mysql/docs")
       (string-append "-DINSTALL_DOCDIR=" (assoc-ref %outputs "out")
                      "/share/mysql/docs")
       (string-append "-DINSTALL_SUPPORTFILESDIR=" (assoc-ref %outputs "out")
                      "/share/mysql/support-files")
       "-DINSTALL_MYSQLSHAREDIR=share/mysql"
       "-DINSTALL_SHAREDIR=share")
      #:phases
      (modify-phases %standard-phases
                     (add-after 'unpack 'adjust-output-references
                                (lambda _
                                  ;; The build system invariably prepends $CMAKE_INSTALL_PREFIX
                                  ;; to other variables such as $INSTALL_INCLUDEDIR, which does
                                  ;; not work when the latter uses an absolute file name.
                                  (substitute* "libmariadb/mariadb_config/mariadb_config.c.in"
                                               (("@CMAKE_INSTALL_PREFIX@/@INSTALL_INCLUDEDIR@")
                                                "@INSTALL_INCLUDEDIR@"))
                                  (substitute* "libmariadb/mariadb_config/libmariadb.pc.in"
                                               (("\\$\\{prefix\\}/@INSTALL_INCLUDEDIR@")
                                                "@INSTALL_INCLUDEDIR@"))
                                  (substitute* "include/CMakeLists.txt"
                                               (("\\\\\\$\\{CMAKE_INSTALL_PREFIX\\}/\\$\\{INSTALL_INCLUDEDIR\\}")
                                                "${INSTALL_INCLUDEDIR}"))
                                  #t))
                     (add-after 'unpack 'adjust-tests
                                (lambda _
                                  (let ((disabled-tests
                                         '( ;; These fail because root@hostname == root@localhost in
                                           ;; the build environment, causing a user count mismatch.
                                           ;; See <https://jira.mariadb.org/browse/MDEV-7761>.
                                           "funcs_1.is_columns_mysql"
                                           "main.join_cache"
                                           "main.explain_non_select"
                                           "main.stat_tables"
                                           "main.stat_tables_innodb"
                                           "roles.acl_statistics"

                                           ;; This file contains a time bomb which makes it fail after
                                           ;; 2030-12-31.  See <https://bugs.gnu.org/34351> for details.
                                           "main.mysqldump"))

                                        ;; This file contains a list of known-flaky tests for this
                                        ;; release.  Append our own items.
                                        (unstable-tests (open-file "mysql-test/unstable-tests" "a")))
                                    (for-each (lambda (test)
                                                (format unstable-tests "~a : ~a\n"
                                                        test "Disabled in Guix"))
                                              disabled-tests)
                                    (close-port unstable-tests)

                                    ;; XXX: These fail because they expect a latin1 charset and
                                    ;; collation.  See <https://jira.mariadb.org/browse/MDEV-21264>.
                                    (substitute* '("mysql-test/main/gis_notembedded.result"
                                                   "mysql-test/main/system_mysql_db.result")
                                                 (("latin1_swedish_ci") "utf8_general_ci")
                                                 (("\tlatin1") "\tutf8"))

                                    (substitute* "mysql-test/suite/binlog/t/binlog_mysqlbinlog_stop_never.test"
                                                 (("/bin/bash")
                                                  (which "bash")))

                                    (substitute* "mysql-test/mysql-test-run.pl"
                                                 (("/bin/ls") (which "ls"))
                                                 (("/bin/sh") (which "sh")))
                                    #t)))
                     (add-before 'configure 'disable-plugins
                                 (lambda _
                                   (let ((disable-plugin (lambda (name)
                                                           (call-with-output-file
                                                               (string-append "plugin/" name
                                                                              "/CMakeLists.txt")
                                                             (lambda (port)
                                                               (format port "\n")))))
                                         (disabled-plugins '( ;; XXX: Causes a test failure.
                                                             "disks")))
                                     (for-each disable-plugin disabled-plugins)
                                     #t)))
                     (replace 'check
                              (lambda* (#:key (tests? #t) #:allow-other-keys)
                                (if tests?
                                    (with-directory-excursion "mysql-test"
                                                              (invoke "./mtr" "--verbose"
                                                                      "--retry=3"
                                                                      "--testcase-timeout=40"
                                                                      "--suite-timeout=600"
                                                                      "--parallel" (number->string (parallel-job-count))
                                                                      ;; Skip the replication tests: they are very I/O
                                                                      ;; intensive and frequently causes indeterministic
                                                                      ;; failures even on powerful hardware.
                                                                      "--skip-rpl"
                                                                      "--skip-test-list=unstable-tests"))
                                    (format #t "test suite not run~%"))
                                #t))
                     (add-after
                      'install 'post-install
                      (lambda* (#:key inputs outputs #:allow-other-keys)
                        (let* ((out     (assoc-ref outputs "out"))
                               (dev     (assoc-ref outputs "dev"))
                               (lib     (assoc-ref outputs "lib"))
                               (openssl (assoc-ref inputs "openssl")))
                          (substitute* (list (string-append out "/bin/mariadb-install-db")
                                             (string-append out "/bin/mysql_install_db"))
                                       (("basedir=\"\"")
                                        (string-append "basedir=\"" out "\""))
                                       (("\\$basedir/share/mysql")
                                        (string-append lib "/share/mysql")))

                          ;; Remove unneeded files for testing.
                          (with-directory-excursion lib
                                                    (for-each delete-file-recursively
                                                              '("mysql-test" "sql-bench"))
                                                    ;; And static libraries.
                                                    (for-each delete-file (find-files "lib" "\\.a$")))
                          (with-directory-excursion out
                                                    (delete-file "share/man/man1/mysql-test-run.pl.1")
                                                    ;; Delete huge and unnecessary executables.
                                                    (for-each delete-file (find-files "bin" "test$")))
                          (mkdir-p (string-append dev "/share"))
                          (mkdir-p (string-append dev "/bin"))
                          (rename-file (string-append lib "/bin/mariadbd")
                                       (string-append out "/bin/mariadbd"))
                          (rename-file (string-append lib "/bin/mysqld")
                                       (string-append out "/bin/mysqld"))
                          (mkdir-p (string-append dev "/lib"))
                          (rename-file (string-append lib "/lib/pkgconfig")
                                       (string-append dev "/lib/pkgconfig"))
                          (rename-file (string-append lib "/bin/mariadb_config")
                                       (string-append dev "/bin/mariadb_config"))
                          (rename-file (string-append out "/bin/mysql_config")
                                       (string-append dev "/bin/mysql_config"))

                          ;; Embed an absolute reference to OpenSSL in mysql_config
                          ;; and the pkg-config file to avoid propagation.
                          ;; XXX: how to do this for mariadb_config.c.in?
                          (substitute* (list (string-append dev "/bin/mysql_config")
                                             (string-append dev "/lib/pkgconfig/mariadb.pc"))
                                       (("-lssl -lcrypto" all)
                                        (string-append "-L" openssl "/lib " all)))

                          #t))))))
   (native-inputs
    `(("bison" ,bison)
      ("perl" ,perl)))
   (inputs
    `(("jemalloc" ,jemalloc)
      ("libaio" ,libaio)
      ("libxml2" ,libxml2)
      ("ncurses" ,ncurses)
      ("openssl" ,openssl)
      ("pam" ,linux-pam)
      ("pcre2" ,pcre2)
      ("xz" ,xz)
      ("zlib" ,zlib)))
   ;; The test suite is very resource intensive and can take more than three
   ;; hours on a x86_64 system.  Give slow and busy machines some leeway.
   (properties '((timeout . 64800)))    ;18 hours
   (home-page "https://mariadb.org/")
   (synopsis "SQL database server")
   (description
    "MariaDB is a multi-user and multi-threaded SQL database server, designed
as a drop-in replacement of MySQL.")
   (license license:gpl2)))

(define-public galera
  (package
    (name "galera")
    (version "26.4.7")
    (source (origin
             ;; tarball is missing wsrep/src submodule
             ;; bac8171266cb982fe013ce496d78085438c6f23e
	     (method git-fetch)
	     (uri (git-reference
		   (commit "bac8171266cb982fe013ce496d78085438c6f23e")
		   (url "https://github.com/codership/galera.git")
                   (recursive? #t)))
	     (sha256
	      (base32 "0h7s670pcasq8wzprhyxqfca2cghi62b8xz2kikb2a86wd453qil"))))             
    (build-system cmake-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'adjust-output-references
           (lambda _
             (substitute* "CMakeLists.txt"
               (("add_subdirectory\\(wsrep/tests\\)") ""))
             (delete-file-recursively "wsrep/tests")
             )))))
    (native-inputs
     `(("check" ,check)
       ("boost" ,boost)))
    
    (inputs
     `(
       ("openssl" ,openssl)
       ))
    (home-page "https://github.com/codership/galera/")
    (synopsis "Extension to the MariaDB database server")
    (description
     "Galera is a wsrep-provider that is used with MariaDB for load-balancing and HA.")
    (license license:gpl2)))

;; TODO: CONTINUE HERE: package wsrep-api to package wsrep-lib and then use those as inputs to galera.
;; then, use https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mariadb-on-centos-7-servers and be able to specify wsrep provider.

;; wants #include wsrep_api.h
;;galera


;; provides libwsrep_api_v26.a
;;wsrep-lib


;;wsrep-api

