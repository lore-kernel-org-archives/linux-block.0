Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D7C55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08FF20729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UrAycymQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgKKFQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43928 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKFQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071812; x=1636607812;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PKMMRUU9vYzHfv4nwkDX8jarpnBsCQGZ/fU3l0xt8Fk=;
  b=UrAycymQ3z99iBjJbte3bi9quFQpFv9yc0E5Rq21MIqMojw42b0gnGzB
   a1MN7uK6j+zB6FhK03yOiq4JwfhT/vBvFPQFpcQ+BzU0/9+1Y8tFTKXFX
   cx/8J5xnr+MLmwBr6BTkmvo3VMp0gvqG/kIUWNNJPicj7GX4QiJPTMYBb
   X/rnJx+bB/BDHRARjyonW9+yTfFYjWPbcIh9SM21Q+qq63y8SSja/TaRr
   3vIwQFWvUISZ8lgo3B23CMIRNcqf0FgrHwjRAQUQZOuMuOvwbVE7IrTK3
   AJq8X8s+NaWr5zQ2QY2ZLHX3vHciQ3lpulHfgMy26qvWngSzbrMF1hb96
   Q==;
IronPort-SDR: ERJIxLONaFWPp9psoK7LnyjlchNv20RrfM2U48fHCpBvS63stgpuGEdJcv85UfyB2JH3FmtJWf
 9m3r8n2mdFsFvQAxiosHtKXbcJGiBjpwklJdA8IuOxiJdNQmSYbC7VwtD0y5y9PyC41S0nq+5M
 u6xnI4CEv/D7seiOilSUeSlfsV+kTzflDgXgTvF4NLXUrc1Bs00oKns5xNAmjPpBCuebegPaVx
 hOPFOWvhhXjCKD2X3RDpWZkImTZ4ZGbhJ+i6dFgFssxG6GkxxbgvSD/EgPXF1h5tVSwzxFbEJG
 jbw=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254625"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:51 +0800
IronPort-SDR: EM2uzdqI/rxw1SBJbxFvxG7Te5IjK+59nh3x4sCG2zInV8irRWepqYNw2/0q4DKSyxpzQUiR5N
 u7ll4dRL+DUUxRydapmc2FflofxGuFKjRjHUugHv9+8g8m/GDlocbkkceBtpYIHkvfWu77CYwr
 +d75NbPaXawKyb6WWC7gBBRbrkXsm3YLE24jWRhGSAHg+H3ZRKl1lXkH9cY6dYngHmVK+dmcQa
 U1ocbr0yLZncvB2s3wlXvb7d6ZVWBybPu1FQPRXp5qtsvBIao2Kr6noahgeMZdz3Xam9kl8EeZ
 qqM49lYwIAgTGWgTok1uHffj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:38 -0800
IronPort-SDR: jFkxlsc67ig6dc6maMjzGftxd1UiHdcyuKahsyfw9SvKIasm8XT4+k7ShfbOz1FPRZJ/Wmq2HB
 yxAInFAzWuNCFqD+2qbLgUwtbGOK1xr3DQdG+yh1+XFaOlHN3G53KAhEos7yQGKXnqZGX5udno
 tOkeAL3JrE77KmdPd/o6srOj1g9AN+Wb6angKBcv9APAc3qPFy66bwj1TzuiwT9jyFKuxrEB7r
 k1Gqc5csdX2J7p1UvuDZg6aQnvD8htvf/SvxXRHLBlc4Ho0/MMrgkd1HPndwGvxnkAo9s8ZbsC
 gwk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:51 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 1/9] null_blk: Fix zone size initialization
Date:   Wed, 11 Nov 2020 14:16:40 +0900
Message-Id: <20201111051648.635300-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a null_blk device with zoned mode enabled is currently initialized
with a number of zones equal to the device capacity divided by the zone
size, without considering if the device capacity is a multiple of the
zone size. If the zone size is not a divisor of the capacity, the zones
end up not covering the entire capacity, potentially resulting is out
of bounds accesses to the zone array.

Fix this by adding one last smaller zone with a size equal to the
remainder of the disk capacity divided by the zone size if the capacity
is not a multiple of the zone size. For such smaller last zone, the zone
capacity is also checked so that it does not exceed the smaller zone
size.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Fixes: ca4b2a011948 ("null_blk: add zone support")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_zoned.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index beb34b4f76b0..1d0370d91fe7 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -6,8 +6,7 @@
 #define CREATE_TRACE_POINTS
 #include "null_blk_trace.h"
 
-/* zone_size in MBs to sectors. */
-#define ZONE_SIZE_SHIFT		11
+#define MB_TO_SECTS(mb) (((sector_t)mb * SZ_1M) >> SECTOR_SHIFT)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
@@ -16,7 +15,7 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 
 int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 {
-	sector_t dev_size = (sector_t)dev->size * 1024 * 1024;
+	sector_t dev_capacity_sects, zone_capacity_sects;
 	sector_t sector = 0;
 	unsigned int i;
 
@@ -38,9 +37,13 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
-	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
-	dev->nr_zones = dev_size >>
-				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
+	zone_capacity_sects = MB_TO_SECTS(dev->zone_capacity);
+	dev_capacity_sects = MB_TO_SECTS(dev->size);
+	dev->zone_size_sects = MB_TO_SECTS(dev->zone_size);
+	dev->nr_zones = dev_capacity_sects >> ilog2(dev->zone_size_sects);
+	if (dev_capacity_sects & (dev->zone_size_sects - 1))
+		dev->nr_zones++;
+
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
 			GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
@@ -101,8 +104,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		struct blk_zone *zone = &dev->zones[i];
 
 		zone->start = zone->wp = sector;
-		zone->len = dev->zone_size_sects;
-		zone->capacity = dev->zone_capacity << ZONE_SIZE_SHIFT;
+		if (zone->start + dev->zone_size_sects > dev_capacity_sects)
+			zone->len = dev_capacity_sects - zone->start;
+		else
+			zone->len = dev->zone_size_sects;
+		zone->capacity =
+			min_t(sector_t, zone->len, zone_capacity_sects);
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
-- 
2.26.2

