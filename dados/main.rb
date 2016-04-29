require 'CSV'

class Propriedade
    @nome
    @propriedade

    # Getters
    attr_reader :nome, :propriedade

    # Construtor
    def initialize nome, propriedade
        @nome, @propriedade = nome, propriedade
    end
end

class Tamanho
	@unidade
	@tamanho

    # Getters and Setters
	attr_accessor :unidade, :tamanho

    # Construtor
    def initialize unidade, tamanho
        @unidade, @tamanho = unidade, tamanho
    end
end

class DimensoesPlanta
	# Altura folhagem
	@AF
	# Altura da Planta
	@AP
	# Altura
	@A
	# Comprimento
	@C
	# Comprimento da vagem
	@CV
	# Comprimento da espiga
	@CE
	# Diametro
	@D
	# Peso
	@P

    # Getters
    attr_reader :AF, :AP, :A, :C, :CV, :CE, :D, :P

    # Construtor
    def initialize(propriedades)
        # cada propriedade é dado na forma de uma tupla ":nome, tamanho
        for propriedade in propriedades
            instance_variable_set "@#{propriedade.nome}", propriedade.tamanho
        end
    end
end

class Semente
	# Propriedades Gerais
	@nome
	@sigla
	@id
	@foto
	@nomes_cientificos

	# Propriedades Especificas
	@n_sementes_g
	@n_dias_germinacao
	@necessidade_kg_ha

	# Preferencias da planta
	@ciclo_dias_ver
	@ciclo_dias_inv
	@espacamento_linha_plantas

	# Caracteristicas regionais
	@epoca_plantio_R1
	@epoca_plantio_R2
	@epoca_plantio_R3

	# Caracteristicas da Planta
	@descricao
	@tamanho

    # Getters and setters
    attr_accessor :nome, :sigla, :id, :foto, :nomes_cientificos, :n_sementes_g, :n_dias_germinacao
    attr_accessor :necessidade_kg_ha, :ciclo_dias_inv, :espacamento_linha_plantas, :epoca_plantio_R1
    attr_accessor :epoca_plantio_R2, :epoca_plantio_R3, :descricao, :tamanho

    # Construtor
    def initialize nome, sigla, id
        @nome, @sigla, @id = nome, sigla, id
        @nomes_cientificos = []
    end

    # Retorna um array deste objeto
    def to_a
        return ["nome: #{@nome}",
                "sigla: #{@sigla}",
                "id: #{@id}",
                "foto: #{@foto}",
                "nomes_cientificos: #{@nomes_cientificos.to_s}",
                "n_sementes_g: #{@n_sementes_g}",
                "n_dias_germinacao: #{@n_dias_germinacao}",
                "necessidade_kg_ha: #{@necessidade_kg_ha}",
                "ciclo_dias_inv: #{@ciclo_dias_inv}",
                "ciclo_dias_ver: #{@ciclo_dias_ver}",
                "espacamento_linha_plantas: #{@espacamento_linha_plantas}",
                "epoca_plantio_R1: #{@epoca_plantio_R1}",
                "epoca_plantio_R2: #{@epoca_plantio_R2}",
                "epoca_plantio_R3: #{@epoca_plantio_R3}",
                "descricao: #{@descricao}",
                "tamanho: #{@tamanho}"]
    end

    # Retorna uma string desse objeto
    def to_s
        return  "nome: #{@nome}, " +
                "sigla: #{@sigla}, " +
                "id: #{@id}, " +
                "foto: #{@foto}, " +
                "nomes_cientificos: #{@nomes_cientificos.to_s}, " +
                "n_sementes_g: #{@n_sementes_g}, " +
                "n_dias_germinacao: #{@n_dias_germinacao}, " +
                "necessidade_kg_ha: #{@necessidade_kg_ha}, " +
                "ciclo_dias_inv: #{@ciclo_dias_inv}, " +
                "ciclo_dias_ver: #{@ciclo_dias_ver}, " +
                "espacamento_linha_plantas: #{@espacamento_linha_plantas}, " +
                "epoca_plantio_R1: #{@epoca_plantio_R1}, " +
                "epoca_plantio_R2: #{@epoca_plantio_R2}, " +
                "epoca_plantio_R3: #{@epoca_plantio_R3}, " +
                "descricao: #{@descricao}, " +
                "tamanho: #{@tamanho}"
    end
end

class Arvore
    # Propriedades Gerais
    @nome
    @id
    @foto
    @nomes_cientificos

    # Caracteristicas da Planta
    @classificacao
    @bioma
    @regiao_de_origem
    @caracteristicas

    # Getters and setters
    attr_accessor :nome, :id, :foto, :nomes_cientificos
    attr_accessor :classificacao, :bioma, :regiao_de_origem, :caracteristicas

    # Construtor
    def initialize nome, id
        @nome, @id = nome, id
        @nomes_cientificos = []
    end

    # Retorna um array deste objeto
    def to_a
        return ["nome: #{@nome}",
                "id: #{@id}",
                "foto: #{@foto}",
                "nomes_cientificos: #{@nomes_cientificos.to_s}",
                "classificacao: #{@classificacao}",
                "bioma: #{@bioma}",
                "regiao_de_origem: #{@regiao_de_origem}",
                "caracteristicas: #{@caracteristicas}"]
    end

    # Retorna uma string desse objeto
    def to_s
        return  "nome: #{@nome}, " +
                "id: #{@id}, " +
                "foto: #{@foto}, " +
                "nomes_cientificos: #{@nomes_cientificos.to_s}, " +
                "classificacao: #{@classificacao}, " +
                "bioma: #{@bioma}, " +
                "regiao_de_origem: #{@regiao_de_origem}, " +
                "caracteristicas: #{@caracteristicas}"
    end
end

## Palavras reservadas - COLUNAS
titulos_colunas = { "VARIEDADE"                      => 1,   # IGN: -
                    "Nº DE"                          => 2,   # IGN: "SEMENTES/g",
                    "NECESSIDADE"                    => 2,   # IGN: "(KG/ha)",
                    "Nº DIAS INÍCIO "                => 2,   # IGN: "GERMINAÇÃO",
                    "CICLO"                          => 2,   # IGN: "(dias)",
                    "ESPAÇAMENTO"                    => 3,   # IGN: "LINHA X PLANTAS", "(cm)",
                    "TAMANHO DA "                    => 3,   # IGN: "PLANTA/FRUTO", "CRESCIMENTO",
                    "CARACTERÍSTICAS/DIFERENCIAIS"   => 1,   # IGN: -
                    "ÉPOCA DE"                       => 2  } # IGN: "PLANTIO"

# Com essa informação podemos agora excluir essas linhas, sabemos que elas vão sempre aparecer na mesma ordem
# então só precisamos saber o que vamos modificar de acordo com cada uma
# para facilitar vamos agrupar por linha nossos titulos

# Começo do código
puts ("...:::Sementes CSV Extractor :::...\n" +
      "Developed By: Jeferson Lima\n" +
      "Version: 0.1\n\n" +
      "Starting CSV Extraction...\n\n")

# Antes de carregar os dados
# precisamos corrigir a estrutura desse CSV

# Carregamos o arquivo
arquivo = IO.readlines 'test1.csv'

# Hash de plantas
plantas = Hash.new

# Hash de arvores
arvores = Hash.new

# Vou criar uma lista com todos os id's
ref_list = []
id_list = []
i = 0

# Vou remover os ID's que estão entre 'VARIEDADE' e 'Nº DE' e deixar
# só os outros, ai usando o modelo deles, irei cosertar todos de
# forma que seja possível extrair os dados de cada planta
while i < arquivo.length do
    # Se eu encontro a palavra variedade no arquivo
    if arquivo[i] == "VARIEDADE\r\n" then
        # Removo a palavra VARIEDADE para que ela não me atrapalhe
        arquivo[i] = "=====\r\n"

        # Pulo para a próxima entrada válida
        i += 1

        # Enquanto não acabar a lista de ID's
        # eu limpo o ID, inseridno '-' no lugar dele e incremento
        # o indice
        while arquivo[i] != "Nº DE\r\n" do
            id_list.push arquivo[i]
            arquivo[i] = ''
            i += 1
        end
    else
        # Se eu não encontrei ID's novos eu continuo a leitura
        i += 1
    end
end

# Com a lista de ids em mão vou procurar por eles e fazer
# verificações sobre como a string começa e como ela acaba
# de forma a fazer as devidas correções no arquivo adequadamente
# Como esse maldito arquivo não tem ordem, e as entradas estão
# bastante desorganizadas e tal não vejo forma melhor de computar
# essa coisa ao não ser em O(m*n) aonde m é o length dos ids e n e
# o length do arquivo

# retire o comentario dessa linha e das outras entradas para o debug
# k = 0
id_list.each do |e|
    # Inicialização
    i = 0

    # Enquanto não encontrar o id procurado incrementa o loop
    while i < arquivo.length && ( !arquivo[i].start_with?(e.gsub(/\r\n?/,'')) || (arquivo[i] =~ /^[^A-Za-z]+$/).nil?) do
       i += 1
    end

    # Se o indice chegou ao tamanho do arquivo então o ID não foi
    # encontrado, como os testes já foram feitos comentei a checagem
    # de id's não encontrados
    if i != arquivo.length then
        # Se chegamos até aqui o ID está correto vamos corrigir ele
        # antes de inserir essa entrada, então vamos fazer algumas
        # checagems e correções

        # Vamos checar se a entrada está no formato desejado
        if !arquivo[i].end_with?(",\"\"\r\n") then
            arquivo[i] = arquivo[i].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        # Vamos corrigir as 2 posições anteriores e as duas seguintes
        2.times do |x|
            # Checa posição anterior
            if !arquivo[i-(x+1)].start_with?('"",') then
                arquivo[i-(x+1)] = '"",' + arquivo[i-(x+1)]
            end

            # Checa próxima posição
            if !arquivo[i+(x+1)].end_with?(",\"\"\r\n") then
                arquivo[i+(x+1)] = arquivo[i+(x+1)].gsub(/\r\n?/,'') + ",\"\"\r\n"
            end
        end

        # Checa a última posição e corrige se for necessário
        if !arquivo[i+3].end_with?(",\"\"\r\n") then
            arquivo[i+3] = arquivo[i+3].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        # Faz o parse e adiciona a propriedade
        id = CSV.parse(arquivo[i])[0].to_i
        plantas[id] = Semente.new(  CSV.parse(arquivo[i - 2])[0][1],  # Nome
                                    CSV.parse(arquivo[i - 1])[0][1],  # Sigla
                                    id)                               # ID

        # Por ultimo adicionamos os nomes cientificos
        # as outras propriedades vão ser adicionadas futuramente
        3.times do |x|
            plantas[id].nomes_cientificos.push CSV.parse(arquivo[i + (x + 1)]
        end

        # Com tudo isso feito vamos limpar essa parte do arquivo
        z = i - 2
        6.times do |x|
            arquivo[z + x] = ''
        end
    end
end

# Agora que removemos todas as 'sementes', vamos adicionar as sementes só
# que as sementes das Arvores, vamos começar adicionando as referências que é o
# mesmo que o ID das variedades só que com outro nome.. Graças a Deus!

# Armazenemos o ID da primeira referência
first_ref = arquivo.find_index "REF\r\n"

# Vamos agora pegar a lista de todas as referências a partir da primeira
i = first_ref
while i < arquivo.length do
    if arquivo[i] == "REF\r\n" then
        # Remove a palavra REF do arquivo
        arquivo[i] = "=======\r\n"

        # Pulo para a próxima entrada válida
        i += 1

        # Enquanto houver referências, adicionamos a entrada a lista REF
        while arquivo[i] != "CLASSIFICAÇÃO\r\n" do
            ref_list.push arquivo[i]
            arquivo[i] = ''
            i += 1
        end
    else
        # Se não encontramos a palavra REF, incrementamos o contador
        i += 1
    end
end

# Como sabemos a primeira posição das arvores é igual a first_ref -13
first_ref -= 13

# Agora que temos a lista de referências preciamos procurar estas
# arvores e adicionalas ao nosso hash de arvores
ref_list.each do |e|
    # Iniciamos a posição com a primeira referência, porém como nada nesse
    # arquivo está organizado nós não podemos incrementar o first ref :/
    i = first_ref

    # Enquanto ão encontrarmos a referência desejada
    while i < arquivo.length && ( !arquivo[i].start_with?(e.gsub(/\r\n?/,'')) || (arquivo[i] =~ /^[^A-Za-z]+$/).nil?) do
        i += 1
    end

    # Se o indice chegou ao tamanho do arquivo então não encontramos o ID
    # caso ele não tenha chegado nós olhamos os indices anteriores e após
    # ele afim de inserir a arvore a nossa lista de arvores
    if i != arquivo.length then


# Agora com todas as informações triviais organizadas, nome da planta, sigla,
# e nomes cientificos, iremos salvar esse arquivo e dar um parse dele uma única
# vez, é importante lembrar que esse novo arquivo não vai conter a lista de ID's
# nem as classes, já que essas já estão prontas, o que falta é só compor
# as instâncias das classes com as informações que ainda não estão presentes
# Para que isso seja fácil iremos salvar nosso arquivo resultante e carregar
# ele numa nova variável

# Abro meu arquivo final como escrita
arquivo_pronto = open('dados2.csv', 'w')
# Limpo ele
arquivo_pronto.truncate(0)

# Antes de gravar o arquivo vamos limpar a primeira instância do mesmo
arquivo[0] = ''

# Escrevo todas as linhas de arquivo em arquivo pronto
arquivo.each do |e|
    arquivo_pronto.write e
end

# Fechamos o arquivo para não ter nenhum tipo de problema
arquivo_pronto.close

# Carrega os dados do CSV de entrada
dados = CSV.read 'dados2.csv'

# Progresso
progresso = 'Progress ['

# Arquivo de saida
CSV.open 'saida.csv', 'wb' do |saida|
    # Lista de ID's
    lista_id = []

    # Da start no progresso
    prog = 0
    unidades = dados.length / 100

    # Como Ruby não tem um FOR, C-like (shame) implementamos um while
    # for(inicializacao;condiao;incremento){}
    # Inicilização
    i = 0
    j = 0
    # Condição
    while i < dados.length do
        # Adiciona uma barra de carregando
        if i >= (unidades * prog) then
            # Incrementa o progresso
            prog += 1
            # Adiciona isso visualmente
            progresso << '='
            # Move o cursor para o começo da linha
            print "\r"
            print "#{progresso} - #{prog} %"

            # Força a saida para aparecer imediatamente, por padrão quando
            # '\n' é printado o buffer da saida padrão é 'atualizado - flushed'
            $stdout.flush
        end

        # Como só restam "Titulos" de colunas e dados dessas vamos organizar
        palavra_reservada = dados[i][0]

        # Remove o Index do titulo
        i += titulos_colunas[palavra_reservada]

        # Checa a palavra reservada
        case palavra_reservada
            when '====='
                # Se encontrou um bloco incrementamos em 6 o j
                j += 6
            when 'Nº DE'
                for x in 0..5 do
                    # Coloca a informação da tabela
                    plantas[lista_id[]].n_sementes_g = dados[i+j][0].gsub('.', '').to_i
                    j += 1
                end

                # Incrementa o contador
                i += 6

            # Faz a mesma coisa que o anterior só que numa propriedade nova
            when 'NECESSIDADE'
                for j in 0..5 do
                    # Como o array já está inicializado não precisamos verificar
                    plantas[lista_id[j]].necessidade_kg_ha = dados[i+j][0].gsub('.','').gsub(',','.').to_f
                end

                # Incrementa o contador
                i += 6

            # Mais uma propriedade parecida
            when 'Nº DIAS INÍCIO '
                for j in 0..5 do
                    plantas[lista_id[j]].n_dias_germinacao = dados[i+j][0]
                end

                # Incrementa o contador
                i += 6

            # Mesma receita de bolo
            when 'ESPAÇAMENTO'
                for j in 0..5 do
                    # Muda o index e adiciona a palavra Vasos
                    if dados[i+j][0] == '(Vasos)' || dados[i+j][0] == 'Planta para' || dados[i+j][0] == 'Lanço' then
                        i += 1
                        plantas[lista_id[j]].espacamento_linha_plantas = "(Vasos)\n#{dados[i+j][0]}"
                        if dados[i+j] == 'cultivo ornamental' then i += 1 end
                    else
                        # Adciona a caracteristica
                        plantas[lista_id[j]].espacamento_linha_plantas = dados[i+j][0]
                    end
                end

                # Incrementa o contador
                i += 6

            # Essa próximas caracteristicas são bem chatinhas e algumas
            # muito complexas
            # Apesar da receita ser a mesma, a execução é diferenciada
            when 'CICLO'
            when 'TAMANHO DA '
            when 'CARACTERÍSTICAS/DIFERENCIAIS'
            when 'ÉPOCA DE'
            else
                # Não deveria estar chegando aqui :S
        end
    end

    # Para cada planta cadastrada
    # transformar objeto em array e jogar no CSV
    plantas.each do |e|
        saida << e.to_a
    end

    # Adiciona a propriedade extra
    extra = plantas[15]
    extra.id = 16
    saida << extra.to_a

    # FINISHED :D
    puts("]\n" +
         "Extraction Complete.\n" +
         "Open 'saida.csv' to see the results.\n" +
         "Thank You\n")
end
