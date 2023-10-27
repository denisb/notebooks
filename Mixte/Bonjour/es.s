@
@ fonctions d'entrees sorties
@ version 0 : aucune verification concernant les tailles des
@             representation n'est effectuee
@             on utilise uniquement les formats des fonctions de
@             la bibliotheque d'entrees/sorties C
@     il faudrait ameliorer la lecture et l'ecriture d'octets
@     qui pour l'instant se fait sur un demi-mot...
@ auteur : Fabienne Carrier
@ date creation : 10 mai 2003
@ modifications :
@ --> 29/10/03 : sauvegarde r2 et r3
@ Ajout : AlaLigne - EcrCar - EcrChn - EcrNdecim32 : Emeric Malevergne
@ Ajout : LireCar : Renaud Lachaize
@ Correction septembre 2011 : Alaligne modifiait r1 : Fabienne Carrier
@ Modification 2018 : relai_XXX devient LD_XXX : Denis B.
@ Ajout Fev 2019 : EcrHexa16 EcrHexa8 : Denis B.

	.global AlaLigne
	.global EcrCar
	.global EcrChn
	.global EcrChaine
	.global EcrHexa32
	.global EcrHexa16
	.global EcrHexa8
	.global EcrZdecimal32
	.global EcrZdecimal16
	.global EcrZdecimal8
	.global EcrNdecim32
	.global EcrNdecimal32
	.global EcrNdecimal16
	.global EcrNdecimal8
	.global Lire32
	.global Lire16
	.global Lire8
	.global LireCar

	.text


@ AlaLigne :
@    retour a la ligne
AlaLigne:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
      mov r1, #32
	   ldr r0, LD_f_alaligne
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrCar :
@    ecriture d'un caractère dont la valeur est dans r1
EcrCar:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, LD_fe_car
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrChn :
@    ecriture de la chaine sans retour à la ligne dont l'adresse est dans r1
EcrChn:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, LD_fe_chn
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrChaine :
@    ecriture de la chaine dont l'adresse est dans r1
EcrChaine:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, LD_fe_chaine
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrHexa32 :
@    ecriture d'un mot de 32 bits en hexadécimal
@    la valeur a afficher est dans r1
EcrHexa32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, LD_f_hexa_32
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

	@ EcrHexa16 :
@    ecriture d'un demi mot de 16 bits en hexadécimal
@    la valeur a afficher est dans les bit de poids faible de r1
EcrHexa16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
   and r1, r1, #0x00ffffff
   and r1, r1, #0xff00ffff
   ldr r0, LD_f_hexa_16
   bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrHexa8 :
@    ecriture d'un octet en hexadécimal
@    la valeur a afficher est dans l'octet de poids faible de r1
EcrHexa8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
   and r1, r1, #0x000000ff
   ldr r0, LD_f_hexa_8
   bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrZdecimalf32 :
@    ecriture en decimal d'un entier relatif represente sur 32 bits
@    l'entier est dans r1
EcrZdecimal32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, LD_fe_rel32
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrZdecimal16 :
@    ecriture en decimal d'un entier relatif represente sur 16 bits
@    l'entier est dans les 16 bits de poids faibles de r1
EcrZdecimal16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   ldr r0, LD_fe_rel16
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrZdecimal8 :
@    ecriture en decimal d'un entier relatif represente sur 8 bits
@    l'entier est dans les 8 bits de poids faibles de r1
@    attention : les bits 15 a 8 de r1 sont eventuellement modifies
EcrZdecimal8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
	sub     fp, ip, #4
	   tst r1, #0x00000080 @ bit7 ?
	   andeq r1, r1, #0xffff00ff
		orrne r1, r1, #0x0000ff00
	   ldr r0, LD_fe_rel16
      bl printf
	ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNdecim32 :
@    ecriture en decimal d'un entier naturel represente sur 32 bits
@    l'entier est dans r1
EcrNdecim32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, LD_fe_na32
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNdecimal32 :
@    ecriture en decimal d'un entier naturel represente sur 32 bits
@    l'entier est dans r1
EcrNdecimal32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, LD_fe_nat32
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNdecimal16 :
@    ecriture en decimal d'un entier naturel represente sur 16 bits
@    l'entier est dans les 16 bits de poids faibles de r1
EcrNdecimal16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, LD_fe_nat16
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ EcrNdecimal8 :
@    ecriture en decimal d'un entier naturel represente sur 8 bits
@    l'entier est dans les 8 bits de poids faibles de r1
@    attention : les bits 15 a 8 de r1 sont mis a 0
EcrNdecimal8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
	   and r1, r1, #0xffff00ff
      ldr r0, LD_fe_nat16
      bl printf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ Lire32 :
@    lecture d'un entier represente sur 32 bits
@    l'adresse de l'entier doit etre donnee dans r1
Lire32:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, LD_fl_rel32
      bl scanf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ Lire16 :
@    lecture d'un entier represente sur 16 bits
@    l'adresse de l'entier doit etre donnee dans r1
Lire16:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
      ldr r0, LD_fl_rel16
      bl scanf
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ Lire8 :
@    lecture d'un entier represente sur 8 bits
@    l'adresse de l'entier doit etre donnee dans r1
Lire8:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
	   @ lecture dans la donnee DON sur 16 bits
      ldr r0, LD_fl_rel16
      ldr r1, LD_DON
      bl scanf
		@ recuperer le demi-mot lu 
		ldr r1, LD_DON
		ldrh r0, [r1]
		@ et le stocker ou on l'attend
		@ l'adresse etait dans r1 empile en debut de procedure
		@ d'ou on recupere r1 dans la pile
      ldr r1, [fp, #-24]
		strb r0, [r1]
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc}

@ LireCar :
@    lecture d'un caractere tape au clavier
@    l'adresse du caractere (code en ascii) doit etre donnee dans r1
LireCar:
   mov ip, sp
   stmfd sp!, {r0, r1, r2, r3, fp, ip, lr, pc}
   sub     fp, ip, #4
     bl getchar
     ldr r1, [fp, #-24]
     strb r0, [r1]
   ldmea fp, {r0, r1, r2, r3, fp, sp, pc} 

LD_f_alaligne: .word f_alaligne
LD_fe_car: .word fe_car
LD_fe_chn: .word fe_chn
LD_fe_chaine: .word fe_chaine
LD_f_hexa_32: .word f_hexa_32
LD_f_hexa_16: .word f_hexa_16
LD_f_hexa_8: .word f_hexa_8
LD_fe_rel32: .word fe_rel32
LD_fe_rel16: .word fe_rel16
LD_fe_na32: .word fe_na32
LD_fe_nat32: .word fe_nat32
LD_fe_nat16: .word fe_nat16
LD_fl_rel32: .word fl_rel32
LD_fl_rel16: .word fl_rel16

LD_DON: .word DON  @ acces a la zone data

	.data

@ definition des formats de lecture ecriture
f_alaligne: .asciz "%c\n"
fe_car: .asciz "%c"
fe_chn: .asciz "%s"
fe_chaine: .asciz "%s\n"
f_hexa_32: .asciz "%08x\n"
f_hexa_16: .asciz "%04x\n"
f_hexa_8: .asciz "%02x\n"
fe_rel32: .asciz  "%d\n"
fe_rel16: .asciz  "%hd\n"
fe_na32: .asciz  "%u"
fe_nat32: .asciz  "%u\n"
fe_nat16: .asciz  "%hu\n"
fl_rel32: .asciz  "%d"
fl_rel16: .asciz  "%hd"

          .balign 4
@ pour la fonction Lire8
DON: .word 0
