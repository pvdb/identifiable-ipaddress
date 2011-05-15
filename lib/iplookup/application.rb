module IPLookup
  class Application

    # default application options...
    DEFAULT_OPTIONS = {
      :exit => 0,
    }

    # parsed application options...
    attr_reader :options

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
      IPAddress.load_identities(@options.rc_file)
      return self
    end

    def run!(stdin = $stdin, stdout = $stdout)

      while line = stdin.gets do
        ip_address = line.chomp
        identity = IPAddress.get_identity(ip_address)
        stdout.puts identity || ip_address
      end

      return @options.exit

    end

  end # class Application
end # module IPLookup
