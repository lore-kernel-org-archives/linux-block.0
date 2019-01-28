Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A77DC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5103220989
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QPwJWJX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1NPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:15:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60364 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfA1NPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548681331; x=1580217331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXVjGmULqipA7ROs8cuvjZ8HifiIlveKYNJgKpS3KdE=;
  b=QPwJWJX8sJbv4TupE4Oh0e7KumYPZs3mQlRnBcA7qySlqza2W6sdfv09
   GyUtgZnWz0VjNMXUL5fdfHLYOq8OuYu+prtscXbCfS8UD3V4E/4jkPJo0
   x8Dm/9yJeV3NoQTY3nro3hoSJg+jO/FCw5xG8zNJWCxbHZ0ibFiYrzXp/
   azZTJck9aCozcQMi9WUhx84F90tYulGUJ1QHps94Vm3tYQAK+DEgyA0iW
   9nYbG7MEwXU0RA4t6kN2KKWEu6sAXl3RHG4lqpcwkLnrvIge5tX9r5FSG
   POsxTaAQ98u7qxQZmNhkvKCWJ/niW7I+zeWbqA6VBQ9as3GiiOEa/qHME
   g==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="204977749"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 21:15:31 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jan 2019 04:56:32 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2019 05:15:28 -0800
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
Subject: [PATCH blktests v4 07/12] tests: Introduce zbd test group
Date:   Mon, 28 Jan 2019 22:14:50 +0900
Message-Id: <20190128131455.31997-8-shinichiro.kawasaki@wdc.com>
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

The zoned block device (zbd) test group is used to gather all tests
specific to zoned block devices (null_blk device with zoned mode enabled,
SMR disks, dm-linear on top of zoned devices, etc). Execution of this group
requires that the kernel be compiled with the block layer
CONFIG_BLK_DEV_ZONED option enabled and also requires the null_blk driver
to have zoned mode support (added in kernel 4.19).

This group rc script implements _fallback_null_blk_zoned() helper function
which initailize a null_blk device with zoned mode. Each of the zbd group
test cases calls it in fallback_device() function. This allows the zbd
group test cases fallback to the null_blk device even if the TEST_DEVS
is empty. With this, all tests scripts can be written by only defining
the test_device() function while allowing operation on both null_blk and
user specified devices.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/zbd/rc | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 tests/zbd/rc

diff --git a/tests/zbd/rc b/tests/zbd/rc
new file mode 100644
index 0000000..a6c7696
--- /dev/null
+++ b/tests/zbd/rc
@@ -0,0 +1,195 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#
+# Tests for Zone Block Device.
+
+. common/rc
+. common/null_blk
+
+#
+# Test requirement check functions
+#
+
+group_requires() {
+	_have_root || return $?
+	_have_program blkzone || return $?
+	_have_program dd || return $?
+	_have_kernel_option BLK_DEV_ZONED || return $?
+	_have_modules null_blk && _have_module_param null_blk zoned
+}
+
+group_device_requires() {
+	_test_dev_is_zoned
+}
+
+_fallback_null_blk_zoned() {
+	if ! _init_null_blk zone_size=4 gb=1 zoned=1 ; then
+		return 1
+	fi
+	echo /dev/nullb0
+}
+
+#
+# Zone types and conditions
+#
+export ZONE_TYPE_CONVENTIONAL=1
+export ZONE_TYPE_SEQ_WRITE_REQUIRED=2
+export ZONE_TYPE_SEQ_WRITE_PREFERRED=3
+
+export ZONE_COND_EMPTY=1
+export ZONE_COND_IMPLICIT_OPEN=2
+export ZONE_COND_FULL=14
+
+export ZONE_TYPE_ARRAY=(
+	[1]="CONVENTIONAL"
+	[2]="SEQ_WRITE_REQUIRED"
+	[3]="SEQ_WRITE_PREFERRED"
+)
+
+export ZONE_COND_ARRAY=(
+	[0]="NOT_WP"
+	[1]="EMPTY"
+	[2]="IMPLICIT_OPEN"
+	[3]="EXPLICIT_OPEN"
+	[4]="CLOSE"
+	[13]="READ_ONLY"
+	[14]="FULL"
+	[15]="OFFLINE"
+)
+
+# sysfs variable array indices
+export SV_CAPACITY=0
+export SV_CHUNK_SECTORS=1
+export SV_PHYS_BLK_SIZE=2
+export SV_PHYS_BLK_SECTORS=3
+export SV_NR_ZONES=4
+
+#
+# Helper functions
+#
+
+# Obtain zone related sysfs variables and keep in a global array until put
+# function call.
+_get_sysfs_variable() {
+	unset SYSFS_VARS
+	local _dir=${TEST_DEV_SYSFS}
+	SYSFS_VARS[$SV_CAPACITY]=$(<"${_dir}"/size)
+	SYSFS_VARS[$SV_CHUNK_SECTORS]=$(<"${_dir}"/queue/chunk_sectors)
+	SYSFS_VARS[$SV_PHYS_BLK_SIZE]=$(<"${_dir}"/queue/physical_block_size)
+	SYSFS_VARS[$SV_PHYS_BLK_SECTORS]=$((SYSFS_VARS[SV_PHYS_BLK_SIZE] / 512))
+
+	# If the nr_zones sysfs attribute exists, get its value. Otherwise,
+	# calculate its value based on the total capacity and zone size, taking
+	# into account that the last zone can be smaller than other zones.
+	if [[ -e ${TEST_DEV_SYSFS}/queue/nr_zones ]]; then
+		SYSFS_VARS[$SV_NR_ZONES]=$(<"${_dir}"/queue/nr_zones)
+	else
+		SYSFS_VARS[$SV_NR_ZONES]=$(( (SYSFS_VARS[SV_CAPACITY] - 1) \
+				/ SYSFS_VARS[SV_CHUNK_SECTORS] + 1 ))
+	fi
+}
+
+_put_sysfs_variable() {
+	unset SYSFS_VARS
+}
+
+# Issue zone report command and keep reported information in global arrays
+# until put function call.
+_get_blkzone_report() {
+	local target_dev=${1}
+
+	# Initialize arrays to store parsed blkzone reports.
+	# Number of reported zones is set in REPORTED_COUNT.
+	# The arrays have REPORTED_COUNT+1 elements with additional one at tail
+	# to simplify loop operation.
+	ZONE_STARTS=()
+	ZONE_LENGTHS=()
+	ZONE_WPTRS=()
+	ZONE_CONDS=()
+	ZONE_TYPES=()
+	NR_CONV_ZONES=0
+	REPORTED_COUNT=0
+
+	TMP_REPORT_FILE=${TMPDIR}/blkzone_report
+	if ! blkzone report "${target_dev}" > "${TMP_REPORT_FILE}"; then
+		echo "blkzone command failed"
+		return $?
+	fi
+
+	local _IFS=$IFS
+	local -i loop=0
+	IFS=$' ,:'
+	while read -r -a _tokens
+	do
+		ZONE_STARTS+=($((_tokens[1])))
+		ZONE_LENGTHS+=($((_tokens[3])))
+		ZONE_WPTRS+=($((_tokens[5])))
+		ZONE_CONDS+=($((${_tokens[11]%\(*})))
+		ZONE_TYPES+=($((${_tokens[13]%\(*})))
+		if [[ ${ZONE_TYPES[-1]} -eq ${ZONE_TYPE_CONVENTIONAL} ]]; then
+			(( NR_CONV_ZONES++ ))
+		fi
+		(( loop++ ))
+	done < "${TMP_REPORT_FILE}"
+	IFS="$_IFS"
+	REPORTED_COUNT=${loop}
+
+	if [[ ${REPORTED_COUNT} -eq 0 ]] ; then
+		echo "blkzone report returned no zone"
+		return 1
+	fi
+
+	# Set value to allow additioanl element access at array end
+	local -i max_idx=$((REPORTED_COUNT - 1))
+	ZONE_STARTS+=( $((ZONE_STARTS[max_idx] + ZONE_LENGTHS[max_idx])) )
+	ZONE_LENGTHS+=( "${ZONE_LENGTHS[max_idx]}" )
+	ZONE_WPTRS+=( "${ZONE_WPTRS[max_idx]}" )
+	ZONE_CONDS+=( "${ZONE_CONDS[max_idx]}" )
+	ZONE_TYPES+=( "${ZONE_TYPES[max_idx]}" )
+
+	rm -f "${TMP_REPORT_FILE}"
+}
+
+_put_blkzone_report() {
+	unset ZONE_STARTS
+	unset ZONE_LENGTHS
+	unset ZONE_WPTRS
+	unset ZONE_CONDS
+	unset ZONE_TYPES
+	unset REPORTED_COUNT
+	unset NR_CONV_ZONES
+}
+
+# Issue reset zone command with zone count option.
+# Call _get_blkzone_report() beforehand.
+_reset_zones() {
+	local target_dev=${1}
+	local -i idx=${2}
+	local -i count=${3}
+
+	if ! blkzone reset -o "${ZONE_STARTS[idx]}" -c "${count}" \
+	     "${target_dev}" >> "$FULL" 2>&1 ; then
+		echo "blkzone reset command failed"
+		return 1
+	fi
+}
+
+# Search zones and find two contiguous sequential required zones.
+# Return index of the first zone of the found two zones.
+# Call _get_blkzone_report() beforehand.
+_find_two_contiguous_seq_zones() {
+	local -i type_seq=${ZONE_TYPE_SEQ_WRITE_REQUIRED}
+
+	for ((idx = NR_CONV_ZONES; idx < REPORTED_COUNT; idx++)); do
+		if [[ ${ZONE_TYPES[idx]} -eq ${type_seq} &&
+		      ${ZONE_TYPES[idx+1]} -eq ${type_seq} ]]; then
+			echo "${idx}"
+			return 0
+		fi
+	done
+
+	echo "Contiguous sequential write required zones not found"
+	return 1
+}
+
-- 
2.20.1

