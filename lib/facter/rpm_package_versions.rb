# Fact: java_version
#
# Purpose: get full java version string
#
# Resolution:
#   Tests for presence of java, returns nil if not present
#   returns output of "java -version" and splits on \n + '"'
#
# Caveats:
#   none
#
# Notes:
#   None
if Facter::Util::Resolution.which('rpm')
  package_data = Facter::Util::Resolution.exec('rpm --query --all  --qf "%{NAME}||%{VERSION}\n"')

  package_data.split("\n").each do |line|

    rpm_detail      = line.split("||")

    package_name    = 'package_' + rpm_detail[0]
    package_version = rpm_detail[1]

    Facter.add(package_name) do
      setcode do
        package_version
      end
    end

  end
end
