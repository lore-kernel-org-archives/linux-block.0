Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C1EC43444
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960CB2086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EEg+RK7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfARJpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8861 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfARJpp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804745; x=1579340745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZuAoGLlnQKEbYDiO6jPdNjX8klQL9nBbv/TjzQXA7Ec=;
  b=EEg+RK7M6GeTl3nXn5SR2oPy7BP5FX++VJx+Hf1ut5Lfrs6dQa4ktrMf
   5IjR8kuUb4FQz/DELEl1CjVGGgAiDcZ+gRC/ZUTAzYbWkuE/R8oaTPRwn
   Svk6EJRGjRmYCKkXrWF4hsQUYGMbYnvNDAnLizGRemJ5QwpaPB4i+mCSf
   juNtf8e8mPXfVr7ouycKj7iQY/UpRkonTv1rxhgcTJ/fXbNh5mWBmfd/T
   ronT+6DYwCronZoRHMrsIh2uVGE244xQjZOtZMZzTIcDp/QLuQggFfoAi
   iEvGZJf2srHLx5/ZxT9jftHYhgGulBgD7xdJ/QBARtjoXeIpBCyO2kjdf
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="99182327"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:38 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:55 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:34 -0800
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
Subject: [PATCH blktests v3 09/13] zbd/001: sysfs and ioctl consistency test
Date:   Fri, 18 Jan 2019 18:44:49 +0900
Message-Id: <20190118094453.13773-10-shinichiro.kawasaki@wdc.com>
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

