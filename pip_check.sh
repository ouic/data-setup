REQUIRED=('pytest' 'pylint' 'ipdb' 'pyyaml' 'nbresult' 'autopep8' 'flake8' 'yapf' 'lxml' 'requests' 'bs4' 'jupyterlab' 'pandas' 'matplotlib' 'seaborn' 'plotly' 'scikit-learn' 'tensorflow' 'nbconvert' 'xgboost' 'statsmodels' 'pandas-profiling' 'jupyter-resource-usage' 'dtale')
PACKAGES=$(pip freeze)
PACKS=()
while read -r line; do
   PACKS+=("$line")
done <<< "$PACKAGES"
missing=()
for r in ${REQUIRED[@]}; do
  present=0
  for p in ${PACKS[@]}; do
    if (($present == 0)); then
      q=${p//==[0-9|\.]*/} #
      if [ $r = ${q:l} ]; then
        present=1
      fi
    fi
  done
  if (($present == 0))
  then
    missing+=($r)
  fi
done
if (( ${#missing[@]} )); then
  sentence='Try to `pip install '
  sentence+=$missing
  sentence+='` again.'
  echo '❌ Some packages are missing:'
  echo $sentence
else
  echo '✅ Everything is fine, continue the setup intructions.'
fi
