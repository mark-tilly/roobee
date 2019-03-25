# roobee
This script was written on a Windows 10 box. Besides having Ruby and Watir installed, two things are required to run it:
Change the user name in the path on line 15, two places on line 31 and on line 32 to be the name of the user running the script. 
Those lines look like this:
Line 15:@logger = Logger.new('C:\Users\rmtil\Documents\TCC_Demo.log', 'daily')
Line 31:  FileUtils.mkdir_p('C:\Users\rmtil\Documents\Screenshots') unless File.exist?('C:\Users\rmtil\Documents\Screenshots')
Line 32: b.screenshot.save "C:\\Users\\rmtil\\Documents\\Screenshots\\/Error-#{ss}.png"
The last thing required for script execution is to create a folder named Screenshots in the Documents folder
