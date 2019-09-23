function __is-vpn-connected() {
    /opt/cisco/anyconnect/bin/vpn status | grep -q Connected
    if [ $? -eq 0 ]; then
        return 0
    fi
    return 1
}

function __connect-to-vpn() {
    echo "Connecting to VPN..."
    pgrep -x -- "Cisco AnyConnect Secure Mobility Client" | xargs kill
    #echo "$VPN_USERNAME\n$VPN_PASSWORD\ny" | /opt/cisco/anyconnect/bin/vpn -s connect $VPN_HOST &> /dev/null
    echo "$VPN_USERNAME\n$VPN_PASSWORD\ny" | /opt/cisco/anyconnect/bin/vpn -s connect $VPN_HOST
    open -a /Applications/Cisco/Cisco\ AnyConnect\ Secure\ Mobility\ Client.app -gj
    echo "VPN connected"
    return 0
}

function __disconnect-from-vpn() {
    echo "Disconnecting from VPN..."
    /opt/cisco/anyconnect/bin/vpn -s disconnect &> /dev/null
    pgrep -x -- "Cisco AnyConnect Secure Mobility Client" | xargs kill
    echo "VPN disconnected."
    return 0
}

function vpn() {
	case "$1" in 
		on)
			if (__is-vpn-connected); then
				echo "VPN is already connected"
        		return 1
    		else
			 __connect-to-vpn
    		fi
			;;
		off)
			 if (__is-vpn-connected); then
				__disconnect-from-vpn
  			else
  				echo "VPN is not connected"            
    			return 1
  			fi
			;;	
		status)
            if (__is-vpn-connected); then
                echo "VPN is CONNECTED"
                return 0
            else
                echo "VPN is DISCONNECTED"
                return 0
            fi
            ;;
        *)
            echo "Usage: $0 {on|off|status}"
            return 1    
    esac
}

#Apply Charles Proxy settings to VPN connection
function cpon() {
        local toCopy=$((scutil | grep /Proxies | sed -n '1p' | sed 's/.*subKey.*=.//') < <(echo "
                list
                quit
        "));
        echo "Copying proxy settings from $toCopy"
        echo "Applying settings to State:/Network/Service/com.cisco.anyconnect/Proxies"
        (sudo scutil < <(echo "
                get $toCopy
                d.add ProxyAutoConfigEnable 1
                d.add ProxyAutoConfigURLString $VPN_PROXY_CONFIG
                set State:/Network/Service/com.cisco.anyconnect/Proxies
                quit
        "));
}
