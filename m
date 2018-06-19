Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43081 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757240AbeFSUYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 16:24:09 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 3/9] check, tests/meta/012: Use array["index"] instead of array[index]
Date: Tue, 19 Jun 2018 13:23:47 -0700
Message-Id: <20180619202353.23631-4-bart.vanassche@wdc.com>
In-Reply-To: <20180619202353.23631-1-bart.vanassche@wdc.com>
References: <20180619202353.23631-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This causes shellcheck to stop complaining about these array element
accesses.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check          | 46 +++++++++++++++++++++++-----------------------
 tests/meta/012 |  4 ++--
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/check b/check
index 5e1ba7bc8401..5f53fa105f72 100755
--- a/check
+++ b/check
@@ -156,11 +156,11 @@ declare -A TEST_RUN
 _read_last_test_run() {
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 
-	LAST_TEST_RUN[date]=""
-	LAST_TEST_RUN[status]=""
-	LAST_TEST_RUN[reason]=""
-	LAST_TEST_RUN[exit_status]=""
-	LAST_TEST_RUN[runtime]=""
+	LAST_TEST_RUN["date"]=""
+	LAST_TEST_RUN["status"]=""
+	LAST_TEST_RUN["reason"]=""
+	LAST_TEST_RUN["exit_status"]=""
+	LAST_TEST_RUN["runtime"]=""
 
 	if [[ ! -e $seqres ]]; then
 		return
@@ -247,9 +247,9 @@ _output_test_run() {
 	fi
 
 	if [[ -v TEST_DEV ]]; then
-		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" "${TEST_RUN[status]}ed"
+		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" "${TEST_RUN["status"]}ed"
 	else
-		_output_status "$TEST_NAME" "${TEST_RUN[status]}ed"
+		_output_status "$TEST_NAME" "${TEST_RUN["status"]}ed"
 	fi
 
 	(
@@ -306,14 +306,14 @@ _call_test() {
 	_read_last_test_run
 	_output_last_test_run
 
-	TEST_RUN[date]="$(date "+%F %T")"
+	TEST_RUN["date"]="$(date "+%F %T")"
 
 	mkdir -p "$(dirname "$seqres")"
 	# Remove leftovers from last time.
 	rm -f "${seqres}" "${seqres}."*
 
 	if [[ -w /dev/kmsg ]]; then
-		local dmesg_marker="run blktests $TEST_NAME at ${TEST_RUN[date]}"
+		local dmesg_marker="run blktests $TEST_NAME at ${TEST_RUN["date"]}"
 		echo "$dmesg_marker" >> /dev/kmsg
 	else
 		local dmesg_marker=""
@@ -328,35 +328,35 @@ _call_test() {
 	TIMEFORMAT="%Rs"
 	pushd . >/dev/null || return
 	{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runtime"
-	TEST_RUN[exit_status]=$?
+	TEST_RUN["exit_status"]=$?
 	popd >/dev/null || return
-	TEST_RUN[runtime]="$(cat "${seqres}.runtime")"
+	TEST_RUN["runtime"]="$(cat "${seqres}.runtime")"
 	rm -f "${seqres}.runtime"
 
 	_cleanup
 
 	if ! diff "tests/${TEST_NAME}.out" "${seqres}.out" >/dev/null; then
 		mv "${seqres}.out" "${seqres}.out.bad"
-		TEST_RUN[status]=fail
-		TEST_RUN[reason]=output
-	elif [[ ${TEST_RUN[exit_status]} -ne 0 ]]; then
-		TEST_RUN[status]=fail
-		TEST_RUN[reason]="exit"
+		TEST_RUN["status"]=fail
+		TEST_RUN["reason"]=output
+	elif [[ ${TEST_RUN["exit_status"]} -ne 0 ]]; then
+		TEST_RUN["status"]=fail
+		TEST_RUN["reason"]="exit"
 	elif ! _check_dmesg "$dmesg_marker"; then
-		TEST_RUN[status]=fail
-		TEST_RUN[reason]=dmesg
+		TEST_RUN["status"]=fail
+		TEST_RUN["reason"]=dmesg
 	else
-		TEST_RUN[status]=pass
+		TEST_RUN["status"]=pass
 	fi
 	rm -f "${seqres}.out"
 
 	_write_test_run
 	_output_test_run
 
-	if [[ ${TEST_RUN[status]} = pass ]]; then
+	if [[ ${TEST_RUN["status"]} = pass ]]; then
 		return 0
 	else
-		case "${TEST_RUN[reason]}" in
+		case "${TEST_RUN["reason"]}" in
 		output)
 			diff -u "tests/${TEST_NAME}.out" "${seqres}.out.bad" | awk "
 			{
@@ -369,7 +369,7 @@ _call_test() {
 			}"
 			;;
 		exit)
-			echo "    exited with status ${TEST_RUN[exit_status]}"
+			echo "    exited with status ${TEST_RUN["exit_status"]}"
 			;;
 		dmesg)
 			echo "    something found in dmesg:"
@@ -432,7 +432,7 @@ _run_test() {
 
 _run_group() {
 	local tests=("$@")
-	local group="${tests[0]%/*}"
+	local group="${tests["0"]%/*}"
 
 	# shellcheck disable=SC1090
 	. "tests/${group}/group"
diff --git a/tests/meta/012 b/tests/meta/012
index fcf8fbdde2aa..ab8c2a73eaa5 100755
--- a/tests/meta/012
+++ b/tests/meta/012
@@ -22,8 +22,8 @@ DESCRIPTION="record pid and random junk"
 test() {
 	echo "Running ${TEST_NAME}"
 	sleep 1
-	TEST_RUN[pid]=$$
-	TEST_RUN[random]="$(od -N $((4 * (RANDOM % 4))) -An -vtx1 /dev/urandom | tr -d ' \n')"
+	TEST_RUN["pid"]=$$
+	TEST_RUN["random"]="$(od -N $((4 * (RANDOM % 4))) -An -vtx1 /dev/urandom | tr -d ' \n')"
 	TEST_RUN[$$]=hello
 	echo "Test complete"
 }
-- 
2.17.1
