Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A146C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DC420880
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oKIdCZOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1NPt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:15:49 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60364 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfA1NPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548681347; x=1580217347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o3ijVPlHOHweejMKpnpz1+JJdIfDikp98NdosZb2dsM=;
  b=oKIdCZOaq0uz7u5CKzhuYCY21VsPJtebSWM2SGFj6lD/Shg2MNJWw4Fr
   Zja3BjfEBabk3jDBLAhMN8Fnw9F9taf+n0/dG90x4XluB3f8WCncf2MXc
   GWzF6nUtBiiGwtSTQXK5+KrJ9jn6XpNsin8+g8Z3l1kp9Qep9C7KtdCry
   1+/kSqdoZ7Xrp1BQeJLZKmO4e5O5WOJz5VtnPpQwFQNKE7nE1s5z2CcKX
   Ng02hWnfwGnwVcsNVTmswThbLR9hKx63PASC//qeUKg3kH5uFfekUtdAM
   kVcHQs2XE9wPVBittIekl6/XlNV958lSdMRJ4yWblw7ENHPNW5CoY/BSY
   w==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="204977764"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 21:15:47 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jan 2019 04:56:48 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2019 05:15:44 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v4 11/12] zbd/004: Check write split accross sequential zones
Date:   Mon, 28 Jan 2019 22:14:54 +0900
Message-Id: <20190128131455.31997-12-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
References: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Masato Suzuki <masato.suzuki@wdc.com>

Check that write operations spanning a zone boundary are correctly
processed as 2 different write operations each fully within a single
zone.

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/004     | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/004.out |  2 +
 2 files changed, 101 insertions(+)
 create mode 100755 tests/zbd/004
 create mode 100644 tests/zbd/004.out

diff --git a/tests/zbd/004 b/tests/zbd/004
new file mode 100755
index 0000000..ee7a6f0
--- /dev/null
+++ b/tests/zbd/004
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Check kernel splits write operations across a zone border. Select two
+# contiguous sequential write required zones and confirm write oprations
+# across the two zones succeed.
+
+. tests/zbd/rc
+
+DESCRIPTION="write split across sequential zones"
+QUICK=1
+CAN_BE_ZONED=1
+
+fallback_device() {
+	_fallback_null_blk_zoned
+}
+
+cleanup_fallback_device() {
+	_exit_null_blk
+}
+
+_check_zone_cond() {
+	local -i idx=${1}
+	local -i cond=${2}
+
+	if [[ ${ZONE_CONDS[idx]} -ne ${cond} ]]; then
+		echo -n "Zone ${idx} condition is not ${ZONE_COND_ARRAY[cond]} "
+		echo "cond: ${ZONE_COND_ARRAY[ZONE_CONDS[idx]]}"
+		return 1
+	fi
+}
+
+test_device() {
+	local -i idx
+	local -i phys_blk_size
+	local -i phys_blk_sectors
+
+	echo "Running ${TEST_NAME}"
+
+	# Get physical block size and sectors for dd.
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	phys_blk_size=${SYSFS_VARS[SV_PHYS_BLK_SIZE]}
+	phys_blk_sectors=${SYSFS_VARS[SV_PHYS_BLK_SECTORS]}
+	_put_sysfs_variable
+
+	# Find target sequential required zones and reset write pointers
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	idx=$(_find_two_contiguous_seq_zones) || return $?
+	_reset_zones "${TEST_DEV}" "${idx}" "2"
+
+	# Confirm the zones are initialized
+	_put_blkzone_report
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	_check_zone_cond "${idx}" "${ZONE_COND_EMPTY}" || return $?
+	_check_zone_cond "$((idx+1))" "${ZONE_COND_EMPTY}" || return $?
+
+	# Fill first target zone, remaining a physical block to write.
+	# Set physical block size as dd block size to meet zoned block
+	# device requirement.
+	if ! dd bs=${phys_blk_size} \
+	     count=$(((ZONE_LENGTHS[idx] - phys_blk_sectors) \
+			      * 512 / phys_blk_size)) \
+	     if=/dev/zero of="${TEST_DEV}" oflag=direct \
+	     seek=$((ZONE_STARTS[idx] * 512 / phys_blk_size)) \
+	     >> "$FULL" 2>&1 ; then
+		echo "Fill zone failed"
+		return 1
+	fi
+
+	# Write across the zone border as a single block write.
+	# Specify count=1 to request one shot write, expecting kernel to split
+	# the request. Set dd block size as phys_blk_size * 2 to make count=1.
+	local -i start_sector=$((ZONE_STARTS[idx+1] - phys_blk_sectors))
+	if ! dd bs=$((phys_blk_size * 2)) count=1 \
+	     if=/dev/zero of="${TEST_DEV}" oflag=seek_bytes,direct \
+	     seek=$((start_sector * 512)) >> "$FULL" 2>&1 ; then
+		echo "Fill zone failed"
+		return 1
+	fi
+
+	# Confirm the zone conditions are as expected
+	_put_blkzone_report
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	_check_zone_cond "${idx}" "${ZONE_COND_FULL}" || return $?
+	_check_zone_cond "$((idx+1))" "${ZONE_COND_IMPLICIT_OPEN}" || return $?
+	if [[ ${ZONE_WPTRS[idx+1]} -ne ${phys_blk_sectors} ]]; then
+		echo -n "Unexpected write pointer for zone $((idx+1)) "
+		echo "wp: ${ZONE_WPTRS[idx+1]}"
+		return 1
+	fi
+
+	# Clean up
+	_reset_zones "${TEST_DEV}" "${idx}" "2"
+	_put_blkzone_report
+
+	echo "Test complete"
+}
+
diff --git a/tests/zbd/004.out b/tests/zbd/004.out
new file mode 100644
index 0000000..dd4ea94
--- /dev/null
+++ b/tests/zbd/004.out
@@ -0,0 +1,2 @@
+Running zbd/004
+Test complete
-- 
2.20.1

