Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F7C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403DF214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qd8yquOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfAJJif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:35 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16282 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfAJJif (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113116; x=1578649116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRStSmA3z7y5GT4HO7DZcFbbF37eLE/fboNsTo5oOSo=;
  b=qd8yquOEj35SufcEWkfXLYoC/8AaALr5Hmys573gu3yL2LJO0QouJ6Cc
   fMKeu4b+rROfIFkPb7TGmY57vli52URZxlk1hzRwOzJ0/34xTUSO6cmjH
   YvCeT1Y2CXBoYlXjWsiF7ZJ0WVt5MvMMlMew+6DnCQjZxte6FBxsJi+7G
   k55dDWZSmIZBkXISyl60nxHyyk9RTfHyw34kjyVd2R3tMMJzHjNWCuD0/
   pLaTEptu7rJKpHX8UnvKS75+5XEop9P5To9J2Y16peEfiQjVSNYEmtyiB
   mGB9OHBIwp9oqetqjLYWILwbQZHPsmKtOgPBtJ8i4drYzEcZCjQdwlW6h
   A==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="100223376"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:36 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:20:06 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:38:32 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 14/16] zbd/003: Test sequential zones reset
Date:   Thu, 10 Jan 2019 18:37:23 +0900
Message-Id: <20190110093725.32675-15-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Masato Suzuki <masato.suzuki@wdc.com>

Test zone reset operation to make sure that the BLKRESETZONE ioctl call
works as expected but also that the zone sector remapping that may be
done for logical devices (partitions or dm-linear devices) is correct.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/003     | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/003.out |  2 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/zbd/003
 create mode 100644 tests/zbd/003.out

diff --git a/tests/zbd/003 b/tests/zbd/003
new file mode 100755
index 0000000..a44960d
--- /dev/null
+++ b/tests/zbd/003
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Confirm that reset zone command for 2 contiguous sequential write
+# requried zones works as expected.
+
+. tests/zbd/rc
+
+DESCRIPTION="reset sequential required zones"
+QUICK=1
+
+requires() {
+	_have_program blkzone
+}
+
+test_device() {
+	local -i zone_idx
+	local -a target_zones
+	local -i phys_blk_size
+
+	echo "Running ${TEST_NAME}"
+
+	# Get physical block size for dd
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	phys_blk_size=${SYSFS_VARS[$SV_PHYS_BLK_SIZE]}
+	_put_sysfs_variable
+
+	# Select 2 target zones so that reset zone range also get tested
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	zone_idx=$(_find_two_contiguous_seq_zones) || return $?
+	target_zones=( "${zone_idx}" "$((zone_idx + 1))" )
+
+	# Reset the 2 target zones and write 4KB in each zone to increment
+	# their write pointer positions
+	_reset_zones "${TEST_DEV}" "${zone_idx}" "2"
+	for i in "${target_zones[@]}"; do
+		_dd "${TEST_DEV}" "write" "${ZONE_STARTS[$i]}" \
+		    "8" "${phys_blk_size}"
+	done
+	_put_blkzone_report
+
+	# Check that the write pointers have moved by 8x512 B sectors
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	for i in "${target_zones[@]}"; do
+		if [[ ${ZONE_WPTRS[$i]} -ne 8 ]]; then
+			echo -n "Unexpected write poiter position in zone ${i} "
+			echo "wp: ${ZONE_WPTRS[i]}"
+			return 1
+		fi
+	done
+
+	# Reset the 2 target zones
+	_reset_zones "${TEST_DEV}" "${zone_idx}" "2"
+	_put_blkzone_report
+
+	# Check that the write pointers have moved back to position 0
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	for i in "${target_zones[@]}"; do
+		if [[ ${ZONE_WPTRS[i]} -ne 0 ]]; then
+			echo -n "Unexpected non-zero write poiter in zone ${i} "
+			echo "wp: ${ZONE_WPTRS[i]}"
+			return 1
+		fi
+	done
+	_put_blkzone_report
+
+	echo "Test complete"
+}
diff --git a/tests/zbd/003.out b/tests/zbd/003.out
new file mode 100644
index 0000000..7326ae4
--- /dev/null
+++ b/tests/zbd/003.out
@@ -0,0 +1,2 @@
+Running zbd/003
+Test complete
-- 
2.20.1

