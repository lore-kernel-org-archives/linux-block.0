Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45849 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbdESNRV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2017 09:17:21 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] check: add ability to exclude a test or group
Date: Fri, 19 May 2017 15:17:10 +0200
Message-Id: <20170519131710.4813-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add the ability to exclude a test or whole test group from a test
run. Thus a user can explicitly decide which tests to skip like in
this example where one wants all of the 'block' group but block/001.

block/002 (remove a device while running blktrace)
    0.835s           ...
    runtime  + test  ...
[  363.132053] run blktests block/002 at 2017-05-19 13:01:56
[  363.136844] scsi host0: scsi_debug: version 1.86 [20160430]
[  363.136844]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
[  363.138819] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0186 PQ: 0 ANSI: 7
[  363.199172] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[  363.207053] sd 0:0:0:0: [sda] Write Protect is off
block/002 (remove a device while running blktrace)           [passed]

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 check | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 26c5189b6e27..b1e7fab0aaa0 100755
--- a/check
+++ b/check
@@ -17,6 +17,17 @@
 
 . common/rc
 
+_test_is_excluded() {
+	local e
+	for e in "${@:2}"; do
+		if [[ "$e" == "$1" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
 _found_test() {
 	local test_name="$1"
 	local explicit="$2"
@@ -51,6 +62,10 @@ _found_test() {
 		return
 	fi
 
+	if _test_is_excluded $test_name ${EXCLUDE[@]}; then
+		return 1
+	fi
+
 	printf '%s\0' "$test_name"
 }
 
@@ -58,6 +73,11 @@ _found_group() {
 	local group="$1"
 
 	local test_path
+
+	if _test_is_excluded $group ${EXCLUDE[@]}; then
+		return
+	fi
+
 	while IFS= read -r -d '' test_path; do
 		_found_test "${test_path#tests/}" 0
 	done < <(find "tests/$group" -type f -name '[0-9][0-9][0-9]' -print0)
@@ -518,6 +538,9 @@ Test runs:
 			 runtime of longer tests to the given timeout,
 			 defaulting to 30 seconds)
 
+  -x, --exclude=test     exclude a test (or test group) from the list of
+			 tests to run
+
 Miscellaneous:
   -h, --help             display this help message and exit"
 
@@ -533,7 +556,7 @@ Miscellaneous:
 	esac
 }
 
-TEMP=$(getopt -o 'q::h' --long 'quick::,help' -n "$0" -- "$@")
+TEMP=$(getopt -o 'x:q::h' --long 'quick::,exclude::,help' -n "$0" -- "$@")
 if [[ $? -ne 0 ]]; then
 	exit 1
 fi
@@ -542,6 +565,7 @@ eval set -- "$TEMP"
 unset TEMP
 
 QUICK_RUN=0
+EXCLUDE=()
 while true; do
 	case "$1" in
 		'-q'|'--quick')
@@ -549,6 +573,10 @@ while true; do
 			TIMEOUT="${2:-30}"
 			shift 2
 			;;
+		'-x'|'--exclude')
+			EXCLUDE+=("$2")
+			shift 2
+			;;
 		'-h'|'--help')
 			usage out
 			;;
-- 
2.12.0
