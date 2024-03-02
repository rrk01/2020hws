TITLE TIC TAC TOE
INCLUDE irvine32.inc

Turn = 1
.data
BlockE BYTE "123456789ABCDEFGHIJKLMNOP",0
iqra byte "Five_By_Five 5*5",0
Variable BYTE '  | ',0
Variable1 BYTE "Enter the position player X : ",0
Variable2 BYTE "Enter the position player 0 : ",0
Variable3 BYTE "Player  ",0
Variable4 BYTE "  has won the game ",0
Variable5 BYTE "              Sorry! No One Can Win The Game",0
Variable6 BYTE "Invalid move",0
Variable7 BYTE "Do You Want to Play With Pc (y/n) : ",0
pc BYTE ?
pc_input DWORD ?
Move BYTE ?
Count BYTE 1
Draw Byte 0
str1 byte "TIC TAC TOE",0
str2 byte "New game",0
str3 byte "High Scores",0
str4 byte "Instruction",0
button byte "->",0
XPosition byte ?
YPosition byte ?
XPositionDisp byte ?
YPositionDisp byte ?
newG byte "New Game",0
high1 byte "HighScore",0
instruction byte "Instruction",0
row1 byte '__|__|__|__|__',0
row2 byte '  |  |  |  |',0
Easy byte "Hard Level",0
Medium byte "Easy Level",0
Hard byte "Medium Level",0
exiting byte "Exit",0
again byte "Do you want to play again(y/n):",0
again1 byte ?
startTime DWORD ?
HighScoreComp DWORD ?
score byte "Your High Score is : ",0
seconds byte " Seconds",0
player1 byte ?
player2 byte ?
temp DWORD 60000
str10 byte "Result (PlayerX vs Player0):",0
str11 byte "PlayerX : ",0
str12 byte "Player0 : ",0
winFlag byte 0
compFlag byte 0
Instruct2 BYTE "                             Instructions",0ah,0dh
			 BYTE "* Goal : ",0ah,0dh
			 BYTE "      => The goal of Tic Tac Toe is to be the first player to get Four in a row on a 5*5 grid",0ah,0dh
			 BYTE "* Playing Tic Tac Toe on a 5*5 Board",0ah,0dh
			 BYTE "      => X always goes first",0ah,0dh
			 BYTE "      => Players alternate placing Xs and Os on the board until either (a) one player has three",0ah,0dh
			 BYTE "         in a row horizontally, vertically or diagonally; or (b) all sixteen squares are filled",0ah,0dh
			 BYTE "      => If a player is able to draw five Xs or five Os in a row, that player wins",0ah,0dh
			 BYTE "      => If all Twenty five squares are filled and neither player has five in a row, the game is a draw",0ah,0dh,0


.code
main PROC


call Front
startGame::
mov al,1
cmp al, Count
jne Initial
call DisplayEasy
mov Count, 0
Initial:
call GetMSeconds
mov startTime,eax
mov eax,1
cmp eax,Turn
je TurnX

cmp eax, Turn
jne Turn0
TurnX:
call FuncX
Turn0:
call Func0
jmp Initial
doWhile::
;call clrscr
mov count,1
mov draw,0
mov pc,'n'
call crlf

mov again1,al
call GetMSeconds
sub eax,startTime

mov HighScoreComp,eax
mov eax,HighScoreComp
mov edx,0
mov ebx,1000
div ebx
mov HighScoreComp,eax
mov ecx,temp
cmp HighScoreComp,ecx
jg skip
mov temp,eax
jmp skip1
skip:
mov ecx,temp
mov HighScoreComp,ecx
skip1:
cmp again1,'y'


exit

main ENDP

;------------------------Front Function------------------------------------
Front PROC
call clrscr
call DisplayFront

mov dh,13
mov dl,40
call gotoxy
mov edx,OFFSET str2
call writestring
mov dh,14
mov dl,40
call gotoxy
mov edx,OFFSET str3
call writestring
mov dh,15
mov dl,40
call gotoxy
mov edx,OFFSET str4
call writestring
mov dh,16
mov dl,40
call gotoxy
mov edx,OFFSET exiting
call writestring
mov dl,35
mov dh,13
mov Xposition,dh
mov YPosition,dl
call gotoxy


lookForKey:
mov eax,5
call delay
mov eax,0
mov edx,0
call readKey
jz lookForKey

cmp dx,28h
jne next1
cmp XPosition,15
ja noIncrement
inc XPosition
noIncrement:
mov dl,YPosition
mov dh,XPosition
call gotoxy

next1:
cmp dx,26h
jne next2
cmp XPosition,14
jb noDecrement
dec XPosition
noDecrement:
mov dl,YPosition
mov dh,XPosition
call gotoxy

next2:
cmp dx,0dh
jne next3
cmp XPosition,13
je newGame1
cmp XPosition,14
je highscore
cmp XPosition,15
je instruct
cmp XPosition,16
je exiting1

next3:
jmp lookForKey

newGame1:
call NewGame
jmp ending

highscore:
call clrscr
mov edx,OFFSET score
call writeString
mov eax,HighScoreComp
call writeDec
mov edx,OFFSET seconds
call writeString
jmp doWhile

instruct:
call clrscr
call Instruction1
jmp doWhile

exiting1:
call crlf
exit

ending:
call crlf

ret
Front ENDP
;------------------------Front Ends----------------------------------------

;-----------------------result Function------------------------------------

result PROC
mov edx,OFFSET str10      ;Result
call writeString
call crlf
mov edx,OFFSET str11       ;PlayerX
call writeString
movzx eax,player1
call writedec
call crlf

mov edx,OFFSET str12                 ;Player0
call writeString
movzx eax,player2
call writedec
call crlf

ret
result ENDP
;-----------------------result End-----------------------------------------

;------------------------DisplayFront Function-----------------------------
DisplayFront PROC

mov dl,41
mov dh,1
call gotoxy
mov edx,OFFSET str1                 ;TIC TAC TOE
call writeString
call crlf

mov dl,41
mov dh,3
call gotoxy
mov edx,offset iqra
call writestring
mov XPosition,5
mov YPosition,42
call grid


ret
DisplayFront ENDP
;------------------------DisplayFront Ends---------------------------------

;------------------------Instruction1 Function-----------------------------

Instruction1 PROC
call clrscr
call displayFront
call crlf
call crlf
call crlf
mov edx,OFFSET Instruct2
call writeString
ret
Instruction1 ENDP

;------------------------Instruction1 Ends---------------------------------


;------------------------NewGame Function----------------------------------

NewGame PROC
call clrscr
call DisplayFront


mov dh,14
mov dl,40
call gotoxy
mov edx,OFFSET Easy
call writestring
mov dh,15
mov dl,40
call gotoxy
mov edx,OFFSET Medium
call writestring
mov dh,16
mov dl,40
call gotoxy
mov edx,OFFSET Hard
call writestring
mov dl,35
mov dh,14
mov Xposition,dh
mov YPosition,dl
call gotoxy


lookForKey:
mov eax,5
call delay
mov eax,0
mov edx,0
call readKey
jz lookForKey

cmp dx,28h
jne next1
cmp XPosition,13
ja noIncrement
inc XPosition
noIncrement:
mov dl,YPosition
mov dh,XPosition
call gotoxy

next1:
cmp dx,26h
jne next2
cmp XPosition,14
jb noDecrement
dec XPosition
noDecrement:
mov dl,YPosition
mov dh,XPosition
call gotoxy

next2:
cmp dx,0dh
jne next3
cmp XPosition,14
je playUser
next3:
jmp lookForKey
playUser:
call clrscr
call playWithFriend
jmp ending

ending:

ret
NewGame ENDP

;------------------------NewGame Ends--------------------------------------

;-------------------------playWithFriend Function--------------------------------------
playWithFriend PROC
call clrscr
mov compFlag,0
jmp startGame
ret
playWithFriend ENDP

;------------------------playWithFriend Ends-------------------------------------------

;------------------------Grid Function-----------------------------------------------
Grid PROC
mov ecx,4
l1:
mov dl,YPosition
mov dh,XPosition
call gotoxy
mov edx,OFFSET row1           ;Blocks |
call writeString
inc XPosition
mov dl,YPosition
mov dh,XPosition
call gotoxy
mov edx,OFFSET row2
call writeString
inc XPosition
LOOP l1

ret
Grid ENDP

;------------------------Grid Ends---------------------------------------------------

; -----------------------Display Easy LEVEL Starts--------------------------
DisplayEasy PROC
call clrscr
mov ecx, LENGTHOF BlockE-1
mov esi,0
mov ebx,5
disp:
movzx eax, BlockE[esi]
call writeChar
inc esi
mov edx, OFFSET Variable
call writeString

cmp esi,ebx
je disp1

Loop disp

disp1:
call crlf
dec ecx				;To decrement one extra loop at the end
add ebx,5
mov eax, 0
cmp eax,ecx
jne disp

ret
DisplayEasy ENDP
; -----------------------Display Easy Level Ends--------------------------

; -----------------------FuncX Procedure Starts--------------------------
FuncX PROC USES edx eax
start : 
mov edx, OFFSET Variable1            ;PlayerX Position
call writeString
mov eax, OFFSET Move
call Readint
cmp eax,25
jg equal
cmp eax,1
jl equal
cmp BlockE[eax-1],'X'
je equal
cmp BlockE[eax-1],'0'
je equal
mov BlockE[eax-1], 'X'
inc Draw
call clrscr
call DisplayEasy
turn = 0
call Win
jmp ending
equal :
mov edx,OFFSET Variable6              ;Invalid Move
call writeString
call crlf
jmp start
ending :
ret
FuncX ENDP
; -----------------------FuncX Procedure Ends--------------------------

; -----------------------Func0 Procedure Starts--------------------------
Func0 PROC 
start:

next:
mov edx, OFFSET Variable2
call writeString
mov eax, OFFSET Move
call Readint
put_input:
cmp eax,25
jg equal
cmp eax,1
jl equal
cmp BlockE[eax-1],'X'
je equal
cmp BlockE[eax-1],'0'
je equal
mov BlockE[eax-1], '0'
inc Draw
call clrscr
call DisplayEasy
turn = 1
call Win
jmp ending
equal :
cmp pc,'y'
je start
mov edx,OFFSET Variable6
call writeString
call crlf
jmp start
ending :
ret
Func0 ENDP
; -----------------------Func0 Procedure Ends--------------------------

; -----------------------Win Procedure Starts--------------------------
Win PROC
call Condition1
call Condition2
call Condition3
call Condition4
call Condition5
call Condition6
call Condition7
call Condition8
call Condition9
call Condition10
call Condition11
call Condition12
mov al,16
cmp al,Draw
je Drw
jmp Drw1
Drw:
mov edx, OFFSET Variable5         ;Game Draw
call writeString
call crlf
jmp doWhile

Drw1:
ret
Win ENDP
; -----------------------Win Procedure Ends--------------------------
; ----------------------- Horizontal Conditions starts ------------------------
; -----------------------Condition1 Procedure starts--------------------------
Condition1 PROC USES eax edx
mov al,BlockE[0]
cmp al,BlockE[1]
je L1
ret
jmp L3
L1:
cmp al,BlockE[2]
je L4
ret
jmp L3
L4:
cmp al,BlockE[3]
je L8
ret
jmp L3
L8:
cmp al,BlockE[4]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip7
call result
kip7:

jmp doWhile
L3:
call main
Condition1 ENDP
; -----------------------Condition1 Procedure ends--------------------------

; -----------------------Condition2 Procedure starts--------------------------
Condition2 PROC USES eax edx
mov al,BlockE[5]
cmp al,BlockE[6]
je L1
ret
jmp L3
L1:
cmp al,BlockE[7]
je L4
ret
jmp L3
L4:
cmp al,BlockE[8]
je L8
ret
jmp L3
L8:
cmp al,BlockE[9]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip7
call result
kip7:

jmp doWhile
L3:
call main
Condition2 ENDP
; -----------------------Condition2 Procedure ends--------------------------

; -----------------------Condition3 Procedure starts--------------------------
Condition3 PROC USES eax edx
mov al,BlockE[10]
cmp al,BlockE[11]
je L1
ret
jmp L3
L1:
cmp al,BlockE[12]
je L4
ret
jmp L3
L4:
cmp al,BlockE[13]
je L8
ret
jmp L3
L8:
cmp al,BlockE[14]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip7
call result
kip7:

jmp doWhile
L3:
call main
Condition3 ENDP
; -----------------------Condition3 Procedure ends--------------------------
; ----------------------- Horizontal Conditions ends ------------------------


; ----------------------- Vertical Conditions starts ------------------------
; -----------------------Condition4 Procedure starts--------------------------
Condition4 PROC USES eax edx
mov al,BlockE[15]
cmp al,BlockE[16]
je L1
ret
jmp L3
L1:
cmp al,BlockE[17]
je L4
ret
jmp L3
L4:
cmp al,BlockE[18]
je L8
ret
jmp L3
L8:
cmp al,BlockE[19]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip7
call result
kip7:

jmp doWhile
L3:
call main
Condition4 ENDP
; -----------------------Condition4 Procedure ends--------------------------

; -----------------------Condition5 Procedure starts--------------------------
Condition5 PROC USES eax edx
mov al,BlockE[20]
cmp al,BlockE[21]
je L1
ret
jmp L3
L1:
cmp al,BlockE[22]
je L4
ret
jmp L3
L4:
cmp al,BlockE[23]
je L8
ret
jmp L3
L8:
cmp al,BlockE[24]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip7
call result
kip7:

jmp doWhile
L3:
call main
Condition5 ENDP
; -----------------------Condition5 Procedure ends--------------------------

; -----------------------Condition6 Procedure starts--------------------------
Condition6 PROC USES eax edx
mov al,BlockE[0]
cmp al,BlockE[5]
je L1
ret
jmp L3
L1:
cmp al,BlockE[10]
je L4
ret
jmp L3
L4:
cmp al,BlockE[15]
je L8
ret
jmp L3
L8:
cmp al,BlockE[20]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip6
call result
kip6:

jmp doWhile
L3:
call main
Condition6 ENDP
; -----------------------Condition6 Procedure ends--------------------------
; ----------------------- Vertical Conditions ends ------------------------

;----------------------- Diagonal Conditions starts ------------------------
; -----------------------Condition7 Procedure starts--------------------------
Condition7 PROC USES eax edx
mov al,BlockE[1]
cmp al,BlockE[6]
je L1
ret
jmp L3
L1:
cmp al,BlockE[11]
je L4
ret
jmp L3
L4:
cmp al,BlockE[16]
je L8
ret
jmp L3
L8:
cmp al,BlockE[21]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip7
call result
kip7:

jmp doWhile
L3:
call main
Condition7 ENDP
; -----------------------Condition7 Procedure ends--------------------------

; -----------------------Condition8 Procedure starts--------------------------
Condition8 PROC USES eax edx
mov al,BlockE[2]
cmp al,BlockE[7]
je L1
ret
jmp L3
L1:
cmp al,BlockE[12]
je L4
ret
jmp L3
L4:
cmp al,BlockE[17]
je L8
ret
jmp L3
L8:
cmp al,BlockE[22]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip8
call result
kip8:

jmp doWhile
L3:
call main
Condition8 ENDP
; -----------------------Condition8 Procedure ends--------------------------

; -----------------------Condition9 Procedure starts--------------------------
Condition9 PROC USES eax edx
mov al,BlockE[3]
cmp al,BlockE[8]
je L1
ret
jmp L3
L1:
cmp al,BlockE[13]
je L4
ret
jmp L3
L4:
cmp al,BlockE[18]
je L8
ret
jmp L3
L8:
cmp al,BlockE[23]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip8
call result
kip8:

jmp doWhile
L3:
call main
Condition9 ENDP
; -----------------------Condition9 Procedure ends--------------------------

; -----------------------Condition10 Procedure starts--------------------------
Condition10 PROC USES eax edx
mov al,BlockE[4]
cmp al,BlockE[9]
je L1
ret
jmp L3
L1:
cmp al,BlockE[14]
je L4
ret
jmp L3
L4:
cmp al,BlockE[19]
je L8
ret
jmp L3
L8:
cmp al,BlockE[24]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip8
call result
kip8:

jmp doWhile
L3:
call main
Condition10 ENDP
; -----------------------Condition10 Procedure ends--------------------------

; -----------------------Condition11 Procedure starts--------------------------
Condition11 PROC USES eax edx
mov al,BlockE[0]
cmp al,BlockE[6]
je L1
ret
jmp L3
L1:
cmp al,BlockE[12]
je L4
ret
jmp L3
L4:
cmp al,BlockE[18]
je L8
ret
jmp L3
L8:
cmp al,BlockE[24]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip8
call result
kip8:

jmp doWhile
L3:
call main
Condition11 ENDP
; -----------------------Condition11 Procedure ends--------------------------

; -----------------------Condition12 Procedure starts--------------------------
Condition12 PROC USES eax edx
mov al,BlockE[4]
cmp al,BlockE[8]
je L1
ret
jmp L3
L1:
cmp al,BlockE[12]
je L4
ret
jmp L3
L4:
cmp al,BlockE[16]
je L8
ret
jmp L3
L8:
cmp al,BlockE[20]
je L2
ret
jmp L3
L2:
mov edx,offset Variable3
call writeString
cmp compFlag,1
je skip3
cmp al,'X'
jne playe2
inc player1
jmp skip3
playe2:
inc player2
skip3:

call writeChar
mov edx, OFFSET Variable4
call writeString
call crlf
call crlf

cmp compFlag,1
je kip8
call result
kip8:

jmp doWhile
L3:
call main
Condition12 ENDP
; -----------------------Condition12 Procedure ends--------------------------
;----------------------- Diagonal Conditions ends ------------------------

END main