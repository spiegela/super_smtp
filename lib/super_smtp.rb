require 'net/smtp'

module Net
  class SMTP
    #
    # Creates a new Net::SMTP object.
    #
    # +address+ is the hostname or ip address of your SMTP
    # server.  +port+ is the port to connect to; it defaults to
    # port 25.
    #
    # This method does not open the TCP connection.  You can use
    # SMTP.start instead of SMTP.new if you want to do everything
    # at once.  Otherwise, follow SMTP.new with SMTP#start.
    #
    def initialize(address, port = nil, source_address = nil)
      @address = address
      @source_address = source_address
      @port = (port || SMTP.default_port)
      @esmtp = true
      @capabilities = nil
      @socket = nil
      @started = false
      @open_timeout = 30
      @read_timeout = 60
      @error_occured = false
      @debug_output = nil
      @tls = false
      @starttls = false
      @ssl_context = nil
    end

    private

    def tcp_socket(address, port, source_address = nil)
      TCPSocket.open address, port, source_address
    end

    def do_start(helo_domain, user, secret, authtype)
      raise IOError, 'SMTP session already started' if @started
      if user or secret
        check_auth_method(authtype || DEFAULT_AUTH_TYPE)
        check_auth_args user, secret
      end
      s = timeout(@open_timeout) { tcp_socket(@address, @port, @source_address) }
      logging "Connection opened: #{@address}:#{@port}"
      @socket = new_internet_message_io(tls? ? tlsconnect(s) : s)
      check_response critical { recv_response() }
      do_helo helo_domain
      if starttls_always? or (capable_starttls? and starttls_auto?)
        unless capable_starttls?
          raise SMTPUnsupportedCommand,
              "STARTTLS is not supported on this server"
        end
        starttls
        @socket = new_internet_message_io(tlsconnect(s))
        # helo response may be different after STARTTLS
        do_helo helo_domain
      end
      authenticate user, secret, (authtype || DEFAULT_AUTH_TYPE) if user
      @started = true
    ensure
      unless @started
        # authentication failed, cancel connection.
        s.close if s and not s.closed?
        @socket = nil
      end
    end

  end   # class SMTP
end
