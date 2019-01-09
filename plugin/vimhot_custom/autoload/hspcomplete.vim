"
" hspcomplete.vim  ver 1.0.0
"
"
" �T�v
"   HSP��omnicomplete
"
"
" �ݒ�K�v�����E�E�E
"   
"  \(HSP�𕁒ʂ̏ꏊ�ɃC���X�g�[�����ĂȂ�|�o�[�W�������Ⴄ)����
"  �ǂ����B
"   
      let s:hspath = 'C:\Program Files\hsp35\hsphelp'


" ���ʂȉ��s�R�[�h���폜
func! s:chomp(raw)
  let idx = len( a:raw ) - 1
  while 1
    if a:raw[idx] != "\n"
      break
    endif
    let idx -= 1
  endwhile
  return strpart( a:raw, 0, idx + 1 )
endfunc


let s:lastftime = 0

" tags����
func! s:TagInitialize()

  let tagfilename = "tags"

  let ftime = getftime( tagfilename )
  if ftime > s:lastftime || ftime == -1 " �X�V
    let s:t_funclist = []
    let s:t_orderlist = []
    let s:t_macrolist = []
    let s:t_constlist = []
  else

    " �K�v�Ȃ�
    return
  endif
  let s:lastftime = ftime

  if ftime == -1
    return
  endif

  let lines = readfile( tagfilename )

  for line in lines
    " �w�b�_�̓X�L�b�v
    if strpart( line, 0, 2 ) == "!_"
      continue
    endif

    " �t�@�C���ő�p
    let dll = matchstr( line, '\t\S\{-}\t' )
    let dll = substitute( dll, '\t', '', 'g' )
    let dll = '[' . dll . ']'

    " �S�Ẵ^�O�t�@�C���� / �Ō��������Ƃ����O�񂾂��璍��
    let prminfo = matchstr( line, '/\^.*' )
    let prminfo = strpart( prminfo, 2, len( prminfo ) - 2 )
    let prminfo = matchstr( prminfo, '[^/]*' )

    let name = substitute( prminfo, '\(#define\|#const\|#deffunc\|#defcfunc\|#enum\|global\|ctype\|#cfunc\|#func\)', '', 'g' )
    let name = matchstr( name, '\<\S\{-}\>' )

    " �֐�
    if (prminfo =~ '\<ctype\>' && prminfo =~ '^#define') || (prminfo =~ '^#\(defcfunc\|cfunc\)')
      call add( s:t_funclist, {'name': name . '(', 'prm': prminfo, 'summary': '���[�U�[��`�֐��i�}�N���j', "dll": dll, "prminfo": '', "kind": "f"} )
    " �}�N��
    elseif prminfo =~ '^#define'
      call add( s:t_macrolist, {'name': name, 'prm': prminfo, 'summary': '���[�U�[��`�}�N��', "dll": dll, "prminfo": '', "kind": "m"} )
    " ����
    elseif prminfo =~ '^#\(deffunc\|func\)'
      call add( s:t_orderlist, {'name': name, 'prm': prminfo, 'summary': '���[�U�[��`����', "dll": dll, "prminfo": '', "kind": "o"} )
    " �萔
    elseif prminfo =~ '^#\(enum\|const\)'
      call add( s:t_constlist, {'name': name, 'prm': prminfo, 'summary': '���[�U�[��`�萔', "dll": dll, "prminfo": '', "kind": "c"} )
    else
      " ���x���iHSP�̎d�l��A�Ή��̂��悤�������j
    endif

  endfor

endfunc



" �����\�z
func! s:Initialize()

  let s:funclist = []
  let s:orderlist = []
  let s:svlist = []
  let s:prmtypelist = []
  let s:definemodifierlist = []
  let s:modifierlist = []
  let s:macrolist = []
  let s:swmacrolist = []

  echo "Constructing DataBases"

  " �܂���.hs�t�@�C����T��

  for file in split( glob(s:hspath . "\\" . "*.hs"), "\n" )

    let lines = readfile( file )

    " dll�擾
    let index = 0
    let dll = ""
    while lines[index] != "%index"
      if lines[index] == "%dll"
        let dll = "@" . lines[index+1]
      endif
      let index = index + 1
    endwhile

    " type�擾
    let index = 0
    let type = ""
    while lines[index] != "%index"
      if lines[index] == "%type"
        let type = lines[index+1]
      endif
      let index = index + 1
    endwhile


    " �V�X�e���ϐ����ۂ��H
    let is_sv = ( type =~ "�V�X�e���ϐ�" )

    " hs ����

    while index < len( lines )

      " %index�܂ōs�������߂�
      while index < len( lines )
        if lines[index] == "%index"
          break
        endif
        let index = index + 1
      endwhile
      if index >= len( lines )
        break
      endif

      " �֐������擾
      let index = index + 1
      let name = lines[index]

      " �T�}���[�擾
      let index = index + 1
      let summary = lines[index]

      " �p�����[�^���X�g�擾
      let _index = index
      let prm = ""
      let haveprm = 0
      while _index < len( lines )
        if lines[_index] == "%index"
          let _index -= 1
          break
        endif
        if lines[_index] == "%prm"
          let prm = lines[_index+1]
          let haveprm = 1
          break
        endif
        let _index = _index + 1
      endwhile

      " �p�����[�^�̃T�}���[�擾
      let prminfo = ""
      if haveprm
        let _index += 2
        while _index < len( lines ) 
          if strpart( lines[_index], 0, 1 ) == "%"
            break
          endif
          let prminfo .= lines[_index] . "\n"
          let _index = _index + 1
        endwhile
      endif


      " �ǉ�
      if is_sv
        call add( s:svlist, {'name': name, 'prm': prm, 'summary': summary, "dll": dll, "prminfo": s:chomp(prminfo), "kind": "v"} )
      elseif prm =~ "^(" && prm =~ ")$"
        call add( s:funclist, {'name': name . '(', 'prm': prm, 'summary': summary, "dll": dll, "prminfo": s:chomp(prminfo), "kind": "f"} )
      else
        call add( s:orderlist, {'name': name, 'prm': prm, 'summary': summary, "dll": dll, "prminfo": s:chomp(prminfo), "kind": "o"} )
      endif

      let index = _index + 1

    endwhile


  endfor


  " .hs�ɋL�ڂ���ĂȂ����

  " �v���v���Z�b�T
  call add( s:swmacrolist, {'name': '_debug', 'prm': '', 'summary': '�f�o�b�O���[�h���i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )
  call add( s:swmacrolist, {'name': '__hsp30__', 'prm': '', 'summary': 'ver3.0�g�p���i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )
  call add( s:macrolist, {'name': '__file__', 'prm': '', 'summary': '�����_�ŉ�͂���Ă���t�@�C�����i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )
  call add( s:macrolist, {'name': '__line__', 'prm': '', 'summary': '�����_�ŉ�͂���Ă���s�ԍ��i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )
  call add( s:macrolist, {'name': '__date__', 'prm': '', 'summary': '�g�p���_�̓��t�i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )
  call add( s:macrolist, {'name': '__time__', 'prm': '', 'summary': '�g�p���_�̎����i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )
  call add( s:macrolist, {'name': '__hspver__', 'prm': '', 'summary': 'HSP�o�[�W�����ԍ��i�}�N���j', 'dll': '', 'prminfo': '', "kind": "d"} )


  " �p�����[�^�^�C�v
  call add( s:prmtypelist, {'name': 'int', 'prm': '', 'summary': '�����l(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'var', 'prm': '', 'summary': '�ϐ��̃f�[�^�|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'str', 'prm': '', 'summary': '������|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'wstr', 'prm': '', 'summary': 'unicode������|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'sptr', 'prm': '', 'summary': '�|�C���^�����l�܂��͕�����̃|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'wptr', 'prm': '', 'summary': '�|�C���^�����l�܂���unicode������̃|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'double', 'prm': '', 'summary': '�����l(64bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'label', 'prm': '', 'summary': '���x���|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'float', 'prm': '', 'summary': '�����l(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'pval', 'prm': '', 'summary': 'PVal�\���̂̃|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'bmscr', 'prm': '', 'summary': 'BMSCR�\���̂̃|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'comobj', 'prm': '', 'summary': 'COMOBJ�^�ϐ��̃f�[�^�|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'prefstr', 'prm': '', 'summary': '�V�X�e���ϐ�refstr�̃|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'pexinfo', 'prm': '', 'summary': 'EXINFO�\���̂̃|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )
  call add( s:prmtypelist, {'name': 'nullptr', 'prm': '', 'summary': '�k���|�C���^(32bit)', 'dll': '', 'prminfo': '', "kind": "p"} )

  " �v���v���Z�b�T�̏C���q
  call add( s:modifierlist, {'name': 'global', 'prm': '', 'summary': '�O���[�o���C���q', 'dll': '', 'prminfo': '', "kind": ""} )

  " #define�̏C���q
  call add( s:definemodifierlist, {'name': 'ctype', 'prm': '', 'summary': 'C���ꕗ�\�L', 'dll': '', 'prminfo': '', "kind": ""} )

endfunction



function! hspcomplete#Complete(findstart, base)

  if !exists( "s:funclist" )
    call s:Initialize()
  endif

  call s:TagInitialize()

  if a:findstart
    let index = getline('.')
    let start = col('.') - 1
    while start > 0 && index[start - 1] =~ "[0-9A-Za-z_#]"
      let start -= 1
    endwhile
    return start
  else

    let res = []

    let complist = []

    " �J�[�\�����O�̂��擾
    let huge = strpart( getline('.'), 0, col('.') )

    " ����
    if huge !~ "[^ 	]"
      call extend( complist, s:t_orderlist )
      call extend( complist, s:t_macrolist )
      call extend( complist, s:orderlist )

    " �֐���`
    elseif huge =~ '^\s*#\(cfunc\|func\|deffunc\|defcfunc\|compfunc\|modfunc\|modinit\)'
      call extend( complist, s:modifierlist )
      call extend( complist, s:prmtypelist )

    " �X�^�e�B�b�N�ȏ�������
    elseif huge =~ '^\s*#\(if\|ifdef\|ifndef\)'
      call extend( complist, s:t_macrolist )
      call extend( complist, s:swmacrolist )
      call extend( complist, s:t_constlist )

    " #define
    elseif huge =~ '^\s*#\(define\)'
      " global, ctype
      call extend( complist, s:modifierlist )
      call extend( complist, s:definemodifierlist )

      " ����Ȃɂ����H
      call extend( complist, s:t_orderlist )
      call extend( complist, s:t_funclist )
      call extend( complist, s:t_constlist )
      call extend( complist, s:t_macrolist )

      call extend( complist, s:orderlist )
      call extend( complist, s:funclist )
      call extend( complist, s:svlist )
      call extend( complist, s:prmtypelist )
      call extend( complist, s:definemodifierlist )
      call extend( complist, s:modifierlist )
      call extend( complist, s:macrolist )
      call extend( complist, s:swmacrolist )

    " #undef
    elseif huge =~ '^\s*#\(undef\)'

      " �Ƃ肠�����A���������m��Ȃ�
      call extend( complist, s:t_funclist )
      call extend( complist, s:t_constlist )
      call extend( complist, s:t_orderlist )
      call extend( complist, s:t_macrolist )

      call extend( complist, s:funclist )
      call extend( complist, s:orderlist )
      call extend( complist, s:svlist )
      call extend( complist, s:prmtypelist )
      call extend( complist, s:definemodifierlist )
      call extend( complist, s:modifierlist )
      call extend( complist, s:macrolist )
      call extend( complist, s:swmacrolist )

    " �萔
    elseif huge =~ '^\s*#\(const\|enum\)'

      " global
      call extend( complist, s:modifierlist )

      call extend( complist, s:t_constlist )
      call extend( complist, s:t_macrolist )

    " �֐��A���߁A�}�N��
    else
      call extend( complist, s:t_funclist )
      call extend( complist, s:t_constlist )
      call extend( complist, s:t_macrolist )

      call extend( complist, s:funclist )
      call extend( complist, s:svlist )
      call extend( complist, s:macrolist )
    endif

    for comp in complist
      if comp.name =~ "^".a:base
        call add( res, {'word': comp.name, "menu": comp.summary, "info": comp.name .  comp.dll . "  " . comp.prm . "\n" . comp.prminfo} )
      endif
    endfor

    return res

  endif
endfunc

" vim: sw=2
