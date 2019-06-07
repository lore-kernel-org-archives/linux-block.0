Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB88C468BD
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D8320665
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F32VfgnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfFGMT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:19:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58140 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfFGMT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 08:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559909998; x=1591445998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYBbw4Ktuqi2MnClo3f1wC1CF0Ikk7vhFh53ZZllDco=;
  b=F32VfgnDEoL0Q3+4wotZBfUQ6BkQTNZ9BiGyFxekHFkK/P6o9ffJYxKy
   IAjVKAjLJts23b/Rw1HubzMyHFXWrf/Oaa0Et1p1YxQyapKZDCBGFlJ1Q
   JLUkysI4DOB95ATheeF1Uf5c0Lr09e3cQuSsDUeEl03//2Ispfn4x25uC
   Sfoc65n0ZlFbyZ1Y3WL9MrlO+HRqYeQX/KCEo3k7J5oaT48JfouYPP9ju
   DD1Qxz5YzJBK1cDMRg4BnfSO639omoy9elCmPcQq+XtdpsTq5Ksqvkkbn
   5CP0nkjrUnmBxySIMY0k3GjdH5orS1dg2Yp+N0W9eZl6yTi0dMnRilAiD
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="216339837"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 20:19:58 +0800
IronPort-SDR: 7tKAbeGS0ceawc9QgFN//gUc7DtgBYvdyTzAvuHa6rBd7ilZtNeUtAROCxFytCykkI3T+dDbZM
 EsmBHhfZ5OqicaolEFOIfLPg5nSbzg1cPkPYL0zbGCitIoWn/llH251HpvwKS0enkxkAw6ZIGi
 APXwNJqMYwBr95CMgjDAJOte5cGDcBpOV4XpoZfDCg0hCAadtaNoG2Zfjux8TX+1iH2VNQdVYH
 eQZln2lg/TjOpZqCz6AXibF6Wpy5483m/fZaMDgqexzlr1ZCT/796b3/sDNzht5fcIu6abLHDd
 3F1vmItCutmEshuIP5sXw7bJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 04:54:51 -0700
IronPort-SDR: Vl5fJHIlpi1LqhtmYwsSYsU/icsrs7AmTwo50Fb9DBt4ukYP+GHTzQYFvVHLI9J+nPjmQAsXwV
 J4b7MYpKosPkI2s+ZFmhp7dwAooxqf5PZ2p2e59FThUsNDKCbDdtOqxkexk0EuYpqySDUqQSKd
 oYKlRaA4NYGpILMRpqQeTu15vbk7kJ7q+bo/HsEW+woN3T3kkIg8sH+q4D9dYOqnxKzhLY86cS
 NYselLJwu0BSLGGxRFDZxd/3pGRPpKmTyPyMztxxBJzF1XiGk6kLgwdcRum3YbhZM1+B05bt/v
 o9I=
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 05:19:58 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v3 1/2] zbd/rc: Introduce helper functions for zone mapping test
Date:   Fri,  7 Jun 2019 21:19:54 +0900
Message-Id: <20190607121955.9368-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607121955.9368-1-shinichiro.kawasaki@wdc.com>
References: <20190607121955.9368-1-shinichiro.kawasaki@wdc.com>
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

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/rc | 140 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index 5f04c84..5dd2779 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -193,6 +193,49 @@ _find_first_sequential_zone() {
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
+	local -i idx
+	local -i i=1
+
+	if ((s < 0 || e >= REPORTED_COUNT || e <= s + 1)); then
+		echo "Invalid arguments: ${s} ${e}"
+		return 1
+	fi
+
+	idx=$(((s + e) / 2))
+
+	while ((idx != s && idx != e)); do
+		if ((ZONE_TYPES[idx] == ZONE_TYPE_SEQ_WRITE_REQUIRED)); then
+			echo "${idx}"
+			return 0
+		fi
+		if ((i%2 == 0)); then
+			((idx += i))
+		else
+			((idx -= i))
+		fi
+		((i++))
+	done
+
+	echo "-1"
+	return 1
+}
+
 # Search zones and find two contiguous sequential required zones.
 # Return index of the first zone of the found two zones.
 # Call _get_blkzone_report() beforehand.
@@ -210,3 +253,100 @@ _find_two_contiguous_seq_zones() {
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
+	for d in /sys/block/* /sys/block/*/*; do
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

