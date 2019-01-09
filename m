Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADFAC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CE02146F
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T0cuNyy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfAIBgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAIBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997800; x=1578533800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRStSmA3z7y5GT4HO7DZcFbbF37eLE/fboNsTo5oOSo=;
  b=T0cuNyy2t1XE3FHwF6UacCNv83BH7cP6oX9LGJX7w/I2xxH6uK+IPiNe
   /0jTX8HCFRMTqSUoxNli5/Dxn85Xz3xEHrrh79e2ji7mzET2UjlYpP21n
   pfRbmpQFsyNY8IXJwE0h5+atNJL7a8doV2tb72v0mTqm3XBfl/jU6qnaO
   HtMWWh0vyN18miHkB033t3Obn76A4xr/Nw9FoT46YXDJLoq7WMZ27nNDH
   l5iIJHlUuB1WJWxpxQuIfM6BetMcJ41NOPFOU6Ycz+mEaFsKVClanUviL
   Rpf3tnQS0x9INkax7A+y9dPyaHqkuePGRfRCR4r6BoWU8WUGA3bf6Z7gV
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169217"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:40 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:41 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:37 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 12/14] zbd/003: Test sequential zones reset
Date:   Wed,  9 Jan 2019 10:35:40 +0900
Message-Id: <20190109013542.23686-13-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
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

