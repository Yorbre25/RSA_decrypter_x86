import math
import PIL.Image as Image
denc_path = "output.txt "
enc_path = "input.txt"

def get_denc_pixel_values(path, list):
    with open(path, 'rb') as file:
        for line in file:
            numbers = line.strip().split()
            for num in numbers:
                list.append(int(num, 2))
        return list

def get_enc_pixel_values(path, list):
    with open(path, 'rb') as file:
        for line in file:
            numbers = line.strip().split()
            for num in numbers:
                list.append(int(num))
        return list    

        
enc_pic_values = []
denc_pic_values = []
get_enc_pixel_values(enc_path, enc_pic_values)
get_denc_pixel_values(denc_path, denc_pic_values)
# print(math.sqrt(len(enc_pic_values)))

# print(enc_pic_values)
# print(denc_pic_values)


denc_pic = Image.new('L', (320, 320))
denc_pic.putdata(enc_pic_values)
denc_pic.save("enc_pic.png")
denc_pic.close()

enc_pic = Image.new('L', (640, 320))
enc_pic.putdata(denc_pic_values)
enc_pic.save("denc_pic.png")
enc_pic.close()