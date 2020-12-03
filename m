Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4EFC83014
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668EB217A0
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbgLCIXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:23:55 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38586 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbgLCIXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 03:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606983834; x=1638519834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPRSpPjfvRjSN9KdlKbem0b6Wu4WeYyVxvWLW/m4TNg=;
  b=quG3XBHpdAOoOctZ5O4xhg5fmckRLpotiLOSbusx06AYm4dqEh30a267
   zKqW14h364mKwYCRtWr1Ymv2pr8gXMghouX9iCsCO4Nj644YvMeO+1yH/
   hYsA/vhxXR2hKFur0lN0PmL5nFwc6UttXsZpZiqb6duiPH8h3mYuITnVE
   gBKrnlCgTOuOcSPoigMWG4Ke3U1sqbQ9YWhABLrvEA3/39erO5bh+NjAa
   T5v8xsPoqyJHsy1Q/r8X5L5P3JQ5rLmuu4zAKIX2y5W5X/hjqHjwlH1Tl
   uIkT3rOQogvAfpxgfanAYaRWeTImcSW3bqMz3VEi3C81LWAa1nR+HgMOP
   Q==;
IronPort-SDR: +smjE2e2+aDBxhTPoC4mU+PV78bum/GCFRwpA36hWbS6A+iolxO/BreHwTYNcIG0uF6f4fDAJK
 o0L115hDJXVch4x9+3A3tOUBxWAKXeqwolcnXOE9U341wdbypVantlpti2qSWl5poqBkJjznjh
 6OSF1SXIO9JefqAYw5LQRITGjVE9jHqTuDYpxNqcrcbqrmwjbJinGO8N1V7SWrdf46m7bAcc2P
 M5kll7Ds0JUvIZDNr+yFLUL12sP/wZD/r+riS5KCO8HivAS/bJ112I1uYfM0iC4F3oT6HY2fQz
 b1w=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="154306301"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:22:49 +0800
IronPort-SDR: qx4jNV05ptWOO5XA75wASAY3qw53EzX/7N4Q3dLoQ4x9efhIzIgio/ynffyhubXLnQ4knFBslw
 JviSecAMU0/K6cQo/x52pkgXC7Z8wIXuA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:06:59 -0800
IronPort-SDR: jURoI+9ObdYckp1Ti8rIuTyn6pbKglO94BsQYBSxLy1mnhbGfiQek5fE7/3QL9WZu3H+8Z0HaJ
 2+g+BlzsFZKg==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Dec 2020 00:22:48 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] zbd/005: Provide max_active/open_zones limit to fio command
Date:   Thu,  3 Dec 2020 17:22:44 +0900
Message-Id: <20201203082244.268632-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
References: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
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

