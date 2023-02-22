set port=8033
start http://localhost:%port% 
title 复习 - %port%
mkdocs serve -a localhost:%port%
