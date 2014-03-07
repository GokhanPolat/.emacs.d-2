;; Time-stamp: <2014-03-07 14:46:20 kmodi>

;; KEY BINDINGS

;; The way to figure out how to type a particular key combination or to know
;; what a particular key combination does, do help on a key `C-h k`, and type
;; the keystrokes you're interested in. What Emacs shows in the Help buffer is
;; the string you can pass to the macro 'kbd.

(global-set-key [f1]       'goto-line) ;; Default `M-g M-g` for `goto-line'

(global-set-key [f2]       'menu-bar-mode) ;; Toggle the menu bar: File|Edit|Options|..
;; (when (boundp 'setup-desktop-loaded)
;;   (global-set-key [S-f2]     'session-save)) ;; Save the current desktop session
(global-set-key [S-f2]     'desktop-save-in-desktop-dir)

;; `boundp` returns t if SYMBOL's value is not void.
(when (boundp 'setup-editing-loaded)
  (global-set-key [f3]       'toggle-comment-on-line-or-region))
;; (global-set-key [S-f3]     'uncomment-region) ;; and also to add comment to end of current line

(global-set-key [f4]       'kmacro-end-or-call-macro) ;; end macro recording/call last macro
(global-set-key [S-f4]     'start-kbd-macro) ;; start macro recording
(global-set-key [C-f4]     'start-kbd-macro) ;; start macro recording

(global-set-key [f5]       'revert-buffer)
(when (boundp 'setup-windows-buffers-loaded)
  (global-set-key [S-f5]   'revert-all-buffers))
;; (when (boundp 'setup-smart-compile-loaded)
;;   (global-set-key [C-f5]   'save-compile-execute))

;; (when (boundp 'setup-occur-loaded)
;;   (global-set-key [f6]     'multi-occur-in-this-mode) ;; search the regexp in all buffers with current major mode
;;   (global-set-key [C-f6]   'multi-occur-in-matching-buffers) ;; search the regexp in buffers matching the regexp
;;   )
;; (global-set-key [f6] )

;; (global-set-key [f7] )

;; F8 key can't be used as it launches the VNC menu
;; It can though be used with shift/ctrl/alt keys
(when (boundp 'setup-visual-loaded)
  (global-set-key [S-f8]   'toggle-presentation-mode))

(global-set-key [f9]       'eval-region)
(global-set-key [S-f9]     'eshell)

(when (boundp 'setup-sos-loaded)
  (global-set-key [f10]    'sos-co)
  (global-set-key [S-f10]  'sos-ci)
  (global-set-key [C-f10]  'sos-discardco))

(when (boundp 'setup-magit-loaded)
  (global-set-key [f11]    'magit-status)
  (global-set-key [S-f11]  'magit-push)
  (global-set-key [M-f11]  'magit-pull)
  )

(when (boundp 'setup-verilog-loaded)
  (global-set-key [f12]    'verilog-goto-defun)) ;; jump to the module definition file


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Unset keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "C-z")) ;; it is bound to `suspend-frame' by default
;; suspend-frame can be called using `C-x C-z` too. And `C-z` is used as prefix
;; key in tmux. So removing the `C-z` binding from emacs makes it possible to
;; use emacs in -nw (no window) mode in tmux if needed without any key binding
;; contention.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom key map: modi-map
;; Source: http://stackoverflow.com/questions/1024374/how-can-i-make-c-p-an-emacs-prefix-key-for-develperlysense
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-prefix-command 'modi-map)
(global-set-key (kbd "C-x m") 'modi-map) ;; overriding the default binding to `compose-mail'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Desktop
;; Setting a secondary key binding for saving session as `S-F2` doesn't work
;; when emacs is in terminal mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (boundp 'setup-desktop-loaded)
  (define-key modi-map (kbd "d")  'session-save)) ;; C-x m d (save desktop)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smex package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-smex-loaded)
  ;; reworking key bindings for smex
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; old M-x
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Windows, Buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Resize windows
;; Use co-located , . ; ' keys to control window size
(global-set-key (kbd "C-,")       'shrink-window-horizontally)
(global-set-key (kbd "C-.")       'enlarge-window-horizontally)
(global-set-key (kbd "C-;")       'shrink-window) ;; make window shorter
;; Don't let verilog-mode redefine the `C-;` key to (electric-verilog-semi-with-comment)
(when (boundp 'setup-verilog-loaded)
  (add-hook 'verilog-mode-hook
            '(lambda ()
               (define-key verilog-mode-map (kbd "C-;") 'shrink-window))))
(global-set-key (kbd "C-'")       'enlarge-window) ;; make window taller

;; Make Control+mousewheel do increase/decrease font-size
;; Source: http://ergoemacs.org/emacs/emacs_mouse_wheel_config.html
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase) ;; C + wheel-up
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease) ;; C + wheel-down


(global-set-key (kbd "C-c k")     'windmove-up) ;; switch to buffer on top
(global-set-key (kbd "C-c j")     'windmove-down) ;; switch to buffer on bottom
(global-set-key (kbd "C-c h")     'windmove-left) ;; switch to buffer on left
(global-set-key (kbd "C-c l")     'windmove-right) ;; switch to buffer on right

(global-set-key (kbd "C-c t")     'toggle-window-split) ;; convert between horz-split <-> vert-split
(global-set-key (kbd "C-c s")     'rotate-windows) ;; rotate windows clockwise. This will do the act of swapping windows if the frame is split into only 2 windows

(global-set-key (kbd "C-x C-b")   'ibuffer) ;; replace buffer-menu with ibuffer

(when (boundp 'setup-windows-buffers-loaded)
  ;; overriding the `C-x C-p binding with `mark-page' command
  (global-set-key (kbd "C-x C-p")   'show-copy-buffer-file-name)
  (global-set-key (kbd "C-x C-k")   'delete-current-buffer-file)
  (global-set-key (kbd "C-x C-r")   'rename-current-buffer-file)
  (define-key modi-map (kbd "b")    'switch-to-scratch-and-back) ;; C-x m b
  ;; overriding the `C-x C-o` binding with `delete-blank-lines'
  (global-set-key (kbd "C-x C-o")   'recentf-open-files)
  (define-key modi-map (kbd "l")    'load-current-file) ;; C-x m l
  (global-set-key (kbd "C-S-t")     'undo-kill-buffer) ;; same shortcut as for reopening closed tabs in browsers
  (global-set-key (kbd "<M-up>")    'scroll-down-dont-move-point)
  (global-set-key (kbd "<M-down>")  'scroll-up-dont-move-point)
  ;; Change the default `M-left` key binding from `left-word'
  ;; The same function anyways is also bound to `C-left`
  (global-set-key (kbd "<M-left>")  'scroll-other-window-down-dont-move-point)
  ;; Change the default `M-right` key binding from `right-word'
  ;; The same function anyways is also bound to `C-right`
  (global-set-key (kbd "<M-right>") 'scroll-other-window-up-dont-move-point)
)

;; Print to printer defined by env var `PRINTER'
(define-key modi-map (kbd "p")    'ps-print-buffer-with-faces) ;; C-x m p

;; Cycle the buffers in reverse order than what happens with `C-x o`
(global-set-key (kbd "<C-tab>")   'other-window) ;; alternative shortcut for `C-x o`
(global-set-key (kbd "C-x O")
                (lambda ()
                  (interactive)
                  (other-window -1)))

(when (boundp 'setup-dired-loaded)
  ;; Change the default `C-x C-d` key binding from `ido-list-directory'
  (global-set-key (kbd "C-x C-d") 'dired-single-magic-buffer)
  ;; Change the default `C-x C-j` key binding from  `dired-jump'
  ;; dired magic buffer is now used instead of the default dired for the same action
  (global-set-key (kbd "C-x C-j")
                  (lambda()
                    (interactive)
                    (dired-single-magic-buffer default-directory)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Navigation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Move more quickly
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

;; Scroll down; does the same as `M-v'. It makes scrolling up and down quick
;; as the `scroll-up' is bound to `C-v'.
(global-set-key (kbd "C-S-v") 'scroll-down)

;; NOTE: `C-[` key combination is the same as pressing the meta key Esc|Alt
;; Do NOT reconfigure that key combination.
(global-set-key (kbd "C-}") 'forward-paragraph)
(global-set-key (kbd "M-}") 'forward-paragraph) ;; default key-binding for `forward-paragraph'
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "C-{") 'backward-paragraph)
(global-set-key (kbd "M-{") 'backward-paragraph) ;; default key-binding for `backward-paragraph'
(global-set-key (kbd "M-[") 'backward-paragraph)

(global-set-key (kbd "C-c f") 'follow-mode) ;; Toggle Follow-mode
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Follow-Mode.html
;; Follow-mode is a minor mode that makes 2 or more windows, all showing the same
;; buffer/file, scroll as a single tall virtual window. To use Follow mode, go
;; to a frame with just one window, split it into two side-by-side windows using
;; C-x 3, and then type M-x follow-mode. From then on, you can edit the buffer
;; in either of the windows, or scroll either one; the other window follows it.
;; In Follow mode, if you move point outside the portion visible in one window
;; and into the portion visible in the other window, that selects the other
;; window again, treating the two as if they were parts of one large window.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing | Search | Highlight
;; visual-regexp package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x d")        'delete-region)

(when (boundp 'setup-editing-loaded)
  (global-set-key (kbd "C-c C-d")     'insert-current-date-time)
  (global-set-key (kbd "C-c C-t")     'insert-current-time)

  (global-set-key (kbd "C-S-d")       'duplicate-current-line-or-region)

  ;; override the binding of `C-x =` for `what-cursor-position'
  (global-set-key (kbd "C-x =")       'align-to-equals) ;; align all = signs in selected region
  (global-set-key (kbd "C-x \\")      'align-regexp)  ;; align selected region to the entered regexp
  ;; align multiple columns in the selected region. Of course all the selected
  ;; lines must have the same number of columns of groups of non-space characters
  (global-set-key (kbd "C-x |")       'align-columns)

  (define-key modi-map (kbd "x")      'eval-and-replace-last-sexp) ;; C-x m x
  (define-key modi-map (kbd "c")      'toggle-comment-on-line-or-region) ;; C-x m c
  )

(when (boundp 'setup-drag-stuff-loaded)
  (global-set-key (kbd "C-\"")         'drag-stuff-up)
  (global-set-key (kbd "C-:")         'drag-stuff-up)
  (global-set-key (kbd "C-?")         'drag-stuff-down)
  (global-set-key (kbd "<C-S-left>")  'drag-stuff-left)
  (global-set-key (kbd "<C-S-right>") 'drag-stuff-right)
  )

;; Insert a newline at the current cursor location, while not moving the cursor
(global-set-key (kbd "C-o")          'open-line)
;; Join the following line onto the current one
(global-set-key (kbd "C-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))
(global-set-key (kbd "M-j")          'comment-indent-new-line)
(global-set-key (kbd "C-M-j")        'comment-indent-new-line)

(when (boundp 'setup-search-loaded)
  (global-set-key (kbd "C-S-s")      'isearch-current-symbol)
  (global-set-key (kbd "C-S-r")      'isearch-backward-current-symbol)
  (define-key modi-map (kbd "s")     'search-all-buffers) ;; C-x m s

  ;; replace the emacs default query-replace
  (global-set-key (kbd "M-%")        'anzu-query-replace)
  (global-set-key (kbd "C-c r")      'anzu-replace-at-cursor-thing)
  )

(when (boundp 'setup-visual-regexp-loaded)
  ;; replace the emacs default query-replace-regexp
  (global-set-key (kbd "C-M-%")      'vr/query-replace)
  (global-set-key (kbd "C-c q")      'vr/query-replace))

(when (boundp 'setup-highlight-loaded)
  (define-key modi-map (kbd "h")  'highlight-frame-toggle) ;; C-x m h
  (define-key modi-map (kbd "H")  'clear-highlight-frame) ;; C-x m H
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visual | Looks
;; hl-line+ package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x t")     'toggle-truncate-lines)

(when (boundp 'setup-visual-loaded)
  (define-key modi-map (kbd "g")  'hidden-mode-line-mode) ;; C-x m g (no mode line, no Ground)
  (define-key modi-map (kbd "f")  'bzg-big-fringe-mode) ;; C-x m f
  )

(when (boundp 'setup-hl-line+-loaded)
  (global-set-key (kbd "C-c C-f") 'hl-line-flash) ;; flash the current line
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-multiple-cursors-loaded)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->")         'mc/mark-next-like-this)
  (global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)

  (define-key modi-map (kbd "m")      'mc/edit-all-like-this) ;; C-x m m
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm-swoop package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-helm-loaded)
  (global-set-key (kbd "M-i") 'helm-multi-swoop-all)
  ;; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-yasnippet-loaded)
  ;; unset the key binding for `C-q` which is set for `(quoted-insert ARG)`.
  ;; Example: by default pressing `C-q` and then `C-l` inserts 
  (global-unset-key (kbd "C-q"))
  ;; Now key bindings starting with C-q key sequence are used in yasnippet
  ;; bindings. Example: In verilog-mode, pressing `C-q i` inserts an if
  ;; statement. If a region is selected, the if statement wraps that region.
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-org-loaded)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-iswitchb)
  (global-set-key (kbd "C-c c") 'org-capture))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expand-region package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-expand-region-loaded)
  (global-set-key (kbd "C-=") 'er/expand-region))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-jump-mode package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-ace-jump-mode-loaded)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  ;; remove the conf-mode-map to `C-c Space` as it overrides the ace-jump-mode
  ;; binding, eg. while editing .tmux.conf
  ;; (define-key conf-mode-map (kbd "C-c SPC") nil)
  ;; FIXME: "C-c SPC" binding conflicts with default bindings in conf-mode-map
  ;;        org-mode. Need to fix that. For now, creating an alternate
  ;;        binding for ace-jump-mode
  ;; Alternate binding for `ace-jump-mode'
  (define-key modi-map (kbd "a")  'ace-jump-mode) ;; C-x m a
  )
;;         `ace-jump-mode-BINDING' -> `ace-jump-word-mode'
;;     C-u `ace-jump-mode-BINDING' -> `ace-jump-char-mode'
;; C-u C-u `ace-jump-mode-BINDING' -> `ace-jump-line-mode'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key-chord package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-key-chord-loaded)

  ;; Alternative for `M-x'
  (key-chord-define-global ";'"   'smex)

  ;; Alternative for `F*' keys
  (key-chord-define-global "1q"   'goto-line)
  (key-chord-define-global "2w"   'menu-bar-mode)
  (when (boundp 'setup-editing-loaded)
    (key-chord-define-global "3e" 'toggle-comment-on-line-or-region))
  (key-chord-define-global "5t"   'revert-buffer)
  ;; (key-chord-define-global "6y"   )
  ;; (key-chord-define-global "7u"   )
  (when (boundp 'setup-visual-loaded)
    (key-chord-define-global "8i" 'toggle-presentation-mode))
  (key-chord-define-global "9o"   'eval-region)
  (when (boundp 'setup-sos-loaded)
    (key-chord-define-global "0p" 'sos-co))
  (when (boundp 'setup-magit-loaded)
    (key-chord-define-global "-[" 'magit-status))
  ;; (key-chord-define-global "=]"   )

  ;; Editing
  (key-chord-define-global "UU"   'undo)

  ;; Windows and buffers
  (key-chord-define-global "OO"   'other-window)
  (key-chord-define-global "XX"   ( lambda()
                                    (interactive)
                                    (kill-buffer (current-buffer))))
  (key-chord-define-global "ZZ"   'toggle-between-buffers)

  ;; Navigation
  (key-chord-define-global "m,"   'beginning-of-buffer)
  (key-chord-define-global ",."   'end-of-buffer)

  (key-chord-define-global "p["   'windmove-left)
  (key-chord-define-global "[]"   'windmove-right)

  (when (boundp 'setup-w3m-loaded)
    (key-chord-define-global "-=" 'wicked/toggle-w3m)
    )

  ;; Alternate binding for `ace-jump-mode'
  (when (boundp 'setup-ace-jump-mode-loaded)
    (key-chord-define-global "]\\" 'ace-jump-mode))

  (when (boundp 'setup-navigation-loaded)
    ;; Note that repeatedly calling the `iy-go-tochar' key-chords without first
    ;; quitting the previous `iy-go-to-char' call will cause emacs to crash.
    (key-chord-define-global "fg" 'iy-go-to-char)
    (key-chord-define-global "zx" 'iy-go-to-char-backward)
    (key-chord-define-global "bb" 'iy-go-to-char-backward)
    (key-chord-define-global "BB" 'iy-go-to-char-backward))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ctags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-ctags-loaded)
  ;; overriding the default binding to `find-tag'
  (global-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-misc-loaded)
  (global-set-key (kbd "C-x C-c")  'save-desktop-save-buffers-kill-emacs)
)
(global-set-key (kbd "C-x M-c")   'save-buffers-kill-emacs)


(provide 'setup-key-bindings)
