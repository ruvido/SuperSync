#!/usr/bin/ruby
require 'FileUtils'
# ================================
dcimlist	=	[]
proj 		=	''
configdir	=	'/Users/ruvido/Dropbox/.supersync'
storage 	= 	''
sddest		=	''
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
# Print menu dialog and read choice made
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
	# puts "Project name:"
	# proj = storage + "/" + gets.chomp
	print "Date: "
	wdate = gets.chomp
	print "Groom: "
	groom = gets.chomp
	print "Bride: "
	bride = gets.chomp
	projtitle=wdate+" "+groom+" e "+bride
	proj = storage + "/" + projtitle
	if File.directory?(proj)
		puts "No way this project already exits"
		puts "Exiting"
		exit
	else
		puts "This project will be copied to "+storage
		Dir.mkdir(proj)
		sddest=proj+"/originals"
		Dir.mkdir(sddest)
		Dir.mkdir(proj+"/exports")
		Dir.mkdir(proj+"/exports"+"/1_whatsapp")
		Dir.mkdir(proj+"/exports"+"/2_facebook")
		Dir.mkdir(proj+"/exports"+"/3_squares")
		Dir.mkdir(proj+"/exports"+"/4_print")
		Dir.mkdir(proj+"/exports"+"/4_print/color")
		Dir.mkdir(proj+"/exports"+"/4_print/black&white")
		Dir.mkdir(proj+"/exports"+"/5_book")
		FileUtils.cp_r configdir+'/template.lrcat', proj+'/'+projtitle+'.lrcat' 
		File.write(configdir+'/latest', proj)
	end
when "2"
	proj = File.read(configdir+"/latest")
	sddest=proj+"/originals"
	puts "This project will be updated to "+sddest


when "3"
	puts "Enter full path"
	proj = gets.chomp
	sddest=proj+"/originals"

else
	puts "Please choose one of the three options"
	puts "Exiting"
	exit
end

total_images=Dir[File.join(sddest, '**', '*')].count { |file| File.file?(file) }
puts "-----------------------------------------------"
print total_images
puts  " already present in this project"

puts "==============================================="
puts ""
puts " Detected cards:"
Dir.glob("/Volumes/*").each do |volname|
		dcim=volname+"/DCIM"
		if File.directory?(dcim)
			puts " "+dcim
			dcimlist.push(dcim)
		end
end
puts ""

puts "==============================================="
imported_images=0
dcimlist.each do |card|

	n_images=Dir[File.join(card, '**', '*')].count { |file| File.file?(file) }
	imported_images+=n_images

	print n_images, " images\t", ' from ', card

	ii=1
	while 1 do
		slotname = sddest+"/"+'scheda_'+ii.to_s
		if File.directory?(slotname) 
			ii+=1
		else
			# puts sddest+"/"+slotname
			Dir.mkdir(slotname)
			print ' to ', slotname
			FileUtils.cp_r card, slotname
			puts ' copied!'
			break
		end
	end
end
puts "-----------------------------------------------"
print imported_images
puts  " images imported"

total_images=Dir[File.join(sddest, '**', '*')].count { |file| File.file?(file) }
puts "-----------------------------------------------"
print total_images
puts  " total images imported in project"
puts "==============================================="
puts ""

# ===============================================
# TODO:
# - it doesnt check for duplicates, it can replicate entire directories
# ===============================================




