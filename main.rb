require_relative 'Window.rb'
require "thread"
#Main de nuestro programa
rf = Rfid_mifare.new
window = Window.new
window.show_all

thr = Thread.new{	#Thread donde se realizara la lectura del ID
	while true do
		uid = rf.readUid
		window.change_label("Uid: " + uid, 'red')
	end
}
window.signal_connect("delete-event") {
	Gtk.main_quit
	thr.kill
}
Gtk.main
thr.join


