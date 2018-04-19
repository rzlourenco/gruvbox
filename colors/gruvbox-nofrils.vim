" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='gruvbox-nofrils'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:gruvbox_bold')
  let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
if !exists('g:gruvbox_undercurl')
  let g:gruvbox_undercurl=1
endif
if !exists('g:gruvbox_underline')
  let g:gruvbox_underline=1
endif
if !exists('g:gruvbox_inverse')
  let g:gruvbox_inverse=1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_improved_strings')
  let g:gruvbox_improved_strings=0
endif

if !exists('g:gruvbox_improved_warnings')
  let g:gruvbox_improved_warnings=0
endif

if !exists('g:gruvbox_termcolors')
  let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
  let g:gruvbox_invert_indent_guides=0
endif

if exists('g:gruvbox_contrast')
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  let g:gruvbox_contrast_dark='medium'
endif

if !exists('g:gruvbox_contrast_light')
  let g:gruvbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = ''
let s:italic = ''

let s:underline = 'underline,'
if g:gruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:gruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:gruvbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:gruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:gruvbox_number_column')
  let s:number_column = get(s:gb, g:gruvbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    let s:sign_column = get(s:gb, g:gruvbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:gruvbox_color_column')
  let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:gruvbox_vert_split')
  let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('GruvboxFg0', s:fg0)
call s:HL('GruvboxFg1', s:fg1)
call s:HL('GruvboxFg2', s:fg2)
call s:HL('GruvboxFg3', s:fg3)
call s:HL('GruvboxFg4', s:fg4)
call s:HL('GruvboxGray', s:gray)
call s:HL('GruvboxBg0', s:bg0)
call s:HL('GruvboxBg1', s:bg1)
call s:HL('GruvboxBg2', s:bg2)
call s:HL('GruvboxBg3', s:bg3)
call s:HL('GruvboxBg4', s:bg4)

call s:HL('GruvboxRed', s:red)
call s:HL('GruvboxRedBold', s:red, s:none, s:bold)
call s:HL('GruvboxGreen', s:green)
call s:HL('GruvboxGreenBold', s:green, s:none, s:bold)
call s:HL('GruvboxYellow', s:yellow)
call s:HL('GruvboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('GruvboxBlue', s:blue)
call s:HL('GruvboxBlueBold', s:blue, s:none, s:bold)
call s:HL('GruvboxPurple', s:purple)
call s:HL('GruvboxPurpleBold', s:purple, s:none, s:bold)
call s:HL('GruvboxAqua', s:aqua)
call s:HL('GruvboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('GruvboxOrange', s:orange)
call s:HL('GruvboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('GruvboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('GruvboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('GruvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('GruvboxBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('GruvboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('GruvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory GruvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
" Warning messages
hi! link WarningMsg GruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

hi! link Special Normal

hi! link Comment GruvboxGray
hi! link Todo GruvboxGreen
hi! link Error GruvboxRed

" Generic statement
hi! link Statement Normal
" if, then, else, endif, swicth, etc.
hi! link Conditional Normal
" for, do, while, etc.
hi! link Repeat Normal
" case, default, etc.
hi! link Label Normal
" try, catch, throw
hi! link Exception Normal
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword Normal

" Variable name
hi! link Identifier Normal
" Function name
hi! link Function Normal

" Generic preprocessor
hi! link PreProc Normal
" Preprocessor #include
hi! link Include Normal
" Preprocessor #define
hi! link Define Normal
" Same as Define
hi! link Macro Normal
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit Normal

" Generic constant
hi! link Constant Normal
" Character constant: 'c', '/n'
hi! link Character Normal
" String constant: "this is a string"
hi! link String Normal
" Boolean constant: TRUE, false
hi! link Boolean Normal
" Number constant: 234, 0xff
hi! link Number Normal
" Floating point constant: 2.3e10
hi! link Float Normal

" Generic type
hi! link Type Normal
" static, register, volatile, etc
hi! link StorageClass Normal
" struct, union, enum, etc.
hi! link Structure Normal
" typedef
hi! link Typedef Normal

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd GruvboxGreenSign
hi! link GitGutterChange GruvboxAquaSign
hi! link GitGutterDelete GruvboxRedSign
hi! link GitGutterChangeDelete GruvboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange GruvboxAquaSign
hi! link SignifySignDelete GruvboxRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   GruvboxBlueSign
hi! link SignatureMarkerText GruvboxPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl GruvboxBlueSign
hi! link ShowMarksHLu GruvboxBlueSign
hi! link ShowMarksHLo GruvboxBlueSign
hi! link ShowMarksHLm GruvboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxBlue
hi! link CtrlPLinePre GruvboxBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket GruvboxFg3
hi! link StartifyFile GruvboxFg1
hi! link StartifyNumber GruvboxBlue
hi! link StartifyPath GruvboxGray
hi! link StartifySlash GruvboxGray
hi! link StartifySection GruvboxYellow
hi! link StartifySpecial GruvboxBg2
hi! link StartifyHeader GruvboxOrange
hi! link StartifyFooter GruvboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign GruvboxRedSign
hi! link ALEWarningSign GruvboxYellowSign
hi! link ALEInfoSign GruvboxBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail GruvboxAqua
hi! link DirvishArg GruvboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir GruvboxAqua
hi! link netrwClassify GruvboxAqua
hi! link netrwLink GruvboxGray
hi! link netrwSymLink GruvboxFg1
hi! link netrwExe GruvboxYellow
hi! link netrwComment GruvboxGray
hi! link netrwList GruvboxBlue
hi! link netrwHelpCmd GruvboxAqua
hi! link netrwCmdSep GruvboxFg3
hi! link netrwVersion GruvboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

" }}}
" Html: {{{

hi! link htmlTag Normal
hi! link htmlEndTag Normal

hi! link htmlTagName Normal
hi! link htmlArg Normal

hi! link htmlScriptTag Normal
hi! link htmlTagN Normal
hi! link htmlSpecialTagName Normal

hi! link htmlLink Normal

hi! link htmlSpecialChar Normal

hi! link htmlBold Normal
hi! link htmlBoldUnderline Normal
hi! link htmlBoldItalic Normal
hi! link htmlBoldUnderlineItalic Normal

hi! link htmlUnderline Normal
hi! link htmlUnderlineItalic Normal
hi! link htmlItalic Normal

" }}}
" Xml: {{{

hi! link xmlTag Normal
hi! link xmlEndTag Normal
hi! link xmlTagName Normal
hi! link xmlEqual Normal
hi! link docbkKeyword Normal

hi! link xmlDocTypeDecl Normal
hi! link xmlDocTypeKeyword Normal
hi! link xmlCdataStart Normal
hi! link xmlCdataCdata Normal
hi! link dtdFunction Normal
hi! link dtdTagName Normal

hi! link xmlAttrib Normal
hi! link xmlProcessingDelim Normal
hi! link dtdParamEntityPunct Normal
hi! link dtdParamEntityDPunct Normal
hi! link xmlAttribPunct Normal

hi! link xmlEntity Normal
hi! link xmlEntityPunct Normal
" }}}
" Vim: {{{

hi! link vimCommentTitle Normal

hi! link vimNotation Normal
hi! link vimBracket Normal
hi! link vimMapModKey Normal
hi! link vimFuncSID Normal
hi! link vimSetSep Normal
hi! link vimSep Normal
hi! link vimContinue Normal

" }}}
" Clojure: {{{

hi! link clojureKeyword Normal
hi! link clojureCond Normal
hi! link clojureSpecial Normal
hi! link clojureDefine Normal

hi! link clojureFunc Normal
hi! link clojureRepeat Normal
hi! link clojureCharacter Normal
hi! link clojureStringEscape Normal
hi! link clojureException Normal

hi! link clojureRegexp Normal
hi! link clojureRegexpEscape Normal
hi! link clojureRegexpCharClass Normal
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen Normal
hi! link clojureAnonArg Normal
hi! link clojureVariable Normal
hi! link clojureMacro Normal

hi! link clojureMeta Normal
hi! link clojureDeref Normal
hi! link clojureQuote Normal
hi! link clojureUnquote Normal

" }}}
" C: {{{

hi! link cOperator Normal
hi! link cStructure Normal

" }}}
" Python: {{{

hi! link pythonBuiltin Normal
hi! link pythonBuiltinObj Normal
hi! link pythonBuiltinFunc Normal
hi! link pythonFunction Normal
hi! link pythonDecorator Normal
hi! link pythonInclude Normal
hi! link pythonImport Normal
hi! link pythonRun Normal
hi! link pythonCoding Normal
hi! link pythonOperator Normal
hi! link pythonException Normal
hi! link pythonExceptions Normal
hi! link pythonBoolean Normal
hi! link pythonDot Normal
hi! link pythonConditional Normal
hi! link pythonRepeat Normal
hi! link pythonDottedName Normal

" }}}
" CSS: {{{

hi! link cssBraces Normal
hi! link cssFunctionName Normal
hi! link cssIdentifier Normal
hi! link cssClassName Normal
hi! link cssColor Normal
hi! link cssSelectorOp Normal
hi! link cssSelectorOp2 Normal
hi! link cssImportant Normal
hi! link cssVendor Normal

hi! link cssTextProp Normal
hi! link cssAnimationProp Normal
hi! link cssUIProp Normal
hi! link cssTransformProp Normal
hi! link cssTransitionProp Normal
hi! link cssPrintProp Normal
hi! link cssPositioningProp Normal
hi! link cssBoxProp Normal
hi! link cssFontDescriptorProp Normal
hi! link cssFlexibleBoxProp Normal
hi! link cssBorderOutlineProp Normal
hi! link cssBackgroundProp Normal
hi! link cssMarginProp Normal
hi! link cssListProp Normal
hi! link cssTableProp Normal
hi! link cssFontProp Normal
hi! link cssPaddingProp Normal
hi! link cssDimensionProp Normal
hi! link cssRenderProp Normal
hi! link cssColorProp Normal
hi! link cssGeneratedContentProp Normal

" }}}
" JavaScript: {{{

hi! link javaScriptBraces Normal
hi! link javaScriptFunction Normal
hi! link javaScriptIdentifier Normal
hi! link javaScriptMember Normal
hi! link javaScriptNumber Normal
hi! link javaScriptNull Normal
hi! link javaScriptParens Normal

" }}}
" YAJS: {{{

hi! link javascriptImport Normal
hi! link javascriptExport Normal
hi! link javascriptClassKeyword Normal
hi! link javascriptClassExtends Normal
hi! link javascriptDefault Normal

hi! link javascriptClassName Normal
hi! link javascriptClassSuperName Normal
hi! link javascriptGlobal Normal

hi! link javascriptEndColons Normal
hi! link javascriptFuncArg Normal
hi! link javascriptGlobalMethod Normal
hi! link javascriptNodeGlobal Normal
hi! link javascriptBOMWindowProp Normal
hi! link javascriptArrayMethod Normal
hi! link javascriptArrayStaticMethod Normal
hi! link javascriptCacheMethod Normal
hi! link javascriptDateMethod Normal
hi! link javascriptMathStaticMethod Normal

" hi! link Normal GruvboxFg1
hi! link javascriptURLUtilsProp Normal
hi! link javascriptBOMNavigatorProp Normal
hi! link javascriptDOMDocMethod Normal
hi! link javascriptDOMDocProp Normal
hi! link javascriptBOMLocationMethod Normal
hi! link javascriptBOMWindowMethod Normal
hi! link javascriptStringMethod Normal

hi! link javascriptVariable Normal
" hi! link javascriptVariable GruvboxRed
" hi! link javascriptIdentifier GruvboxOrange
" hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptIdentifier Normal
hi! link javascriptClassSuper Normal

" hi! link javascriptFuncKeyword GruvboxOrange
" hi! link javascriptAsyncFunc GruvboxOrange
hi! link javascriptFuncKeyword Normal
hi! link javascriptAsyncFunc Normal
hi! link javascriptClassStatic Normal

hi! link javascriptOperator Normal
hi! link javascriptForOperator Normal
hi! link javascriptYield Normal
hi! link javascriptExceptions Normal
hi! link javascriptMessage Normal

hi! link javascriptTemplateSB Normal
hi! link javascriptTemplateSubstitution Normal

" hi! link javascriptLabel GruvboxBlue
" hi! link javascriptObjectLabel GruvboxBlue
" hi! link javascriptPropertyName GruvboxBlue
hi! link javascriptLabel Normal
hi! link javascriptObjectLabel Normal
hi! link javascriptPropertyName Normal

hi! link javascriptLogicSymbols Normal
hi! link javascriptArrowFunc Normal

hi! link javascriptDocParamName Normal
hi! link javascriptDocTags Normal
hi! link javascriptDocNotation Normal
hi! link javascriptDocParamType Normal
hi! link javascriptDocNamedParamType Normal

hi! link javascriptBrackets Normal
hi! link javascriptDOMElemAttrs Normal
hi! link javascriptDOMEventMethod Normal
hi! link javascriptDOMNodeMethod Normal
hi! link javascriptDOMStorageMethod Normal
hi! link javascriptHeadersMethod Normal

hi! link javascriptAsyncFuncKeyword Normal
hi! link javascriptAwaitFuncKeyword Normal

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword Normal
hi! link jsExtendsKeyword Normal
hi! link jsExportDefault Normal
hi! link jsTemplateBraces Normal
hi! link jsGlobalNodeObjects Normal
hi! link jsGlobalObjects Normal
hi! link jsFunction Normal
hi! link jsFuncParens Normal
hi! link jsParens Normal
hi! link jsNull Normal
hi! link jsUndefined Normal
hi! link jsClassDefinition Normal

" }}}
" TypeScript: {{{

hi! link typeScriptReserved Normal
hi! link typeScriptLabel Normal
hi! link typeScriptFuncKeyword Normal
hi! link typeScriptIdentifier Normal
hi! link typeScriptBraces Normal
hi! link typeScriptEndColons Normal
hi! link typeScriptDOMObjects Normal
hi! link typeScriptAjaxMethods Normal
hi! link typeScriptLogicSymbols Normal
hi! link typeScriptDocSeeTag Normal
hi! link typeScriptDocParam Normal
hi! link typeScriptDocTags Normal
hi! link typeScriptGlobalObjects Normal
hi! link typeScriptParens Normal
hi! link typeScriptOpSymbols Normal
hi! link typeScriptHtmlElemProperties Normal
hi! link typeScriptNull Normal
hi! link typeScriptInterpolationDelimiter Normal

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword Normal
hi! link purescriptModuleName Normal
hi! link purescriptWhere Normal
hi! link purescriptDelimiter Normal
hi! link purescriptType Normal
hi! link purescriptImportKeyword Normal
hi! link purescriptHidingKeyword Normal
hi! link purescriptAsKeyword Normal
hi! link purescriptStructure Normal
hi! link purescriptOperator Normal

hi! link purescriptTypeVar Normal
hi! link purescriptConstructor Normal
hi! link purescriptFunction Normal
hi! link purescriptConditional Normal
hi! link purescriptBacktick Normal

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp Normal
hi! link coffeeSpecialOp Normal
hi! link coffeeCurly Normal
hi! link coffeeParen Normal
hi! link coffeeBracket Normal

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter Normal
hi! link rubyInterpolationDelimiter Normal

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier Normal
hi! link objcDirective Normal

" }}}
" Go: {{{

hi! link goDirective Normal
hi! link goConstants Normal
hi! link goDeclaration Normal
hi! link goDeclType Normal
hi! link goBuiltins Normal

" }}}
" Lua: {{{

hi! link luaIn Normal
hi! link luaFunction Normal
hi! link luaTable Normal

" }}}
" MoonScript: {{{

hi! link moonSpecialOp Normal
hi! link moonExtendedOp Normal
hi! link moonFunction Normal
hi! link moonObject Normal

" }}}
" Java: {{{

hi! link javaAnnotation Normal
hi! link javaDocTags Normal
hi! link javaCommentTitle Normal
hi! link javaParen Normal
hi! link javaParen1 Normal
hi! link javaParen2 Normal
hi! link javaParen3 Normal
hi! link javaParen4 Normal
hi! link javaParen5 Normal
hi! link javaOperator Normal

hi! link javaVarArg Normal

" }}}
" Elixir: {{{

hi! link elixirDocString Normal

hi! link elixirStringDelimiter Normal
hi! link elixirInterpolationDelimiter Normal

hi! link elixirModuleDeclaration Normal

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition Normal
hi! link scalaCaseFollowing Normal
hi! link scalaCapitalWord Normal
hi! link scalaTypeExtension Normal

hi! link scalaKeyword Normal
hi! link scalaKeywordModifier Normal

hi! link scalaSpecial Normal
hi! link scalaOperator Normal

hi! link scalaTypeDeclaration Normal
hi! link scalaTypeTypePostDeclaration Normal

hi! link scalaInstanceDeclaration Normal
hi! link scalaInterpolation Normal

" }}}
" Markdown: {{{

hi! link markdownItalic Normal

hi! link markdownH1 Normal
hi! link markdownH2 Normal
hi! link markdownH3 Normal
hi! link markdownH4 Normal
hi! link markdownH5 Normal
hi! link markdownH6 Normal

hi! link markdownCode Normal
hi! link markdownCodeBlock Normal
hi! link markdownCodeDelimiter Normal

hi! link markdownBlockquote Normal
hi! link markdownListMarker Normal
hi! link markdownOrderedListMarker Normal
hi! link markdownRule Normal
hi! link markdownHeadingRule Normal

hi! link markdownUrlDelimiter Normal
hi! link markdownLinkDelimiter Normal
hi! link markdownLinkTextDelimiter Normal

hi! link markdownHeadingDelimiter Normal
hi! link markdownUrl Normal
hi! link markdownUrlTitleDelimiter Normal

hi! link markdownLinkText Normal
hi! link markdownIdDeclaration Normal

" }}}
" Haskell: {{{

" hi! link haskellType GruvboxYellow
" hi! link haskellOperators GruvboxOrange
" hi! link haskellConditional GruvboxAqua
" hi! link haskellLet GruvboxOrange
"
hi! link haskellType Normal
hi! link haskellIdentifier Normal
hi! link haskellSeparator Normal
hi! link haskellDelimiter Normal
hi! link haskellOperators Normal
"
hi! link haskellBacktick Normal
hi! link haskellStatement Normal
hi! link haskellConditional Normal

hi! link haskellLet Normal
hi! link haskellDefault Normal
hi! link haskellWhere Normal
hi! link haskellBottom Normal
hi! link haskellBlockKeywords Normal
hi! link haskellImportKeywords Normal
hi! link haskellDeclKeyword Normal
hi! link haskellDeriving Normal
hi! link haskellAssocType Normal

hi! link haskellNumber Normal
hi! link haskellPragma Normal

hi! link haskellString Normal
hi! link haskellChar Normal

" }}}
" Json: {{{

hi! link jsonKeyword Normal
hi! link jsonQuote Normal
hi! link jsonBraces Normal
hi! link jsonString Normal

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
