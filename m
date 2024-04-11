Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B3147C7C
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834023; cv=none; b=cb0lNr9AeZx1d1wjmP6p0EJETd6UmINtRmXQ/FUhTDWaP955SGSUmUfMO7NF0DQh6cfqSCt+AUZaH1j5wZSnswcL5Vxlppvh+we4ovg59U4DT49uqtsoIDlHyYdeW3CDpzjDYeoGSDc0zB2i+hapJ2b8VejeZd/KqiDuCOx6ny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834023; c=relaxed/simple;
	bh=9MjajHbnj6QVYHeGzTlH+Mn0XUl56AuvvOOv7c7MCeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWakFo0CNPI0WpNCnwsDN+OEHSB/AAgL9S8E2YhWK+McJp34LzAxRfH6Pk8NMCe8fy5g3iGFeRsRE87i5RoMG7uYL+FA0C/2x8qEptJWRpUd1Fie/z+sh7vTzv361cxs68zd82re3vBdJtOVK/g0QHKAXY7fpyC5Q7q3tMrEG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JxxAuZuI; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JxxAuZuI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712834022; x=1744370022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9MjajHbnj6QVYHeGzTlH+Mn0XUl56AuvvOOv7c7MCeU=;
  b=JxxAuZuIYrjmuxRHhSFHIUIk4HUGcAmF+QUoCMcH0DeC46IY8RUhkXUU
   hBHJbqnOk5d42fNDRocEFOcICMHDxKr/9QYxqIVgG+ZMRMp1O2hK90MBg
   R9Gfy194eXRfXchCttj0hULPYitGPmjQhls3juployHYQ1JwlEVizJQmi
   dtCEUmXNowIDyjIwrAnNlVUBJgyqqb67tw/ZQWJcFOFLiF9Lb8kEx3bzV
   twkLzaEHEsOQEKOOAwo9SF8jHAPA6NsEveiKAnC937hW5g/gPRBiYYJGf
   loMN34gNLT749Ko7b3VEQZ5Fps/78QBm5G4B8K0+YNB5iAEnuFBKfY8M7
   g==;
X-CSE-ConnectionGUID: /htKG/aCSnKBnR4DCUugYQ==
X-CSE-MsgGUID: eYQ740lLSsOOlO/MawA4kw==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579862"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:31 +0800
IronPort-SDR: q/Jl1S9nLJtGSCnfEksW8WuoT2xCOt6X5Asn1G8kv8nzx/SBP6fycgPwmz8STlW0BMXYjvAScz
 Q8VlgPdNVVxA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:16 -0700
IronPort-SDR: yAVqHJyiA8jRA1vbeHTk0EnaTBt/34S6e1Cjqkh9GpNtniVztoayhpuOaXrmvIspyDoUKISgUk
 rUhe9+G6GFnQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:30 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 01/11] check: factor out _run_test()
Date: Thu, 11 Apr 2024 20:12:18 +0900
Message-ID: <20240411111228.2290407-2-shinichiro.kawasaki@wdc.com>
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

The function _run_test() is rather complex and has deep nests. Before
modifying it for repeated test case runs, simplify it. Factor out some
part of the function to the new functions _check_and_call_test() and
_check_and_call_test_device().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 90 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/check b/check
index 55871b0..b1f5212 100755
--- a/check
+++ b/check
@@ -463,6 +463,56 @@ _unload_modules() {
 	unset MODULES_TO_UNLOAD
 }
 
+_check_and_call_test() {
+	if declare -fF requires >/dev/null; then
+		requires
+	fi
+
+	RESULTS_DIR="$OUTPUT/nodev"
+	_call_test test
+	ret=$?
+	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
+		RESULTS_DIR="$OUTPUT/nodev_zoned"
+		RUN_FOR_ZONED=1
+		_call_test test
+		ret=$(( ret || $? ))
+	fi
+
+	return $ret
+}
+
+_check_and_call_test_device() {
+	local unset_skip_reason
+
+	if declare -fF requires >/dev/null; then
+		requires
+	fi
+
+	for TEST_DEV in "${TEST_DEVS[@]}"; do
+		TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
+		TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
+
+		unset_skip_reason=0
+		if [[ ! -v SKIP_REASONS ]]; then
+			unset_skip_reason=1
+			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
+				SKIP_REASONS+=("${TEST_DEV} is a zoned block device")
+			elif declare -fF device_requires >/dev/null; then
+				device_requires
+			fi
+		fi
+		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
+		if ! _call_test test_device; then
+			ret=1
+		fi
+		if (( unset_skip_reason )); then
+			unset SKIP_REASONS
+		fi
+	done
+
+	return $ret
+}
+
 _run_test() {
 	TEST_NAME="$1"
 	CAN_BE_ZONED=0
@@ -482,19 +532,8 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
-		if declare -fF requires >/dev/null; then
-			requires
-		fi
-
-		RESULTS_DIR="$OUTPUT/nodev"
-		_call_test test
+		_check_and_call_test
 		ret=$?
-		if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
-			RESULTS_DIR="$OUTPUT/nodev_zoned"
-			RUN_FOR_ZONED=1
-			_call_test test
-			ret=$(( ret || $? ))
-		fi
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
@@ -516,31 +555,8 @@ _run_test() {
 			return 0
 		fi
 
-		if declare -fF requires >/dev/null; then
-			requires
-		fi
-
-		for TEST_DEV in "${TEST_DEVS[@]}"; do
-			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
-			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
-
-			local unset_skip_reason=0
-			if [[ ! -v SKIP_REASONS ]]; then
-				unset_skip_reason=1
-				if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
-					SKIP_REASONS+=("${TEST_DEV} is a zoned block device")
-				elif declare -fF device_requires >/dev/null; then
-					device_requires
-				fi
-			fi
-			RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
-			if ! _call_test test_device; then
-				ret=1
-			fi
-			if (( unset_skip_reason )); then
-				unset SKIP_REASONS
-			fi
-		done
+		_check_and_call_test_device
+		ret=$?
 
 		if (( FALLBACK_DEVICE )); then
 			cleanup_fallback_device
-- 
2.44.0

