" Author: notuxic <notuxic@gmail.com
" License: BSD 2-clause
" Description: <Plug>-mappings and commands to pad/unpad line/selection with empty lines above/below/around

if exists('g:loaded_padline')
	finish
endif
let g:loaded_padline = 1



function! padline#PadLineAbove(linenr, count)
	call append(a:linenr-1, repeat([''], a:count))
endfunction

function! padline#PadLineBelow(linenr, count)
	call append(a:linenr, repeat([''], a:count))
endfunction

function! padline#PadBlockAround(linenr1, linenr2, count)
	call padline#PadLineBelow(a:linenr2, a:count)
	call padline#PadLineAbove(a:linenr1, a:count)
endfunction

nnoremap <unique> <silent> <Plug>PadLineAbove :<C-U>call padline#PadLineAbove(line('.'), v:count1)<CR>
nnoremap <unique> <silent> <Plug>PadLineBelow :<C-U>call padline#PadLineBelow(line('.'), v:count1)<CR>
nnoremap <unique> <silent> <Plug>PadLineAround :<C-U>call padline#PadBlockAround(line('.'), line('.'), v:count1)<CR>
inoremap <unique> <silent> <Plug>PadLineAbove <C-R>=repeat('', padline#PadLineAbove(line('.'), 1))<CR>
inoremap <unique> <silent> <Plug>PadLineBelow <C-R>=repeat('', padline#PadLineBelow(line('.'), 1))<CR>
inoremap <unique> <silent> <Plug>PadLineAround <C-R>=repeat('', padline#PadBlockAround(line('.'), 1))<CR>
vnoremap <unique> <silent> <Plug>PadBlockAbove :<C-U>call padline#PadLineAbove(line("'<"), v:count1)<CR>
vnoremap <unique> <silent> <Plug>PadBlockBelow :<C-U>call padline#PadLineBelow(line("'>"), v:count1)<CR>
vnoremap <unique> <silent> <Plug>PadBlockAround :<C-U>call padline#PadBlockAround(line("'<"), line("'>"), v:count1)<CR>
command -range -nargs=? PadAbove call padline#PadLineAbove(<line1>, empty('<args>') + '<args>')
command -range -nargs=? PadBelow call padline#PadLineBelow(<line2>, empty('<args>') + '<args>')
command -range -nargs=? PadAround call padline#PadBlockAround(<line1>, <line2>, empty('<args>') + '<args>')



function! s:prevblank(linenr)
	let nr = a:linenr
	while nr > 0 && getline(nr) != ''
		let nr -= 1
	endwhile
	return max([1, nr])
endfunction

function! s:nextblank(linenr)
	let nr = a:linenr
	let last = line('$')
	while nr < last && getline(nr) != ''
		let nr += 1
	endwhile
	return min([last, nr])
endfunction

function! padline#UnpadLineAbove(linenr, count)
	let empty_to = <SID>prevblank(a:linenr - 1)
	let empty_from = max([empty_to - a:count + 1, prevnonblank(empty_to) + 1])
	call deletebufline('%', empty_from, empty_to)
endfunction

function! padline#UnpadLineBelow(linenr, count)
	let empty_from = <SID>nextblank(a:linenr + 1)
	let empty_to = min([empty_from + a:count - 1, nextnonblank(empty_from) - 1])
	if empty_to < 0
		let empty_to = line('$')
	endif
	call deletebufline('%', empty_from, empty_to)
endfunction

function! padline#UnpadBlockAround(linenr1, linenr2, count)
	call padline#UnpadLineBelow(a:linenr2, a:count)
	call padline#UnpadLineAbove(a:linenr1, a:count)
endfunction

nnoremap <unique> <silent> <Plug>UnpadLineAbove :<C-U>call padline#UnpadLineAbove(line('.'), v:count1)<CR>
nnoremap <unique> <silent> <Plug>UnpadLineBelow :<C-U>call padline#UnpadLineBelow(line('.'), v:count1)<CR>
nnoremap <unique> <silent> <Plug>UnpadLineAround :<C-U>call padline#UnpadBlockAround(line('.'), line('.'), v:count1)<CR>
inoremap <unique> <silent> <Plug>UnpadLineAbove <C-R>=repeat('', padline#UnpadLineAbove(line('.'), 1))<CR>
inoremap <unique> <silent> <Plug>UnpadLineBelow <C-R>=repeat('', padline#UnpadLineBelow(line('.'), 1))<CR>
inoremap <unique> <silent> <Plug>UnpadLineAround <C-R>=repeat('', padline#UnpadBlockAround(line('.'), 1))<CR>
vnoremap <unique> <silent> <Plug>UnpadBlockAbove :<C-U>call padline#UnpadLineAbove(line("'<"), v:count1)<CR>
vnoremap <unique> <silent> <Plug>UnpadBlockBelow :<C-U>call padline#UnpadLineBelow(line("'>"), v:count1)<CR>
vnoremap <unique> <silent> <Plug>UnpadBlockAround :<C-U>call padline#UnpadBlockAround(line("'<"), line("'>"), v:count1)<CR>
command -range -nargs=? UnpadAbove call padline#UnpadLineAbove(<line1>, empty('<args>') + '<args>')
command -range -nargs=? UnpadBelow call padline#UnpadLineBelow(<line2>, empty('<args>') + '<args>')
command -range -nargs=? UnpadAround call padline#UnpadBlockAround(<line1>, <line2>, empty('<args>') + '<args>')

