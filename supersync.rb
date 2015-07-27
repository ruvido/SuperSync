#!/usr/bin/ruby

# ================================
dcimlist	=	[]
proj 		=	''
configdir	=	'/Users/ruvido/Dropbox/.supersync'
storage 	= 	''
# ================================

# ----------------------------------------------
# Create config directory if it doesn't exist
# ----------------------------------------------
Dir.mkdir(configdir) unless File.directory?(configdir)

configfile=configdir+"/config"

if File.file?(configfile)
	config = File.read(configfile)
	config.split("\n").each do |line|
		k,v=line.split(":")
		if k =~ /Storage/
			storage= v.strip
		end
	end
end

# ----------------------------------------------
# Print menu dialog
# ----------------------------------------------
puts ""
puts "SuperSync"
puts ""
puts "[1] to create a new project"
puts "[2] to update files to your last project"
puts "[3] to update files to an existing project"
puts ""

# choice = $stdin.readline()
choice = gets.chomp

case choice
when "1"
	puts "Project name:"
	proj = gets.chomp
when "2"
	puts 2
when "3"
	puts 3
else
	puts "Please choose one of the three options"
	puts "Exiting"
	exit
end

puts proj
exit


Dir.glob("/Volumes/*").each do |volname|
		dcim=volname+"/DCIM"
		if File.directory?(dcim)
			dcimlist.push(dcim)
		end
end

puts dcimlist