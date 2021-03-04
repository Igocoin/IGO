#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

IGOCOIND=${IGOCOIND:-$BINDIR/igocoind}
IGOCOINCLI=${IGOCOINCLI:-$BINDIR/igocoin-cli}
IGOCOINTX=${IGOCOINTX:-$BINDIR/igocoin-tx}
IGOCOINQT=${IGOCOINQT:-$BINDIR/qt/igocoin-qt}

[ ! -x $IGOCOIND ] && echo "$IGOCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
IGOVER=($($IGOCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for igocoind if --version-string is not set,
# but has different outcomes for igocoin-qt and igocoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$IGOCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $IGOCOIND $IGOCOINCLI $IGOCOINTX $IGOCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${IGOVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${IGOVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
