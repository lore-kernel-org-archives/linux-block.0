Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046911586FB
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945609; cv=none; b=OJIHq/ENRrPTtDI3x2DfXFF/qFf/3msBw1Ap9QYc9fRWqhT9hQlwvumNMa8OT/ACOPUZacYY6dn3rHFtK7CDgQBzyGula0jUS4lpB2cQdFBV/0QTAVC2SB8xqdZPkJvTS3WtLq7JDs2vyzX1iCWUCjtWr+WE2c3tbLMxxbGBeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945609; c=relaxed/simple;
	bh=lG5GYMuyEZNZtr3PgzkOH8KI6EYXvgXm7PdLubwRkjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI5/lcV4qEQcG/1fLU1aQq9xFqVoTe7kdUhCZNF5KiCv8AXEpTqa1OwxoKxPtsfQkFtQoWo6J0PdB9d64gvZmGZVw+yZWTUbgbEdx4Vvs64poUCcBIpQGTl+otA36BAqRBt9KAf7AJkDUYH4iT11+KKTK66MByHKmfOmT1TfXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Jk6CMth9; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jk6CMth9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945606; x=1745481606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lG5GYMuyEZNZtr3PgzkOH8KI6EYXvgXm7PdLubwRkjs=;
  b=Jk6CMth9jWD2blK8ulklfwIkz80ViDU5cyskahdgr2xLibssSett1RjR
   z8AKV4j7G6MqmgYsM/sXSpv/fVKDkLxwfAY5InVlEju7zIai7SWJVidRw
   c83pz23AHQsMp7MdJPw9FG+TxC0dLCtI7TKINqdPTo8mtKNLBO/hJicsO
   Z7dtGQs7WnwOwl67RxPH0LgHgFTHls+lnBEUw6qm0iCDT2PDomU4SG+6j
   zCOe0Jj3Qhann8UqBcqGwMfjxQ89Y7xH5wHbXSA0GLF3n/cyqhXLzkYJ3
   dLK/6cwiZKyXMPX5QfkPkG/O/qVMtMOtGU0JGIv7xQx3KLlhHnImvjnvG
   w==;
X-CSE-ConnectionGUID: wG140JrvQJqiyUoL626xmA==
X-CSE-MsgGUID: u3knHSk8SxKTXw3wc+sDAg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515675"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:59 +0800
IronPort-SDR: MN8+eeGloKnfdxKlXprGphog65THY4AXf7y1g3Q+ZWgfcU/Nt0VerzIP01L1msGN5JYbyMeATN
 E10IwSScVnE+pXphwgMY5p1ZO6jlxAaSRyDYmmb9dAE86sZ9pkIGydnPJ5mlTUWyWz4FH9mvWt
 /nnroghjNBDPawPoXVAqcs37+ikll+jsnDaqUOCLFPUjj6r7fpDCabSs0//37ywI1zbRq9WGmw
 UieAhRS0USQ6lAHjzst7H5rrwxOy8ZMTpCElXN/cx4k27uHKp/pZIj1s1/AnJGYvAf8ojqiLbY
 wGQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:09 -0700
IronPort-SDR: 7ZI83bO/6w3h1mphMJLq9putUiGHtXW82tRutl7d8uisL7r1SW7JsxGSx8qtfxXtCRl1zscLAR
 gA0+Q+4lua/hXXIYu2WVcyHD/ROKUBFLO1GNTCHrcVEMODcHdJS8i4oS0+YAs1SLyTrYnVFGfB
 WJJ7aMHPcstomIYQSj3AInQNbskfAbaOBKxqjB5kgtfNKafRh5N/KHoFeSCF04kCxdz/5A9Evy
 PBjo+7dTeuESjCmE9WtHL5y3Grm23RKr8VcwnLQgs+PVig9urxfczxfI7ridHoGHRsVcxVCs3/
 DCg=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 03/15] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Wed, 24 Apr 2024 16:59:43 +0900
Message-ID: <20240424075955.3604997-4-shinichiro.kawasaki@wdc.com>
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

