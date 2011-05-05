module IPLookup
  class Application

    # default application options...
    DEFAULT_OPTIONS = {
      :exit => 0,
    }

    # parsed application options...
    @options = nil

    def parse_options(argv, defaults = {})
      OpenStruct.new(defaults)
    end

    def initialize(argv = [])
      @options = parse_options(argv, DEFAULT_OPTIONS)
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