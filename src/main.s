.area _DATA
.area _CODE

;;
;; Plantilla de datos iniciales de un copo
;;
plantilla_copo:
   .db 25,    0   ;; ( X,   Y  ) Coordenadas de pantalla
   .db  1, 0xF0  ;; (VY, Color) Velocidad en Y, Color del copo

mi_simbolo:

contador_de_copos:
   .db 0

tam_copo = mi_simbolo-plantilla_copo ;; tamaño copo

max_copos = 10

reserva_bytes= tam_copo*max_copos

tam_array:
   .ds #reserva_bytes

init_entidades::
   ld hl, #tam_array
   ;;ld (hl), #0x77 ;; llenar de 77s
   ld de, #tam_array+1
   ld bc, #reserva_bytes-1
   ldir
   ret

init_val_copo::
   push de
   ld hl, #plantilla_copo
   ld bc, #tam_copo
   ldir
   pop de
   ret

init_val_array_in_copo::
   add hl, hl
   add hl, hl
   ld  bc ,#tam_array
   add hl, bc
   ex de, hl
   call init_val_copo
   ret

create_copo_in_array::
   ld a, (contador_de_copos)
   ld h, #0
   ld l, a
   call init_val_array_in_copo
   ld a, (contador_de_copos)
   inc a
   ld (contador_de_copos),a
   ret


;;---------------------------------------------------------------
;; MAIN
;;---------------------------------------------------------------
_main::
   call init_entidades
   jr .