Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0784C43460
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD956142D
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhELRc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbhELQyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 12:54:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516BC06134D
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rQpKhARa4do/q2GK3W6QYyt9aq9PrNIGFIXW84FwRzQ=; b=Rm5sd8Z9CInnzNrirHu9AtFATP
        MtUKPX2bWRwtn6m60NK58WxRaGzaeBsSk/YdYRcMZDgbK7cy38ULkfmG4pyK9OWiNYUZjtFFJSEVJ
        jQJcjAumlaYEQwZzmyK8E89HYY52EnIB+rWsOa+hnlHTSeY88jhWe0I1sijhEySbeSdpFeWWsbJNA
        WDaIYWJN2SzIIKT8MQSsfGpy+hI0jYTEVSZZz60sh+vThP+iLyQf57Af7IpW+PY9HnUH/kxOCQyOJ
        gSg3zinBS2Xr4COAnJ+ToIGlj2bPfWE0GwIjFmFvTCKNMj2ksI1torJ6f3ZSw/5r0cjFA17hlkUg1
        qflbc7gA==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgs4U-00AcHD-RZ; Wed, 12 May 2021 16:50:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: prevent block device lookups at the beginning of del_gendisk
Date:   Wed, 12 May 2021 18:50:49 +0200
Message-Id: <20210512165050.628550-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512165050.628550-1-hch@lst.de>
References: <20210512165050.628550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As an aritfact of how gendisk lookup used to work in earlier kernels,
GENHD_FL_UP is only cleared very late in del_gendisk, and instead a
global lock is used to prevent opens from actually succeeding.  Clear
the flag, and remove the bdev inode from the inode hash earlier to
ensure lookups fail from the very beginning of del_gendisk, and remove
the now not needed bdev_lookup_sem.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 19 ++-----------------
 fs/block_dev.c        |  9 +--------
 include/linux/genhd.h |  2 --
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 39ca97b0edc6..1693e520ec7d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -29,8 +29,6 @@
 
 static struct kobject *block_depr;
 
-DECLARE_RWSEM(bdev_lookup_sem);
-
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
@@ -609,28 +607,15 @@ void del_gendisk(struct gendisk *disk)
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
-	/*
-	 * Block lookups of the disk until all bdevs are unhashed and the
-	 * disk is marked as dead (GENHD_FL_UP cleared).
-	 */
-	down_write(&bdev_lookup_sem);
-
 	mutex_lock(&disk->part0->bd_mutex);
+	disk->flags &= ~GENHD_FL_UP;
+	remove_inode_hash(disk->part0->bd_inode);
 	blk_drop_partitions(disk);
 	mutex_unlock(&disk->part0->bd_mutex);
 
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
-
-	/*
-	 * Unhash the bdev inode for this device so that it can't be looked
-	 * up any more even if openers still hold references to it.
-	 */
-	remove_inode_hash(disk->part0->bd_inode);
-
 	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
-	up_write(&bdev_lookup_sem);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
diff --git a/fs/block_dev.c b/fs/block_dev.c
index eb265d72fce8..de1a760da62d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1364,16 +1364,12 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	struct block_device *bdev;
 	struct gendisk *disk;
 
-	down_read(&bdev_lookup_sem);
 	bdev = bdget(dev);
 	if (!bdev) {
-		up_read(&bdev_lookup_sem);
 		blk_request_module(dev);
-		down_read(&bdev_lookup_sem);
-
 		bdev = bdget(dev);
 		if (!bdev)
-			goto unlock;
+			return NULL;
 	}
 
 	disk = bdev->bd_disk;
@@ -1383,14 +1379,11 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 		goto put_disk;
 	if (!try_module_get(bdev->bd_disk->fops->owner))
 		goto put_disk;
-	up_read(&bdev_lookup_sem);
 	return bdev;
 put_disk:
 	put_disk(disk);
 bdput:
 	bdput(bdev);
-unlock:
-	up_read(&bdev_lookup_sem);
 	return NULL;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7e9660ea967d..6fc26f7bdf71 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -306,8 +306,6 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 }
 #endif /* CONFIG_SYSFS */
 
-extern struct rw_semaphore bdev_lookup_sem;
-
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
-- 
2.30.2

