# DIR_PRJ=/home/laptq/CogVideo
# VENV_PARENT=/mnt/hdd10tb/Users/laptq/CogVideo
DIR_PRJ=/home/lap_awlv/Wan2.2
VENV_PARENT=/media/home4/free_space/lap_awlv/Wan2.2

mkdir -p $VENV_PARENT

VENV_NAME=.venv
VENV_PATH=$VENV_PARENT/$VENV_NAME
[[ ! -d $VENV_PATH ]] && python3 -m venv $VENV_PATH

if [ $( realpath "$VENV_PARENT" ) != $( realpath "$DIR_PRJ" ) ]; then
    ln -sf $VENV_PATH $DIR_PRJ/
fi

source $DIR_PRJ/$VENV_NAME/bin/activate
which python3

pip install torch>=2.4.0 torchvision>=0.19.0 --index-url https://download.pytorch.org/whl/cu118
pip install -r requirements.txt --default-timeout=10000

# install flass_attn
cd ~
[[ ! -f ninja-linux.zip ]] && wget https://github.com/ninja-build/ninja/releases/download/v1.13.1/ninja-linux.zip && unzip ninja-linux.zip
export PATH=$PATH:$(pwd)
python -m pip install --upgrade pip wheel setuptools
pip install flash_attn --no-build-isolation

pip install "huggingface_hub[cli]"