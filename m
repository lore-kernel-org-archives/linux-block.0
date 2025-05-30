Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D0211A00
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591670; cv=none; b=L3h+njFBQsJJylqgDiXTtJzAl2pzb4E46U+82P4SkMVcmUHaSbTcyF+a6YR+SwmDpqi7WFeNYh34rBT4hm9DF60JsX99CvHyAIj9p8dwsarTSG810L0zUReF71rwfGEj4BkZ51ADTafR8kWkTJ0tCSx8O5G3eu2nyfkerwYhOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591670; c=relaxed/simple;
	bh=OcKCwXdyljO5Q2VzkG5dka8GCLY1xEJIMWq5C/67bpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX3Pd5wUjCUvLeySW1TAC8tFS0+dHJGjDocJvYHIeG3cDLQmQqOCpInGjsL4Yfft4zaGNBrke4DcBk7xRtpP7b4i8sMOm3AohNjlr43MWcdLCHq1FrJhKOOjuLfbmMqv865mnHIm6mg+juJylkHpi/HZRAyehJnS0MRB7fm0+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bBI3BNU8; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bBI3BNU8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748591669; x=1780127669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcKCwXdyljO5Q2VzkG5dka8GCLY1xEJIMWq5C/67bpE=;
  b=bBI3BNU8kGjbzzi9iAf9kltaYwmUC+XtR8hFjRT+5wD909Ka7YSly3H+
   mkexY8jkbED+dTfxpAujWuSy/3c09wRCVWqKIosP61zkKE97S2Yi2EA2J
   Zl9WJQ4xeL78DpxhPAI6DPsQ5a6TKXeRDcoPNm44bAlY5r9FNESbsPYco
   2212S0cSxwDJyoJsmQDSF6d3UcJk7SsB+1m6gbQ7NPfBwGy1N2xn0a0Ve
   xa2w177WpApj+MF+fLItd/H5bUWLgAXrpfnISf45aCP3uSCF/7G+YUJ5Z
   O2ScvozQc2Vqjv2DtddO7X9LTrlsTkTTdR3I/q8sM5T8/kcb5Jd7q8R63
   A==;
X-CSE-ConnectionGUID: WiBGrXsCSACDb3em2sl53A==
X-CSE-MsgGUID: EjSWvYONQsWoPA8OzV+Bjg==
X-IronPort-AV: E=Sophos;i="6.16,195,1744041600"; 
   d="scan'208";a="88625262"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2025 15:54:28 +0800
IronPort-SDR: 683955df_UylrBgg+BVsxi/ncxoeLINMCWxJzvR+Z1V/5qYX8Cb9+8eq
 G2CmgjRyLCDB1gQLFVo0iksyr297ER8nCjkIj1g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2025 23:53:20 -0700
WDCIronportException: Internal
Received: from 4r6vzh3.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.85])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2025 00:54:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests RFC 2/2] check: abort test run when a test case exits by "set -e" error-checking
Date: Fri, 30 May 2025 16:54:25 +0900
Message-ID: <20250530075425.2045768-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a test case does "set -e" for the string error-checking, the test
case exits immediately encountering an error. This skips the cleanup
steps in the test case, potentially leaving the test system in a dirty
state, which may affect subsequent test cases.

To avoid such impacts, detect the test case exit due to "set -e". If a
test case uses "set -e", set the global flag ERR_EXIT. If this flag is
on in _cleanup(), exit the sub-shell with an exit code ABORT_RUN, then
stop the test script.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 3cf741a..81bb84d 100755
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
@@ -379,6 +387,12 @@ _call_test() {
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
@@ -522,6 +536,7 @@ _run_test() {
 	COND_DESC=""
 	FALLBACK_DEVICE=0
 	MODULES_TO_UNLOAD=()
+	ERR_EXIT=0
 
 	local nr_conds cond_i
 	local ret=0
@@ -533,6 +548,10 @@ _run_test() {
 	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
 
+	if grep --quiet "set -e" "tests/${TEST_NAME}"; then
+		ERR_EXIT=1
+	fi
+
 	if declare -fF test >/dev/null; then
 		if ((RUN_ZONED_TESTS && CAN_BE_ZONED)); then
 			. "common/zoned"
@@ -634,12 +653,14 @@ _run_group() {
 		unset TEST_DEV
 	fi
 
-	local ret=0
+	local ret=0 run_test_ret
 	local test_name
 	for test_name in "${tests[@]}"; do
 		( _run_test "$test_name" )
 		# shellcheck disable=SC2181
-		(($? != 0)) && ret=1
+		run_test_ret=$?
+		((run_test_ret != 0)) && ret=1
+		((run_test_ret == ABORT_RUN)) && break
 	done
 	return $ret
 }
-- 
2.49.0

