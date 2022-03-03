- [Key strokes](#orgfb8e5e7)
- [To do <code>[1/3]</code>](#org1810918)
  - [What to use Org mode for <code>[8/8]</code>](#orgc497c0f)
  - [Add file with simple examples <code>[5/6]</code>](#org1117355)
    - [Text style](#org4ccebd8)
    - [Task lists and headings <code>[33%]</code>](#org566302c)
    - [Links](#org9bebac0)
    - [Table/spreadsheet](#orgf093d68)
  - [More advanced examples](#orgebfa1bb)
    - [Equations](#orgf2723bd)
    - [Code](#org2da97b1)



<a id="orgfb8e5e7"></a>

# Key strokes

1.  I use lower-case letter `a` for the `A`-key.
2.  I use upper-case letter `C-` for the `Ctrl` key, `M-` for the Alt (meta) key and `S-` for the `Shift` key.
    -   hence `C-c` is `Ctrl-C`, `C-c C-c` is twice that and `C-M-a` means simultaneously press `Ctrl`, `Alt` and `A`.
    -   note that you can type e.g. `C-c C-x C-l` without releasing the `Ctrl` key (i.e., keep `Ctrl` pressed while typing `c x l`).
3.  `ENTER`, `TAB` and `ESC` are the keys you'd expect.
4.  Got confused? Press `ESC ESC ESC` and you should be good to start typing again.
5.  See also <http://pub.vandersluys.nl/download/GettingStartedWithEmacs.pdf> (in particular section 1.2 and the start of 1.3)


<a id="org1810918"></a>

# TODO To do <code>[1/3]</code>


<a id="orgc497c0f"></a>

## DONE What to use Org mode for <code>[8/8]</code>

1.  [X] note taking, personal wiki, writing documentation
2.  [X] the brainstorm phase of a project, paper:
    1.  Overview in Org mode
    2.  then export to LaTeX to finish
3.  [X] clock tasks, projects
4.  [X] agenda, planning, task lists (TODO/PROGRESS/DONE), issues (OPEN/ASSIGNED/CLOSED), idea lists, &#x2026;
5.  [X] (internal) links
6.  [X] tables, simple spreadsheets
7.  [X] export, publish: plain text (ASCII, UTF-8), html, md, LaTeX/PDF (+Beamer!), odt, reST, &#x2026;
8.  [X] equations, code


<a id="org1117355"></a>

## PROGRESS Add file with simple examples <code>[5/6]</code>


<a id="org4ccebd8"></a>

### DONE Text style

-   **bold**
-   *italics*
-   <span class="underline">underlined</span>
-   ~~strike through~~
-   `code` or `verbatim`


<a id="org566302c"></a>

### DONE Task lists and headings <code>[33%]</code>

-   [X] see [2](#org1810918)
-   [X] indent:
    -   put the cursor on an item (e.g. in this list) and press `Alt-arrow right/left`
    -   same for headers
-   [ ] drag:
    -   put the cursor on an item and press `Alt-arrow up/down`
    -   up/down swaps items (with the same indentation and if possible)
    -   the same for headers (of the same level)
-   [ ] change list symbols:
    -   put the cursor on an item and press `Shift right/left`
    -   symbols change between `+/-/*/1./1)` (`*` if possible)
-   [X] (de)select item (radio button):
    -   put the cursor on the item and press `C-c C-c`
    -   the number or percentage in the parent header (created by typing `[/]` or `[%]`) changes as well
-   [ ] change TODO:
    -   put the cursor on a header and press `Shift right/left`
    -   if all subheaders are DONE, the parent header changes from TODO to DONE as well
-   [ ] new item in a list:
    -   `Alt-ENTER`
-   [ ] new header in a document:
    -   `Ctrl-ENTER`
-   [ ] Create new list
    1.  Enumerated:
        1.  type `1.` or `1)` followed by a space and the description
        2.  press `Alt-ENTER` for the next item (counts automatically)
    2.  Bullets (unnumbered):
        1.  type a `+`, `-` or (if subitem) `*` followed by a space and the description
        2.  press `Alt-ENTER` for the next item with the same symbol
    3.  Definition:
        -   **Definition:** a definition is an **unnumbered** item with a keyword, followed by a double colon (`::`) and the definition.
        -   `Alt-ENTER` asks for the next definition with the same symbol
    4.  Check box/Radio button:
        1.  type an item symbol or number, followed by a space, `[ ]`, another space and the description
        2.  the `[ ]` lights up to show that the check box is active
        3.  `Alt-ENTER` produces a new item, but **no** empty check box (bug?)
        4.  `C-c C-c` on the line toggles between `[ ]` and `[X]`


<a id="org9bebac0"></a>

### DONE Links

-   Internal link: see [2](#org1810918)
-   External link: <https://github.com/MarcvdSluys/>
-   External link with description: [My GitHub page](https://github.com/MarcvdSluys/)


<a id="orgf093d68"></a>

### DONE Table/spreadsheet

1.  type `|- TAB` for a horizontal line
2.  type `x|x^2|x^3 TAB` in the new line for the header
3.  type `-` right against the `|` for another line
4.  in the left column, type `1 ENTER 2 ENTER` etc.
5.  under x<sup>2</sup>, type `=$1**2 TAB`. `$1` represents column 1.
6.  under x<sup>3</sup>, type `=$1**3 TAB`
7.  go to the line with `TBLFM` (table formula) under the table and press `C-c C-c`

| x | x<sup>2</sup> | x<sup>3</sup> |
| 1 | 1             | 1             |
| 2 | 4             | 8             |
| 3 | 9             | 27            |
| 4 | 16            | 64            |
| 5 | 25            | 125           |


<a id="orgebfa1bb"></a>

## PROGRESS More advanced examples


<a id="orgf2723bd"></a>

### DONE Equations

LaTeX must be installed to display formatted equations in emacs.

1.  Lazy symbols outside equations using inline \LaTeX, like &int;, &infin; and &nabla;<sub>&phi;</sub> will show up nicely in \LaTeX.

2.  inline: type `$\int_0^\infty \frac{\sin x}{x} dx$` and press `C-c C-x C-l` to display in emacs. This is a nice equation $\int_0^\infty \frac{\sin x}{x} dx$, but complicated.

3.  between the lines: type `\[\int_0^\infty \frac{\sin x}{x} dx\]` and press `C-c C-x C-l` to display in emacs. $$\int_0^\infty \frac{\sin x}{x} dx$$


<a id="org2da97b1"></a>

### ACTIVE Code

-   Elisp always works?

1.  Elisp (emacs lisp script)

    1.  press `C-c C-, s` for a `#+begin/end_src`-block and add `elisp` yourself
    2.  type some code and return a value (see example below)
    3.  in the code block, press `C-c C-c` and answer the question in the minibuffer below with `yes ENTER`
    4.  the result appears in a `RESULTS` block under the code, a bit like in a Jupyter notebook.
    
    ```elisp
    (concat  (emacs-version)
    	 "\nOrgmode " (org-version))  
    ```
    
        GNU Emacs 27.2 (build 1, x86_64-pc-linux-gnu, GTK+ Version 3.24.29, cairo version 1.16.0)
         of 2021-10-01
        Orgmode N/A

2.  Bash

    Bash must be installed and Babel must be activated for Bash&#x2026;
    
    ```bash
    echo "My home directory is $HOME"
    ```
    
        My home directory is /home/sluys

3.  Python

    Python must be installed and Babel must be activated for Python&#x2026;
    
    1.  press `C-c C-, s` for a `#+begin/end_src`-block and type `python` yourself
    2.  type some code and return a value
    3.  In the code block, press `C-c C-c` and answer the question in the minibuffer below with `yes ENTER`
    4.  the return value appears below the code in a `RESULTS` block
    
    ```python
    x=3
    y=5
    z=x*y
    return z
    ```
    
        15
    
    ```python
    import numpy as np
    import matplotlib.pyplot as plt
    x = np.linspace(-15,15)
    plt.plot(x, np.sin(x)/x)
    plt.savefig('Orgmode-example.png')
    return 'Orgmode-example.png'  # Return filename to Org mode
    ```
    
    ![img](Orgmode-example.png)

4.  Python + Bash

    -   Nicked from <https://jherrlin.github.io/posts/emacs-orgmode-source-code-blocks/>
    
    Print a list with a selection of files in the current directory in bash. I will export both (`both`) the code and the result (to e.g. `.md` or `.pdf`). Also, I will give the code a name (`ls`) so that the output can be used later:
    
    ```bash
    ls -lb Orgmode-example.*
    ```
    
        -rw-r--r-- 1 sluys sluys   9431 Dec 16 20:45 Orgmode-example.md
        -rw-r--r-- 1 sluys sluys  37346 Dec 16 20:40 Orgmode-example.odt
        -rw-r--r-- 1 sluys sluys   7945 Dec 16 20:48 Orgmode-example.org
        -rw-r--r-- 1 sluys sluys 321341 Dec 16 20:49 Orgmode-example.pdf
        -rw-r--r-- 1 sluys sluys  23293 Dec 16 20:49 Orgmode-example.png
        -rw-r--r-- 1 sluys sluys   9647 Dec 16 20:41 Orgmode-example.rst
        -rw-r--r-- 1 sluys sluys  12381 Dec 16 20:49 Orgmode-example.tex
        -rw-r--r-- 1 sluys sluys   9178 Dec 16 20:41 Orgmode-example.txt
    
    Use `awk` to take the file names and sizes from `ls` and create a table:
    
    ```awk
    BEGIN { OFS="|" }; { print $5, $9}
    ```
    
    | 9431   | Orgmode<sub>example.md</sub>  |
    | 37346  | Orgmode<sub>example.odt</sub> |
    | 7945   | Orgmode<sub>example.org</sub> |
    | 321341 | Orgmode<sub>example.pdf</sub> |
    | 23293  | Orgmode<sub>example.png</sub> |
    | 9647   | Orgmode<sub>example.rst</sub> |
    | 12381  | Orgmode<sub>example.tex</sub> |
    | 9178   | Orgmode<sub>example.txt</sub> |
    
    Use Python to o.a. find the smallest and largest file in the table from `awk`:
    
    ```python
    print(table[0])                     # First row of the table as read
    print("Number of files: %i"         % len(table))
    print("Smallest file:   (%i b) %s"  % tuple(min(table)))
    print("Largest file:    (%i b) %s"  % tuple(max(table)))
    print("Total size:      %0.3f kb"   % (sum([x for x,y in table]) / 1000))
    ```
    
        [9431, 'Orgmode-example.md']
        Number of files: 8
        Smallest file:   (7945 b) Orgmode-example.org
        Largest file:    (321341 b) Orgmode-example.pdf
        Total size:      430.562 kb
