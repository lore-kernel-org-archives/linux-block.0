Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EF10A26
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810501; cv=none; b=H2ZtQlXQ/tMXKGGcTfRXqQUAVABc/NTtA1pI5vaWqivF1GnhgSXgHqWSeMXBxZsll8fkkh0HDHue7yO92J/RHRZVbf1eCCxq12ZELdf9gEv8o604Mh9/ngHgwRfhtGVAJRLCMAT1cf/izUcef7qKb5KPVy+rBFx7u7MQMm+Ok1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810501; c=relaxed/simple;
	bh=lG5GYMuyEZNZtr3PgzkOH8KI6EYXvgXm7PdLubwRkjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwoBdBAA0z49rdm5lZsIpvr6UmdYNuwHMa8r4cLNXTJm9WNgfr7KzrpcB9KfDMSQpXwUg8M4Eh4nDAQXJKFhItfT37td6Jvr6RMrx0xt5SkshJDqoNF7byo9eA3OwkEjYk0I6DWNsG+7OcmQr7sXjAPduefd9bngc6+QPpK/U+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i8McxMok; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i8McxMok"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810499; x=1746346499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lG5GYMuyEZNZtr3PgzkOH8KI6EYXvgXm7PdLubwRkjs=;
  b=i8McxMok9Cucqbx+otxi9KyPol+Yxk0sIApRIuW0enyRiy1xxBUMiAr5
   l+8xhfahbg3l9pBtyEO6LkoKrqWaz3i23FpSR9iBPPtUJT6teCJz/XShD
   yb5WveEv0OtrVyUEgF29gbQQ5s9ft6rBcnEiYfnWp192xr23+jlmE3ze1
   SdVp4u8mCLdq4qlqE4DPIzhSYH35nfINurxMSiJS4olFBTolFC1yvO2Sa
   mPa5MmldloI9+TKzrRJ59DX2tqx+y35GZ0BqY0dEI6cTQjk4VRqSYl6Ir
   waELV7ysUNOy3d5px8ChPIkpGy56UK2UnXQbn5sFjig8/qOOH5ELhA3t/
   w==;
X-CSE-ConnectionGUID: OqgIuhN7ToaQVWzJeMJI2Q==
X-CSE-MsgGUID: JPhyIj16Qeu8PnsyV+LM5w==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540300"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:53 +0800
IronPort-SDR: kTn4mV+kbZFNDWCZu+ameKggMm+zO0a29LVtMaNcG8a3rB9Ixj2gBnHgBdVUthsNcEB0gQMEcE
 GeMZniv9Gy+gJI9x3EYGXj2zZqf2xl7GRvTKQCm307nyH3uvVuqcitLlHrDMdoPhjTGztnmiS6
 NcaZyrcgOxfqKKGtWnP/8rkpIiY3le7UfXHgzCTNv+15AUNg3SuIjOguPCTWhzd1Wu76o9y5XA
 0LOPIgA9rDNDg7ogBAo98PIVK35zffvepI9buXxnxNZHDwwWCEgX7mrwg+oMFXBID1AvmijdgY
 0pY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:51 -0700
IronPort-SDR: TnZsY5mQEhAvgfttTqVAfxDhETXfdWQBYyxSQ/pwzJPRDRWZp5yd3M99pw9qyt3ZFFYcY6Zx2e
 UVdjXON1gOVQzCueEqhl80cHxAbgtMTh8mVI/UOkIVN/yTKDY79PIGYkgdre69xARSuxWuqTy3
 j0vNy2mFqnSS/jPDqxgbkUELqaX+sKTI8K4ZDmxcnz5cS/qRuzrSyLtb2JERVyzkJS70UjvKQn
 /2M1rlBV6RmmdzdGrYvo16T1Z5gWvhkQad2OAiS5maazgEYLe81vTFtdwrLmiX1txwPpPWfP7m
 LeI=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:53 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 03/17] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Sat,  4 May 2024 17:14:34 +0900
Message-ID: <20240504081448.1107562-4-shinichiro.kawasaki@wdc.com>
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

When the test case with test() function is marked as CAN_BE_ZONED,
blktests runs the test case twice: once for non-zoned device, and the
second for zoned device. This is now implemented as a special logic in
the check script.

To simplify the implementation, use the feature to repeat test cases
with different conditions. Use set_conditions() and move out the special
logic from the check script to the common/zoned script file.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
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

