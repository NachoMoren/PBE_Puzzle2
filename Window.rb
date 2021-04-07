require "gtk3"
require_relative "Rfid_USB"


class Window < Gtk::Window
	def initialize #Creamos el constructor de la ventana
		super()
		#Se crea el texto, el boton clear y la caja
		@box = Gtk::Box.new(:vertical, 5)
		@label = Gtk::Label.new("Please, login with your university card")
		@clear = Gtk::Button.new(:label => "Clear")
		#Se crea la ventana 
		set_title("Uid Scanner")
		set_size_request(500,100)
		set_border_width(5)
		set_window_position(:center)
		
		#Si se cierra la ventana, se acaba el programa
		signal_connect("delete-event") {Gtk.main_quit}
		
		#Añadimos la caja a la ventana y le añadimos también los elementos que iran dentro
		add(@box)
		#Se añaden los widgets a la caja
		@box.pack_start(@label,:expand=> true,:fill=> true,:padding=>0)
		@box.pack_start(@clear,:expand=> true,:fill=> true,:padding=>0)
		@label.override_background_color(0,Gdk::RGBA::new(0,0,1,1))
		@label.override_color(0,Gdk::RGBA::new(1,1,1,1))
		
		#Se describe lo que ocurrira al pulsar el clear
		@clear.signal_connect("clicked") do
			change_label('Please, login with your university card','blue')
		end
	end
	def change_label(text, color)
	#Este metodo sirve para actualizar el texto y el fondo del label
		@label.set_markup(text)
		if (color == 'blue')
			@label.override_background_color(0,Gdk::RGBA::new(0,0,1,1))
		end
		if (color == 'red')
			@label.override_background_color(0,Gdk::RGBA::new(1,0,0,1))
		end
	end
end




