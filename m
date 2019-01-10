Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE315C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB4A214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SgVFKLT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfAJJic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16282 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfAJJic (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113112; x=1578649112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBGBtYmwjJ8wWnNKjXnkEfAyt68CuDq6gtWu3cK56ow=;
  b=SgVFKLT1BLks3RucYZ4Ea3JPEdC5cdTNE7gfKkwsHhc3Lc3v4jdAgR0b
   zPaKFA69mwmfE4xk1iGvKIkaN3MtkO3n0fXFx16l609cj0VGjDpSt+5KJ
   GMn0iTHSuSI/SEr6x218O9G88oFCzqPlMbG1UpnUmxs+Nu44wDOZSlPyy
   DwXrX9zkOG1MsOF7zNFznb4g6KPeSlVebP0wSUjt50qPO6dyTO9CaI2Gz
   +vdBit4R8GDrOOAUvrWLwH/56F9q+iabby2DLdfmWcbwk5p04v0kWSK9N
   zV8XLt7xl9XekND3fUplEevUo2QhvHHFPpydSnsjTw2DMnkWGFusZXivx
   w==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="100223371"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:32 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:20:02 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:38:28 -0800
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
Subject: [PATCH blktests v2 13/16] zbd/002: report zone test
Date:   Thu, 10 Jan 2019 18:37:22 +0900
Message-Id: <20190110093725.32675-14-shinichiro.kawasaki@wdc.com>
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

Get a report for all zones and confirm that the reported values are
valid and consistent with regard to the device capacity and zone size.

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/002     | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/002.out |  2 +
 2 files changed, 101 insertions(+)
 create mode 100755 tests/zbd/002
 create mode 100644 tests/zbd/002.out

diff --git a/tests/zbd/002 b/tests/zbd/002
new file mode 100755
index 0000000..aec4813
--- /dev/null
+++ b/tests/zbd/002
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Issue report zone command and confirm consistency of reported values.
+
+. tests/zbd/rc
+
+DESCRIPTION="report zone"
+
+_check_blkzone_report() {
+	# Utilize local variables as much as possible to speed up loop execution
+	local -i max_idx=$((REPORTED_COUNT - 1))
+	local -i chunk_sectors=${SYSFS_VARS[$SV_CHUNK_SECTORS]}
+	local -i cur_start=${ZONE_STARTS[0]}
+	local -i next_start=0
+	local -i len=0
+	local -i wptr=0
+	local -i cond=0
+	local -i zone_type=0
+
+	# Confirm number of reported zones
+	if [[ ${REPORTED_COUNT} -ne ${SYSFS_VARS[$SV_NR_ZONES]} ]]; then
+		echo "The number of zones reported differ from sysfs nr_zones"
+		echo -n "Reported zones count: ${REPORTED_COUNT}  "
+		echo "sysfs nr_zones: ${SYSFS_VARS[$SV_NR_ZONES]}"
+		return 1
+	fi
+
+	# Check consistency between last zone size and capacity
+	local -i last_zone_end=$((ZONE_STARTS[max_idx] + ZONE_LENGTHS[max_idx]))
+	if [[ ${last_zone_end} -gt ${SYSFS_VARS[$SV_CAPACITY]} ]]; then
+		echo "Last zone start sector + length exceeds capacity"
+		echo -n "Capacity: ${SYSFS_VARS[$SV_CAPACITY]}, "
+		echo "last zone start sector + length: ${last_zone_end}"
+		return 1
+	fi
+
+	# Check each zone parameter validity and that all zones are contiguous
+	for ((idx = 0; idx <= max_idx; idx++)); do
+
+		next_start=${ZONE_STARTS[$((idx+1))]}
+		len=${ZONE_LENGTHS[$idx]}
+		wptr=${ZONE_WPTRS[$idx]}
+		cond=${ZONE_CONDS[$idx]}
+		zone_type=${ZONE_TYPES[$idx]}
+
+		# Check two zones are contiguous
+		if [[ $((cur_start+len)) -ne ${next_start} ]]; then
+			echo -n "Zones are not contiguous at zone ${idx}. "
+			echo "cur:${cur_start}+${len}, next:${next_start}"
+			return 1
+		fi
+
+		# Check zone size
+		if [[ ${len} -ne ${chunk_sectors} &&
+		      ${idx} -ne ${max_idx} ]]; then
+			echo -n "Zone size is not same as chunk_sectors "
+			echo -n "at zone ${idx}. "
+			echo "size: ${len}, chunk_sectors: ${chunk_sectors}"
+			return 1
+		fi
+
+		# Check write pointer
+		if [[ ${wptr} -lt 0 || ${wptr} -gt ${len} ]]; then
+			echo -n "Write pointer is invalid at zone ${idx}. "
+			echo "wp:${wptr}"
+			return 1
+		fi
+
+		# Check zone condition
+		if [[ ! ${ZONE_COND_ARRAY[cond]} ]]; then
+			echo -n "Zone condition is incorrect at zone ${idx}. "
+			echo "condition: ${cond}"
+			return 1
+		fi
+
+		# Check zone type
+		if [[ ! ${ZONE_TYPE_ARRAY[zone_type]} ]]; then
+			echo -n "Zone type is incorrect at zone ${idx}. "
+			echo "type: ${zone_type}"
+			return 1
+		fi
+		cur_start=${next_start}
+	done
+	return 0
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	_check_blkzone_report || return $?
+	_put_blkzone_report
+	_put_sysfs_variable
+
+	echo "Test complete"
+}
diff --git a/tests/zbd/002.out b/tests/zbd/002.out
new file mode 100644
index 0000000..7317541
--- /dev/null
+++ b/tests/zbd/002.out
@@ -0,0 +1,2 @@
+Running zbd/002
+Test complete
-- 
2.20.1

