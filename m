Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AE158A0B
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945607; cv=none; b=EU1v5jP5xU4gVdBf3Ui3iGNlAU4LSE5i90fqfuchgWjpF2edbr1KfaEQKARAAoVjrk+J4RLWSnVl6w9E1B6FuUQcg0sqBBhOXlitJJUOW8+IGmFth80k4dumvqtEgKcwkY6sYOc7rfiJLUjwq8U6s0eNBNbBszaDEUSgmTiD/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945607; c=relaxed/simple;
	bh=ZLlifhfpZJXP+J/JjbvB5VBhA8XjzFfCMvsSmzXLv0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkESW3kd/MKSt1RkEDFvyq1VIaN+QIRO5lrGBCSlkywOkaaxtz43xjRVFWtLt0SrPx1UQ5HAQ+K2rQ4krjUFn4Bh8CSzdgWb5PTlBbDV47hXQEBM7P1mNOJMa49gGjTtGf63VLmk8IGR/6+XW/sseZHrXpT/XZ+3UrHIu3FiycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JS+aRe7j; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JS+aRe7j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945605; x=1745481605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLlifhfpZJXP+J/JjbvB5VBhA8XjzFfCMvsSmzXLv0w=;
  b=JS+aRe7jnjPX+v6fZUmeA7dVSl3YbmcT2CSZNQyczaDq1BAa/epx8L89
   wrX9LgRGmofmRbBU7CmV5pZoPbWYqqe7DWx8pzTtbLbLOveIFUauG167U
   a1DDL9PoKnJYRI8d2rQfIySaz9jQMgtT3OfCOJAsesaJAJ1XCqyCzx/9c
   Kd7sdo0oDf6WFXcCqU24EnLP+3Idd5T3TmrvEMB3AMXW6uJvJ6i7Nb+Y7
   0l33L/ywqGgDDe2m9A0Fa+SHMCxdGs5Ep8U5zv9WuxUpQmXrBDJYGCizk
   beVkwSmOAmWGgEhx2ldwGpWgbUdG6usxeyr6QHWVIvk+z/qmrctoJSNZJ
   Q==;
X-CSE-ConnectionGUID: O0cF8cNnR9aVj5wOObV98Q==
X-CSE-MsgGUID: wCxSSeZ1RPCjaUUgfpaqXA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515672"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:58 +0800
IronPort-SDR: mcJCSdHUuKZpi6aJH6VdMuEodqHggPyFWISdK+Z9q1BDZMTELCijGcP8IERrHJ3LR9oBFAKfuk
 5zM6K7iuAaRNCVhG66T5XmqGQghyFecGNm5BCuxtgLHlVrUpmy6LhisruewAzhtN+ysSSubUGU
 WDMTnGSFBW4Zxqg7G/iBQenDMTyLngEqOwFLDwybY1XIQctdn50/1T8o8Lk305eGTi4JDKrfiw
 SZFg3V83enZtn7H5zg4V0T6BgGTbqO+5D5VZ1J8ZfUqsK0Nr6dUxwDpiDLFHMIOq/GmX0e4nhl
 V1o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:08 -0700
IronPort-SDR: X+EXbWWxdDYCPucFiaDKmCDEkn/EEXcZ9jsRsOTtlcXR4MmobsyJex6VEMpJMpw7XqJExWZoD9
 zDMd2NvTVTLJtRTYlpHh0u2ZNWS55qgrxqQMDlE44HeX7Sf+NMR29gtzQ7mdtdjd5NxwZ8lrT+
 q2EvnbzVhxRnt+pCH87G4oDN+llwKP2xVr+ycCI4a1QbcMTvnXaBiNRpjoautOFqZTBbZVDGeu
 r8IXC7NEJBBecarx6uRA5bjvstduR1Rm+tgz8kqaN0pWd7IS9hzwEI8keN7pMOUb7cRrKjEH+/
 e+s=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:58 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 02/15] check: support test case repeat by different conditions
Date: Wed, 24 Apr 2024 16:59:42 +0900
Message-ID: <20240424075955.3604997-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is often required to run the same test with slightly different test
conditions. If we create each test case for each test condition, those
test cases are almost same and have code duplication. Such duplication
is seen in many of the nvme test cases that set up nvme transport.

To avoid the code duplication, introduce a new feature to support test
case repetition with different conditions. When a test case implements
the function set_conditions(), blktests repeat the test case. When
set_conditions() is called without an argument, it returns how many
times the test case is to be repeated. Before each test case run,
blktests calls set_conditions() with an argument number from 0 to the
number of repetitions minus 1. set_conditions() sets up the condition
for each test run referring to the argument as the index of the
condition to set up. set_conditions() also sets up a short string in
the COND_DESC variable. This string is printed to stdout to identify the
condition of each run. It is also used as the directory path name to
hold result files.

Document the usage of set_conditions() in the new script. Separate out
shellcheck command line for the new script to avoid a false-positive
warning unique to the file.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Makefile          |  3 ++-
 check             | 57 ++++++++++++++++++++++++++++++++++-------------
 common/shellcheck |  2 +-
 new               | 21 +++++++++++++++++
 4 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 43f2ab0..1c685fe 100644
--- a/Makefile
+++ b/Makefile
@@ -18,8 +18,9 @@ install:
 SHELLCHECK_EXCLUDE := SC2119
 
 check:
-	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check new common/* \
+	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check common/* \
 		tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
+	shellcheck --exclude=$(SHELLCHECK_EXCLUDE),SC2154 --format=gcc new
 	! grep TODO tests/*/rc tests/*/[0-9]*[0-9]
 	! find -name '*.out' -perm /u=x+g=x+o=x -printf '%p is executable\n' | grep .
 
diff --git a/check b/check
index 7d09ec0..edc421d 100755
--- a/check
+++ b/check
@@ -17,7 +17,9 @@ _found_test() {
 	local test_name="$1"
 	local explicit="$2"
 
-	unset CAN_BE_ZONED DESCRIPTION QUICK TIMED requires device_requires test test_device fallback_device cleanup_fallback_device
+	unset CAN_BE_ZONED DESCRIPTION QUICK TIMED requires device_requires \
+	      test test_device fallback_device cleanup_fallback_device \
+	      set_conditions
 
 	# shellcheck disable=SC1090
 	if ! . "tests/${test_name}"; then
@@ -190,15 +192,12 @@ _write_test_run() {
 _output_status() {
 	local test="$1"
 	local status="$2"
-	local zoned=" "
+	local str="${test} "
 
-	if (( RUN_FOR_ZONED )); then zoned=" (zoned) "; fi
-
-	if [[ "${DESCRIPTION:-}" ]]; then
-		printf '%-60s' "${test}${zoned}($DESCRIPTION)"
-	else
-		printf '%-60s' "${test}${zoned}"
-	fi
+	(( RUN_FOR_ZONED )) && str="$str(zoned) "
+	[[ ${COND_DESC:-} ]] && str="$str(${COND_DESC}) "
+	[[ ${DESCRIPTION:-} ]] && str="$str(${DESCRIPTION})"
+	printf '%-60s' "${str}"
 	if [[ -z $status ]]; then
 		echo
 		return
@@ -464,17 +463,19 @@ _unload_modules() {
 }
 
 _check_and_call_test() {
+	local postfix
 	local ret
 
 	if declare -fF requires >/dev/null; then
 		requires
 	fi
 
-	RESULTS_DIR="$OUTPUT/nodev"
+	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
+	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
 	ret=$?
 	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
-		RESULTS_DIR="$OUTPUT/nodev_zoned"
+		RESULTS_DIR="$OUTPUT/nodev_zoned${postfix}"
 		RUN_FOR_ZONED=1
 		_call_test test
 		ret=$(( ret || $? ))
@@ -484,6 +485,7 @@ _check_and_call_test() {
 }
 
 _check_and_call_test_device() {
+	local postfix
 	local unset_skip_reason
 	local ret
 
@@ -491,6 +493,7 @@ _check_and_call_test_device() {
 		requires
 	fi
 
+	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	for TEST_DEV in "${TEST_DEVS[@]}"; do
 		TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
 		TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
@@ -504,7 +507,7 @@ _check_and_call_test_device() {
 				device_requires
 			fi
 		fi
-		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
+		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")""$postfix"
 		if ! _call_test test_device; then
 			ret=1
 		fi
@@ -522,9 +525,11 @@ _run_test() {
 	CHECK_DMESG=1
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
+	COND_DESC=""
 	FALLBACK_DEVICE=0
 	MODULES_TO_UNLOAD=()
 
+	local nr_conds cond_i
 	local ret=0
 
 	# Ensure job control monitor mode is off in the sub-shell for test case
@@ -535,8 +540,18 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
-		_check_and_call_test
-		ret=$?
+		if declare -fF set_conditions >/dev/null; then
+			nr_conds=$(set_conditions)
+			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
+				set_conditions $cond_i
+				_check_and_call_test
+				ret=$(( ret || $? ))
+				unset SKIP_REASONS
+			done
+		else
+			_check_and_call_test
+			ret=$?
+		fi
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
@@ -558,8 +573,18 @@ _run_test() {
 			return 0
 		fi
 
-		_check_and_call_test_device
-		ret=$?
+		if declare -fF set_conditions >/dev/null; then
+			nr_conds=$(set_conditions)
+			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
+				set_conditions $cond_i
+				_check_and_call_test_device
+				ret=$(( ret || $? ))
+				unset SKIP_REASONS
+			done
+		else
+			_check_and_call_test_device
+			ret=$?
+		fi
 
 		if (( FALLBACK_DEVICE )); then
 			cleanup_fallback_device
diff --git a/common/shellcheck b/common/shellcheck
index 8c324bd..ac0a51e 100644
--- a/common/shellcheck
+++ b/common/shellcheck
@@ -6,5 +6,5 @@
 
 # Suppress unused global variable warnings.
 _silence_sc2034() {
-	echo "$CAN_BE_ZONED $CGROUP2_DIR $CHECK_DMESG $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASONS ${TEST_RUN[*]} $TIMED" > /dev/null
+	echo "$CAN_BE_ZONED $CGROUP2_DIR $CHECK_DMESG $COND_DESC $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASONS ${TEST_RUN[*]} $TIMED" > /dev/null
 }
diff --git a/new b/new
index 574d8b4..cb5fab2 100755
--- a/new
+++ b/new
@@ -180,6 +180,27 @@ DESCRIPTION=""
 # 	_require_test_dev_is_foo && _require_test_dev_supports_bar
 # }
 
+# TODO: if the test case can run the same test for different conditions, define
+# the helper function "set_condition". When no argument is specified, return the
+# number of condition variations. Blktests repeats the test case as many times
+# as the returned number. When its argument is specified, refer to it as the
+# condition variation index and set up the conditions for it. Also set the
+# global variable COND_DESC which is printed at the test case run and used for
+# the result directory name. Blktests calls set_condition() before each run of
+# the test case incrementing the argument index from 0.
+# set_conditions() {
+# 	local index=\$1
+# 
+# 	if [[ -z \$index ]]; then
+# 		echo 2  # return number of condition variations
+# 		return
+# 	fi
+# 
+# 	# Set test conditions based on the $index
+# 	...
+# 	COND_DESC="Describe the conditions shortly"
+# }
+
 # TODO: define the test. The output of this function (stdout and stderr) will
 # be compared to tests/\${TEST_NAME}.out. If it does not match, the test is
 # considered a failure. If the test runs a command which has unnecessary
-- 
2.44.0

