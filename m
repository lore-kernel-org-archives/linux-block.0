Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A5C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbiC3Fbf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiC3Fbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F501C4051
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YCJXVBgO4Vme3TigeREWDcq2buieOFc+drbNrCfzycA=; b=HTdGenJ2/2/t9PASAUxjdjoGhz
        xa+jWufQq4GuIA4V61vyLxOHFcWXZY3F53RwBaOBlmQ+lo5f/ud9DRIXAtupjBLV/ak8T2ya7gI0B
        0s21iHztcXD957U7yj2CiT1bP/Ww+i6eVRzdEmqUS9EBpI+2r62oBGZ+MhWOk9kfHgi7Ke0OQjXdO
        bI1FhezpC8KnvH9Dk+2fM56EvrYdLWwMTB6i8P6y6achHBuJ50YbMakqp+SwMdY3OlcPfKojkHmd+
        fZK7ZEFzDAIBpyJYaUseYhNk8fOrT/tJrSNqZ7beLh6e3+48snlln0rNj4AW6va69by98XpTnDsHD
        28VwiDVA==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQtn-00ELGd-PP; Wed, 30 Mar 2022 05:29:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 05/15] block: turn bdev->bd_openers into an atomic_t
Date:   Wed, 30 Mar 2022 07:29:07 +0200
Message-Id: <20220330052917.2566582-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All manipulation of bd_openers is under disk->open_mutex and will remain
so for the foreseeable future.  But at least one place reads it without
the lock (blkdev_get) and there are more to be added.  So make sure the
compiler does not do turn the increments and decrements into non-atomic
sequences by using an atomic_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c              | 16 ++++++++--------
 block/partitions/core.c   |  2 +-
 include/linux/blk_types.h |  2 +-
 include/linux/blkdev.h    |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 13de871fa8169..7bf88e591aaf3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -673,17 +673,17 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 		}
 	}
 
-	if (!bdev->bd_openers)
+	if (!atomic_read(&bdev->bd_openers))
 		set_init_blocksize(bdev);
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
-	bdev->bd_openers++;
+	atomic_inc(&bdev->bd_openers);
 	return 0;
 }
 
 static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
 {
-	if (!--bdev->bd_openers)
+	if (atomic_dec_and_test(&bdev->bd_openers))
 		blkdev_flush_mapping(bdev);
 	if (bdev->bd_disk->fops->release)
 		bdev->bd_disk->fops->release(bdev->bd_disk, mode);
@@ -694,7 +694,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	struct gendisk *disk = part->bd_disk;
 	int ret;
 
-	if (part->bd_openers)
+	if (atomic_read(&part->bd_openers))
 		goto done;
 
 	ret = blkdev_get_whole(bdev_whole(part), mode);
@@ -708,7 +708,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	disk->open_partitions++;
 	set_init_blocksize(part);
 done:
-	part->bd_openers++;
+	atomic_inc(&part->bd_openers);
 	return 0;
 
 out_blkdev_put:
@@ -720,7 +720,7 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 {
 	struct block_device *whole = bdev_whole(part);
 
-	if (--part->bd_openers)
+	if (!atomic_dec_and_test(&part->bd_openers))
 		return;
 	blkdev_flush_mapping(part);
 	whole->bd_disk->open_partitions--;
@@ -899,7 +899,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	 * of the world and we want to avoid long (could be several minute)
 	 * syncs while holding the mutex.
 	 */
-	if (bdev->bd_openers == 1)
+	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
@@ -1044,7 +1044,7 @@ void sync_bdevs(bool wait)
 		bdev = I_BDEV(inode);
 
 		mutex_lock(&bdev->bd_disk->open_mutex);
-		if (!bdev->bd_openers) {
+		if (!atomic_read(&bdev->bd_openers)) {
 			; /* skip */
 		} else if (wait) {
 			/*
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 2ef8dfa1e5c85..373ed748dcf26 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -486,7 +486,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 		goto out_unlock;
 
 	ret = -EBUSY;
-	if (part->bd_openers)
+	if (atomic_read(&part->bd_openers))
 		goto out_unlock;
 
 	delete_partition(part);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dd0763a1c6740..5fdda716620e6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -44,7 +44,7 @@ struct block_device {
 	unsigned long		bd_stamp;
 	bool			bd_read_only;	/* read-only policy */
 	dev_t			bd_dev;
-	int			bd_openers;
+	atomic_t		bd_openers;
 	struct inode *		bd_inode;	/* will die */
 	struct super_block *	bd_super;
 	void *			bd_claiming;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1abd5a56a5c99..3b11625825d3f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -188,7 +188,7 @@ static inline bool disk_live(struct gendisk *disk)
  */
 static inline unsigned int disk_openers(struct gendisk *disk)
 {
-	return disk->part0->bd_openers;
+	return atomic_read(&disk->part0->bd_openers);
 }
 
 /*
-- 
2.30.2

