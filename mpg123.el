;;; -*- Emacs-Lisp -*-
;;; A front-end program for mpg123
;;; (c)1999 by HIROSE Yuuji [yuuji@gentei.org]
;;; $Id$
;;; Last modified Thu Jun 24 17:01:49 1999 on vfr
;;; Update count: 320

;;[Commentary]
;;	
;;	This package is a front-end program for mpg123 audio player.
;;	mpg123の再生フロントエンドです。
;;	
;;[Requirement]
;;	
;;	The `mpg123' program version 0.59q and enough CPU power to run
;;	it.
;;	mpg123 0.59qとそれを走らすのに十分なCPUパワー。
;;	最低でもMMX??
;;	
;;[Installation]
;;	
;;	You have to install mpg123 0.59q or later first, and get it work
;;	fine.   Check `mpg123  -v' option  if it  displays  the decoding
;;	frame number or not.  If it looks good, then the preparation has
;;	been  done.    Install  this  emacs-lisp   into  your  load-path
;;	directory.  And put the expression below into your ~/.emacs.
;;	
;;	  [~/.emacs]
;;		(autoload 'mpg123 "mpg123" "A Front-end for mpg123" t)
;;	
;;	まず、mpg123の正常動作を確認してから上の行を~/.emacsに追加します。
;;	なおmpg123は0.59q以上でないと正常に動作しない可能性があります(もっ
;;	と新しいのが出たらまた怪しいかもしれん…)。mpg123 に -v オプショ
;;	ンをつけて起動し音楽の再生とともにデコード中のフレーム番号が画面
;;	に表示されるかどうか確認してください。これがうまく行かないとこの
;;	プログラムもうまく動きません。
;;	
;;[How to Play the music]
;;	
;;	It is  assumed that you  already have MPEG1  audio LayerI/II/III
;;	files - you might be only  familiar with MPEG1 Layer III aka mp3
;;	- in the  certain directory.  This program plays  all music in A
;;	direcotry.  If you want to listen, exec Emacs and type:
;;	
;;		M-x mpg123 RET
;;		SomeMP3DirectoryName RET
;;	
;;	Then you will get the music  list in the directory.  Type SPC to
;;	start the  music.  All key bindings  are shown at  the bottom of
;;	music list buffer.  Please take a look at it.
;;	
;;	既に MPEG1 audio Layer I/II/III ファイルは持ってるものとして説明
;;	します(たぶんいわゆるMP3しか持ってないと思うけど気にしないわしも
;;	Layer2と3は作ったことすらない)。で、そのファイルはきっとどこかの
;;	ディレクトリに整理しておいてあると思うので、音楽を聞きたくなった
;;	ら、まずEmacsを起動し、
;;	
;;		M-x mpg123 ぺし
;;		ディレクトリ名 ぺし
;;	
;;	と打つ。と、そのディレクトリにある音楽ファイル一覧が出て来るので、
;;	聞きたい曲に合わせてSPCを打つと演奏が始まる。その他のキーコマン
;;	ドは音楽一覧バッファの末尾に表示されているのでそっちを見るべし。
;;	
;;	
;;[Configuration]
;;	
;;	Because this program is designed for mpg123 0.59q, there not so
;;	many configurable aspects.  Here are the customization
;;	variables.
;;	
;;	  [Variable]		[Default value/Meaning]
;;	  mpg123-command	"mpg123"
;;				Command name of mpg123
;;	  mpg123-mixer-command	"mixer"
;;				Command name of mixer(FreeBSD)
;;	  mpg123-preserve-playtime t
;;				If you want to mpg123 to play all music
;;				from the beginning even if the last
;;				played time is shown in the buffer, set
;;				this variable to `nil'.
;;	  mpg123-startup-volume 30
;;				Initialize sound volume with this value.
;;	
;;	
;;	ほぼ mpg123 0.59q に決め打ちという風情なので、あまりいじれるとこ
;;	ろ無いけど、上に書いてある変数がいじれます。
;;	ワタシLinuxワッカリマセ〜ン! ほとんどのLinuxで通用する音量調節コ
;;	マンドがあったら教えてくださいな。
;;	aumix -v 「百分率」でええの?
;;	
;;[More comfortable]
;;	
;;	Yes, Emacs is the editor.  Even thought you are listening to the
;;	music, you have to edit something!! :)
;;	This program occupies one Emacs window.  Using this program
;;	without any window manager is hard job.  Please use this with
;;	windows.el - The Window Manager for Emacs - which can be
;;	obtained from http://www.gentei.org/~yuuji/software/.
;;	
;;	Emacs使ってるんだから聞くばっかりじゃなくて編集しなさい!  てこと
;;	で、全画面を消費するmpg123.elを素のEmacsで使ってたら大変。ためし
;;	に windows.el と一緒につこてみてくれ。フレームを使ってるときは別
;;	フレームでバックグラウンド再生、-nw で起動しているときは裏ウィン
;;	ドウでバックグラウンド再生できて、その裏ウィンドウといくつかの編
;;	集ウィンドウを切替えて使うなんて事も可能。もちろんこの文章も裏で
;;	mpg123を走らせながら書いてます。windows.el は
;;	http://www.gentei.org/~yuuji/software/ からどうぞ。
;;	
;;[Bugs]
;;	
;;	It is impossible to yank music line onto the end of list.
;;	曲リストの最後尾にスタックからの曲をyankできません。
;;	
;;[No Warranty]
;;	
;;	This  program is  free  software and  comes  with absolutely  NO
;;	WARRANTY.   The  author  is  not responsible  for  any  possible
;;	defects caused by this software.  You can freely modify this
;;	program for your convenience.  But if you want to publish
;;	modified program, please tell me before announcement.  Take it
;;	easy to write me comments, bug-reports.
;;							yuuji@gentei.org
;;	
;;	このプログラムはフリーソフトウェアとして配布します。このプログラ
;;	ムの利用によって生じたいかなる結果に対しても作者は責任を負いませ
;;	ん。コメントやバグレポートはおおいに歓迎しますので御気軽に御連絡
;;	ください。またプログラムに対する個人的な修正は自由にして頂いて構
;;	いませんが、それを公開したい場合は私まで御連絡ください。連絡は以
;;	下のアドレスまでお願いします(1999/6現在)。
;;							yuuji@gentei.org

(defvar mpg123-system-type
  (cond
   ((string-match "freebsd" (emacs-version))	'freebsd)
   ((string-match "netbsd" (emacs-version))	'netbsd)  ;not yet
   ((string-match "openbsd" (emacs-version))	'openbsd) ;not yet
   ((string-match "linux" (emacs-version))	'linux))) ;not yet maybe

(defvar mpg123-command "mpg123"
  "*Command name of mpg123 player. Need 0.59q or later.
mpg123のコマンド名。0.59qが必要。")
(defvar mpg123-mixer-command
  (cdr (assq mpg123-system-type
	     '((freebsd . "mixer") (linux . "aumix"))))
  "*Command name for mixer setting utility
mixer調節用コマンド")
(defvar mpg123-mixer-setvol-target-list
  (cdr (assq mpg123-system-type
	     '((freebsd . ("vol" "pcm")) (linux . '("-v")))))
  "*Option list for volume setting utility.
mixer調節コマンドの音量調節オプションのリスト")
(defvar mpg123-preserve-playtime t
  "When shift to other music, leave playing time of current music, or not")
(defvar mpg123-id3-tag-function 'mpg123:peek-tag
  "*Emacs-Lisp function for extracting ID3 tag.
MP3からID3を取得するための関数")
(defvar mpg123-startup-volume 30
  "*Default sound volume at startup of this program.
mpg123.el初回起動時の音量のデフォルト値.")
(defvar mpg123-default-repeat 0
  "*Default number of repetition of through playing.
再生のデフォルトのリピート回数")

(defvar mpg123-mode-map nil)
(setq mpg123-mode-map (make-keymap))
(define-key mpg123-mode-map "p" 'mpg123-prev-line)
(define-key mpg123-mode-map "n" 'mpg123-next-line)
(define-key mpg123-mode-map " " 'mpg123-play-stop)
(define-key mpg123-mode-map "\C-m" 'mpg123-play)
(define-key mpg123-mode-map "<" 'mpg123-<)
(define-key mpg123-mode-map ">" 'mpg123->)
(define-key mpg123-mode-map "m" 'mpg123-mark-position)
(define-key mpg123-mode-map "r" 'mpg123-refrain)
(define-key mpg123-mode-map "w" 'mpg123-where-is-mark)
(define-key mpg123-mode-map "-" 'mpg123-volume-decrease)
(define-key mpg123-mode-map "+" 'mpg123-volume-increase)
(define-key mpg123-mode-map "f" 'mpg123-forward)
(define-key mpg123-mode-map "b" 'mpg123-backward)
(define-key mpg123-mode-map "F" 'mpg123-forward-10)
(define-key mpg123-mode-map "B" 'mpg123-backward-10)
(define-key mpg123-mode-map "o" 'mpg123-open-new)
(define-key mpg123-mode-map "i" 'mpg123-increase-repeat-count)
(define-key mpg123-mode-map "d" 'mpg123-decrease-repeat-count)
(define-key mpg123-mode-map "k" 'mpg123-kill-line)
(define-key mpg123-mode-map "y" 'mpg123-yank-line)
(define-key mpg123-mode-map "s" 'mpg123-shuffle)
(define-key mpg123-mode-map "q" 'mpg123-quit)

;;;
;; Internal Work
;;;
(defvar mpg123*process nil)
(defvar mpg123*buffer "*mpg123*")
(defvar mpg123*info-buffer " *mpg123 info* ")
(defvar mpg123*cur-music-number nil)
(defvar mpg123*cur-playtime nil)
(defvar mpg123*cur-playframe nil)
(defvar mpg123*cur-start-frame "0")
(defvar mpg123*cur-play-marker nil)
(defvar mpg123*cur-repeat-count nil)
(defvar mpg123*music-alist nil)
(defvar mpg123*default-time-string "--:--/--:--\t")
(defvar mpg123*interrupt-p nil)
(defvar mpg123*end-of-list-marker nil "The end mark of music list")
(defvar mpg123*cur-volume nil)
(defvar mpg123*volume-marker nil)
(defvar mpg123*time-setting-mode nil)
(defvar mpg123*repeat-count-marker nil)

(defun mpg123:sound-p (f)
  "Check the file F is MPEG 1 Audio file or not."
  (and (> (nth 7 (file-attributes f)) 128) ;check file size > 128
       (let ((b (get-buffer-create " *mpg123tmp*"))
	     (file-coding-system-alist (list (cons "." 'no-conversion))) ;20
	     (file-coding-system-for-read)) ;19
	 (set-buffer b)
	 (erase-buffer)
	 (insert-file-contents f nil 0 2) ;insert 2bytes of the beginning
	 (goto-char (point-min))
	 (prog1 ; if short & 0xfff0 = 0xfff0, it is MPEG audio
	     (and (= (char-after 1) ?\xFF)
		  (= (logand (char-after 2) ?\xF0) ?\xF0))
	   (kill-buffer b)))))

(defun mpg123-next-line (arg)
  "Down line"
  (interactive "p")
  (forward-line arg)
  (if (mpg123:in-music-list-p)
      (skip-chars-forward "^:")))

(defun mpg123-prev-line (arg)
  "Up line"
  (interactive "p")
  (mpg123-next-line (- arg)))

;(defun mpg123:goto-playtime-position ()
;  (goto-char mpg123*cur-play-marker)
;  (move-to-column 3))
(defmacro mpg123:goto-playtime-position ()
  (list 'progn
	(list 'goto-char 'mpg123*cur-play-marker)
	(list 'move-to-column 3)))

; (defun mpg123:update-playtime (timestr)
;   "Update playing time string"
;   (set-buffer mpg123*buffer)
;   (let (buffer-read-only)
;     (mpg123:goto-playtime-position)
;     (delete-char 5)
;     (insert timestr)))
(defmacro mpg123:update-playtime (timestr)
  (list 'progn  ;; 'save-excursion  ??
	(list 'set-buffer (list 'marker-buffer 'mpg123*cur-play-marker))
	;(list 'set-buffer 'mpg123*buffer)
	(list 'let (list 'buffer-read-only)
	      (list 'mpg123:goto-playtime-position)
	      (list 'delete-char 5)
	      (list 'insert timestr))))

(defun mpg123:update-length (timestr)
  "Update music length time string"
  (set-buffer mpg123*buffer)
  (let (buffer-read-only)
    (mpg123:goto-playtime-position)
    (skip-chars-forward "^/")
    (forward-char 1)
    (delete-char 5)
    (insert timestr)))

(defun mpg123:update-volume (vollist)
  "Update volume display"
  (set-buffer mpg123*buffer)
  (let (buffer-read-only)
    (save-excursion
      (goto-char mpg123*volume-marker)
      (delete-region (point) (progn (skip-chars-forward "^\\]") (point)))
      (if (and (listp vollist) (integerp (car vollist)))
	  (insert (format "%03d:%03d" (car vollist) (cdr vollist)))
	(insert "N/A")))))

(defun mpg123:update-repeat-count ()
  "Update repetition meter"
  (set-buffer mpg123*buffer)
  (let (buffer-read-only)
    (save-excursion
      (goto-char mpg123*repeat-count-marker)
      (delete-region (point) (progn (skip-chars-forward "^\\]") (point)))
      (insert
       (cond
	((= mpg123*cur-repeat-count 0) "--")
	((= mpg123*cur-repeat-count -1) "oo")
	(t (format "%02d" mpg123*cur-repeat-count)))))))

(defun mpg123:repeat-check ()
  (cond
   ((= mpg123*cur-repeat-count -1) t)
   ((= mpg123*cur-repeat-count 0) nil)
   (t (setq mpg123*cur-repeat-count (1- mpg123*cur-repeat-count))
      (mpg123:update-repeat-count)
      mpg123*cur-repeat-count)))

(defun mpg123:set-music-info (n attr value)
  (let ((cur (cdr (assoc n mpg123*music-alist))))
    (setq cur (cons (cons attr value)
		    (delq (assq attr cur) cur)))
    (setq mpg123*music-alist
	  (cons (cons n cur)
		(delq (assoc n mpg123*music-alist) mpg123*music-alist)))))

;(defun mpg123:get-music-info (n attr)
;  (cdr (assq attr (assoc n mpg123*music-alist))))
(defmacro mpg123:get-music-info (n attr)
  (list 'cdr (list 'assq attr (list 'assoc n 'mpg123*music-alist))))


(defun mpg123:filter (proc mess)
  (if (stringp mess)
      (save-excursion
	;;(set-buffer mpg123*info-buffer)  ;heavy
	;;(insert mess)                    ;jobs
	(if (string-match "Time: \\(..:..\\)... +\\[\\(..:..\\)" mess)
	    (let ((s (substring mess (match-beginning 1) (match-end 1)))
		  l)
	      (and (not (string= s mpg123*cur-playtime))
		   (not mpg123*time-setting-mode)
		   (mpg123:update-playtime (setq mpg123*cur-playtime s)))
	      (or (mpg123:get-music-info mpg123*cur-music-number 'length)
		  (progn
		    (mpg123:set-music-info
		     mpg123*cur-music-number
		     'length
		     (setq
		      l (substring mess (match-beginning 2) (match-end 2))))
		    (mpg123:update-length l))
		  )))
	(if (string-match "Frame# +\\([0-9]+\\)" mess)
	    (setq mpg123*cur-playframe
		  (substring mess  (match-beginning 1) (match-end 1))))
	)))

(defun mpg123:sentinel (proc state)
  (cond
   ((string-match "^finished" state)
    (if mpg123*interrupt-p
	(progn
	  (setq mpg123*interrupt-p nil)
	  )
      (setq mpg123*time-setting-mode nil)
      (mpg123:update-playtime "--:--")
      (if (eq (get-buffer mpg123*buffer)
	      (marker-buffer mpg123*cur-play-marker))
	  (progn
	    (set-buffer mpg123*buffer)
	    (goto-char mpg123*cur-play-marker)
	    (mpg123-next-line 1)
	    (if (and (not (mpg123:in-music-list-p))
		     (mpg123:repeat-check))
		(goto-char (point-min)))
	    (mpg123:play)))))))

(defun mpg123:time2frame (timestr)
  "Convert time string (mm:ss) to frame number.(0.026s/f)"
  (string-match "\\(..\\):\\(..\\)" timestr)
  (let*((m (string-to-number
	    (substring timestr (match-beginning 1) (match-end 1))))
	(s (string-to-number
	    (substring timestr (match-beginning 2) (match-end 2))))
	(total (+ (* m 60) s)))
    (format "%d" (/ (* total 1000) 26))))

(defun mpg123:in-music-list-p ()
  (and (equal mpg123*buffer (buffer-name))
       (< (point) mpg123*end-of-list-marker)))

(defun mpg123:play (&optional startframe)
  "Play mp3 on current line."
  (save-excursion
    (set-buffer (get-buffer-create mpg123*info-buffer))
    (buffer-disable-undo)
    (erase-buffer))
  (beginning-of-line)
  (if (and mpg123*cur-play-marker
	   (markerp mpg123*cur-play-marker))
      (set-marker mpg123*cur-play-marker nil))
  (setq mpg123*cur-play-marker (point-marker))
  (skip-chars-forward " ")
  (if (or (not (looking-at "[0-9]"))
	  (not (mpg123:in-music-list-p)))
      nil ;;if not on music line, then exit
    (let ((last mpg123*cur-music-number) music p)
      (setq mpg123*cur-music-number
	    (string-to-int
	     (buffer-substring
	      (point)
	      (progn (skip-chars-forward "0-9") (point)))))
      (skip-chars-forward " ")
      (cond
       (startframe (setq mpg123*cur-start-frame startframe))
       ((or (looking-at mpg123*default-time-string)
	    ;;(not (equal last mpg123*cur-music-number))
	      )
	(setq mpg123*cur-start-frame "0"))
       (t
	(let ((time (buffer-substring
		     (point)
		     (progn (skip-chars-forward "^ /")(point)))))
	  (if (string= time mpg123*cur-playtime)
	      (setq mpg123*cur-start-frame mpg123*cur-playframe)
	    (setq mpg123*cur-start-frame (mpg123:time2frame time))))))
      (setq music (mpg123:get-music-info mpg123*cur-music-number 'filename))
      (setq mpg123*time-setting-mode nil)
      (set-process-filter
       (setq p (start-process "mpg123"
			      (current-buffer)
			      mpg123-command
			      "-v"
			      "-k" mpg123*cur-start-frame
			      music
			      ))
       'mpg123:filter)
      (message "%s %s.."
	       mpg123*cur-music-number
	       (mpg123:get-music-info mpg123*cur-music-number 'name))
      (set-process-sentinel p 'mpg123:sentinel))))

(defun mpg123*sure-kill (p)
  "Waiting process to be killed."
  (let ((retry (if (fboundp 'float) 50 5))) ;retry in seconds
    (while (and p (eq (process-status p) 'run)
		(>= (setq retry (1- retry)) 0))
      (interrupt-process p)
      (if (fboundp 'float)
	  (sleep-for (string-to-number "0.1"))
	(sleep-for 1))
      (message "Waiting for process to exit..."))
    (message "")
    (if (and p (eq (process-status p) 'run))
	(error "Cannot terminate %s process" (process-name p)))))

(defun mpg123-play-stop (&optional start-frame)
  "Play or Stop"
  (interactive)
  (let ((p (get-buffer-process (current-buffer)))
	now-stopped
	music)
    (if (and p (eq (process-status p) 'run))
	(progn
	  (interrupt-process p)
	  (message "PAUSE!")
	  (setq mpg123*interrupt-p t)
	  (setq now-stopped t)))
    (if (and now-stopped
	     (not mpg123*time-setting-mode)
	     (= (save-excursion (beginning-of-line) (point))
		(save-excursion (goto-char mpg123*cur-play-marker) (point))))
	nil ;if on the current music, do nothing (?)
      (mpg123*sure-kill p)
      (mpg123:play start-frame))))

(defun mpg123-play ()
  "PLAY(from the beginning of the music)."
  (interactive)
  (mpg123-play-stop "0"))

(defun mpg123-< (arg)
  "Rewind music by one."
  (interactive "p")
  (let ((p (get-buffer-process (current-buffer))))
    (cond
     ;;If currently playing, then rewind and start
     ((and p (eq (process-status p) 'run))
      (goto-char mpg123*cur-play-marker)
      (if (and (stringp mpg123*cur-playtime)
	       (string< mpg123*cur-playtime "00:02")) ; is 00:02 readsonable?
	  (mpg123-prev-line arg))
      (setq mpg123*interrupt-p t)
      (mpg123*sure-kill p)
      (or mpg123-preserve-playtime (mpg123:update-playtime "00:00"))
      (mpg123:play "0")) ;play from frame#0
     ;;else go back to previous line
     (t
      (mpg123-prev-line arg)))))

(defun mpg123-> (arg)
  "Skip forward"
  (interactive "p")
  (let ((p (get-buffer-process (current-buffer))))
    (cond
     ;;If currently playing, then go forward and start
     ((and p (eq (process-status p) 'run))
      (goto-char mpg123*cur-play-marker)
      (mpg123-next-line arg)
      (setq mpg123*interrupt-p t)
      (mpg123*sure-kill p)
      (mpg123:play "0")) ;play from frame#0
     ;;else go to next line
     (t
      (mpg123-next-line arg)))))

(defun mpg123-mark-position ()
  "Mark the playing position now."
  (interactive)
  (let ((f (max 0 (- (string-to-int mpg123*cur-playframe) 50))))
    (mpg123:set-music-info mpg123*cur-music-number 'mark (format "%d" f))
    (mpg123:set-music-info
     mpg123*cur-music-number 'marktime mpg123*cur-playtime)
    (message "Mark the position of [%s].  Push `%s' to refrain"
	     mpg123*cur-playtime
	     (substitute-command-keys "\\[mpg123-refrain]"))))

(defun mpg123-refrain ()
  "Refrain from marked position."
  (interactive)
  (let ((frame (mpg123:get-music-info mpg123*cur-music-number 'mark))
	(p (get-buffer-process (current-buffer))))
    (if frame
	(progn
	  (if (and p (eq (process-status p) 'run))
	      (progn
		(setq mpg123*interrupt-p t)
		(mpg123*sure-kill p)))
	  (mpg123:play
	   (mpg123:get-music-info mpg123*cur-music-number 'mark)))
      (message "No position for refrain marked. Type `%s' to mark position"
	       (substitute-command-keys "\\[mpg123-mark-position]")))))

(defun mpg123-where-is-mark ()
  "Print the current music's marked position."
  (interactive)
  (let ((marktime (mpg123:get-music-info mpg123*cur-music-number 'marktime))
	(frame (mpg123:get-music-info mpg123*cur-music-number 'mark)))
    (if marktime
	(message "Mark for music#%d is [%s] (frame#%s)"
		 mpg123*cur-music-number marktime frame)
      (message "No mark set for music#%d" mpg123*cur-music-number))))

(defun mpg123:add-time (m s add &optional max)
  (let ((x (max 0 (+ (* m 60) s add))))
    (if max (setq x (min max x)))
    (setq m (/ x 60)
	  s (- x (* 60 m)))
    (cons m s)))

(defun mpg123-forward (arg)
  "forw"
  (interactive "p")
  (setq mpg123*time-setting-mode t)
  (save-excursion
    (mpg123:goto-playtime-position)
    (looking-at "\\([0-9]+\\):\\([0-9]+\\)/\\([0-9]+\\):\\([0-9]+\\)")
    (let*((m (string-to-int
	      (buffer-substring (match-beginning 1) (match-end 1))))
	  (s (string-to-int
	      (buffer-substring (match-beginning 2) (match-end 2))))
	  time M S T)
      (if (and (match-beginning 3) (match-beginning 4))
	  (setq M (string-to-int
		   (buffer-substring (match-beginning 3) (match-end 3)))
		S (string-to-int
		   (buffer-substring (match-beginning 4) (match-end 4)))
		T (+ (* 60 M) S)))
      (setq time (mpg123:add-time m s arg T))
      (mpg123:update-playtime (format "%02d:%02d" (car time) (cdr time)))
      (message "Time Slide mode: Type `SPC' to play in that position"))))

(defun mpg123-backward (arg)
  "Rew"
  (interactive "p")
  (mpg123-forward (- arg)))

(defun mpg123-forward-10 (arg)
  "Forw by (ARG*10)sec"
  (interactive "p")
  (mpg123-forward (* 10 arg)))

(defun mpg123-backward-10 (arg)
  "Rew"
  (interactive "p")
  (mpg123-forward (* -10 arg)))

(defun mpg123-open-new (dir)
  "Open new directory."
  (interactive "Dmpg123 on directory: ")
  (if (not (file-directory-p dir))
      (error "Not directory: %s" dir))
  (let ((p (get-buffer-process (current-buffer))))
    (setq mpg123*interrupt-p t)
    (if (and p (process-status p)) (mpg123*sure-kill p))
    (mpg123 dir)))

(defun mpg123-increase-repeat-count (arg)
  "Increase repeat count."
  (interactive "p")
  (setq mpg123*cur-repeat-count
	(min 99 (max -1 (+ arg mpg123*cur-repeat-count))))
  (mpg123:update-repeat-count))

(defun mpg123-decrease-repeat-count (arg)
  "Decrease repeat count."
  (interactive "p")
  (mpg123-increase-repeat-count (- arg)))

(defun mpg123:get-music-number ()
  "Get current line's music number."
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t" nil)
    (and
     (looking-at "[0-9]+")
     (string-to-int (buffer-substring (match-beginning 0) (match-end 0))))))

(defvar mpg123-popup-window-height 8)
(defun mpg123:popup-buffer (buffer)
  "Popup specified BUFFER."
  (cond
   ((get-buffer-window buffer)
    (select-window (get-buffer-window buffer)))
   ((one-window-p)
      (let ((h (max window-min-height
		    (- (window-height) mpg123-popup-window-height))))
	(split-window nil h)
	(other-window 1)
	(switch-to-buffer buffer)))
   (t
    (other-window 1)
    (switch-to-buffer buffer))))

(defvar mpg123*stack-buffer " *mpg123 stack*")
(defun mpg123-kill-line (arg)
  "Kill current music line and move it to the stack."
  (interactive "p")
  (beginning-of-line)
  (if (mpg123:in-music-list-p)
      (let ((sb (get-buffer-create mpg123*stack-buffer))
	    n current (stack "") buffer-read-only
	    (sw (selected-window)))
	(save-excursion
	  (set-buffer sb)
	  (use-local-map mpg123-mode-map))
	(while (and (> arg 0) (mpg123:in-music-list-p))
	  (setq n (mpg123:get-music-number))
	  (if (and (eq (marker-buffer mpg123*cur-play-marker) (current-buffer))
		   (= (point) mpg123*cur-play-marker))
	      (setq current t))
	  (delete-region (point)
			 (progn (forward-line 1) (point)))
	  (save-excursion
	    (set-buffer sb)
	    (goto-char (point-min))
	    (if current
		(progn
		  (set-marker mpg123*cur-play-marker nil)
		  (setq mpg123*cur-play-marker (point-marker))
		  (setq current nil)
		  (insert (mpg123:format-line n)))
	      (insert-before-markers (mpg123:format-line n))))
	  (setq arg (1- arg)))
	(mpg123:popup-buffer sb)
	(goto-char (point-min))
	(select-window sw))))

(defun mpg123-yank-line (arg)
  "Yank music line from stack buffer."
  (interactive "p")
  (beginning-of-line)
  (if (mpg123:in-music-list-p)
      (let ((sb (get-buffer-create mpg123*stack-buffer))
	    (sw (selected-window)) stackw
	    n buffer-read-only current)
	(beginning-of-line)
	(mpg123:popup-buffer sb)
	(setq stackw (selected-window))
	(goto-char (point-min))
	(while (and (setq n (mpg123:get-music-number))
		    (> arg 0))
	  (if (and (eq (marker-buffer mpg123*cur-play-marker) (current-buffer))
		   (= (point) mpg123*cur-play-marker))
	      (setq current t))
	  (delete-region (point) (progn (forward-line 1) (point)))
	  (save-excursion
	    (set-buffer mpg123*buffer)
	    (if current
		(progn
		  (set-marker mpg123*cur-play-marker nil)
		  (setq mpg123*cur-play-marker (point-marker))
		  (setq current nil)
		  (insert (mpg123:format-line n)))
	      (insert-before-markers (mpg123:format-line n))))
	  (setq arg (1- arg)))
	(if (progn (set-buffer sb)
		   (= (buffer-size) 0))
	    (progn
	      (delete-window stackw)
	      (kill-buffer sb)))
	(select-window sw))))

(defun mpg123-shuffle ()
  "Shuffle the music!"
  (interactive)
  (message "Shuffle music by...(O)rder, (I)nverse order, (R)andom: ")
  (let ((c (read-char)) ord (n 0) (l (length mpg123*music-alist))
	r tmp buffer-read-only (p (point)))
    (cond
     ((eq c ?o)
      (setq n l)
      (while (> n 0)
	(setq ord (cons n ord)
	      n (1- n))))
     ((eq c ?i)
      (while (<= (setq n (1+ n)) l)
	(setq ord (cons n ord))))
     ((eq c ?r)
      (random t)
      (setq ord (make-vector l nil))
      (while (< n l)
	(aset ord n (1+ n)) (setq n (1+ n)))
      (while (>= (setq n (1- n)) 0)
	(setq r (random l)
	      tmp (aref ord r))
	(aset ord r (aref ord n))
	(aset ord n tmp)))
     (t (error "Canceled")))
    (setq n 0)
    (goto-char (point-min))
    (if (and mpg123*cur-play-marker
	     (markerp mpg123*cur-play-marker)
	     (eq (marker-buffer mpg123*cur-play-marker) (current-buffer)))
	(set-marker mpg123*cur-play-marker nil))
    (while (< n l)
      (if (equal (elt ord n) mpg123*cur-music-number)
	  (setq mpg123*cur-play-marker (point-marker)))
      (insert (mpg123:format-line (elt ord n)))
      (setq n (1+ n)))
    (delete-region (point) mpg123*end-of-list-marker)
    (goto-char p)))

(defun mpg123-quit ()
  "Quit"
  (interactive)
  (let ((p (get-buffer-process (current-buffer))))
    (if (and p
	     (eq (process-status p) 'run)
	     (y-or-n-p "Kill current music?"))
	(mpg123*sure-kill p))
    (setq mpg123*interrupt-p t)
    (mapcar '(lambda (b) (and (get-buffer b) (kill-buffer b)))
	    (list mpg123*buffer mpg123*info-buffer
		  " *mpg123tmp* " " *mpg123 tag tmp*" " *mpg123 mixer* "))))

(defun mpg123:mp3-files-in-dir (dir)
  "Return mp3 files"
  (let ((files (sort (directory-files dir) 'string<)) f mp3s)
    (while files
      (message "Inspect file %s..." (car files))
      (setq f (expand-file-name (car files) dir))
      (and (not (file-directory-p f))
	   (file-readable-p f)
	   (if (mpg123:sound-p f) (setq mp3s (cons f mp3s))))
      (setq files (cdr files)))
    (message "")
    (nreverse mp3s)))

(defun mpg123:squeeze-spaces-buffer ()
  (save-excursion
    (goto-char (point-min))
    (if (looking-at "\\s +") (replace-match ""))
    (save-excursion
      (while (search-forward "\0" nil t)
	(replace-match "")))
    (save-excursion
      (while (search-forward "　" nil t) (replace-match " ")))
    (save-excursion
      (while (re-search-forward "\\s \\s +" nil t)
      (replace-match " ")))
    (if (re-search-forward "\\s +$" nil t)
      (replace-match ""))))

(defun mpg123:peek-tag (file)
  "Try peeking id3tag from FILE"
  (let ((sz (nth 7 (file-attributes file)))
	(b (get-buffer-create " *mpg123 tag tmp*"))
	title artist)
    (save-excursion
      (set-buffer b)
      (erase-buffer)
      (insert-file-contents file nil (- sz 128) (- sz 125))
      (if (looking-at "TAG")
	  (progn
	    (erase-buffer)
	    (insert-file-contents file nil (- sz 125) (- sz 95))
	    (mpg123:squeeze-spaces-buffer)
	    (setq title (buffer-string))
	    (erase-buffer)
	    (insert-file-contents file nil (- sz 95) (- sz 65))
	    (mpg123:squeeze-spaces-buffer)
	    (setq artist (buffer-string))
	    (kill-buffer b)
	    (concat (if (string< "" title) title "UnknownTitle")
		    " by "
		    (if (string< "" artist) artist "UnknownArtist")))
	(kill-buffer b)
	(file-name-nondirectory file)))))

(defun mpg123:insert-help ()
  "Insert help string to current buffer."
  (insert (substitute-command-keys "
mpg123:
\\[mpg123-play-stop]	Play or pause
\\[mpg123-play]	Play
\\[mpg123-mark-position]	Mark position (when playing)
\\[mpg123-refrain]	Refrain from marked position
\\[mpg123-where-is-mark]	Where is the marked position
\\[mpg123-<]	<<
\\[mpg123->]	>>
\\[mpg123-forward]	Forward 1 sec
\\[mpg123-backward]	Backward 1 sec
\\[mpg123-forward-10]	Forward 10 sec
\\[mpg123-backward-10]	Backard 10 sec
\\[mpg123-next-line]	Move to next line
\\[mpg123-prev-line]	Move to previous line
\\[mpg123-volume-increase]	Volume up
\\[mpg123-volume-decrease]	Volume down
\\[mpg123-open-new]	Open other directory
\\[mpg123-increase-repeat-count]	Increase repetition count
\\[mpg123-decrease-repeat-count]\tDecrease repetition count (-1 for infinity)
\\[mpg123-shuffle]	Shuffle music list
\\[mpg123-kill-line]	Kill music line and push onto stack
\\[mpg123-yank-line]	Yank music line from stack
\\[mpg123-quit]	Quit
"
)))

(defun mpg123:format-line (n)
  (if (stringp n) (setq n (string-to-int n)))
  (format "%2d --:--/%s\t %s\n"
	  n
	  (or (mpg123:get-music-info n 'length) "--:--")
	  (mpg123:get-music-info n 'name)))

(defun mpg123-mode ()
  "mpg123 controling mode."
  (setq truncate-lines t)
  (setq major-mode 'mpg123-mode
	mode-name "mpg123"
	mpg123*cur-music-number nil
	mpg123*cur-repeat-count mpg123-default-repeat
	mpg123*cur-playtime nil
	mpg123*cur-start-frame "0"
	mpg123*cur-playframe nil)
  (use-local-map mpg123-mode-map))

(defun mpg123:create-buffer (files)
  "Create play-buffer"
  (switch-to-buffer (get-buffer-create mpg123*buffer))
  (setq buffer-read-only nil)
  (buffer-disable-undo)
  (erase-buffer)
  (setq mpg123*music-alist nil)
  (cd dir) (setq default-directory dir)
  (save-excursion
    (set-buffer (get-buffer-create mpg123*stack-buffer))
    (setq buffer-read-only nil)
    (erase-buffer))
  (mpg123-mode)
  (let (f (i 1) name)
    (while files
      (setq f (car files))
      (setq name (if (fboundp mpg123-id3-tag-function)
		     (funcall mpg123-id3-tag-function f)
		   (file-name-nondirectory f)))
      (mpg123:set-music-info i 'filename f)
      (mpg123:set-music-info i 'name name)
      (insert (mpg123:format-line i))
      (setq i (1+ i)
	    files (cdr files))))
  (if (markerp mpg123*end-of-list-marker)
      (set-marker mpg123*end-of-list-marker nil))
  (setq mpg123*end-of-list-marker (point-marker))
  (insert-char ?- (1- (window-width)))
  (insert "\nVolume: [")
  (if (markerp mpg123*volume-marker)
      (set-marker mpg123*volume-marker nil))
  (setq mpg123*volume-marker (point-marker))
  (insert (format "--:--]"))
  (mpg123:update-volume (mpg123:get-volume))
  (insert " Repeat: [")
  (if (markerp mpg123*repeat-count-marker)
      (set-marker mpg123*repeat-count-marker nil))
  (setq mpg123*repeat-count-marker (point-marker))
  (insert (format "--]"))
  (mpg123:update-repeat-count)
  (mpg123:insert-help)
  (setq buffer-read-only t)
  (goto-char (point-min))
  )

;;;
;; Mixer
;;;
(defun mpg123:get-volume ()
  "Get current volume."
  (cond
   ((eq mpg123-system-type 'freebsd)
    (let ((b (get-buffer-create " *mpg123 mixer* "))
	  vol)
      (set-buffer b)
      (erase-buffer)
      (call-process mpg123-mixer-command nil b nil "vol")
      (goto-char (point-min))
      (if (re-search-forward "set to *\\([0-9]+\\):\\([0-9]+\\)" nil t)
	  (let ((left (buffer-substring (match-beginning 1) (match-end 1)))
		(right (buffer-substring (match-beginning 2) (match-end 2))))
	    (setq vol (cons (string-to-int left) (string-to-int right))))
	(setq vol "unknown"))
      (setq mpg123*cur-volume vol)))
   ((eq mpg123-system-type 'linux)
    "unknown")))

(defun mpg123:set-volume (vollist)
  "Set volume"
  (if (integerp vollist) (setq vollist (cons vollist vollist)))
  (cond
   ((memq mpg123-system-type '(freebsd linux))
    (let ((l mpg123-mixer-setvol-target-list)
	  (v (format "%d:%d" (car vollist) (cdr vollist)))
	  args)
      (setq mpg123*cur-volume vollist)
      (while l
	(setq args (cons (car l) (cons v args)))
	(setq l (cdr l)))
      (apply 'call-process
	     mpg123-mixer-command nil nil nil
	     args)))))

(defun mpg123-volume-increase (arg)
  "Increase both(left/right) volume by ARG count."
  (interactive "p")
  (cond
   ((consp mpg123*cur-volume)
    (let ((left (car mpg123*cur-volume)) (right (cdr mpg123*cur-volume)))
      (setq left (max 0 (min 100 (+ arg left)))
	    right (max 0 (min 100 (+ arg right))))
      (mpg123:set-volume (cons left right))))
   ((integerp mpg123*cur-volume)
    (let ((v (max 0 (min (+ mpg123*cur-volume arg)))))
      (mpg123:set-volume (cons v v)))))
  (mpg123:update-volume mpg123*cur-volume))

(defun mpg123-volume-decrease (arg)
  "Decrease both(left/right) volume by ARG count."
  (interactive "p")
  (mpg123-volume-increase (- arg)))

(defun mpg123:initialize ()
  (if (get 'mpg123:initialize 'done)
      nil
    (mpg123:set-volume mpg123-startup-volume)
    (put  'mpg123:initialize 'done t)))

(defun mpg123 (dir)
  "Call mpg123 on dir"
  (interactive "Dmpg123 on dir: ")
  (if (not (file-directory-p dir))
      (error "It's not directory! %s" dir))
  (let ((files (mpg123:mp3-files-in-dir dir)))
    (mpg123:create-buffer files)
    (message "Let's listen to the music. Type SPC to start.")
    ))

(provide 'mpg123)

; Local variables: 
; fill-prefix: ";;	" 
; paragraph-start: "^$\\|\\|;;$" 
; paragraph-separate: "^$\\|\\|;;$" 
; End: 
