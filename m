Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E881C55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175202074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MpXEx5IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKNAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32526 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKNAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099653; x=1636635653;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9qFucpkNIESU4Lx+66q5XvnOPY7JzlNKI8S9eoBvN8k=;
  b=MpXEx5IRA3LtlKOis4FkVGq2ozbE3OFDmmjVrfNukU/5eMdRvbK+gT0F
   9lrtTDtuiA5EdnV2/tkY9bKNDwqQwkSGL8LulCrkPVBV/ntdTJDL+c8q9
   Ux6u6pT9lD3t+5jSujpSKoxfFJ0E/aneoXIEI+7FgDZ9NrekNAzQaq5t+
   tGnGuby6aQqoif497Qq7vyC8YnttVqln5BpmO//DtRPBuvA1+xSctVgo/
   GRs3S9VqPz30R+mg4Iyqa+ej6fDUUwcgVLmsrUOLhviWJhCSBwf9DkK/Q
   aWyQsBxhPgPx8Ovbpj5rVyxcZ9FtSFEtV9IQ4foaBch79QxsVab1FIsrs
   Q==;
IronPort-SDR: RwQuUKX5AZpkGLrVuWPbydnFV6OxDmJ9M1LVUL+O/oylA/mHQsEJV0Y52n7TliJH6OegSqfn0l
 P3n186r2tnmttY9TDyEbxwr4KOO+QBeiFOUFPEvNxTwAI+YLZ8R7CFwJ1feZWPR6BxdKM6905v
 JPzbZaIrkG7Xuyfb1wkzfXOdrzdQmnFwuL1DeH7iEatYehWR+arxgQGjHX6szMYlqRi6Ez0+ix
 UafyoMIwNbKj48vFxYUmLb9soGfbCs17cc5l6T6mDMnL+uPjM6WYgtwCXjUAo7GSQzTin+FZLL
 Z90=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283535"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:52 +0800
IronPort-SDR: UuwUZihHI6Wpgyb4L41b2bbcl3rvoxTZkvxMqYzee5SCUnN8yZ5OhkEk8QWRMYSkYLGF4y+ZSM
 k4rZasJg9p6Z5OyQXL4zYvbTHAFfNKGDk9gHlXP7eY9/UvNJcmGJMBhhZUQJ6V0d5tk0eUrfNk
 2CEDfD3FQkihdpJ2nGrJJh+Tc1rnwiSOOOBW4iPpyNpUgCVKz1HrPabXM4vJiUHussm336wpEN
 xs2yjTzmRvmeuNJT1eKHSsTZ9fKF+cYYxZVK4GMC93lwuuNDjXGmHh/LYnD1ZEVxXbXw7/0BxF
 /rnV/rJSeLxjiOjMJeIfDt9D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:35 -0800
IronPort-SDR: qs1aCjIzbuc8feLkhcANqHaVR/NvibTt2ibKjZ/yEb89jv/a5c5yfZlhrBPWojTUJJNWYIGwsh
 d3defz3NKwkm+ycI8xevH84wylgQD7Nxd6CxIiNiVKZuB96VP19jQ3UuPkWqNC47qWTnQfrf7V
 qQyXlE2lefFvdtGyAQvh7bjpVysio2EZ+UuEbFNT0C1T9XbDBuEplkh7E51vtwaXGINyQxOdL4
 aCWn7/nE/vHAeYgpmr21iH8dJYWiW1gwvKlrB4oMJXh5X+RVR1Mhs20f5146DAG873YbAjCntr
 X54=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:53 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 1/9] null_blk: Fix zone size initialization
Date:   Wed, 11 Nov 2020 22:00:41 +0900
Message-Id: <20201111130049.967902-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

