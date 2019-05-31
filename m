Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7713C46460
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 01:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC1C2601B
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 01:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ol+FDtqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEaB7R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 21:59:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19074 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfEaB7R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 21:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559267957; x=1590803957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2x5tPTzPIYYfXqv4G+vKwWTkNH/JdH1Duf2QwNcKDc=;
  b=Ol+FDtqv7fdf6wmWhIJ0eFXIC60wb65X2wqVuCd/64wUBXhgnDs+P+lM
   jq3PQ0kaAZCheZorC0q+nulwzASDLNxSrdBEkNZxrPxisgCkdBoFcSb68
   Q99Q2yy4EYMKVKsXgsoYLds61PVy8+fUGJYuAA44gig0y27CGh6VDx8qu
   RxYqlCHksMO5E5jhqa40GCd2HxgKRh0kL9zT7hXfSbHvkoI2UTVLC0+Kp
   ehlZ1RX10tQufUyrRXTdIgx7qCv5ymCdLlA1rDhhzwbFqiM9B+4KgUsQi
   3m8UNfI6+vyZeKtTH4IOkozvG/uB/cdHg6111U1W/EU09owHfCjuX4VrH
   g==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="111145552"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 09:59:17 +0800
IronPort-SDR: VxVcnjKtcS7xCKVXg7ywbbreqlyhYkewHLO6ch4FBqk1YVex7finoHty0jFZqCJOcldCKDLmYG
 arbReOY0wyaUFPVh6vtMKmm45LD43Od5FonHLtAPy5vey31kNT3lGLuOE6zExAhopD4E7tICuJ
 vLnCBFWHB7TLA+zja2tYyIz1urtVHBw7x9tWuVznz4RyFBiUxinqrOZSSCPBLE7TxBxFGEdYi1
 +nsmq4osQeQ5BFxERleX7IGQgIhNhO3OLlnm9EEpZNwW2+OUxTfc7OIIrwVtuXN9n3xRbXM8QS
 IRrgOTUclmKoPLx/Hqk3SNUK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 May 2019 18:36:46 -0700
IronPort-SDR: p7ZzSZCRqWM5USzLWoZWDkfd2LUPuIeUGrvl4+0KinGxQRtHDIuTGmFtWoHlQkTK4wcp26zMZ3
 eKMrLJu9p3FHtmpf3tENG9ppeA8gQ7WTgxRNz+O2h8dK/f0P4sSo+AejC5MIl42IJmmoG4pRmc
 Zak9/ecl3xvnYpDEbYgaFnXI5It0qb58P09KOZkzD0tEwtSR/4juzMEU2oRL1P4DFUq3nZep+k
 l4+5eyH6w+AmTASV3RGXjabF9aTydrifq38wP3O7IA7YZwgNeO8pi7RSqEFAy73XTU57ckEAZ8
 6+M=
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 May 2019 18:59:15 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for zone mapping test
Date:   Fri, 31 May 2019 10:59:12 +0900
Message-Id: <20190531015913.5560-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As a preparation for the zone mapping test case, add several helper
functions. _find_last_sequential_zone() and
_find_sequential_zone_in_middle() help to select test target zones.
_test_dev_is_logical() checks TEST_DEV is the valid test target.
_test_dev_has_dm_map() helps to check that the dm target is linear or
flakey. _get_dev_container_and_sector() helps to get the container device
and sector mappings.
---
 tests/zbd/rc | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index 5f04c84..792b83d 100644
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
+	while ((idx != s && idx != e)); do
+		if ((ZONE_TYPES[idx] == ZONE_TYPE_SEQ_WRITE_REQUIRED)); then
+			echo "${idx}"
+			return 0
+		fi
+		if ((i%2 == 0)); then
+			$((idx += i))
+		else
+			$((idx -= i))
+		fi
+		$((i++))
+	done
+
+	echo "-1"
+	return 1
+}
+
 # Search zones and find two contiguous sequential required zones.
 # Return index of the first zone of the found two zones.
 # Call _get_blkzone_report() beforehand.
@@ -210,3 +246,100 @@ _find_two_contiguous_seq_zones() {
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
+
+	dm_name=$(<"${TEST_DEV_SYSFS}/dm/name")
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
+		if [[ "${1}" == "$(<"${d}/dev")" ]]; then
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
+		offset=$(<"${TEST_DEV_PART_SYSFS}/start")
+		cont_dev=$(_get_dev_path_by_id "$(<"${TEST_DEV_SYSFS}/dev")")
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
+
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
+	done < <(dmsetup table "$(<"${TEST_DEV_SYSFS}/dm/name")")
+
+	echo -n "Cannot find container device of ${TEST_DEV}"
+	return 1
+}
-- 
2.21.0

