Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8171147C77
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834024; cv=none; b=WuzGDrS0rUcIKiRRA+WZpO8YZLwcXc25/zUafjIdhpzcj1DypnvMbmj2Re786yvAFBJPWEhjNfEKKkDC3iaUJ/UX7mQ5QGi3w/zP/0KVxZsZUQnAh7bMS9rKOLABOH5ou/s5+TRL965w9Hiy7LsdCQsEXUh+qokI7Pevfbb0ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834024; c=relaxed/simple;
	bh=8XWsBfcuPK6MSnKkO91ZMiolR0lPRUUOuelXGyh30/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5Rc8OdxnnWH8AQ02s/fn8c0r2q8KJA0+WmWYXaPUQnHIBDtwOcAbHDwcHAwDnjBzTJlV+L7RwyTfXQTvVYU21lWA2x77JIq3fz8LAS6/upNbFdMSe1A9L28Eo6ZzEPgRLTIVAXEUzHqTo9swrm7m77qVENnyZGHGPnVij/ziUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hVOG2glJ; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hVOG2glJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712834023; x=1744370023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8XWsBfcuPK6MSnKkO91ZMiolR0lPRUUOuelXGyh30/0=;
  b=hVOG2glJ4iEV45O/C5gXmjINUrSxJHR/knqicSff9mgfCyzF13878A9L
   ChCf+xsj+bvgGsIc98SleVp0ztLZv9a6aoATD2AlQ4iaZy2JIFmWfs+rJ
   sTMMH2Zi0gcWAl8n09ahJAjGu7RmCDd6WXG3Yr7yPG0aNiTD/m6z+w1P5
   BXQfCXHUTN/BvAQ2mvnlq/JbNWOUhdOTFK+ScZEGVSOnl9nJEk/U4OPWu
   0BI5+JajLSCRoectAWFkqdMDT+H755TsafZs/bzpBUlRx5H+Q7xYv7AWM
   Nho0fig06URm+y2YzkgUpiBo6x0aNzD34m4W3CjOSLoADZNJLHGa+ci95
   g==;
X-CSE-ConnectionGUID: 87BFDyEuR4e8MY2a6Oayrg==
X-CSE-MsgGUID: QERP5Bt5QNauK1bN6fn71A==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579863"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:32 +0800
IronPort-SDR: Akz52Nvig4+oHbrKRgerG0c6TZbccBK6caOP2EvxsxK34XRO8dnc/wo6/xGAgkFV+qNjSJjy3t
 t0LpWG5dSBEw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:17 -0700
IronPort-SDR: Z6l09byqTQ9gTR8UbY5kfo7ty+Ju7J8gV6twwn66mD0CUjbYXF84bJ7M67Rr+PFIKZDTB1Ohwm
 iIo+PFfBub9A==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 02/11] check: support test case repeat by different conditions
Date: Thu, 11 Apr 2024 20:12:19 +0900
Message-ID: <20240411111228.2290407-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
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

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Makefile          |  3 ++-
 check             | 58 ++++++++++++++++++++++++++++++++++-------------
 common/shellcheck |  2 +-
 new               | 21 +++++++++++++++++
 4 files changed, 66 insertions(+), 18 deletions(-)

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
index b1f5212..cef84ec 100755
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
@@ -464,15 +463,18 @@ _unload_modules() {
 }
 
 _check_and_call_test() {
+	local postfix
+
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
@@ -482,12 +484,14 @@ _check_and_call_test() {
 }
 
 _check_and_call_test_device() {
+	local postfix
 	local unset_skip_reason
 
 	if declare -fF requires >/dev/null; then
 		requires
 	fi
 
+	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	for TEST_DEV in "${TEST_DEVS[@]}"; do
 		TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
 		TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
@@ -501,7 +505,7 @@ _check_and_call_test_device() {
 				device_requires
 			fi
 		fi
-		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
+		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")""$postfix"
 		if ! _call_test test_device; then
 			ret=1
 		fi
@@ -519,9 +523,11 @@ _run_test() {
 	CHECK_DMESG=1
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
+	COND_DESC=""
 	FALLBACK_DEVICE=0
 	MODULES_TO_UNLOAD=()
 
+	local nr_conds cond_i
 	local ret=0
 
 	# Ensure job control monitor mode is off in the sub-shell for test case
@@ -532,8 +538,18 @@ _run_test() {
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
@@ -555,8 +571,18 @@ _run_test() {
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

