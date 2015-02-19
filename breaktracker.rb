require 'date'

filename = "breakgraph.txt"
lineregex = /(\d\d\.\d\d\.\d{4}): x+/

def write_new_line
  puts "writing new line"
end

def append_to_last_line
  puts "appending to last line"
end

if File.exist? filename
  lastline = IO.readlines(filename)[-1]
  regexmatch = lineregex.match lastline
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
