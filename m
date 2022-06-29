Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B920FC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiF2GUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GUW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:20:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB61E3DA
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y3Ev+HwWisnIIGsq+Sd/akN2bB1kNClGcZereSIgQMo=; b=tNz3BkJxyM8JfdoVmLhaMA6IRU
        oI0ifILI775sjFXT80NEdnzUI/2LQfbWAjwRT7Q/T2u0VwJ5iq0Nkh7B5ZF0J7THXQGMYAv1NIVpR
        lnjyWGkLgdH/e/3y0I6EKnjIGBppKfDymqRbOcI7BzmaLkCggrNStiHx19DP+chhaSJjl93enG8gh
        n9vjlIZBCepnD4fy8K9h0OETcB/Nr2AMOFK7oqvtZ8OsQxLGPhtmhWdJ5TIKW95xNR8+K5UUw6EAr
        Itj7wT2QKJJNSvjyO9vvReGMKpPQFo1QKIr+x3HlKIKLewjJvflpAzMKBxV6dqQIzkey5RCrOr/GI
        ELEdtUzA==;
Received: from [2001:4bb8:199:3788:6e38:f996:aa54:7e1e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6R3l-009knP-0L; Wed, 29 Jun 2022 06:20:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: move ->ia_ranges from the request_queue to the gendisk
Date:   Wed, 29 Jun 2022 08:20:12 +0200
Message-Id: <20220629062013.1331068-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220629062013.1331068-1-hch@lst.de>
References: <20220629062013.1331068-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Independent access ranges only matter for file system I/O and are only
valid with a registered gendisk, so move them there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ia-ranges.c  | 18 +++++++++---------
 include/linux/blkdev.h | 12 ++++++------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 47c89e65b57fa..c1bf14bcd15f4 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -106,7 +106,7 @@ static struct kobj_type blk_ia_ranges_ktype = {
  *
  * Register with sysfs a set of independent access ranges for @disk.
  * If @new_iars is not NULL, this set of ranges is registered and the old set
- * specified by q->ia_ranges is unregistered. Otherwise, q->ia_ranges is
+ * specified by disk->ia_ranges is unregistered. Otherwise, disk->ia_ranges is
  * registered if it is not already.
  */
 int disk_register_independent_access_ranges(struct gendisk *disk,
@@ -121,12 +121,12 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
 
 	/* If a new range set is specified, unregister the old one */
 	if (new_iars) {
-		if (q->ia_ranges)
+		if (disk->ia_ranges)
 			disk_unregister_independent_access_ranges(disk);
-		q->ia_ranges = new_iars;
+		disk->ia_ranges = new_iars;
 	}
 
-	iars = q->ia_ranges;
+	iars = disk->ia_ranges;
 	if (!iars)
 		return 0;
 
@@ -138,7 +138,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
 	ret = kobject_init_and_add(&iars->kobj, &blk_ia_ranges_ktype,
 				   &q->kobj, "%s", "independent_access_ranges");
 	if (ret) {
-		q->ia_ranges = NULL;
+		disk->ia_ranges = NULL;
 		kobject_put(&iars->kobj);
 		return ret;
 	}
@@ -164,7 +164,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
 void disk_unregister_independent_access_ranges(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	struct blk_independent_access_ranges *iars = q->ia_ranges;
+	struct blk_independent_access_ranges *iars = disk->ia_ranges;
 	int i;
 
 	lockdep_assert_held(&q->sysfs_dir_lock);
@@ -182,7 +182,7 @@ void disk_unregister_independent_access_ranges(struct gendisk *disk)
 		kfree(iars);
 	}
 
-	q->ia_ranges = NULL;
+	disk->ia_ranges = NULL;
 }
 
 static struct blk_independent_access_range *
@@ -242,7 +242,7 @@ static bool disk_check_ia_ranges(struct gendisk *disk,
 static bool disk_ia_ranges_changed(struct gendisk *disk,
 				   struct blk_independent_access_ranges *new)
 {
-	struct blk_independent_access_ranges *old = disk->queue->ia_ranges;
+	struct blk_independent_access_ranges *old = disk->ia_ranges;
 	int i;
 
 	if (!old)
@@ -331,7 +331,7 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
 	if (blk_queue_registered(q)) {
 		disk_register_independent_access_ranges(disk, iars);
 	} else {
-		swap(q->ia_ranges, iars);
+		swap(disk->ia_ranges, iars);
 		kfree(iars);
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22b12531aeb71..b9a94c53c6cd3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -171,6 +171,12 @@ struct gendisk {
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
 	u64 diskseq;
+
+	/*
+	 * Independent sector access ranges. This is always NULL for
+	 * devices that do not have multiple independent access ranges.
+	 */
+	struct blk_independent_access_ranges *ia_ranges;
 };
 
 static inline bool disk_live(struct gendisk *disk)
@@ -539,12 +545,6 @@ struct request_queue {
 
 	bool			mq_sysfs_init_done;
 
-	/*
-	 * Independent sector access ranges. This is always NULL for
-	 * devices that do not have multiple independent access ranges.
-	 */
-	struct blk_independent_access_ranges *ia_ranges;
-
 	/**
 	 * @srcu: Sleepable RCU. Use as lock when type of the request queue
 	 * is blocking (BLK_MQ_F_BLOCKING). Must be the last member
-- 
2.30.2

