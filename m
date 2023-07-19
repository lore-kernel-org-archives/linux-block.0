Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F276EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGSHPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGSHPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:18 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8AEE43
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750918; x=1721286918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uLN/bf/CwY5QdaY046syQAVGUa8EIplLl09TzUIT9M=;
  b=quE1JPAdR3FoI4jFFit/Czs+oraaFyJtU67VG6Qeb8Ynke2cqlaaA4KA
   1jj+/uYoIJeCwsysb9pGWLEmNBwGYc1AzeSfc1SOIuh1uE2WFNAlwmBuu
   QBO1an+s1ZkMWaahR46aXdmJaE2zNThPXt57pft0qEKj8HGQfFcMNsAmd
   Kc9bNML9hQVivQCGnrpyhT6ObNNWDzapZdrBPhi4+DsUF1JVLHRmcwU/P
   eOn8KELoD2YSC/0A7PXBhabSzAlQI1qGdEm8JEYdBOXZ49ip30XXDvyBZ
   VbEwTQ+eFcuWvtuzbisvmcwzcNvzsrKags/rLJ27uj59K7WVJ53KaIG1/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846530"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:17 +0800
IronPort-SDR: ikWBoOr71qAoO1ygusZ+wL1WVwNlrK1023Mw8rgCYNhNmm/bpv2T8EYqgb2gPFsFBLUeeE292Q
 C2kSK9Xt/jMLtB+vRrUm0asTUXMBYcsiXRPS88v04o3eP+0RJS5Vd8eDzpLyqYDbEq10WVEqF3
 cN/DqLd6q2gBsMYCdeuhR41nNe9wnDcAxiAWyvvazvSSfa55YHhpQDQ2Lav/Z+i/9OpDrm6mjU
 2JQgnBfTfggmxJO2PJQJGlf6NLesuy8dJFrrH0D5wEvtzbb3Bhn1T30M2E2JgbQUloz4trGUkP
 I2Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:23:25 -0700
IronPort-SDR: OVLPoeUiukHrHWd9T07cHYIvUItZsX+2RH/9FFw5S4rnIeW0O5fcHKGK/i1ITuzxOY054PIliW
 xhqQ5FTrsjuNWotZLSwLvwCq/ZighJpHdsLs61YC+C4F4mgViJ7PnIRvbSJbsJtEOY5b3/zd2l
 Xks7zrI2L3h8SkYQNspO9axg4PGp4Iv7MMpQbri6/ent4j94d9m42aMpUQPsivwV7AdiLJ/AJK
 XzNFpZfwjXrxVt6EcqgsnThkP1bRGrq4OdsQTkoTh7XRqCpxt1U9OD0HGsovKwhr5YvKZvwgXm
 qWg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:13 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/6] common/{rc,dm}: introduce functions to set scheduler of dm destinations
Date:   Wed, 19 Jul 2023 16:15:07 +0900
Message-Id: <20230719071510.530623-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since version v6.5, kernel no longer provides scheduler sysfs attribute
of bio based device-mapper. If TEST_DEV is a bio based device-mapper and
the test case requires specific scheduler, it is required to modify
sysfs attributes of destination devices instead of TEST_DEV.

To set scheduler to the sysfs attribute of destination devices, add the
helper function _dm_destination_dev_set_scheduler. It saves the original
scheduler value in the associative array SYSFS_QUEUE_SAVED so that it is
restored at each test case end. Also add _test_dev_set_scheduler which
sets scheduler regardless whether TEST_DEV is a bio based device-mapper
or not.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/dm | 21 +++++++++++++++++++++
 common/rc |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/common/dm b/common/dm
index 85e1ed9..14f4265 100644
--- a/common/dm
+++ b/common/dm
@@ -21,3 +21,24 @@ _get_dev_path_by_id() {
 	done
 	return 1
 }
+
+_dm_destination_dev_set_scheduler() {
+	local dest_dev_id dest_dev path
+
+	while read -r dest_dev_id; do
+		if ! dest_dev=$(_get_dev_path_by_id "${dest_dev_id}"); then
+			continue
+		fi
+		path=${dest_dev/dev/sys\/block}/queue/scheduler
+		if [[ ! -w ${path} ]]; then
+			echo "Can not set scheduler of device mapper destination: ${dest_dev}"
+			continue
+		fi
+		if [[ ${SYSFS_QUEUE_SAVED["$path"]-unset} == unset ]]; then
+			SYSFS_QUEUE_SAVED["$path"]="$(sed \
+					-e 's/.*\[//' -e 's/\].*//' "${path}")"
+		fi
+		echo "${1}" > "${path}"
+	done < <(dmsetup table "$(<"${TEST_DEV_SYSFS}/dm/name")" |
+			 sed -n  's/.* \([0-9]*:[0-9]*\).*/\1/p')
+}
diff --git a/common/rc b/common/rc
index 4984100..52d1602 100644
--- a/common/rc
+++ b/common/rc
@@ -10,6 +10,7 @@ shopt -s extglob
 # Include fio helpers by default.
 . common/fio
 . common/cgroup
+. common/dm
 
 # If a test runs multiple "subtests", then each subtest should typically run
 # for TIMEOUT / number of subtests.
@@ -294,6 +295,14 @@ _test_dev_queue_set() {
 	echo "$2" >"$path"
 }
 
+_test_dev_set_scheduler() {
+	if [[ -w "${TEST_DEV_SYSFS}/queue/scheduler" ]]; then
+		_test_dev_queue_set scheduler "$1"
+	elif _test_dev_is_dm; then
+		_dm_destination_dev_set_scheduler "$1"
+	fi
+}
+
 _require_test_dev_is_pci() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q pci; then
 		# nvme needs some special casing
-- 
2.40.1

