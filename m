Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94AFC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9075D214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mzecDYNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfAJJio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:38:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16282 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfAJJio (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113124; x=1578649124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KttUW25DXSCzueklgKuVjkva9JoW+uEw7MOvlYCeB/E=;
  b=mzecDYNJSQ9mLdiG4obkcLfAvZP2QLxlfQCcdY4Zq1qj79OLWV0Lo9rf
   8rUVIsz0zHpPUispUMDOJ2G+0zeCXemXFQFdbJPnm5jxwOSFDQQfkURem
   ioHA5XnGR9D+jAQEu4yXqq8PVNUoy9aN0Ez9gnmHXALEyzItoC36ERFdq
   DQNdFr1IthPKWpd3to8j4wmxOOJLVvxC1MFd+KQr7BGo0v7+B2Z5Yb6uk
   /Lpf7n7/1i8HxwP/F9w+07yNvGXkXlANKgiAi+v2E1tWe3FvPx5xf+hIu
   M4NikHPxl5nJ3HS/B58bAFbzt+lm0HxVumXbQhIuaZf/e5H78dLvO0REe
   w==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="100223386"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:44 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:20:14 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:38:40 -0800
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
Subject: [PATCH blktests v2 16/16] zbd/005: Test write ordering
Date:   Thu, 10 Jan 2019 18:37:25 +0900
Message-Id: <20190110093725.32675-17-shinichiro.kawasaki@wdc.com>
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

Run a high queue depth direct sequential write fio job to check that
write requests are not being reordered when the deadline scheduler is
used. This test allowed to catch a bug fixed with commit
80e02039721 "block: mq-deadline: Fix write completion handling".

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/005     | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/005.out |  2 ++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/zbd/005
 create mode 100644 tests/zbd/005.out

diff --git a/tests/zbd/005 b/tests/zbd/005
new file mode 100755
index 0000000..5286a6d
--- /dev/null
+++ b/tests/zbd/005
@@ -0,0 +1,59 @@
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
+
+requires() {
+	_have_fio_zbd_zonemode
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
+	set_scheduler "$(basename "$(readlink -f "${TEST_DEV}")")" \
+		      deadline || return $?
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

