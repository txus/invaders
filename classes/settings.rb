class Settings
  def self.load
    xml = File.read('settings.xml')
    file = REXML::Document.new(xml)
    file.elements.each('settings/setting') do |p|
      name = p.elements.entries.values_at(0)[0].text # <name> ... </name>
      value = p.elements.entries.values_at(1)[0].text # <value> ... </value>
      self.class.send(:define_method, name) { value }
    end
  end
  def self.reload
    self.load
  end
end

