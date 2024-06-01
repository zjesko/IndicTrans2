#!/bin/bash

#SBATCH -A research
#SBATCH -n 40
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=2048
#SBATCH --time=4-00:00:00
#SBATCH --output=logs.out
#SBATCH --mail-type=END

rm -rf /scratch/jesko/proto50
mkdir -p /scratch/jesko/proto50

ls /scratch/jesko/proto50/model

module add u18/cuda/12.1
module add u18/cudnn/8.4.0-cuda-11.6

source ~/.bashrc

# This script trains the translation model on the binarized data using fairseq.


echo `date`
exp_dir="proto50"                              # path of the experiment directory
out_dir="/scratch/jesko/proto50"
model_arch=${2:-"transformer_med"}    # model architecture (defaults to `transformer_18_18`)

fairseq-train $exp_dir/final_bin \
--max-source-positions=256 \
--max-target-positions=256 \
--source-lang=SRC \
--target-lang=TGT \
--max-epoch=8 \
--save-interval-updates=2500 \
--arch=$model_arch \
--activation-fn gelu \
--criterion=label_smoothed_cross_entropy \
--label-smoothing=0.1 \
--optimizer adam \
--adam-betas "(0.9, 0.98)" \
--lr-scheduler=inverse_sqrt \
--clip-norm 1.0 \
--warmup-init-lr 1e-07 \
--lr 5e-4 \
--warmup-updates 4000 \
--dropout 0.2 \
--save-dir $out_dir/model \
--keep-last-epochs 1 \
--keep-interval-updates 1 \
--patience 10 \
--skip-invalid-size-inputs-valid-test \
--user-dir model_configs \
--update-freq=32 \
--distributed-world-size 2 \
--num-workers 32 \
--max-tokens 256 \
--eval-bleu \
--eval-bleu-args "{\"beam\": 1, \"lenpen\": 1.0, \"max_len_a\": 1.2, \"max_len_b\": 10}" \
--eval-bleu-detok moses \
--eval-bleu-remove-bpe sentencepiece \
--eval-bleu-print-samples \
--best-checkpoint-metric bleu \
--maximize-best-checkpoint-metric \
--task translation \
--wandb-project thesis-ft \
--ddp-backend=no_c10d \
--find-unused-parameters \
--batch-size=16