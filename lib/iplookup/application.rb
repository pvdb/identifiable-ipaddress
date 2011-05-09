module IPLookup
  class Application

    # default application options...
    DEFAULT_OPTIONS = {
      :exit => 0,
    }

    # parsed application options...
    attr_reader :options
    @options = nil

    def parse_options(argv, defaults = {})
      options = OpenStruct.new(defaults)
      OptionParser.new do |opts|
        opts.on '--rc-file', '-r FILE', "read IP address identities from FILE" do |value|
          options.rc_file = value if File.exists? value
        end
      end.parse!(argv)
      return options
    end

    def initialize(argv = [])
      @options = parse_options(argv, DEFAULT_OPTIONS)
    end

    def run!(stdin = $stdin, stdout = $stdout)

      IPAddress.set_identities(YAML.load_file @options.rc_file) if @options.rc_file

      while line = stdin.gets do
        ip_address = line.chomp
        identity = IPAddress.get_identity(ip_address)
        stdout.puts identity || ip_address
      end

      return @options.exit

    end

  end # class Application
end # module IPLookup
