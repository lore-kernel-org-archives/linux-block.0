Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795BC55191
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 03:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AAD20767
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 03:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DJIoFFee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDWDCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:02:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26228 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWDCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 23:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587610962; x=1619146962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+7xGv4S31a2jL1P8xiVKMGr/YSi9vZxPoDU3Q/CEn9U=;
  b=DJIoFFee9eJY7wuT8WwPX6qBYQV7ayVnCmWru0uLDypFSpQFPe8noFb6
   VBunwY9doNiHZLzKctrMboqOxSeXGnjqKtMaf2SVUUHYBzw44hNFhK43r
   1cpsFb4B8zztb73ovbuSDq01n7DtS7gVPe5kBZa+RTMa5DKN7jbikeCXC
   QlOIQ2skPYm8A8Mz+Kk/dTta/JQaBzHwQFKg4//tlgh2D+hrB5TrZkobM
   asU77hLWBRQDga/MRG/BpIz7UGAc+4+7wO+To92CGeCag9wJtFqoP7AGw
   xqBg89LJA4j9DH7WflGjt9svy8G+iyVR6e2WTNxQ6LKoiF9F0oEUVN2GK
   Q==;
IronPort-SDR: tJ1VoITmjZz6a3Ea9PWTq0JTdfb7lulZzahgIhBEO3ey1RXDCnr+AXfEV/sccyFtSgmna/UI0D
 UpSRrP/HwNEH2sQdq2dnsgQxXqTLhMIDZCGNK7fUEIN2JYvHBqZ1Kj1BGJL5JA8vIMbV237hmo
 STKWnzV0jHctaRfiA4BLTNDNVysJNqmsc3TgfwctJktY3lo0jxuXtWTeZmaJi7sYamviScU63y
 v75D9qULGSZU6u5oHSmbgHE0fC/l9yIhGF6xAvYoOwQpEiLXGgyyg6I9lnmIE7cMNib9N+Bpxy
 UR0=
X-IronPort-AV: E=Sophos;i="5.73,305,1583164800"; 
   d="scan'208";a="140292054"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 11:02:41 +0800
IronPort-SDR: h0RddDjrN9MH5P/TZnAd9QP162mLvf7RiamiePe2e9NXCXuAHuorglLoNrebzJQMrQLFTHgmq+
 3oTn0zlFYQvloWph40K+a9bNacSF0HouM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 19:53:30 -0700
IronPort-SDR: +f3lim7PZc51W99mWylrFFOFMKb+PqNyJSQtTVAYF/UFJsaNGoDHW+j01H2qwYVy/8txp45uEc
 zzaMxF0A6Rhw==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Apr 2020 20:02:40 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] null_blk: Cleanup zoned device initialization
Date:   Thu, 23 Apr 2020 12:02:38 +0900
Message-Id: <20200423030238.494843-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423030238.494843-1-damien.lemoal@wdc.com>
References: <20200423030238.494843-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all zoned mode related code from null_blk_main.c to
null_blk_zoned.c, avoiding an ugly #ifdef in the process.
Rename null_zone_init() into null_init_zoned_dev(), null_zone_exit()
into null_free_zoned_dev() and add the new function
null_register_zoned_dev() to finalize the zoned dev setup before
add_disk().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk.h       | 14 ++++++++++----
 drivers/block/null_blk_main.c  | 27 +++++++--------------------
 drivers/block/null_blk_zoned.c | 21 +++++++++++++++++++--
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 83320cbed85b..81b311c9d781 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -90,8 +90,9 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 			      unsigned int nr_sectors);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-int null_zone_init(struct nullb_device *dev);
-void null_zone_exit(struct nullb_device *dev);
+int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q);
+int null_register_zoned_dev(struct nullb *nullb);
+void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
@@ -100,12 +101,17 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
 size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len);
 #else
-static inline int null_zone_init(struct nullb_device *dev)
+static inline int null_init_zoned_dev(struct nullb_device *dev,
+				      struct request_queue *q)
 {
 	pr_err("CONFIG_BLK_DEV_ZONED not enabled\n");
 	return -EINVAL;
 }
-static inline void null_zone_exit(struct nullb_device *dev) {}
+static inline int null_register_zoned_dev(struct nullb *nullb)
+{
+	return -ENODEV;
+}
+static inline void null_free_zoned_dev(struct nullb_device *dev) {}
 static inline blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
 			enum req_opf op, sector_t sector, sector_t nr_sectors)
 {
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 8335e2b04aac..8efd8778e209 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -580,7 +580,7 @@ static void null_free_dev(struct nullb_device *dev)
 	if (!dev)
 		return;
 
-	null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
@@ -1618,19 +1618,12 @@ static int null_gendisk_register(struct nullb *nullb)
 	disk->queue		= nullb->q;
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
-#ifdef CONFIG_BLK_DEV_ZONED
 	if (nullb->dev->zoned) {
-		if (queue_is_mq(nullb->q)) {
-			int ret = blk_revalidate_disk_zones(disk);
-			if (ret)
-				return ret;
-		} else {
-			blk_queue_chunk_sectors(nullb->q,
-					nullb->dev->zone_size_sects);
-			nullb->q->nr_zones = blkdev_nr_zones(disk);
-		}
+		int ret = null_register_zoned_dev(nullb);
+
+		if (ret)
+			return ret;
 	}
-#endif
 
 	add_disk(disk);
 	return 0;
@@ -1786,14 +1779,9 @@ static int null_add_dev(struct nullb_device *dev)
 	}
 
 	if (dev->zoned) {
-		rv = null_zone_init(dev);
+		rv = null_init_zoned_dev(dev, nullb->q);
 		if (rv)
 			goto out_cleanup_blk_queue;
-
-		nullb->q->limits.zoned = BLK_ZONED_HM;
-		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);
-		blk_queue_required_elevator_features(nullb->q,
-						ELEVATOR_F_ZBD_SEQ_WRITE);
 	}
 
 	nullb->q->queuedata = nullb;
@@ -1822,8 +1810,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	return 0;
 out_cleanup_zone:
-	if (dev->zoned)
-		null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 2e9add7d89a4..9e4bcdad1a80 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -13,7 +13,7 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
-int null_zone_init(struct nullb_device *dev)
+int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 {
 	sector_t dev_size = (sector_t)dev->size * 1024 * 1024;
 	sector_t sector = 0;
@@ -61,10 +61,27 @@ int null_zone_init(struct nullb_device *dev)
 		sector += dev->zone_size_sects;
 	}
 
+	q->limits.zoned = BLK_ZONED_HM;
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
+
+	return 0;
+}
+
+int null_register_zoned_dev(struct nullb *nullb)
+{
+	struct request_queue *q = nullb->q;
+
+	if (queue_is_mq(q))
+		return blk_revalidate_disk_zones(nullb->disk);
+
+	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
+	q->nr_zones = blkdev_nr_zones(nullb->disk);
+
 	return 0;
 }
 
-void null_zone_exit(struct nullb_device *dev)
+void null_free_zoned_dev(struct nullb_device *dev)
 {
 	kvfree(dev->zones);
 }
-- 
2.25.3

