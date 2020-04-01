Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73188C2D0F3
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1022063A
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L2raqgeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgDABHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:07:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16250 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbgDABHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585703252; x=1617239252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hb+Jc8CP5Kai856e/U8+rKR+2r5DeEhrjs2bnX2lymU=;
  b=L2raqgeWi5xMhTMMwOOKRk4Uf3sHsxamI3WX+GbZovOHQiH3i5UfU0Xp
   u5XG5/JLZrO7V5Gr8aYVwXs9C2fqGRHbD3L82A98lFrOYooAug0GOB0ne
   h4EXQk35lEk/oEc3TjMH8kBWDwIF7y/H/LTkhuzoyoPjz9LUkAH9Z5ZDl
   kdNKdjD4uPEQIZD+rZNI5/OLEQ5AKZMIWuR6RT9HOFmdBHd2OS8qtCSGY
   gaVhwYgb7sVN0DozP59KeYH4xYQXHV12GozAtqQHVkPXtbkbSh+z6mIXe
   Au0qLQwfes8BqIJ/x5SdNliBsVUH+8Z4/rKjRRnLLzSSGxdhpcFe0MQyx
   Q==;
IronPort-SDR: q+8IUzGxmCG5KfmXCacdUdxHA1N8r0u5BM6vbNFx/uqno7PPUaKd7CfXai5iqjCRPa5XHfySO0
 AfNFl5KKw4avxItE2VvJN66DCchMOEr8Y4YVb3MPHQ0IsGPhXAJ6opup++QrQPiFyUVDUv/71x
 P6i84p0XUhRofGToYkq+QQWXsQM5/WxxLr4UThlXvDOf2XXyoG0W/tXexA6J7K/joglMaj7Wzd
 dILryd45Ha4k4v8gjrQ1AsRx7rnR71pEBjfCxLb9FQtrSbEpL6KpbR9SUaAOftiaDsvcoBmj8P
 uRM=
X-IronPort-AV: E=Sophos;i="5.72,329,1580745600"; 
   d="scan'208";a="134531020"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 09:07:32 +0800
IronPort-SDR: 4DFVvEloqKDCLXw6gSMUY4UNcwzzp6LfiWzFUc9RGNWtzu8iYNGAw+URMjlhKh1OhXAE+EOiqW
 UALECiXdbQGXMQvthb2JNZYnmrtNCJDGIHLWPrnmMuBW2hKrayOKfWnN88qj6ebyHlT2/ZRPa4
 vQC+LG+/+qYzY7bgvnwSq796hB5BUqVrp9LKCh8s48k/SnzzVZIkBB/dQ3DXC7UA1VRSjjHbGm
 MBTG+0EjK1hY83f/j/TciZi6wC6FtpwIkomTz9X1AxJrHJKkKTbWneAWHm1pQDNjcrlWWRowHr
 9fnV12fWFbmmWO1TkhZzBm6K
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 17:58:25 -0700
IronPort-SDR: y4gmb1u5QNjkVnWBuPwnYxDi8uL4zP+TTS/AOWWTMfBLa7vmKANpAfd/0Qnt9E3v7M/BIzciHw
 O20/2kHotTNaPilDarvhgUYzy2wpMVhLEcztneDTz1FeKRn0HmSOCbm9lG9TTIxEesQ+f63lTm
 ClRd+AIdu7SWVJABSOFhSiZwUvy2qMataPeJxc81UhWo9eudWw7tSQHxyKYP9uaMDaETrRdB8l
 LJykbXcp5X0YUg0nUgNM26jMBcO/Q9ABF/bnplV8HbsoxENWuDq4JDkvVb+o97XdhUGbE3PBw8
 BRU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Mar 2020 18:07:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] null_blk: Cleanup zoned device initialization
Date:   Wed,  1 Apr 2020 10:07:28 +0900
Message-Id: <20200401010728.800937-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401010728.800937-1-damien.lemoal@wdc.com>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
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
index 1d8141dfba6e..1004819f5d4a 100644
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
@@ -1808,14 +1801,9 @@ static int null_add_dev(struct nullb_device *dev)
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
@@ -1844,8 +1832,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	return 0;
 out_cleanup_zone:
-	if (dev->zoned)
-		null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 3a50897f3432..185c2a64cb16 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -10,7 +10,7 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
-int null_zone_init(struct nullb_device *dev)
+int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 {
 	sector_t dev_size = (sector_t)dev->size * 1024 * 1024;
 	sector_t sector = 0;
@@ -58,10 +58,27 @@ int null_zone_init(struct nullb_device *dev)
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
2.25.1

