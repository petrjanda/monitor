module IdGenerator
  def self.build(prefix = nil)
    id = (Time.new.to_f * 10000000).to_s.gsub('.', '')

    prefix ? "#{prefix}-#{id}" : id
  end
end