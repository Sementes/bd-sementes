# Common entries, withhin two files
awk 'FNR==NR {a[$0]++; next} a[$0]' id_list-links.txt id_list-pdf.txt > common_id-list.txt

# Sortered last field of an organized file
cat download-list.csv | rev | cut -d '/' -f 1 | rev | cut -d'"' -f 1 | sort --general-numeric-sort > id_2

