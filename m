Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D9CC4741F
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAB520684
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nlMJaraq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgKIMvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43848 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIMvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926276; x=1636462276;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Gs91s4H9n0Om7t/enpIZtfjgR6t6tdaBBQzqDFdHcec=;
  b=nlMJaraq4vYXk+F5ObBlme8YTJbVV41mzmJXgdS7nUvhkfFWI8XRc57v
   ZPZ9x3BF/k8EX+aqzaMF6thv36WfB/MW+yetKYFmrvbAbRoeBtqY9w4UU
   Ao6I8KdI60Jep95daMshzDGmTaoAec2/IuOWCnd2VhDvP/K8aGYop2XgH
   GEs3FEh0wrRuesy3jmSi75by45SukGJZCw5jH9ZVNTGa0GFqFW0gZbHXv
   AmmViKDPtSng9H6ME8psYR9jPns59EeIV3dv2cGpCAJRFjhfngXIuC/R2
   uKUfUHVEDu16l86crjUaXEZvP71GjH8B+CiwBtkuteO/VCFGGkWSieqsh
   A==;
IronPort-SDR: 5FhWByMkcdKjGc86z2pAmBqP9NzY+c1F1BdafH6pYAQhutDpjquvWgdrOmneorVl/IgIKshSsz
 jfh9zucGZh3+6HXcxxkZf1QEDi6NU6N02g84aous89GqzXXihyHrozcdxv9qVUTr6IB1oG5Kcs
 2jUaf1m6Jczp7rkTYffdOg2Ginb+37oDq7uMRn5dQYheRLLQXV8Pmsgmy/6s/xSbtw//oqVPWm
 xe9qNfJmz9SGGv2fXvE2tAr0KyeFJagjDnrXWqn6tUjLtOM78cKpZziv2RrQtexrFFG0xvoqwY
 J9Y=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668397"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:09 +0800
IronPort-SDR: 7Xr9ECur7IybXBQoYbY4wT7BYzs+Q++Qmq1iQc0JKVAKhAmPN+K9a5uLeLSge7OLJrj5AXNDFr
 Gyq/lfYw+xNQMMiIhv6sCyx0k1EVgt2uVAEd4iC7xtRAtDw5HGPP9X40sV6ZhlvY3uAMrNsEbl
 40STqTJQAQGXEnRFFN5vnlkNrMSYNBpC62HCxSyTtmk/Wot3h50MYVtjASh2OvvIQ76sgYn7YC
 2K/c+11mWWlHbxGeo1rW9vcXt6vkXuiqqhf/gHPMgrB76PNtz59Do3Tnzxc5ruxWeRPrRBv8ZX
 ySwr9FPsO+cuYtwoh+uIutJv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:11 -0800
IronPort-SDR: Cd7BY1YjA9p/r+0TuewdZgVD0xyyfUWnYlkD++a+gMoxhmtwmVVqlCXg6uaHJ3LckJgA7lgZ1M
 DsA7CBtlKiSRCxwtbokaAAGCWesNhV2uaWX9z30p3DoEtko17MiUywIlW7zf8Hn95NigkaLspo
 3sw/kr8qHc8duVETfdEmyvcJUJozt9fsZPTB+Lx7V1nIw6rUUnLLZAcWQ9vrG8gp+9Aes9jrLO
 I1WIF5OtF2SgY10FS1R2T9eHZniyBJyioVPhWFDZjT/0bWKO+9mABRpSo6b9Fdds0XOcL2GMJQ
 Ju0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:09 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] null_blk: Fix zone size initialization
Date:   Mon,  9 Nov 2020 21:51:00 +0900
Message-Id: <20201109125105.551734-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109125105.551734-1-damien.lemoal@wdc.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All zones of a zoned null_blk device are currently initialized with the
same size. However, if the specified size (capacity) of the null_blk
device is not a multiple of the zone size, the last zone becomes too
large and read/write accesses to it can cause out of bound errors.
Fix this by correctly setting the size of the last zone of the device
to the remainder of the disk capacity if this capacity is not a
multiple of the zone size. For such smaller last zone, the zone
capacity is also checked so that it does not exceed the smaller zone
size.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_zoned.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index beb34b4f76b0..18911e67f792 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -16,7 +16,7 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 
 int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 {
-	sector_t dev_size = (sector_t)dev->size * 1024 * 1024;
+	sector_t dev_capacity, zone_capacity;
 	sector_t sector = 0;
 	unsigned int i;
 
@@ -38,9 +38,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
+	zone_capacity = dev->zone_capacity << ZONE_SIZE_SHIFT;
+	dev_capacity = ((sector_t)dev->size * SZ_1M) >> SECTOR_SHIFT;
+
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
-	dev->nr_zones = dev_size >>
-				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
+	dev->nr_zones = dev_capacity >> ilog2(dev->zone_size_sects);
+	if (dev_capacity & (dev->zone_size_sects - 1))
+		dev->nr_zones++;
+
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
 			GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
@@ -101,8 +106,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		struct blk_zone *zone = &dev->zones[i];
 
 		zone->start = zone->wp = sector;
-		zone->len = dev->zone_size_sects;
-		zone->capacity = dev->zone_capacity << ZONE_SIZE_SHIFT;
+		if (zone->start + dev->zone_size_sects > dev_capacity)
+			zone->len = dev_capacity - zone->start;
+		else
+			zone->len = dev->zone_size_sects;
+		zone->capacity =
+			min_t(sector_t, zone->len, zone_capacity);
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
-- 
2.26.2

