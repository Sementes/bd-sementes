i = 0
z = 0
k = 0
lista = []
while i < x.length do
    if x[i][0] == 'VARIEDADE' then
        z = 0
        i += 2
        k += 1
        while x[i][0] != 'Nº DE' do
            #print "#{x[i][0]}\n"
            lista.push x[i][0]
            i += 1
            z += 1
        end
    else
        if z != 0  && z != 18 then 
            i -= 1
            print "Z = #{z}\n"
            z.downto(1) do |e|
                print "#{x[i-e][0]}\n"
            end
            print "#{k}\n=============\n"
            z = 0
        end
        i += 1
    end
end


=====================================

id_list = []
ref_list = []

arquivo = IO.readlines 'test1.csv'
i = 0

while i < arquivo.length do
    if arquivo[i] == "VARIEDADE\r\n" then
        arquivo[i] = "======\r\n"
        i += 1
        while arquivo[i] != "Nº DE\r\n" do
            id_list.push arquivo[i]
            arquivo[i] = ''
            i += 1
        end
    else
        i += 1
    end
end

id_list.sort.each do |e|
    puts e
end

first_ref = arquivo.find_index "REF\r\n"

i = first_ref
while i < arquivo.length do
    if arquivo[i] == "REF\r\n" then
        arquivo[i] = "=======\r\n"

        i += 1

        while arquivo[i] != "CLASSIFICAÇÃO\r\n" do
            ref_list.push arquivo[i]
            arquivo[i] = ''
            i += 1
        end
    else
        i += 1
    end
end

ref_list.sort.each do |e|
    puts e 
end

=====================================

class Semente
    @nome
    @sigla
    @id
    @foto
    @nomes_cientificos = []

    @n_sementes_g
    @n_dias_germinacao
    @necessidade_kg_ha

    @ciclo_dias_ver
    @ciclo_dias_inv
    @espacamento_linha_plantas

    @epoca_plantio_R1
    @epoca_plantio_R2
    @epoca_plantio_R3

    @descricao
    @tamanho

    attr_accessor :nome, :sigla, :id, :foto, :nomes_cientificos, :n_sementes_g, :n_dias_germinacao
    attr_accessor :necessidade_kg_ha, :ciclo_dias_inv, :espacamento_linha_plantas, :epoca_plantio_R1
    attr_accessor :epoca_plantio_R2, :epoca_plantio_R3, :descricao, :tamanho

    def initialize nome, sigla, id
        @nome, @sigla, @id = nome, sigla, id
        @nomes_cientificos = []
    end

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

    def to_s
        return  "nome: #{@nome}," +
                "sigla: #{@sigla}," +
                "id: #{@id}," +
                "foto: #{@foto}," +
                "nomes_cientificos: #{@nomes_cientificos.to_s}," +
                "n_sementes_g: #{@n_sementes_g}," +
                "n_dias_germinacao: #{@n_dias_germinacao}," +
                "necessidade_kg_ha: #{@necessidade_kg_ha}," +
                "ciclo_dias_inv: #{@ciclo_dias_inv}," +
                "ciclo_dias_ver: #{@ciclo_dias_ver}," +
                "espacamento_linha_plantas: #{@espacamento_linha_plantas}," +
                "epoca_plantio_R1: #{@epoca_plantio_R1}," +
                "epoca_plantio_R2: #{@epoca_plantio_R2}," +
                "epoca_plantio_R3: #{@epoca_plantio_R3}," +
                "descricao: #{@descricao}," +
                "tamanho: #{@tamanho}"
    end
end

plantas = Hash.new
k = 0
id_list.each do |e|
    i = 0

    while i < arquivo.length && ( !arquivo[i].start_with?(e.gsub(/\r\n?/,'')) || (arquivo[i] =~ /^[^A-Za-z]+$/).nil?) do
        i += 1
    end

    if i != arquivo.length then

        if !arquivo[i].end_with?(",\"\"\r\n") then
            arquivo[i] = arquivo[i].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        2.times do |x|
            if !arquivo[i-(x+1)].start_with?('"",') then
                arquivo[i-(x+1)] = '"",' + arquivo[i-(x+1)]
            end

            if !arquivo[i+(x+1)].end_with?(",\"\"\r\n") then
                arquivo[i+(x+1)] = arquivo[i+(x+1)].gsub(/\r\n?/,'') + ",\"\"\r\n"
            end
        end

        if !arquivo[i+3].end_with?(",\"\"\r\n") then
            arquivo[i+3] = arquivo[i+3].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        id = CSV.parse(arquivo[i])[0][0].to_i

        plantas[id] = Semente.new( CSV.parse(arquivo[i - 2])[0][1], CSV.parse(arquivo[i - 1])[0][1], id)

        e = id;

        3.times do |x|
            plantas[id].nomes_cientificos.push(CSV.parse(arquivo[i + (x + 1)])[0][0])
        end

        z = i - 2
        6.times do |x|
            arquivo[z + x] = ''
        end


        puts "\n=============================="
        print plantas[id].to_s

    else
        k += 1
        puts "not found #{e}"
    end
end

print "Not found ID's = #{k} \n"

class Arvore
    @nome
    @id
    @foto
    @nomes_cientificos

    @classificacao
    @bioma
    @regiao_de_origem
    @caracteristicas

    attr_accessor :nome, :id, :foto, :nomes_cientificos
    attr_accessor :classificacao, :bioma, :regiao_de_origem, :caracteristicas

    def initialize nome, id
        @nome, @id = nome, id
        @nomes_cientificos = []
    end

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

first_ref -= 13
arvores = Hash.new
k = 0

ref_list.each do |e|
    i = first_ref

    while i < arquivo.length && ( !arquivo[i].start_with?(e.gsub(/\r\n?/,'')) || (arquivo[i] =~ /^[^A-Za-z]+$/).nil?) do
        i += 1
    end

    if i != arquivo.length then
        if !arquivo[i].end_with?(",\"\"\r\n") then
            arquivo[i] = arquivo[i].gsub(/\r\n?/,'') + ",\"\"\r\n"
        end

        if !arquivo[i-1].start_with?('"",') then
            arquivo[i-1] = '"",' + arquivo[i-(x+1)]
        end

        id = CSV.parse(arquivo[i])[0][0].to_i
        nome = CSV.parse(arquivo[i - 1])[0][1]
        arvores[id] = Arvore.new(nome, id)
        e = id

        x = 1
        while x + i < arquivo.length && !arquivo[i].empty? && !arquivo[i+x].start_with?('"",') && arquivo[i + x] != "=======\r\n" do
            if !arquivo[i+x].end_with?(",\"\"\r\n") then
                arquivo[i+x] = arquivo[i+x].gsub(/\r\n?/,'') + ",\"\"\r\n"
            end

            arvores[id].nomes_cientificos.push CSV.parse(arquivo[i + x])[0][0]
            arquivo[i + x] = ''
            x += 1
        end

        arquivo[i] = ''
        arquivo[i - 1] = ''

        puts "\n=============================="

        print arvores[id].to_s
    else
        k += 1
        puts "not found #{e}"
    end
end

print "Not found ID's = #{k} \n"

=====================================

arquivo[18] = ''

arquivo_pronto = open('dados2.csv', 'w') 
arquivo_pronto.truncate(0)

arquivo.each do |e|
    arquivo_pronto.write e
end

arquivo_pronto.close

=====================================
