class UserAgent
  module Browsers
    module Other

      REGEXP_AND_NAMES = [
        [%r{ABrowse[-/\s]?(.*)}i,                "ABrowse"],       # Latest update: 07 Sept 2004
        [%r{Acoo Browser[-/\s]?(.*)}i,           "Acoo Browser"],  # Latest release: 1.98.744 (Sep-27-2009)
        [%r{America Online Browser[-/\s]?(.*)}i, "America Online Browser"],
        [%r{AOL[-/\s]?(.*)}i,                    "AOL"],
        [%r{Avant Browser[-/\s]?(.*)}i,          "Avant Browser"], # Latest release: 2010 Build 130, 1.26.2011
        [%r{BlackBerry[0-9]{4}}i,                "BlackBerry"],
        [%r{Galaxy[-/\s]?(.*)}i,                 "Galaxy"],
        [%r{Konqueror[-/\s]?(.*)}i,              "Konqueror"],
        [%r{Lynx[-/\s]?(.*)}i,                   "Lynx"],
        [%r{NetPositive[-/\s]?(.*)}i,            "NetPositive"],
        [%r{PLAYSTATION 3}i,                     "Playstation 3"],
        [%r{PSP|PLAYSTATION Portable}i,          "Playstation Portable"]
      ]

      def self.extend?(agent)
        !(REGEXP_AND_NAMES.detect { |regex_and_browser| agent.detect_user_agent_by_product(regex_and_browser[0]) }.nil? &&
          REGEXP_AND_NAMES.detect { |regex_and_browser| agent.detect_user_agent_by_comment(regex_and_browser[0]) }.nil?)
      end

      def browser
        detect_name_from(REGEXP_AND_NAMES)
      end

      def version
        if v = detect_version_from(REGEXP_AND_NAMES)
          v.strip!
          v unless v.empty?
        end
      end

      def mobile?
        ["Playstation Portable"].include?(browser)
      end

    end
  end
end