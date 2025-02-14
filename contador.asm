section .data
    mensaje db "Contador=", 0  ; Mensaje a mostrar antes del número
    salto db 10, 0             ; Salto de línea

section .bss
    contador resb 1            ; Variable para el contador

section .text
    global _start

_start:
    mov byte [contador], 5      ; Inicializamos el contador en 5

loop_inicio:
    ; Imprimir mensaje "Contador="
    mov eax, 4                 ; syscall write
    mov ebx, 1                 ; file descriptor (stdout)
    mov ecx, mensaje           ; dirección del mensaje
    mov edx, 9                 ; longitud del mensaje
    int 0x80                   ; llamada al sistema

    ; Convertir el valor del contador a carácter ASCII
    mov al, [contador]         
    add al, '0'                ; Convertir número a ASCII
    mov [contador], al

    ; Imprimir el valor del contador
    mov eax, 4
    mov ebx, 1
    mov ecx, contador
    mov edx, 1
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Restaurar el valor numérico del contador
    mov al, [contador]
    sub al, '0'
    mov [contador], al

    ; Decrementar el contador
    dec byte [contador]
    cmp byte [contador], -1     ; Comparar con -1 para incluir el 0 en la salida
    jne loop_inicio

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
