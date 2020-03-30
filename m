Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B051C43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 04:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB4C20732
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 04:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tqk/berR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgC3EBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:01:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56281 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3EBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 00:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585540880; x=1617076880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtI1iEeEBIkXq425hB9bdXSpjpZ1sLvPGB1Z6pMV02g=;
  b=Tqk/berRsisrFrdlK4jnBb4iqEjUOxNfkOlvMvmUw9IRDJduxCl41QTR
   t1FRcfzU8/XPz7bHHpOf57MCQLG78D5LSDTyAWNhldEiIlH6LA9fye80W
   pXep/4nvVESU+uC6ZyjEnPNKMqqD3LdrQ5m4aNANiKxo/LDzBDMWEaXJD
   u6/sF/FkzLb9dirqYKYlTCXOpyDcIDO+OoQHuN0AzhxM+CPDDX3EFBw19
   5Q54IEpIDAcVHjbAqe11YnkJtCnWaHS8az69EBpkpT3AzYeX+kjQEMyP2
   WrhEA2pK9UqBE2fpuiPIYSJYwvN2QCt1TGXl6icRy2Rjn4pD7IL5IbsKw
   Q==;
IronPort-SDR: PX+pjD3JT9fT1bjj3HrEQuGN0XJCXBgPxq3s/dQ7MgHbbS2u9AR9Tzd/OtQvVg35sCKsioZHpv
 fSa9XnH6XsFo7TyqyR1r/tkbdr8RRHdi8IRhDuW7uPByGsLzrfzYeRpRchp9k0EwZ+R7inNELt
 W1tIZLSHa79AEFyVusQzGvhQDgyOdhP8angxDLvFjh+AAE7aJJIw9OQ/QRMhT+hv30RiXqH+ZO
 XuNp59u3F/UWZmnUrkLhk8xgItpXpiQw8naoJrElOjrA1cr+VwQGJ0zkCzMmu95lxNeJkwveAX
 VYY=
X-IronPort-AV: E=Sophos;i="5.72,322,1580745600"; 
   d="scan'208";a="242386355"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 12:01:19 +0800
IronPort-SDR: HKcZ+NFfnkpOXQC5b7c2KLadFdb/tnLEn7Fh2e2RGHg8j9c1YWtvNSxWNO+O+mBHxWUJGIRS2z
 cqluVuEeB1eAdGrXrexqUalQWBOiTsikJ7sFCpO2VVt6CKydDeCIwdYqtT2E9ga8liRHA9GfNQ
 hBjzCycnzM16zUI1OZKIGUggi391xkJCmANAYaYxAPuxSRswGCkR5Zs9rQff1AyNrb3qbZ1+hP
 Eqz8iN4n8+U60P1f2hytts7G44lusn4WTk64akjNa1lGxqG0bMkhCKRNrRHF/6lj9bMY6dZwix
 m50QJJQhagzOlArtUe3n6Yt3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 20:52:16 -0700
IronPort-SDR: Y22P5BGtvD5lQT8MJGbChMLtUNyJR0SdpLGFdu4E4p2WFJ6mKg745cuVpVpVPVrRBJtrAfHg4d
 B3Z3ANbcB8XlcVC/QrCvftaPy/H4G3V++Qmbj2WdOyjUjmMGsBOqZIS5X3OXfdYASt908gqVbi
 ciRepJkSSMo0N3hMbvE3eJ8GqvFd0NX9c4TblIdKOcPuDEsX/qIESFQxhQsHvy22OXvoJKbWMn
 r6BgNxqE618NLn38MROjidXu8qb8+M+ke9Nsn8Dq9nYd4S2/lccyeo26PdNDYAAZLz6eTx7OBI
 IUg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 21:01:18 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] null_blk: Cleanup zoned device initialization
Date:   Mon, 30 Mar 2020 13:01:15 +0900
Message-Id: <20200330040116.178731-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330040116.178731-1-damien.lemoal@wdc.com>
References: <20200330040116.178731-1-damien.lemoal@wdc.com>
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
---
 drivers/block/null_blk.h       | 14 ++++++++++----
 drivers/block/null_blk_main.c  | 27 +++++++--------------------
 drivers/block/null_blk_zoned.c | 21 +++++++++++++++++++--
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 62b660821dbc..2874463f1d42 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -86,8 +86,9 @@ struct nullb {
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
-int null_zone_init(struct nullb_device *dev);
-void null_zone_exit(struct nullb_device *dev);
+int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q);
+int null_register_zoned_dev(struct nullb *nullb);
+void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
 blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
@@ -96,12 +97,17 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
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
 static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 					     enum req_opf op, sector_t sector,
 					     sector_t nr_sectors)
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 5f13793d35ee..60f09fac6404 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -573,7 +573,7 @@ static void null_free_dev(struct nullb_device *dev)
 	if (!dev)
 		return;
 
-	null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
@@ -1596,19 +1596,12 @@ static int null_gendisk_register(struct nullb *nullb)
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
@@ -1764,14 +1757,9 @@ static int null_add_dev(struct nullb_device *dev)
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
@@ -1800,8 +1788,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	return 0;
 out_cleanup_zone:
-	if (dev->zoned)
-		null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index ed34785dd64b..8259f3212a28 100644
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

