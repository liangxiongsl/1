set port=8000
start http://localhost:%port% 
title ttt - %port%
mkdocs serve -a localhost:%port%
