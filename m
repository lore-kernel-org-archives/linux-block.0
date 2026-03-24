Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DB3A5437
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331419; cv=none; b=r7rxprsveeAZNwxG8Gj/x3BjkjLYlZwxZuvaM9e28SAyi7jj0YKlhD1lXmdBK7CPaFQ1kpGQUw8ZI+8pIXwn/gSqhYGGd5/uB7T4/2W/6ya5qhReuWkyT7MBJWLJQ1ebdQ5Xl9y6uEjauaLqcmcrNKVmGpB0jXyWE81tMq/z7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331419; c=relaxed/simple;
	bh=EMTewabo6yCavUg86Dwybca4lue0udTULUNI26aJm4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bogLbE5fPkBSG+f1WEVpevTeNVzBfMF5hViwXfyShcs1VTbDjZ6K+6vjfauvKvgjEIuG3HkqvXMjSNbhxtoZwNYb0zkt86LVlJGtzLbhy46jiYGR2pb2W+Aj49jYdrHLDkL5/87iff/7VDMde92lxYlMQqLmpD7CwUdg7SCidAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jvQICKGU; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jvQICKGU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331415; x=1805867415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMTewabo6yCavUg86Dwybca4lue0udTULUNI26aJm4I=;
  b=jvQICKGU2M6Gm7a8rZvXeM36JsUSRWWYcB7xlxK5GmHr+7LV/B4RR0aG
   UQjvPS8SzFOqoc6xpEROxrH6WhxJk6NMaSbWL9ArUxWp4lCzzR1hxAZcz
   kf6OIyrhS9bQXkLHsGJSLDu9VEx0LUsIenB2VGeJjqiB6orfUs9yvGtkM
   +8m2Ek7rzOV3ekj4vFl/K6oruhuviyJDwYAMhLnShxvDS15Il5pKHyZJ8
   ONm1KyuMTGB2TlIP7369c3c6qOmAP7LGYhpYTIe/9drKQdOx8IvJWOLOD
   NASyl/AH1S+GnfmRCl6kqbLp8ymx61ochL+Oz8cueEQqVogKlhkDctNhR
   A==;
X-CSE-ConnectionGUID: C1Ht+caHTI+gX59fVy9ESg==
X-CSE-MsgGUID: cNsyEqMJRUmdYMtIuBeksQ==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614096"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c225ff_HPyaVkNzU5X6tZ0KrhVDoBJD6wJqbED9lJXv4U/mG79Si/s
 TxaglnTRZnCSzjUnX+d8Jxj6YYorpd14FXwCeLg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:51 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:51 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/7] check: move fallback device handling into _check_and_call_test_device()
Date: Tue, 24 Mar 2026 14:49:43 +0900
Message-ID: <20260324054949.3821569-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when a test case has callback functions for fallback device,
the fallback device is created in run_test(). Meanwhile,
_unload_module() is called in _call_test(). Then,
cleanup_fallback_device() is called after _unload_module().

  _run_test
    fallback_device
      _check_and_call_test_device
        _call_test
          _unload_modules
    cleanup_fallback_device

This is not desired since module unload can affect
cleanup_fallback_device(). For example, scsi_debug is used as a fallback
device, _unload_modules() can unload scsi_debug before calling
cleanup_fallback_device().

To resolve this, make two changes. The first change is to move fallback
operations from _run_test() to _check_and_call_test_device(). This
commit does it. After this commit, the call chain will be as follows.

  _run_test
    _check_and_call_test_device
      fallback_device
        _call_test
          _unload_modules
      cleanup_fallback_device

As the second change, the following commit will move the
_unload_modules() call.

While at this change, rename the local variable FALLBACK_DEVICE to
'fallback', since capital letters imply that the variable would be
a global variable.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 57 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/check b/check
index f170458..3fa3e97 100755
--- a/check
+++ b/check
@@ -716,14 +716,34 @@ _check_and_call_test() {
 _check_and_call_test_device() {
 	local postfix
 	local unset_skip_reason
-	local ret
+	local ret=0
+	local fallback=0
 
 	if declare -fF requires >/dev/null; then
 		requires
 	fi
 
+	if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
+		   declare -fF fallback_device >/dev/null; then
+		TEST_DEVS[0]=fallback
+	fi
+
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	for TEST_DEV in "${TEST_DEVS[@]}"; do
+		if [[ $TEST_DEV == fallback ]]; then
+			if ! TEST_DEV=$(fallback_device); then
+				_warning "$TEST_NAME: fallback_device call failure"
+				return 0
+			fi
+
+			if ! _find_sysfs_dirs "$TEST_DEV"; then
+				_warning "$TEST_NAME: could not find sysfs directory for ${TEST_DEV}"
+				cleanup_fallback_device
+				return 0
+			fi
+			fallback=1
+		fi
+
 		TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
 		TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
 
@@ -744,6 +764,13 @@ _check_and_call_test_device() {
 		if (( unset_skip_reason )); then
 			unset SKIP_REASONS
 		fi
+
+		if (( fallback )); then
+			cleanup_fallback_device
+			unset "TEST_DEV_SYSFS_DIRS[${TEST_DEV}]]"
+			unset "TEST_DEV_PART_SYSFS_DIRS[${TEST_DEV}]"
+			TEST_DEVS=()
+		fi
 	done
 
 	return $ret
@@ -825,7 +852,6 @@ _run_test() {
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
 	COND_DESC=""
-	FALLBACK_DEVICE=0
 	MODULES_TO_UNLOAD=()
 
 	local nr_conds cond_i
@@ -855,26 +881,6 @@ _run_test() {
 			ret=$?
 		fi
 	elif declare -fF test_device >/dev/null; then
-		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
-			declare -fF fallback_device >/dev/null; then
-			if ! test_dev=$(fallback_device); then
-				_warning "$TEST_NAME: fallback_device call failure"
-				return 0
-			fi
-
-			if ! _find_sysfs_dirs "$test_dev"; then
-				_warning "$TEST_NAME: could not find sysfs directory for ${test_dev}"
-				cleanup_fallback_device
-				return 0
-			fi
-			TEST_DEVS=( "${test_dev}" )
-			FALLBACK_DEVICE=1
-		fi
-
-		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
-			return 0
-		fi
-
 		if declare -fF set_conditions >/dev/null; then
 			nr_conds=$(set_conditions)
 			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
@@ -887,13 +893,6 @@ _run_test() {
 			_check_and_call_test_device
 			ret=$?
 		fi
-
-		if (( FALLBACK_DEVICE )); then
-			cleanup_fallback_device
-			unset "TEST_DEV_SYSFS_DIRS[${TEST_DEVS[0]}]"
-			unset "TEST_DEV_PART_SYSFS_DIRS[${TEST_DEVS[0]}]"
-			TEST_DEVS=()
-		fi
 	else
 		_check_and_call_test_device_array
 		ret=$?
-- 
2.49.0

