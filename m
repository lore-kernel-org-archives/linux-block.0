Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A86C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1454C20821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nm6Zt2qK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfAIBgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAIBgd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997793; x=1578533793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHNEgPsvje071JZF8Ps1r1fXJmKXODgGJh7ZfxsTKDc=;
  b=Nm6Zt2qKJ5lvkY/zF2dKnkhA/q/Wypzh3dRpLmnU6WwQi1nTVP7Fs+WP
   9sHZcGFI7Dq6PsJ6wBBH9miUOhjqWShf+eFmNtSWLyMWwMglV/ikLITA+
   SKME3Z9OeexkQPY51ECkU0O73XSx/3IF4hsLHHLWuIaGfDy0dNh96X5Dp
   crWrODdcUzD47lXqSCDLsrjpQINgXXo699BFjMIrCZxqykKMvTvuqMfGN
   +PT+3D55KoI9lNub03w75l6pKba2prcoYsnohzA3MRrNO8K7ULCf3ZNUM
   qfksy6iG2GjE6ZVhrPS9aJaTDs9f6wgbv0AEl+RD1ga1btg2+m5Iq1Q7m
   A==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169209"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:33 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:34 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:30 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 10/14] zbd/001: sysfs and ioctl consistency test
Date:   Wed,  9 Jan 2019 10:35:38 +0900
Message-Id: <20190109013542.23686-11-damien.lemoal@wdc.com>
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

Obtain a zoned block device attributes from sysfs and using ioctl calls
and confirm the consistency of the values.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/001     | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/001.out |  2 ++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/zbd/001
 create mode 100644 tests/zbd/001.out

diff --git a/tests/zbd/001 b/tests/zbd/001
new file mode 100755
index 0000000..7f16c9a
--- /dev/null
+++ b/tests/zbd/001
@@ -0,0 +1,66 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Check zoned block device sysfs and ioctl parameter availability and
+# confirm consistency among them.
+
+. tests/zbd/rc
+
+DESCRIPTION="sysfs and ioctl"
+QUICK=1
+
+requires() {
+	_have_src_program zbdioctl
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	# Get and keep sysfs variables
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	local -i capacity=${SYSFS_VARS[$SV_CAPACITY]}
+	local -i chunk_sectors=${SYSFS_VARS[$SV_CHUNK_SECTORS]}
+
+	# Calculate expected number of zones based on the total capacity and
+	# zone size, taking into account that the last zone can be smaller
+	# than other zones.
+	local -i nr_zones=$(( (capacity - 1) / chunk_sectors + 1 ))
+
+	# Compare sysfs values and ioctl values
+	if [[ -e "${TEST_DEV_SYSFS}"/queue/nr_zones ]]; then
+		local -i sysfs_nr_zones=${SYSFS_VARS[$SV_NR_ZONES]}
+		local -i ioctl_nr_zones
+		local -i ioctl_zonesize
+
+		ioctl_zonesize=$(src/zbdioctl -s "${TEST_DEV}")
+		if [[ ${chunk_sectors} -ne ${ioctl_zonesize} ]]; then
+			echo -n "ioctl zone size:${ioctl_zonesize} != "
+			echo "sysfs chunk_sectors:${chunk_sectors}"
+			return 1
+		fi
+
+		ioctl_nr_zones=$(src/zbdioctl -n "${TEST_DEV}")
+		if [[ ${nr_zones} -ne ${ioctl_nr_zones} ]]; then
+			echo -n "ioctl nr_zones:${ioctl_nr_zones} != "
+			echo "nr_zones:${nr_zones}"
+			return 1
+		fi
+
+		if [[ ${nr_zones} -ne ${sysfs_nr_zones} ]]; then
+			echo -n "sysfs nr_zones:${sysfs_nr_zones} != "
+			echo "nr_zones:${nr_zones}"
+			return 1
+		fi
+	fi
+
+	_put_sysfs_variable
+	{
+		echo "Capacity: ${capacity} sectors"
+		echo "Zone: ${chunk_sectors} sectors"
+		echo "Number of zones: ${nr_zones} zones"
+	} >> "$FULL" 2>&1
+
+	echo "Test complete"
+}
+
diff --git a/tests/zbd/001.out b/tests/zbd/001.out
new file mode 100644
index 0000000..7d72a8f
--- /dev/null
+++ b/tests/zbd/001.out
@@ -0,0 +1,2 @@
+Running zbd/001
+Test complete
-- 
2.20.1

