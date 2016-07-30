require 'rubygems'
require "yogi/version"
require 'fileutils'
require 'json'
require 'os'
require 'shellwords'

module Yogi

  $pre_counted_comma = 0
  $pre_counted_semicolon = 0
  $pre_counted_l = 0
  $pre_counted_3 = 0
  $pre_counted_s = 0
  $pre_counted_bracket = 0
  $pre_counted_px = 0
  $pre_counted_sq_bracket = 0
  $pre_counted_equal = 0
  $pre_counted_sdot = 0

  $pre_diff_comma = 0
  $pre_diff_semicolon = 0
  $pre_diff_l = 0
  $pre_diff_3 = 0
  $pre_diff_s = 0
  $pre_diff_bracket = 0
  $pre_diff_px = 0
  $pre_diff_sq_bracket = 0
  $pre_diff_equal = 0
  $pre_diff_sdot = 0


  class Setup
    def setup
      $file_names = []
      $file_names = Dir.glob("app/**/*.rb") + Dir.glob("app/**/*.js") + Dir.glob("app/**/*.css") + Dir.glob("app/**/*.scss") + Dir.glob("app/**/*.erb") + Dir.glob("app/**/*.html") + Dir.glob("config/routes.rb")
      $sample_size = 7
      $file_sample = $file_names.sample($sample_size)
      File.open('.git/.ignoremefile.txt', "a") {|file| file.puts $file_sample.to_json}
    end
  end

  class ErrorInside

    def count_em(text, substring)
      text.scan(/(?=#{substring})/).count
    end

    # creating backup directory
    def backup
        FileUtils.mkdir_p '.git/.backupFiles' unless File.exists?('.git/.backupFiles')

        #copy backup to backup folder
        FileUtils.cp_r "./app", ".git/.backupFiles/"
        FileUtils.cp_r "./config", ".git/.backupFiles/"
    end

    def yogify
      count_hash = []
      buffer = File.open('.git/.ignoremefile.txt', 'r').read
      file_sample = JSON.parse(buffer)

      file_sample.each do |file_name|
        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)

        $pre_counted_comma = count_em(text,",")
        $pre_counted_semicolon = count_em(text,";")
        $pre_counted_l = count_em(text,"ll")
        $pre_counted_3 = count_em(text,"3")
        $pre_counted_s = count_em(text,"s")
        $pre_counted_bracket = count_em(text,"}")
        $pre_counted_px = count_em(text,"px")
        $pre_counted_sq_bracket = count_em(text,">")
        $pre_counted_equal = count_em(text,"==")
        $pre_counted_sdot = count_em(text,"s.")

        # To merely print the contents of the file, use:
        new_contents1 = text.gsub(";"){rand(2).zero? ? ";" : ":"}
        new_contents2 = new_contents1.gsub(","){rand(2).zero? ? "," : " "}
        new_contents3 = new_contents2.gsub("ll"){rand(2).zero? ? "ll" : "l1"}
        new_contents4 = new_contents3.gsub("3"){rand(2).zero? ? "3" : "E"}
        new_contents5 = new_contents4.gsub(/[s]$/){rand(2).zero? ? " " : "5"}
        new_contents6 = new_contents5.gsub("}"){rand(2).zero? ? "}" : ")"}
        new_contents7 = new_contents6.gsub("px"){rand(2).zero? ? "px" : "xp"}
        new_contents8 = new_contents7.gsub(">"){rand(2).zero? ? "<" : ">"}
        new_contents9 = new_contents8.gsub("=="){rand(2).zero? ? "==" : "="}
        new_contents10 = new_contents9.gsub("s."){rand(2).zero? ? ".s" : "."}

        # To write changes to the file, use:
        File.open(file_name, "w") {|file| file.puts new_contents10 }

        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)
        #counts ocurences in the file after initial change
        post_counted_comma = count_em(text,",")
        post_counted_semicolon = count_em(text,";")
        post_counted_l = count_em(text,"ll")
        post_counted_3 = count_em(text,"3")
        post_counted_s = count_em(text,"s")
        post_counted_bracket = count_em(text,"}")
        post_counted_px = count_em(text,"px")
        post_counted_sq_bracket = count_em(text,">")
        post_counted_equal = count_em(text,"==")
        post_counted_sdot = count_em(text,"s.")

        $pre_diff_comma = $pre_counted_comma - post_counted_comma
        $pre_diff_semicolon = $pre_counted_semicolon - post_counted_semicolon
        $pre_diff_l = $pre_counted_l - post_counted_l
        $pre_diff_3 = $pre_counted_3 - post_counted_3
        $pre_diff_s = $pre_counted_s - post_counted_s
        $pre_diff_bracket = $pre_counted_bracket - post_counted_bracket
        $pre_diff_px = $pre_counted_px - post_counted_px
        $pre_diff_sq_bracket = $pre_counted_sq_bracket - post_counted_sq_bracket
        $pre_diff_equal = $pre_counted_equal - post_counted_equal
        $pre_diff_sdot = $pre_counted_sdot - post_counted_sdot

        pre_count_hash = {file_name => {
          "pre_counted_comma": $pre_counted_comma,
          "pre_counted_semicolon": $pre_counted_semicolon,
          "pre_counted_l": $pre_counted_l,
          "pre_counted_3": $pre_counted_3,
          "pre_counted_s": $pre_counted_s,
          "pre_counted_bracket": $pre_counted_bracket,
          "pre_counted_px": $pre_counted_px,
          "pre_counted_sq_bracket": $pre_counted_sq_bracket,
          "pre_counted_equal": $pre_counted_equal,
          "pre_counted_sdot": $pre_counted_sdot,
          "pre_diff_comma": $pre_diff_comma,
          "pre_diff_semicolon": $pre_diff_semicolon,
          "pre_diff_l": $pre_diff_l,
          "pre_diff_3": $pre_diff_3,
          "pre_diff_s": $pre_diff_s,
          "pre_diff_bracket": $pre_diff_bracket,
          "pre_diff_px": $pre_diff_px,
          "pre_diff_sq_bracket": $pre_diff_sq_bracket,
          "pre_diff_equal": $pre_diff_equal,
          "pre_diff_sdot": $pre_diff_sdot
        }}
          count_hash << pre_count_hash
      end
      File.open('.git/.ignoreme.json', "a") {|file| file.write count_hash.to_json}
      puts "You can start your debugging..."
      puts "if your are sick of it, just type...'fixme'"
      if OS.mac?
        file = File.join(__dir__, 'sound', 'activated.mp3')
        escfile = Shellwords.escape(file)
        cmd = "afplay #{escfile}"
        system cmd
      # elsif OS.linux?
      #   file = File.join(__dir__, 'sound', 'activated.mp3')
      #   escfile = Shellwords.escape(file)
      #   cmd = "aplay #{escfile}"
      #   system cmd
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

      file_sample.each do |file_name|
        text =  File.open(file_name, "r"){ |file| file.read }#File.read(file_name)


        post_counted_comma = count_em(text,",")
        post_counted_semicolon = count_em(text,";")
        post_counted_l = count_em(text,"ll")
        post_counted_3 = count_em(text,"3")
        post_counted_s = count_em(text,"s")
        post_counted_bracket = count_em(text,"}")
        post_counted_px = count_em(text,"px")
        post_counted_sq_bracket = count_em(text,">")
        post_counted_equal = count_em(text,"==")
        post_counted_equal = count_em(text,"s.")

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
        $pre_counted_sdot = variable_hash[i][file_name]['pre_counted_sdot']

        $pre_diff_comma = variable_hash[i][file_name]['pre_diff_comma']
        $pre_diff_semicolon = variable_hash[i][file_name]['pre_diff_semicolon']
        $pre_diff_l = variable_hash[i][file_name]['pre_diff_l']
        $pre_diff_3 = variable_hash[i][file_name]['pre_diff_3']
        $pre_diff_s = variable_hash[i][file_name]['pre_diff_s']
        $pre_diff_bracket = variable_hash[i][file_name]['pre_diff_bracket']
        $pre_diff_px = variable_hash[i][file_name]['pre_diff_px']
        $pre_diff_sq_bracket = variable_hash[i][file_name]['pre_diff_sq_bracket']
        $pre_diff_equal = variable_hash[i][file_name]['pre_diff_equal']
        $pre_diff_sdot = variable_hash[i][file_name]['pre_diff_sdot']
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
        post_diff_sdot = $pre_counted_sdot - post_counted_sdot

        # total changes made in each file
        total_pre_diff = $pre_diff_comma + $pre_diff_semicolon + $pre_diff_l + $pre_diff_3 + $pre_diff_s + $pre_diff_bracket + $pre_diff_px + $pre_diff_sq_bracket + $pre_diff_equal + $pre_diff_sdot

        # total changes not fixed
        total_post_diff = post_diff_comma + post_diff_semicolon + post_diff_l + post_diff_3 + post_diff_s + post_diff_bracket + post_diff_px + post_diff_sq_bracket + post_diff_equal + post_diff_sdot

        pre_diff_array << total_pre_diff
        post_diff_array << total_post_diff
      end
      pre_diff = pre_diff_array.inject(0, :+)
      post_diff = post_diff_array.inject(0, :+)
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
      puts " You fixed #{fixed_errors.to_i} errors, #{post_diff.to_i} more to go."
      puts "================================="
        if  OS.mac?
          file = File.join(__dir__, 'sound', 'oh-yeah.mp3')
          escfile = Shellwords.escape(file)
          cmd = "afplay #{escfile}"
          system cmd
        # elsif  OS.linux?
        #   file = File.join(__dir__, 'sound', 'oh-yeah.mp3')
        #   escfile = Shellwords.escape(file)
        #   cmd = "aplay #{escfile}"
        #   system cmd
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
      # elsif OS.linux?
      #   file = File.join(__dir__, 'sound', 'Giving-up.mp3')
      #   escfile = Shellwords.escape(file)
      #   cmd = "aplay #{escfile}"
      #   system cmd
      end
    end
  end

end
