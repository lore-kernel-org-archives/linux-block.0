Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D31C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 13:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804D661460
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 13:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhENNUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhENNUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 09:20:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD51C061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+yFWD0mE1OxhuHwIEtmAie6vSoYQG7WoSUO8rCZzCLo=; b=hvc+oRX7s/vJHUhmZHBssc8um3
        8UtSIlCvQ56dEdsKCqlCEsAG0423Nu5zcxTBzHtscJO7MqxrxJJuK49n5s6E3EP7PQrzKn5O62C0s
        F3TDbMyghc+D+nouFjpA+KwbbOhzn7vURPxQIBsbvhTH/FyIh5xG08P86M8vNwWjEmnSVXocSe8UV
        aEk+bIlt7gC9fdoTyWU/D6EQogeI9+QDXF9YQcqD2Na6zE4Lwtka2MeEyfZW9KkZjyMUgmIHp9FAs
        BZjzn/Ai9G8PYkzH0d5pF5l0S9EJwPlOVwHzwh2A4k6ijpwUlf5CjrR/UuUdDMirB1nLpl/SrOAl4
        74UVIhzg==;
Received: from [2001:4bb8:198:fbc8:cf38:8667:24ad:8b9e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhXiK-00BzyR-2y; Fri, 14 May 2021 13:18:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: prevent block device lookups at the beginning of del_gendisk
Date:   Fri, 14 May 2021 15:18:41 +0200
Message-Id: <20210514131842.1600568-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514131842.1600568-1-hch@lst.de>
References: <20210514131842.1600568-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As an artifact of how gendisk lookup used to work in earlier kernels,
GENHD_FL_UP is only cleared very late in del_gendisk, and a global lock
is used to prevent opens from succeeding while del_gendisk is tearing
down the gendisk.  Switch to clearing the flag early and under bd_mutex
so that callers can use bd_mutex to stabilize the flag, which removes
the need for the global mutex.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 11 +----------
 fs/block_dev.c        | 15 +++++----------
 include/linux/genhd.h |  2 --
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 39ca97b0edc6..9f8cb7beaad1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -29,8 +29,6 @@
 
 static struct kobject *block_depr;
 
-DECLARE_RWSEM(bdev_lookup_sem);
-
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
@@ -609,13 +607,8 @@ void del_gendisk(struct gendisk *disk)
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
 	blk_drop_partitions(disk);
 	mutex_unlock(&disk->part0->bd_mutex);
 
@@ -629,8 +622,6 @@ void del_gendisk(struct gendisk *disk)
 	remove_inode_hash(disk->part0->bd_inode);
 
 	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
-	up_write(&bdev_lookup_sem);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
diff --git a/fs/block_dev.c b/fs/block_dev.c
index eb265d72fce8..580bae995b87 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1298,6 +1298,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 	struct gendisk *disk = bdev->bd_disk;
 	int ret = 0;
 
+	if (!(disk->flags & GENHD_FL_UP))
+		return -ENXIO;
+
 	if (!bdev->bd_openers) {
 		if (!bdev_is_partition(bdev)) {
 			ret = 0;
@@ -1332,8 +1335,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			whole->bd_part_count++;
 			mutex_unlock(&whole->bd_mutex);
 
-			if (!(disk->flags & GENHD_FL_UP) ||
-			    !bdev_nr_sectors(bdev)) {
+			if (!bdev_nr_sectors(bdev)) {
 				__blkdev_put(whole, mode, 1);
 				bdput(whole);
 				return -ENXIO;
@@ -1364,16 +1366,12 @@ struct block_device *blkdev_get_no_open(dev_t dev)
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
@@ -1383,14 +1381,11 @@ struct block_device *blkdev_get_no_open(dev_t dev)
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

