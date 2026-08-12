#export PYTHONPATH=$(python3 -c "import site; print(site.getsitepackages()[0])"):$PYTHONPATH
#./run  && unset PYTHONPATH

export PYTHONPATH=$(python3 -c "import site; print(site.getsitepackages()[0])"):$PYTHONPATH
venvPath="/media/mint/dataku1/backup/kodeku/phphai/python/venv"
#./run  && unset PYTHONPATH
$venvPath//bin/python3 run.py

