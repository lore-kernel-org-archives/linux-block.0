Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE253C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB4E20989
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZlMxAwzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfA1NPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:15:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60364 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfA1NPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548681335; x=1580217335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZuAoGLlnQKEbYDiO6jPdNjX8klQL9nBbv/TjzQXA7Ec=;
  b=ZlMxAwzguLwHPqhm0U/u/SKikh4vzAYYe8+TF+0oHxM+GBeFIM1R6JB/
   7wyYeLoqCKX/9WDPxNCcGGwXgmUZXYn+thLLlaK2LDM3uxRf4f0K50aSz
   e6EyDWYd3VS8hxOKhRyCyevRes0FQTrirLf9ZJyuxNQiaBvWV8NKLNtUf
   msm/XBLbwChpsRWwGeK0yagjFyXZppnDa7xibWaavD4BD8p7i3G61yx8U
   WbbJGuPDxAGj+02gPWlmrjx01A+0WHv6stP9UZg8KgrZv2G6zygaWUww0
   FEcKXlUaBhZjTEpgS6R/80odwQAqAobFagiLcGfY86m597jLJOVpffdFr
   w==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="204977751"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 21:15:35 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jan 2019 04:56:36 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2019 05:15:32 -0800
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
Subject: [PATCH blktests v4 08/12] zbd/001: sysfs and ioctl consistency test
Date:   Mon, 28 Jan 2019 22:14:51 +0900
Message-Id: <20190128131455.31997-9-shinichiro.kawasaki@wdc.com>
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

Obtain a zoned block device attributes from sysfs and using ioctl calls
and confirm the consistency of the values.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/001     | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/001.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/zbd/001
 create mode 100644 tests/zbd/001.out

diff --git a/tests/zbd/001 b/tests/zbd/001
new file mode 100755
index 0000000..ccb6e6c
--- /dev/null
+++ b/tests/zbd/001
@@ -0,0 +1,75 @@
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
+CAN_BE_ZONED=1
+
+requires() {
+	_have_src_program zbdioctl
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

