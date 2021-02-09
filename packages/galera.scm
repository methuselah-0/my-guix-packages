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
    ;; (arguments
    ;;  `(#:tests? #f
    ;;    #:phases
    ;;    (modify-phases %standard-phases
    ;;      (add-after 'unpack 'adjust-output-references
    ;;        (lambda _
    ;;          (substitute* "CMakeLists.txt"
    ;;            (("add_subdirectory\\(wsrep/tests\\)") ""))
    ;;          (delete-file-recursively "wsrep/tests")
    ;;          )))))
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

