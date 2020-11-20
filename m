Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15DAC63798
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3949B22255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PMYZB9UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgKTBzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6553 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgKTBzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837341; x=1637373341;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=B/NkrmS6S2vXNAmi2wSNbc75GLIMf9m34of4fI/U8sg=;
  b=PMYZB9UDpnquO9q2GnT7keRUHmtOQ/NlxVsfB+Ht6vdFPBp/MNOPEyw7
   jRkjVdNRYRou9inMOv+otailA4N7rU0Bz68+JG1B5RXemql/J0jVBBluN
   0Vj4N5PGgxk2BX/xi9H5Owta2NEXusgwM0id4FarJf5v564e+zii5P01m
   Z/WakxAhbj+r1tjPJ7sSuD/6+btUHWszcXcxoZkqD24wJ43pcLYRfgh1r
   ipdVkybklSak22/zoPyAZh/OAFPIsITyudTuHNJSGSueZDz4AC3X+hi+t
   Ru8q3o5rt4RQvMkdpOk1/EkQNyOED2kJr9pyya/iTMX10lg+L9bMa8zi/
   w==;
IronPort-SDR: bmM6X3ToJRdyjtyTiX+Njau6ftGUFVHZc5YCTMReJ17jqxHsU5Q4n9t4Ly7gX/TBHnTR0AIOwZ
 qJYW+5qc050LSFQ8fQGcePKUaoINJvCC1StgFurbmm2Hk6L295cGSRDqNRC4MQuptmlU+VZhBO
 OnPaZNqEivwI9+prBWnTCELbpZyZAHzxAJO4TAeWAz+5xFLs5hs8rOIxU22sRfu7m2cSflYkV5
 lDw/ws2KO2trFFr3HMGpi6SzLqezfhkIIx8Y/NHr6JzppTo/zKr57eyRgTubMzCovYge78cwq0
 qOc=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516399"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:41 +0800
IronPort-SDR: 7hqa4JuF9aa58kxPLb7TLMlmkIVTpCkGphwO7IQIA/93rOaKVA55Fce+LQWWyVZPfD+HbQYnBq
 vN9tqyOUziWq8yP7xgkPWv/PoOPUYsSix7StOpA/HSMzflPMEStB/hPfWmt/QVK++R7vyznf0d
 rqSrqwfSSRaJmzQsF/mlE8zg3Q/rYtDDk9p751Gzp0WLTSeb8zySLJ1Dy/c7dnWyoKXCEjak5C
 4oLHUjHSPKekVwb/6uB6oW8qf6wsIyuJLYKrb+i3l1mkEBGI6pNIeoR4fszHPg01eiA2kTnunZ
 Ax0kwZWVOFaVw5W1qTOAHnEW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:31 -0800
IronPort-SDR: JI0zDegYvulBj+85xemEc0E6AIQ0g/lRKOfYMGpu10xKcOBrwybWRibfcxBwWz9KAykcMYV+2o
 BPebqhjuF84qeUEOyk7MMAs/0EI1NUp+Av9BpRQu9VmZrn+Dxrs/rfgcLFei3hP/Em+w0++U/a
 RhjvpWiOa1m7vJw56a0+iBoO4Rcmw2MmT1UMbwtNF4yqrqk9qZQVYZOtOMN1I9PkY1wEbLqLc9
 F5xNd3BywHsYnP2U5XAknhcxbMTkS36/FQyPM1Y7y+IcoBnRO+Bpf0+DR3H2/cYb7/+pKeY3Wr
 beI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:41 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 1/9] null_blk: Fix zone size initialization
Date:   Fri, 20 Nov 2020 10:55:11 +0900
Message-Id: <20201120015519.276820-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
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
2.28.0

