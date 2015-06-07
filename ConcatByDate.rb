#!/usr/bin/env ruby

$textdir = ""
$fileprefix = ""
$deletefiles = "false"

require 'time'

today = Time.now

thisyear = today.strftime("%Y")
thismonth = today.strftime("%m")

month = ((thismonth.to_i - 1).to_s)

if  thismonth == "01"
	newyear = ((thisyear.to_i - 1).to_s)
	year = newyear
	month = "12"
else
	year = thisyear
end

if month.size == 1
	month.insert 0, "0"
end

day = "01"
$output = ""

begin
	filename = ( $notebookdir + $fileprefix + year + "-" + month + "-" + day + ".txt"  )
	if File.file?(filename)
		newtext = ""
		openfile = File.open filename
		$output.concat "\n" + "## " + year + "-" + month + "-" + day + "\n"
		newtext = openfile.read
		$output.concat newtext
		$output.concat "\n"
		openfile.close
		if $deletefiles == "true"
			 File.delete filename
		end
	end
#

#
#	else end
#
	day.next!
end until day == "32"

if $output ==""
	puts "Error! No relevant files to concatenate!"
else
	writefilename = $notebookdir + $fileprefix +  year + "-" + month + ".txt"
	writefile = File.new(writefilename, "a")
	writefile.puts $output
	writefile.close
	puts "Created new file " + writefilename
end
