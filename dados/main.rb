require 'csv'
require 'sqlite3'

class Propriedade
    @nome
    @propriedade

    # Getters
    attr_reader :nome, :propriedade

    # Construtor
    def initialize(nome, propriedade)
        @nome, @propriedade = nome, propriedade
    end
end

class Tamanho
    @unidade
    @tamanho

    # Getters and Setters
    attr_accessor :unidade, :tamanho

    # Construtor
    def initialize(unidade, tamanho)
        @unidade, @tamanho = unidade, tamanho
    end
end

class DimensoesPlanta
    # Altura folhagem
    @af
    # Altura da Planta
    @ap
    # Altura
    @al
    # Comprimento
    @co
    # Comprimento da vagem
    @cv
    # Comprimento da espiga
    @ce
    # Diametro
    @di
    # Peso
    @pe

    # Getters
    attr_reader :af, :ap, :al, :co, :cv, :ce, :di, :pe

    # Construtor
    def initialize(propriedades)
        # Inicializa todas as propriedades como vazias
        @af, @ap, @al, @co, @cv, @ce, @di, @pe = ''

        # cada propriedade é dado na forma de uma tupla ":nome, tamanho
        propriedades.each do |propriedade |
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
    @epoca_plantio_r1
    @epoca_plantio_r2
    @epoca_plantio_r3

    # Caracteristicas da Planta
    @descricao
    @tamanho

    # Getters and setters
    attr_accessor :nome, :sigla, :id, :foto, :nomes_cientificos, :n_sementes_g, :n_dias_germinacao
    attr_accessor :necessidade_kg_ha, :ciclo_dias_inv, :espacamento_linha_plantas, :epoca_plantio_r1
    attr_accessor :epoca_plantio_r2, :epoca_plantio_r3, :descricao, :tamanho

    # Construtor
    def initialize(nome, sigla, id)
        @nome, @sigla, @id = nome, sigla, id
        @nomes_cientificos = []

        # Inicializa todas as propriedades como umas string vazia
        @foto, @n_sementes_g, @n_dias_germinacao = ''
        @ciclo_dias_inv, @ciclo_dias_ver, @espacamento_linha_plantas = ''
        @epoca_plantio_r1, @epoca_plantio_r2, @epoca_plantio_r3 = ''
        @descricao, @tamanho, @necessidade_kg_ha = ''
    end

    # Retorna um array deste objeto
    def to_a
        [@nome,
        @sigla,
        @id,
        @foto,
        @nomes_cientificos.to_s,
        @n_sementes_g,
        @n_dias_germinacao,
        @necessidade_kg_ha,
        @ciclo_dias_inv,
        @ciclo_dias_ver,
        @espacamento_linha_plantas,
        @epoca_plantio_r1,
        @epoca_plantio_r2,
        @epoca_plantio_r3,
        @descricao,
        @tamanho]
    end

    # To string sql
    def to_sql
        "#{@id}, " +
        "'#{@nome}', " +
        "'#{@sigla}', " +
        "'#{@foto}', " +
        "'#{@nomes_cientificos.to_s}', " +
        "#{@n_sementes_g}, " +
        "'#{@n_dias_germinacao}', " +
        "'#{@necessidade_kg_ha}', " +
        "'#{@ciclo_dias_inv}', " +
        "'#{@ciclo_dias_ver}', " +
        "'#{@espacamento_linha_plantas}', " +
        "'#{@epoca_plantio_r1}', " +
        "'#{@epoca_plantio_r2}', " +
        "'#{@epoca_plantio_r3}', " +
        "'#{@descricao}', " +
        "'#{@tamanho}'"
    end

    # Retorna uma string desse objeto
    def to_s
        "nome: #{@nome}, " +
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
        "epoca_plantio_r1: #{@epoca_plantio_r1}, " +
        "epoca_plantio_r2: #{@epoca_plantio_r2}, " +
        "epoca_plantio_r3: #{@epoca_plantio_r3}, " +
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
    def initialize(nome, id)
        @nome, @id = nome, id
        @nomes_cientificos = []

        # Inicializa todas as propriedaes como campos vazios
        @foto, @classificacao, @bioma, @regiao_de_origem = ''
        @caracteristicas = ''
    end

    # Retorna um array deste objeto
    def to_a
        [@nome,
        @id,
        @foto,
        @nomes_cientificos.to_s,
        @classificacao,
        @bioma,
        @regiao_de_origem,
        @caracteristicas]
    end

    # Retorna uma string desse objeto
    def to_s
        "nome: #{@nome}, " +
        "id: #{@id}, " +
        "foto: #{@foto}, " +
        "nomes_cientificos: #{@nomes_cientificos.to_s}, " +
        "classificacao: #{@classificacao}, " +
        "bioma: #{@bioma}, " +
        "regiao_de_origem: #{@regiao_de_origem}, " +
        "caracteristicas: #{@caracteristicas}"
    end

    def to_sql
        "#{@id}, " +
        "'#{@nome}', " +
        "'#{@foto}', " +
        "'#{@nomes_cientificos.to_s}', " +
        "'#{@classificacao}', " +
        "'#{@bioma}', " +
        "'#{@regiao_de_origem}', " +
        "'#{@caracteristicas}'"
    end
end

## Palavras reservadas - COLUNAS
titulos_colunas = { 'VARIEDADE'.to_sym                      => 1,   # IGN: -
                    'Nº DE'.to_sym                          => 2,   # IGN: "SEMENTES/g",
                    'NECESSIDADE'.to_sym                    => 2,   # IGN: "(KG/ha)",
                    'Nº DIAS INÍCIO '.to_sym                => 2,   # IGN: "GERMINAÇÃO",
                    'CICLO'.to_sym                          => 2,   # IGN: "(dias)",
                    'ESPAÇAMENTO'.to_sym                    => 3,   # IGN: "LINHA X PLANTAS", "(cm)",
                    'TAMANHO DA '.to_sym                    => 3,   # IGN: "PLANTA/FRUTO", "CRESCIMENTO",
                    'CARACTERÍSTICAS/DIFERENCIAIS'.to_sym   => 1,   # IGN: -
                    'ÉPOCA DE'.to_sym                       => 2  } # IGN: "PLANTIO"

# Barra de progresso simples
class ProgressBar
    # Caracteristicas da barra de progresso
    @progress
    @unities
    @length
    @title
    @it

    # Items da barra de progresso
    @status_bar
    @symbol_bar
    @tags_bar

    # Getters
    attr_reader :progress, :unities, :title, :it

    def initialize(length, title = 'Progress = ', symbol_bar = '=', tags_bar = %w{[ ]})
        @it         = 0
        @progress   = 0

        @title      = title
        @length     = length
        @symbol_bar = symbol_bar
        @tags_bar   = tags_bar

        @status_bar = "#{title} #{tags_bar[0]}"
        @unities    = @length >= 100 ? @length / 100.to_f : 1
    end

    # Imprime o progresso inicial ou seja 0%
    def start
        # Move o cursor para o começo da linha
        print "\r"

        # Imprime a barra de progresso
        print   "#{@status_bar}#{ @tags_bar[1] if @progress == 100} - " +
                "#{ @length >= 100 ? @progress : ((100 / @length) * @progress) }%"

        # Força a saida para aparecer imediatamente, por padrão quando
        # '\n' é printado o buffer da saida padrão é 'atualizado - flushed'
        $stdout.flush
    end

    # Conta quanto falta para finalizar a barra de progresso e finaliza a mesma
    def stop
        # Finaliza a barra de progresso
        @status_bar = "#{@title} #{@tags_bar[0]}"
        @status_bar << @symbol_bar * 100

        # Move o cursor para o começo da linha
        print "\r"

        # Imprime a barra de progresso
        print "#{@status_bar}#{@tags_bar[1]} - 100%"

        # Força a saida para aparecer imediatamente, por padrão quando
        # '\n' é printado o buffer da saida padrão é 'atualizado - flushed'
        $stdout.flush

        # Coloca um '\n' na saída para que a barra de progresso não seja alterada
        print "\n"
    end

    # Checa se devemos acrescentar uma nova barra de progresso
    def check
        # Incrementa o contador
        @it += 1

        # Imprime o progresso
        imprime_progresso
    end

    # Move o iterador da barra de progresso para um ponto especifico
    def change(value)
        @it = value

        # Imprime o progresso
        imprime_progresso
    end

    private
    def imprime_progresso
        # Se o iterador for maior que o progresso atual pela quantidade de unidades
        if @it >= (@progress * @unities)
            # Incrementa o progresso
            @progress += 1

            # Adiciona isso visualmente
            @status_bar << @symbol_bar * (@length >= 100 ? 1 : (100 / @length))

            # Move o cursor para o começo da linha
            print "\r"

            # Imprime a barra de progresso
            print   "#{@status_bar}#{ @tags_bar[1] if @progress == 100 } - " +
                    "#{ @length >= 100 ? @progress - 1 : ((100 / @length) * @progress) }%"

            # Força a saida para aparecer imediatamente, por padrão quando
            # '\n' é printado o buffer da saida padrão é 'atualizado - flushed'
            $stdout.flush
        end
    end

end

# Remove os acentos
def remove_acentos(str)
    str.tr('ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁł' +
               'ÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž',
           'AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLl' +
               'NnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz') unless str.nil?
end

# Com essa informação podemos agora excluir essas linhas, sabemos que elas vão sempre aparecer na mesma ordem
# então só precisamos saber o que vamos modificar de acordo com cada uma
# para facilitar vamos agrupar por linha nossos titulos

# Começo do código
puts ("...::: Sementes CSV Extractor :::...\n" +
      "Developed By: Jeferson Lima\n" +
      "Version: 0.6\n\n" +
      "Starting CSV Extraction...\n\n")

# Antes de carregar os dados
# precisamos corrigir a estrutura desse CSV

# Carregamos o arquivo
arquivo = IO.readlines 'entrada.csv'

# Hash de plantas
plantas = Hash.new

# Hash de arvores
arvores = Hash.new

# Vou criar uma lista com todos os id's
ref_list = []
id_list = []
i = 0

# Barra de Progresso
progresso = ProgressBar.new arquivo.length

# Inicia a barra de progresso
puts 'Extracting list of Plants'
progresso.start

# Vou remover os ID's que estão entre 'VARIEDADE' e 'Nº DE' e deixar
# só os outros, ai usando o modelo deles, irei cosertar todos de
# forma que seja possível extrair os dados de cada planta
while i < arquivo.length do
    # Incrementa o progresso
    progresso.check

    # Se eu encontro a palavra variedade no arquivo
    if arquivo[i] == "VARIEDADE\r\n"
        # Removo a palavra VARIEDADE para que ela não me atrapalhe
        arquivo[i] = "======\r\n"

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

# Finaliza o progresso
progresso.stop

# Vamos popular também o array de REF

# Armazenemos o ID da primeira referência
first_ref = arquivo.find_index "REF\r\n"

# Barra de Progresso
progresso = ProgressBar.new arquivo.length - first_ref

# Inicia a barra de progresso
puts 'Extracting list of Trees'
progresso.start

# Vamos agora pegar a lista de todas as referências a partir da primeira
i = first_ref
while i < arquivo.length do
    # Incrementa o progresso
    progresso.check

    # Se encontramos uma lista de referências, adicionamos todas elas
    if arquivo[i] == "REF\r\n"
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

# Finaliza o progresso
progresso.stop

# Com a lista de ids em mão vou procurar por eles e fazer
# verificações sobre como a string começa e como ela acaba
# de forma a fazer as devidas correções no arquivo adequadamente
# Como esse maldito arquivo não tem ordem, e as entradas estão
# bastante desorganizadas e tal não vejo forma melhor de computar
# essa coisa ao não ser em O(m*n) aonde m é o length dos ids e n e
# o length do arquivo

# Barra de Progresso
progresso = ProgressBar.new id_list.length

# Inicia a barra de progresso
puts 'Creating Plants instances'
progresso.start

id_list = id_list.map do |e|
    # Checa o progresso
    progresso.check

    # Inicialização
    i = 0

    # Enquanto não encontrar o id procurado incrementa o loop
    while i < arquivo.length && ( !arquivo[i].start_with?(e.gsub(/\r\n?/,'')) || (arquivo[i] =~ /^[^A-Za-z]+$/).nil?) do
        i += 1
    end

    # Inicialização do ID
    id = 0

    # Se o indice chegou ao tamanho do arquivo então o ID não foi
    # encontrado, como os testes já foram feitos comentei a checagem
    # de id's não encontrados
    if i != arquivo.length
        # Se chegamos até aqui o ID está correto vamos corrigir ele
        # antes de inserir essa entrada, então vamos fazer algumas
        # checagems e correções

        # Vamos checar se a entrada está no formato desejado
        unless arquivo[i].end_with?(",\"\"\r\n")
            arquivo[i] = arquivo[i].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        # Vamos corrigir as 2 posições anteriores e as duas seguintes
        2.times do |x|
            # Checa posição anterior
            unless arquivo[i-(x+1)].start_with?('"",')
                arquivo[i-(x+1)] = '"",' + arquivo[i-(x+1)]
            end

            # Checa próxima posição
            unless arquivo[i+(x+1)].end_with?(",\"\"\r\n")
                arquivo[i+(x+1)] = arquivo[i+(x+1)].gsub(/\r\n?/,'') + ",\"\"\r\n"
            end
        end

        # Checa a última posição e corrige se for necessário
        unless arquivo[i+3].end_with?(",\"\"\r\n")
            arquivo[i+3] = arquivo[i+3].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        # Faz o parse do id
        id = CSV.parse(arquivo[i])[0][0].to_i


        # Agora adicionamos a nova propriedade
        plantas[id] = Semente.new(  CSV.parse(arquivo[i - 2])[0][1],  # Nome
                                    CSV.parse(arquivo[i - 1])[0][1],  # Sigla
                                    id)                               # ID

        # Por ultimo adicionamos os nomes cientificos
        # as outras propriedades vão ser adicionadas futuramente
        3.times do |x|
            plantas[id].nomes_cientificos.push CSV.parse(arquivo[i + (x + 1)])[0][0]
        end

        # Com tudo isso feito vamos limpar essa parte do arquivo
        z = i - 2
        6.times do |x|
            arquivo[z + x] = ''
        end
    end

    # Salvamos nossa referência como o novo valor
    e = id
end

# Finaliza o progresso
progresso.stop

# Como sabemos a primeira posição das arvores é igual a first_ref -13
first_ref -= 13

# Barra de Progresso
progresso = ProgressBar.new ref_list.length

# Inicia a barra de progresso
puts 'Extracting list of Trees'
progresso.start

# Agora que temos a lista de referências preciamos procurar estas
# arvores e adicionalas ao nosso hash de arvores
ref_list = ref_list.map do |e|
    # Incrementa o progresso
    progresso.check

    # Iniciamos a posição com a primeira referência, porém como nada nesse
    # arquivo está organizado nós não podemos incrementar o first ref :/
    i = first_ref

    # Enquanto ão encontrarmos a referência desejada
    while i < arquivo.length && ( !arquivo[i].start_with?(e.gsub(/\r\n?/,'')) || (arquivo[i] =~ /^[^A-Za-z]+$/).nil?) do
        i += 1
    end

    # Inicialização do ID
    id = 0

    # Se o indice chegou ao tamanho do arquivo então não encontramos o ID
    # caso ele não tenha chegado nós olhamos os indices anteriores e após
    # ele afim de inserir a arvore a nossa lista de arvores
    if i != arquivo.length
        # Se não estamos no final do arquivo então a entrada está correta
        # para assegurar que nada dê errado, iremos corrigir a estrutura
        # antes de adicionarmos a propriedade
        unless arquivo[i].end_with?(",\"\"\r\n")
            arquivo[i] = arquivo[i].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        # Se a posição anterior não estiver no formato adequado
        # corrigimos ela
        unless arquivo[i-1].start_with?('"",')
            arquivo[i-1] = '"",' + arquivo[i-(x+1)]
        end

        # Agora com tudo corrigido iremos adicionar a arvore ao seu
        # respectivo vetor
        id = CSV.parse(arquivo[i])[0][0].to_i
        nome = CSV.parse(arquivo[i - 1])[0][1]
        arvores[id] = Arvore.new(nome, id)

        # Como não sabemos quantos nomes cientficos a arvore possui
        # iremos corrigir e adiciona-los ele a instancia da classe
        # recem criada
        x = 1
        while x + i < arquivo.length && !arquivo[i].empty? && !arquivo[i+x].start_with?('"",') && arquivo[i + x] != "=======\r\n" do
            # Primeiro verificamos se elá está no formato desejado
            unless arquivo[i+x].end_with?(",\"\"\r\n")
                arquivo[i+x] = arquivo[i+x].gsub(/\r\n?/,'') + ",\"\"\r\n"
            end

            # Após isso adicionamos ela e incrementamos o contador
            arvores[id].nomes_cientificos.push CSV.parse(arquivo[i + x])[0][0]
            arquivo[i + x] = ''
            x += 1
        end

        # Com tudo ok podemos limpar as posições anteriores do vetor
        arquivo[i] = ''
        arquivo[i - 1] = ''
    end

    # Salvamos a referência como o novo id
    e = id
end

# Finaliza o progresso
progresso.stop

# Agora com todas as informações triviais organizadas, nome da planta, sigla,
# e nomes cientificos, iremos salvar esse arquivo e dar um parse dele uma única
# vez, é importante lembrar que esse novo arquivo não vai conter a lista de ID's
# nem as classes, já que essas já estão prontas, o que falta é só compor
# as instâncias das classes com as informações que ainda não estão presentes
# Para que isso seja fácil iremos salvar nosso arquivo resultante e carregar
# ele numa nova variável

# Removemos a primeira linha das variedades para que a mesma não gere erros
arquivo[18] = ''

# Abro meu arquivo final como escrita
arquivo_pronto = open('dados.csv', 'w')
# Limpo ele
arquivo_pronto.truncate(0)

# Escrevo todas as linhas de arquivo em arquivo pronto
arquivo.each do |e|
    arquivo_pronto.write e
end

# Fechamos o arquivo para não ter nenhum tipo de problema
arquivo_pronto.close

# Carrega os dados do CSV de entrada
dados = CSV.read 'dados.csv'

# Barra de Progresso
progresso = ProgressBar.new dados.length

# Inicia a barra de progresso
puts 'Composing Plants instances'
progresso.start

# Como Ruby não tem um FOR, C-like (shame) implementamos um while
# for(inicializacao;condiao;incremento){}
# Inicilização
i = 0
j = 0
# Condição
while i < dados.length && dados[i][0] != '=======' do
    # Adiciona uma barra de carregando
    progresso.check

    # Como só restam "Titulos" de colunas e dados dessas vamos organizar
    palavra_reservada = dados[i][0]

    # Remove o Index do titulo, se a posição não for um bloco
    unless titulos_colunas[palavra_reservada.to_sym].nil?
        i += titulos_colunas[palavra_reservada.to_sym]
    end

    # Checa a palavra reservada
    case palavra_reservada
        when '======'
            # Se encontrou um bloco incrementamos em 6 o j e em 1 o i
            j += 6
            i += 1
        when 'Nº DE'
            0..5.times do |x|
                # Coloca a informação da tabela na hash table
                plantas[id_list[j+x]].n_sementes_g = dados[i][0].gsub('.', '').to_i

                # Incrementamos o contador, para ler a próxima linha
                # não incrementamos j aqui ao não ser que tenhamos encontrado um novo bloco
                i += 1
            end

        # Faz a mesma coisa que o anterior só que numa propriedade nova
        when 'NECESSIDADE'
            0..5.times do |x|
                # Coloca a informação da tabela na hash table
                plantas[id_list[j+x]].necessidade_kg_ha = dados[i][0].gsub('.','').gsub(',','.').to_f

                i += 1
            end

        # Mais uma propriedade parecida
        when 'Nº DIAS INÍCIO '
            0..5.times do |x|
                # Coloca a informação da tabela na hash table
                plantas[id_list[j+x]].n_dias_germinacao = dados[i][0]

                i += 1
            end

        # Mesma receita de bolo
        when 'ESPAÇAMENTO'
            0..5.times do |x|
                # Coloca a informação da tabela na hash table
                plantas[id_list[j+x]].espacamento_linha_plantas = dados[i][0]

                i += 1
            end

        # Mesma Receita de bolo só que 3 vezes para cada planta
        when 'ÉPOCA DE'
            0..5.times do |x|
                # Coloca a informação da tabela na hash table
                plantas[id_list[j+x]].epoca_plantio_r1 = dados[i][0]
                plantas[id_list[j+x]].epoca_plantio_r2 = dados[i+1][0]
                plantas[id_list[j+x]].epoca_plantio_r2 = dados[i+2][0]

                # Incrementamos 3 posições porque são 3 linhas por planta
                i += 3
            end

        # Essa próximas caracteristicas são bem chatinhas e algumas muito complexas
        # Apesar da receita ser a mesma, a execução é diferenciada
        # TODO - Inserção de propriedades chave
        # TODO - CICLO
        #when 'CICLO'
        # TODO - TAMANHO DA
        #when 'TAMANHO DA '
        # TODO - CARACTERISTICAS
        #when 'CARACTERÍSTICAS/DIFERENCIAIS'
        else
            # Se chegarmos em uma linha que não sabemos tratar
            # ignoramos a mesma
            i += 1
    end
end
progresso.stop

# Depois de inserirmos as outras caracteristicas de uma planta iremos
# fazer o mesmo agora para as arvores
# Barra de Progresso
progresso = ProgressBar.new(dados.length - i)

# Inicia a barra de progresso
puts 'Composing Trees instances'
progresso.start

# Referência
j = 0
# Condição
while i < dados.length do
    # Adiciona uma barra de carregando
    progresso.check

    # Como só restam "Titulos" de colunas e dados dessas vamos organizar
    #palavra_reservada = dados[i][0]

    # Remove o Index do titulo, se a posição não for um bloco
    unless titulos_colunas[palavra_reservada].nil?
        i += titulos_colunas[palavra_reservada]
    end

    ref_list

    # Checa a palavra reservada
    case palavra_reservada
        when '======='
            # Se encontrou um bloco incrementamos em 6 o j e em 1 o i
            j += 6
            i += 1
        else
            # Se chegarmos em uma linha que não sabemos tratar
            # ignoramos a mesma
            i += 1
    end
end
progresso.stop

# Arquivo de saida Plantas
CSV.open 'plantas-saida.csv', 'wb' do |saida|
    # Insere os headers
    saida << %w{    NOME
                    SIGLA
                    ID
                    FOTO
                    NOMES_CIENTIFICOS
                    N_SEMENTES_G
                    N_DIAS_GERMINACAO
                    NECESSIDADE_KG_HA
                    CICLO_DIAS_INV
                    CICLO_DIAS_VER
                    ESPACAMENTO_LINHA_PLANTAS
                    EPOCA_PLANTIO_R1
                    EPOCA_PLANTIO_R2
                    EPOCA_PLANTIO_R3
                    DESCRICAO
                    TAMANHO }

    # Para cada planta cadastrada
    # transformar objeto em array e jogar no CSV
    plantas.each do |e|
        saida << e[1].to_a
    end

end

# Arquivo de sadia Arvores
CSV.open 'arvores-saida.csv', 'wb' do |saida|
    # Insere os titulos
    saida << %w{    NOME
                    ID
                    FOTO
                    NOMES_CIENTIFICOS
                    CLASSIFICACAO
                    BIOMA
                    REGIAO_DE_ORIGEM
                    CARACTERISTICAS }

    arvores.each do |e|
        saida << e[1].to_a
    end
end

# TODO - Adiciona a propriedade extra
# Existe uma lista grande de propriedades repetidas.
# Precisamos inserir as mesmas dentros das listas já criadas

# TODO - Exportar para uma tabela sqlite3
begin
    # Create a new Database
    db = SQLite3::Database.open 'dados.db'

    # Remove a tabela plantas caso a mesma já exista
    db.execute 'DROP TABLE IF EXISTS Plantas'

    # Remove a tabela arvores caso a mesma já exista
    db.execute 'DROP TABLE IF EXISTS Arvores'

    # Cria a tabela Plantas
    db.execute  'CREATE TABLE Plantas(Id INTEGER PRIMARY KEY, ' +
                'Nome TEXT, Sigla TEXT, Foto TEXT, ' +
                'NomeCientificos TEXT, NumeroSementes INTEGER, ' +
                'NumeroDias TEXT, NecessidadeSementes , CicloDiasInv TEXT, ' +
                'CicloDiasVer TEXT, Espacamento TEXT, EpocaPlantioR1 TEXT, ' +
                'EpocaPlantioR3 TEXT, EpocaPlantioR2 TEXT, Descricao TEXT, Tamanho TEXT)'

    # Cria a tabela Arvores
    db.execute  'CREATE TABLE Arvores(Id INTEGER PRIMARY KEY, ' +
                'Nome TEXT, ' +
                'Foto TEXT, ' +
                'NomesCientificos TEXT, ' +
                'Classificacao TEXT, ' +
                'Bioma TEXT, ' +
                'RegiaoDeOrigem TEXT, ' +
                'Caracteristicas TEXT)'

    # Barra de Progresso
    progresso = ProgressBar.new plantas.length

    # Inicia a barra de progresso
    puts 'Populating Output Database - Plants'
    progresso.start

    # Adicionamos agora todas as propriedades
    # Nossa classe já possui um metodo to_s que serve exatamente para esse propósito
    plantas.each do |e|
        # Adicionamos o progresso
        progresso.check

        # Adicionamos a entrada
        db.execute "INSERT INTO Plantas VALUES(#{e[1].to_sql})"
    end

    # Finliza o progresso
    progresso.stop

    # Barra de Progresso
    progresso = ProgressBar.new plantas.length

    # Inicia a barra de progresso
    puts 'Populating Output Database - Trees'
    progresso.start

    # Vamos adicionar as arvores
    arvores.each do |e|
        # Checamos o progresso
        progresso.check

        # Adicionamos a entrada
        db.execute "INSERT INTO Arvores VALUES(#{e[1].to_sql})"
    end

    # Finliza o progresso
    progresso.stop

rescue SQLite3::Exception => e
    puts '[BUG] Error on database interaction'
    puts e
ensure
    # Fecha a db mesmo que ocoram erros
    db.close if db
end

# FINISHED :D
puts("Extraction Complete.\n" +
     "Open 'saida.csv' or 'dados.db' to see the results.\n" +
     "Thank You\n")
