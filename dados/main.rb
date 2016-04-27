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
	@nomes_cientificos = []

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

# Vou criar uma lista com os id's que vou remover
id_list = []
i = 0

# Vou remover os ID's que estão entre 'VARIEDADE' e 'Nº DE' e deixar
# só os outros, ai usando o modelo deles, irei concertar todos de
# forma que seja possível extrair os dados de cada planta
while i < arquivo.length do
    # Se eu encontro a palavra variedade no arquivo
    if arquivo[i] == "VARIEDADE\r\n" then
        # Pulo para a próxima entrada válida
        i += 1
        # Enquanto não acabar a lista de ID's
        # eu limpo o ID, inseridno '-' no lugar dele e incremento
        # o indice
        while arquivo[i] != "Nº DE\r\n" do
            id_list.push arquivo[i]
            arquivo[i] = '-'
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

# Carrega os dados do CSV de entrada
dados = CSV.read 'dados2.csv'

# Progresso
progresso = 'Progress ['

# Arquivo de saida
CSV.open 'saida.csv', 'wb' do |saida|
	# Hash de Plantas
    plantas = Hash.new

    # Lista de ID's
    lista_id = []

    # Da start no progresso
    prog = 0
    unidades = dados.length / 100

    # Como Ruby não tem um FOR, C-like (shame) implementamos um while
    # for(inicializacao;condiao;incremento){}
    # Inicilização
    i = 0
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

            # Força a saida para aparecer imediatamente, por padrão quando '\n' é printado
            # o buffer da saida padrão é 'atualizado - flushed'
            $stdout.flush
        end

        # Se o primeiro parametro for igual uma string vazia ("")
        # Cadastremos uma nova planta ou complementamos as informações da mesma
        if dados[i][0].empty? then
            # Adquire o ID da planta
            id = dados[i+2][0].to_i

            unless plantas[id]
                plantas[id] = Semente.new(dados[i][1],   # NOME
                                          dados[i+1][1], # SIGLA
                                          id)            # ID
            else
                plantas[id].nome    = dados[i][1]
                plantas[id].sigla   = dados[i+1][1]
                plantas[id].id      = id
            end

            # Elimina os três primeiros dados
            i += 3
            # Procura os nomes cientficos
            while dados[i][1].empty? do
                # Adiciona o nome cientifico encontrado
                plantas[i].nomes_cientificos.push dados[i][0]
                # Incrementa 1
                i += 1
            end
        # Como RUBY também não tem CONTINUE (puqueeee)
        # CASO CONTRÁRIO
        else
            # Se não estamos cadastrando uma nova planta vamos verificar se temos uma palavra reservada
            # na verdade sabemos que tem, vamos organizar o que cada uma vai nos retornar
            palavra_reservada = dados[i][0]

            # Remove o Index do titulo
            i += titulos_colunas[palavra_reservada]

            # Checa a palavra reservada
            case palavra_reservada
                # O ID define a ordem da leitura das linhas de cada tabela
                # logo limpanos a lista_id e empilhamos os ID's
                when 'VARIEDADE'
                    # Limpa a Lista de ID
                    lista_id = []

                    while dados[i][0] != 'Nº DE' do
                        # Empilha o ID atual
                        lista_id.push dados[i][0].to_i

                        # Incrementa
                        i += 1
                    end
                # Esse tipo aqui remove 6 linhas da tabela
                # e coloca os valores no hash de plantas
                when 'Nº DE'
                    for j in 0..5 do
                        # Se a posição não tiver ainda sido inicializada, inicializamos ela sem
                        # os dados que não possuimos, nome e sigla, eles vão aparecer em algum momento rsrs
                        unless plantas[lista_id[j]]
                            plantas[lista_id[j]] = Semente.new('','',lista_id[j])
                        end

                        # Coloca a informação da tabela
                        plantas[lista_id[j]].n_sementes_g = dados[i+j][0].gsub('.', '').to_i
                    end

                    # Incrementa o contador
                    i += 6

                # Faz a mesma coisa que o anterior só que numa propriedade diferente
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

                # Essa próximas caracteristicas são bem chatinhas e algumas muito complexas
                # Apesar da receita ser a mesma, a execução é diferenciada
                when 'CICLO'
                when 'TAMANHO DA '
                when 'CARACTERÍSTICAS/DIFERENCIAIS'
                when 'ÉPOCA DE'
                else
                    # Não deveria estar chegando aqui :S
            end
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
