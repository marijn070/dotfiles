"Vim syntax file
" Language:     TypeQL
" Maintainer:   Marijn de Rijk <derijkmarijn00@gmail.com>
" Filenames:    *.tql
" Last Change:  2023 March 29
" Sources:
" * https://github.com/graknlabs/grakn/blob/master/grakn-typeql/src/main/antlr4/ai/grakn/typeql/internal/antlr/typeql.g4
" * http://dev.grakn.ai/docs/api-references/ddl

if exists("b:current_syntax")
  finish
endif

syntax keyword typeqlMatchProperty add-more-here contained
highlight def link typeqlMatchProperty Keyword
syntax keyword typeqlDatatype boolean double long string date true false contained
highlight def link typeqlDatatype Keyword
syntax keyword typeqlRuleAdverb when then contained
highlight def link typeqlRuleAdverb Keyword

syntax region typeqlComment start=/^#/ end=/$/
syntax region typeqlStatement start=/\v(define|insert|match)(\s|\n)+/ end=/;(\s|\n)*(define|insert|match)/ms=s-1 contains=typeqlQueryType,typeqlDefineVariablePattern,typeqlInsertVariablePattern
syntax region typeqlDefineVariablePattern start=/\v[^[:space:]\n]+(\s|\n)+sub/ end=/;/ contains=typeqlCommonProperty,typeqlDefineProperty,typeqlIdentifier,typeqlVariable,typeqlString,typeqlSchemaConcept contained
syntax region typeqlInsertVariablePattern start=/\v[^[:space:]\n]+(\s|\n)+(\([^()]+\)(\s|\n)+)?isa/ end=/;/ contains=typeqlCommonProperty,typeqlInsertProperty,typeqlIdentifier,typeqlVariable,typeqlString contained
syntax region typeqlString start=/"/ skip=/\\"/ end=/"/ contained

syntax match typeqlIdentifier /\v[a-zA-Z_][a-zA-Z0-9_-]*/ contained
syntax match typeqlVariable /\v\$[a-zA-Z0-9_-]+/ contained
syntax match typeqlQueryType /\v<(define|insert|match)>/ contained
syntax match typeqlCommonProperty /\v<(has)>/ contained
syntax match typeqlDefineProperty /\v<(datatype|is-abstract|key|plays|relates|sub|as|owns|rule)>/ contained
syntax match typeqlInsertProperty /\v<(isa)>/ contained
syntax match typeqlSchemaConcept /\v(sub(\s|\n)+)\@<=[a-zA-Z_][a-zA-Z0-9_-]*/ contained

let b:current_syntax = "tql"

highlight def link typeqlComment Comment
highlight def link typeqlString String
highlight def link typeqlIdentifier Identifier
highlight def link typeqlVariable Identifier
highlight def link typeqlQueryType Keyword
highlight def link typeqlCommonProperty Keyword
highlight def link typeqlDefineProperty Keyword
highlight def link typeqlInsertProperty Keyword
highlight def link typeqlSchemaConcept Type

" setting the comment string to #
setlocal commentstring=#\ %s

