# This is a "hidden" version of the final Snakefile if students want/need 
# to run the instructor's copy.

# our zipf analysis pipeline
DATA = glob_wildcards('books/{book}.txt').book

localrules: all, clean, make_archive

rule all:
    input:
        'zipf_analysis.tar.gz'

# delete everything so we can re-run things
# deletes a little extra for purposes of lesson prep
rule clean:
    shell:  
        '''
        rm -rf results data plots results __pycache__
        rm -f results.txt zipf_analysis.tar.gz *.out *.log *.pyc
        '''

# count words in one of our "books"
rule count_words:
    input:  
        wc='source/wordcount.py',
        book='books/{file}.txt'
    output: 'data/{file}.dat'
    threads: 4
    log: 'data/{file}.log'
    shell:
        '''
        echo "Running {input.wc} with {threads} cores on {input.book}." &> {log} &&
            ./{input.wc} {input.book} {output} >> {log} 2>&1
        '''

# create a plot for each book
rule make_plot:
    input:
        plotcount='source/plotcount.py',
        book='data/{file}.dat'
    output: 'plots/{file}.png'
    resources: gpu=1
    shell: './{input.plotcount} {input.book} {output}'

# generate summary table
rule zipf_test:
    input:  
        zipf='source/zipf_test.py',
        books=expand('data/{book}.dat', book=DATA)
    output: 'results/results.txt'
    shell:  './{input.zipf} {input.books} > {output}'

# create an archive with all of our results
rule make_archive:
    input:
        expand('plots/{book}.png', book=DATA),
        expand('data/{book}.dat', book=DATA),
        'results/results.txt'
    output: 'zipf_analysis.tar.gz'
    shell: 'tar -czvf {output} {input}'

