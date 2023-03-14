.model tiny
.code
org 100h

locals

;=============================================
;PLAN
;=============================================
;---------------------------------------------
; 1) Create a frame, when a person should enter
;    the password;
; 2) Check some cash of the programm
; 3) td 
;
;---------------------------------------------



Start:		jmp skip
            ;UserPass db 0BAh, 03h, 01h, 0B9h, 0Ch, 00h, 0B4h
            UserPass db 0BAh, 03h, 01h, 0B9h, 0Ch
            LengthPass db 7d
            LastSym db 3Ah
            skip:

            mov bh, 10d
            mov dx, offset Frase

            call PrintToConsole
            call GetConsoleSym
            call XorArr
            call CheckPass

            mov ax, 4c00h
            int 21h

;========================================================
;PRINT AN ARRAY TO THE CONSOLE
;========================================================
;--------------------------------------------------------
; Outputs an array to the console
;--------------------------------------------------------
;
;ENTRY: DS:DX
;
;DESTROYS: NONE
;--------------------------------------------------------

PrintToConsole  proc

                push ax dx

                mov ah, 09h
                int 21h

                pop dx ax

                ret
                endp

;========================================================
; GET A CHARACTER FROM THE
;========================================================
;--------------------------------------------------------
; Outputs an array to the console
;--------------------------------------------------------
;
;ENTRY: DS:DX
;
;DESTROYS: NONE
;--------------------------------------------------------

XorArr          proc
                xor ax, ax              ; AX = SUM
                mov cx, 7d
                lea di, UserPass
                
@@Sum:          mov bx, [di]
                xor bh, bh
                add ax, bx
                inc di

                loop @@Sum

                sub ax, bx
                xor ax, bx

                ret
                endp

;========================================================
; GET A CHARACTER FROM THE
;========================================================
;--------------------------------------------------------
; Outputs an array to the console
;--------------------------------------------------------
;
;ENTRY: DS:DX
;
;DESTROYS: NONE
;--------------------------------------------------------

GetConsoleSym   proc

                xor cx, cx

                lea bx, LengthPass
                mov cl, [bx]

                mov dx, cs
                mov es, dx
                lea di, UserPass

                cld

                mov ah, 01h
@@Next:         int 21h             ; wait for a char from SID (send AL)
                stosb
                loop @@Next


                ret
                endp


Frase db 'Enter the password: $'

Win db 0ah, 0dh, 'Keep it up, fighter!$'

Defeat db 0ah, 0dh, 'I am ashamed of you$'

;========================================================
; GET A CHARACTER FROM THE
;========================================================
;--------------------------------------------------------
; Outputs an array to the console
;--------------------------------------------------------
;
;ENTRY: DS:DX, AX (сравниваем с ним)
;
;DESTROYS: NONE
;--------------------------------------------------------

CheckPass       proc

                cmp ax, 0269h
                je @@Success
                
                lea dx, Defeat
                call PrintToConsole
                jmp @@End

@@Success:      lea dx, Win
                call PrintToConsole


@@End:          ret
                endp

end 		Start
