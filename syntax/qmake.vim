if !exists("b:current_syntax")
    if version < 600
        syntax clear
    elseif exists("b:current_syntax")
        finish
    endif
    let b:current_syntax = 'qmake'
endif

syn match qmakeComment /#.*/

syn region qmakeString start=/\(^\|[^\\]\)\zs"/  skip=/\\"/  end=/"/ contains=qmakeEscape,qmakeValue,qmakeEnvVariable
syn match qmakeEscape /\\./ contained

syn match qmakeVariable /^\s*\zs[\$(){}a-zA-Z_\-.]\+\s*\ze\(+\|-\||\|*\|\~\|\)=/
syn match qmakeValue /\$\$\([a-zA-Z0-9_\-.]\+\|{[^}]*}\)/ contains=qmakeReplaceFuncall,qmakeBuiltin,qmakeBuiltinVariables
syn match qmakeReplaceFuncall /\$\$\S\+\ze(/ contained
syn match qmakeEnvVariable /\$\?\$([^)]*)/

syn match qmakeTest /.*\ze\([^\$]\{2}{\|:\)/ contains=qmakeTestFuncall,qmakeString,qmakeBuiltin
syn match qmakeTestFuncall /[a-zA-Z0-9_\-.]\+\ze\s*(/ contained

syn keyword qmakeBuiltin for if else defineReplace defineTest
syn keyword qmakeBuiltinVariables QMAKE_EXTRA_TARGETS TEMPLATE CONFIG SOURCES QMAKE_CXXFLAGS QMAKE_CFLAGS HEADERS

syn match qmakeInclude /^\s*include(.*)$/ contains=qmakeModule
syn match qmakeModule /(\zs.*\ze)$/ contained

hi def link qmakeComment Comment
hi def link qmakeString String
hi def link qmakeEscape Special

hi def link qmakeVariable Identifier
hi def link qmakeValue Type
hi def link qmakeReplaceFuncall Function
hi def link qmakeEnvVariable Type

hi def link qmakeTestFuncall Function

hi def link qmakeBuiltin Keyword
hi def link qmakeBuiltinVariables Keyword

hi def link qmakeInclude Keyword
hi def link qmakeModule String
