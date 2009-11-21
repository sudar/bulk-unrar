# Author : sudar <http://sudarmuthu.com>
# Licence: GPL
#
# Recurse into directory given on the command-line, and unrar all files found in all the subdirectories.
# The winrar installation directory should be placed in the path variable
#
# Will work only in Windows :)
#

require "find"

dirs = ARGV || ["."]

Find.find(*dirs) do |path|
  Find.prune if File.basename(path) == "CVS" or File.basename(path) == ".svn" or (!File.directory?(path) && File.extname(path) != ".rar")
  if (!File.directory?(path))
    puts "\nExtracting #{path}"
    Dir.chdir(File.dirname(path))
    puts `unrar -y e "#{path}"`
  end
end