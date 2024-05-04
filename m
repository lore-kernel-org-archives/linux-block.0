Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DFD29E
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810500; cv=none; b=OtWzl7UiMook1CkQhBFeqCaQbKcnb6Z6WL+owkLmAcJnZNaYiISlmTtSahuENYveAtdIua06QVYsioTzQsbjmJR2Y8rREko/PNddG2Gz0q4iCOkR7Nj73TLfPtJ6gmfE9TneT3SzM3dzQfJjUI1vlbzRf9q/ZOjfADrK/SWWi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810500; c=relaxed/simple;
	bh=29N5U6N1y9BlM6ECK69L6XwHI/nK7ulbD7kVCqyaSx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwa6TQ07VWlcZJ0wdIp1RyVwYPVl+iGycaEf5KGkHq0UeYPsyo65P6Y8YnkiRc7p2h2MPE/jvDTDMDl85F3ukB4JQHPESEJj0YEsnU23uws3xCuv1C5Br/tJ0zruEigYj6n4rVs4x86te+z084/FG+cNue91ZyPhAqYg6HwvT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eB/WlAFa; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eB/WlAFa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810498; x=1746346498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29N5U6N1y9BlM6ECK69L6XwHI/nK7ulbD7kVCqyaSx0=;
  b=eB/WlAFaofb+SBrIO0n078ODZRGxd6TDvlTz4WhTj/VdJYeUQVfNZx0i
   nmSKe5pcDGeylIkP0nLtNovR/iDy43XYu3svJ9zLdVVwehp70wJuhZgfd
   vCM1Sur532Jm4KdO40ZJ9hDOv9rQPErivJXAdQGlitP5clmr6ziTpI1Xi
   HHxqmv+GxqdV7A/89TQ7HydNJnt9zHm8kUCLaq8tDtx8IgdqU7OMlQm95
   4tMExQdc2DBzwWPIjDwRD0CS6c+4OPzz6iX71q7GfzLmxhC/2+n3yMsvq
   mV1Kc6TOW3b+9sZs5Ud7LKz5ew7y3Dpl1FSRVMejs1jfv+LSOx2BxzHoT
   A==;
X-CSE-ConnectionGUID: P5Hsh9VySuu4eturjY+TqA==
X-CSE-MsgGUID: 767+Q1weSACETvv0kkAH4A==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540292"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:51 +0800
IronPort-SDR: 9j81RalhNNQURYpt8EzRmr0CPs6i1mMKmAJ1AiBVB4TeoClYRwD4rug87iWDowoLsf2Nwslvh3
 iJ60OhiVH77EseOzXrorQjWh3l6sFILmjuzEoAgNefEEUsAAyDoKhT61yhUwEvO9e/mDjiTH94
 kYsf8XD/UjxKoeF8USD8UVxHyIW/cU5dGVRYyiMzj4YmEX18xVJCbh2pjX+wdKXA8BoE0Ygql7
 dgo9Ql4Ubv6axp6ix82MsBrRa7bJlNlfNZ7KfxqQWenRgDJ/23seZzUirfnM7d6H9+nxogZFbd
 n14=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:49 -0700
IronPort-SDR: /r2o56pQMmpWDEcNJHGtuzhL8Mvi8YGgsUKZu21Ry/EzigCQypNhuLqdIe6WUVVmGeXsR5EqKc
 /f8E1+02sFb9HqsGvNJUzY7Zvh95BlcvnUaFvn5l7TbCUwB+YbZSpo17DK+d5UZUxrpIZOKNWY
 p4XdU5SE1aTPdIrJ6Uk26BykldZZHbGrJTgM9moOcyM8FEe3Z1H77imvJ1+lUKsx+BWz2LxiMA
 l4FuvZpYdilw6mBvOzrs5W6+/tUIldqIgktHpfNLPI/xAhquJGKNn71WDQZz/twQ8AdOWGEUOz
 H/0=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:50 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 01/17] check: factor out _run_test()
Date: Sat,  4 May 2024 17:14:32 +0900
Message-ID: <20240504081448.1107562-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
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

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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

