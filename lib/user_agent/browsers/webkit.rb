class UserAgent
  module Browsers
    module Webkit

      WEBKIT_BROWSERS = %w[
        Arora
        Android
        BlackBerry
        Chrome
        Fluid
        NetNewsWire
        OmniWeb
        Shiira
        webOS
      ]

      BUILD_VERSIONS = {
        "85"      => "1.0",
        "85.7"    => "1.0",
        "85.8.2"  => "1.0.3",
        "85.8.5"  => "1.0.3",
        "100"     => "1.1",
        "124"     => "1.2",
        "125"     => "1.2",
        "125.2"   => "1.2.2",
        "125.4"   => "1.2.3",
        "125.5.5" => "1.2.4",
        "125.5.6" => "1.2.4",
        "125.5.7" => "1.2.4",
        "312"     => "1.3",
        "312.1"   => "1.3",
        "312.1.1" => "1.3",
        "312.5"   => "1.3.1",
        "312.5.1" => "1.3.1",
        "312.5.2" => "1.3.1",
        "312.8"   => "1.3.2",
        "312.8.1" => "1.3.2",
        "412"     => "2.0",
        "412.6"   => "2.0",
        "412.6.2" => "2.0",
        "412.7"   => "2.0.1",
        "416.11"  => "2.0.2",
        "416.12"  => "2.0.2",
        "417.9"   => "2.0.3",
        "418"     => "2.0.3",
        "418.8"   => "2.0.4",
        "418.9"   => "2.0.4",
        "418.9.1" => "2.0.4",
        "419"     => "2.0.4",
        "425.13"  => "2.2"
      }

      IOS_BUILD_VERSIONS = {
        "419.3"     => "3.0",
        "525.20"    => "3.1.1",
        "528.18"    => "4.0",
        "531.21.10" => "4.0.4",
        "532.9"     => "4.0.5",
        "533.17.9"  => "5.0.2"
      }

      def self.extend?(agent)
        agent.detect_user_agent_by_product("AppleWebKit")
      end

      def webkit?
        true
      end

      def browser
        WEBKIT_BROWSERS.detect { |browser| detect_user_agent_by_product_or_comment(browser) } || "Safari"
      end

      def version
        # Newest browser first
        if product = detect_user_agent_by_product("Version")
          product.version

        # Detect Safari iOS versions before desktop Safari (because iOS browser is 'Safari' too)
        elsif os =~ /^iOS/i
          IOS_BUILD_VERSIONS[build]

        # Try to map legacy version of desktop Safari (before version 3)
        # This mapping is only used for Macintosh/Safari, Windows/Safari began with version 3 (with the 'Version/X.Y' string)
        elsif browser == "Safari"
          BUILD_VERSIONS[build]

        # Try to automatically detect the version of all other browsers
        elsif v = send(browser).version
          v.gsub(/^v/, '') # Handle 'OmniWeb/v563.15'
        end
      end

      def webkit
        detect_user_agent_by_product("AppleWebKit")
      end

      def build
        detect_user_agent_by_product("AppleWebKit").version
      end

      def os
        if platform == "webOS"
          "Palm #{last.product} #{last.version}"

        # Handle iOS
        # Examples:
        #   CPU like Mac OS X => 'iOS'
        #   CPU iPhone OS 3_1_3 like Mac OS X => 'iOS 3.1.3'
        elsif ua = detect_user_agent_by_comment(/CPU.*like Mac OS X/i)
          ua.comment.detect { |comm| comm =~ /CPU (?:iPhone )?OS ([\d_]+) like Mac OS X/i }
          "iOS#{" #{$1.gsub(/_/, '.')}" unless !$1 || $1.strip.empty?}"

        else
          name_and_version = detect_name_and_version_from(OperatingSystems::REGEXP_AND_NAMES)
          # Map OS name that needs to (mainly Windows)
          if platform == "Android" || !name_and_version
            # Return the OS name *almost* as is (just make the version prettier: e.g. 10_6_6 => 10.6.6)
            ua = detect { |ua| !ua.comment.nil? }
            if ua.comment.size > 2
              ua.comment[2].gsub(/_/, '.')
            else
              nil
            end

          else
            name_and_version
          end
        end
      end

      def security
        SECURITY[detect { |ua| !ua.comment.nil? }.comment[1]]
      end

      def mobile?
        browser == "webOS" || !detect_user_agent_by_product("Mobile").nil?
      end

    end
  end
end
