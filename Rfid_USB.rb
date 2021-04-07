#  Test.rb
#  
#  Copyright 2021  <pi@raspberrypi>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
require 'io/console'

class Rfid_mifare
	def readUid
		uid = STDIN.noecho(&:gets).chomp.to_i  #Lee el numero introducido mediante el lector de targetas y lo almacena en un string. La funcion chomp se encarga de borrar el salto de línea. to_i pasa el string a un entero
		uid_hex = uid.to_s(16) #Pasa el entero a un string con los numeros en la base puesta entre parentesis (en nuestro caso, hexadecimal)
		if uid_hex.length <= 7 #Añado este condicional para asegurarme de que el uid es de 8 dígitos
			uid_hex = "0" + uid_hex
		end
		return uid_hex		
	end
end
if __FILE__ == $0
	rf = Rfid_mifare.new
	puts "Escanea tu targeta"
	uid = rf.readUid
	puts"Tu id es: "
	puts uid.upcase
end

