Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45A147C92
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834025; cv=none; b=E41G7+rgsrZxi9Fb34QnMzfPViDRQVwMAMIr48p3Wv50mpl4Tv/df/1sXtXS8y17VAR1pnPmusB7/7QXsj7fwfeicf9OQ76k1xh7wAO+mabD+FTG12hwhZrl2WjzOM+fTeLtGjR2BnBNpkiTABpUW9g4bmf5RwDx5YH7KO3QytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834025; c=relaxed/simple;
	bh=Gvq2kP8QGe4kZ9iHWlwYHHp657BYUaSrEtjR03kuTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD7RCGMpHkDyVLcqgItc7KLFwmVQIzFlHxP3hIhVY2M/gqth01KlJZt3bgcIFmt5FZkmtOyrUK7RtcmuoOW3JOLFai1d1hKIzGY6WLllx5wNaR3pKl2aVOgbyN5c9Ys9xFAwGYla/uKBssj0X8I4dP/m3dxaNHgEMMOZO/wmp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AYiYhnOq; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AYiYhnOq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712834023; x=1744370023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gvq2kP8QGe4kZ9iHWlwYHHp657BYUaSrEtjR03kuTkM=;
  b=AYiYhnOq7/z6RfGD0r+c447ncyhZojEr3wps0U8NOCmO8OxgXxZSajOx
   qyuK/N6L5h/gAHdfMdp/+h05XOnmp461Q1I0abeUGVduG6f5dM60vE08Z
   yVRt2fLw6ZOtZQoX6BuKjI8o9mwN6thVnps6ppNO4KT1s/LTp2e9B215f
   q06XlWEB+po2in5tPc5tawVUuQuprOmxjxKH3A14ivDunTdGUoYQVvw29
   /TO0ldxO7oHOV41/ef1SKkMA/FfxsJ1pewwoEM9s/gaCw54sZs9bFrJbP
   T8+3TpaDaCI3ATfdxghJ0+z/vKslMpvp4TXrsCQ/L9GHMQCOpwZjbWyGi
   Q==;
X-CSE-ConnectionGUID: waK2hqAnQeKlyUgC1M1FFg==
X-CSE-MsgGUID: bIpKIMHwTQiVy65tKNLXTw==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579864"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:33 +0800
IronPort-SDR: IhsMJgZLeNQYXF2tkN4Tm/XqU/G5C2w+4hXRMVOZ7dGRsw7Xmqpnx6THVIDMKKGP6vsyMpLS1l
 Fl6wiogpm//Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:18 -0700
IronPort-SDR: TrqEZxDh+H+nP45uKrePgG9poAGhw3h7JflL9lqG/xkZ6hPd0I1obmHHW21IqUF6mDACDIAIDf
 Zw60n9vCHwOQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 03/11] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Thu, 11 Apr 2024 20:12:20 +0900
Message-ID: <20240411111228.2290407-4-shinichiro.kawasaki@wdc.com>
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

When the test case with test() function is marked as CAN_BE_ZONED,
blktests runs the test case twice: once for non-zoned device, and the
second for zoned device. This is now implemented as a special logic in
the check script.

To simplify the implementation, use the feature to repeat test cases
with different conditions. Use set_conditions() and move out the special
logic from the check script to the common/zoned script file.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check        | 18 ++++++++----------
 common/zoned | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)
 create mode 100644 common/zoned

diff --git a/check b/check
index cef84ec..aeca894 100755
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
@@ -472,15 +476,6 @@ _check_and_call_test() {
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
@@ -538,6 +533,9 @@ _run_test() {
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

