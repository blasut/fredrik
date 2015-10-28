(defparameter *webgunk-cookie-jar* ())

(defun http-request (uri &rest args)
  "A wrapper around DRAKMA:HTTP-REQUEST which converts octet array
which it sometimes returns to normal string"
  (let* ((result-mv (multiple-value-list (apply #'drakma:http-request uri `(,@args :cookie-jar ,*webgunk-cookie-jar*))))
         (result (car result-mv)))
    (apply #'values
           (if (and (arrayp result)
                    (equal (array-element-type result) '(unsigned-byte 8)))
               (flexi-streams:octets-to-string result)
               result)
           (cdr result-mv))))

(defun parse-url (url &rest args)
  "Parse HTTP request response to CXML-DOM"
  (let ((response (apply #'http-request url args)))
    (chtml:parse response (cxml-dom:make-dom-builder))))

(defun get-all-hrefs (url)
  (let* ((document (parse-url url))
         (links (css:query ".companies-list a" document)))
    (remove-duplicates (loop for link in links collect (buildnode:get-attribute link "href"))))) 

(defun get-all-bars ()
  (get-all-hrefs "http://www.gastlistan.com/utestallen/search/city:Stockholm/clubType:Bar/extraTyp:all/date:all/hours:all"))

(defun get-all-nightclubs ()
  (get-all-hrefs "http://www.gastlistan.com/utestallen/search/city:Stockholm/clubType:Nattklubb/extraTyp:all/date:all/hours:all"))
