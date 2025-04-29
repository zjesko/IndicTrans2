#!/bin/bash


# # prepare domain data for grid search
# for i in AI Ch Go La Md X g
#     do
#         rm -rf eval_benchmarks/${i}/grid-search-data/*
#         for j in AI Ch Go La Md X g
#             do
#                 mkdir -p eval_benchmarks/${i}/grid-search-data/en${j}_Latn-hin_Deva
#                 rsync -av --exclude='*protoDmix*' eval_benchmarks/${i}/X/enX_Latn-hin_Deva/ eval_benchmarks/${i}/grid-search-data/en${j}_Latn-hin_Deva
#                 mv eval_benchmarks/${i}/grid-search-data/en${j}_Latn-hin_Deva/test.enX_Latn eval_benchmarks/${i}/grid-search-data/en${j}_Latn-hin_Deva/test.en${j}_Latn
#             done
#     done


# # prepare flores data for grid search
# rm -rf eval_benchmarks/flores/grid-search-data/*
# for j in AI Ch Go La Md X g
#     do
#         mkdir -p eval_benchmarks/flores/grid-search-data/en${j}_Latn-hin_Deva
#         rsync -av --exclude='*proto*' eval_benchmarks/flores/eng_Latn-hin_Deva/ eval_benchmarks/flores/grid-search-data/en${j}_Latn-hin_Deva
#         mv eval_benchmarks/flores/grid-search-data/en${j}_Latn-hin_Deva/test.eng_Latn eval_benchmarks/flores/grid-search-data/en${j}_Latn-hin_Deva/test.en${j}_Latn
#     done


# run eval grid-search on proto50 as background processes
./eval.sh eval_benchmarks/flores/grid-search-data proto50 proto50 &
for j in AI Ch Go La Md 
    do
    ./eval.sh eval_benchmarks/${j}/grid-search-data proto50 proto50 &    
    done

