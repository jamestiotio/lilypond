;;;; encoding.scm -- font encoding
;;;;
;;;;  source file of the GNU LilyPond music typesetter
;;;; 
;;;; (c) 2004 Jan Nieuwenhuizen <janneke@gnu.org>

;; WIP
;; encoding.ly:
;; #(display (reencode-string "adobe" "latin1" "hell� f�eb�r"))
;;


(define-public (read-encoding-file file-name)
  "Read .enc file, return (COMMAND-NAME . VECTOR-OF-SYMBOLS)."
  (let* ((path (ly:kpathsea-find-file file-name))
	 (unused (if (string? path) #t (ly:warn "can't find ~s" file-name)))
	 (raw (ly:gulp-file path))
	 (string (regexp-substitute/global #f "%[^\n]*" raw 'pre "" 'post))
	 (command (match:substring
		   (string-match "/([^ \t\n\r]*)[ \t\n\r]*[[]" string) 1))
	 (encoding (match:substring (string-match "[[](.*)[]]" string) 1))
	 (ps-lst (string-tokenize encoding))
	 (lst (map (lambda (x) (string->symbol (substring x 1))) ps-lst))
	 (vector (list->vector lst)))
    (cons command vector)))

(define (make-encoding-table encoding-vector)
  "Return a hash table mapping names to chars. ENCODING-VECTOR is a
vector of symbols."

  (let* ((h (make-hash-table 256)))
    
    (for-each
     (lambda (i)
       (hash-set! h (vector-ref encoding-vector i)
		  (integer->char i)))
     (iota 256))

    h))

(define-public (reencode-string mapping str)
  "Apply MAPPING, a vector of [0..256) -> char, to STR"
  (string-map (lambda (chr)
		(vector-ref mapping (char->integer chr)))
	      str))

(define-public (make-encoding-mapping input-encoding output-encoding)
  "Contruct a mapping by applying output-encoding after input-encoding "
  (list->vector
   (map
    (lambda (byte)
      (let ((new-char (hash-ref
		       output-encoding (vector-ref input-encoding byte) #f)))
		       ;;input-encoding (vector-ref output-encoding byte) #f)))

	;; substitute space for unknown characters.
	(if (char? new-char)
	    new-char
	    #\ )))
    (iota 256))))


(define (get-coding-from-file file-name)
  "Read FILE-NAME, return a list containing encoding vector and table"
   (let* ((coding (read-encoding-file file-name))
	  (command (car coding))
	  (vector (cdr coding))
	  (table (make-encoding-table vector)))
    (list command vector table)))

;; coding-alist maps NAME -> (list FILE-NAME COMMAND VECTOR TAB)
(define coding-alist
  
  (map (lambda (x)
	 (cons (car x)
	       (cons (cdr x) (delay (get-coding-from-file (cdr x))))))
       '(
	 ;; teTeX font (output) encodings
	 ("TeX-typewriter-text" . "09fbbfac.enc") ;; cmtt10
	 ("TeX-math-symbols" . "10037936.enc") ;; cmbsy
	 ("ASCII-caps-and-digits" . "1b6d048e.enc") ;; cminch
	 ("TeX-math-italic" . "aae443f0.enc")  ;; cmmi10
	 ("TeX-extended-ASCII" . "d9b29452.enc")
	 ("TeX-text" . "cmr.enc")
	 ("TeX-text-without-f-ligatures" . "0ef0afca.enc")
	 ("Extended-TeX-Font-Encoding---Latin" . "tex256.enc")
	 ("AdobeStandardEncoding" . "8a.enc")
	 ("T1" . "tex256.enc")
	 ("adobe" . "8a.enc")
	 ;; EC-fonts-mftraced
	 ("ec" . "EC.enc")
	 ;; lmodern, encoding flavour latin1
	 ("cork-lm" . "cork-lm.enc")
	 
	 ;; input encodings
	 ("latin1" . "latin1.enc")
	 ("cork" . "cork.enc")

	 ;; LilyPond FETA music font
	 ("fetaBraces" . "feta-braces-a.enc")
	 ("fetaDynamic" . "feta-din10.enc")
	 ("fetaNumber" . "feta-nummer10.enc")
	 ("fetaMusic" . "feta20.enc")
	 ("parmesanMusic" . "parmesan20.enc"))
       ))

;; FIXME: this is broken, cannot get font encoding from font/AFM file,
;; should use encoding from font-tree in fonts.scm
(define (get-coding coding-name)
  (let ((entry (assoc-get coding-name coding-alist)))
    (if entry
	(cons (car entry) (force (cdr entry)))
	(if (equal? coding-name "feta-music")
	    (begin
	      (ly:warn "installation problem: deprecated encoding requested: ~S" coding-name)
	      (exit 1))
	    (let ((fallback "latin1"))
	      (ly:programming-error "no such encoding: ~S" coding-name)
	      (ly:programming-error "programming error: cross thumbs, using: ~S:" fallback)
	      (get-coding fallback))))))

(define-public (get-coding-file-name coding-name)
  (car (get-coding coding-name)))

(define-public (get-coding-command coding-name)
  (cadr (get-coding coding-name)))

(define-public (get-coding-vector coding-name)
  (caddr (get-coding coding-name)))

(define-public (get-coding-table coding-name)
  (cadddr (get-coding coding-name)))


(define-public (decode-byte-string encoding-name str)
  "Return vector of glyphname symbols that correspond to string,
assuming that STR is byte-coded using ENCODING-NAME."

  (let* ((coding-vector (get-coding-vector encoding-name))
	 (len (string-length str))
	 (output-vector (make-vector len '.notdef)))

    (do
	((idx 0 (1+ idx)))
	((>= idx len) output-vector)
      (vector-set! output-vector idx
		     (vector-ref coding-vector
				 (char->integer (string-ref str idx)))))))
