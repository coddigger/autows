git config --global user.email "n.andersen@f5.com"
git config --global user.name "n-andersen"
git config --global push.default simple
git add -A
git commit -m "Code Updates - $(date)"
git push 