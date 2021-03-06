module Dert

  class SRV

    @res = Dnsruby::Resolver.new

    def self.query(domain)
      results = []
      default_address = Resolv.getaddress(domain)

      common = %w(
                _gc._tcp. _kerberos._tcp. _kerberos._udp. _ldap._tcp _test._tcp. _sips._tcp. _sip._udp. _sip._tcp.
                _aix._tcp. _aix._tcp. _finger._tcp. _ftp._tcp. _http._tcp. _nntp._tcp. _telnet._tcp. _whois._tcp.
                _h323cs._tcp. _h323cs._udp. _h323be._tcp. _h323be._udp. _h323ls._tcp. _h323ls._udp. _sipinternal._tcp.
                _sipinternaltls._tcp. _sip._tls. _sipfederationtls._tcp. _jabber._tcp. _xmpp-server._tcp.
                _xmpp-client._tcp. _imap._tcp. _certificates._tcp. _crls._tcp. _pgpkeys._tcp. _pgprevokations._tcp.
                _cmp._tcp. _svcp._tcp. _crl._tcp. _ocsp._tcp. _PKIXREP._tcp. _smtp._tcp. _hkp._tcp. _hkps._tcp.
                _jabber._udp. _xmpp-server._udp. _xmpp-client._udp. _jabber-client._tcp. _jabber-client._udp.
              )

      # SRV
      common.each do |a|
        begin
          ret = @res.query("#{a}#{domain}", Dnsruby::Types.SRV)
          ret.answer.each do |x|
            results << {
                address: default_address,
                type: x.type,
                hostname: x.name.to_s,
                target: x.target.to_s,
                ttl: x.ttl,
                klass: x.klass,
            }
          end
        rescue => e
          #
        end
      end

      results
    end

  end
end