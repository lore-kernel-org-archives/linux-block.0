Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E06158A0E
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945607; cv=none; b=bIgUoF85v3wqe8W2As17kX6evWRkhPM9CCkYIPVtMie8Z2OfMRXVCMw1TDCSwfgZweCSOc8QpteN6TlPPICt1flnU05bp8RmiP4UJ0ziebf8ugOQbDvAhW2hWF/pvSv0RLDhk5onQ6hfOB3/kdz5pbCx4sgevgGVZrBn0jMLqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945607; c=relaxed/simple;
	bh=29N5U6N1y9BlM6ECK69L6XwHI/nK7ulbD7kVCqyaSx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6h5trBD/4GKiycfgOSI3k8/3QyAvA3ijKerp0ep3Ko683bt/uEsGalgi0C6lxxclVbtpM7EChzHDCTOkiAKVbXaG1J3f0/aJQJNG74zApZG3VOrTzNUu15kmKJigGX1+qKo4BCeJVhYrXIHnDkyhImzB3y4Cbn2WPreJi6BPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NX1jxUhg; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NX1jxUhg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945605; x=1745481605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29N5U6N1y9BlM6ECK69L6XwHI/nK7ulbD7kVCqyaSx0=;
  b=NX1jxUhgxoU8gpao+yTHv7UaSLe+5rTFV0P3btLiyHdAhTyTeOjpkGAV
   jr12nIwupmYECyRRK/+xnNzapLl5aA9DpVclTTIyrIB6MZacfU4mNqINN
   +aapo6vkEAUunCf5uew68DIRpkHUuwoFPXasjLQO19iprcFu/RcFBN36C
   NLdwFsQ2iOCH+mDGyOp491XROul3qSsco5b4lSqBQQE+hr57Twwvu1IIE
   BdCllGKP6a3K8ieQzGgNgZwCjHUoYsuCxqjx7J4oqPgAMMWUDuGT29xVV
   Yeb+qqsO9Mfa1bWB00bJ/YVPIIuCebadilDfMzMDMQGO2FmZHl0eBlIOE
   A==;
X-CSE-ConnectionGUID: vZZTdpT4TNuccYAbwe9jRg==
X-CSE-MsgGUID: h31mIjoJQrWOjcJHPlEK2g==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515670"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:57 +0800
IronPort-SDR: 4HqjoBhoD6vkZ8M9YYB+fDPGU/MzuIC2Ftd8eIELvy245fpX61s1XTDXCEElffSDDzXDCDcqKF
 7tDpYym44bTEYK68jhaZhsc8x/ZENGxKeWcRJBwADsAZUc+L1WxZMQ96ckHRD6ZNP60H9dc6mR
 C9WWOD4b2Rpm+HykQpGkJc87mz7mPwvPm/3+sLWTkvfz5oz9DmpN5DUtoLJA94Vbf7ZJ9eSG0N
 yy3SLXrqzAFktuUfYgSOPaH60Z5+jJf9ADVxbT7TPwPeKr6eOqhB0jJCKvsYsQwqZT6+67mXEj
 oOA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:07 -0700
IronPort-SDR: nBmiefH4CHw2SsOQtpcUduyjB5QQNs1gVt3JDxhSep7wcQpdN67xR+XN/0hGvJgXgTcXmHatPS
 GuHwaVsVtwfY+9CpRvDd/V8EUOC2hhIOvssoU45K0CmygkmBkE5NiO7SUc0/oBDYx59zme8m+L
 1WcQq53Al1jl6vwxfRrMg7VeU3c7pNdYDXTtBQLbSonSvJ8oPYPReB/tNX5LOPGmVa+GzbVxof
 7bihKXNlLp18USScw3PPRz/LeBkYhWB7N/ldZ9HLYFWrIMixtD9BPNGzwXjXcbwbzJzIBmMk3j
 jxU=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 01/15] check: factor out _run_test()
Date: Wed, 24 Apr 2024 16:59:41 +0900
Message-ID: <20240424075955.3604997-2-shinichiro.kawasaki@wdc.com>
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

