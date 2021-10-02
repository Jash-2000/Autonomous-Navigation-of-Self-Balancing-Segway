import cv2
import numpy as np

flag = 0

path = "../Maps/"
choice = input("\n Enter e, m, h and b for easy/medium/hard and Blank level map analysis : ")

if (choice == "m"):
	img_path = path + "med.png"
	file_path = path + "med.map"

elif(choice == "e"):
	img_path = path + "easy.png"
	file_path = path + "easy.map"
	
elif(choice == "c"):
	img_path = path + "custom.png"
	file_path = path + "custom.map"
elif(choice == "b"):
	flag = 1
	print("You will get a blank map now")
else :
	img_path = path + "hard.png" 
	file_path = path + "hard.map"
	
if(flag == 0):
	img = cv2.imread(img_path)


def showImg():
	win_name = "Original Map"  
	cv2.namedWindow(win_name, cv2.WINDOW_NORMAL)
	h,w = img.shape[:2]
	h = int(h / 2)  
	w = int(w / 2)  
	cv2.resizeWindow(win_name, w, h)  
	cv2.imshow(win_name, img)
	cv2.waitKey(0)

def Padding(Map, h, w):
	
	if (abs(h-w)/2 == abs(h-w) // 2):
		pad_amount_1 = abs(h-w)/2
		pad_amount_2 = abs(h-w)/2
	else:
		pad_amount_1 = abs(h-w)/2 - 0.5
		pad_amount_2 = abs(h-w)/2 + 0.5

	if(h>w):
		column_to_be_added = []
		for i in range(h):
			column_to_be_added.append("@")
		column_to_be_added = np.array(column_to_be_added)

		count = pad_amount_1
		while(count >0):
			Map = np.column_stack((column_to_be_added, Map))
			count = count-1		

		count = pad_amount_2
		while(count >0):
			Map = np.column_stack((Map, column_to_be_added))
			count = count-1
		pad = h
	

	else:
		row_to_be_added = []
		for i in range(h):
			row_to_be_added.append('@')
		row_to_be_added = np.array(row_to_be_added)

		count = pad_amount_1
		while(count >0):
			Map = np.row_stack((row_to_be_added, Map))
			count = count-1		

		count = pad_amount_2
		while(count >0):
			Map = np.row_stack((Map, row_to_be_added))
			count = count-1
		
		pad = w

	return Map, pad

def split(word):
    return [char for char in word]

def getDetails():
	f = open(file_path, "r")
	Map = []
	R = []
	for num,x in enumerate(f):
		if(num == 0 or num == 3):
			pass
		
		elif (num == 1) :
			height = int(x[-3:-1])

		elif (num == 2) :
			width = int(x[-3:-1])
		
		else :
			R = split(x)
			R = R[:-1]
			print(R)
			R = np.array(R)
			Map.append(R)

	Map = np.array(Map)
	Map, pad = Padding(Map, height, width)
		
	print("\n\n The Original dimmensions were : ", height, "\t", width)
	print("\n\n After Padding,: ", pad, "\t", pad)
	
	return Map, pad

if flag ==0:
	showImg()
