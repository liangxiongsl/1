set port=8033
start http://localhost:%port% 
title ttt - %port%
mkdocs serve -a localhost:%port%
