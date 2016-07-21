require "yogi/version"
require 'fileutils'

$file_names = []
$file_names = Dir.glob("app/**/*.rb") + Dir.glob("app/**/*.js") + Dir.glob("app/**/*.css") + Dir.glob("app/**/*.scss") + Dir.glob("app/**/*.erb") + Dir.glob("app/**/*.html")
$file_sample = $file_names.sample(5)
$pre_counted_comma = 0
$pre_counted_semicolon = 0
$pre_counted_l = 0
$pre_counted_3 = 0
$pre_counted_s = 0
$pre_counted_bracket = 0
$pre_counted_px = 0

$pre_diff_comma = 0
$pre_diff_semicolon = 0
$pre_diff_l = 0
$pre_diff_3 = 0
$pre_counted_s = 0
$pre_diff_bracket = 0
$pre_diff_px = 0

module Yogi

  def count_em(text, substring)
    text.scan(/(?=#{substring})/).count
  end

  class ErrorInside

    def count_em(text, substring)
      text.scan(/(?=#{substring})/).count
    end

    def backup
      # creating backup directory
        FileUtils.mkdir_p '.backupFiles' unless File.exists?('.backupFiles')
        # puts "created folder backupFiles"

        #copy backup to backup folder
        FileUtils.cp_r "./app", ".backupFiles/"
        # puts "copied files to backupFiles #{$file_names}"

      # #rename files in backupFiles folder
      #   backup_file_path = "./backupFiles/"
      #   Dir.foreach('./backupFiles') do |item|
      #     next if item == '.' or item == '..'
      #     File.rename(backup_file_path+item, backup_file_path+item +".bak")
      #   end
      # end
    end

    def yogify
      $file_sample.each do |file_name|
        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)
        # puts "editing #{$file_sample}"

        $pre_counted_comma = count_em(text,",")
        $pre_counted_semicolon = count_em(text,";")
        $pre_counted_l = count_em(text,"l")
        $pre_counted_3 = count_em(text,"3")
        $pre_counted_s = count_em(text,"s")
        $pre_counted_bracket = count_em(text,"}")
        $pre_counted_px = count_em(text,"px")

        # puts "commas : #{$pre_counted_comma}"
        # puts "semicolons : #{$pre_counted_semicolon}"
        # puts "l : #{$pre_counted_l}"
        # puts "3 : #{$pre_counted_3}"
        # puts "s : #{$pre_counted_s}"
        # puts "} : #{$pre_counted_bracket}"
        # puts "px : #{$pre_counted_px}"

        #counts total symbols to be effected
        # pre_total = pre_counted_comma + pre_counted_semicolon + pre_counted_l + pre_counted_3 + pre_counted_s + pre_counted_bracket + pre_counted_px
        # puts pre_total

        # To merely print the contents of the file, use:
        new_contents1 = text.gsub(";"){rand(2).zero? ? ";" : ","}
        new_contents2 = new_contents1.gsub(","){rand(2).zero? ? "," : ";"}
        new_contents3 = new_contents2.gsub("l"){rand(2).zero? ? "l" : "1"}
        new_contents4 = new_contents3.gsub("3"){rand(2).zero? ? "3" : "E"}
        new_contents5 = new_contents4.gsub("s"){rand(2).zero? ? "s" : "5"}
        new_contents6 = new_contents5.gsub("}"){rand(2).zero? ? "}" : "]"}
        new_contents7 = new_contents6.gsub("px"){rand(2).zero? ? "px" : "xp"}

        # puts new_contents6

        # To write changes to the file, use:
        File.open(file_name, "w") {|file| file.puts new_contents7 }

        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)
        # puts text
        #counts ocurences in the file after initial change
        post_counted_comma = count_em(text,",")
        post_counted_semicolon = count_em(text,";")
        post_counted_l = count_em(text,"l")
        post_counted_3 = count_em(text,"3")
        post_counted_s = count_em(text,"s")
        post_counted_bracket = count_em(text,"}")
        post_counted_px = count_em(text,"px")

        # puts "commas : #{post_counted_comma}"
        # puts "semicolons : #{post_counted_semicolon}"
        # puts "l : #{post_counted_l}"
        # puts "3 : #{post_counted_3}"
        # puts "s : #{post_counted_s}"
        # puts "} : #{post_counted_bracket}"
        # puts "px : #{post_counted_px}"
        #counts total symbols to be effected
        # post_total = post_counted_comma + post_counted_semicolon + post_counted_l + post_counted_3 + post_counted_s + post_counted_bracket + post_counted_px
        # puts post_total

        $pre_diff_comma = $pre_counted_comma - post_counted_comma
        $pre_diff_semicolon = $pre_counted_semicolon - post_counted_semicolon
        $pre_diff_l = $pre_counted_l - post_counted_l
        $pre_diff_3 = $pre_counted_3 - post_counted_3
        $pre_diff_s = $pre_counted_s - post_counted_s
        $pre_diff_bracket = $pre_counted_bracket - post_counted_bracket
        $pre_diff_px = $pre_counted_px - post_counted_px

        # puts "commas : #{$pre_diff_comma}"
        # puts "semicolons : #{$pre_diff_semicolon}"
        # puts "l : #{$pre_diff_l}"
        # puts "3 : #{$pre_diff_3}"
        # puts "s : #{$pre_diff_s}"
        # puts "} : #{$pre_diff_bracket}"
        # puts "px : #{$pre_diff_px}"

      end
    end
  end

  class CheckErrors

    def count_em(text, substring)
      text.scan(/(?=#{substring})/).count
    end

    def checker
      $file_sample.each do |file_name|
        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)
        post_counted_comma = count_em(text,",")
        post_counted_semicolon = count_em(text,";")
        post_counted_l = count_em(text,"l")
        post_counted_3 = count_em(text,"3")
        post_counted_s = count_em(text,"s")
        post_counted_bracket = count_em(text,"}")
        post_counted_px = count_em(text,"px")

        # puts "commas : #{post_counted_comma}"
        # puts "semicolons : #{post_counted_semicolon}"
        # puts "l : #{post_counted_l}"
        # puts "3 : #{post_counted_3}"
        # puts "s : #{post_counted_s}"
        # puts "} : #{post_counted_bracket}"
        # puts "px : #{post_counted_px}"
puts ($pre_counted_comma).class
puts (post_counted_comma).class
        post_diff_comma = $pre_counted_comma - post_counted_comma
        post_diff_semicolon = $pre_counted_semicolon - post_counted_semicolon
        post_diff_l = $pre_counted_l - post_counted_l
        post_diff_3 = $pre_counted_3 - post_counted_3
        post_diff_s = $pre_counted_s - post_counted_s
        post_diff_bracket = $pre_counted_bracket - post_counted_bracket
        post_diff_px = $pre_counted_px - post_counted_px

        if $pre_diff_comma == 0
          comma_fix = 100
        else
        comma_fix = (($pre_diff_comma - post_diff_comma)/$pre_diff_comma)*100
        end
        puts " #{comma_fix}% of comma errors fixed"

        if $pre_diff_semicolon == 0
           semicolon_fix = 100
        else
        semicolon_fix = (($pre_diff_semicolon - post_diff_semicolon)/$pre_diff_semicolon)*100
        end
        puts " #{semicolon_fix}% of comma errors fixed"

        if $pre_diff_l == 0
           l_fix = 100
        else
        l_fix = (($pre_diff_l - post_diff_l)/$pre_diff_l)*100
        end
        puts " #{l_fix}% of comma errors fixed"

        if $pre_diff_3 == 0
           three_fix = 100
        else
        three_fix = (($pre_diff_3 - post_diff_3)/$pre_diff_3)*100
        end
        puts " #{three_fix}% of comma errors fixed"

        if $pre_diff_s == 0
           s_fix = 100
        else
        s_fix = (($pre_diff_s - post_diff_s)/$pre_diff_s)*100
        end
        puts " #{s_fix}% of comma errors fixed"

        if $pre_diff_bracket == 0
           bracket_fix = 100
        else
        bracket_fix = (($pre_diff_bracket - post_diff_bracket)/$pre_diff_bracket)*100
        end
        puts " #{bracket_fix}% of comma errors fixed"

        if $pre_diff_px == 0
           px_fix = 100
        else
        px_fix = (($pre_diff_px - post_diff_px)/$pre_diff_px)*100
        end
        puts " #{px_fix}% of comma errors fixed"
      end
    end
  end





  class ErrorOut
    def undo
      #undo changes originaly made.
      Dir.foreach('.backupFiles') do |item|
        next if item == '.' or item == '..'
      FileUtils.cp_r ".backupFiles/"+ item, "./"
      # puts item
      # FileUtils.cp_r file_names, "backupFiles/"
      end
      #removes folder backupFiles
      FileUtils.rm_r '.backupFiles'
    end
  end

end
