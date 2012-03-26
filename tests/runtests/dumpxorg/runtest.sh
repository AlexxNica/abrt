#!/bin/bash
# vim: dict=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   runtest.sh of abrt-dump-xorg
#   Description: looks for xorg crashes via abrt-dump-xorg
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   Copyright (c) 2011 Red Hat, Inc. All rights reserved.
#
#   This program is free software: you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation, either version 3 of
#   the License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#   PURPOSE.  See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see http://www.gnu.org/licenses/.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

. /usr/share/beakerlib/beakerlib.sh

TEST="dumpxorg"
PACKAGE="abrt"

rlJournalStart
    #rlPhaseStartSetup
    #    TmpDir=$(mktemp -d)
    #    tar xf examples.tar -C $TmpDir
    #    rlRun "pushd $TmpDir/examples"
    #rlPhaseEnd

    rlPhaseStartTest XORG
        for f in crash*.test; do
            b=${f%.test}
            rlRun "
abrt-dump-xorg -o $f >$b.out $f 2>&1
diff -u $b.right $b.out >$b.diff 2>&1 && rm $b.out $b.diff
" 0 "[$f] Good output"
        done
    rlPhaseEnd

    #rlPhaseStartTest not-OOPS
    #    for noops in not_oops*.test; do
    #        rlRun "abrt-dump-xorg $noops 2>&1 | grep 'abrt-dump-xorg: Found oopses: 0'" 0 "[$noops] Not found OOPS"
    #    done
    #rlPhaseEnd

    #rlPhaseStartCleanup
    #    rlRun "popd"
    #    rlRun "rm -r $TmpDir" 0 "Removing tmp directory"
    #rlPhaseEnd
    rlJournalPrintText
rlJournalEnd
