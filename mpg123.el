;;; -*- Emacs-Lisp -*-
;;; A front-end program to mpg123
;;; (c)1999,2000 by HIROSE Yuuji [yuuji@gentei.org]
;;; $Id$
;;; Last modified Tue Jan 30 12:35:52 2001 on firestorm
;;; Update count: 815

;;[Commentary]
;;	
;;	This package is a front-end program to mpg123 audio player.
;;	mpg123の再生フロントエンドです。
;;	
;;[Requirement]
;;	
;;	The `mpg123' program version 0.59q or later, and enough CPU
;;	power to run it.
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
;;		(autoload 'mpg123 "mpg123" "A Front-end to mpg123" t)
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
;;		SomeMP3DirectoryName (or playlist file) RET
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
;;		ディレクトリ名 (またはプレイリストファイル名) ぺし
;;	
;;	と打ちます。と、そのディレクトリにある音楽ファイル一覧が出て来る
;;	ので、聞きたい曲に合わせてSPCを打つと演奏が始まります。その他の
;;	キーコマンドは音楽一覧バッファの末尾に表示されているのでそっちを
;;	見てください。
;;	
;;[Playlist]
;;	
;;	If you  give `M-x mpg123' a  simple file which  consists of file
;;	name list;  one file  name per line,  mpg123.el assumes it  as a
;;	playlist file.   All of  mp3 files listed  in playlist  file are
;;	incorporated in *mpg123* playing  buffer.  If a line in playlist
;;	points  to another  playlist file,  file is  parsed recursively.
;;	There are mainly two ways to create a playlist file.
;;	
;;		* Typing `S' in *mpg123* buffer
;;		* Create directly on the shell;
;;		  Ex. % ls */*.mp3 > playlist
;;	
;;	Because a playlist is very simple, you can edit it manually to
;;	arrange the order of music list.
;;	
;;	M-x mpg123 のあとに、一行に一つMP3ファイルの名前が書かれた普通の
;;	ファイルを指定するとmpg123.elはそれをプレイリストファイルだとみ
;;	なし、そこに書かれているMP3ファイル群を *mpg123* 音楽一覧バッファ
;;	に全て取り込みます。プレイリストファイルを作るには二つの方法があ
;;	ります。
;;	
;;		* 音楽一覧(*mpg123*)バッファで S を押す
;;		* シェルの上で直接作る
;;		  【例】 % ls */*.mp3 > playlist
;;	
;;	プレイリストファイルはとても単純なので、直接編集して好きな曲順を
;;	リストを作るのは簡単でしょう。プレイリストファイル中に別のプレイ
;;	リストを指定することもできます。
;;	
;;[Configuration]
;;	
;;	Here are the variables for your customization.
;;	
;;	  [Variable]		[Default value/Meaning]
;;	  mpg123-command	"mpg123"
;;				Command name of mpg123
;;	  mpg123-command-args	nil
;;				Argument list to pass mpg123 command
;;	  mpg123-mixer-command	"mixer"
;;				Command name of mixer(FreeBSD)
;;	  mpg123-preserve-playtime t
;;				If you want to mpg123 to play all music
;;				from the beginning even if the last
;;				played time is shown in the buffer, set
;;				this variable to `nil'.
;;	  mpg123-startup-volume 30
;;				Initialize sound volume with this value.
;;	  mpg123-default-repeat	0
;;				Default number of repetition
;;	  mpg123-show-help	t
;;				Whether show help under the music list
;;				or not
;;	  mpg123-omit-id3-artist nil
;;				Whether omit the artist name in ID3
;;	  mpg123-lazy-check	nil
;;				Check sound file or not by filename
;;	
;;	  mpg123-face-playing	'("yellow" . "#004080")
;;				Cons of default playing cursor color
;;				'(FGCOLOR . BGCOLOR)
;;	  mpg123-face-slider	'("black" . "yellow")
;;				Cons of default playing position slider color
;;	  mpg123-need-slider	t on color display, else nil
;;				Whether the playing position slider is
;;				needed or not
;;	
;;	ほぼ mpg123 0.59q に決め打ちという風情なので、あまりいじれるとこ
;;	ろ無いけど、上に書いてある変数がいじれます。
;;	
;;	なおLinuxでは音量調節コマンドとして aumix -w の利用を前提とします。
;;	このプログラムで音量をいじりたいときは aumix をインストールしてお
;;	きましょう。
;;	
;;[More comfortable]
;;	
;;	Yes, Emacs is the editor.  Even though you are listening to the
;;	music, you have to edit something!! :)
;;	
;;	This  program occupies  one  Emacs window.   Using this  program
;;	without any  window manager is  hard job.  Please use  this with
;;	windows.el  -  The Window  Manager  for  Emacs  - which  can  be
;;	obtained   from   http://www.gentei.org/~yuuji/software/.   With
;;	windows.el,  you can  listen the  music  which is  run in  other
;;	frame. Or  if you use  emacs -nw, you  can run mpg123.el  in the
;;	background  window and  can  switch from  and  to mpg123  buffer
;;	alternatively.   Of  course,  I'm  writing this  document  while
;;	mpg123.el is running in the background window.
;;	
;;	Emacs使ってるんだから聞くばっかりじゃなくて編集しなさい!  てこと
;;	で、全フレームを消費するmpg123.elを素のEmacsで使ってたら大変。た
;;	めしに windows.el と一緒につこてみてね。フレームを使ってるときは
;;	別フレームでバックグラウンド再生、-nw で起動しているときは裏ウィ
;;	ンドウでバックグラウンド再生できて、その裏ウィンドウといくつかの
;;	編集ウィンドウを切替えて使うなんて事も可能。もちろんこの文章も裏
;;	に半分隠れてるフレームでmpg123を走らせながら書いてます。
;;	windows.el は http://www.gentei.org/~yuuji/software/ からどうぞ。
;;	
;;[Bugs]
;;	
;;	It is  perhaps only on  my system that sometimes  mpg123 command
;;	gets confused to decode and  ticks playing time very slowly.  In
;;	such case, mpg123.el cannot  detect that condition.  If you come
;;	to see such behavior, please pause and restart player by SPC key.
;;	
;;	たまにmpg123が動いてはいるものの音を出さなくなってしまうことがあ
;;	ります。そのような挙動をmpg123.elは検出できないので、そうなった
;;	らSPCで一旦止めて動かし直してください。Emacs19ベースのMuleでは複
;;	雑な理由により別フレームで演奏中に次の曲に進むと、次の曲に移った
;;	直後のキーを演奏用バッファに取られてしまい、なおかつ演奏時間の更
;;	新が(みかけ上)次にキー入力するまで止まってしまいます。そうなって
;;	しまう確率が下がるような工夫はしてみましたが根本的解決には至りま
;;	せんでした。
;;	
;;	Play/Stop control against the  music in the stack buffer doesn't
;;	work.   Although  it is  feasible,  the  feature isn't  actually
;;	usefull and ends in self-satisfaction.  So, no plan to make it.
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
;;	下のアドレスまでお願いします(2000/12現在)。
;;							yuuji@gentei.org
;;[Acknowledgements]
;;	
;;	Tijs van Bakel, <smoke@casema.net>
;;		Reported mpg123 termination problem on mpg123 0.59r on
;;		linux 2.2.10.
;;	sen_ml@eccosys.com
;;		Reported problem at playing music more than 100.
;;	Kenichi OKADA, <okada@opaopa.org>
;;		Sent a patch of setting sound volume on Solaris/sparc.
;;	Takuro Horikawa <takuroho@tky3.3web.ne.jp>
;;		Reported running on WinNT.
;;		Port `mixer command' to Windows.
;;		(See http://www3.tky.3web.ne.jp/~takuroho/mpg123.html)
;;	TAOKA Satoshi <taoka@infonets.hiroshima-u.ac.jp>
;;		Put mpg123.el into FreeBSD ports collection
;;	T. V. Raman <ramantv@earthlink.net>
;;		Made emacspeak-mpg123.el.  Many comments.
;;	Per Weijnitz <Per.Weijnitz@etl.ericsson.se>
;;		Sent a patch to enable mixer command on NT4
;;	Takayuki TSUKAGOSHI <tsuka@soft.ics.keio.ac.jp>
;;		Sent a patch for mule2@19.34.
;;	Ryuichi Arafune <arafune@debian.org>
;;		Put mpg123.el to Debian package.
;;	Laurent Martelli <martelli@iie.cnam.fr>
;;		Sent a patch of passing optional arguments to mpg123.
;;		Volume control for Linux.
;;	T. Amano <tomoo@cheri.sh>
;;		Reported running on Linux.
;;	OHTAKI Naoto <ohtaki@wig.nu>
;;		Reported running on Windows98
;;	MOROHOSHI Akihiko <moro@nii.ac.jp>
;;		Sent a patch on coding-system detection for XEmacs+emu.el
;;	Alex Shinn <foof@debian.org>
;;		Patch to handle mp3 files in multiple directories.
;;		Implemented `playlist'.
;;	Seiichi Namba <sn@asahi-net.email.ne.jp>
;;		Many collaboration codes for working with dired-dd.
;;		Made dired-dd-mpg123.
;;
;;[History]
;; $Log$
;; Revision 1.20  2001/01/30 03:35:54  yuuji
;; (Win)convert music filename to dos file name for music over shared folder
;;
;; Revision 1.19  2001/01/19 04:41:37  yuuji
;; Fix the invalid 'cond form.
;;
;; Revision 1.18  2000/12/23 07:41:23  yuuji
;; Slider stays wrong position when music list added.  Fixed
;;
;; Revision 1.17  2000/12/08 00:54:09  yuuji
;; Variable mpg123-face-playing specifies the color of cursor for playing music.
;; Variable mpg123-face-slider specifies the color of slider of playing position.
;; Variable mpg123-need-slider specifies wheter the slider is needed or not.
;; Mouse-2 selects directly a music on the mouse pointer(in music list) or
;; playing position(in delimiter line).
;; RET(M-x mpg123-play) on the delimiter line move the playing position
;; according to the proportion of the window width from left side.
;;
;; Revision 1.16  2000/11/24 15:09:22  yuuji
;; Support emacs-21.0.9x (in mpg123:mp3-p)
;;
;; Revision 1.15  2000/10/20 14:43:06  yuuji
;; (if (featurep 'xemacs) (require 'overlay))
;;
;; Revision 1.14  2000/10/16 08:52:44  yuuji
;; 'mpg123*cur-face renamed to 'mpg123-cur-face (For XEmacs)
;;
;; Revision 1.13  2000/08/06 03:56:37  yuuji
;; Support volume setting on NetBSD(mixerctl)
;;
;; Revision 1.12  2000/08/06 02:27:58  yuuji
;; Set it default to use hilighting.
;;
;; Revision 1.11  2000/08/05 15:40:57  yuuji
;; Revise document.
;;
;; Revision 1.10  2000/08/05 15:37:50  yuuji
;; Handle mp3 files in multiple directories.
;; Playlist support.
;;
;; Revision 1.9  2000/06/25 14:38:17  yuuji
;; Fix for XEmacs+emu.el
;;
;; Revision 1.8  2000/02/09 04:15:31  yuuji
;; Fix for mule2 (mpg123:sound-p).
;;
;; Revision 1.7  1999/09/25 07:09:44  yuuji
;; mpg123-delete-file can delete music only from the list, not on the disk.
;; Shuffle after mpg123-delete-file now works correctly.
;;
;; Revision 1.6  1999/09/10 02:09:02  yuuji
;; mpg123-mp3-scan-bytes
;; defmacro changed to defsubst
;;
;; Revision 1.5  1999/07/24 03:58:52  yuuji
;; mule2でなるべく曲連係が途切れないように工夫(完璧ではない)。
;;
;; Revision 1.4  1999/07/05 09:00:19  yuuji
;; 日本語ファイル名対応(たぶん)
;; \C-d (mpg123-delete-file)
;;

(defvar mpg123-system-type
  (cond
   ((string-match "freebsd" (emacs-version))	'freebsd)
   ((string-match "netbsd" (emacs-version))	'netbsd)
   ((string-match "openbsd" (emacs-version))	'openbsd) ;not yet tested
   ((string-match "linux" (emacs-version))	'linux)
   ((string-match "nt4\\|windows9" (emacs-version)) 'nt)
   ((string-match "solaris" (emacs-version))	'solaris)))

(defvar mpg123-command "mpg123"
  "*Command name of mpg123 player. Need 0.59q or later.
mpg123のコマンド名。0.59qが必要。")
(defvar mpg123-command-args nil
  ;;'("--8bit -m")	;<- example
  "*Arguments to give to mpg123")
(defvar mpg123-mixer-command
  (cdr (assq mpg123-system-type
	     '((freebsd . "mixer") (netbsd . "mixerctl") (linux . "aumix")
	       (solaris . "audioctl") (nt . "mixer.exe"))))
  "*Command name for mixer setting utility
mixer調節用コマンド")
(defvar mpg123-mixer-setvol-target-list
  (cdr (assq mpg123-system-type
	     '((freebsd . ("vol" "pcm")) (netbsd . ("outputs.master"))
	       (linux . ("-w"))
	       (solaris . ("-v")) (nt . ("-v")))))
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
(defvar mpg123-process-coding-system
  (cond ((and (fboundp 'modify-coding-system-alist)
	      (intern-soft "euc-jp"))
	 'euc-jp)
	((boundp '*euc-japan*) *euc-japan*)
	(t nil))
  "*Default process coding system for mpg123.
mpg123コマンド用の漢字コード。漢字ファイル名があるときは必須")
(defvar mpg123-omit-id3-artist nil
  "*Non-nil for omitting artist name display of ID3 tag.
non-nilのときID3タグからのアーチスト名表示を省略する。")
(defvar mpg123-mp3-scan-bytes 3
  "*Default number of bytes of header to examine the file is mp3 or not.
MP3ファイルかどうかを調べるために読み込むファイルの先頭のバイト数")

(defvar mpg123-lazy-check nil
  "*Check sound file or not by filename.
If want to check by filename, set this variable to filename regexp.
MP3ファイルかどうか調べるためにファイル名だけで済ます場合は
正規表現を指定する.")

(defvar mpg123-show-help t
  "*Print help summary in mpg123 buffer")

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
(define-key mpg123-mode-map "v" 'mpg123-volume-decrease)
(define-key mpg123-mode-map "V" 'mpg123-volume-increase)
(define-key mpg123-mode-map "f" 'mpg123-forward)
(define-key mpg123-mode-map "b" 'mpg123-backward)
(define-key mpg123-mode-map "F" 'mpg123-forward-10)
(define-key mpg123-mode-map "B" 'mpg123-backward-10)
(define-key mpg123-mode-map "o" 'mpg123-open-new)
(define-key mpg123-mode-map "a" 'mpg123-add-new)
(define-key mpg123-mode-map "i" 'mpg123-increase-repeat-count)
(define-key mpg123-mode-map "d" 'mpg123-decrease-repeat-count)
(define-key mpg123-mode-map "k" 'mpg123-kill-line)
(define-key mpg123-mode-map "K" 'mpg123-kill-stack)
(define-key mpg123-mode-map "y" 'mpg123-yank-line)
(define-key mpg123-mode-map "s" 'mpg123-shuffle)
(define-key mpg123-mode-map "S" 'mpg123-save-playlist)
(define-key mpg123-mode-map "\C-d" 'mpg123-delete-file)
(define-key mpg123-mode-map "E" 'id3-edit)
(define-key mpg123-mode-map "q" 'mpg123-quit)
(define-key mpg123-mode-map "Q" 'mpg123-quit-yes)
(if (and window-system)
    (cond
     ((featurep 'xemacs)
      (define-key mpg123-mode-map '(button1) 'mpg123-mouse-play-stop)
      (define-key mpg123-mode-map '(control button4) 'mpg123-volume-increase)
      (define-key mpg123-mode-map '(control button5) 'mpg123-volume-decrease)
      (define-key mpg123-mode-map 'button3 'mpg123-mouse-force-play)
      )
     (t
      (define-key mpg123-mode-map [down-mouse-1] 'mpg123-mouse-play-stop)
      (define-key mpg123-mode-map [down-mouse-2] 'mpg123-mouse-force-play)
      (define-key mpg123-mode-map [C-mouse-4] 'mpg123-volume-increase)
      (define-key mpg123-mode-map [C-mouse-5] 'mpg123-volume-decrease)
      )))
(let ((ch ?0))
  (while (<= ch ?9)
    (define-key mpg123-mode-map (char-to-string ch) 'digit-argument)
    (setq ch (1+ ch))))

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
;(defvar mpg123-playlist-regexp ".*\\.m3u"
;  "*Regular expression to match to playlist files")
(defvar mpg123-url-regexp "http://.*"
  "*Regular expression to match to URL requests")


(defun mpg123:mp3-skip-id3v2 ()
  "Skip ID3v2 tag in current buffer."
  (let ((case-fold-search nil) (p (point)))
    (while (looking-at "ID3")
      (goto-char (setq p (+ p 6)))	;header size location
      (goto-char
       (+ p
	  (* 128 128 128 (char-after p))
	  (* 128 128 (char-after (1+ p)))
	  (* 128 (char-after (+ p 2)))
	  (char-after (+ p 3))
	  4)))
    (goto-char (1- (point)))))

(defun mpg123:mp3-p (f)
  "Check the file F is MPEG 1 Audio file or not."
  (save-excursion
    ;;check file size > 128
    (and (> (nth 7 (file-attributes (file-truename f))) 128)
	 (let ((b (set-buffer (get-buffer-create " *mpg123tmp*"))) e0 b0
	       (file-coding-system-alist (list (cons "." 'no-conversion)))
	       (file-coding-system
		(if (and (boundp '*noconv*) (coding-system-p '*noconv*))
		    '*noconv*		;mule19
		  'no-conversion))	;XEmacs(maybe)
	       (file-coding-system-for-read '*noconv*) ;19
	       (skipchars (if (string-match "^21\\.0\\.9" emacs-version)
			      "\000-\177"
			    "^\xff")))
	   (set-buffer b)
	   (erase-buffer)
	   (insert "..")		;dummy dot to simplify the while loop
	   (insert-file-contents f nil 0 mpg123-mp3-scan-bytes)
	   (goto-char (point-min))
	   (prog1	; if short & 0xfff0 = 0xfff0, it is MPEG audio
	       (or
		(looking-at "\\.\\.ID3")
		(catch 'found
		  (if (string-match "^19\\." emacs-version)
		      (while (search-forward "\xff" nil t) ;Scan `0xff'
			(setq e0 (match-end 0) b0 (match-beginning 0))
			(if (and (char-after b0)
				 (= (logand
				     (char-after (+ 1 b0)) ?\xF0)
				    ?\xF0))
			    (throw 'found t))
			(goto-char e0))
		    (while (> (skip-chars-forward skipchars) 0) ;Scan `0xff'
		      (if (and (char-after (1+ (point)))
			       (= (logand (char-after (1+ (point)))
					  ?\xF0) ?\xF0))
			  (throw 'found t))))))
	     (kill-buffer b))))))

(defun mpg123:sound-p (f)
  (or (and mpg123-lazy-check (stringp mpg123-lazy-check)
	   (string-match mpg123-lazy-check (file-name-nondirectory f)))
      (mpg123:mp3-p f)))

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

(defsubst mpg123:goto-playtime-position ()
  ;;For speed, we do not set-buffer to where mpg123*cur-play inhabits,
  ;;Confirm yourself to set the current buffer to mpg123*cur-play buffer
  ;;if you call this from the function that can be called when the
  ;;currently being played music is in stac-buffer.
  (goto-char mpg123*cur-play-marker)
  (skip-chars-forward "^:")
  (forward-char -2))
; (defmacro mpg123:goto-playtime-position ()
;   (list 'progn
; 	(list 'goto-char 'mpg123*cur-play-marker)
; 	;(list 'move-to-column 3)
; 	(list 'skip-chars-forward "^:")
; 	(list 'forward-char -2)
; 	))

(defsubst mpg123:update-playtime (timestr)
  "Update playing time string"
  (save-excursion
    (set-buffer (marker-buffer mpg123*cur-play-marker))
    (let (buffer-read-only)
      (mpg123:goto-playtime-position)
      (delete-char 5)
      (insert timestr))))

; (defmacro mpg123:update-playtime (timestr)
;   (list 'save-excursion
; 	(list 'set-buffer (list 'marker-buffer 'mpg123*cur-play-marker))
; 	;(list 'set-buffer 'mpg123*buffer)
; 	(list 'let (list 'buffer-read-only)
; 	      (list 'mpg123:goto-playtime-position)
; 	      (list 'delete-char 5)
; 	      (list 'insert timestr)
; 	      ;(list 'set-buffer-modified-p nil) ;is not essential
; 	      )))

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

(defun mpg123:get-music-info (n attr)
  (cdr (assq attr (assoc n mpg123*music-alist))))
; (defmacro mpg123:get-music-info (n attr)
;   (list 'cdr (list 'assq attr (list 'assoc n 'mpg123*music-alist))))

(defun mpg123:delete-music-from-list (n)
  "Delete music number N from mpg123*music-alist."
  (setq mpg123*music-alist
	(delq (assq n mpg123*music-alist) mpg123*music-alist)))

(defun mpg123:open-error ()
  (momentary-string-display "
***********************************************************
Something is wrong with sound device.
It seemes that you don't have set up sound device on
this machine, or you already have running some application
which locks sound device in other session on this host.
Anyway, you have to make sure that mpg123 program plays
mp3 files on your pseudo terminal(xterm, rxvt, etc).
-- Type SPC to exit ---

サウンドデバイスが開けん素。
このマシンのオーディオデバイスはちゃんと設定したけ?
あと、ほかにサウンドデバイスを使うアプリケーションを起動して
いるんちゃう?
まず、ktermなどで mpg123 コマンド単独で音楽再生できるかどうか
確認してみれ。
(スペースキーでオサラバ)
***********************************************************" (point)))
  

(defun mpg123:initial-filter (proc mess)
  "mpg123 process filter No.1, called at startup of mpg123."
  (if (string-match "Can't open /dev" mess)
      (progn
	(set-process-filter proc nil)
	(mpg123:open-error)
	(error "bye")))
  (if (string-match "Frame# *[0-9]+ *\\[\\([ 0-9]+\\]\\)" mess)
      (let ((f (substring mess (match-beginning 1) (match-end 1))))
	(mpg123:set-music-info
	 mpg123*cur-music-number 'frames
	 (setq mpg123*cur-total-frame (string-to-number f)))))
  (if (string-match "Time: \\(..:..\\)... +\\[\\(..:..\\)" mess)
      (let ((cur (substring mess (match-beginning 1) (match-end 1)))
	    (max (substring mess (match-beginning 2) (match-end 2))))
	(mpg123:update-playtime cur)
	(mpg123:set-music-info
	 mpg123*cur-music-number 'length max)
	(if (not (string-equal "00:00" max))
	    (mpg123:update-length max))
    ))
  ;(save-excursion
  ;  (set-buffer mpg123*info-buffer)
  ;  (insert mess))
  (and (mpg123:get-music-info mpg123*cur-music-number 'length)
       (mpg123:get-music-info mpg123*cur-music-number 'frames)
       (set-process-filter proc 'mpg123:filter)))

(defvar mpg123*window-width nil)
(defvar mpg123*cur-total-frame nil)
(defvar mpg123*cur-slider-column nil)

;; (defun mpg123:move-slider (column)
;;   "Move slider to COLUMN"
;;   (let ((left (overlay-start mpg123*indicator-overlay)))
;;     (move-overlay mpg123*slider-overlay
;; 		  (+ left column)
;; 		  (+ left column 1)
;; 		  (overlay-buffer mpg123*slider-overlay))))

(defun mpg123:filter (proc mess)
  (if (stringp mess)
      (save-excursion
	;;(set-buffer mpg123*info-buffer)  ;heavy
	;;(insert mess)                    ;jobs
	(if (string-match "Time: \\(..:..\\)" mess)
	    (let ((s (substring mess (match-beginning 1) (match-end 1))))
	      (and (not (string= s mpg123*cur-playtime))
		   (not mpg123*time-setting-mode)
		   (mpg123:update-playtime (setq mpg123*cur-playtime s)))))
	(if (string-match "Frame# +\\([0-9]+\\)" mess)
	    (let (c)
	      (setq mpg123*cur-playframe
		    (substring mess  (match-beginning 1) (match-end 1)))
	      (mpg123:slider-check))))))

(defsubst mpg123:slider-check-1 ()
  (let ((c (/ (* mpg123*window-width
		 (string-to-int mpg123*cur-playframe))
	      mpg123*cur-total-frame))
	left)
    (or (eq c mpg123*cur-slider-column)
	(progn
	  (setq left (overlay-start mpg123*indicator-overlay))
	  (move-overlay mpg123*slider-overlay
			(+ left c)
			(+ left c 1)
			(overlay-buffer mpg123*slider-overlay))))))

(defsubst mpg123:null ())

(defun mpg123:sentinel (proc state)
  (cond
   ((string-match "^finished" state)
    (if mpg123*interrupt-p
	(progn
	  (if (eq mpg123*interrupt-p 'quit)
	      (kill-buffer mpg123*buffer))
	  (setq mpg123*interrupt-p nil))
      (setq mpg123*time-setting-mode nil)
      (mpg123:update-playtime "--:--")
      (if (eq (get-buffer mpg123*buffer)
              (marker-buffer mpg123*cur-play-marker))
          (let ((cb (current-buffer)) (sw (selected-window))
		(sf (selected-frame)) mp3w p)
            (set-buffer mpg123*buffer)
            (goto-char mpg123*cur-play-marker)
            (mpg123-next-line 1)
	    (sit-for 0)
            (if (and (not (mpg123:in-music-list-p))
                     (mpg123:repeat-check)) ;decrement counter and check
                (goto-char (point-min)))
	    (setq p (point))
	    (if (and (string-match "^19\\." emacs-version)
		     (setq mp3w (get-buffer-window mpg123*buffer t)))
		;; For the sake of Emacs 19, we have to switch to
		;; mpg123 buffer explicitly.
		(progn
		  (select-frame (window-frame mp3w))
		  (save-window-excursion
		    (select-window mp3w)
		    (switch-to-buffer mpg123*buffer)
		    (goto-char p)
		    (message "Next music")
		    (sit-for (string-to-number "0.1"))
		    (mpg123:play))
		  (select-frame sf)
		  (select-window sw)
		  (switch-to-buffer cb))
	      ;; Emacs20 or later, simply play it.
	      (mpg123:play))))))))

(defun mpg123:time2frame (timestr)
  "Convert time string (mm:ss) to frame number.(0.026s/f)"
  (string-match "\\(..\\):\\(..\\)" timestr)
  (let*((m (string-to-number
	    (substring timestr (match-beginning 1) (match-end 1))))
	(s (string-to-number
	    (substring timestr (match-beginning 2) (match-end 2))))
	(total (+ (* m 60) s))
	(frames (mpg123:get-music-info mpg123*cur-music-number 'frames))
	(length (mpg123:get-music-info mpg123*cur-music-number 'length))
	(ratio-f 1000) (ratio-s 26))
    (if (and frames length)
	;;if total frames and length(in time) is available,
	;;use them to calculate target frame number
	(setq ratio-f frames
	      ratio-s (+ (* 60 (string-to-number (substring length 0 2)))
			 (string-to-number (substring length 3 5)))))
    (format "%d" (/ (* total ratio-f) ratio-s))))

(defun mpg123:in-music-list-p ()
  (and (equal mpg123*buffer (buffer-name))
       (< (point) mpg123*end-of-list-marker)))

(defun mpg123:in-indicator-p (&optional pos)
  "Return whether the point (or POS) is in playing position indicator or not."
  (memq mpg123*indicator-overlay (overlays-at (or pos (point)))))

;;2000/5/19
(defvar mpg123*use-face t)
(defvar mpg123-face-playing '("yellow" . "#004080")
  "*Set of default playing cursor's foreground/background color.
Set this as '(FGCOLOR . BGCOLOR)
演奏中の曲名を示すカーソルの色。'(前景色 . 背景色) という
コンスセルで指定する。XEmacsでは -nw のときに表現できない色だと
デフォルト色になってしまうので、せめて前景色は yellow のような
基本8色の一つにしておくと良い。Emacs-21 は -nw で表現できない色は
基本8色のうち近い色にmappingしてくれるがどぎつい色になりやすいので
ほどほどに。")
(defvar mpg123-face-slider '("black" . "yellow")
  "*Set of default fgcolor/bgcolor of slider in indicator.
演奏中の曲の相対位置を示す曲リスト下部のインジケータ内スライダーの色
mpg123-face-playing のDOC-STRINGも参照せよ")

(defvar mpg123*cur-overlay nil "Overlay to cursor of playing position")
(defvar mpg123*slider-overlay nil "Overlay of playing position slider")

(if (featurep 'xemacs) (require 'overlay))
(if (and (fboundp 'make-face) mpg123*use-face)
    (progn
      (make-face 'mpg123-face-cur)
      (make-face 'mpg123-face-slider)
      (if (or (and (fboundp 'display-color-p)	;Emacs-21
		   (display-color-p))
	      (and (fboundp 'device-class) 	;XEmacs-21
		   (eq 'color (device-class (selected-device))))
	      (and window-system (x-display-color-p)))
	  (progn
	    (set-face-foreground 'mpg123-face-cur (car mpg123-face-playing))
	    (set-face-background 'mpg123-face-cur (cdr mpg123-face-playing))
	    (set-face-foreground 'mpg123-face-slider (car mpg123-face-slider))
	    (set-face-background 'mpg123-face-slider (cdr mpg123-face-slider)))
	(set-face-underline-p 'mpg123-face-cur t)
	(set-face-underline-p 'mpg123-face-slider t)
	(set-face-background 'mpg123-face-slider "white")))
  (setq mpg123*use-face nil))

(defvar mpg123-need-slider mpg123*use-face
  "*Need slider in the delimiter line which indicates playing position.
一覧の下の境界線領域に、現在曲のの再生位置を示すスライダーが要るかどうか。")


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
  (if mpg123*use-face
      (progn
	(setq mpg123*window-width (window-width))
	(and mpg123*cur-overlay (delete-overlay mpg123*cur-overlay))
	(and mpg123*slider-overlay
	     (delete-overlay mpg123*slider-overlay))))
  (setq mpg123*cur-play-marker (point-marker))
  (skip-chars-forward " ")
  (if (or (not (looking-at "[0-9]"))
	  (not (mpg123:in-music-list-p)))
      nil ;;if not on music line, then exit
    (let (music p)
      (setq mpg123*cur-music-number (mpg123:get-music-number)
	    mpg123*cur-total-frame (mpg123:get-music-info
				    mpg123*cur-music-number 'frames))

      (skip-chars-forward "^ ")
      (skip-chars-forward " ")
      (cond
       (startframe (setq mpg123*cur-start-frame startframe))
       ((or (looking-at mpg123*default-time-string))
	(setq mpg123*cur-start-frame "0"))
       (t
	(let ((time (buffer-substring
		     (point)
		     (progn (skip-chars-forward "^ /")(point)))))
	  (if (and (string= time mpg123*cur-playtime) mpg123*cur-playframe)
	      (setq mpg123*cur-start-frame mpg123*cur-playframe)
	    (setq mpg123*cur-start-frame (mpg123:time2frame time))))))
      (setq music (mpg123:get-music-info mpg123*cur-music-number 'filename))
      (if (fboundp 'code-convert-string)
	  (setq music (code-convert-string
		       music mpg123-process-coding-system *internal*)))
      (and (eq mpg123-system-type 'nt)		;convert to dos filename for
	   (fboundp 'unix-to-dos-file-name)	;music over shared folder(Win)
	   (setq music (unix-to-dos-file-name music)))
      (setq mpg123*time-setting-mode nil)
      (if mpg123*use-face
	  (let ((frames (mpg123:get-music-info mpg123*cur-music-number 'frames))
		(istart mpg123*end-of-list-marker))
	    (if (overlayp mpg123*indicator-overlay)
		(delete-overlay mpg123*indicator-overlay))
	    (setq mpg123*indicator-overlay
		  (make-overlay istart (+ (window-width) istart)))
	    (overlay-put (setq mpg123*cur-overlay
			       (make-overlay
				(save-excursion (beginning-of-line) (point))
				(save-excursion (end-of-line) (point))))
			 'face
			 'mpg123-face-cur)
	    (if mpg123-need-slider
		(progn
		  (fset 'mpg123:slider-check 'mpg123:slider-check-1)
		  (if frames
		      (setq istart
			    (+ istart
			       (/ (* (string-to-int mpg123*cur-start-frame)
				     mpg123*window-width)
				  frames))))
		  (overlay-put (setq mpg123*slider-overlay
				     (make-overlay istart (1+ istart)))
			       'face
			       'mpg123-face-slider))
	      (fset 'mpg123:slider-check 'mpg123:null))))
      (set-process-filter
       (setq p (apply 'start-process "mpg123"
		      (current-buffer)
		      mpg123-command
		      (delq nil
			    (append
			     (list
			      "-v" "-k" mpg123*cur-start-frame)
			     mpg123-command-args
			     (list music)
			     ))))
       (if (and (mpg123:get-music-info mpg123*cur-music-number 'length)
		(mpg123:get-music-info mpg123*cur-music-number 'frames))
	   'mpg123:filter
	 'mpg123:initial-filter))
      (message "%s %s.."
	       mpg123*cur-music-number
	       (mpg123:get-music-info mpg123*cur-music-number 'name))
      (set-process-sentinel p 'mpg123:sentinel))))

(defun mpg123:sure-kill (p)
  "Waiting process to be killed."
  (let ((retry (if (fboundp 'float) 50 5))) ;retry in seconds
    (while (and p (eq (process-status p) 'run)
		(>= (setq retry (1- retry)) 0))
      (interrupt-process p)
      (if (fboundp 'float)
	  (sit-for (string-to-number "0.1"))
	(sit-for 1))
      (if (input-pending-p)
	  (cond
	   ((fboundp 'read-event) (read-event))
	   ((fboundp 'next-command-event) (next-command-event))
	   (t (read-char))))
      (message "Waiting for process to exit..."))
    (message "")
    (if (and p (eq (process-status p) 'run))
	(error "Cannot terminate %s process" (process-name p)))))

(defun mpg123:kill-current-music (&optional proc)
  (let ((p (or proc (get-buffer-process (current-buffer)))))
    (and p (eq (process-status p) 'run)
	 (progn
	   (setq mpg123*interrupt-p t)
	   (mpg123:sure-kill p)))))

(defun mpg123-play-stop (&optional start-frame)
  "Play or Stop"
  (interactive)
  (let ((p (get-buffer-process (current-buffer)))
	now-stopped
	music)
    (if (and p (eq (process-status p) 'run))
	(progn
	  ;(interrupt-process p)
	  ;(sit-for 1)
	  ;(mpg123:sure-kill p)
	  (mpg123:kill-current-music)
	  (message "PAUSE!")
	  (setq now-stopped t)))
    (if (and now-stopped
	     (not mpg123*time-setting-mode)
	     (= (save-excursion (beginning-of-line) (point))
		(save-excursion (goto-char mpg123*cur-play-marker) (point))))
	nil ;if on the current music, do nothing (?)
      (mpg123:sure-kill p)
      (mpg123:play start-frame))))

(defun mpg123-mouse-play-stop (ev)
  "Play-Stop on current music."
  (interactive "e")
  (set-buffer mpg123*buffer)
  (if (and mpg123*cur-play-marker (markerp mpg123*cur-play-marker))
      (goto-char mpg123*cur-play-marker)
    (goto-char (point-min)))
  (mpg123-play-stop)
  (mouse-set-point ev))

;;;Mouse related functions from Seiichi Namba 2000/12
(defun mpg123-mouse-force-play (event)
  "Immediately move to line on click EVENT, and play the file.
Also you can hit \"^-----------\" line in *mpg123* buffer as if the
line were a scale corresponding to the length of the current music.
If 30% from the left was hit, the playing location jumps to that
percentage in the length of the song etc.
曲名のところに合わせてクリックするとその曲を直ちに演奏する。
曲一覧下部の ------ という行は曲全体の長さを示しており、ここでクリック
すると曲のその位置に直ちにジャンプする。"
  (interactive "e")
  (mouse-set-point event)
  (let (p)
    (cond
     ((mpg123:in-indicator-p)
      (mpg123*jump-to-pos))
     ((mpg123:in-music-list-p)
      (mpg123:kill-current-music)
      (mpg123-play-stop "0"))
     (t (message "Bad bad click, brother")))))

(defun mpg123*jump-to-pos ()
  "Jump to current music's certain position according to current column."
  (let ((p (get-buffer-process (current-buffer)))
	(c (current-column))
	(w (window-width))
	frames target)
    (if (null mpg123*cur-music-number) nil
      (mpg123:kill-current-music)
      (setq frames (mpg123:time2frame
		    (mpg123:get-music-info mpg123*cur-music-number 'length))
	    target (/ (* (string-to-int frames) c) w))
      (message "new = %d" target)
      (save-excursion
	;;set buffer in my responsibility
	(set-buffer (marker-buffer mpg123*cur-play-marker))
	(mpg123:goto-playtime-position)
	(mpg123:play (int-to-string target))))))

(defun mpg123-play ()
  "PLAY(from the beginning of the music)."
  (interactive)
  (cond
   ((mpg123:in-indicator-p) (mpg123*jump-to-pos))
   (t (mpg123-play-stop "0"))))

(defun mpg123-< (arg)
  "Rewind music by one."
  (interactive "p")
  (let ((p (get-buffer-process (current-buffer))))
    (cond
     ;;If currently playing, then rewind and start
     ((and p (eq (process-status p) 'run))
      (goto-char mpg123*cur-play-marker)
      (if (and (stringp mpg123*cur-playtime)
	       (string< mpg123*cur-playtime "00:05")) ; is 00:02 readsonable?
	  (progn
	    (mpg123:update-playtime "00:00")
	    (mpg123-prev-line arg)))
      (mpg123:kill-current-music p)
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
      (mpg123:kill-current-music p)
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
    (message "Mark the position of [%s].  Push `%s' to restart here"
	     mpg123*cur-playtime
	     (substitute-command-keys "\\[mpg123-refrain]"))))

(defun mpg123-refrain ()
  "Refrain from marked position."
  (interactive)
  (let ((frame (mpg123:get-music-info mpg123*cur-music-number 'mark)))
    (if frame
	(progn
	  (mpg123:kill-current-music)
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
    ;;set buffer in my responsibility
    (set-buffer (marker-buffer mpg123*cur-play-marker))
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
  "Open new directory or playlist."
  (interactive "Fmpg123 on directory or playlist: ")
  (if (not (file-exists-p dir))
      (error "Not such file or directory: %s" dir))
  (mpg123:kill-current-music)
  (mpg123 dir))

(defun mpg123:playlist-p (file)
  "Check if FILE can be seemed to be a playlist"
  (and
   (file-exists-p file)
   (not (file-directory-p file))
   ;(not (mpg123:sound-p file))
   (let ((b (set-buffer (get-buffer-create " *mpg123pl*")))
	 (PATH_MAX 1024)
	 (dir (file-name-directory file)))
     (erase-buffer)
     (insert-file-contents file nil 0 PATH_MAX)
     (goto-char (point-min))
     (while (looking-at "\\s *#") (forward-line 1))
     (skip-chars-forward "[ \t]")
     (prog1
	 (file-exists-p
	  (expand-file-name
	   (buffer-substring
	    (point)
	    (progn (end-of-line) (skip-chars-backward "[ \t]") (point)))
	   dir))
       (kill-buffer b)))))

(defun mpg123-add-new (file)
  "Add a new file or directory to the playist"
  (interactive "Fmpg123 add to playlist: ")
  ;;(cd (file-name-directory file))
  (setq file (expand-file-name file))
  (cond ((file-directory-p file)
         ;; Add all files and playlists in a directory
         (mpg123-add-to-playlist (mpg123:mp3-files-in-dir file)))
	((mpg123:sound-p file)
	 (mpg123-add-to-playlist (list file)))
        (;(string-match mpg123-playlist-regexp file)
	 (mpg123:playlist-p file)
         ;; Add all files in a playlist file
         (mpg123-add-to-playlist (mpg123:mp3-files-in-list file)))
        ((string-match mpg123-url-regexp file)
         ;; Add file[s] from an external URL
         (error "mpg123: URL's not yet supported"))
        (t
         ;; Add a single file
         (mpg123-add-to-playlist (list file)))))

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
	    n current (stack "") buffer-read-only p
	    (sw (selected-window)))
	(save-excursion
	  (set-buffer sb)
	  (use-local-map mpg123-mode-map))
	(while (and (> arg 0) (mpg123:in-music-list-p))
	  (setq n (mpg123:get-music-number))
	  (if (and (markerp mpg123*cur-play-marker)
		   (eq (marker-buffer mpg123*cur-play-marker) (current-buffer))
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
		  (setq current nil p (point))
		  (insert (mpg123:format-line n))
		  (if (overlayp mpg123*cur-overlay)
		      (move-overlay
		       mpg123*cur-overlay p (point) (current-buffer))))
	      (insert-before-markers (mpg123:format-line n))))
	  (setq arg (1- arg)))
	(mpg123:popup-buffer sb)
	(goto-char (point-min))
	(select-window sw))))

(defun mpg123-kill-stack ()
  "Kill all music list in stack."
  (interactive)
  "Not yet implemented")

(defun mpg123-yank-line (arg)
  "Yank music line from stack buffer."
  (interactive "p")
  (beginning-of-line)
  (if (= mpg123*end-of-list-marker (point))
      (let (buffer-read-only)
	(insert-before-markers "\t") ;dirty hack!
	(backward-char 1)))
  (if (mpg123:in-music-list-p)
      (let ((sb (get-buffer-create mpg123*stack-buffer))
	    (sw (selected-window)) stackw
	    n buffer-read-only current p)
	(beginning-of-line)
	(mpg123:popup-buffer sb)
	(setq stackw (selected-window))
	(goto-char (point-min))
	(while (and (setq n (mpg123:get-music-number))
		    (> arg 0))
	  (if (and (markerp mpg123*cur-play-marker)
		   (eq (marker-buffer mpg123*cur-play-marker) (current-buffer))
		   (= (point) mpg123*cur-play-marker))
	      (setq current t))
	  (delete-region (point) (progn (forward-line 1) (point)))
	  (save-excursion
	    (set-buffer mpg123*buffer)
	    (if current
		(progn
		  (set-marker mpg123*cur-play-marker nil)
		  (setq mpg123*cur-play-marker (point-marker))
		  (setq current nil p (point))
		  (insert (mpg123:format-line n))
		  (if (overlayp mpg123*cur-overlay)
		      (move-overlay
		       mpg123*cur-overlay p (point) (current-buffer))))
	      (insert-before-markers (mpg123:format-line n))))
	  (setq arg (1- arg)))
	(if (progn (set-buffer sb)
		   (= (buffer-size) 0))
	    (progn
	      (delete-window stackw)
	      (kill-buffer sb)))
	(select-window sw)
	(if (eq ?\t (char-after (1- mpg123*end-of-list-marker)))
	    (save-excursion
	      (goto-char mpg123*end-of-list-marker)
	      (delete-backward-char 1))) ;dirty hack
	)))

(defun mpg123-shuffle (&optional method)
  "Shuffle the music!
From Lisp program, you can specify one of order/Inverse/Random by
optional argument METHOD.  Set one of ?o or ?i or ?r."
  (interactive)
  (message "Shuffle music by...(O)rder, (I)nverse order, (R)andom: ")
  (let ((c (or method (read-char)))
	ord (n 0) (l (length mpg123*music-alist))
	r tmp buffer-read-only (p (point))
	(number-list (sort (mapcar (function (lambda (s) (car s)))
				   mpg123*music-alist)
			   '<)))
    (cond
     ((eq c ?o)
      (setq n l)
      (while (>= (setq n (1- n)) 0)
	(setq ord (cons (nth n number-list) ord))))
     ((eq c ?i)
      (while (< n l)
	(setq ord (cons (nth n number-list) ord)
	      n (1+ n))))
     ((eq c ?r)
      (random t)
      (setq ord (make-vector l nil))
      (while (< n l)
	(aset ord n (nth n number-list)) (setq n (1+ n)))
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

(defun mpg123-delete-file ()
  "Delete audio file on the point."
  (interactive)
  (if (not (mpg123:in-music-list-p))
    (error "Not on music list"))
  (let*((n (mpg123:get-music-number)) p c
	(file (mpg123:get-music-info n 'filename)))
    (message "Delete file?(%s) [Y]es, [L]from list, [N]o"
	     (file-name-nondirectory file))
    (setq c (read-char))
    (cond
     ((memq c '(?y ?Y ?L ?l))
      (beginning-of-line)
      (setq p (point))
      (if (and mpg123*cur-play-marker
	       (marker-position mpg123*cur-play-marker)
	       (eq (point)
		   (save-excursion
		     (goto-char mpg123*cur-play-marker)
		     (beginning-of-line)
		     (point))))
	  (save-excursion (mpg123-> 1)))
      (let ((buffer-read-only nil))
	(if (memq c '(?Y ?y)) (delete-file file))
	(delete-region (point)
		       (progn (forward-line 1) (point)))
	(mpg123:delete-music-from-list n)))
     (t
      (message "Canceled")))))

(defun mpg123-quit (&optional yes)
  "Quit"
  (interactive)
  (let ((p (get-buffer-process (current-buffer)))
	(buffers (list mpg123*buffer mpg123*info-buffer
		  " *mpg123tmp* " " *mpg123 tag tmp*" " *mpg123 mixer* ")))
    (if (and p
	     (eq (process-status p) 'run)
	     (or yes (y-or-n-p "Kill current music?")))
	(mpg123:sure-kill p)
      (setq buffers (delete mpg123*buffer buffers))
      (switch-to-buffer (get-buffer-create mpg123*initial-buffer)))
    (setq mpg123*interrupt-p 'quit)
    (mapcar '(lambda (b) (and (get-buffer b) (kill-buffer b))) buffers)))

(defun mpg123-quit-yes ()
  "Force to quit"
  (interactive)
  (mpg123-quit t))

(defun mpg123:mp3-files-in-dir (dir)
  "Return mp3 files in a directory"
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

(defun mpg123:mp3-files-in-list1 (file)
  (save-excursion
    (let ((buf (find-file-noselect file))
          (dir (file-name-directory file)) f mp3s)
      (put 'mpg123:mp3-files-in-list 'parsed
	   (cons (cons (expand-file-name file) nil)
		 (get 'mpg123:mp3-files-in-list 'parsed)))
      (set-buffer buf)
      (goto-char (point-min))
      (while (not (eobp))
        (and (looking-at "^[ \t]*\\(.*[^ \t\n]\\)[ \t\n]*$")
             (setq f (expand-file-name
                      (buffer-substring (match-beginning 1)
                                        (match-end 1))
                      dir))
             (message "Inspect file %s..." f)
             (not (file-directory-p f))
             (file-readable-p f)
	     (cond
	      ((mpg123:sound-p f)
	       (setq mp3s (cons f mp3s)))
	      ((and
		(not (assoc (expand-file-name f)
			    (get 'mpg123:mp3-files-in-list 'parsed)))
		(mpg123:playlist-p f))
	       (setq mp3s (append (mpg123:mp3-files-in-list1 f) mp3s)))))
        (message "")
        (forward-line 1))
      (if (buffer-modified-p buf)
          (bury-buffer buf)
        (kill-buffer buf))
      mp3s)))

(defun mpg123:mp3-files-in-list (file)
  "Return mp3 files in a playlist"
  (put 'mpg123:mp3-files-in-list 'parsed nil)
  (nreverse (mpg123:mp3-files-in-list1 file)))

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
  (let ((sz (nth 7 (file-attributes (file-truename file))))
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
		    (or mpg123-omit-id3-artist
			(concat " by "
				(if (string< "" artist)
				    artist "UnknownArtist")))))
	(kill-buffer b)
	(setq file (file-name-nondirectory file))
	(if (fboundp 'code-convert-string)
	    (code-convert-string file mpg123-process-coding-system *internal*)
	  (file-name-nondirectory file))))))

(defun mpg123:insert-help ()
  "Insert help string to current buffer."
  (if mpg123-show-help
      (insert (substitute-command-keys "
mpg123:
\\[mpg123-play-stop]	Play or pause
\\[mpg123-play]	Play
\\[mpg123-mark-position]	Mark position (when playing)
\\[mpg123-refrain]	Restart from marked position
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
\\[mpg123-open-new]	Open other directory or playlist file
\\[mpg123-add-new]	Add other directory or playlist file
\\[mpg123-save-playlist]	Save current playlist to a file
\\[mpg123-increase-repeat-count]	Increase repetition count
\\[mpg123-decrease-repeat-count]\tDecrease repetition count (-1 for infinity)
\\[mpg123-shuffle]	Shuffle music list
\\[mpg123-kill-line]	Kill music line and push onto stack
\\[mpg123-yank-line]	Yank music line from stack
\\[mpg123-quit]	Quit
\\[mpg123-quit-yes]	Quit without query
\\[mpg123-mouse-force-play]	Select a music directly on the mouse cursor
0..9	Digit argument (ex. 50V increase volume by 50steps)
----
The delimiter line \"-------\" is the indicator of currently playing position.
You may see the slider on the line running from left to right while the
music's going ahead.  If you hit \\[mpg123-play] or \\[mpg123-mouse-force-play] on the indicator line,
the music will immediately move to that position.
"
))))


(defun mpg123:format-line (n)
  (if (stringp n) (setq n (string-to-int n)))
  (if (mpg123:get-music-info n 'name)
      (format "%2d --:--/%s\t %s\n"
	      n
	      (or (mpg123:get-music-info n 'length) "--:--")
	      (mpg123:get-music-info n 'name))))

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

(defvar mpg123*indicator-overlay nil)

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
  (if (overlayp mpg123*indicator-overlay)
      (delete-overlay mpg123*indicator-overlay))
  (if mpg123-need-slider
      (progn
	(insert "0%")	;2columns
	(insert-char ?- (/ (- (window-width) 9) 2))
	(insert "50%")	;3columns
	(insert-char ?- (- (window-width) (current-column) 5))
	(insert "100%"))	;4columns
    (insert-char ?- (1- (window-width))))
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

(defun mpg123-add-to-playlist (files)
  "Add files to the current playlist"
  (switch-to-buffer (get-buffer-create mpg123*buffer))
  (setq buffer-read-only nil)
  (buffer-disable-undo)
  (save-excursion
    (goto-char (marker-position mpg123*end-of-list-marker))
    (let (f (i (1+ (length mpg123*music-alist))) name)
      (while files
	(setq f (car files))
	(setq name (if (fboundp mpg123-id3-tag-function)
		       (funcall mpg123-id3-tag-function f)
		     (file-name-nondirectory f)))
	(mpg123:set-music-info i 'filename f)
	(mpg123:set-music-info i 'name name)
	(insert-before-markers (mpg123:format-line i))
	(setq i (1+ i)
	      files (cdr files))))
    (setq buffer-read-only t)))

(defun mpg123-save-playlist (file)
  "Save current music list into a file"
  (interactive "FSave Playlist to a file: ")
  (let (list n)
    (or (eq major-mode 'mpg123-mode)
	(error "[Save playlist] is only available in *mpg123* buffer."))
    (if (file-exists-p file)
	(or (y-or-n-p (format "Overwrite %s? " file))
	    (error "Abort.")))
    (save-excursion
      (save-restriction
	(widen)
	(narrow-to-region (point-min) mpg123*end-of-list-marker)
	(goto-char (point-min))
	(while (looking-at "^[ 0-9]+")
	  (setq n (mpg123:get-music-number)) ;get current line's music No.
	  (setq list (cons (mpg123:get-music-info n 'filename) list))
	  (forward-line 1))
	(set-buffer (find-file-noselect file))
	(erase-buffer)
	(while list
	  (goto-char (point-min))
	  (insert (abbreviate-file-name (car list)) "\n")
	  (setq list (cdr list)))
	(basic-save-buffer)))))

;;;
;; Mixer
;;;
(defun mpg123:get-volume ()
  "Get current volume"
  (if mpg123-mixer-command
      (cond
       ((eq mpg123-system-type 'freebsd)
	(let ((b (get-buffer-create " *mpg123 mixer* "))
	      vol)
	  (set-buffer b)
	  (erase-buffer)
	  (call-process mpg123-mixer-command nil b nil "vol")
	  (goto-char (point-min))
	  (if (re-search-forward "set to *\\([0-9]+\\):\\([0-9]+\\)" nil t)
	      (let ((left (buffer-substring
			   (match-beginning 1) (match-end 1)))
		    (right (buffer-substring
			    (match-beginning 2) (match-end 2))))
		(setq vol (cons (string-to-int left) (string-to-int right))))
	    (setq vol "unknown"))
	  (setq mpg123*cur-volume vol)))
       ((eq mpg123-system-type 'netbsd)
	(let ((b (get-buffer-create " *mpg123 mixer* "))
	      vol)
	  (set-buffer b)
	  (erase-buffer)
	  (call-process mpg123-mixer-command
			nil b nil "-v" (car mpg123-mixer-setvol-target-list))
	  (goto-char (point-min))
	  (if (re-search-forward "=*\\([0-9]+\\),\\([0-9]+\\)" nil t)
	      (let ((left (buffer-substring
			   (match-beginning 1) (match-end 1)))
		    (right (buffer-substring
			    (match-beginning 2) (match-end 2))))
		(setq vol (cons (string-to-int left) (string-to-int right))))
	    (setq vol "unknown"))
	  (setq mpg123*cur-volume vol)))
       ((eq mpg123-system-type 'linux)
	(let ((b (get-buffer-create " *mpg123 mixer* "))
	      vol)
	  (set-buffer b)
	  (erase-buffer)
	  (call-process mpg123-mixer-command nil b nil "-w" "q")
	  (goto-char (point-min))
	  (if (re-search-forward "pcm *\\([0-9]+\\), *\\([0-9]+\\)" nil t)
	      (let ((left (buffer-substring
			   (match-beginning 1) (match-end 1)))
		    (right (buffer-substring
			    (match-beginning 2) (match-end 2))))
		(setq vol (cons (string-to-int left) (string-to-int right))))
	    (setq vol "unknown"))
	  (setq mpg123*cur-volume vol)))
       ((eq mpg123-system-type 'solaris)
	"unknown"))))

(defun mpg123:set-volume (vollist)
  "Set volume"
  (if (integerp vollist) (setq vollist (cons vollist vollist)))
  (if (and mpg123-mixer-command
	   (memq mpg123-system-type '(freebsd netbsd linux solaris nt)))
      (let*((l mpg123-mixer-setvol-target-list)
	    (ctl-type (string-match "mixerctl" mpg123-mixer-command))
	    (v (format "%d%c%d"
		       (car vollist) (if ctl-type ?, ?:) (cdr vollist)))
	    args)
	(setq mpg123*cur-volume vollist)
	(while l
	  (setq args
		(if ctl-type
		    (cons (format "%s=%s" (car l) v) args)
		  (cons (car l) (cons v args))))
	  (setq l (cdr l)))
	(if ctl-type (setq args (cons "-w" args)))
	(apply 'call-process
	       mpg123-mixer-command nil nil nil
	       args))))

(defun mpg123-volume-increase (arg)
  "Increase both(left/right) volume by ARG count."
  (interactive "p")
  (let ((maxvol (if (string-match "mixerctl" mpg123-mixer-command) 255 100)))
    (cond
     ((consp mpg123*cur-volume)
      (let ((left (car mpg123*cur-volume)) (right (cdr mpg123*cur-volume)))
	(setq left (max 0 (min maxvol (+ arg left)))
	      right (max 0 (min maxvol (+ arg right))))
	(mpg123:set-volume (cons left right))))
     ((integerp mpg123*cur-volume)
      (let ((v (max 0 (min (+ mpg123*cur-volume arg)))))
	(mpg123:set-volume (cons v v)))))
    (mpg123:update-volume mpg123*cur-volume)))

(defun mpg123-volume-decrease (arg)
  "Decrease both(left/right) volume by ARG count."
  (interactive "p")
  (mpg123-volume-increase (- arg)))

(defun mpg123:initialize ()
  (if (get 'mpg123:initialize 'done)
      nil
    (mpg123:set-volume mpg123-startup-volume)
    (put  'mpg123:initialize 'done t)))

(defvar mpg123*initial-buffer nil)
(setq mpg123*initial-buffer (current-buffer))

;;;
;; mpg123 main function
;;;
(defun mpg123 (file)
  "Call mpg123 on file"
  (interactive "Fmpg123 on file: ")
  (let ((dir (file-name-directory file))
        (files
         (cond ((file-directory-p file)
                ;; Add all files and playlists in a directory
                (mpg123:mp3-files-in-dir file))
               ((mpg123:playlist-p file)
                ;; Load all files in a playlist file
		(mpg123:mp3-files-in-list file))
               ((mpg123:sound-p file)
                ;; Add a single file
                (list file))
               (t
                (error "Not an mp3 or playlist: %s" file)))))
    (mpg123:create-buffer files)
    (message "Let's listen to the music. Type SPC to start.")
    (run-hooks 'mpg123-hook)))

(if (and mpg123-process-coding-system (symbolp mpg123-process-coding-system))
    (let ((coding mpg123-process-coding-system))
      (cond
       ((fboundp 'modify-coding-system-alist)
	(modify-coding-system-alist
	 'process mpg123-command (cons coding coding)))
       ((fboundp 'define-program-coding-system)
	(define-program-coding-system nil mpg123-command (cons coding coding)))
       (t nil))))

(provide 'mpg123)
(mpg123:initialize)
(run-hooks 'mpg123-load-hook)
;;(load "id3")
(autoload 'id3-edit "id3" "Edit id3tag" t)


; Local variables: 
; fill-prefix: ";;	" 
; paragraph-start: "^$\\|\\|;;$" 
; paragraph-separate: "^$\\|\\|;;$" 
; buffer-file-coding-system: euc-jp
; End: 
