require 'date'

@filename = "breakgraph.txt"

def write_new_line
  puts "Today has not been added before, drawing new bar"
  File.open(@filename, 'a+') do |file|
    file.puts Date.today.strftime "%d.%m.%Y: x"
  end
end

def append_to_last_line
  puts "Today exists in graph, adding to todays bar"
  todays_line = Date.today.strftime "%d.%m.%Y: x"
  File.write(f = @filename, File.read(f).gsub(/#{todays_line}/, Date.today.strftime("%d.%m.%Y: xx")))
end

def parse_file
  # regex that matches the line format
  lineregex = /(\d\d\.\d\d\.\d{4}): x+/

  # get the last line in the file
  lastline = IO.readlines(@filename)[-1]

  # apply the line regex to it
  regexmatch = lineregex.match lastline

  unless regexmatch
    puts "Cannot parse last line of file, assuming corrupt format or file, bailing out."
    return
  end

  # capture the date using a regex, see docs here:
  # http://ruby-doc.org//core-2.2.0/Regexp.html#class-Regexp-label-Capturing
  # match 0 is the entire line, match 1 is the date
  lastline_date = Date.parse regexmatch[1]

  if lastline_date === Date.today
    # Already got an entry for today, append to that line
    append_to_last_line
  else
    # No entry for today, create a new line
    write_new_line
  end
end

def breakgrapher
  if File.exist? @filename and not File.zero? @filename
    parse_file
  else
    puts "File is empty or does not exist, I will create it"
    write_new_line
  end
end

breakgrapher
