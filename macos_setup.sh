#!/bin/bash
echo "Creating virtual environment 'raftenv'."
python -m venv raftenv
# Add environment variable for falling back on CPU for any 
# operations not currently implemented on MPS.
echo "export PYTORCH_ENABLE_MPS_FALLBACK=1" >> raftenv/bin/activate
# Activate the environment
. ./raftenv/bin/activate

echo "Installing dependencies via pip."
pip install --upgrade pip
pip install -r requirements.txt

# Nightly build used for the moment since pip hasnt got the
# latest version of PyTorch with M1 GPU Acceleration.
echo "Installing nightly build of PyTorch."
pip install -U --pre torch torchvision torchaudio \
    --extra-index-url https://download.pytorch.org/whl/nightly/cpu

echo "Installing 7-zip"
brew update && brew install p7zip wget

echo "Downloading datasets"
./shell_scripts/download_datasets.sh
./shell_scripts/download_middlesbury_2014.sh

echo "Downloading pre-trained models"
./shell_scripts/download_models.sh

echo "Done."