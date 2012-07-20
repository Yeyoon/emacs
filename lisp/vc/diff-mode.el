(eval-when-compile (require 'cl))
  '(;; From Pavel Machek's patch-mode.
    ("n" . diff-hunk-next)
    ;; From compilation-minor-mode.
    ("}" . diff-file-next)
    ;; From XEmacs's diff-mode.
    ;;("." . diff-goto-source)		;display-buffer
    ;;("f" . diff-goto-source)		;find-file
    ("o" . diff-goto-source)		;other-window
    ;;("w" . diff-goto-source)		;other-frame
    ;;("N" . diff-narrow)
    ;;("h" . diff-show-header)
    ;;("j" . diff-show-difference)	;jump to Nth diff
    ;;("q" . diff-quit)
    ;; Not useful if you have to metafy them.
    ;;(" " . scroll-up)
    ;;("\177" . scroll-down)
    ("R" . diff-reverse-direction))
    (((class color) (background light))
    (((class color) (background dark))
     :foreground "green" :weight bold)
    (((class color) (background light))
     :foreground "green" :weight bold)
    (((class color) (background dark))
  '((t :inherit diff-changed))
  '((t :inherit diff-changed))
    (((class color) (background light))
     :foreground "magenta" :weight bold :slant italic)
    (((class color) (background dark))
     :foreground "yellow" :weight bold :slant italic))
     (1 diff-indicator-changed-face) (2 diff-changed-face))
    ("^Index: \\(.+\\).*\n"
                      (case style
                        (unified (concat (if diff-valid-unified-empty-line
                                             "^[^-+# \\\n]\\|" "^[^-+# \\]\\|")
                                         ;; A `unified' header is ambiguous.
                                         diff-file-header-re))
                        (context "^[^-+#! \\]")
                        (normal "^[^<>#\\]")
                        (t "^[^-+#!<> \\]"))
  "Move back to beginning of hunk.
If TRY-HARDER is non-nil, try to cater to the case where we're not in a hunk
but in the file header instead, in which case move forward to the first hunk."
  (unless (looking-at diff-hunk-header-re)
       (if (not try-harder)
           (error "Can't find the beginning of the hunk")
         (diff-beginning-of-file-and-junk)
         (diff-hunk-next))))))
  (save-excursion
    (if arg (diff-beginning-of-file) (diff-beginning-of-hunk 'try-harder))
    (narrow-to-region (point)
		      (progn (if arg (diff-end-of-file) (diff-end-of-hunk))
			     (point)))
    (set (make-local-variable 'diff-narrowed-to) (if arg 'file 'hunk))))

  "Kill current hunk."
  (diff-beginning-of-hunk)
  (let* ((start (point))
         ;; Search the second match, since we're looking at the first.
	 (nexthunk (when (re-search-forward diff-hunk-header-re nil t 2)
		     (match-beginning 0)))
	 (firsthunk (ignore-errors
		      (goto-char start)
		      (diff-beginning-of-file) (diff-hunk-next) (point)))
	 (nextfile (ignore-errors (diff-file-next) (point)))
    (goto-char start)
    (if (and firsthunk (= firsthunk start)
	     (or (null nexthunk)
		 (and nextfile (> nexthunk nextfile))))
	;; It's the only hunk for this file, so kill the file.
	(diff-file-kill)
      (diff-end-of-hunk)
      (kill-region start (point)))))
  "diff \\|index \\|\\(?:deleted file\\|new\\(?: file\\)?\\|old\\) mode")
  (let ((orig (point))
        (start (progn (diff-beginning-of-file-and-junk) (point)))
	 (inhibit-read-only t))
    (diff-end-of-file)
    (if (looking-at "^\n") (forward-char 1)) ;`tla' generates such diffs.
    (if (> orig (point)) (error "Not inside a file diff"))
    (kill-region start (point))))
      (while (re-search-forward re end t) (incf n))
	(start (progn (diff-beginning-of-hunk) (point))))
       (dolist (rf diff-remembered-files-alist)
	   (if (and newfile (file-exists-p newfile)) (return newfile))))
       (do* ((files fs (delq nil (mapcar 'diff-filename-drop-dir files)))
	     (file nil nil))
		(setq file (do* ((files files (cdr files))
				 (file (car files) (car files)))
         (let ((file (expand-file-name (or (first fs) ""))))
			(case (char-after)
				  (progn (forward-char 1)
					 (insert " "))
				(delete-char 1)
				(insert "! "))
			      (backward-char 2))
						     (= (char-after) ?+))
				 (delete-region (point) last-pt) (setq modif t)))
                          (?\n (insert "  ") (setq modif nil) (backward-char 2))
			  (t (setq modif nil))))))
		      (if (save-excursion (re-search-forward "^\\+.*\n-" nil t))
			(case (char-after)
				  (progn (forward-char 1)
					 (insert " "))
				(delete-char 1)
				(insert "! "))
			      (backward-char 2))
						     (not (eobp)))
				 (setq delete t) (setq modif t)))
			  (t (setq modif nil)))
                    (case (char-after)
                      (?\s           ;merge with the other half of the chunk
                         (case (char-after pt2)
                           ((?! ?+)
                                    (prog1 (buffer-substring (+ pt2 2) endline2)
                           (t (setq reversible nil)
                      (t (setq reversible nil) (forward-line 1))))
	      (while (case (setq c (char-after))
			   (delete-char 1) (insert "+") t)
			   (delete-char 1) (insert "-") t)
		       ((?\\ ?#) t)
		       (t (when (and first last (< first last))
	      (case (char-after)
		(?\s (incf space))
		(?+ (incf plus))
		(?- (incf minus))
		(?! (incf bang))
		((?\\ ?#) nil)
		(t  (setq space 0 plus 0 minus 0 bang 0)))
  ;; Set up `whitespace-mode' so that turning it on will show trailing
  ;; whitespace problems on the modified lines of the diff.
  (set (make-local-variable 'whitespace-style) '(face trailing))
  (set (make-local-variable 'whitespace-trailing-regexp)
       "^[-\+!<>].*?\\([\t ]+\\)$")
          (decf count) t)
                (case (char-after)
                  (?\s (decf before) (decf after) t)
                     (decf before) t))
                  (?+ (decf after) t)
                  (t
                     (decf before) (decf after) t)
	   (char-offset (- (point) (progn (diff-beginning-of-hunk 'try-harder)
                                          (point))))
  (destructuring-bind (buf line-offset pos old new &optional switched)
      ;; Sometimes we'd like to have the following behavior: if REVERSE go
      ;; to the new file, otherwise go to the old.  But that means that by
      ;; default we use the old file, which is the opposite of the default
      ;; for diff-goto-source, and is thus confusing.  Also when you don't
      ;; know about it it's pretty surprising.
      ;; TODO: make it possible to ask explicitly for this behavior.
      ;;
      ;; This is duplicated in diff-test-hunk.
      (diff-find-source-location nil reverse)
  (destructuring-bind (buf line-offset pos src _dst &optional switched)
      (diff-find-source-location nil reverse)
    (destructuring-bind (buf line-offset pos src _dst &optional switched)
	(diff-find-source-location other-file rev)
    (destructuring-bind (&optional buf _line-offset pos src dst switched)
        ;; Use `noprompt' since this is used in which-func-mode and such.
	(ignore-errors                ;Signals errors in place of prompting.
          (diff-find-source-location nil nil 'noprompt))
  (let* ((char-offset (- (point) (progn (diff-beginning-of-hunk 'try-harder)
                                        (point))))
	 (opts (case (char-after) (?@ "-bu") (?* "-bc") (t "-b")))
	      (case status
		(0 nil)			;Nothing to reformat.
		   ;; Remove the file-header.
		   (when (re-search-forward diff-hunk-header-re nil t)
		     (delete-region (point-min) (match-beginning 0))))
		(t (goto-char (point-max))
     :background "grey85")
     :background "grey60")
    (((class color) (background light))
     :background "yellow")
    (((class color) (background dark))
     :background "green")
    (t :weight bold))
                  (beg1 end1 beg2 end2 props &optional preproc))
    (diff-beginning-of-hunk 'try-harder)
           (props '((diff-mode . fine) (face diff-refine-change)))
      (case style
        (unified
                                props 'diff-refine-preproc)))
        (context
                                  props 'diff-refine-preproc))))
        (t ;; Normal diffs.
                                  props 'diff-refine-preproc))))))))