(import (rnrs)
        (only (srfi :1) first second)
        (match)
        (mosh file)
        (only (mosh pp) pretty-print)
        (mosh control)
        (mosh))

;; generate lib/srfi/n.sld from lib/srfi/%3a.mosh.sls
(define (main args)
  (let1 sexp* (file->sexp-list (second args))
    (match (car sexp*)
      [('library ('srfi name) ('export e-spec* ...) ('import i-spec* ...) body ...)
        (let* ([name (symbol->string name)]
               [n (substring name 1 (string-length name))]
               [n (string->number n)]
               [path (format #f "lib/srfi/~a.sld" n)])
          (call-with-port (open-file-output-port path (make-file-options '(no-fail)) 'block (native-transcoder))
            (lambda (p)
              (format p ";; Generated by ~a\n" (first args))
              (pretty-print `(define-library (srfi ,n) (export ,@e-spec*) (import ,@i-spec*) ,@body) p))))])))

(main (command-line))