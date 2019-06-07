Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7262C2BCA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A1920665
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ocn3pMvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfFGMUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:20:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58140 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfFGMUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 08:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559909999; x=1591445999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jl3jF4cmoEXxvz+We2qB17Aud3EARTFqMSqejXZ+lyE=;
  b=ocn3pMvsjiqRpPBws54SZKXr/T4+Ne1pcMmPds1tOlbhhDaYFtdkYyFo
   w89mliqfGGRGCwI/9MOXeqgcgXXolnt+xKx0JKt7VLsGY2xdbQ7bU0WGh
   OPdB/2HatpeOYqGZ2nH5bUzI2E22CtZETvPRl3vC1ViD72NqK8Pu/FaQg
   JXTLxzj2VANVAtNgyNYEz78ODi2k+6uL6edZI3RdsIOCYGqxqz/SikcsM
   ozRKZvfx6Dnl+kp/4qYCrqznDgexKDFrJ49QlEu9VxKCH0GDEsoklDMZa
   m66BdDlzMU3tgCyb47pro5vBniqsh/4aWxYBYffBqr2ZceROpLKmQos26
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="216339838"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 20:19:59 +0800
IronPort-SDR: 5MeQ14V2wjvaYsp4d9CTW/2hWOS1KCicIWmbklQzpFiwp8vwltnLMX37Rs/OIyMYfV2r/gwDaZ
 xmx73P0ExNhpFI/1c9k4czPOnF69nIllNzeNbDFMTD8OWxM7MjkhbStqrRCQsPvZdbz1faDlC+
 TuZ+obxUXWAcSjuSysh1LdppsphfjQKZ0dNGjDfW5gjxCrhsKIn8OvDwLODo/G63cYZ0D52jBs
 xg6foERGSgkjVBMcp9qu1U1nVjRpmLf9ilmijmLgKsUGB/spC4pegjrU15fqLjiKcceJJDQ9pa
 imoeYIRgUGRBrMltSR+x0VxE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 04:54:52 -0700
IronPort-SDR: P7WWzILgIVcNYQSvu23+kZtPZFUdhffHTaX3zPIJL7GCAM4gpHp3UwJKZQVSuzWuJPV43+QX0n
 iNCYkGgadc7FXq7kJN1UF6fqKWMtFs8NV02sN+mToqYRlItQ3na8Tf+uXy5PaqtdZGPfiP3Ett
 60c2EWl1oFvAXeRGzrcEaxTES2KmqCCzpXUn5ZPoMb5cQZ5wL/Cctx4Z5D06Svag8XkSe48izb
 LUOtnMXKpUsT53t1+cOdI1L2Gf2mAZg1gqFmMn6u3gZXXe36jfVGc9Dzha31F4JK0dp/VtFrrl
 lmE=
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 05:19:59 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v3 2/2] zbd/007: Add zone mapping test for logical devices
Date:   Fri,  7 Jun 2019 21:19:55 +0900
Message-Id: <20190607121955.9368-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607121955.9368-1-shinichiro.kawasaki@wdc.com>
References: <20190607121955.9368-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the test case to check zones sector mapping of logical devices
This test case requires that such a logical device be specified in
TEST_DEVS in config. The test is skipped for devices that are identified
as not logically created. This test case catches regressions of complex
zone remapping problem fixed by commit 9864cd5dc54c "dm: fix report zone
remapping to account for partition offset".

To test that the zone mapping is correct, select a few sequential write
required zones of the logical device and move the write pointers of
these zones through the container device of the logical device, using
the physical sector mapping of the zones. The write pointers position of
the selected zones is then checked through a zone report of the logical
device using the logical sector mapping of the zones. The test reports a
success if the position of the zone write pointers relative to the zone
start sector must be identical for both the logical and physical
locations of the zones.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/007     | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/007.out |   2 +
 2 files changed, 112 insertions(+)
 create mode 100755 tests/zbd/007
 create mode 100644 tests/zbd/007.out

diff --git a/tests/zbd/007 b/tests/zbd/007
new file mode 100755
index 0000000..b4dcbd8
--- /dev/null
+++ b/tests/zbd/007
@@ -0,0 +1,110 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Western Digital Corporation or its affiliates.
+#
+# Test zones are mapped correctly between a logical device and its container
+# device. Move write pointers of sequential write required zones on the
+# container devices, and confirm same write pointer positions of zones on the
+# logical devices.
+
+. tests/zbd/rc
+
+DESCRIPTION="zone mapping between logical and container devices"
+CAN_BE_ZONED=1
+QUICK=1
+
+requires() {
+	_have_program dmsetup
+}
+
+device_requires() {
+	_test_dev_is_logical
+}
+
+# Select test target zones. Pick up the first sequential required zones. If
+# available, add one or two more sequential required zones. One is at the last
+# end of TEST_DEV. The other is in middle between the first and the last zones.
+select_zones() {
+	local -i zone_idx
+	local -a zones
+
+	zone_idx=$(_find_first_sequential_zone) || return $?
+	zones=( "${zone_idx}" )
+	if zone_idx=$(_find_last_sequential_zone); then
+		zones+=( "${zone_idx}" )
+		if zone_idx=$(_find_sequential_zone_in_middle \
+				      "${zones[0]}" "${zones[1]}"); then
+			zones+=( "${zone_idx}" )
+		fi
+	fi
+	echo "${zones[@]}"
+}
+
+test_device() {
+	local -i bs
+	local -a test_z # test target zones
+	local -a test_z_start
+
+	echo "Running ${TEST_NAME}"
+
+	# Get physical block size to meet zoned block device I/O requirement
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	bs=${SYSFS_VARS[SV_PHYS_BLK_SIZE]}
+	_put_sysfs_variable
+
+	# Get test target zones
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	read -r -a test_z < <(select_zones)
+	for ((i = 0; i < ${#test_z[@]}; i++)); do
+		test_z_start+=("${ZONE_STARTS[test_z[i]]}")
+	done
+	echo "${test_z[*]}" >> "$FULL"
+	echo "${test_z_start[*]}" >> "$FULL"
+	_put_blkzone_report
+	if ((!${#test_z[@]})); then
+		echo "Test target zones not available on ${TEST_DEV}"
+		return 1
+	fi
+
+	# Reset and move write pointers of the container device
+	for ((i=0; i < ${#test_z[@]}; i++)); do
+		local -a arr
+
+		read -r -a arr < <(_get_dev_container_and_sector \
+					   "${test_z_start[i]}")
+		container_dev="${arr[0]}"
+		container_start="${arr[1]}"
+
+		echo "${container_dev}" "${container_start}" >> "$FULL"
+
+		if ! blkzone reset -o "${container_start}" -c 1 \
+		     "${container_dev}"; then
+			echo "Reset zone failed"
+			return 1
+		fi
+
+		if ! dd if=/dev/zero of="${container_dev}" bs="${bs}" \
+		     count=$((4096 * (i + 1) / bs)) oflag=direct \
+		     seek=$((container_start * 512 / bs)) \
+		     >> "$FULL" 2>&1 ; then
+			echo "dd failed"
+		fi
+
+		# Wait for partition table re-read event settles
+		udevadm settle
+	done
+
+	# Check write pointer positions on the logical device
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	for ((i=0; i < ${#test_z[@]}; i++)); do
+		if ((ZONE_WPTRS[test_z[i]] != 8 * (i + 1))); then
+			echo "Unexpected write pointer position"
+			echo -n "zone=${i}, wp=${ZONE_WPTRS[i]}, "
+			echo "dev=${TEST_DEV}"
+		fi
+		echo "${ZONE_WPTRS[${test_z[i]}]}" >> "$FULL"
+	done
+	_put_blkzone_report
+
+	echo "Test complete"
+}
diff --git a/tests/zbd/007.out b/tests/zbd/007.out
new file mode 100644
index 0000000..28a1395
--- /dev/null
+++ b/tests/zbd/007.out
@@ -0,0 +1,2 @@
+Running zbd/007
+Test complete
-- 
2.21.0

