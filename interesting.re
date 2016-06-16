# Verifica todas as 'EPOCAS DE PLANTIO'
#Multiline-Version_PICK_CORRECT_LINES
((ÉPOCA DE)+[\r\n]+(PLANTIO))+[\r\n]+
(
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))
)

# Verifica todas as 'EPOCAS DE PLANTIO'
#Singleline-Version_PICK_CORRECT_LINES
((ÉPOCA DE)+[\r\n]+(PLANTIO))+[\r\n]+(((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$)))

# Verifica todas as 'EPOCAS DE PLANTIO'
#Multiline-Version_PICK_INCORRECT_LINES
((ÉPOCA DE)+[\r\n]+(PLANTIO))+[\r\n]
(?!
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+
	((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))
)

# Verifica todas as 'EPOCAS DE PLANTIO'
#Singleline-Version_PICK_INCORRECT_LINES
((ÉPOCA DE)+[\r\n]+(PLANTIO))+[\r\n](?!((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$))+[\r\n]+((^R1.*$)+[\r\n]+(R2.*$)+[\r\n]+(R3.*$)))

# Verifica todas as 'VARIEDADE'
#Singleline-Version_PICK_INCORRECT_LINES
(VARIE.*$)+[\r\n]([0-9].*$)+[\r\n]([0-9].*$)+[\r\n]([0-9].*$)+[\r\n]([0-9].*$)+[\r\n]([0-9].*$)+[\r\n]([0-9].*$)+[\r\n](Nº DE)

# Verifica a palavra 'VARIEDADE'
#Singleline-Version_PICK_INCORRECT_LINES
(VARIE(?!DADE).*$)

# Verifica todas as 'Nº DE'
#Singleline-Version_PICK_INCORRECT_LINES
(Nº DE)+[\r\n]+(SEMENTES/g)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n]+(NECESSIDADE)

# Procura por erros em 'Nº DE'
(Nº DE)+[\r\n]+(SEMENTES/g)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n](.*$)+[\r\n]+(?!NECESSIDADE)

# Procura por erros em 'NECESSIDADE'
(NECESSIDADE)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](?=Nº D)

# Procura por erros em 'ESPAÇAMENTO'
(ESPAÇAMENTO)[\r\n](LINHA X PLANTAS)[\r\n](\(cm\))[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](?=TAMANHO)

# Procura por erros em 'Nº DIAS'
(Nº DIAS INÍCIO\ )[\r\n](GERMINAÇÃO)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](?=CICLO)

# Procura por erros em 'CICLO' - COMPLETO
(CICLO)[\r\n](\(dias\))[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](?=ESPAÇAMENTO)

# Procura por erros em 'CICLO' falta
(CICLO)[\r\n](\(dias\))[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](.*$)[\r\n](?=ESPAÇAMENTO)

# Ahh se existisse uma regex para 'CICLO', 'TAMANHO DA' e 'CARACTERISTICAS' rsrs ;)

# Uppercase usando regex no sublime text para corrigir titulos
# Procura
(?=[a-z])(.*)(?=\")

# da Uppercase
\U$1\E