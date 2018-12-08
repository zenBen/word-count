rule compile_results:
    input:
        'source/zipf_test.py',
        'processed_data/abyss.dat',
        'processed_data/isles.dat',
        'processed_data/last.dat',
    output: 'results/results.txt'
    shell: 'python {input} > {output}'

rule alldata:
     input:
         'processed_data/isles.dat',
         'processed_data/abyss.dat',
         'processed_data/last.dat',
         'results/results.txt'

rule count_words:
    input:
        wc = 'source/wordcount.py',
        book = 'data/{file}.txt'
    output: 'processed_data/{file}.dat'
    shell: 'python {input.wc} {input.book} {output}'

rule clean:
    shell:
        'rm -f processed_data/*.dat & rm -f results/results.txt'

