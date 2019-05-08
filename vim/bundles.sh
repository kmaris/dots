#!/bin/bash -eu

## Manage vim bundles. Specify with the -s option to regenerate $BUNDLE_URLS
## with the repositories that are either present or unaccounted for.

VIMDIR="$(dirname $0)"
BUNDLES_DIR="$VIMDIR/bundles"
BUNDLE_URLS="$VIMDIR/bundle_urls"

if [ ! -f "$BUNDLE_URLS" ] ; then
  echo "Missing url file: $BUNDLE_URLS"
  exit 1
fi

case "${1:-}" in
  "-s")
    echo "Regenerating $BUNDLES_URLS from repositories in $BUNDLES_DIR..."
    find $BUNDLES_DIR -type d -name .git -exec git -C {} remote get-url origin \; | \
      cat - $BUNDLE_URLS | sort -u > $BUNDLE_URLS
    ;;
  "-c")
    echo "Cleaning out repositories and cloning..."
    find $BUNDLES_DIR -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} \;
    ;;
esac

GIT_PIDS=""
while read url; do
  [[ $url =~ ^[[:space:]]*# ]] && continue # Ignore lines starting with '#'.
  name="${url##*/}"
  if [ ! -d $BUNDLES_DIR/$name ] ; then
    echo "Cloning $name to $BUNDLES_DIR/"
    git -C $BUNDLES_DIR clone --quiet $url &
  else
    echo "Updating $name"
    git -C $BUNDLES_DIR/$name pull --quiet &
  fi
  GIT_PIDS+="$! "
done < $BUNDLE_URLS

printf "Waiting for clones/pulls to complete.."
for i in $(seq 1 10) ; do printf "." ; sleep 2 ; done &
PRINTF_PID="$!"
wait $GIT_PIDS
kill $PRINTF_PID
printf " done.\n"
