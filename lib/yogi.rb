require 'rubygems'
require "yogi/version"
require 'fileutils'
require 'json'
require 'os'
require 'shellwords'

module Yogi

  class Setup
    def setup
      $file_names = []
      $file_names = Dir.glob("app/**/*.rb") + Dir.glob("app/**/*.js") + Dir.glob("app/**/*.css") + Dir.glob("app/**/*.scss") + Dir.glob("app/**/*.erb") + Dir.glob("app/**/*.html") + Dir.glob("config/routes.rb")
      $sample_size = 7
      $file_sample = $file_names.sample($sample_size)
      File.open('.git/.ignoremefile.txt', "a") {|file| file.puts $file_sample.to_json}
    end
  end

  $pre_counted_comma = 0
  $pre_counted_semicolon = 0
  $pre_counted_l = 0
  $pre_counted_3 = 0
  $pre_counted_s = 0
  $pre_counted_bracket = 0
  $pre_counted_px = 0
  $pre_counted_sq_bracket = 0
  $pre_counted_equal = 0

  $pre_diff_comma = 0
  $pre_diff_semicolon = 0
  $pre_diff_l = 0
  $pre_diff_3 = 0
  $pre_diff_s = 0
  $pre_diff_bracket = 0
  $pre_diff_px = 0
  $pre_diff_sq_bracket = 0
  $pre_diff_equal = 0

  class ErrorInside

    def count_em(text, substring)
      text.scan(/(?=#{substring})/).count
    end

    # creating backup directory
    def backup
        FileUtils.mkdir_p '.git/.backupFiles' unless File.exists?('.git/.backupFiles')
        # puts "created folder backupFiles"

        #copy backup to backup folder
        FileUtils.cp_r "./app", ".git/.backupFiles/"
        FileUtils.cp_r "./config", ".git/.backupFiles/"
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
      count_hash = []
      buffer = File.open('.git/.ignoremefile.txt', 'r').read
      file_sample = JSON.parse(buffer)
      # puts file_sample.class
      # puts file_sample

      file_sample.each do |file_name|
        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)
        # puts "editing #{$file_sample}"
        $pre_counted_comma = count_em(text,",")
        $pre_counted_semicolon = count_em(text,";")
        $pre_counted_l = count_em(text,"l")
        $pre_counted_3 = count_em(text,"3")
        $pre_counted_s = count_em(text,"s")
        $pre_counted_bracket = count_em(text,"}")
        $pre_counted_px = count_em(text,"px")
        $pre_counted_sq_bracket = count_em(text,">")
        $pre_counted_equal = count_em(text,"==")

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
        new_contents1 = text.gsub(";"){rand(2).zero? ? ";" : ":"}
        new_contents2 = new_contents1.gsub(","){rand(2).zero? ? "," : " "}
        new_contents3 = new_contents2.gsub("l"){rand(2).zero? ? "l" : "1"}
        new_contents4 = new_contents3.gsub("3"){rand(2).zero? ? "3" : "E"}
        new_contents5 = new_contents4.gsub(/[s]$/){rand(2).zero? ? " " : "5"}
        new_contents6 = new_contents5.gsub("}"){rand(2).zero? ? "}" : ")"}
        new_contents7 = new_contents6.gsub("px"){rand(2).zero? ? "px" : "xp"}
        new_contents8 = new_contents7.gsub(">"){rand(2).zero? ? "<" : "."}
        new_contents9 = new_contents8.gsub("=="){rand(2).zero? ? "==" : "="}

        # puts new_contents6

        # To write changes to the file, use:
        File.open(file_name, "w") {|file| file.puts new_contents8 }

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
        post_counted_sq_bracket = count_em(text,">")
        post_counted_equal = count_em(text,"==")

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
        $pre_diff_sq_bracket = $pre_counted_sq_bracket - post_counted_sq_bracket
        $pre_diff_equal = $pre_counted_equal - post_counted_equal

        pre_count_hash = {file_name => {
          "pre_counted_comma": $pre_counted_comma,
          "pre_counted_semicolon": $pre_counted_semicolon,
          "pre_counted_l": $pre_counted_l,
          "pre_counted_3": $pre_counted_3,
          "pre_counted_s": $pre_counted_s,
          "pre_counted_bracket": $pre_counted_bracket,
          "pre_counted_px": $pre_counted_px,
          "pre_counted_sq_bracket": $pre_counted_sq_bracket,
          "pre_diff_comma": $pre_diff_comma,
          "pre_diff_semicolon": $pre_diff_semicolon,
          "pre_diff_l": $pre_diff_l,
          "pre_diff_3": $pre_diff_3,
          "pre_diff_s": $pre_diff_s,
          "pre_diff_bracket": $pre_diff_bracket,
          "pre_diff_px": $pre_diff_px,
          "pre_diff_sq_bracket": $pre_diff_sq_bracket,
          "pre_diff_equal": $pre_diff_equal
        }}
          count_hash << pre_count_hash

        # puts "commas : #{$pre_diff_comma}"
        # puts "semicolons : #{$pre_diff_semicolon}"
        # puts "l : #{$pre_diff_l}"
        # puts "3 : #{$pre_diff_3}"
        # puts "s : #{$pre_diff_s}"
        # puts "} : #{$pre_diff_bracket}"
        # puts "px : #{$pre_diff_px}"

        # json_file = File.read(".ignoreme.json")
        # variable_hash = JSON.parse(json_file)
        # # counter_test = variable_hash[file_name]
        # puts "pre_counted_l schould be : #{variable_hash}"
      end
      File.open('.git/.ignoreme.json', "a") {|file| file.write count_hash.to_json}
      puts "You can start your debugging..."
      puts "if your are sick of it, just type...'fixme'"
      if OS.mac?
        file = File.join(__dir__, 'sound', 'activated.mp3')
        escfile = Shellwords.escape(file)
        cmd = "afplay #{escfile}"
        system cmd


      # cmd = ("say 'Debugging mode activated'")
      # exec cmd
      # cmd = ("afplay 'sound/activated.wav'")
      # exec cmd

      end
    end
  end

  class CheckErrors

    def count_em(text, substring)
      text.scan(/(?=#{substring})/).count
    end

    def checker
      i = 0
      pre_diff_array = []
      post_diff_array = []
      buffer = File.open('.git/.ignoremefile.txt', 'r').read
      file_sample = JSON.parse(buffer)
      # puts file_sample.class
      # puts file_sample

      file_sample.each do |file_name|
        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)


        post_counted_comma = count_em(text,",")
        post_counted_semicolon = count_em(text,";")
        post_counted_l = count_em(text,"l")
        post_counted_3 = count_em(text,"3")
        post_counted_s = count_em(text,"s")
        post_counted_bracket = count_em(text,"}")
        post_counted_px = count_em(text,"px")
        post_counted_sq_bracket = count_em(text,">")
        post_counted_equal = count_em(text,"==")

        json_file = File.read(".git/.ignoreme.json")
        variable_hash = JSON.parse(json_file)

        $pre_counted_comma = variable_hash[i][file_name]['pre_counted_comma']
        $pre_counted_semicolon = variable_hash[i][file_name]['pre_counted_semicolon']
        $pre_counted_l = variable_hash[i][file_name]['pre_counted_l']
        $pre_counted_3 = variable_hash[i][file_name]['pre_counted_3']
        $pre_counted_s = variable_hash[i][file_name]['pre_counted_s']
        $pre_counted_bracket = variable_hash[i][file_name]['pre_counted_bracket']
        $pre_counted_px = variable_hash[i][file_name]['pre_counted_px']
        $pre_counted_sq_bracket = variable_hash[i][file_name]['pre_counted_sq_bracket']
        $pre_counted_equal = variable_hash[i][file_name]['pre_counted_equal']

        $pre_diff_comma = variable_hash[i][file_name]['pre_diff_comma']
        $pre_diff_semicolon = variable_hash[i][file_name]['pre_diff_semicolon']
        $pre_diff_l = variable_hash[i][file_name]['pre_diff_l']
        $pre_diff_3 = variable_hash[i][file_name]['pre_diff_3']
        $pre_diff_s = variable_hash[i][file_name]['pre_diff_s']
        $pre_diff_bracket = variable_hash[i][file_name]['pre_diff_bracket']
        $pre_diff_px = variable_hash[i][file_name]['pre_diff_px']
        $pre_diff_sq_bracket = variable_hash[i][file_name]['pre_diff_sq_bracket']
        $pre_diff_equal = variable_hash[i][file_name]['pre_diff_equal']
        i += 1
        post_diff_comma = $pre_counted_comma - post_counted_comma
        post_diff_semicolon = $pre_counted_semicolon - post_counted_semicolon
        post_diff_l = $pre_counted_l - post_counted_l
        post_diff_3 = $pre_counted_3 - post_counted_3
        post_diff_s = $pre_counted_s - post_counted_s
        post_diff_bracket = $pre_counted_bracket - post_counted_bracket
        post_diff_px = $pre_counted_px - post_counted_px
        post_diff_sq_bracket = $pre_counted_sq_bracket - post_counted_sq_bracket  
        post_diff_equal = $pre_counted_equal - post_counted_equal

        # total changes made in each file
        total_pre_diff = $pre_diff_comma + $pre_diff_semicolon + $pre_diff_l + $pre_diff_3 + $pre_diff_s + $pre_diff_bracket + $pre_diff_px + $pre_diff_sq_bracket + $pre_diff_equal

        # total changes not fixed
        total_post_diff = post_diff_comma + post_diff_semicolon + post_diff_l + post_diff_3 + post_diff_s + post_diff_bracket + post_diff_px + post_diff_sq_bracket + post_diff_equal

        pre_diff_array << total_pre_diff
        post_diff_array << total_post_diff

        # puts '--------------------------------------------------------------------'
        # puts "#{file_name}"
        # puts " total_pre_diff: #{total_pre_diff}"
        # puts " total_post_diff: #{total_post_diff}"
        # puts "post commas : #{post_counted_comma}"
        # puts "post semicolons : #{post_counted_semicolon}"
        # puts "post l : #{post_counted_l}"
        # puts "post 3 : #{post_counted_3}"
        # puts "post s : #{post_counted_s}"
        # puts "post } : #{post_counted_bracket}"
        # puts "post px : #{post_counted_px}"
        # puts  "pre_diff_comma: #{$pre_diff_comma} vs post_diff_comma: #{post_diff_comma}"
        # puts  "pre_diff_semicolon: #{$pre_diff_semicolon} vs post_diff_semicolon: #{post_diff_semicolon}"
        # puts  "pre_diff_l: #{$pre_diff_l} vs post_diff_l: #{post_diff_l}"
        # puts  "pre_diff_3: #{$pre_diff_3} vs post_diff_3: #{post_diff_3}"
        # puts  "pre_diff_s: #{$pre_diff_s} vs post_diff_s: #{post_diff_s}"
        # puts  "pre_diff_bracket: #{$pre_diff_bracket} vs post_diff_bracket: #{post_diff_bracket}"
        # puts  "pre_diff_px: #{$pre_diff_px} vs post_diff_px: #{post_diff_px}"
        # puts  "pre_counted_comma: #{$pre_counted_comma} vs post_counted_comma: #{post_counted_comma}"
        # puts  "pre_counted_semicolon: #{$pre_counted_semicolon} vs post_counted_semicolon: #{post_counted_semicolon}"
        # puts  "pre_counted_l: #{$pre_counted_l} vs post_counted_l: #{post_counted_l}"
        # puts  "pre_counted_3: #{$pre_counted_3} vs post_counted_3: #{post_counted_3}"
        # puts  "pre_counted_s: #{$pre_counted_s} vs post_counted_s: #{post_counted_s}"
        # puts  "pre_counted_bracket: #{$pre_counted_bracket} vs post_counted_bracket: #{post_counted_bracket}"
        # puts  "pre_counted_px: #{$pre_counted_px} vs post_counted_px: #{post_counted_px}"
        # puts '--------------------------------------------------------------------'

      #   if $pre_diff_comma == 0
      #     comma_fix = 100
      #   else
      #   comma_fix = (($pre_diff_comma - post_diff_comma)/$pre_diff_comma)*100
      #   end
      #   puts " #{comma_fix}% of comma errors fixed"
      #
      #   if $pre_diff_semicolon == 0
      #      semicolon_fix = 100
      #   else
      #   semicolon_fix = (($pre_diff_semicolon - post_diff_semicolon)/$pre_diff_semicolon)*100
      #   end
      #   puts " #{semicolon_fix}% of comma errors fixed"
      #
      #   if $pre_diff_l == 0
      #      l_fix = 100
      #   else
      #   l_fix = (($pre_diff_l - post_diff_l)/$pre_diff_l)*100
      #   end
      #   puts " #{l_fix}% of comma errors fixed"
      #
      #   if $pre_diff_3 == 0
      #      three_fix = 100
      #   else
      #   three_fix = (($pre_diff_3 - post_diff_3)/$pre_diff_3)*100
      #   end
      #   puts " #{three_fix}% of comma errors fixed"
      #
      #   if $pre_diff_s == 0
      #      s_fix = 100
      #   else
      #   s_fix = (($pre_diff_s - post_diff_s)/$pre_diff_s)*100
      #   end
      #   puts " #{s_fix}% of comma errors fixed"
      #
      #   if $pre_diff_bracket == 0
      #      bracket_fix = 100
      #   else
      #   bracket_fix = (($pre_diff_bracket - post_diff_bracket)/$pre_diff_bracket)*100
      #   end
      #   puts " #{bracket_fix}% of comma errors fixed"
      #
      #   if $pre_diff_px == 0
      #      px_fix = 100
      #   else
      #   px_fix = (($pre_diff_px - post_diff_px)/$pre_diff_px)*100
      #   end
      #   puts " #{px_fix}% of comma errors fixed"
      end
      # puts " pre_diff_array: #{pre_diff_array}"
      # puts " post_diff_array: #{post_diff_array}"


      #calulate the total differences to original and errors
      pre_diff = pre_diff_array.inject(0, :+)
      # puts "total of pre_diff #{pre_diff}"
      post_diff = post_diff_array.inject(0, :+)
      # puts "total of post_diff #{post_diff}"
      pre_diff = pre_diff.to_f
      post_diff = post_diff.to_f


      if pre_diff == 0
        puts 'there must have gone something wrong...no errors to begin with'
      else
      fixed_errors = pre_diff - post_diff
      fix = ((fixed_errors)/pre_diff)*100
      fix = fix.round(3)
      puts "================================="
      puts " You fixed #{fix}% of all the errors "
      puts " You fixed #{fixed_errors} errors, #{post_diff} more to go."
      puts "================================="
        if  OS.mac?
          file = File.join(__dir__, 'sound', 'oh-yeah.mp3')
          escfile = Shellwords.escape(file)
          cmd = "afplay #{escfile}"
          system cmd

        end
      end
    end
  end


  class ErrorOut
    def undo
      #undo changes originaly made.
      Dir.foreach('.git/.backupFiles') do |item|
        next if item == '.' or item == '..'
      FileUtils.cp_r ".git/.backupFiles/"+ item, "./"
      # puts item
        end
      #removes folder backupFiles
      FileUtils.rm_r '.git/.backupFiles'
      FileUtils.rm_r '.git/.ignoreme.json'
      FileUtils.rm_r '.git/.ignoremefile.txt'
      puts " Hope You had fun and try it again later."
      if OS.mac?
        file = File.join(__dir__, 'sound', 'Giving-up.mp3')
        escfile = Shellwords.escape(file)
        cmd = "afplay #{escfile}"
        system cmd
      end
    end
  end

end
