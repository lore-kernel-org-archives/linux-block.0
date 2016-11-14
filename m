Return-Path: <prvs=0126aabdb8=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hch@infradead.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/2] block: support any sized IO for simplified bdev direct-io
Date: Mon, 14 Nov 2016 10:28:38 -0700
Message-ID: <1479144519-15738-2-git-send-email-axboe@fb.com>
In-Reply-To: <1479144519-15738-1-git-send-email-axboe@fb.com>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Just alloc the bio_vec array if we exceed the inline limit.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 fs/block_dev.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7c3ec6049073..2010997fd326 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -193,7 +193,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
 	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
-	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *bvec;
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
@@ -204,9 +204,17 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
 		return -EINVAL;
 
+	if (nr_pages <= DIO_INLINE_BIO_VECS)
+		vecs = inline_vecs;
+	else {
+		vecs = kmalloc(nr_pages * sizeof(struct bio_vec), GFP_KERNEL);
+		if (!vecs)
+			return -ENOMEM;
+	}
+
 	bio_init(&bio);
 	bio.bi_max_vecs = nr_pages;
-	bio.bi_io_vec = inline_vecs;
+	bio.bi_io_vec = vecs;
 	bio.bi_bdev = bdev;
 	bio.bi_iter.bi_sector = pos >> blkbits;
 	bio.bi_private = current;
@@ -243,6 +251,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		put_page(bvec->bv_page);
 	}
 
+	if (vecs != inline_vecs)
+		kfree(vecs);
+
 	if (unlikely(bio.bi_error))
 		return bio.bi_error;
 	iocb->ki_pos += ret;
@@ -259,7 +270,7 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 	if (!nr_pages)
 		return 0;
-	if (is_sync_kiocb(iocb) && nr_pages <= DIO_INLINE_BIO_VECS)
+	if (is_sync_kiocb(iocb))
 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
 				    blkdev_get_block, NULL, NULL,
-- 
2.7.4
