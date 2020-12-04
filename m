Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD1C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E17224BE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgLDCos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:44:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5204 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgLDCos (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 21:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607049887; x=1638585887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJ/1XenUYJjYtHaFN3rHzOaKbVrrQPZ9mT2xSptjg8Q=;
  b=obT49UoDVzkmViOI29OLUVTye9kNX220QteJVFO9X/ihkZBsVbgOK/fI
   CfQ30jyzZ9EZZvmIdNREqa/Gw4BSvkZekDohPjNUsYodhlPti+cP/X+mV
   JWf03IQolUGBVfFpOmCUiZIQ82BReeqlrNXJeseTyYNtxO16sPoX8U324
   O8urYiZjFP10tmOAWQYdmDyha9pAjXoAJQNOJ7PDlMzBqAynwRVurLKJb
   D3u+RN1wo4VBxxv+RNK1yw+MuSK8eOfi7P55TCBZckVqBtrxdXoqVoKjL
   XxJa7Qly4FDFnRxJW/JJznJYKdOK0HzXXNGvHDCkbhEzZMxHVdYY11qQK
   g==;
IronPort-SDR: jFMN4X+dMBV9amvFFo8Hfz+JjOCyc1OmJdkS12YyDgFN+3kh8K9eGiujWsMy+8ci7HgUG/TVdk
 ysf7DyH3dCc+ci+RMS/an/FrE/mzUsHe46vc6viglXkI54025wSvgA9acejNjuYzsPyEM8EdQR
 YCGtEk/lxk45fXHvX7KkWZm8WGGwhnzElgNZGZ7iLp4kS32oRzTguh4N5Tmdy4CyiDulA/dt+/
 5Y0GskdVyijBvLZ6QlclkwKAG3G6OOZrXWlyQ04f6zWNyzy3eMEZ9uDJ7Wh69V7fQW790jmOpS
 xt0=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="264546969"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 10:42:39 +0800
IronPort-SDR: GZrb/XyRYR/EbDBEAQx1+efnESw5zLzKXfnB/EBEOtVXaU4qUE0UZ600N+sBle48LDwo7ZdjlG
 iLEes+BO0B9aUf5Y53qzCgmrgS06I0YHc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 18:28:12 -0800
IronPort-SDR: tMv9MWngb71/7WPwHKC3e0kVADirP2BxmEeq2/FpVqFi9DATSJWOx3cbxVbsIWBC9HHyNE3oYW
 sTP1wN+RJooQ==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Dec 2020 18:42:38 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] zbd/005: Provide max_active/open_zones limit to fio command
Date:   Fri,  4 Dec 2020 11:42:35 +0900
Message-Id: <20201204024235.273924-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
References: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
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

