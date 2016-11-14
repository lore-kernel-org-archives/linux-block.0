Return-Path: <prvs=0126aabdb8=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hch@infradead.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/2] block: add support for async simple direct-io for bdevs
Date: Mon, 14 Nov 2016 10:28:39 -0700
Message-ID: <1479144519-15738-3-git-send-email-axboe@fb.com>
In-Reply-To: <1479144519-15738-1-git-send-email-axboe@fb.com>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 fs/block_dev.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2010997fd326..62ca4ce21222 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -176,9 +176,68 @@ static struct inode *bdev_file_inode(struct file *file)
 	return file->f_mapping->host;
 }
 
+static void blkdev_bio_end_io_async(struct bio *bio)
+{
+	struct kiocb *iocb = bio->bi_private;
+
+	iocb->ki_complete(iocb, bio->bi_error, 0);
+
+	if (bio_op(bio) == REQ_OP_READ)
+		bio_check_pages_dirty(bio);
+	else
+		bio_put(bio);
+}
+
+static ssize_t
+__blkdev_direct_IO_async(struct kiocb *iocb, struct iov_iter *iter,
+			 int nr_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
+	loff_t pos = iocb->ki_pos;
+	struct bio *bio;
+	ssize_t ret;
+
+	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
+		return -EINVAL;
+
+	bio = bio_alloc(GFP_KERNEL, nr_pages);
+	if (!bio)
+		return -ENOMEM;
+
+	bio->bi_bdev = bdev;
+	bio->bi_iter.bi_sector = pos >> blkbits;
+	bio->bi_private = iocb;
+	bio->bi_end_io = blkdev_bio_end_io_async;
+
+	ret = bio_iov_iter_get_pages(bio, iter);
+	if (unlikely(ret))
+		return ret;
+
+	/*
+	 * Overload bio size in error. If it gets set, we lose the
+	 * size, but we don't need the size for that case. IO is limited
+	 * to BIO_MAX_PAGES, so we can't overflow.
+	 */
+	ret = bio->bi_error = bio->bi_iter.bi_size;
+
+	if (iov_iter_rw(iter) == READ) {
+		bio_set_op_attrs(bio, REQ_OP_READ, 0);
+		bio_set_pages_dirty(bio);
+	} else {
+		bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
+		task_io_account_write(ret);
+	}
+
+	submit_bio(bio);
+	iocb->ki_pos += ret;
+	return -EIOCBQUEUED;
+}
+
 #define DIO_INLINE_BIO_VECS 4
 
-static void blkdev_bio_end_io_simple(struct bio *bio)
+static void blkdev_bio_end_io_sync(struct bio *bio)
 {
 	struct task_struct *waiter = bio->bi_private;
 
@@ -187,8 +246,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 }
 
 static ssize_t
-__blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
-		int nr_pages)
+__blkdev_direct_IO_sync(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
@@ -218,7 +276,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_bdev = bdev;
 	bio.bi_iter.bi_sector = pos >> blkbits;
 	bio.bi_private = current;
-	bio.bi_end_io = blkdev_bio_end_io_simple;
+	bio.bi_end_io = blkdev_bio_end_io_sync;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -263,18 +321,16 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 static ssize_t
 blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = bdev_file_inode(file);
 	int nr_pages;
 
 	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 	if (!nr_pages)
 		return 0;
+
 	if (is_sync_kiocb(iocb))
-		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
-				    blkdev_get_block, NULL, NULL,
-				    DIO_SKIP_DIO_COUNT);
+		return __blkdev_direct_IO_sync(iocb, iter, nr_pages);
+
+	return __blkdev_direct_IO_async(iocb, iter, nr_pages);
 }
 
 int __sync_blockdev(struct block_device *bdev, int wait)
-- 
2.7.4
