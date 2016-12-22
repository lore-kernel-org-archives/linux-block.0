Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbcLVSUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2016 13:20:50 -0500
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: loberman@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] block: add back plugging in __blkdev_direct_IO
Date: Thu, 22 Dec 2016 19:20:45 +0100
Message-Id: <1482430845-28938-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This allows sending larger than 1 MB requess to devices that support
large I/O sizes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Laurence Oberman <loberman@redhat.com>
---
 fs/block_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7c45072..206a92a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -328,6 +328,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = bdev_file_inode(file);
 	struct block_device *bdev = I_BDEV(inode);
+	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ);
@@ -353,6 +354,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	dio->multi_bio = false;
 	dio->should_dirty = is_read && (iter->type == ITER_IOVEC);
 
+	blk_start_plug(&plug);
 	for (;;) {
 		bio->bi_bdev = bdev;
 		bio->bi_iter.bi_sector = pos >> 9;
@@ -394,6 +396,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
+	blk_finish_plug(&plug);
 
 	if (!dio->is_sync)
 		return -EIOCBQUEUED;
-- 
2.1.4

