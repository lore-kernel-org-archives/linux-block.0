Return-Path: <prvs=0115b0b9d1=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/5] block: fast-path for small and simple direct I/O requests
Date: Thu, 3 Nov 2016 13:45:03 -0600
Message-ID: <1478202307-1947-2-git-send-email-axboe@fb.com>
In-Reply-To: <1478202307-1947-1-git-send-email-axboe@fb.com>
References: <1478202307-1947-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

This patch adds a small and simple fast patch for small direct I/O
requests on block devices that don't use AIO.  Between the neat
bio_iov_iter_get_pages helper that avoids allocating a page array
for get_user_pages and the on-stack bio and biovec this avoid memory
allocations and atomic operations entirely in the direct I/O code
(lower levels might still do memory allocations and will usually
have at least some atomic operations, though).

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 fs/block_dev.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 05b553368bb4..d01413da5319 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -30,6 +30,7 @@
 #include <linux/cleancache.h>
 #include <linux/dax.h>
 #include <linux/badblocks.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <asm/uaccess.h>
 #include "internal.h"
@@ -175,12 +176,91 @@ static struct inode *bdev_file_inode(struct file *file)
 	return file->f_mapping->host;
 }
 
+#define DIO_INLINE_BIO_VECS 4
+
+static void blkdev_bio_end_io_simple(struct bio *bio)
+{
+	struct task_struct *waiter = bio->bi_private;
+
+	WRITE_ONCE(bio->bi_private, NULL);
+	wake_up_process(waiter);
+}
+
+static ssize_t
+__blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
+		int nr_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *bvec;
+	loff_t pos = iocb->ki_pos;
+	bool should_dirty = false;
+	struct bio bio;
+	ssize_t ret;
+	blk_qc_t qc;
+	int i;
+
+	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
+		return -EINVAL;
+
+	bio_init(&bio);
+	bio.bi_max_vecs = nr_pages;
+	bio.bi_io_vec = inline_vecs;
+	bio.bi_bdev = bdev;
+	bio.bi_iter.bi_sector = pos >> blkbits;
+	bio.bi_private = current;
+	bio.bi_end_io = blkdev_bio_end_io_simple;
+
+	ret = bio_iov_iter_get_pages(&bio, iter);
+	if (unlikely(ret))
+		return ret;
+	ret = bio.bi_iter.bi_size;
+
+	if (iov_iter_rw(iter) == READ) {
+		bio_set_op_attrs(&bio, REQ_OP_READ, 0);
+		if (iter_is_iovec(iter))
+			should_dirty = true;
+	} else {
+		bio_set_op_attrs(&bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+		task_io_account_write(ret);
+	}
+
+	qc = submit_bio(&bio);
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(bio.bi_private))
+			break;
+		if (!(iocb->ki_flags & IOCB_HIPRI) ||
+		    !blk_poll(bdev_get_queue(bdev), qc))
+			io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
+	bio_for_each_segment_all(bvec, &bio, i) {
+		if (should_dirty && !PageCompound(bvec->bv_page))
+			set_page_dirty_lock(bvec->bv_page);
+		put_page(bvec->bv_page);
+	}
+
+	if (unlikely(bio.bi_error))
+		return bio.bi_error;
+	iocb->ki_pos += ret;
+	return ret;
+}
+
 static ssize_t
 blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = bdev_file_inode(file);
+	int nr_pages;
 
+	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
+	if (!nr_pages)
+		return 0;
+	if (is_sync_kiocb(iocb) && nr_pages <= DIO_INLINE_BIO_VECS)
+		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
 				    blkdev_get_block, NULL, NULL,
 				    DIO_SKIP_DIO_COUNT);
-- 
2.7.4
