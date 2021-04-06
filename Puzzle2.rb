#  Puzzle2.rb
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
require "gtk3"
require_relative "Rfid_USB"
require "thread"

class Window < Gtk::Window
	def initialize
		super()
		#Se crea la ventana 
		set_title("Uid Scanner")
		set_size_request(500,100)
		set_border_width(5)
		move(600,400)
		
		#Utilizamos el css para poder utilizar los colores
		provider = Gtk::CssProvider.new
		provider.load(data: "label {background-color: blue;}")
		
		#Si se cierra la ventana, se acaba el programa
		signal_connect("delete-event") {Gtk.main_quit}
		
		#Se crea la caja que contendra los widgets y la añadimos a la ventana
		box=Gtk::Box.new(:vertical, 5)
		add(box)
		
		#Creamos el boton clear
		button = Gtk::Button.new(:label => "Clear")
		
		
		#Creamos el texto donde pedira escanear la tarjeta 
		label = Gtk::Label.new('Please, login with your university card')
		
		#Se añaden los widgets a la caja
		box.pack_start(label,:expand=> true,:fill=> true,:padding=>0)
		box.pack_start(button,:expand=> true,:fill=> true,:padding=>0)
		label.style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
		#Describimos lo que ocurrira al pulsar el botón
		button.signal_connect("clicked") {
			if @ACK == 1
				label.set_label("Please, login with your university card")
				#Cambiamos el color de rojo a azul
				provider.load(data: "label {background-color: blue;}")
				label.style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
			end
		}
		

		#Creamos una variable que indicara si hemos leido o no la tarjeta (0: No, 1: Si)
		@ACK = 0;
		#Creamos el thread donde se ejecutará el read_uid
		thread = Thread.new{
			read_uid
		}
	end
	def read_uid
		@ACK = 0
		rf = Rfid_mifare.new
		uid = rf.readUid
		#Se ha leido una tarjeta
		@ACK = 1
		label.set_label(uid)
		provider.load(data: "label {background-color: red;}")
		label.style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
		
	end
end
if __FILE__ == $0
	window = Window.new
	window.show_all
	Gtk.main
end

