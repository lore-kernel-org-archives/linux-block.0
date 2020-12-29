Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC4DC433DB
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 00:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3078A2222A
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 00:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgL2Aqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 19:46:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59532 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgL2Aqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 19:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1609202807; x=1640738807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ha6RmPM/35Zv5cAGmjxa4wGXp9l404hBv7VLHtjEUjQ=;
  b=IVdsOMerrT+Qgy8OP4dp95L6t10kpAROZsXgdJSNVtGNGf0HrEUtn5P2
   i8zTqASPPaHXtRUYNPySpspVv+pyvfvEOefKwlcD8w1u1bhQ/4BdjKtd0
   s4Jb4Wvvfz+RU66PQyzDN/AGqY1bgqcF1TRNxeREekZw6XXoM2wjWcYYS
   be9GpviF27NBrUmJAe0ByJorrmmUpR8RimGN6zu8/kkEzcIKseKZOzKRh
   IXh3Jei14CAgPOZ4TebuScvsUGm8zUdFOSRgogFTXLoXUeiXnfNVBVgY7
   vKOG4FNrbZ0ZVrmSIlMTKsEaWFMy7dJlOXAb5HlWk2mAOnNyHJTxe5Oc5
   Q==;
IronPort-SDR: BNYjDQ/HdvEAqWk1opow53D1Pyr9dhUdwCbWlcq8QzSxSOZQoEOZmFLS4NzwdFVMcTS4v6ELHv
 2NABLzv+Do3kH9jsN+yQxTyKUV2ERFizPpu98NpO4tb4StQp1PpaI6pa1fQgHjwoE60lsdg7k7
 cs9z6oKqhoytKcFTTq1MLGfhQmla4m4Syo0ONCczX7FnLTwch85ftq8epMfWEInax7upsx+o5x
 ZGlZeavtOEmJ93XrGOLgRnJTEWuTM4VQlmqT/kfxrmpNF6M9EwqjL9PnUD1pF++LeLLnuA6i1O
 x28=
X-IronPort-AV: E=Sophos;i="5.78,456,1599494400"; 
   d="scan'208";a="156192857"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2020 08:44:38 +0800
IronPort-SDR: 6wyMmAOcb5pgFnw+LCJCRizGNDXxydWl44Elo4asZOnjHUBpVN6fGOKefQ091Q2PR52CotbfrD
 eBWrb71d87UHwowMkf46VdFpElDn4SR4ffSXIWJBWj3xWxt1SiFo+CSTRmtHZsapd3HIz09G3L
 cMxYByMZbRVxk2ZQo5lYk+ej1IJPUZF+Yjh06+Q1U4UWw9JbnRWb7ErVv67QTBRmtGZoSWSAcu
 9p+U8QpqgBLiInGDfgxl5m5bfojsMaauO+pBbkVmNYvOYcZi5P3lJY2pyqFLRPIG7oVxXLVYPm
 OlI+RZapHRoMvRhhSl/zKW1I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 16:29:41 -0800
IronPort-SDR: v8I26ngK5czgaiEIan3hzGycI2GX5/42BHKbt2cfjOJmrBu225Vb9K1saMbN0kdnvhd4K3rjDp
 ZYotpZ5bufZe70JHfM2CFwyjbEOMg3Gny6ZjyfLhbY6fu5dOlHi02GMHLGMMg+cWynYIdEcWFG
 sfZWLTxiGe2lWAj7RW8d1NqLvikQJwV7UoyIJS6fyKY4c47od5+65DoN59+VUVuhR7mI/l7KZu
 r/gMynqqVc19tyuerMB10uITMbIsaY32SIep4MJuGd6XQwFedy4K1gD58TgBl+XMpD5IW5i8uu
 NBM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Dec 2020 16:44:38 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 2/2] zbd/005: Provide max_active/open_zones limit to fio command
Date:   Tue, 29 Dec 2020 09:44:34 +0900
Message-Id: <20201229004434.927644-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
References: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When test target zoned block devices have max_open_zones or
max_active_zones limit, high queue depth sequential write in the test
case zbd/005 may result in parallel writes to number of zones beyond the
limit. This causes I/O errors.

To avoid the errors, specify the limit to fio command in the test case.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/zbd/005 | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/zbd/005 b/tests/zbd/005
index 1e8962c..a7fb175 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -28,7 +28,8 @@ cleanup_fallback_device() {
 test_device() {
 	local -i zone_idx
 	local -i offset
-	local zbdmode=""
+	local -i moaz
+	local -a zbdmode=()
 
 	echo "Running ${TEST_NAME}"
 
@@ -36,11 +37,13 @@ test_device() {
 
 	zone_idx=$(_find_first_sequential_zone) || return $?
 	offset=$((ZONE_STARTS[zone_idx] * 512))
+	moaz=$(_test_dev_max_open_active_zones)
 
 	# If the test target zone has smaller zone capacity than zone size,
-	# enable zonemode=zbd to have fio handle the zone capacity limit.
-	if ((ZONE_CAPS[zone_idx] != ZONE_LENGTHS[zone_idx])); then
-		zbdmode="--zonemode=zbd"
+	# or if the test target device has max open/active zones limit, enable
+	# zonemode=zbd and specify the limit to handle the zone restrictions.
+	if ((ZONE_CAPS[zone_idx] != ZONE_LENGTHS[zone_idx])) || ((moaz)); then
+		zbdmode=("--zonemode=zbd" "--max_open_zones=${moaz}")
 	fi
 
 	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
@@ -51,7 +54,7 @@ test_device() {
 	FIO_PERF_FIELDS=("write io" "write iops")
 	_fio_perf --filename="${TEST_DEV}" --name zbdwo --rw=write --direct=1 \
 		  --ioengine=libaio --iodepth=128 --bs=256k \
-		  --offset="${offset}" ${zbdmode}
+		  --offset="${offset}" "${zbdmode[@]}"
 
 	_put_blkzone_report
 
-- 
2.28.0

