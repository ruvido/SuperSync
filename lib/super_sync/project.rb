module SuperSync

  class Project

    attr_accessor :title
    attr_accessor :root
    attr_accessor :target
    attr_accessor :raw_format

    def initialize (config,wedding_data)

      @title=wedding_data['title']
      @root=File.join(config['storage'],@title)
      @target=File.join(@root,config['target'])
      @raw_format=config['raw_format']

      if File.directory?(@root)
        @update=true
      else
        @update=false
        # Create project folder from template
        FileUtils.cp_r config['lightroom'], @root

        # Create target folder
        Dir.mkdir(@target)

        # Rename lightroom template catalog file
        template_catalog=Dir.glob("#{@root}/*.#{SuperSync::LR_CATALOG}")[0]
        catalog="#{@root}/#{wedding_data['title']}.#{SuperSync::LR_CATALOG}"
        FileUtils.mv template_catalog, catalog

        # Replace handles in lightroom smart collections
        bride=wedding_data['bride']
        groom=wedding_data['groom']
        Dir.glob("#{@root}/**/*.#{SuperSync::LR_COLLECT}") do |file|
          ff = File.read(file)
          ff.gsub!("XGROOM", groom)
          ff.gsub!("XBRIDE", bride)
          of=open(file, 'w')
          of.write(ff)
          of.close()
        end
      end

    end

    def import_from_cards(list_of_cards)

      # Count total number of images present on cards
      total_number_of_images=0
      list_of_cards.each do |card|
        total_number_of_images+=SuperSync::Utilities::Folder.number_of_images(card,@raw_format)
      end

      # Copy images on cards into the created card slot folder (see available_card_slot method)
      progress_bar = ProgressBar.create(:format => '%a |%b>>%i| %p%% %t Processed: %c from %C',:total => total_number_of_images, :autofinish => false)
      count=0
      list_of_cards.each do |card|
        slot=SuperSync::Utilities::Folder.available_card_slot(@target)

        slot_basename = Pathname.new(slot).basename
        # progress_bar.log "#{card} #{slot_basename}"
        plog="%40s :: %s" % [card,slot_basename]
        progress_bar.log plog


        Dir.glob("#{card}/**/*.#{@raw_format}") do |file|
          FileUtils.cp file, slot
          count+=1
          progress_bar.increment
        end
      end
      progress_bar.log ""
      plog="%40s :: %s" % ['Total imported',total_number_of_images]
      progress_bar.log plog

      noto=SuperSync::Utilities::Folder.number_of_images(@target,@raw_format)
      plog="%40s :: %s" % ['Total',noto]
      progress_bar.log plog
      progress_bar.log "\n"
      progress_bar.finish
      puts ""
      
    end

  end

end