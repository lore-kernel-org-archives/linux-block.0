Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07EFC43444
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB50F2087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aYizh53U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfARJpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8872 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfARJpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804754; x=1579340754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HhLivrf1ZOQNPDV2UpJ0kdP7WmFbE6YMCJKyYi+AggQ=;
  b=aYizh53U0FFv/FdxWNXSiujKhLHsqLNWfOESIcPphQ9NL/mhBI1HndCD
   8XXars++MQS76I6m747l2MOg2QoA83jsxW9eBvDnZuN00vLWXlE5lKsT0
   9d8hPrSEd0h7fEtBN5n7QVcFlz++pEFox3SDpxvU0IGClb5Yu1BqitVFl
   t9n0aTp6K57XbZwBXmM+Bwxrgf4BP8kMro62nCpjAcMCnc1pvOmYmtGJ3
   nHhX8264qsZhKcmrtH9HoeGRsBpmzfMLf64+oOF9qhMSJ9Wh1x3d3rc9+
   53Xa23qx68go8YR+PUb7b8Ngda6Tmr8Bv0XI9P1tmAVQY86WEi8dU18PT
   A==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="99182391"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:54 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:27:12 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:50 -0800
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
Subject: [PATCH blktests v3 13/13] zbd/005: Test write ordering
Date:   Fri, 18 Jan 2019 18:44:53 +0900
Message-Id: <20190118094453.13773-14-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Masato Suzuki <masato.suzuki@wdc.com>

Run a high queue depth direct sequential write fio job to check that
write requests are not being reordered when the deadline scheduler is
used. This test allowed to catch a bug fixed with commit
80e02039721 "block: mq-deadline: Fix write completion handling".

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/005     | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/005.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/zbd/005
 create mode 100644 tests/zbd/005.out

diff --git a/tests/zbd/005 b/tests/zbd/005
new file mode 100755
index 0000000..bc9cad5
--- /dev/null
+++ b/tests/zbd/005
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Run a high queue depth direct sequential write fio job to check that
+# write requests are not being reordered when the deadline scheduler is
+# used. This test allowed to catch a bug fixed with commit 80e02039721
+# "block: mq-deadline: Fix write completion handling".
+
+. tests/zbd/rc
+
+DESCRIPTION="write command ordering"
+TIMED=1
+CAN_BE_ZONED=1
+
+requires() {
+	_have_fio_zbd_zonemode
+}
+
+fallback_device() {
+	_fallback_null_blk_zoned
+}
+
+cleanup_fallback_device() {
+	_exit_null_blk
+}
+
+_find_first_sequential_zone() {
+	for ((idx =  NR_CONV_ZONES; idx < REPORTED_COUNT; idx++)); do
+		if [[ ${ZONE_TYPES[idx]} -eq ${ZONE_TYPE_SEQ_WRITE_REQUIRED} ]];
+		then
+			echo "${idx}"
+			return 0
+		fi
+	done
+	echo "Sequential write required zone not found"
+
+	return 1
+}
+
+test_device() {
+	local -i zone_idx
+	local -i offset
+
+	echo "Running ${TEST_NAME}"
+
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	_get_blkzone_report "${TEST_DEV}" || return $?
+
+	zone_idx=$(_find_first_sequential_zone) || return $?
+	offset=$((ZONE_STARTS[zone_idx] * 512))
+
+	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
+
+	_test_dev_queue_set scheduler deadline
+
+	: "${TIMEOUT:=30}"
+	FIO_PERF_FIELDS=("write io" "write iops")
+	_fio_perf --filename="${TEST_DEV}" --name zbdwo --rw=write --direct=1 \
+		  --ioengine=libaio --iodepth=128 --bs=256k \
+		  --offset="${offset}"
+
+	_put_blkzone_report
+	_put_sysfs_variable
+
+	echo "Test complete"
+}
diff --git a/tests/zbd/005.out b/tests/zbd/005.out
new file mode 100644
index 0000000..3ff78c6
--- /dev/null
+++ b/tests/zbd/005.out
@@ -0,0 +1,2 @@
+Running zbd/005
+Test complete
-- 
2.20.1

