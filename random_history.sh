#!/bin/bash
DAYS=90
for i in $(seq 1 $DAYS); do
  DATE=$(date -v-${i}d +%Y-%m-%d)
  if [ $((RANDOM % 3)) -eq 0 ]; then continue; fi
  COMMITS=$((RANDOM % 3 + 1))
  for j in $(seq 1 $COMMITS); do
    # Реалистичные изменения
    echo "Update $j on $DATE" >> CHANGELOG.md
    touch file_$j.txt  # Новый файл
    git add .
    GIT_AUTHOR_DATE="$DATE 14:00:00" GIT_COMMITTER_DATE="$DATE 14:00:00" git commit -m "Progress: $DATE #$j"
  done
done
git push origin main
