Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2227C4338F
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C04460F13
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGYFP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:15:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90831C061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JdjPIQN1aMpI+SU5s1H+dtNE18IeZrMpmR0A+VXAzSc=; b=PR36wRgtYr3wnCsyRw/5Lpd8jx
        Hc4IfY/gJtAqRHBSdiLtjMPrPlJGlcG/PlLMOl2tJW5Cgm9m844solQf5RaEsBxvSxk3jLTdOQWqU
        6xr4OihRHqqT93lFxhQD7erB3weDVs5vyYtjmMabwei4BVNatQ8tUis2xcNViytbdrqnkQ+8tIcPl
        fRd4qNfT3vJfJjmF5ojJ/vapq/o1hrJ/vdN8SM3sDfff5U32zyrTuY2ASDPUIWSJGVFeOU/RBSurk
        41/S69L61gFo/4VsKKlHIQ/YuKmJksfdQuDck085SW54Q+UPt70xt3V58tzGzz6l5hts43kGL8B/M
        K0ju/4ag==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X7A-00Cphh-1i; Sun, 25 Jul 2021 05:56:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: look up holders by bdev
Date:   Sun, 25 Jul 2021 07:54:53 +0200
Message-Id: <20210725055458.29008-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Invert they way the holder relations are tracked.  This very
slightly reduces the memory overhead for partitioned devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c             |  3 +++
 block/holder.c            | 18 +++++++++---------
 fs/block_dev.c            |  3 ---
 include/linux/blk_types.h |  3 ---
 include/linux/genhd.h     |  4 +++-
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..e2708a4a7a47 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1263,6 +1263,9 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
+	INIT_LIST_HEAD(&disk->slave_bdevs);
+#endif
 	return disk;
 
 out_destroy_part_tbl:
diff --git a/block/holder.c b/block/holder.c
index 960654a71342..11e65d99a9fb 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -3,7 +3,7 @@
 
 struct bd_holder_disk {
 	struct list_head	list;
-	struct gendisk		*disk;
+	struct block_device	*bdev;
 	int			refcnt;
 };
 
@@ -12,8 +12,8 @@ static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 {
 	struct bd_holder_disk *holder;
 
-	list_for_each_entry(holder, &bdev->bd_holder_disks, list)
-		if (holder->disk == disk)
+	list_for_each_entry(holder, &disk->slave_bdevs, list)
+		if (holder->bdev == bdev)
 			return holder;
 	return NULL;
 }
@@ -61,7 +61,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	struct bd_holder_disk *holder;
 	int ret = 0;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
 
 	WARN_ON_ONCE(!bdev->bd_holder);
 
@@ -82,7 +82,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	}
 
 	INIT_LIST_HEAD(&holder->list);
-	holder->disk = disk;
+	holder->bdev = bdev;
 	holder->refcnt = 1;
 
 	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
@@ -93,7 +93,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (ret)
 		goto out_del;
 
-	list_add(&holder->list, &bdev->bd_holder_disks);
+	list_add(&holder->list, &disk->slave_bdevs);
 	goto out_unlock;
 
 out_del:
@@ -101,7 +101,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 out_free:
 	kfree(holder);
 out_unlock:
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bd_link_disk_holder);
@@ -120,7 +120,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 {
 	struct bd_holder_disk *holder;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
@@ -128,6 +128,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7825d152634e..22646906ddaa 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -900,9 +900,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
-#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
-	INIT_LIST_HEAD(&bdev->bd_holder_disks);
-#endif
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 7a4e139d24ef..e92735655684 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -34,9 +34,6 @@ struct block_device {
 	void *			bd_holder;
 	int			bd_holders;
 	bool			bd_write_holder;
-#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
-	struct list_head	bd_holder_disks;
-#endif
 	struct kobject		*bd_holder_dir;
 	u8			bd_partno;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6831d74f2002..26c8557e2714 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -159,7 +159,9 @@ struct gendisk {
 	unsigned open_partitions;	/* number of open partitions */
 
 	struct kobject *slave_dir;
-
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
+	struct list_head slave_bdevs;
+#endif
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
-- 
2.30.2

