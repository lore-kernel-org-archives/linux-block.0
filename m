Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47165C001DE
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGSHPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGSHPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CA1E47
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750914; x=1721286914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3fF1NGMIcRWVjBOewH3fuROA4CJqtnPUQFzIkVwHVm8=;
  b=cQMqrSHdrMGIoxbVQbHRzDEryM+0FkvabRAn4jDsUd8CBvm9ERb+S3ZJ
   w1cY8PYNeaeKRNnlsmYO78ZTDby8GQHnZhjDylq1Tf1+9cSonQ61hCnta
   uaWNkKSRQQVDabNax7Ow7Sk1jZUw8uxz5fK09PIadFtdj32jyKYi54zdY
   kDaxbGIFvr87xH8l0zsnEFx6CW/fSgYMBWHQHUyh1VEv9Q7sP+SI4gfuY
   y/2CkdK4B0DGHjSDfGWj32kWWlUbxtjRQnqHPyJbHZB44NNHoTOZTcNBa
   Sd5kOljEeTxBMFv2N1U1mdMYuvxwyGqpncaLS0GRTaEs0a15KGmRrzfdh
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846517"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:12 +0800
IronPort-SDR: T5ashRWuF20qy9+30nKI+IMmv8UiOmdy+iS/2GsnJMbXljtKANAXlFcNuvU84bADz7ssA9Us3H
 3RtPTAk6IGqR/fCQpPEXJaJ8+ANKRjIU+uEjtaCoyEHwCTOTmymvz5oS77HjWyBhcedxn4kOaY
 ahzdI9SsCLugn4raZzy4SAH37EAh1rKhLjfbowNepeqQQlIQehj6oB5JN+L0/XMjqVdO0Ajzpi
 OK8OkHb1eRR3HE9UPIRJYQgWG+N2GKvWZHjkrW/hKYQC151bTOZs+ojkJS+ZelqT3V7qXt9zxZ
 INc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:23:24 -0700
IronPort-SDR: jIcVTulS4JZ487tzqYQdpZ/JGLIYXAGGYvKxyB9Tj7/R6DfUZ16Pqbz6rBKSHZgbVxVglpE0u2
 1N4BnTLOm/XZqBgVWYbZ+82YRsw/IVWFUI1B3NVc4sdK7t2QC/JXd4Qt6mXkqgcqovq9VoPXU3
 ZImBRVv/ede1wCcXw39s/FD/A5K3kwLuOfx0JyoBKmO4EnN/Qaa95gv6/Qmpy1PJTaf5N1m4jL
 9z77eCVpS7Rlv6M9+kJgiRpdMKe1hILTI2SbmdEqPhHZV5LQSC6oqG7cpS9syajikidbUdbsvJ
 2h8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:12 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/6] common/dm: add script file for device-mapper functions
Date:   Wed, 19 Jul 2023 16:15:06 +0900
Message-Id: <20230719071510.530623-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create a new script file common/dm and move two helper functions for
device-mapper from tests/zbd/rc.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/dm    | 23 +++++++++++++++++++++++
 tests/zbd/rc | 19 +------------------
 2 files changed, 24 insertions(+), 18 deletions(-)
 create mode 100644 common/dm

diff --git a/common/dm b/common/dm
new file mode 100644
index 0000000..85e1ed9
--- /dev/null
+++ b/common/dm
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Western Digital Corporation or its affiliates.
+#
+# scsi_debug helper functions.
+
+_test_dev_is_dm() {
+	[[ -r "${TEST_DEV_SYSFS}/dm/name" ]]
+}
+
+# Get device file path from the device ID "major:minor".
+_get_dev_path_by_id() {
+	for d in /sys/block/* /sys/block/*/*; do
+		if [[ ! -r "${d}/dev" ]]; then
+			continue
+		fi
+		if [[ "${1}" == "$(<"${d}/dev")" ]]; then
+			echo "/dev/${d##*/}"
+			return 0
+		fi
+	done
+	return 1
+}
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 2e370f0..ffe3f6c 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -6,6 +6,7 @@
 
 . common/rc
 . common/null_blk
+. common/dm
 
 #
 # Test requirement check functions
@@ -281,10 +282,6 @@ _find_two_contiguous_seq_zones() {
 	return 1
 }
 
-_test_dev_is_dm() {
-	[[ -r "${TEST_DEV_SYSFS}/dm/name" ]]
-}
-
 _require_test_dev_is_logical() {
 	if ! _test_dev_is_partition && ! _test_dev_is_dm; then
 		SKIP_REASONS+=("$TEST_DEV is not a logical device")
@@ -307,20 +304,6 @@ _test_dev_has_dm_map() {
 	return 0
 }
 
-# Get device file path from the device ID "major:minor".
-_get_dev_path_by_id() {
-	for d in /sys/block/* /sys/block/*/*; do
-		if [[ ! -r "${d}/dev" ]]; then
-			continue
-		fi
-		if [[ "${1}" == "$(<"${d}/dev")" ]]; then
-			echo "/dev/${d##*/}"
-			return 0
-		fi
-	done
-	return 1
-}
-
 # Given sector of TEST_DEV, return the device which contain the sector and
 # corresponding sector of the container device.
 _get_dev_container_and_sector() {
-- 
2.40.1

