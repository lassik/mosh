; io-error.scm - Tests for i/o errors
;
;   Copyright (c) 2009  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
;
;   Redistribution and use in source and binary forms, with or without
;   modification, are permitted provided that the following conditions
;   are met:
;
;   1. Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
;
;   2. Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(import (rnrs)
        (mosh)
        (mosh process)
        (mosh test))

(define (on-mona?)
  (string=? (host-os) "mona"))

(define test-path-prefix
  (if (on-mona?)
      "/APPS/MOSH.APP/"
      ""))

;; utf-8-codec
;;   error-handling-mode: raise
(test-error i/o-decoding-error?
                (bytevector->string #vu8(97 #xff 98 99) (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise))))

;; utf-8-codec
;;   error-handling-mode: ignore
(test-equal (bytevector->string #vu8(97 #xff 98 99) (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode ignore)))
       "abc")

;; utf-8-codec
;;   error-handling-mode: ignore
(test-equal (bytevector->string #vu8(97 98 #xff 99) (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode ignore)))
       "abc")

;; utf-8-codec
;;   error-handling-mode: ignore
(test-equal (bytevector->string #vu8(97 98 99 #xff) (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode ignore)))
       "abc")

;; utf-8-code
;;   error-handling-mode: replace
(let ([s (bytevector->string #vu8(97 #xff 98 99) (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode replace)))])
  (test-equal #\a (string-ref s 0))
  (test-equal (string-ref s 1) (integer->char #xfffd))
  (test-equal (string-ref s 2) #\b)
  (test-equal (string-ref s 3) #\c))

;; How do I can test utf-8-codec encoding-error?
;; It never happen?

;; utf-8-codec
;;  read
(test-error i/o-decoding-error?
                 (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                       (file-options no-truncate no-fail)
                                                       (buffer-mode none)
                                                       (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                         read))

(test-error i/o-decoding-error?
                 (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                       (file-options no-truncate no-fail)
                                                       (buffer-mode none)
                                                       (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                         (lambda (x) (read x))))

;; utf-8-codec
;;  peek-char
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                peek-char))

;; utf-8-codec
;;  get-datum
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                get-datum))

;; utf-8-codec
;;  get-string
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                get-string-all))

;; utf-8-codec
;;  get-string-n!
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                (lambda (x) (get-string-n! x "abc" 0 3))))

;; utf-8-codec
;;  get-char
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                get-char))

;; utf-8-codec
;;  get-string-n
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                (lambda (x) (get-string-n x 3))))

;; utf-8-codec
;;  port-eof?
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                port-eof?))

;; utf-8-codec
;;  get-line
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                get-line))

;; utf-8-codec
;;  lookahead-char
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                lookahead-char))

;; utf-8-codec
;;  read-char
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                read-char))

;; utf-8-codec
;;  read-char
(test-error i/o-decoding-error?
                (call-with-port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                                      (file-options no-truncate no-fail)
                                                      (buffer-mode none)
                                                      (make-transcoder (utf-8-codec) (native-eol-style) (error-handling-mode raise)))
                (lambda (x) (read-char x))))


;; utf-16-codec
;;   error-handling-mode: raise
(test-error i/o-decoding-error?
                (bytevector->string #vu8(97) (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise))))


;; utf-16-codec
;;   error-handling-mode: ignore
(test-equal (bytevector->string #vu8(97) (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode ignore)))
       "")

;; utf-16-code
;;   error-handling-mode: replace
(let ([s (bytevector->string #vu8(97) (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode replace)))])
  (test-equal (string-ref s 0) (integer->char #xfffd)))

;; utf-16-codec
;;  read
;; (test-error i/o-decoding-error?
;;                  (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                        (file-options no-truncate no-fail)
;;                                                        (buffer-mode none)
;;                                                        (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                          read))

;; (test-error i/o-decoding-error?
;;                  (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                        (file-options no-truncate no-fail)
;;                                                        (buffer-mode none)
;;                                                        (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                          (lambda (x) (read x))))

;; ;; utf-16-codec
;; ;;  peek-char
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 peek-char))

;; ;; utf-16-codec
;; ;;  get-datum
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 get-datum))

;; ;; utf-16-codec
;; ;;  get-string
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 get-string-all))

;; ;; utf-16-codec
;; ;;  get-string-n!
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 (lambda (x) (get-string-n! x "abc" 0 3))))

;; ;; utf-16-codec
;; ;;  get-char
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 get-char))

;; ;; utf-16-codec
;; ;;  get-string-n
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 (lambda (x) (get-string-n x 3))))

;; ;; utf-16-codec
;; ;;  port-eof?
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 port-eof?))

;; ;; utf-16-codec
;; ;;  get-line
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 get-line))

;; ;; utf-16-codec
;; ;;  lookahead-char
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 lookahead-char))

;; ;; utf-16-codec
;; ;;  read-char
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 read-char))

;; ;; utf-16-codec
;; ;;  read-char
;; (test-error i/o-decoding-error?
;;                 (call-with-port (open-file-input-port "./tests/invalid-utf16.txt"
;;                                                       (file-options no-truncate no-fail)
;;                                                       (buffer-mode none)
;;                                                       (make-transcoder (utf-16-codec) (native-eol-style) (error-handling-mode raise)))
;;                 (lambda (x) (read-char x))))


(test-error i/o-invalid-position-error?
            (let ([port (open-file-input-port (string-append test-path-prefix "./tests/invalid-utf8.txt")
                                              (file-options no-truncate no-fail)
                                              (buffer-mode none))])
              (set-port-position! port -1)))

;; file-is-read-only
;(unless (or (string=? (host-os) "win32") (string=? (host-os) "cygwin") (string=? (host-os) "mona"))
;  (let ()
;  (test-error i/o-file-is-read-only-error?
;                  (open-file-input/output-port "./tests/read-only.txt" (file-options no-fail) 'block))
;
;  (test-error i/o-file-is-read-only-error?
;                  (open-file-output-port "./tests/read-only.txt" (file-options no-fail) 'block))))


; we can't "svn add" this file, but test is OK.
;(open-file-output-port "./tests/can-not-read-write.txt" (file-options no-fail) 'block)
;(open-file-input/output-port "./tests/can-not-read-write.txt" (file-options no-fail) 'block)
;(open-file-input-port "./tests/can-not-read-write.txt" (file-options no-fail) 'block)
;(open-input-file "./tests/can-not-read-write.txt")
;(open-output-file "./tests/can-not-read-write.txt")

;; transcoded-port procedure closes the binary port
(test-error i/o-port-error?
                (let* ([binary-port (open-bytevector-input-port #vu8(97 98 99))]
                       [text-port (transcoded-port binary-port (make-transcoder (latin-1-codec)))])
                  (read-char text-port)
                  (read-char text-port)
                  (get-u8 binary-port) ;; port is already closed!
                  (display (read-char text-port))))

(when (or (string=? (host-os) "linux")
          (string=? (host-os) "bsd")
          (string=? (host-os) "darwin"))
(let ()
  (define (text-pipe)
    ;; Binary ports here
    (let-values ([(in out) (pipe)])
      ;; Textual ports here
      (cons (transcoded-port in (native-transcoder))
            (transcoded-port out (native-transcoder)))))

  (define p (text-pipe))
  (define p-reader (car p))
  (define p-writer (cdr p))

  (test-write-equal "<transcoded-textual-input-port <binary-input-port <unknown file>>>"
                     p-reader)
  (test-true (textual-port? p-reader))
  (test-write-equal "<transcoded-textual-output-port <binary-output-port <unknown file>>>"
                     p-writer)
  (test-true (textual-port? p-writer))

  (display "asd" p-writer)
  (flush-output-port p-writer)
  (test-eqv #\a (read-char p-reader))
  (close-port p-reader)
  (close-port p-writer)))

(cond
 [(member (host-os) '("win32" "linux" "bsd" "darwin"))
  (test-true (string? (mosh-executable-path)))]
 [else
  '()])

(test-results)
