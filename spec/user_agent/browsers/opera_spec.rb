require 'spec_helper'

describe UserAgent::Browsers::Opera do

  describe "comparisons" do
    before(:all) do
      @opera_9_26 = UserAgent.parse("Opera/9.26 (Macintosh; Intel Mac OS X; U; en)")
      @opera_9_27 = UserAgent.parse("Opera/9.27 (Windows NT 5.1; U; en)")
      @opera_9_28 = UserAgent.parse("Opera/9.28 (Windows NT 5.1; U; en)")
    end

    specify { @opera_9_27.should_not == @opera_9_26 }
    specify { @opera_9_27.should_not <  @opera_9_26 }
    specify { @opera_9_27.should_not <= @opera_9_26 }
    specify { @opera_9_27.should     >  @opera_9_26 }
    specify { @opera_9_27.should     >= @opera_9_26 }

    specify { @opera_9_27.should     == @opera_9_27 }
    specify { @opera_9_27.should_not <  @opera_9_27 }
    specify { @opera_9_27.should     <= @opera_9_27 }
    specify { @opera_9_27.should_not >  @opera_9_27 }
    specify { @opera_9_27.should     >= @opera_9_27 }

    specify { @opera_9_27.should_not == @opera_9_28 }
    specify { @opera_9_27.should     <  @opera_9_28 }
    specify { @opera_9_27.should     <= @opera_9_28 }
    specify { @opera_9_27.should_not >  @opera_9_28 }
    specify { @opera_9_27.should_not >= @opera_9_28 }
  end

  describe "Opera" do
    describe "Windows" do
      it { "Opera/9.23 (Windows NT 5.0; U; en)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows 2000").language("en").security(:strong) }
      it { "Opera/9.23 (Windows NT 5.0; U; de)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows 2000").language("de").security(:strong) }
      it { "Opera/9.23 (Windows NT 5.1; U; zh-cn)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows XP").language("zh-cn").security(:strong) }
      it { "Opera/9.23 (Windows NT 5.1; U; SV1; MEGAUPLOAD 1.0; ru)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows XP").language("ru").security(:strong) }
      it { "Opera/9.23 (Windows NT 5.1; U; pt)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows XP").language("pt").security(:strong) }
      it { "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; es-es) Opera 9.23".should be_browser("Opera").version("9.23").platform("Windows").os("Windows XP").language("es-es") }
      it { "Mozilla/5.0 (Windows NT 5.1; U; de; rv:1.8.0) Gecko/20060728 Firefox/1.5.0 Opera 9.23".should be_browser("Opera").version("9.23").platform("Windows").os("Windows XP").language("de").security(:strong) }
      it { "Opera/9.23 (Windows NT 6.0; U; de)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows Vista").language("de").security(:strong) }
      it { "Opera/9.23 (Windows NT 6.0; U; it)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows Vista").language("it").security(:strong) }
      it { "Opera/9.23 (Windows NT 6.0; U; fi)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows Vista").language("fi").security(:strong) }
      it { "Opera/9.23 (Windows NT 6.0; U; da)".should be_browser("Opera").version("9.23").platform("Windows").os("Windows Vista").language("da").security(:strong) }
      it { "Opera/9.27 (Windows NT 5.1; U; en)".should be_browser("Opera").version("9.27").platform("Windows").os("Windows XP").language("en").security(:strong) }
    end

    describe "Macintosh" do
      it { "Opera/9.23 (Macintosh; Intel Mac OS X; U; ja)".should be_browser("Opera").version("9.23").platform("Macintosh").os("Intel Mac OS X").language("ja").security(:strong) }
      it { "Opera/9.23 (Mac OS X; ru)".should be_browser("Opera").version("9.23").platform("Macintosh").os("OS X").language("ru") }
      it { "Opera/9.23 (Mac OS X; fr)".should be_browser("Opera").version("9.23").platform("Macintosh").os("OS X").language("fr") }
      it { "Opera/9.27 (Macintosh; Intel Mac OS X; U; en)".should be_browser("Opera").version("9.27").platform("Macintosh").os("Intel Mac OS X").language("en").security(:strong) }
    end

    describe "Linux" do
      it { "Opera/9.23 (X11; Linux x86_64; U; en)".should be_browser("Opera").version("9.23").platform("Linux").os("Linux x86_64").language("en").security(:strong) }
      it { "Opera/9.23 (X11; Linux i686; U; es-es)".should be_browser("Opera").version("9.23").platform("Linux").os("Linux i686").language("es-es").security(:strong) }
      it { "Opera/9.23 (X11; Linux i686; U; en)".should be_browser("Opera").version("9.23").platform("Linux").os("Linux i686").language("en").security(:strong) }
      it { "Mozilla/4.0 (compatible; MSIE 6.0; X11; Linux i686; en) Opera 9.23".should be_browser("Opera").version("9.23").platform("Linux").os("Linux i686").language("en") }
      it { "Mozilla/5.0 (X11; Linux i686; U; en; rv:1.8.0) Gecko/20060728 Firefox/1.5.0 Opera 9.23".should be_browser("Opera").version("9.23").platform("Linux").os("Linux i686").language("en").security(:strong) }
      it { "Opera/9.27 (X11; Linux x86_64; U; en)".should be_browser("Opera").version("9.27").platform("Linux").os("Linux x86_64").language("en").security(:strong) }
    end

    describe "Wii" do
      # Console
      it { "Opera/9.23 (Nintendo Wii; U; ; 1038-58; Wii Internet Channel/1.0; en)".should be_browser("Opera").version("9.23").type(:console).platform("Nintendo Wii").os(nil).language("en").security(:strong) }
    end
  end
  
  describe "Opera Mini" do
    it { "Opera/9.80 (Series 60; Opera Mini/5.1.22784/22.394; U; en) Presto/2.5.25 Version/10.54".should be_browser("Opera Mini").version("5.1.22784").language("en").security(:strong).mobile(true) }
  end
  
  describe "Opera Mobile" do
    it { "Opera/9.80 (Android; Linux; Opera Mobi/ADR-1012221546; U; pl) Presto/2.7.60 Version/10.5".should be_browser("Opera Mobile").version("10.5").platform("Android").os("Android").language("pl").security(:strong).mobile(true) }
    it { "Opera/9.80 (Android 2.2; Opera Mobi/-2118645896; U; pl) Presto/2.7.60 Version/10.5".should be_browser("Opera Mobile").version("10.5").platform("Android").os("Android 2.2").language("pl").security(:strong).mobile(true) }
  end

end