(define-module (python-nbdev-org-babel-revs) #:use-module (python-extras) #:use-module (guix packages) #:use-module (guix git-download))
(define-public python-nbdev-org-babel-66079a5 (package (inherit python-nbdev-org-babel)(properties '(("generated-by" . "cigmon")))(name "python-nbdev-org-babel-66079a5")(source (origin (method git-fetch) (uri (git-reference (commit "66079a59aa9ee5e4479bdce597aac0f42f7fb565")(url "https://github.com/methuselah-0/nbdev-org-babel.git")))(sha256 (base32 "0krdpc6zbdljriw6s80g08fywy0d1nq8wi3q07v3qs0b6rfz68n4"))))))
(define-public python-nbdev-org-babel-4f195e9 (package (inherit python-nbdev-org-babel)(properties '(("generated-by" . "cigmon")))(name "python-nbdev-org-babel-4f195e9")(source (origin (method git-fetch) (uri (git-reference (commit "4f195e915eefe5cd4deec3c6aea27e4b61233f33")(url "https://github.com/methuselah-0/nbdev-org-babel.git")))(sha256 (base32 "0ayfxnw1s9rzs1qpqqyqwhf21xk6g8psffsqzfvvl0w5k1j88dqn"))))))
(define-public python-nbdev-org-babel-master (package (inherit python-nbdev-org-babel-4f195e9)(name "python-nbdev-org-babel-master")))
;;(define-public python-nbdev-org-babel-master (package (inherit python-nbdev-org-babel-66079a5)(name "python-nbdev-org-babel-master")))
;;python-nbdev-org-babel-master

