asim -acdb +access+r;
run -all;
acdb save;
acdb report -db work.acdb -txt -o cov.txt;
exec cat cov.txt;
exit
