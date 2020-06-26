Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DED1C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6CA20857
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WgwKN5n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgFZIC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgFZICZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6FC08C5DB;
        Fri, 26 Jun 2020 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9TwHQN5otZ7PBNa1KtFbOqjvaBuTORubLW27TUGLV0I=; b=WgwKN5n/SDLSGIBhtCb+1ksjtQ
        nbZpZVKOSUPlcA4HFM7kMO1ljNUraod4RxKvD8VbMBA2rTEVit2i6WY86oqBhZbwIec8JNNa3PXmD
        d/lXHEoukxHDqTaOLyYlyC19d8uV/ELR8IKeMj8CoNYwWfnv7QBrmcmngiXAlxnrbgDmnCuMpALMA
        g2e82hLI3RbG51uYLsJpe6VI8Gp/P4i1sVcGLZ3QouKyNAE5pD0L6+DIGC/VegIFaZbORUFvbNkzX
        tx2ezkDZwKWjChynBctKqwBD/pJT62Ore7A05Pq0LUUd0Wrv6icxwftuOGz0zpCCuErFa0uWzyGtl
        3/ueKifg==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJF-0007UY-27; Fri, 26 Jun 2020 08:02:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] block: remove the bd_queue field from struct block_device
Date:   Fri, 26 Jun 2020 10:01:56 +0200
Message-Id: <20200626080158.1998621-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just use bd_disk->queue instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c        |  2 +-
 drivers/md/md.c            |  2 +-
 drivers/nvme/target/core.c |  2 +-
 fs/block_dev.c             | 11 ++++-------
 fs/direct-io.c             |  4 ++--
 fs/xfs/xfs_pwork.c         |  2 +-
 include/linux/blk_types.h  |  1 -
 mm/swapfile.c              |  2 +-
 8 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f743..f508285263319b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(bdev_dax_pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 {
-	if (!blk_queue_dax(bdev->bd_queue))
+	if (!blk_queue_dax(bdev->bd_disk->queue))
 		return NULL;
 	return dax_get_by_host(bdev->bd_disk->disk_name);
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529bd..6f13c6d328ba7b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -199,7 +199,7 @@ static int rdevs_init_serial(struct mddev *mddev)
 static int rdev_need_serial(struct md_rdev *rdev)
 {
 	return (rdev && rdev->mddev->bitmap_info.max_write_behind > 0 &&
-		rdev->bdev->bd_queue->nr_hw_queues != 1 &&
+		rdev->bdev->bd_disk->queue->nr_hw_queues != 1 &&
 		test_bit(WriteMostly, &rdev->flags));
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6e2f623e472e9f..6816507fba58a6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -467,7 +467,7 @@ static int nvmet_p2pmem_ns_enable(struct nvmet_ns *ns)
 		return -EINVAL;
 	}
 
-	if (!blk_queue_pci_p2pdma(ns->bdev->bd_queue)) {
+	if (!blk_queue_pci_p2pdma(ns->bdev->bd_disk->queue)) {
 		pr_err("peer-to-peer DMA is not supported by the driver of %s\n",
 		       ns->device_path);
 		return -EINVAL;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 06d31e459048ad..68cb08bc1b7a65 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -693,12 +693,12 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return result;
 
-	result = blk_queue_enter(bdev->bd_queue, 0);
+	result = blk_queue_enter(bdev->bd_disk->queue, 0);
 	if (result)
 		return result;
 	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
 			      REQ_OP_READ);
-	blk_queue_exit(bdev->bd_queue);
+	blk_queue_exit(bdev->bd_disk->queue);
 	return result;
 }
 
@@ -729,7 +729,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return -EOPNOTSUPP;
-	result = blk_queue_enter(bdev->bd_queue, 0);
+	result = blk_queue_enter(bdev->bd_disk->queue, 0);
 	if (result)
 		return result;
 
@@ -742,7 +742,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 		clean_page_buffers(page);
 		unlock_page(page);
 	}
-	blk_queue_exit(bdev->bd_queue);
+	blk_queue_exit(bdev->bd_disk->queue);
 	return result;
 }
 
@@ -1568,7 +1568,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	if (!bdev->bd_openers) {
 		first_open = true;
 		bdev->bd_disk = disk;
-		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
 		bdev->bd_partno = partno;
 
@@ -1589,7 +1588,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 					disk_put_part(bdev->bd_part);
 					bdev->bd_part = NULL;
 					bdev->bd_disk = NULL;
-					bdev->bd_queue = NULL;
 					mutex_unlock(&bdev->bd_mutex);
 					disk_unblock_events(disk);
 					put_disk_and_module(disk);
@@ -1666,7 +1664,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	disk_put_part(bdev->bd_part);
 	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
-	bdev->bd_queue = NULL;
 	if (bdev != bdev->bd_contains)
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6d5370eac2a8f2..183299892465af 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1387,8 +1387,8 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 * Attempt to prefetch the pieces we likely need later.
 	 */
 	prefetch(&bdev->bd_disk->part_tbl);
-	prefetch(bdev->bd_queue);
-	prefetch((char *)bdev->bd_queue + SMP_CACHE_BYTES);
+	prefetch(bdev->bd_disk->queue);
+	prefetch((char *)bdev->bd_disk->queue + SMP_CACHE_BYTES);
 
 	return do_blockdev_direct_IO(iocb, inode, bdev, iter, get_block,
 				     end_io, submit_io, flags);
diff --git a/fs/xfs/xfs_pwork.c b/fs/xfs/xfs_pwork.c
index 4bcc3e61056c8c..b03333f1c84ad0 100644
--- a/fs/xfs/xfs_pwork.c
+++ b/fs/xfs/xfs_pwork.c
@@ -132,5 +132,5 @@ xfs_pwork_guess_datadev_parallelism(
 	 * For now we'll go with the most conservative setting possible,
 	 * which is two threads for an SSD and 1 thread everywhere else.
 	 */
-	return blk_queue_nonrot(btp->bt_bdev->bd_queue) ? 2 : 1;
+	return blk_queue_nonrot(btp->bt_bdev->bd_disk->queue) ? 2 : 1;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b01cd19bbe8a6e..667cd365fd048b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -39,7 +39,6 @@ struct block_device {
 	unsigned		bd_part_count;
 	int			bd_invalidated;
 	struct gendisk *	bd_disk;
-	struct request_queue *  bd_queue;
 	struct backing_dev_info *bd_bdi;
 	struct list_head	bd_list;
 	/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 987276c557d1f1..6c26916e95fd4a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2929,7 +2929,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 		 * write only restriction.  Hence zoned block devices are not
 		 * suitable for swapping.  Disallow them here.
 		 */
-		if (blk_queue_is_zoned(p->bdev->bd_queue))
+		if (blk_queue_is_zoned(p->bdev->bd_disk->queue))
 			return -EINVAL;
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
-- 
2.26.2

