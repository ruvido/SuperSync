module SuperSync

  class Messages

# ----------------------------------------------------
    def initialize(project)
      @title  = project.title
      @target = project.target
      @raw_format = project.raw_format
      no=SuperSync::Utilities::Folder.number_of_images(@target,@raw_format)

      puts ""
      puts ""
      # printf "%40s :: %s\n", 'Project name', @title
      # printf "%40s :: %5d images\n", '', no
      printf "%40s :: %-5d images\n", @title, no
      puts ""
      # printf "%40s :: \n", ''
    end

# ----------------------------------------------------
    def info_cards(list)
      noto=0
      list.each do |cc|
        no=SuperSync::Utilities::Folder.number_of_images(cc,@raw_format)
        printf "%40s :: %-5d images\n", cc, no
        noto+=no
      end
      printf "%40s :: %-5d images\n", 'Total', noto
      puts ""
    end

    # def update_copying_status(card,slot)
    # end

  end

end


