Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B11C5F14
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182197; cv=none; b=KX9dz4egAFQfRYtntdhbNRnCb9pce2SwGLLm8yiFwbpmsNY9tezHe8jshIbVhE3nq6jU9IzH4cPWbzqXBu7YTyI14jvdCXKNTpd/MX4dw8bj2WSkiY1vcJBa1LChQs/v0aO27YJkzLMcYLpkAWJvkWR8xIwHkWeIaYpujZysfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182197; c=relaxed/simple;
	bh=/QB/RH74L4gec/OuO8ACmxpqoGCPh1l4ws/B4U8loOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvp/JQDqhXErMzgwlsXe8S0mMJMIXu+svaAjWCjLR+MSTzxva+SCh/sRGCh38mINUoqZBsC6/eGd9ON2dxYaHxV0rDj3Py39CdVATl0KtGYQF31+p3OBO9GsYlmsBuu2I9pNnt3PduGOBaujLaSZ8uYF7wWreNVmyHgSo1Uwffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XurekeQ2; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XurekeQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749182195; x=1780718195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QB/RH74L4gec/OuO8ACmxpqoGCPh1l4ws/B4U8loOU=;
  b=XurekeQ2Xv6HtYIN0taTN34IovEDsQPoe94n/o8W9lLv6v2gQYeX0AfP
   yMOVmnZK/ivDEHiuvZGUehvXSnSJUAEvr4MWOkmF8i07XsZ/ylvGYOpyQ
   zzxrUXKt6Wvlv9q7uAIBEf2M0ZZtGcgqnu78PE8y6py+hi+Ood4L70SbI
   1/e3rJ4WNmr5h41DsHujdpOhXTNAew8rRQzWc/Vi3vXWbtXP/6KabAi+N
   W16W8VKyHidAHt4yqt3EkmJMpzrNEPxQ+Zb6a5Rm6YxhMZ9qiB49Z8tCh
   RER2HbUUb775GtR9zhkXSSw38pMrIVRcLPHXQcsFLJOGxsF3RARUeG3fU
   g==;
X-CSE-ConnectionGUID: wpH167SvSQum4NdLpstBHA==
X-CSE-MsgGUID: gohSiyO6QsqMBPdDSWxSUg==
X-IronPort-AV: E=Sophos;i="6.16,214,1744041600"; 
   d="scan'208";a="86114883"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2025 11:56:34 +0800
IronPort-SDR: 68425891_qlWkxamhm5sD6CKQGZl5/+xdVOaIGH8Sh30huICstrWwATD
 s7IK5oODM639trqr3vsq+Bm3XLmJwqIrtvpIM+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2025 19:55:13 -0700
WDCIronportException: Internal
Received: from 5cg21505sl.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Jun 2025 20:56:33 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
Date: Fri,  6 Jun 2025 12:56:30 +0900
Message-ID: <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bash script development, it is a good practice to enable strict
error-checking using "set -e" or "set -o errexit". However, implementing
this in blktests has two problems.

The first problem is script changes to ignore non-zero status. When the
error-checking is enabled, any non-zero status immediately terminates
the script. However, non-zero statuses are often intentional and
expected. Ignoring these statuses across all test cases would require
extensive code modifications and weird codes. Therefore, the error-
checking should be enabled for limited subset of test cases where non-
zero statuses are not expected.

The second problem is impact on following test cases. When the error-
checking is enabled for a test case, the test case script exits
immediately encountering an error. This skips the cleanup steps in the
test case, potentially leaving the test system in a dirty state, which
may affect subsequent test cases.

To address the two problems, introduce the new flag ERR_EXIT. When a
test case sets ERR_EXIT=1 at the beginning of its file, the blktests
check script calls "set -e" for the test case. The test case does not
need to call "set -e". This allows the strict error-checking to be
applied to test cases selectively.

If a test case with ERR_EXIT=1 exits due to a non-zero status, catch the
exit in _cleanup(). Then print an error message to the user and stop the
test script. This ensures the following test cases are not run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check             | 22 ++++++++++++++++++++--
 common/shellcheck |  4 +++-
 new               |  6 ++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/check b/check
index f11ce74..a690e47 100755
--- a/check
+++ b/check
@@ -4,6 +4,8 @@
 
 shopt -s extglob
 
+readonly ABORT_RUN=255
+
 _warning() {
 	echo "$0: $*" >&2
 }
@@ -332,6 +334,12 @@ _cleanup() {
 	fi
 
 	_exit_cgroup2
+
+	if ((ERR_EXIT)); then
+		echo "${TEST_NAME} should be error free but caused an error."
+		echo "It might have left dirty status. Abort the test run."
+		exit $ABORT_RUN
+	fi
 }
 
 _call_test() {
@@ -372,6 +380,7 @@ _call_test() {
 		fi
 
 		TIMEFORMAT="%Rs"
+		((ERR_EXIT)) && set -e
 		pushd . >/dev/null || return
 		{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runtime"
 		TEST_RUN["exit_status"]=$?
@@ -379,6 +388,12 @@ _call_test() {
 		TEST_RUN["runtime"]="$(cat "${seqres}.runtime")"
 		rm -f "${seqres}.runtime"
 
+		# The test case did not exit due to error for "set -e". Clear
+		# ERR_EXIT flag to not abort in _cleanup(). Also ensure to
+		# disable the error check.
+		unset ERR_EXIT
+		set +e
+
 		_cleanup
 
 		if [[ -v SKIP_REASONS ]]; then
@@ -523,6 +538,7 @@ _run_test() {
 	COND_DESC=""
 	FALLBACK_DEVICE=0
 	MODULES_TO_UNLOAD=()
+	ERR_EXIT=0
 
 	local nr_conds cond_i
 	local ret=0
@@ -635,13 +651,15 @@ _run_group() {
 		unset TEST_DEV
 	fi
 
-	local ret=0
+	local ret=0 run_test_ret
 	local test_name
 	for test_name in "${tests[@]}"; do
 		# Avoid "if" and "!" for errexit in test cases
 		( _run_test "$test_name" )
 		# shellcheck disable=SC2181
-		(($? != 0)) && ret=1
+		run_test_ret=$?
+		((run_test_ret != 0)) && ret=1
+		((run_test_ret == ABORT_RUN)) && break
 	done
 	return $ret
 }
diff --git a/common/shellcheck b/common/shellcheck
index ac0a51e..a1f8473 100644
--- a/common/shellcheck
+++ b/common/shellcheck
@@ -6,5 +6,7 @@
 
 # Suppress unused global variable warnings.
 _silence_sc2034() {
-	echo "$CAN_BE_ZONED $CGROUP2_DIR $CHECK_DMESG $COND_DESC $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASONS ${TEST_RUN[*]} $TIMED" > /dev/null
+	echo "$CAN_BE_ZONED $CGROUP2_DIR $CHECK_DMESG $COND_DESC $DESCRIPTION \
+		$DMESG_FILTER $ERR_EXIT $FIO_PERF_FIELDS $FIO_PERF_PREFIX \
+		$QUICK $SKIP_REASONS ${TEST_RUN[*]} $TIMED" > /dev/null
 }
diff --git a/new b/new
index d84f01d..3664b1b 100755
--- a/new
+++ b/new
@@ -149,6 +149,12 @@ DESCRIPTION=""
 # Alternatively, you can filter out any unimportant messages in dmesg like so:
 # DMESG_FILTER="grep -v sysfs"
 
+# TODO: if you want to enable bash errexit "set -e" feature for strict error
+# check, uncomment the line below. If any command returns non-zero status, the
+# test case stops at that step. For detail, refer to the bash manual "SHELL
+# BUILTIN COMMAND", "set", "-e" section.
+# ERR_EXIT=1
+
 # TODO: if this test can be run for both regular block devices and zoned block
 # devices, uncomment the line below.
 # CAN_BE_ZONED=1
-- 
2.49.0

