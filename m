Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F62127B7D
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263534; cv=none; b=trBD8wlz7dc41H5XqmGzMR2gS+DAS0/LnyhVcsUnb8E73NbUrBhhuoIYIdV5Gq3JK/7O9BFHgh4dxMkQPcf+5aVPhcvONn4PubiQ7fW79iBhUpYI5x08GmP34/LmB2KXJcneVZyCMc1C27SDw/jg627xrmyvr9y7q5TTaEkcdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263534; c=relaxed/simple;
	bh=OULd77odMzihZqoRtAKAJByG8IrF0EFlmFWrGigNWSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad4fkhjWNyJPUf0a1MTCK5Mo2P6mY6/ipWVOEYPxXbviNDC1DPdceTjU/IaaTqTo++YdtAHaHInZuRU9Mg5TdYtRtaTs2T3pkkUX2UwfhkTHPlYKKKzgtvpRNBAgC1Km5X0x4uMWf1LkcfYu4U8FMkSzQ2o9LuTSs+KWNpvhoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NWM64oZ9; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NWM64oZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263532; x=1744799532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OULd77odMzihZqoRtAKAJByG8IrF0EFlmFWrGigNWSg=;
  b=NWM64oZ9I+RDu5mzcDOiIMEKBgeHblw4n7yV9j8rZugQinLCWh9/Tygu
   zf7sCugnh5rfGs0J6caRDoLz35eU+iNM+EmFtpCOzPBtlQ5/tE0YiI4hn
   TSuOCRenWTvQh8wQSLvvPGTCI+1bootfhUFuZb2N/++bkJlMwx9SWs2th
   2QmhLVX8ZVU+bt2VQW2JSbSa5aN9+KhUY5V8SZOsC+4ixwB5613eTmYww
   ouBR/FFCzn4BxU33+sAs1NkInqbALcgd1UR9KVVxvi//F0z/cFSZr21tF
   RSC57Yi80uCj7Wk6e+5IFlGSVuIyWLjc+LaM3/LbJ/k0s8zim0lu346MA
   A==;
X-CSE-ConnectionGUID: C8UuPGZqRpuVHha1b3BZzw==
X-CSE-MsgGUID: jBq0kIapRVOkViUP99Mh6Q==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322612"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:11 +0800
IronPort-SDR: HGFr86W74vaiT0TDhLB6PLyDn1w6VeXWeKV19jiLydGFzUngq4I1FrvxTOFnq1yiFE86pGkoQi
 Skv/B1h6YNyYE1zAax36F4OZVG6Q1xmeXhHXGgoN7SppnoZm7oeDCr/LsmQDPHX/MHglPmlirK
 y7sh+905RiyM5IgoZjsGPf2Y+ucmimoaXTezL5SSpLBdjSXA7Jq9tZkdXs48+QcLNAy2Eat0k1
 pdzuhqarkk7Nzgv41AmVQA5ZFNttMXmx5LhuiMdAAPECCxEkNuApX6lbjdPNOsjK/hCdNzTBU9
 u+8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:40:32 -0700
IronPort-SDR: OG1vlJXPg0nZfzFnr5t+P0MJNu7zY0MN9sHkwwcmMhvsjurQ6nF0hZKU8OxwH0yG8KrY8TzM9i
 whTBqJuB44od0II4cRIdAuvgBtTK138HWVC5lznWmOMor08QF1M1K1p0RdcoIH0W8lrltLrlL9
 ZchcUuPSbAiG1BLc7KzXCZI2hSNsia7wR2v9+/6PdlmkynMN8HtnMN/ZzMSLsB1Q4U+OXXEcaN
 2Pc3SeIjVXP5krRKcdlLIh5oGG0Za33bKQw4IaEXfTeyO/tIeUr+9nPZLY6S6pVXeJrZX5Ujdd
 5fs=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 03/11] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Tue, 16 Apr 2024 19:31:59 +0900
Message-ID: <20240416103207.2754778-4-shinichiro.kawasaki@wdc.com>
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

When the test case with test() function is marked as CAN_BE_ZONED,
blktests runs the test case twice: once for non-zoned device, and the
second for zoned device. This is now implemented as a special logic in
the check script.

To simplify the implementation, use the feature to repeat test cases
with different conditions. Use set_conditions() and move out the special
logic from the check script to the common/zoned script file.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check        | 19 ++++++++-----------
 common/zoned | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)
 create mode 100644 common/zoned

diff --git a/check b/check
index edc421d..3ed4510 100755
--- a/check
+++ b/check
@@ -56,6 +56,11 @@ _found_test() {
 		return 1
 	fi
 
+	if [[ -n $CAN_BE_ZONED ]] && declare -fF test >/dev/null && declare -fF set_conditions >/dev/null; then
+		_warning "${test_name} defines both CAN_BE_ZONED and set_conditions()"
+		return 1
+	fi
+
 	if (( QUICK && TIMED )); then
 		_warning "${test_name} cannot be both QUICK and TIMED"
 		return 1
@@ -194,7 +199,6 @@ _output_status() {
 	local status="$2"
 	local str="${test} "
 
-	(( RUN_FOR_ZONED )) && str="$str(zoned) "
 	[[ ${COND_DESC:-} ]] && str="$str(${COND_DESC}) "
 	[[ ${DESCRIPTION:-} ]] && str="$str(${DESCRIPTION})"
 	printf '%-60s' "${str}"
@@ -464,7 +468,6 @@ _unload_modules() {
 
 _check_and_call_test() {
 	local postfix
-	local ret
 
 	if declare -fF requires >/dev/null; then
 		requires
@@ -473,15 +476,6 @@ _check_and_call_test() {
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
-	ret=$?
-	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
-		RESULTS_DIR="$OUTPUT/nodev_zoned${postfix}"
-		RUN_FOR_ZONED=1
-		_call_test test
-		ret=$(( ret || $? ))
-	fi
-
-	return $ret
 }
 
 _check_and_call_test_device() {
@@ -540,6 +534,9 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
+		if ((RUN_ZONED_TESTS && CAN_BE_ZONED)); then
+			. "common/zoned"
+		fi
 		if declare -fF set_conditions >/dev/null; then
 			nr_conds=$(set_conditions)
 			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
diff --git a/common/zoned b/common/zoned
new file mode 100644
index 0000000..6a8f1e5
--- /dev/null
+++ b/common/zoned
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+
+# The helper function for test cases with CAN_BE_ZONED flag and test()
+# function. Run the test case twice for non-zoned and zoned conditions.
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	if ((index == 0)); then
+		export RUN_FOR_ZONED=0
+		export COND_DESC=
+	elif ((index == 1)); then
+		export RUN_FOR_ZONED=1
+		export COND_DESC="zoned"
+	fi
+}
-- 
2.44.0

