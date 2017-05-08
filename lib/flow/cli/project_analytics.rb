require_relative './ios_build_step_generator'

module Flow::Cli
  class ProjectAnalytics
    attr_accessor :config
    def initialize(config = {})
      self.config = config
    end

    def platform
      raise "conflict platform" if is_ios? && is_android?
      return "ios" if ios?
      return "android" if android?
      raise ConflictPlatformError, "conflict, unknown platform"
    end

    private

    def ios?
      (Dir["#{base_path}*.xcodeproj"] + Dir["#{base_path}*.xcworkspace"]).count > 0
    end

    def android?
      Dir["#{base_path}*.gradle"].count > 0
    end

    def base_path
      config[:workspace] || './'
    end
  end
end
