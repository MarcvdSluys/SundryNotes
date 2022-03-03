;; MvdS emacs orgmode settings
;; 
;; Reload this file:  M-x load-file ENT
;; Evaluate a region: select region, M-x eval-region


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;  GENERAL  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use .org mode for .txt files:
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode) )

;; Open (links to) .jot files in emacs (rather than less):
(push '("\\.jot\\'" . emacs) org-file-apps)

;; Open a file in the same window when following a link (or always?):
(setq org-link-frame-setup (delete '(file . find-file-other-window)  org-link-frame-setup))  ;; Remove the original entry
(add-to-list 'org-link-frame-setup '(file . find-file) )                                     ;; Replace with the new value



;; Use indented mode for headlines ("^  *" -> "^**"):
(setq org-startup-indented t)

;; Start with folded trees when opening file:
(setq org-startup-folded t)  ;; t: primary headlines only, nil: show everything

;; Use section numbers for headlines:
(add-hook 'org-mode-hook 'org-num-mode)

;; Use speed keys at the start of a headline (https://orgmode.org/manual/Speed-Keys.html):
(setq org-use-speed-commands t)

;; Show table header even if the first table line is invisible:
(setq-default org-table-header-line-mode t)

;; More beautiful headlines?  Larger fonts, but no colours...
;; (require 'org-beautify-theme)



;; My global keys:
(global-set-key (kbd "C-c a")  'org-agenda)                    ;; Switch to org agenda options list - press a again for agenda
(global-set-key (kbd "C-c c")  'org-capture)                   ;; Capture an idea/todo - see org-capture-templates below
(global-set-key (kbd "C-c b")  'org-switchb)                   ;; Switch between org buffers - use Tab to see possible completions
(global-set-key (kbd "C-c k")  'calendar)                      ;; Open Emacs (not org-mode) calendar.  Press po to print today's date in other calendars  -  https://www.gnu.org/software/emacs/manual/html_node/emacs/To-Other-Calendar.html#To-Other-Calendar

(global-set-key (kbd "C-c l s") 'org-store-link)               ;; Store a link to the current file/email in a list - C-c l a / C-c l i (see below) to insert elsewhere
(global-set-key (kbd "C-c l l") 'org-store-link)               ;; Store a link to the current file/email in a list - C-c l a / C-c l i (see below) to insert elsewhere
(global-set-key (kbd "C-c l i") 'org-insert-link)              ;; Insert a stored link from a list (stored with C-c l s)
(global-set-key (kbd "C-c l a") 'org-insert-last-stored-link)  ;; Insert the last stored link (stored with C-c l s)

;; Auto-save orgmode buffers when auto-save is kicking in (after 300 chars or 30s of idleness by default)
;; (https://emacs.stackexchange.com/a/38068/17538):
(add-hook 'auto-save-hook 'org-save-all-org-buffers)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;  AGENDA  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Agenda custom commands - https://orgmode.org/manual/Storing-searches.html
;; Display agenda AND todos (assigned to n by default, but C-c a a is quicker):
(setq org-agenda-custom-commands
      '(("a" "Agenda and all TODOs" ((agenda "") (alltodo ""))))
      )

(setq org-agenda-confirm-kill t)  ;; Confirm to exit Agenda(?)


;; Start week (e.g. week, fortnight in agenda) on Sunday:
(setq org-agenda-start-on-weekday 0)


;; List of Closed (DONE) tasks for the last two weeks (https://emacs.stackexchange.com/a/53007/17538):
;; (add-to-list 'org-agenda-custom-commands
;;              '("W" "Weekly review"
;;                agenda ""
;;                ((org-agenda-start-day "-14d")
;;                 (org-agenda-span 15)
;;                 (org-agenda-start-on-weekday 1)
;;                 (org-agenda-start-with-log-mode '(closed))
;; ;;                (org-agenda-log-mode-items '(closed))
;;                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "^\\*\\* DONE "))
;; ;;                (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp " CLOSED: "))
;;              )
;;             )
;;           )

;; Org mode: don't display days in clock tables / clock reports (1d 01:00 -> 25:00):
(setq org-duration-format 'h:mm)  ;; New format - https://stackoverflow.com/a/17930704/1386750
;;(setq org-time-clocksum-format :hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)  ;; Old format - https://stackoverflow.com/a/17930704/1386750
(setq org-time-clocksum-use-fractional t)  ;; Use decimal hours - https://stackoverflow.com/a/30104957/1386750
;; (:days "%dd " :hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)

;; Save the clock history across Emacs sessions:  -  https://orgmode.org/manual/Clocking-work-time.html
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Clocktable default -> custom format:
;; Default: (setq org-clocktable-defaults '(:maxlevel 2 :lang "en" :scope file :block nil :wstart 1 :mstart 1 :tstart nil :tend nil :step nil :stepskip0 nil :fileskip0 nil :tags nil :match nil :emphasize nil :link nil :narrow 40! :indent t :formula nil :timestamp nil :level nil :tcolumns nil :formatter nil))
(setq org-clocktable-defaults '(:maxlevel 2 :lang "en" :scope file :block nil :wstart 1 :mstart 1 :tstart nil :tend nil :step nil :stepskip0 nil :fileskip0 t :tags nil :match nil :emphasize nil :link nil :narrow 53! :indent t :formula nil :timestamp t :level nil :tcolumns nil :formatter nil))  ;; narrow 60 -> 53 when adding column in decimal hours below
;; (setq org-clocktable-defaults '(:fileskip0 t :narrow 65! :indent t :timestamp t))  ;; Should be same as above, but doesn't work for weekly totals in hanhours-report

;; Add the currently clocked task to the clocktable:
(setq org-clock-report-include-clocking-task t)
;; (setq org-clock-report-include-clocking-task nil)  ;; 2020-05-30: weird behaviour when editing Python since I added this?

;; Add a colum to the clock table/clock report to show the time in decimal hours (adapted from https://emacs.stackexchange.com/a/12883/17538):
(setq org-agenda-clockreport-parameter-plist 
      '(:link t :formula "$6=($4+$5);t")
      )

;; Show only the current clocking instance of the current task, rather than all time ever (default value: auto)
(setq org-clock-mode-line-total 'current)

;; Open agenda in current window rather than a new one:
(setq org-agenda-window-setup (quote current-window))



;; Warn me of any deadlines in next 14 days (default: 14):
(setq org-deadline-warning-days 14)

;; Default Agenda view is a single day:
;;(setq org-agenda-span (quote fortnight))  ;; 14 days
(setq org-agenda-span (quote day))  ;; single day

;; Don't show tasks as scheduled if they are already shown as a deadline:
;; (setq org-agenda-skip-scheduled-if-deadline-is-shown t)

;; Don't give a warning colour to tasks with impending deadlines if they are scheduled to be done:
;; (setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))

;; Don't show SCHEDULED TASKS in Agenda if they are marked DONE:  -  https://orgmode.org/manual/Deadlines-and-scheduling.html - https://stackoverflow.com/a/8282185/1386750
;; (setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-scheduled-if-done nil)

;; Don't show DEADLINES in Agenda if they are marked DONE:  -  https://orgmode.org/manual/Deadlines-and-scheduling.html - https://stackoverflow.com/a/8282185/1386750
(setq org-agenda-skip-deadline-if-done t)

;; Don't show tasks that are scheduled or have deadlines in the normal todo list:
;; (setq org-agenda-todo-ignore-deadlines (quote all))  ;; past/future/all Covered by org-agenda-todo-ignore-with-date
;; (setq org-agenda-todo-ignore-scheduled (quote all))  ;; past/future/all Covered by org-agenda-todo-ignore-with-date
(setq org-agenda-todo-ignore-with-date t)            ;; past/future/all Covered by org-agenda-todo-ignore-timestamp - NO!
;;(setq org-agenda-todo-ignore-timestamp (quote all))  ;; past/future/all
;;(setq org-agenda-todo-ignore-timestamp nil)  ;; none

;; Sort tasks in order of when they are due and then by priority:
;; (setq org-agenda-sorting-strategy
;;       (quote
;;        (
;;      (agenda deadline-up priority-down)
;;      (todo priority-down category-keep)
;;      (tags priority-down category-keep)
;;      (search category-keep)
;;      )))

;; Sort tasks in order of when they are due and then by priority - MvdS - flips time grid when time-up is left out!:
(setq org-agenda-sorting-strategy
      (quote
       (
        (agenda time-up scheduled-up deadline-up priority-down)
        (todo scheduled-up deadline-up priority-down category-keep)
        (tags priority-down category-keep)
        (search category-keep)
        )))


;; Use 10x10 pixel icons for categories in Agenda view:
(setq org-agenda-category-icon-alist nil)  ;; Empty list before adding items:
(add-to-list 'org-agenda-category-icon-alist '("GWs"      "/home/sluys/local/www/avatars/software_logos/gws-10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("Git"      "/home/sluys/local/www/avatars/software_logos/git-icon-10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("GitHub"   "/home/sluys/local/www/avatars/software_logos/GitHub-icon2-10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("Sky"      "/home/sluys/local/www/avatars/software_logos/hwc-icon-10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("AstroC"   "/home/sluys/local/www/avatars/software_logos/hwc-icon-10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("Hack"     "/home/sluys/local/www/avatars/AstroFloyd_icon_10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("RU"       "/home/sluys/local/www/avatars/RUN-icon-10.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("Priv"     "/home/sluys/local/www/avatars/Faces/marc_cool_10.jpg" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("BA"       "/home/sluys/local/www/avatars/BA-Nero-10.jpg" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("calendar" "/home/sluys/local/www/avatars/software_logos/gcalendar-10a.png" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("Email"    "/home/sluys/local/www/avatars/software_logos/email-10b.jpg" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("gcalMvdS" "/home/sluys/local/www/avatars/software_logos/google-logo-10.jpg" nil nil :ascent center) )
(add-to-list 'org-agenda-category-icon-alist '("Gentoo"   "/home/sluys/local/www/avatars/software_logos/Gentoo_logo_10.png" nil nil :ascent center) )


;; Allow refiling tasks to all agenda files:
(setq org-refile-targets
      '(
	(nil :maxlevel . 1)
        (org-agenda-files :maxlevel . 1)
        ("GWs.org" :maxlevel . 2)
	)
      )


;; Blend in/out selected holidays from emacs (https://emacs.stackexchange.com/a/13236/17538):
(setq holiday-bahai-holidays nil)
(setq holiday-hebrew-holidays nil)
(setq holiday-islamic-holidays nil)
(setq holiday-oriental-holidays nil)
(setq org-agenda-include-diary t)

;; Custom holidays (https://github.com/abo-abo/netherlands-holidays):
(setq holiday-local-holidays
  '(
    (holiday-fixed  4 27 "Koningsdag")
    (holiday-fixed  5  5 "Bevrijdingsdag")
    (holiday-fixed 12  5 "Sinterklaas")
    (holiday-fixed 12 24 "Christmas eve")
    (holiday-fixed 12 26 "Boxing day")
    (holiday-fixed 12 31 "Old-year's eve")
    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  TODO LISTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; See http://pragmaticemacs.com/emacs/org-mode-basics-vi-a-simple-todo-list/

;; Set priority range from A to D with default D
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?D)
(setq org-default-priority ?C)

;; Set colours for priorities:
(setq org-priority-faces '((?A . (:foreground "red" :weight bold))
                           (?B . (:foreground "orange" :weight bold))
                           (?C . (:foreground "green" :weight bold))
                           (?D . (:foreground "grey"))  ;; 'hidden'
                           )
      )


;; Set default column view headings: Task Total-Time Time-Stamp - http://www.cachestocaches.com/2016/9/my-workflow-org-agenda/
;; View with C-c C-x C-c - quit with q
(setq org-columns-default-format "%ITEM(Task) %PRIORITY(Prio) %TODO(Status) %EFFORT(Effort) %CLOCKSUM(Clocked)")

;; Effort and global properties - https://github.com/pokeefe/Settings/blob/master/emacs-settings/.emacs.d/modules/init-org.el
(setq org-global-properties '(("Effort_ALL". "0 0:15 0:30 1:00 1:30 2:00 3:00 4:00 5:00 6:00 7:00 8:00")))

;; Org todo categories (http://doc.norang.ca/org-mode.html#TasksAndStates):
;; Keywords after |, or the last keyword in absence of |, mean "done"
;; (x) specifies shortcut, @/! that a message is requested (? - e.g., why cancelled?)
(setq org-todo-keywords
      (quote (
              (sequence "TODO(t)" "ACTIVE" "NEXT(n)" "PROGRESS(p)" "WAITING(w)" "HOLD(h)" "|" "DONE(d)" "CANCELLED(c)" "SKIPPED(s)" "ABORTED(a)")
              (sequence "OPEN(o)" "ASSIGNED(a)" "|" "CLOSED(c)")
              )))
;;              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

;; Org todo category colours (http://doc.norang.ca/org-mode.html#TasksAndStates):
(setq org-todo-keyword-faces
      (quote (
              ("TODO"      :foreground "red"     :weight bold)
              ("OPEN"      :foreground "red"     :weight bold)
              ("NEXT"      :foreground "magenta" :weight bold)
              ("ACTIVE"    :foreground "magenta" :weight bold)
              ("PROGRESS"  :foreground "orange"  :weight bold)
              ("WAITING"   :foreground "orange"  :weight bold)
              ("HOLD"      :foreground "orange"  :weight bold)
              ("ASSIGNED"  :foreground "orange"  :weight bold)
              ("DONE"      :foreground "green")
              ("CANCELLED" :foreground "green")
              ("ABORTED"   :foreground "green")
              ("CLOSED"    :foreground "green")
              )))

;; Set todo state to ACTIVE when clocking in (https://emacs.stackexchange.com/a/57851/17538) and WAITING when clocking out:
(setq org-clock-in-switch-to-state  "ACTIVE")
(setq org-clock-out-switch-to-state "WAITING")

;; Log a timestamp when a TODO becomes done:
(setq org-log-done 'time)

;; Automatically change TODO entry to DONE when all children are done:  -  https://orgmode.org/manual/Breaking-down-tasks.html
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  CAPTURES  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; See http://pragmaticemacs.com/emacs/org-mode-basics-vi-a-simple-todo-list/

;; Capture todo and clocking items using C-c c <char> [<char> ...] (see key for org-capture above) and add (scheduled)
;;   timestamp for today (%t):
;; - Clock: start timer (which sets task to magenta ACTIVE, see org-todo-keywords ff. above).
;; - Todo: no timer, add TODO and SCHEDULED, so that it will still show up the next day, until it is DONE.
;; - Appointment: no timer, TODO, but not SCHEDULED, so it won't show up the next day.
;; - Deadline: no timer, TODO and DEADLINE: will start showing up 14 days in advance (see org-deadline-warning-days above).
;; Most tasks are assigned to their respective files, GW tasks are filed under their project header, to track clocked time per project.
;; E.g. "C-c c g c p d" clocks a GW task for DetChar, "C-c c g t p d" adds a todo for that project.
;; See https://orgmode.org/manual/Template-expansion.html for details.

(setq org-capture-templates
      '(
	;; GWs:
        ("g" "GWs")
	
	
        ;; Clock a GW task:
        ("gc" "Clock a GW task")
        
        ("gce" "Email and calendar" entry (file+headline "~/.org/GWs.org" "Organisation")
         "* Org: email, chat, calendar\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t :immediate-finish t)
	
	
        ("gcp" "Clock a GW PROJECT")
	
        ("gcpp" "Pipeline" entry (file+headline "~/.org/GWs.org" "Pipeline")
         "* Pline: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("gcpd" "Detector characterisation" entry (file+headline "~/.org/GWs.org" "Detector characterisation")
         "* DetChar: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("gcpl" "General LIGO/Virgo task" entry (file+headline "~/.org/GWs.org" "LIGO/Virgo general")
         "* LVC: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
	
	
        ("gco" "Clock a GW ORGANISATION task")
	
        ("gcoe" "Email and calendar" entry (file+headline "~/.org/GWs.org" "Organisation")
         "* Org: email, chat, calendar\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t :immediate-finish t)
	
        ("gcoo" "Organisation" entry (file+headline "~/.org/GWs.org" "Organisation")
         "* Org: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("gcoc" "Colloquia" entry (file+headline "~/.org/GWs.org" "Colloquia")
         "* Coll: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("gcoC" "Conferences" entry (file+headline "~/.org/GWs.org" "Conferences")
         "* Conf: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("gcoi" "Illness" entry (file+headline "~/.org/GWs.org" "Illness")
         "* Ill: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("gcos" "Sundry Org task" entry (file+headline "~/.org/GWs.org" "Sundry Org")
         "* Etc: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
	
	
        ("gcs" "Clock a STUDENT SqUPERVISION task" entry (file+headline "~/.org/GWs.org" "Student supervision")
         "* Student: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
	
        ("gct" "Clock a TEACHING task")
        
        ("gct1" "Clock a Class1 task")
	
        ("gct1t" "Teaching" entry (file+headline "~/.org/GWs.org" "Class1 teaching")
         "* Class1: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
	("gct1d" "Development" entry (file+headline "~/.org/GWs.org" "Class1 development")
         "* Class1: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
	
        ("gcto" "Clock anOther teaching task" entry (file+headline "~/.org/GWs.org" "Teaching other")
         "* Teach: %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
	
	
	
        
        ;; Create GW todos:
        ("gt" "Add a GW todo")
	
	
        ("gtp" "Add a GW PROJECT todo")
	
        ("gtpp" "Pipeline" entry (file+headline "~/.org/GWs.org" "Pipeline")
         "* TODO Pline: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("gtpd" "Detector characterisation" entry (file+headline "~/.org/GWs.org" "Detector characterisation")
         "* TODO DetChar: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("gtpl" "General LIGO/Virgo task" entry (file+headline "~/.org/GWs.org" "LIGO/Virgo general")
         "* TODO LVC: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
	
        ("gto" "Add a GW ORGANISATION todo")
	
        ("gtoo" "Organisation" entry (file+headline "~/.org/GWs.org" "Organisation")
         "* TODO Org: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("gtoc" "Colloquia" entry (file+headline "~/.org/GWs.org" "Colloquia")
         "* TODO Coll: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("gtoC" "Conferences" entry (file+headline "~/.org/GWs.org" "Conferences")
         "* TODO Conf: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("gtos" "Sundry todo" entry (file+headline "~/.org/GWs.org" "Sundry")
         "* TODO Etc: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
        
	
	
        ("gts" "Add a STUDENT SUPERVISION todo" entry (file+headline "~/.org/GWs.org" "Student supervision")
         "* TODO Student: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
        ("gtt" "Add a TEACHING todo")
        
        ("gtt1" "Add an Class1 todo")
	
        ("gtt1t" "Teaching" entry (file+headline "~/.org/GWs.org" "Class1 teaching")
         "* TODO Class1: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("gtt1d" "Development" entry (file+headline "~/.org/GWs.org" "Class1 development")
         "* TODO Class1: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
        ("gtto" "Add anOther teaching todo" entry (file+headline "~/.org/GWs.org" "Teaching other")
         "* TODO Teach: %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
	
	
	
	
	
        ;; RU:
        ("r" "RU tasks")
	
        ("rc" "CLOCK a RU task" entry (file+headline "~/.org/RU.org" "RU")
         "* %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("rt" "Create a RU TODO" entry (file+headline "~/.org/RU.org" "RU")
         "* TODO %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
        
        ("ra" "Create a RU APPOINTMENT" entry (file+headline "~/.org/RU.org" "RU")
         "* TODO %i%?\n  %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
        
        ("rd" "Create a RU DEADLINE" entry (file+headline "~/.org/RU.org" "RU")
         "* TODO %i%?\nDEADLINE: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
        
	
	
        ;; Private:
        ("p" "Private tasks")
	
        ("pc" "CLOCK a Private task" entry (file+headline "~/.org/Priv.org" "Private")
         "* %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("pt" "Create a Private TODO" entry (file+headline "~/.org/Priv.org" "Private")
         "* TODO %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("pd" "Create a Private DEADLINE" entry (file+headline "~/.org/Priv.org" "Private")
         "* TODO %i%?\nDEADLINE: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("pa" "Create a Private APPOINTMENT" entry (file+headline "~/.org/Priv.org" "Private")
         "* TODO %i%?\n  %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
        
        ;; Sky:
        ("s" "Sky tasks")
        ("sc" "CLOCK a Sky task" entry (file+headline "~/.org/Sky.org" "Sky")
         "* %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("st" "Create a Sky TODO task" entry (file+headline "~/.org/Sky.org" "Sky")
         "* TODO %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("sd" "Create a Sky DEADLINE task" entry (file+headline "~/.org/Sky.org" "Sky")
         "* TODO %i%?\nDEADLINE: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
        
        ;; Hacking:
        ("h" "Hacking tasks")
	
        ("hc" "CLOCK a Hacking task" entry (file+headline "~/.org/Hack.org" "Hacking")
         "* %i%?\n%T\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n" :clock-in t :clock-keep t)
	
        ("ht" "Create a Hacking TODO" entry (file+headline "~/.org/Hack.org" "Hacking")
         "* TODO %i%?\nSCHEDULED: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
        ("hd" "Create a Hacking DEADLINE" entry (file+headline "~/.org/Hack.org" "Hacking")
         "* TODO %i%?\nDEADLINE: %t\n  :PROPERTIES:\n  :Created: %U\n  :Link: %a\n  :END:\n")
	
	
        
        ;; Ideas:
        ("i" "Idea" entry (file+headline "~/.org/Ideas.org" "Ideas")
         "* %?")
        
        ;; Calendar:
        ("c" "Calendar" entry (file+headline "~/.org/calendar.org" "Calendar events")
         "* %?  %t  :Cal:")
        
        ;; Holidays and birthdays:
        ("P" "Public holiday" entry (file+headline "~/.org/calendar.org" "Calendar events")
         "* %?  %t  :Cal:PubHol:")
	
	;; ;; Contacts:
        ;; ("C" "Add a Contact")
	;;  ;; "\n** %\\1 %\\2\n:PROPERTIES:\n:PREFIX:   \n:FIRST:    %^{First Name}\n:MIDDLE:   \n:LAST:     %^{Last Name}\n:SUFFIX:   \n:NICKNAME: \n:NOTE:     \n:BIRTHDAY: \n:TYPE:     \n:COMPANY:    \n:POSITION:   \n:LINE1:    \n:LINE2:    \n:STREET:   \n:CITY:     \n:POSTCODE: \n:PROVINCE: \n:COUNTRY:  \n:EMAIL:    %^{E-Mail}\n:PHONE:    \n:MOBILE:   \n:FAX:      \n:URL:      \n:ADDED:    %U\n:END:" :empty-lines-before 1 :empty-lines-after 1)
	;; ("Cr" "Add a RU contact" entry (file+headline mc-capture-file "RU")
	;;  "\n** %\\1 %\\2\n:PROPERTIES:\n:FIRST:    %^{First Name}\n:LAST:     %^{Last Name}\n:TYPE:     RU\n:COMPANY:    \n:EMAIL:    %^{E-Mail}\n:PHONE:    \n:ADDED:    %U\n:END:" :empty-lines-before 1 :empty-lines-after 1)
	;; ("Cp" "Add a Private contact" entry (file+headline mc-capture-file "Private")
	;;  "\n** %\\1 %\\2\n:PROPERTIES:\n:FIRST:    %^{First Name}\n:LAST:     %^{Last Name}\n:TYPE:     Private\n:COMPANY:    \n:EMAIL:    %^{E-Mail}\n:PHONE:    \n:ADDED:    %U\n:END:" :empty-lines-before 1 :empty-lines-after 1)
	
        )
      
      
      )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  TAGS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Org tags with fast selection keys - http://doc.norang.ca/org-mode.html#Tags - C-c C-q in org mode, / <letter> in Agenda
;; Tags in group are mutually exclusive
(setq org-tag-alist (quote (
;;                          (:startgroup) ;; seems to mess things up
;;                          (:endgroup)
                            ("BA" .        ?b)
                            ("Priv" .      ?p)
                            ("Sky" .       ?s)
                            ("AstroC" .    ?a)
                            ("Hack" .      ?h)
                            ("GWs" .       ?g)
                            ("RU" .        ?r)
                            ("Teach".      ?t)
                            ("Git".        ?G)
                            ("HistAstro"     )
                            ("Cal"           )
                            ("PubHol" .    ?P)
                            ("Birth" .     ?B)
                            ("Wed"   .     ?w)
                            ("export" .    ?E)
                            ("noexport" .  ?N)
                            )))

;; Org tag colours: bright for main tags, grey for secondary:
(setq org-tag-faces
      (quote (
              ("Priv"       :foreground "yellow"  :weight bold)
              ("GWs"        :foreground "red"     :weight bold)
              ("RU"         :foreground "magenta" :weight bold)
              ("Hack"       :foreground "green"   :weight bold)
              ("Sky"        :foreground "cyan"    :weight bold)
              
              ("BA"         :foreground "grey")
              ("Astrocal"   :foreground "grey")
              ("Teach"      :foreground "grey")
              ("Git"        :foreground "grey")
              ("HistAstro"  :foreground "grey")
              
              ("Cal"        :foreground "grey")
              ("PubHol"     :foreground "grey")
              ("Birth"      :foreground "grey")
              ("Wed"        :foreground "grey")
	      
              ("export"     :foreground "white" :background "red" :weight bold)
              ("noexport"   :foreground "white" :background "red" :weight bold)
              )))

;; Allow setting single tags without the menu - http://doc.norang.ca/org-mode.html#Tags
(setq org-fast-tag-selection-single-key (quote expert))

;; For tag searches ignore tasks with scheduled and deadline dates - http://doc.norang.ca/org-mode.html#Tags
(setq org-agenda-tags-todo-honor-ignore-options t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  EXPORT  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LaTeX export:
;; Use A4 with narrow margins for LaTeX export: (https://emacs.stackexchange.com/a/21825/17538)
(setq org-latex-packages-alist '(
				 ("paper=a4paper,margin=2cm" "geometry" nil)
				 ("" "parskip" nil)
				 )
      )

;; Remove boxes around links (in ToC) in LaTeX/PDF export.  Use blue/black text instead.
;; Smuggle in an \author{} command, so that it is always the same
;;   (and does not depend on my current mu4e context (e.g. to become h.w.c))
(setq org-latex-hyperref-template
      "\\hypersetup{
         colorlinks = true,
         linkcolor = black,
         citecolor = black,
         urlcolor = black,
         pdfauthor={Marc van der Sluys},
         pdftitle={%t},
         pdfkeywords={%k},
         pdfsubject={%d},
         pdfcreator={%c}, 
         pdflang={%L}
      }
      \\author{Marc van der Sluys}
      "
      )

(setq user-full-name "Marc van der Sluys")  ;; Default - can be changed when switching mu4e profiles!

;; Add LaTeX Beamer to export options
;; (https://orgcandman.github.io/blog/2016/01/:dat/Writing-emacs-presentations-with-beamer.html):
(require 'ox-beamer)
(setq org-export-allow-bind-keywords t)                     ;; Rebind variables in our .org files, required to adjust variables like: org-latex-title-command, needed for some custom themes.

(setq org-latex-listings 'minted)                           ;; Allow for exporting #+begin_src/#+end_src blocks with syntax highlighting.
(add-to-list 'org-latex-packages-alist '("" "minted" nil))  ;; Allow for exporting #+begin_src/#+end_src blocks with syntax highlighting.
;; (setq org-latex-minted-options '(("cachedir" ".minted-<jobname>")))  ;; Doesn't work - need package options (manual Sect.5.1), not environment options (Sect.5.3) - Create .minted-<jobname> as cache directory (default: _minted-<jobname>)
;; (setq LaTeX-minted-package-options
;;      '("chapter" "cache" "cachedir" "finalizecache" "frozencache" "draft" "final" "kpsewhich" "langlinenos" "newfloat" "outputdir" "section"))
;; (add-to-list 'LaTeX-minted-package-options "cachedir=.minted-<jobname>")  ;; Doesn't work - not used by orgmode?  -  Create .minted-<jobname> as cache directory (default: _minted-<jobname>)

;; Add conf -> aconf to default minted language mappings:
;;   (#+begin_src conf is supported by orgmode but not LaTeX/minted, aconf not by orgmode but by LaTeX/minted)
(add-to-list 'org-latex-minted-langs '(conf "aconf"))

;; Break long code lines in LaTeX/minted/pdf:
(setq org-latex-minted-options '(
				 ("breaklines" "true")
                                 ("breakanywhere" "true")
				 ))

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))  ;; This doesn't seem to affect normal LaTeX export



;; LaTeX fragments in emacs orgmode:
;; - https://orgmode.org/manual/Previewing-LaTeX-fragments.html
;; - Default:  (:foreground default :background default :scale 1.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))
;; - My preference: scale 1.0 -> 1.2
(setq org-format-latex-options '(:foreground default
					     :background default
					     :scale 1.2
					     :html-foreground "Black"
					     :html-background "Transparent"
					     :html-scale 1.0
					     :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")
					     )
      )
;; org-format-latex-header

;; Add orgmode export options:
;; Installed by default (see https://orgmode.org/manual/Exporting.html and /usr/share/emacs/site-lisp/org-mode/ox-*.el)
;;   (of these, enabled by default are ASCII, HTML, iCalendar, LaTeX, and ODT)
(require 'ox-org)        ;; Orgmode
(require 'ox-md)         ;; Markdown
;; (require 'ox-man)        ;; Man page
;; (require 'ox-texinfo)    ;; Texinfo page

;; Manually installed:
(require 'ox-gfm)        ;; GitHub-flavoured Markdown
(require 'ox-rst)        ;; ReStructured Text
(require 'ox-slack)      ;; Slack
;; (require 'ox-mediawiki)  ;; Mediawiki - conflicts with default Markdown
;; (require 'ox-ssh)        ;; SSH config
(require 'ox-jira)       ;; Jira
(require 'ox-jekyll-md)  ;; Jekyll (e.g. GitHub pages)
;; (require 'ox-pandoc)     ;; Pandoc - not installed (requires Haskell)

;; Set a directory for exports (https://stackoverflow.com/a/47850858/1386750):
;;   While this seems to work to export to orgmode, html and LaTeX, exporting to LaTeX and thence pdf does not
;;   work because the pdflatex compilation fails.
;; (defun org-export-output-file-name-modified (orig-fun extension &optional subtreep org-export-dir)
;;   (unless org-export-dir
;;     (setq org-export-dir "~/.orgmode-exports")
;;     (unless (file-directory-p org-export-dir)
;;       (make-directory org-export-dir)))
;;   (apply orig-fun extension subtreep org-export-dir nil))
;; (advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)
;; (advice-remove 'org-export-output-file-name #'org-export-output-file-name-modified)  ;; Remove the advice
;; (setq org-export-publishing-directory "~/.orgmode-exports")  ;; Doesn't do anything.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  PUBLISH  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Publication projects:
;; Issue: links -> .org files are translated to -> .html, but links to .jot files are not!
(setq org-publish-project-alist
      '(
	("GWs"
         :base-directory "~/.jotter/"
	 :include ("gw-astronomy.jot" "gw-clusters.jot" "gw-detections.jot" "gw-lisa.jot" "gw-pipelines.jot" "gw-proposals.jot" "gw-telecons.jot")
	 :publishing-function org-html-publish-to-html
         :publishing-directory "~/temp/orgmode-test"
         :section-numbers t
         :with-toc t
	 :auto-sitemap t
         :html-head "<link rel=\"stylesheet\"
                    href=\"style.css\"
                    type=\"text/css\"/>"
	 )
	))

(setq org-publish-use-timestamps-flag nil)  ;; Do NOT use timestamps -> (re)publish ALL files, even if unmodified.  Issue: if an html file is removed and the source file is unchanged, it is not republished!




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  AGENDA ALERTS in KDE/Plasma  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Show system alerts for deadlines:
;;(require 'org-alert)
;;(org-alert-enable)



;; KDE/Plasma Kdialog appointment reminders:
;; https://lists.gnu.org/archive/html/emacs-orgmode/2009-04/msg00711.html
;; Alternatively, try: https://lists.gnu.org/archive/html/emacs-orgmode/2009-04/msg00753.html

;; Get appointments for today:
(defun my-org-agenda-to-appt ()
       (interactive)
       (setq appt-time-msg-list nil)
       (let ((org-deadline-warning-days 0))    ;; Local var.  Will be automatic in org 5.23? - still seems necessary.
         (org-agenda-to-appt))
       )

(my-org-agenda-to-appt)
(appt-activate t)
(run-at-time "00:01" 900 'my-org-agenda-to-appt)  ;; TIME: One minute after midnight (was 24:01). REPEAT: 900(s) = 15min.

;; 5-minute warnings starting 15 minutes in advance:
(setq appt-message-warning-time '15)  ;; Start warning 15 min in advance
(setq appt-display-interval '5)       ;; Warn every 5 min, i.e., 15, 10, 5 and 0 minutes in advance
(setq appt-display-mode-line nil)     ;; Suppress "App't in xx min" in modeline - https://www.gnu.org/software/emacs/manual/html_node/emacs/Appointments.html

;; Update appt each time agenda opened:
(add-hook 'org-finalize-agenda-hook 'my-org-agenda-to-appt)  ;; This doesn't seem to work (or I don't understand how to open an agenda)

;; Setup zenify, we tell appt to use window, and replace default function:
(setq appt-display-format 'window)
(setq appt-disp-window-function (function my-appt-disp-window))

(defun my-appt-disp-window (min-to-app new-time msg)
       (save-window-excursion (async-shell-command (concat
      "$HOME/usr/bin/emacs_agenda_notify " min-to-app " " new-time " '" msg "'") nil nil)))  ;; Note: possible brackets in msg, hence '.  Note that time is inside 'Time Message' -> 5 args!
     ;; "$HOME/usr/bin/emacs_agenda_notify " min-to-app " " new-time " " msg) nil nil)))
;;     "/usr/bin/kdialog --msgbox '" msg "' &") nil nil)))

;; Prevent emacs popups "A command is running in the default buffer. Use a new buffer? (y or n)" due to the
;; function above colliding with some other function - https://emacs.stackexchange.com/a/41154/17538
(setq async-shell-command-buffer 'new-buffer)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  (ACTIVE) CODE BLOCKS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Active Babel languages for code blocks
;; https://orgmode.org/worg/org-contrib/babel/languages.html#configure
;; ls /usr/share/emacs/site-lisp/org-mode/ob-*.el
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (awk . t)
   (C . t)
   (calc . t)
   (ditaa . t)
   (fortran . t)
   (gnuplot . t)
   (latex . t)
   (octave . t)
   (org . t)
   (perl . t)
   (python . t)
   (ipython . t)
   (R . t)
   (sed . t)
   (shell . t)
   )
 )

;; Fix an incompatibility between the ob-async and ob-ipython packages
(setq ob-async-no-async-languages-alist '("ipython"))

;; Don't prompt before running code in org for some languages:
;; (setq org-confirm-babel-evaluate nil)  ;; DANGEROUS?  Probably for bash, not so much for (most) Python, Ditaa
;; Assume that all Python, awk and ditaa code is safe:
(defun my-org-confirm-babel-evaluate (lang body)
  (not (or
	(string= lang "python")
	(string= lang "awk")
	(string= lang "ditaa")
	) ) )
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)


(setq org-ditaa-jar-path "/usr/share/ditaa/lib/ditaa.jar")  ;; Default: /usr/share/emacs/site-lisp/contrib/scripts/ditaa.jar

(setq org-catch-invisible-edits 'show)  ;; If editing in invisible region, show the region.



