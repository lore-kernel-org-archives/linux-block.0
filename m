Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54564 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751801AbdLTJIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 04:08:50 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
To: <osandov@osandov.com>, <jthumshirn@suse.de>
CC: <linux-block@vger.kernel.org>, xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH blktests] Fix syntax error with bash v4.1.2(e.g RHEL6)
Date: Wed, 20 Dec 2017 17:05:09 +0800
Message-ID: <1513760709-2766-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

-v option is not supported by conditional expressions on
bash v4.1.2, so we use -n instead of -v to fix this issue.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 check            | 12 ++++++------
 common/fio       |  2 +-
 common/rc        |  2 +-
 tests/meta/group |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/check b/check
index 95d269a..7fbdc70 100755
--- a/check
+++ b/check
@@ -178,7 +178,7 @@ _output_status() {
 	local test="$1"
 	local status="$2"
 
-	if [[ -v DESCRIPTION ]]; then
+	if [[ -n $DESCRIPTION ]]; then
 		printf '%-60s' "$test ($DESCRIPTION)"
 	else
 		printf '%-60s' "$test"
@@ -215,7 +215,7 @@ _output_notrun() {
 }
 
 _output_last_test_run() {
-	if [[ -v TEST_DEV ]]; then
+	if [[ -n $TEST_DEV ]]; then
 		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" ""
 	else
 		_output_status "$TEST_NAME" ""
@@ -240,7 +240,7 @@ _output_test_run() {
 		tput cuu $((${#LAST_TEST_RUN[@]} - 3))
 	fi
 
-	if [[ -v TEST_DEV ]]; then
+	if [[ -n $TEST_DEV ]]; then
 		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" "${TEST_RUN[status]}ed"
 	else
 		_output_status "$TEST_NAME" "${TEST_RUN[status]}ed"
@@ -270,7 +270,7 @@ _output_test_run() {
 }
 
 _cleanup() {
-	if [[ -v TMPDIR ]]; then
+	if [[ -n $TMPDIR ]]; then
 		rm -rf "$TMPDIR"
 		unset TMPDIR
 	fi
@@ -282,7 +282,7 @@ _cleanup() {
 		unset TEST_DEV_QUEUE_SAVED["$key"]
 	done
 
-	if [[ -v RESTORE_CPUS_ONLINE ]]; then
+	if [[ -n $RESTORE_CPUS_ONLINE ]]; then
 		local cpu
 		for cpu in "${!CPUS_ONLINE_SAVED[@]}"; do
 			echo "${CPUS_ONLINE_SAVED["$cpu"]}" >"/sys/devices/system/cpu/cpu$cpu/online"
@@ -599,7 +599,7 @@ while true; do
 	esac
 done
 
-if [[ QUICK_RUN -ne 0 && ! -v TIMEOUT ]]; then
+if [[ QUICK_RUN -ne 0 && ! -n $TIMEOUT ]]; then
 	_error "QUICK_RUN specified without TIMEOUT"
 fi
 
diff --git a/common/fio b/common/fio
index f5787b4..eb21038 100644
--- a/common/fio
+++ b/common/fio
@@ -160,7 +160,7 @@ _fio_perf() {
 # You should usually use this instead of calling fio directly.
 _run_fio() {
 	local args=("--output=$TMPDIR/fio_perf" "--output-format=terse" "--terse-version=4" "--group_reporting=1")
-	if [[ -v TIMEOUT ]]; then
+	if [[ -n $TIMEOUT ]]; then
 		args+=("--runtime=$TIMEOUT")
 	fi
 	fio "${args[@]}" "$@"
diff --git a/common/rc b/common/rc
index 09ce4ef..0fdab99 100644
--- a/common/rc
+++ b/common/rc
@@ -35,7 +35,7 @@ _error() {
 # for TIMEOUT / number of subtests.
 _divide_timeout() {
 	local num_tests="$1"
-	if [[ -v TIMEOUT ]]; then
+	if [[ -n $TIMEOUT ]]; then
 		((TIMEOUT = (TIMEOUT + num_tests - 1) / num_tests))
 	fi
 }
diff --git a/tests/meta/group b/tests/meta/group
index 4281ea1..012a700 100644
--- a/tests/meta/group
+++ b/tests/meta/group
@@ -18,7 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 group_requires() {
-	if [[ -v META_REQUIRES_SKIP ]]; then
+	if [[ -n $META_REQUIRES_SKIP ]]; then
 		SKIP_REASON="META_REQUIRES_SKIP was set"
 		return 1
 	fi
@@ -26,7 +26,7 @@ group_requires() {
 }
 
 group_device_requires() {
-	if [[ -v META_DEVICE_REQUIRES_SKIP ]]; then
+	if [[ -n $META_DEVICE_REQUIRES_SKIP ]]; then
 		SKIP_REASON="META_DEVICE_REQUIRES_SKIP was set"
 		return 1
 	fi
-- 
1.8.3.1
