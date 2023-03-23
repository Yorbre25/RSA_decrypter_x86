# ybrenes_computer_architecture_1_2023

*Desencriptador de Rivest-Shamir-Adleman (RSA)*
En criptografía, RSA es un sistema criptográfico de clave pública que utiliza factorización de números 
enteros. Es el primer y más utilizado algoritmo de este tipo y es válido tanto para cifrar como para 
firmar digitalmente.

El programa consiste en un desencriptador RSA de imagenes desarrollado en x86-64. El programa recibe
como entrada un archivollamado "input.txt", que tiene los datos cifrados. Al correr el programa se 
solicita el valor de la clave privada.
El programa desencripta el archivo y lo guarda en un archivo llamado "output.txt". Finalmente, 
la imagen encriptada y desencriptada son desplegadas en pantalla. Esto se hizo a través del lenguaje
de programación Python.

Para ejecutar la formula de desencriptado se utilizo la exponenciación modular con el fin de reducir
tiempo de ejecuión y uso de memoria.


Para ejecutar el programa se debe tener instalado Python 3.8.5 y el modulo PIL (Python Image Library).
Corra el archivo displayPic.py para ejecutar el programa.