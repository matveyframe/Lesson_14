from http.server import SimpleHTTPRequestHandler, HTTPServer
import os

os.chdir("/opt/srv/webapp/content")
server = HTTPServer(('0.0.0.0', 8001), SimpleHTTPRequestHandler)
server.serve_forever()
