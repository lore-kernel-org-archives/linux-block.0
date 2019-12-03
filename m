Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49FC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AA7206EC
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RFsKgDin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLCJjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RjkKQQ/mXkTYLtebs6OoUCV7VmMshyQCN5LWNpnBdyI=; b=RFsKgDin7hUcshEKb+ghGRUCZC
        Pz5vwlemoxjUpKzEQIXQA0pO57kCtwnKl0pKVAsqGYRsAhR03eJ5yrilK4+nVPFReR4kl9G+n4Z+K
        qHeP5K+5vJ4kd2zAAUI89DFb+fuuVuwDTAK1esqLBIXDsXqANBiPP5kn3lQRveEY7cokm6X1/9c8t
        nW0Z+EiYzvbF73gHLqAge9omjBHUxDfUGMxTCZO+Mnbj1unquMIn/EtuFSH5HPOMi7f4bqURRcRsy
        aNIKoYdWX2jQSJcco6whdovezZZ+mGyrIcWkzpGdyJeIVj4Xr7ZOqOM5s+qeunLGE88S9O/xMeD4n
        UncwQN9g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eQ-00028j-7h; Tue, 03 Dec 2019 09:39:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 5/8] block: replace seq_zones_bitmap with conv_zones_bitmap
Date:   Tue,  3 Dec 2019 10:39:05 +0100
Message-Id: <20191203093908.24612-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
References: <20191203093908.24612-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Invert the meaning of seq_zones_bitmap by keeping a bitmap of
conventional zones.  This allows not having a bitmap for devices
that do not have conventional zones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c      | 18 +++++++++---------
 include/linux/blkdev.h | 14 ++++++++------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 65a9bdc9fe27..9c3931051f4f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -332,15 +332,15 @@ static inline unsigned long *blk_alloc_zone_bitmap(int node,
 
 void blk_queue_free_zone_bitmaps(struct request_queue *q)
 {
-	kfree(q->seq_zones_bitmap);
-	q->seq_zones_bitmap = NULL;
+	kfree(q->conv_zones_bitmap);
+	q->conv_zones_bitmap = NULL;
 	kfree(q->seq_zones_wlock);
 	q->seq_zones_wlock = NULL;
 }
 
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
-	unsigned long	*seq_zones_bitmap;
+	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
 	sector_t	sector;
 };
@@ -394,8 +394,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
-	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
-		set_bit(idx, args->seq_zones_bitmap);
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		set_bit(idx, args->conv_zones_bitmap);
 
 	args->sector += zone->len;
 	return 0;
@@ -415,8 +415,8 @@ static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
 	args->seq_zones_wlock = blk_alloc_zone_bitmap(q->node, nr_zones);
 	if (!args->seq_zones_wlock)
 		return -ENOMEM;
-	args->seq_zones_bitmap = blk_alloc_zone_bitmap(q->node, nr_zones);
-	if (!args->seq_zones_bitmap)
+	args->conv_zones_bitmap = blk_alloc_zone_bitmap(q->node, nr_zones);
+	if (!args->conv_zones_bitmap)
 		return -ENOMEM;
 
 	ret = disk->fops->report_zones(disk, 0, nr_zones,
@@ -465,7 +465,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (ret >= 0) {
 		q->nr_zones = nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
-		swap(q->seq_zones_bitmap, args.seq_zones_bitmap);
+		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
@@ -474,7 +474,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	blk_mq_unfreeze_queue(q);
 
 	kfree(args.seq_zones_wlock);
-	kfree(args.seq_zones_bitmap);
+	kfree(args.conv_zones_bitmap);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c5852de402b6..503c4d4c5884 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -503,9 +503,9 @@ struct request_queue {
 	/*
 	 * Zoned block device information for request dispatch control.
 	 * nr_zones is the total number of zones of the device. This is always
-	 * 0 for regular block devices. seq_zones_bitmap is a bitmap of nr_zones
-	 * bits which indicates if a zone is conventional (bit clear) or
-	 * sequential (bit set). seq_zones_wlock is a bitmap of nr_zones
+	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
+	 * bits which indicates if a zone is conventional (bit set) or
+	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
 	 * bits which indicates if a zone is write locked, that is, if a write
 	 * request targeting the zone was dispatched. All three fields are
 	 * initialized by the low level device driver (e.g. scsi/sd.c).
@@ -518,7 +518,7 @@ struct request_queue {
 	 * blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
-	unsigned long		*seq_zones_bitmap;
+	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -723,9 +723,11 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
 					 sector_t sector)
 {
-	if (!blk_queue_is_zoned(q) || !q->seq_zones_bitmap)
+	if (!blk_queue_is_zoned(q))
 		return false;
-	return test_bit(blk_queue_zone_no(q, sector), q->seq_zones_bitmap);
+	if (!q->conv_zones_bitmap)
+		return true;
+	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
-- 
2.20.1

