#!/usr/bin/python3

import dbus

def main():
	session = dbus.SessionBus()
	proxy = session.get_object('es.inled.fildem', '/es/inled/fildem')
	proxy.EmitHudActivated()

if __name__ == "__main__":
	main()
