org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A ; nasm macro for new line character


start: 
    jmp main

;
; Prints a string to the screen
; Params: 
;   - ds:si points to string  
puts:
    ; save registers we will modify
    push si
    push ax
    
.loop:
    lodsb           ; load next charater in al
    or al, al       ; check for null chatacter
    jz .done        ; if char is null, exit

    mov ah, 0x0E    ; tells that we need to put char on the screen
    int 0x10        ; video interupt to put something on the screen
    
    jmp .loop

.done
    pop ax          ;get back the registers 
    pop si
    ret

main: 

    ; setup data segment
    mov ax, 0       ; shinanigan cuz cantwrite to ds directly 
    mov ds, ax
    mov es, ax

    ; stack setup
    mov ss, ax
    mov sp, 0x7C00  ; stack pointer

    ; print message
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt

msg_hello: db 'Hello world!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h