Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CD8C04A6B
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 02:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E05208E3
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 02:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fp2l5TVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfEMCDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 May 2019 22:03:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49921 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCDp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 May 2019 22:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557713024; x=1589249024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ra4lsAlS/8HyxXCg4O96j1dhmWUmFggByBVdZq8ZDMY=;
  b=Fp2l5TVfAmFAAqMW2XVjSFeK9WCxymHGQ91eJ28r7NYt8/LYPyud8Uj0
   w1Zm15SVjVRUnENS+UiEOBdI/NK2slg6tSQo9rw2wnAj2PSUxSfI6tCiJ
   Wfm20tVmBHzp4YldDW3xq0rFEjJJNzR3jqSoz3RbAd9PZ6buUdjs1UfVt
   DSs4gyNLZ6ZnXoevVjmUwKs5BlKHw2ETq6rdn0O5QyecSOxUd5lPcsgvM
   /7p5n1nEKeqvcsir7xbedHvPUz4hVM3raVrh2poRmVPW1j8EkgvFM74eA
   9r5wJfaeZqVLqUPWGHAyJ6d3s/h9ez5YOaf6c9NSeq6uE0sqOIYd5e7Q1
   A==;
X-IronPort-AV: E=Sophos;i="5.60,464,1549900800"; 
   d="scan'208";a="214164148"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 10:03:44 +0800
IronPort-SDR: J2Q3Wds7PrE2n3J2d99bEpDgcOXKQ+rOqcDUG2BssOfGGdVmjkeG301/qwp+8rX1QWLOLIBbiY
 QF+dBtOiXjgcg3Uo/ojx8J2MTasShphDK3QKX+yCypAIv95FxjgJLzjEj1/qwaJEIFUOgd//e4
 +fIucSorvvQUXKBZ93AZroziX4EkcWIgVcTf+tStzzD98c4FBqoqUWydmf3QIskYgIHBtiMXE7
 RXtASJMKLZCYtlWHhnOrynuwfARpQPX1+OQlAy7u46Jp4l74lMsI3PEdj8El52Jp0Rx5BxOx0r
 ahmXj3BcrVITzTCZjOgHAFvv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 May 2019 18:41:47 -0700
IronPort-SDR: 1jd7Ih6OjOyly+pvcgoAfUVLjdfzqVXO8zpZ01QgkL18lORiq6SR29K07KQYTvxs1mKjkUSZhu
 A+xC+IfzIXpDghv6uoh7e0QZBARs+VbcCsd7Uu0ohhvFiPYMu1kX0iSOLb/JQc/DhBAafiOY3Z
 Gh3x8VCdKVxpF7+Wj5C5q/4L9eZlcIKSPeLJyZPRXyKQ29MQaqJe8BgCeMMToisQBgXPtIsAIF
 59Nwf/CByMgC7lIqB6mjwbr6LgfJ2Vk5+FVyXLnGhgO68rsru2Ut6CCt5u7LFF44KyRvRP/Y29
 lWE=
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2019 19:03:42 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests] zbd/007: Test zone mapping of logical devices
Date:   Mon, 13 May 2019 11:03:41 +0900
Message-Id: <20190513020341.2254-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check that zones sector mapping is correct for zoned block devices that
are not an entire full device (null_block device or physical device).
These logical devices are for now partition devices or device-mapper
devices (dm-linear or dm-flakey). This test case requires that such a
logical device be specified in TEST_DEVS in config. The test is skipped
for devices that are identified as not logically created.

To test that the zone mapping is correct, select a few sequential write
required zones of the logical device and move the write pointers of
these zones through the container device of the logical device, using
the physical sector mapping of the zones. The write pointers position of
the selected zones is then checked through a zone report of the logical
device using the logical sector mapping of the zones. The test reports a
success if the position of the zone write pointers relative to the zone
start sector must be identical for both the logical and physical
locations of the zones.

To implement this test case, introduce several helper functions.
_find_last_sequential_zone() and _find_sequential_zone_in_middle()
help target zones selection. _test_dev_is_logical() checks the target
device type. If false is returned, the test case is skipped.
_get_dev_container_and_sector() helps to get the container device and
sector mappings. At this moment, these helper functions support
partition devices and dm-linear/flakey devices as the logical devices.
_test_dev_has_dm_map() helps to check that the dm target is linear or
flakey.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/007     |  95 +++++++++++++++++++++++++++++++++
 tests/zbd/007.out |   2 +
 tests/zbd/rc      | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100755 tests/zbd/007
 create mode 100644 tests/zbd/007.out

diff --git a/tests/zbd/007 b/tests/zbd/007
new file mode 100755
index 0000000..e4723d7
--- /dev/null
+++ b/tests/zbd/007
@@ -0,0 +1,95 @@
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
+DESCRIPTION="zone mapping"
+CAN_BE_ZONED=1
+
+requires() {
+	_have_program dmsetup
+}
+
+device_requires() {
+	_test_dev_is_logical
+}
+
+test_device() {
+	local -i bs
+	local -i zone_idx
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
+	# Select test target zones. Pick up the first sequential required zones.
+	# If available, add one or two more sequential required zones. One is at
+	# the last end of TEST_DEV. The other is in middle between the first
+	# and the last zones.
+	_get_blkzone_report "${TEST_DEV}" || return $?
+	zone_idx=$(_find_first_sequential_zone) || return $?
+	test_z=( "${zone_idx}" )
+	if zone_idx=$(_find_last_sequential_zone); then
+		test_z+=( "${zone_idx}" )
+		if zone_idx=$(_find_sequential_zone_in_middle \
+				      "${test_z[0]}" "${test_z[1]}"); then
+			test_z+=( "${zone_idx}" )
+		fi
+	fi
+
+	for ((i = 0; i < ${#test_z[@]}; i++)); do
+		test_z_start+=("${ZONE_STARTS[test_z[i]]}")
+	done
+	echo "${test_z[*]}" >> "$FULL"
+	echo "${test_z_start[*]}" >> "$FULL"
+
+	_put_blkzone_report
+
+	# Reset and move write pointers of the container device
+	for ((i=0; i < ${#test_z[@]}; i++)); do
+		local -a arr
+		read -r -a arr < <(_get_dev_container_and_sector \
+					   "${test_z_start[i]}")
+		container_dev="${arr[0]}"
+		container_start="${arr[1]}"
+
+		echo "${container_dev}" "${container_start}" >> "$FULL"
+
+		blkzone reset -o "${container_start}" -c 1 "${container_dev}"
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
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 5f04c84..1168c4e 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -193,6 +193,42 @@ _find_first_sequential_zone() {
 	return 1
 }
 
+_find_last_sequential_zone() {
+	for ((idx = REPORTED_COUNT - 1; idx > 0; idx--)); do
+		if ((ZONE_TYPES[idx] == ZONE_TYPE_SEQ_WRITE_REQUIRED)); then
+			echo "${idx}"
+			return 0
+		fi
+	done
+
+	echo "-1"
+	return 1
+}
+
+# Try to find a sequential required zone between given two zone indices
+_find_sequential_zone_in_middle() {
+	local -i s=${1}
+	local -i e=${2}
+	local -i idx=$(((s + e) / 2))
+	local -i i=1
+
+	while ((idx != s)) && ((idx != e)); do
+		if ((ZONE_TYPES[idx] == ZONE_TYPE_SEQ_WRITE_REQUIRED)); then
+			echo "${idx}"
+			return 0
+		fi
+		if ((i%2 == 0)); then
+			: $((idx += i))
+		else
+			: $((idx -= i))
+		fi
+		: $((i++))
+	done
+
+	echo "-1"
+	return 1
+}
+
 # Search zones and find two contiguous sequential required zones.
 # Return index of the first zone of the found two zones.
 # Call _get_blkzone_report() beforehand.
@@ -210,3 +246,99 @@ _find_two_contiguous_seq_zones() {
 	echo "Contiguous sequential write required zones not found"
 	return 1
 }
+
+_test_dev_is_dm() {
+	if [[ ! -r "${TEST_DEV_SYSFS}/dm/name" ]]; then
+		SKIP_REASON="$TEST_DEV is not device-mapper"
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_is_logical() {
+	if ! _test_dev_is_partition && ! _test_dev_is_dm; then
+		SKIP_REASON="$TEST_DEV is not a logical device"
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_has_dm_map() {
+	local target_type=${1}
+	local dm_name
+	dm_name=$(cat "${TEST_DEV_SYSFS}/dm/name")
+	if ! dmsetup status "${dm_name}" | grep -qe "${target_type}"; then
+		SKIP_REASON="$TEST_DEV does not have ${target_type} map"
+		return 1
+	fi
+	if dmsetup status "${dm_name}" | grep -v "${target_type}"; then
+		SKIP_REASON="$TEST_DEV has map other than ${target_type}"
+		return 1
+	fi
+	return 0
+}
+
+# Get device file path from the device ID "major:minor".
+_get_dev_path_by_id() {
+	for d in /sys/block/*; do
+		if [[ ! -r "${d}/dev" ]]; then
+			continue
+		fi
+		dev_id=$(cat "${d}/dev")
+		if [[ "${1}" == "${dev_id}" ]]; then
+			echo "/dev/${d##*/}"
+			return 0
+		fi
+	done
+	return 1
+}
+
+# Given sector of TEST_DEV, return the device which contain the sector and
+# corresponding sector of the container device.
+_get_dev_container_and_sector() {
+	local -i sector=${1}
+	local cont_dev
+	local -i offset
+	local -a tbl_line
+
+	if _test_dev_is_partition; then
+		offset=$(cat "${TEST_DEV_PART_SYSFS}/start")
+		cont_dev=$(_get_dev_path_by_id "$(cat "${TEST_DEV_SYSFS}/dev")")
+		echo "${cont_dev}" "$((offset + sector))"
+		return 0
+	fi
+
+	if ! _test_dev_is_dm; then
+		echo "${TEST_DEV} is not a logical device"
+		return 1
+	fi
+	if ! _test_dev_has_dm_map linear &&
+			! _test_dev_has_dm_map flakey; then
+		echo -n "dm mapping test other than linear/flakey is"
+		echo "not implemented"
+		return 1
+	fi
+
+	# Parse dm table lines for dm-linear or dm-flakey target
+	while read -r -a tbl_line; do
+		local -i map_start=${tbl_line[0]}
+		local -i map_end=$((tbl_line[0] + tbl_line[1]))
+		if ((sector < map_start)) || (((map_end) <= sector)); then
+			continue
+		fi
+
+		offset=${tbl_line[4]}
+		if ! cont_dev=$(_get_dev_path_by_id "${tbl_line[3]}"); then
+			echo -n "Cannot access to container device: "
+			echo "${tbl_line[3]}"
+			return 1
+		fi
+
+		echo "${cont_dev}" "$((offset + sector - map_start))"
+		return 0
+
+	done < <(dmsetup table "$(cat "${TEST_DEV_SYSFS}/dm/name")")
+
+	echo -n "Cannot find container device of ${TEST_DEV}"
+	return 1
+}
-- 
2.21.0

