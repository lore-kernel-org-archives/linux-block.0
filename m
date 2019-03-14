Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE6C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 03:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875102085A
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 03:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QLTlXFYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCNDqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:46:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42066 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfCNDqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 23:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552535195; x=1584071195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fx/JZGvqBH9j3drNPSTXJJvsYhr2et9dpOqKNUiex08=;
  b=QLTlXFYo82cQqW7xFTffS1PNvgosH3UEfneoP3QbHejO1umcQTc9ePuE
   lZQ0R5nJ3qXVsfljv9iYvj/tnND2gm6F6x+yQG8rpn/Etc8xfQAeDIKQ/
   WHhROodAnJnVMojolNMcxr46J/kPdqHHV28uSRZt7UIuqz3YUx3f4IX8d
   NTFEYTTekqPa8lXt6Qh5wngJjC5cdYRyL5DpjnArMBic3Ny2qOBETkDHF
   DOs4TM0m8smH5gNdIOBLbTsXYaEEDh4s3Dk5Zq5FO88No0DDiEa7Oa+Du
   2Vp6WlPrSR97CW1TysV06v519UeTOqwyTe541YiWjGlth4NFgj/4UjOsN
   A==;
X-IronPort-AV: E=Sophos;i="5.58,477,1544457600"; 
   d="scan'208";a="104729109"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2019 11:46:34 +0800
IronPort-SDR: aO5mtnEQ6PObTl2PlAMTBPgWCOOKYjykgnTlcd2WKy3qZMQjCTFpfdFCacUHK9ER9O6ZuWGIXB
 eM/sbNriNuuUN++vsgP5ktObiMNof7yFbpL2YuqMZnI9gp6QZ99kZFRCKo5NdFqQ1PKTOEyUYe
 2LxhajORrbRxHiy/zIHR5jNcG9w5r3xam7P1JaFpYcpdSpsb8V48cCT0AECN5ITIHFnqjYYJnt
 BCn8Escc7SIjGu749t6WVsz+BRcnuKBe9T1Zw1ZaN02TTULIRwLA1A/CzNcyggt96937rDILKy
 5tXFKk9SKRFlLQPhc+a6TkOK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 Mar 2019 20:24:21 -0700
IronPort-SDR: PVaD5Hky5YHLGoYXzYndATWd+Edi2Hajars+zwAnLmRUhk4BN/zfwSOWd1dJSO781uAuP6TLJI
 7CoLrY4en/gorprONHxuLVQhWQAo3kEDufpTsn/cSVfMV3jkShXKuQt1tZKQGjpnvoSzycstCx
 zhJKcdMgn04dY0sIgFbEM6+xg2I2Ykvpm0KavPSsfr+f4QbtTC93SVId/JoVL48w/XRnCB9yJJ
 X3KO5/qEipWu+GDLDKya9b+Ls1GmzRiTwbJUtUszTjEcfpur9+HXIwv/AnyKxCQqX3dO5qIpWv
 YQE=
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Mar 2019 20:46:33 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests] zbd/006: Test revalidate during other I/O requests
Date:   Thu, 14 Mar 2019 12:46:33 +0900
Message-Id: <20190314034633.13233-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since SCSI scanning occurs asynchronously, the kernel function
blk_revalidate_disk_zones() called from sd_revalidate_disk() may be
executed while write I/Os are ongoing. As a result,
blk_revalidate_disk_zones() must not cause write I/O errors by changing
zone related parameters of the device queue unless the disk has changed.
This patch allows checking this behavior and catch regressions such as
fixed by commit ccce20fc7968 ("scsi: sd_zbc: Avoid that resetting a zone
fails sporadically").

To trigger disk revalidate, fio is executed with the --loops option
causing the target device file to be closed and reopen at each loop. The
file close triggers disk revalidate and fio starts issuing I/Os before
revalidate completes, resulting in the desired simultaneous parallel
execution of write I/Os and blk_revalidate_disk_zones().

Also move the _find_first_sequential_zone() helper function from zbd/005
to zbd/rc and reuse it in the new test case for target zone selection.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/005     | 13 ------------
 tests/zbd/006     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/006.out |  2 ++
 tests/zbd/rc      | 13 ++++++++++++
 4 files changed, 67 insertions(+), 13 deletions(-)
 create mode 100644 tests/zbd/006
 create mode 100644 tests/zbd/006.out

diff --git a/tests/zbd/005 b/tests/zbd/005
index bc9cad5..65546a6 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -25,19 +25,6 @@ cleanup_fallback_device() {
 	_exit_null_blk
 }
 
-_find_first_sequential_zone() {
-	for ((idx =  NR_CONV_ZONES; idx < REPORTED_COUNT; idx++)); do
-		if [[ ${ZONE_TYPES[idx]} -eq ${ZONE_TYPE_SEQ_WRITE_REQUIRED} ]];
-		then
-			echo "${idx}"
-			return 0
-		fi
-	done
-	echo "Sequential write required zone not found"
-
-	return 1
-}
-
 test_device() {
 	local -i zone_idx
 	local -i offset
diff --git a/tests/zbd/006 b/tests/zbd/006
new file mode 100644
index 0000000..b745acd
--- /dev/null
+++ b/tests/zbd/006
@@ -0,0 +1,52 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Western Digital Corporation or its affiliates.
+#
+# Run fio write job with loops option to cause file close and scsi disk
+# zone revalidate in parallel with write requests.
+
+. tests/zbd/rc
+
+DESCRIPTION="revalidate"
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
+test_device() {
+	local -i zone_idx
+	local -i offset
+	local -i size
+
+	echo "Running ${TEST_NAME}"
+
+	_get_blkzone_report "${TEST_DEV}" || return $?
+
+	zone_idx=$(_find_first_sequential_zone) || return $?
+	offset=$((ZONE_STARTS[zone_idx] * 512))
+	size=$((ZONE_LENGTHS[zone_idx] * 512))
+
+	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
+
+	_test_dev_queue_set scheduler deadline
+
+	: "${TIMEOUT:=30}"
+	FIO_PERF_FIELDS=("write io" "write iops")
+	_fio_perf --filename="${TEST_DEV}" --name zbdwo --rw=randwrite \
+		  --zonemode=zbd --direct=1 --ioengine=libaio --iodepth=8 \
+		  --bs=4k --offset="${offset}" --size="${size}" --loops=8
+
+	_put_blkzone_report
+
+	echo "Test complete"
+}
diff --git a/tests/zbd/006.out b/tests/zbd/006.out
new file mode 100644
index 0000000..ee844f7
--- /dev/null
+++ b/tests/zbd/006.out
@@ -0,0 +1,2 @@
+Running zbd/006
+Test complete
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 88538d0..5f04c84 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -180,6 +180,19 @@ _reset_zones() {
 	fi
 }
 
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
 # Search zones and find two contiguous sequential required zones.
 # Return index of the first zone of the found two zones.
 # Call _get_blkzone_report() beforehand.
-- 
2.20.1

