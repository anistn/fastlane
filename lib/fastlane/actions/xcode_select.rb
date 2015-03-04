module Fastlane
  module Actions
    # See: https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcode-select.1.html
    #
    # DESCRIPTION
    #   xcode-select controls the location of the developer directory used by xcrun(1), xcodebuild(1), cc(1),
    #   and other Xcode and BSD development tools. This also controls the locations that are searched for  by
    #   man(1) for developer tool manpages.
    #
    # DEVELOPER_DIR
    #   Overrides the active developer directory. When DEVELOPER_DIR  is  set,  its  value  will  be  used
    #   instead of the system-wide active developer directory.
    #
    #   Note that for historical reason, the developer directory is considered to be the Developer content
    #   directory inside the Xcode application (for  example  /Applications/Xcode.app/Contents/Developer).
    #   You  can  set  the  environment variable to either the actual Developer contents directory, or the
    #   Xcode application directory -- the xcode-select provided  shims  will  automatically  convert  the
    #   environment variable into the full Developer content path.
    #
    class XcodeSelectAction
      def self.run(params)
        xcode_path = params.first

        # Verify that a param was passed in
        raise "Path to Xcode application required (e.x. \"/Applications/Xcode.app\")".red unless xcode_path.to_s.length > 0

        # Verify that a path to a directory was passed in
        raise "Nonexistent path provided".red unless Dir.exists? xcode_path

        Helper.log.info "Setting Xcode version to #{xcode_path} for all build steps"

        ENV["DEVELOPER_DIR"] = xcode_path + "/Contents/Developer"
      end
    end
  end
end