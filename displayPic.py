import math
import PIL.Image 
from PIL import ImageTk, Image
import tkinter as tk
from tkinter import *
import os

# Archivos con los datos de las imagenes
denc_path = "output.txt "
enc_path = "input.txt"

# Funciones para obtener los valores de los pixeles de las imagenes

# Se obtienen los valores de los pixeles de la imagen codificada
def get_denc_pixel_values(path, list):
    with open(path, 'rb') as file:
        for line in file:
            numbers = line.strip().split()
            for num in numbers:
                list.append(int(num, 2))
        return list

# Se obtienen los valores de los pixeles de la imagen decodificada 
# y se convierten a decimal
def get_enc_pixel_values(path, list):
    with open(path, 'rb') as file:
        for line in file:
            numbers = line.strip().split()
            for num in numbers:
                list.append(int(num))
        return list

# Funcion para crear las imagenes
def make_pics():
    enc_pic_values = []
    denc_pic_values = []
    get_enc_pixel_values(enc_path, enc_pic_values)
    get_denc_pixel_values(denc_path, denc_pic_values)

    denc_pic = PIL.Image.new('L', (640, 960))
    denc_pic.putdata(enc_pic_values)
    denc_pic.save("enc_pic.png")
    denc_pic.close()

    enc_pic = PIL.Image.new('L', (640, 480))
    enc_pic.putdata(denc_pic_values)
    enc_pic.save("denc_pic.png")
    enc_pic.close()    


os.remove(denc_path)
os.system("nasm -felf64 -o main.o main.asm")
os.system("ld -o main main.o")
os.system("./main")

make_pics()

# Crear la ventana y colocar imagenes
window = tk.Tk()
window.geometry("1280x960")

frame = Frame(window, width=600, height=400)
frame.pack()
frame.place(anchor='center', relx=0.5, rely=0.5)

# Create an object of tkinter ImageTk
enc_img = ImageTk.PhotoImage(ImageTk.Image.open("enc_pic.png"))
denc_img = ImageTk.PhotoImage(ImageTk.Image.open("denc_pic.png"))

# Create a Label Widget to display the text or Image
enc_label = Label(frame, image = enc_img)
enc_label.grid(row=0, column=0)

denc_label = Label(frame, image = denc_img)
denc_label.grid(row=0, column=1)

window.mainloop()