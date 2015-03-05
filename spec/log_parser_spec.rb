#encoding: utf-8
require File.expand_path '../../lib/mailgates.rb', __FILE__
require File.expand_path(File.dirname(__FILE__) + '/spec_helper') 

describe "mailgates log parser" do 
  it "an ok log line should be parsed into hash with 9 keys" do 
    log = "[2015/03/03 19:25:03] [19129-1061775740-qq.com_1425381890.5615237.eml] Mail.RR <1061775740_149_0@online-edm.com> -> <1061775740@qq.com> (集享卡会员帐号激活/1544)[OK][MGHAM--0][MGTAGLOG ][utf-8]"
    parser = Mailgates::Log.parser(log)

    expect(parser.keys.count).to eq(9) 
    expect(parser.keys.sort).to eq([:timestamp, :emailfile, :from, :to, :subject, :result, :mgham, :mgtaglog, :charset].sort)
  end 

  it "not a log line should be parsed into hash with 1 key" do 
    log = []
    log.push "[2015/03/03 22:10:03] [9951-54F5C0B9.0008F593] Error job run/54F5C0B9.0008F593 (mqueue_open:Permission denied)."
    log.push "[2015/03/03 22:10:04] [MASTER] Warning -- Mailer 9666 exited.(0)"
    log.each do |line|
      parser = Mailgates::Log.parser(line)

      expect(parser.keys.count).to eq(1) 
      expect(parser.keys.sort).to eq([:raw])
    end
  end 
end
