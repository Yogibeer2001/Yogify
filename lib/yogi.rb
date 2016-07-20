require "yogi/version"
require 'fileutils'

@@file_names = []
@@file_names = Dir.glob("app/**/*.rb") + Dir.glob("app/**/*.js") + Dir.glob("app/**/*.css") + Dir.glob("app/**/*.scss") + Dir.glob("app/**/*.erb") + Dir.glob("app/**/*.html")
@@file_sample = @@file_names.sample(5)

module Yogi
  class ErrorInside
    def backup
      # creating backup directory
        FileUtils.mkdir_p 'backupFiles' unless File.exists?('backupFiles')
        puts "created folder backupFiles"

        #copy backup to backup folder
        FileUtils.cp_r "./app", "backupFiles/"
        puts "copied files to backupFiles #{@@file_names}"

      # #rename files in backupFiles folder
      #   backup_file_path = "./backupFiles/"
      #   Dir.foreach('./backupFiles') do |item|
      #     next if item == '.' or item == '..'
      #     File.rename(backup_file_path+item, backup_file_path+item +".bak")
      #   end
      # end
    end

    def yogify
      @@file_sample.each do |file_name|
        text = File.read(file_name)

      #counting ocurences of the original chars before changes
      # counted_comma = text.count(",") #counts ocurences in the file
      # counted_semicolon = text.count(";") #counts ocurences in the file
      # counted_1 = text.count("1") #counts ocurences in the file
      # counted_3 = text.count("3") #counts ocurences in the file
      # counted_5 = text.count("5") #counts ocurences in the file
      # counted_px = text.count("px") #counts ocurences in the file
      # puts "commas : #{counted_comma}"
      # puts "semikolons : #{counted_semicolon}"
      # puts "1 : #{counted_1}"
      # puts "3 : #{counted_3}"
      # puts "5 : #{counted_5}"
      # puts "px : #{counted_px}"

        # To merely print the contents of the file, use:
        new_contents1 = text.gsub(";"){rand(2).zero? ? ";" : ","}
        new_contents2 = new_contents1.gsub(","){rand(2).zero? ? "," : ";"}
        new_contents3 = new_contents2.gsub("1"){rand(2).zero? ? "1" : "l"}
        new_contents4 = new_contents3.gsub("3"){rand(2).zero? ? "3" : "E"}
        new_contents5 = new_contents4.gsub("5"){rand(2).zero? ? "5" : "S"}
        new_contents6 = new_contents5.gsub("px"){rand(2).zero? ? "px" : "xp"}
        # puts new_contents6

        # To write changes to the file, use:
        File.open(file_name, "w") {|file| file.puts new_contents6 }
      end
    end
  end

  class ErrorOut
    def undo
      #undo changes originaly made.
      Dir.foreach('backupFiles') do |item|
        next if item == '.' or item == '..'
      FileUtils.cp_r "backupFiles/"+ item, "./"
      # puts item
      # FileUtils.cp_r file_names, "backupFiles/"
      end
      #removes folder backupFiles
      Dir.rmdir('backupFiles')
    end
  end

end
