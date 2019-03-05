Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF9C00319
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF1C20684
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LP6tPRWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfCEFYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:24:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55132 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfCEFYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 00:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551763490; x=1583299490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0OzuGjmy4M/BE9rqf4rRfbTao6WJTH/dhiea2ZR5yo=;
  b=LP6tPRWHjDoYKF7TxD29jwJ8yc7ChJubNWJwL+EENGHS4YkdFf70dLVK
   OVBk54N+hdPtUuyKfQT2qTdClxvQ6rqUPTduP+Xc+DpvKG6sJVljbZZA3
   ai4Kfr90pQ/MDKxU8+SrI/12Xy08eUHyHWPWFGdCYdhotKET/ZMMPaQt8
   fr68kx5p5x7e8kz0aew9457CmLXxcDfqhywkfjEGhglyntSUEvOk26Yzj
   8y9s72pcsIgQw8RrsHaXt0bGs4/NFBAarcFDkBNO1iFRYB5VVUrKk6VuI
   ukqwWXftAT/61OSueNp+G+Gui1F/Wq7PPfQHUogYHzS643iebx4junMrK
   w==;
X-IronPort-AV: E=Sophos;i="5.58,442,1544457600"; 
   d="scan'208";a="107735604"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2019 13:24:50 +0800
IronPort-SDR: yEj+nNpwmD5LbuKQmMwGTArZXnOShSPbJn10frzNWfg9wCJxhAinvDjt2Kg4y4f7UyRQy+egPn
 DvnYxbRRzdxFX9lNpjab0SinOaxJFk7Uk3W7KY74/UIn90WcqjCzd4ebXnLI7BAv01hdV/VbZ4
 w3P3UVbruFeGl68MO2z6qmTzM72ZtBbBSngmD4CCoqAOly3Y6gyKor3hmGPmDPz7ke4ClL4GVw
 ueXrjPVMOxitTBW8f2Wx5Gi1sRcuxbvaV+3MdcpPA9HaP1Pt37FXt47t1V50fOR6r6pDD0ss2K
 MHksDqi90ZgGrhEfV3jgng+g
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 04 Mar 2019 21:04:54 -0800
IronPort-SDR: +nVMYLJalwuHScyHdkc7Yc3t3QWgJC9Sb4ER6JirN4CCY6mNkDDv79ctXuzK+DWnEGZ/Hukh1A
 /+OO/A7s/BrNie0jKH7Qkx2/SUNELHA/NwFpokcEqDoYMYbDB0h+lzsYufuDrBR+WtqvLLFPTg
 PKjNxieQdvPuriUxD5dgu0Tk8HpdT4F0iukK/KjQSwUXiDeftpWw0Ij0NUqADQP6nqTRFw8dFJ
 Je5730vtYsNvu4Cq45Qfkds/CX10hNtUoiHYY55J8wUxNKsgvPZ3duwyTfZqVUHtgTkih5bfRQ
 GAE=
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2019 21:24:49 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 1/3] check: Add TEST_DEV_PART_SYSFS variable
Date:   Tue,  5 Mar 2019 14:24:45 +0900
Message-Id: <20190305052447.24291-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
References: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When partition devices are specified in TEST_DEV, TEST_DEV_SYSFS
variable points to the sysfs paths of holder devices of the partition
devices (e.g., /sys/block/sda). This sysfs path is different from the
sysfs path of the partition devices (e.g., /sys/block/sda/sda1). For
example, size parameters exist in both the holder device sysfs and
the partition device sysfs with different values.

To allow test cases to access sysfs path of the partition devices,
add TEST_DEV_PART_SYSFS variable. TEST_DEV_SYSFS is set as is to refer
the sysfs path of the holder devices. If the TEST_DEV is not a partition
device, an empty string is set to the TEST_DEV_PART_SYSFS variable.

Rename _find_sysfs_dir() function to _find_sysfs_dirs() and make it find
holder device sysfs as well as the partition device sysfs. The function
obtains the canonical sysfs path, and if the device is a partition
device, the function cuts the last device name in the canonical sysfs
path to obtain the holder device sysfs path.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 46 +++++++++++++++++++++++++---------------------
 new   | 16 ++++++++++++++--
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/check b/check
index 819d8f3..6d44bfb 100755
--- a/check
+++ b/check
@@ -443,13 +443,13 @@ _run_test() {
 				_warning "$TEST_NAME: fallback_device call failure"
 				return 0
 			fi
-			if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
+
+			if ! _find_sysfs_dirs "$test_dev"; then
 				_warning "$TEST_NAME: could not find sysfs directory for ${test_dev}"
 				cleanup_fallback_device
 				return 0
 			fi
 			TEST_DEVS=( "${test_dev}" )
-			TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
 			FALLBACK_DEVICE=1
 		fi
 
@@ -465,6 +465,7 @@ _run_test() {
 		local ret=0
 		for TEST_DEV in "${TEST_DEVS[@]}"; do
 			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
+			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
 			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
 				SKIP_REASON="${TEST_DEV} is a zoned block device"
 				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
@@ -484,6 +485,7 @@ _run_test() {
 		if (( FALLBACK_DEVICE )); then
 			cleanup_fallback_device
 			unset TEST_DEV_SYSFS_DIRS["${TEST_DEVS[0]}"]
+			unset TEST_DEV_PART_SYSFS_DIRS["${TEST_DEVS[0]}"]
 			TEST_DEVS=()
 		fi
 
@@ -508,6 +510,8 @@ _run_group() {
 		for i in "${!TEST_DEVS[@]}"; do
 			TEST_DEV="${TEST_DEVS[$i]}"
 			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
+			# shellcheck disable=SC2034
+			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
 			if ! group_device_requires; then
 				_output_notrun "${group}/*** => $(basename "$TEST_DEV")"
 				unset TEST_DEVS["$i"]
@@ -528,30 +532,32 @@ _run_group() {
 	return $ret
 }
 
-_find_sysfs_dir() {
+_find_sysfs_dirs() {
 	local test_dev="$1"
+	local sysfs_path
 	local major=$((0x$(stat -L -c '%t' "$test_dev")))
 	local minor=$((0x$(stat -L -c '%T' "$test_dev")))
-	local dev="$major:$minor"
 
-	local block_dir part_dir
-	for block_dir in /sys/block/*; do
-		if [[ $(cat "${block_dir}/dev") = "$dev" ]]; then
-			echo "$block_dir"
-			return
-		fi
-		for part_dir in "$block_dir"/*; do
-			if [[ -r ${part_dir}/dev && $(cat "${part_dir}/dev") = "$dev" ]]; then
-				echo "$block_dir"
-				return
-			fi
-		done
-	done
+	# Get the canonical sysfs path
+	if ! sysfs_path="$(realpath "/sys/dev/block/${major}:${minor}")"; then
+		return 1
+	fi
 
-	return 1
+	if [[ -r "${sysfs_path}"/partition ]]; then
+		# If the device is a partition device, cut the last device name
+		# of the canonical sysfs path to access to the sysfs of its
+		# holder device.
+		#   e.g.   .../block/sda/sda1  ->  ...block/sda
+		TEST_DEV_SYSFS_DIRS["$test_dev"]="${sysfs_path%/*}"
+		TEST_DEV_PART_SYSFS_DIRS["$test_dev"]="${sysfs_path}"
+	else
+		TEST_DEV_SYSFS_DIRS["$test_dev"]="${sysfs_path}"
+		TEST_DEV_PART_SYSFS_DIRS["$test_dev"]=""
+	fi
 }
 
 declare -A TEST_DEV_SYSFS_DIRS
+declare -A TEST_DEV_PART_SYSFS_DIRS
 _check() {
 	# shellcheck disable=SC2034
 	SRCDIR="$(realpath src)"
@@ -564,11 +570,9 @@ _check() {
 			_error "${test_dev} is not a block device"
 		fi
 
-		local sysfs_dir
-		if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
+		if ! _find_sysfs_dirs "$test_dev"; then
 			_error "could not find sysfs directory for ${test_dev}"
 		fi
-		TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
 	done
 
 	local test_name group prev_group
diff --git a/new b/new
index d7d5f7c..24c066d 100755
--- a/new
+++ b/new
@@ -80,7 +80,10 @@ group_requires() {
 # should return non-zero and set the \$SKIP_REASON variable. \$TEST_DEV is the
 # full path of the block device (e.g., /dev/nvme0n1 or /dev/sda1), and
 # \$TEST_DEV_SYSFS is the sysfs path of the disk (not the partition, e.g.,
-# /sys/block/nvme0n1 or /sys/block/sda).
+# /sys/block/nvme0n1 or /sys/block/sda). If the target device is a partition
+# device, \$TEST_DEV_PART_SYSFS is the sysfs path of the partition device
+# (e.g., /sys/block/nvme0n1/nvme0n1p1 or /sys/block/sda/sda1). Otherwise,
+# \$TEST_DEV_PART_SYSFS is an empty string.
 #
 # Usually, group_device_requires() just needs to check that the test device is
 # the right type of hardware or supports any necessary features using the
@@ -165,7 +168,10 @@ DESCRIPTION=""
 # set the \$SKIP_REASON variable. \$TEST_DEV is the full path of the block
 # device (e.g., /dev/nvme0n1 or /dev/sda1), and \$TEST_DEV_SYSFS is the sysfs
 # path of the disk (not the partition, e.g., /sys/block/nvme0n1 or
-# /sys/block/sda).
+# /sys/block/sda). If the target device is a partition device,
+# \$TEST_DEV_PART_SYSFS is the sysfs path of the partition device (e.g.,
+# /sys/block/nvme0n1/nvme0n1p1 or /sys/block/sda/sda1). Otherwise,
+# \$TEST_DEV_PART_SYSFS is an empty string.
 #
 # Usually, device_requires() just needs to check that the test device is the
 # right type of hardware or supports any necessary features using the
@@ -207,6 +213,12 @@ DESCRIPTION=""
 #    - \$TEST_DEV_SYSFS -- the sysfs directory of the device (e.g.,
 #                         /sys/block/sda). In general, you should use the
 #                         _test_dev_queue_{get,set} helpers.
+#                         If the device is a partition device, the sysfs
+#                         directory of its holder device is set.
+#    - \$TEST_DEV_PART_SYSFS -- the sysfs directory of the device if the device
+#                               is a partition device (e.g.,
+#                               /sys/block/sda/sda1). Empty string is set if
+#                               the device is not a partition device.
 test() {
 	echo "Running \${TEST_NAME}"
 
-- 
2.20.1

