#!/bin/bash
# vim: dict=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   runtest.sh of upload-scp
#   Description: Test reporter-upload and scp uploading
#   Author: Richard Marko <rmarko@redhat.com>
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

TEST="upload-scp"
PACKAGE="abrt"

rlJournalStart
    rlPhaseStartSetup
        TmpDir=$(mktemp -d)
        cp -R problem_dir $TmpDir
        pushd $TmpDir
        mkdir target
    rlPhaseEnd

    rlPhaseStartTest "scp upload, filename set"
        rlRun "reporter-upload -d problem_dir -u scp://root:redhat@localhost$TmpDir/target/upload.tar.gz"
        rlAssertExists "$TmpDir/target/upload.tar.gz"
        rm -rf "$TmpDir/target/upload.tar.gz"
    rlPhaseEnd

    rlPhaseStartTest "scp upload, filename not set"
        rlRun "reporter-upload -d problem_dir -u scp://root:redhat@localhost$TmpDir/target/"
        rlAssertExists $TmpDir/target/abrt-upload*
    rlPhaseEnd

    rlPhaseStartCleanup
        popd # TmpDir
        rm -rf $TmpDir
    rlPhaseEnd
    rlJournalPrintText
rlJournalEnd
