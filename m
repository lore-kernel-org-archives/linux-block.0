Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD90C34026
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110F22B48
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N4r3opbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBRR3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:29:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15390 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 12:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582046946; x=1613582946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJ7i0rEGmDdG/KotE2lMQ4FxHy3uyDFPZA5C2RNJXu4=;
  b=N4r3opbrGagUTO9dkMoY6cKteLE/is6wgwbLGRn0e4O9vjrC+XBuWlfC
   FNieNE2Ug+1+g+JE+n692cQN0FqV2WsM9B84lMqCtLXOjOP4iHFCwLH3r
   NC+ryYATWLYQ5jwR3Qi1lvWjsC02TapoH8gIQx1V00SIXyLHuULejCPQF
   w0sOE0gS3bhJYZP1Mm65hfS23EqWZ1BVWMeUd3KHAeVQxlj+xJ7raLV1h
   o+SxZ4qtqYP+CN3tXv8NnReMwUWmGkN4wp7oLcxFj5Jabekl08fQO2C4L
   D1KxCaI023l4V8Hps7fy8kXk2BO9quufE/LWiIIrZxryK+hHiTL3RZ0jw
   g==;
IronPort-SDR: nJF1BGeDPaHXI67jh+NSqJGYr06OQGTDrluCwabekG5mUNTuUOKsJk9vmB4yoZ0wyIyT/oRtPa
 uw7lxF6vZ+Rq9ykKPEUmJ2AAFydg0uJlObKLodUlhui/a+/Hp44ShKw2xr88X+PaMXZ68jMbQo
 eONdNVuQ/WfVUL2ddWWCIgQ2+KWOC9XGQbnw0aZ2yB/w9lAFknvCsKTbgUr+QkrFjTo0YoW6eJ
 r+iTnl/AtcTCU6sMZeuQCtpT3J6tekHJWlDc5W5t+5qYxcpLNv2GrF5qeGmGyQOBfZIBNUtEjP
 pGs=
X-IronPort-AV: E=Sophos;i="5.70,456,1574092800"; 
   d="scan'208";a="130638281"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 01:29:03 +0800
IronPort-SDR: QXrJ2lCIn7d+vc/dhoqLE/mjgtbRI00QI8jomSzTWKvW6RuYwGnaEawkpOP/Rynsw/lzK0GTC7
 1/ZnQiS0kq6scOT8xJySS1ObMUVLAVGgWIbCvvQSjIcc2cMlAIU8fi+JXkAYqlYcXYKR5l0zDP
 +wfRUOCKPO1iso4NRIwWT6IaiJCRiV5uXjDf38l16Wz8WHHdc7W0JgZOhTxC17RHgEfIZm1dTo
 6p0yoYnXgUIB5/+OnZETGPBBUppbKdOmsNE9RLxszkGxgqyQluxkQh1mJsoT6hHwWuH1Zh1kI7
 3/aF1M0J1UiKv78Ewp2SNAeK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:21:41 -0800
IronPort-SDR: KHfJ0TBlNsthanmot7Beu/Z02SM1k1+OFA3D2vAKLw73F9iAMOx6L+j4Ie3tALL6z0YHDeWR9m
 WKNXhKQYduAAHUw7I8A6b4BWfs5jS+B84h2VwSh9F0SLs6GEZGYKDX+3+NIX8tJr95mSx5547N
 RJxGdR1bnP3lPxuIpT3Q6mfTFUv7b+oCv+M+Lbj7IfHASoqkjx2U+NVj4zge65Oi6z41/STNtZ
 6Vku7ozl1Ml/XoCRCGQLDdlYs06+0QsnOPdkFOghN42142+P4vXJzRRCVK6yafz5/0tG8L6tmt
 32I=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 09:29:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     damien.lemoal@wdc.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/3] null_blk: add trace in null_blk_zoned.c
Date:   Tue, 18 Feb 2020 09:28:40 -0800
Message-Id: <20200218172840.4097-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the help of previously added tracepoints we can now trace
report-zones, zone-write and zone-mgmt ops in null_blk_zoned.c.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_zoned.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index ed34785dd64b..673618d8222a 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -2,6 +2,9 @@
 #include <linux/vmalloc.h>
 #include "null_blk.h"
 
+#define CREATE_TRACE_POINTS
+#include "null_blk_trace.h"
+
 /* zone_size in MBs to sectors. */
 #define ZONE_SIZE_SHIFT		11
 
@@ -80,6 +83,8 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 		return 0;
 
 	nr_zones = min(nr_zones, dev->nr_zones - first_zone);
+	trace_nullb_report_zones(nullb, nr_zones);
+
 	for (i = 0; i < nr_zones; i++) {
 		/*
 		 * Stacked DM target drivers will remap the zone information by
@@ -148,6 +153,8 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		/* Invalid zone condition */
 		return BLK_STS_IOERR;
 	}
+
+	trace_nullb_zone_op(cmd, zno, zone->cond);
 	return BLK_STS_OK;
 }
 
@@ -155,7 +162,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 				   sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
+	unsigned int zone_no = null_zone_no(dev, sector);
+	struct blk_zone *zone = &dev->zones[zone_no];
 	size_t i;
 
 	switch (op) {
@@ -203,6 +211,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	default:
 		return BLK_STS_NOTSUPP;
 	}
+
+	trace_nullb_zone_op(cmd, zone_no, zone->cond);
 	return BLK_STS_OK;
 }
 
-- 
2.22.1

