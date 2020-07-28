Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9CC433EA
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6499F2083E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GK7F+x7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgG1KPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:15:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41078 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595931299; x=1627467299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VaCNNGEe5OuQ6YDyy/3tXmiPAr5Ndjgz9QsiLcuEud4=;
  b=GK7F+x7fKA5ItYd5bCyrbEn2NQgHiLkpdl2BKD3+A/x8fmTBqkpmkehx
   Y5n0YHcFG905zXmmXxW13P1rQ7gb+MQSdBgBrJfydscILi8edoai0n3M9
   JQG/idrASRo5DCMBu583ziRi+/S4zSY7IqwsEcW9lerhae0soqTK+zmaF
   AbaxnYWOZmUCu29D0Kzl90Das0V24sItqRp9fv7qjB1lF0af098OLgW/h
   RnTLl3bgRL6hATDvuB1xrbpYHIkRb/1pPu4MKu9hlbelO11CjSOpTq22G
   v1YUuUr+xnnpzrqW4trlL7BEV+w6hRIW9dCU1UTDt9eRN7yDggMx2Q7Fp
   g==;
IronPort-SDR: tnRyt9ZIdpWpMf+uBXI7yFp0g/s3XnMExxLK3hykhGu0Y40pAozJp4Fg4mzdtri30PvK9WHp2P
 wJd0jNQbRRa5tUDlx0dFSbcTq/XjpgM9RksKip3w4LIcDS4dGimqwIlyotz2akbsOABB/+Hmup
 uBSwxJggx/PvEpbE2ubV/Mu84j2/lBMQh8PxQquUqzTAMXkyPE5MGcxjrAreuyIUG25pjwuC3g
 rDJTKQWfzsG3Xu1diMIsclmPB5cEt4gJPJbsG6f6pR0vYksfdhU7dbVmm+HkWYuajfcTWL9rE1
 prE=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143543047"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:14:59 +0800
IronPort-SDR: 7Dz8nEYLBg7t8MsLIOmM+xiqFtM2HmQbOs38/eMbMuUCWs0B9KcVMJNqqn5oGoHzpQ4YqzMMxi
 IFaYhw2TzmE/5QT3vwCyeaU3GDW5vFtXM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:03:08 -0700
IronPort-SDR: 513hgTjlbOoCIVpIrG+2jXZI3aOY74qSyKjUGoNXYGkDnl3OD/jfZyPW4M9it1cGLb+ZzGWdHj
 QbywUPq3itvg==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 03:14:58 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/5] zbd/005: Enable zonemode=zbd when zone capacity is less than zone size
Date:   Tue, 28 Jul 2020 19:14:51 +0900
Message-Id: <20200728101452.19309-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case zbd/005 runs fio to issue sequential write requests with
high queue depth. This workload does not require zonemode=zbd for zones
with zone capacity same as zone length. However, when the zone has
smaller zone capacity than zone size, it issues write beyond zone
capacity and triggers write errors.

To allow fio skipping the writes beyond zone capacity, specify the option
zonemode=zbd to fio when the test target zone has zone capacity smaller
than zone size.

Also remove unused sysfs access in the test case.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/005 | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/zbd/005 b/tests/zbd/005
index 65546a6..1e8962c 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -28,15 +28,21 @@ cleanup_fallback_device() {
 test_device() {
 	local -i zone_idx
 	local -i offset
+	local zbdmode=""
 
 	echo "Running ${TEST_NAME}"
 
-	_get_sysfs_variable "${TEST_DEV}" || return $?
 	_get_blkzone_report "${TEST_DEV}" || return $?
 
 	zone_idx=$(_find_first_sequential_zone) || return $?
 	offset=$((ZONE_STARTS[zone_idx] * 512))
 
+	# If the test target zone has smaller zone capacity than zone size,
+	# enable zonemode=zbd to have fio handle the zone capacity limit.
+	if ((ZONE_CAPS[zone_idx] != ZONE_LENGTHS[zone_idx])); then
+		zbdmode="--zonemode=zbd"
+	fi
+
 	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
 
 	_test_dev_queue_set scheduler deadline
@@ -45,10 +51,9 @@ test_device() {
 	FIO_PERF_FIELDS=("write io" "write iops")
 	_fio_perf --filename="${TEST_DEV}" --name zbdwo --rw=write --direct=1 \
 		  --ioengine=libaio --iodepth=128 --bs=256k \
-		  --offset="${offset}"
+		  --offset="${offset}" ${zbdmode}
 
 	_put_blkzone_report
-	_put_sysfs_variable
 
 	echo "Test complete"
 }
-- 
2.26.2

