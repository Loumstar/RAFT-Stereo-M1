#!/bin/bash
echo "Creating virtual environment 'raft-venv'"
python -m venv raft-venv
. ./raft-venv/bin/activate

echo "Installing dependencies via pip"
pip install --upgrade pip
pip install -r requirements.txt

# Nightly build used for the moment since pip hasn't got the
# latest version of PyTorch with M1 GPU Acceleration.
echo "Install nightly build of PyTorch"
pip install -U --pre torch torchvision torchaudio \
    --extra-index-url https://download.pytorch.org/whl/nightly/cpu

echo "Installing 7-zip"
brew update && brew install p7zip wget

echo "Downloading datasets and models"
./shell-scripts/download_datasets.sh
./shell-scripts/download_middlesbury.sh
./shell-scripts/download_models.sh

echo "Done."