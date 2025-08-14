
export HF_HOME="/media/home4/free_space/lap_awlv/cache/huggingface"

PATHD_OUTPUT=/home/lap_awlv/Wan2.2/outputs/wan2.2-1
mkdir -p $PATHD_OUTPUT

huggingface-cli download Wan-AI/Wan2.2-T2V-A14B --local-dir ./Wan2.2-T2V-A14B

# CUDA_VISIBLE_DEVICES=2,3 OMP_NUM_THREADS=1 torchrun --nproc_per_node=2 \
#     --master_port=25678 \
#     generate.py \
#     --task t2v-A14B \
#     --size 720*1280 \
#     --ckpt_dir ./Wan2.2-T2V-A14B \
#     --dit_fsdp \
#     --t5_fsdp \
#     --ulysses_size 2 \
#     --prompt "A full-body view from a fixed surveillance camera shows a man holding a product at waist height, pausing briefly, then slowly placing the item into his shoulder bag, using both hands while staying in the same spot. The surveillance camera is far away and static across frames, always capturing the whole body of the person in every frame." \
#     --frame_num 160 \
#     --save_file $PATHD_OUTPUT/01.mp4

CUDA_VISIBLE_DEVICES=2 python generate.py  \
    --task t2v-A14B \
    --size 480*832 \
    --ckpt_dir ./Wan2.2-T2V-A14B \
    --offload_model True \
    --convert_model_dtype \
    --prompt "A full-body view from a fixed surveillance camera shows a man holding a product at waist height, pausing briefly, then slowly placing the item into his shoulder bag, using both hands while staying in the same spot. The surveillance camera is far away and static across frames, always capturing the whole body of the person in every frame." \
    --frame_num 161 \
    --save_file $PATHD_OUTPUT/01.mp4


# nproc_per_node == ulysses_size == num gpus