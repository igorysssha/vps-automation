#!/bin/bash
START_DATE="2025-02-01"
END_DATE=$(date +%Y-%m-%d)
DAYS=$(( ($(date -j -f "%Y-%m-%d" "$END_DATE" +%s) - $(date -j -f "%Y-%m-%d" "$START_DATE" +%s)) / 86400 + 1 ))
TARGET_DAYS=60

for i in $(seq 1 $DAYS); do
  if [ $((RANDOM % $DAYS)) -ge $TARGET_DAYS ]; then continue; fi  # ~60 дней
  DATE=$(date -v-${i}d +%Y-%m-%d)
  COMMITS=$((RANDOM % 3 + 1))
  for j in $(seq 1 $COMMITS); do
    echo "Update $j on $DATE" >> CHANGELOG.md
    touch file_$j.txt
    git add .
    GIT_AUTHOR_DATE="$DATE 14:00:00" GIT_COMMITTER_DATE="$DATE 14:00:00" git commit -m "Progress: $DATE #$j"
  done
done
git push origin main
