Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE66763F1
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263533; cv=none; b=kXc6FtWXYzMbqkLt5nkfMQ+Ta3idcT+hC0foH+GqPzxumvDKUyT3f/5LVwiSP3B0p3a3mSWL3Y6gyVus3zkXSjPB8pD9XOc8cueOT8h4M3nCsHiGFoNLJtsCUCdDqQhU8QxkGfSTNnJIOG2PnU9h6efU2jZs2agLB4LBM9wzpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263533; c=relaxed/simple;
	bh=OvgikZMeVjQImGamzRSuQl9g9/GvBeWvN5ptIDlf9UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi7QAYF8DMy8gOJC+qzkC4cwns6nKx6bzWHiPsNzhlzZ1WgQJd5WET06CNl1dO1AQtyL7ALLfMO3OCt6Ci8K2ankJBqq6JRFhVqLAfZr6j+ZxX/r1MADWdRZib10T3SDIr1xA2GbKZs+UjVRjp9f3bwgo6hxgnabhU9AUNDSYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y4GYrv2l; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y4GYrv2l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263531; x=1744799531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvgikZMeVjQImGamzRSuQl9g9/GvBeWvN5ptIDlf9UU=;
  b=Y4GYrv2lpJQf43x9/zFJ5Y9QC2slQemycOehVZqMDQIek55QWEnwvxbw
   M6KjjKc2C3xNyhZ1MWhiPICr8y95lAG7BgYgcCGZ0IC2YxFkArAQe2puP
   6MkSgbeUHhEMQeUjK/JaL9ZfVdtXmRJo4AGChe0QnBfLYKqxH0w7j8JO6
   BuMpqPxHZBxJwXEahgxlmmsUFcdHFEHnp+y6TdZ/4CnwopIbaJkR4W29C
   ddeugScsLr6ZX+S/gUiDF70qZAuap3y1NtFB14Lrq7meFYMdDGD+EVdCD
   LiGZWDPCi4lbXlrvvQ66o0Q3KjtXlMaYERSTrphqQxDDJ4qsNm3E7itGt
   w==;
X-CSE-ConnectionGUID: 5FOfmW+GTdOc+TdH2OzcIw==
X-CSE-MsgGUID: MWE37c/QTb+eSDH2/akkvQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322607"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:09 +0800
IronPort-SDR: Z9+Hr43s3ZfsVWj8UeOeJ7a0IFAXOsYG1VxXthgkPIU5qbwJZBOj8XNX1a/1BLommC/p0gKvB8
 eD72xT1jfK/dBFIjJSFLFmanEevLZTbKENADYwb8/yvvEfj+Uecwbe51YtEHBs6LSWUX2KC0+S
 DbRyTyT/1BsfiTtKOOpB9O71VdaYMYBE5OYBxhs1GUF8c6UQTbmFhLWImSoZLLp4WxkvgF/qEJ
 Ac3Qn+Z2altS39ORv0+jQFgX1Ii7lABHpMyHzGqvcqW6MBnnilG9gUqZMHYEdfliXz3E5P6YK6
 ZjU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:40:30 -0700
IronPort-SDR: LZSI8JEanNsG3//X4HaccHNrCOh6BKGs1PjUho+9IXMZXa9AfI7oVgskBI4IJE7XuNd6WhdsNf
 8FAHL6pibhjp6VkQHFmjgqfKMzBb/FbST9aADYx3AghUnZE8nDlvoSk6rHJygpJnJidMO3TMks
 FZMmjJ9xIjTFwbmDq6hcFjZtfMmczOnR0mJUSsLd1dr0UZ9KuwI8JlbMldqepeTAYbevlp6epI
 5OTqp75x+8En0AxCzRPmIAKtQe1EqPhsMMPi7sQzK8wfp7W6hGlVpLYzomwm7TnxpbtVy08p9w
 DmM=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 01/11] check: factor out _run_test()
Date: Tue, 16 Apr 2024 19:31:57 +0900
Message-ID: <20240416103207.2754778-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 check | 93 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 37 deletions(-)

diff --git a/check b/check
index 55871b0..7d09ec0 100755
--- a/check
+++ b/check
@@ -463,6 +463,59 @@ _unload_modules() {
 	unset MODULES_TO_UNLOAD
 }
 
+_check_and_call_test() {
+	local ret
+
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
+	local ret
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
@@ -482,19 +535,8 @@ _run_test() {
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
@@ -516,31 +558,8 @@ _run_test() {
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

