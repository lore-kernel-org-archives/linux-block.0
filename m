Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB8C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F36521773
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sv9CEZfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfBTIMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33059 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBTIMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550650371; x=1582186371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWNFwoC38kKh8fBjzt4rovi3POCToF+7xyOOkVr+9ro=;
  b=Sv9CEZfDx71qAcpKdLC1bVOErmcyOWJ2rg/KJk8ipQ2iW6UpNExw9ED6
   y+gwmzied//hdp8fZ9OvKPt6QVx34gDmPXxEoufnmPp++d/NtSCM2xUf1
   tMk0V4y5dHtJJJpyRYyxEyqKxvf9v0Kf/n+B6wIs7UYudTIMOYxjdzpDX
   Hn1Tj58hvv8zfr1AK7Xd2OhN3oI0QDGoJUV7/RaEo1en+WrUXMLtLzkv+
   rE3BdHbhZZoofemOGVhZh9gTJHgQttuWCotFVe4RkFF9d2FOeCE3OR8SN
   Xk3yVui6MkeAjWxCafl6yPdUiKdJO5xxzf9u03fY7TKDF+xtL+MVJfNi1
   g==;
X-IronPort-AV: E=Sophos;i="5.58,390,1544457600"; 
   d="scan'208";a="106682998"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 16:12:51 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 23:51:14 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2019 00:12:49 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 3/5] check: Add TEST_DEV_PART_SYSFS variable
Date:   Wed, 20 Feb 2019 17:12:29 +0900
Message-Id: <20190220081231.15366-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
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

Change _find_sysfs_dir() function to return the holder device sysfs as
well as the partition device sysfs. The function obtains the canonical
sysfs path, and if the device is a partition device, the function cut the
last device name in the canonical sysfs path to obtain the holder device
sysfs path.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 51 ++++++++++++++++++++++++++++++++++-----------------
 new   | 16 ++++++++++++++--
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/check b/check
index f41ecba..e45b34f 100755
--- a/check
+++ b/check
@@ -442,13 +442,19 @@ _run_test() {
 				_warning "$TEST_NAME: fallback_device call failure"
 				return 0
 			fi
-			if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
+
+			local dirs
+			local sysfs_dir
+			local part_sysfs_dir
+			if ! dirs=$(_find_sysfs_dir "$test_dev") ; then
 				_warning "$TEST_NAME: could not find sysfs directory for ${test_dev}"
 				cleanup_fallback_device
 				return 0
 			fi
+			read -r sysfs_dir part_sysfs_dir < <(echo "${dirs}")
 			TEST_DEVS=( "${test_dev}" )
 			TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
+			TEST_DEV_PART_SYSFS_DIRS["$test_dev"]="$part_sysfs_dir"
 			FALLBACK_DEVICE=1
 		fi
 
@@ -464,6 +470,7 @@ _run_test() {
 		local ret=0
 		for TEST_DEV in "${TEST_DEVS[@]}"; do
 			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
+			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
 			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
 				SKIP_REASON="${TEST_DEV} is a zoned block device"
 				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
@@ -483,6 +490,7 @@ _run_test() {
 		if (( FALLBACK_DEVICE )); then
 			cleanup_fallback_device
 			unset TEST_DEV_SYSFS_DIRS["${TEST_DEVS[0]}"]
+			unset TEST_DEV_PART_SYSFS_DIRS["${TEST_DEVS[0]}"]
 			TEST_DEVS=()
 		fi
 
@@ -507,6 +515,8 @@ _run_group() {
 		for i in "${!TEST_DEVS[@]}"; do
 			TEST_DEV="${TEST_DEVS[$i]}"
 			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
+			# shellcheck disable=SC2034
+			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
 			if ! group_device_requires; then
 				_output_notrun "${group}/*** => $(basename "$TEST_DEV")"
 				unset TEST_DEVS["$i"]
@@ -529,28 +539,31 @@ _run_group() {
 
 _find_sysfs_dir() {
 	local test_dev="$1"
+	local sysfs_path
 	local major=$((0x$(stat -L -c '%t' "$test_dev")))
 	local minor=$((0x$(stat -L -c '%T' "$test_dev")))
-	local dev="$major:$minor"
+	local sysdev_path="/sys/dev/block/${major}:${minor}"
 
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
+	if ! sysfs_path=/sys/dev/block/$(readlink "${sysdev_path}"); then
+		return 1
+	fi
 
-	return 1
+	if [[ -r "${sysfs_path}"/partition ]]; then
+		# If the device is a partition device, cut the last device name
+		# of the canonical sysfs path to access to the sysfs of its
+		# holder device.
+		#   e.g.   .../block/sda/sda1  ->  ...block/sda
+		# Return both the holder device sysfs path and the partition
+		# device sysfs path.
+		echo "${sysfs_path%/*}" "${sysfs_path}"
+	else
+		echo "${sysfs_path}" ""
+	fi
 }
 
 declare -A TEST_DEV_SYSFS_DIRS
+declare -A TEST_DEV_PART_SYSFS_DIRS
 _check() {
 	# shellcheck disable=SC2034
 	SRCDIR="$(realpath src)"
@@ -563,11 +576,15 @@ _check() {
 			_error "${test_dev} is not a block device"
 		fi
 
+		local dirs
 		local sysfs_dir
-		if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
+		local part_sysfs_dir
+		if ! dirs=$(_find_sysfs_dir "$test_dev") ; then
 			_error "could not find sysfs directory for ${test_dev}"
 		fi
+		read -r sysfs_dir part_sysfs_dir < <(echo "${dirs}")
 		TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
+		TEST_DEV_PART_SYSFS_DIRS["$test_dev"]="$part_sysfs_dir"
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

