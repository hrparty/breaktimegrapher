require 'date'

@filename = "breakgraph.txt"
# regex that matches the line format
lineregex = /(\d\d\.\d\d\.\d{4}): x+/

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

if File.exist? @filename and !File.zero? @filename
  # get the last line in the file
  lastline = IO.readlines(@filename)[-1]

  # apply the line regex to it
  regexmatch = lineregex.match lastline

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
else
  puts "File does not exist, I will create it"
  write_new_line
end
