module SuperSync

  module Utilities

    module Folder
      def self.number_of_images(folder,file_extension)
        cc=0
        Dir.glob("#{folder}/**/*.#{file_extension}").each do |file|
          cc+=1
        end
        return cc
      end
      def self.available_card_slot(folder)
        ii=1
        while 1 do
          test_slot=File.join(folder,"card_#{ii}")
          if File.directory?(test_slot) 
            ii+=1
          else
            slot = test_slot
            # When missing it creates the parent folder containing all the imported cards (mkdir -p)
            FileUtils.mkdir_p(slot)
            return slot
            break
          end
        end
      end
    end

  # -------------------------------------------------
    module Cards
      def self.list(volumes,images_folder)
        dcim_list=[]
        Dir.glob("/#{volumes}/*").each do |volname|
          dcim=File.join(volname,images_folder)
          if File.directory?(dcim)
            dcim_list.push(dcim)
          end
        end
        return dcim_list
      end
    end

  # -------------------------------------------------
    module CLIdata
      def self.fetch()
        cli_data = Hash.new 
        print "Date: "
        cli_data[ "date" ] = gets.chomp
        print "Groom: "
        cli_data[ "groom" ] = gets.chomp
        print "Bride: "
        cli_data[ "bride" ] = gets.chomp
        cli_data[ "title" ] = "#{cli_data['date']} #{cli_data['groom']} e #{cli_data['bride']}"
        return cli_data
      end
    end
  # -------------------------------------------------
  end
end