Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDAC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E97A20821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ilkCk2Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfAIBgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAIBgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997807; x=1578533807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZuSunFMndezuJc8EhPriCjh5uaG5NjhCSc/h0xqEXE=;
  b=ilkCk2TsN0LK29JFtbjg/WBErE1FWbNmhYwPzP1aLrObfN0GIiObWxxf
   1oWIhdpKBvbwvQeJbt6z2Ya1xTUQCTVSX9kVceQKdrW/w1EN7w8i/rR3S
   S7IBw4r7twUgpafAKp1RIIqDgymvDQXTyDWwTTlW9SrBLEDEOBHexo0KN
   3tjE5qeOYTFXeLf0G/OyveJtOAQDjDnapVGlAb9zpHR8wmzSjES9rx+8/
   CW1dIeuRgUzaYaBX6DFgo5ss4hkHZ2W0fbm6RC3YF4HWRqLzYDgr5ME+v
   6pJpoSxCTNU5q4Rndb5sQkQmnQqkTEPSUqkMlvsp/GCYoEJ7L68rJvQ4v
   g==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169221"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:47 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:48 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:44 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 14/14] zbd/005: Test write ordering
Date:   Wed,  9 Jan 2019 10:35:42 +0900
Message-Id: <20190109013542.23686-15-damien.lemoal@wdc.com>
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

Run a high queue depth direct sequential write fio job to check that
write requests are not being reordered when the deadline scheduler is
used. This test allowed to catch a bug fixed with commit
80e02039721 "block: mq-deadline: Fix write completion handling".

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/005     | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/005.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/zbd/005
 create mode 100644 tests/zbd/005.out

diff --git a/tests/zbd/005 b/tests/zbd/005
new file mode 100755
index 0000000..7b38462
--- /dev/null
+++ b/tests/zbd/005
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Test zoned block device write ordering. Run simultaneous write operations
+# to a single zone and confirm no write ordering failure.
+# It checks fix by commit 80e02039721 ("block: mq-deadline: Fix write
+# completion handling").
+
+. tests/zbd/rc
+
+DESCRIPTION="write command ordering"
+TIMED=1
+
+requires() {
+	_have_fio
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
+	: "${TIMEOUT:=30}"
+	set_scheduler "$(basename "$(readlink -f "${TEST_DEV}")")" deadline
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

