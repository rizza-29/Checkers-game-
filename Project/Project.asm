Include Irvine32.inc
Include Macros.inc
.data
Win1 Byte "Player 1 won"
Win2 Byte "Player 2 won"
count Dword 0
x Dword 0
y Dword 0
Move Dword 0
place1 Dword 0
place2 Dword 0
Oldplace Dword 0
PlayerCount Dword 0
Enemies1 Dword 9 DUP (?)
Enemies2 Dword 9 DUP (?)
direct Sword 0
var Dword 0
rem Dword 0
board DWord 8 DUP (32)
	  DWord 8 DUP (32)
	  DWord 8 DUP (32)
   	  DWord 8 DUP (32)
	  DWord 8 DUP (32)
	  DWord 8 DUP (32)
	  DWord 8 DUP (32)
	  DWord 8 DUP (32)
.code
main PROC
mov ecx,3
mov esi,OFFSET board

L1:
	mov eax,ecx
	mov ecx,4
	mov edi,'B'
	L2:
		mov [esi],edi
		add esi,8
	loop L2
	mov ecx,eax
	mov ebx,2
	cmp ecx,ebx
	jne condition
	sub esi,8
	condition:
	add esi,4
loop L1
mov eax,40
mov ebx,TYPE board
mul ebx
mov esi,OFFSET board
add esi,eax
mov ecx,3
mov edi,"W"
add esi,4
L3:
	mov eax,ecx
	mov ecx,4
	L4:
		mov [esi],edi
		add esi,8
	loop L4
	mov ecx,eax
	mov ebx,2
	cmp ecx,ebx
	jne cond
	add esi,8
	cond:
	sub esi,4
loop L3
call DisplayBoard
call Gameplay
exit
main Endp

PossibleMoves Proc
	Again:
	mWrite "Enter the x-coordinates of the piece you want to move (1-9):"
	call readDec
	mov x,eax
	mWrite "Enter the y-coordinates of the piece you want to move (1-8):"
	call readDec
	mov y,eax
	mWrite "Possible moves:"
	call crlf
	mov esi,0
	mov edi,0
	mov ecx,1
	L5:
		cmp ecx,9
		je loop5End
		cmp y,ecx
		jne Normal1
		mov eax,esi
		mov ecx,1
			L6:
				cmp ecx,9
				jge loopEnd
				cmp x,ecx
				jne Normal
				mov Oldplace,esi
				cmp direct,-1
				jne Upward
				Downward:
					cmp [board+esi],'B'
					jne NotPiece
					mov edi,esi
					cmp edi,256
					je Winning1
					cmp edi,260
					je Winning1
					cmp edi,264
					je Winning1
					cmp edi,268
					je Winning1
					cmp edi,272
					je Winning1
					cmp edi,276
					je Winning1
					cmp edi,280
					je Winning1
					cmp edi,284
					je Winning1
					mov eax,edi
					mov edx,0
					mov ebx,32
					div ebx
					cmp edx,0
					je S2
					add edi,28
					mov count,0
					EnemyCheck1:
						mov eax,[board+edi]
						cmp eax,'B'
						je S2
						cmp eax,'W'
						jne NoEnemies1
						mov eax,edi
						mov edx,0
						mov ebx,32
						div ebx
						cmp edx,0
						je NoEnemies1
						mov [Enemies1+count]
						add edi,28
						inc count
						jmp EnemyCheck1
					NoEnemies1:
						mov [board+edi],5
						mov place1,edi
					S2:
						mov edi,esi
						cmp edi,28
						je loop5End
						cmp edi,60
						je loop5End
						cmp edi,92
						je loop5End
						cmp edi,124
						je loop5End
						cmp edi,156
						je loop5End
						cmp edi,188
						je loop5End
						cmp edi,220
						je loop5End
						cmp edi,252
						je loop5End
						cmp edi,284
						je loop5End
						add edi,36
						mov eax,[board+edi]
						cmp eax,'B'	
						je loop5End
						mov count,0
						EnemyCheck2:
							cmp eax,'W'
							jne NoEnemies2
							mov eax,edi
							mov edx,0
							mov ebx,32
							div ebx
							cmp edi,28
							je NoEnemies2
							cmp edi,60
							je NoEnemies2
							cmp edi,92
							je NoEnemies2
							cmp edi,124
							je NoEnemies2
							cmp edi,156
							je NoEnemies2
							cmp edi,188
							je NoEnemies2
							cmp edi,220
							je NoEnemies2
							cmp edi,252
							je NoEnemies2
							cmp edi,284
							je NoEnemies2
							mov [Enemies2+count],edi
							add edi,36
							inc count
						jmp EnemyCheck1
						NoEnemies2:
							mov [board+edi],5
							mov place2,edi
						jmp loop5End
				Upward:
					cmp [board+esi],'W'
					jne NotPiece
					mov edi,esi
					cmp edi,0
					je Winning2
					cmp edi,4
					je Winning2
					cmp edi,8
					je Winning2
					cmp edi,12
					je Winning2
					cmp edi,16
					je Winning2
					cmp edi,20
					je Winning2
					cmp edi,24
					je Winning2
					cmp edi,28
					je Winning2
					mov eax,edi
					mov edx,0
					mov ebx,32
					div ebx
					cmp edx,0
					je S1
					sub edi,36
					mov count,0
					EnemyCheck3:
						mov eax,[board+edi]
						cmp eax,'W'
						je S1
						cmp eax,'B'
						jne NoEnemies3
						mov eax,edi
						mov edx,0
						mov ebx,32
						div ebx
						cmp edx,0
						je NoEnemies3
						mov [Enemies1+count],32
						sub edi,36
						inc count
						jmp EnemyCheck3
					NoEnemies3:
						mov [board+edi],5
						mov place1,edi
					S1:
						mov edi,esi
						cmp edi,28
						je loop5End
						cmp edi,60
						je loop5End
						cmp edi,92
						je loop5End
						cmp edi,124
						je loop5End
						cmp edi,156
						je loop5End
						cmp edi,188
						je loop5End
						cmp edi,220
						je loop5End
						cmp edi,252
						je loop5End
						cmp edi,284
						je loop5End
						sub edi,28
						EnemyCheck4:
							mov eax,[board+edi]
							cmp eax,'W'	
							je loop5End
							cmp eax,'B'	
							jne NoEnemies4
							mov edi,esi
							cmp edi,28
							je NoEnemies4
							cmp edi,60
							je NoEnemies4
							cmp edi,92
							je NoEnemies4
							cmp edi,124
							je NoEnemies4
							cmp edi,156
							je NoEnemies4
							cmp edi,188
							je NoEnemies4
							cmp edi,220
							je NoEnemies4
							cmp edi,252
							je NoEnemies4
							cmp edi,284
							je NoEnemies4
							mov Enemies,32
							sub edi,28
						NoEnemies4:
							mov [board+edi],5
							mov place2,edi
							jmp loop5End
						jmp Normal
				Winning1:
					mWrite "Player 1 Won !"
					jmp loop5End
				Winning2:
					mWrite "Player 2 Won !"
					jmp loop5End
				Normal:
					inc ecx
					add esi,Type Board
					jmp L6
			loopEnd:
		jmp loop5End
		Normal1:
		add esi,32
		inc ecx
		jmp L5
		NotPiece:
			mWrite "There isn't any piece at your entered co-ordinates!"
			call crlf
			jmp Again
	loop5End:
ret
PossibleMoves Endp

DisplayBoard Proc
	mov esi,0
	mov ecx,1
	mov ebx,2
	L5:
		cmp ecx,9
		je loop5End
		mov var,ecx
		mov eax,ecx
		mov ebx,2
		mov edx,0
		div ebx
		mov ecx,1
		cmp edx,0
		je NotRem
		mov rem,0
		jmp L6
		NotRem:
		mov rem,1
			L6:
				cmp ecx,9
				je loopEnd
				mov ebx,2
				mov eax,ecx
				mov edx,0
				div ebx
				mov ebx,rem
				mov eax,[board + esi]
				cmp eax,5
				jne Blk
				mov al,Black+(Green*16)
				call SetTextColor
				mov eax,0
				mov [board + esi],32
				jmp Continue
				Blk:
				cmp edx,ebx
				je Whi
					mov al,black+(White*16)
					call SetTextColor
					mov eax,0
					jmp Continue
				Whi:
					mov al,White+(Black*16)
					call SetTextColor
					mov eax,0
				Continue:
				mov al,' ' 
				call WriteChar
				mov eax,0
				mov eax,[board + esi]
				add esi,TYPE board
				call WriteChar
				mov al,' ' 
				call WriteChar
				inc ecx
				jmp L6
			loopEnd:
		mov ecx,var
		inc ecx
		call crlf
		jmp L5
	loop5End:
	mov al,White+(Black*16)
	call SetTextColor
	ret
DisplayBoard Endp

MovePiece Proc 
	L1:
	mWrite "Enter 1 for first possible move and 2 for second one:"
	call ReadDec
	mov Move,eax
	cmp Move,1
	jne place2nd
	mov ebx,place1
	mov esi,Oldplace
	mov [board+ebx],edi
	mov [board+esi],32
	jmp EndFunc
	Place2nd:
		cmp Move,2
		jne NotEqual
		mov ebx,place2
		mov esi,Oldplace
		mov [board+ebx],edi
		mov [board+esi],32
		jmp EndFunc
	NotEqual:
		mWrite "Enter valid number:"
		jmp L1
	EndFunc:
	ret
MovePiece Endp

Gameplay Proc
	Game:
		Player1:
			mWrite "Player 1's turn"
			call crlf
			mov direct,-1
			call PossibleMoves
			call DisplayBoard
			mov edi,'B'
			call MovePiece
			call DisplayBoard
		Player2:
			mWrite "Player 2's turn"
			call crlf
			mov direct,1
			call PossibleMoves
			call DisplayBoard
			mov edi,'W'
			call MovePiece
			call DisplayBoard
		jmp Game
	ret
Gameplay Endp

End main