Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] block_dev: Fixed direct I/O bio sector calculation
To: Damien Le Moal <damien.lemoal@wdc.com>
References: <1479796729-25517-1-git-send-email-damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b246a712-d49a-1dff-e912-b4b8167b4b03@kernel.dk>
Date: Tue, 22 Nov 2016 08:11:33 -0700
MIME-Version: 1.0
In-Reply-To: <1479796729-25517-1-git-send-email-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/21/2016 11:38 PM, Damien Le Moal wrote:
> A direct I/O alignment must be always checked against the device blocks size,
> but the I/O offset (bio->bi_iter.bi_sector must always use 512B sector unit, and
> not the actual logical block size.

Oops indeed, that's not great... Added for 4.10.

While there, we can then also get rid of the blkbits variable, and (more
importantly), the call to blksize_bits():

diff --git a/fs/block_dev.c b/fs/block_dev.c
index e49fb797e447..b0c790a19db9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -202,7 +202,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct 
iov_iter *iter,
  {
  	struct file *file = iocb->ki_filp;
  	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
  	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
  	loff_t pos = iocb->ki_pos;
  	bool should_dirty = false;
@@ -211,7 +210,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct 
iov_iter *iter,
  	blk_qc_t qc;
  	int i;

-	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
  		return -EINVAL;

  	if (nr_pages <= DIO_INLINE_BIO_VECS)
@@ -331,7 +331,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct 
iov_iter *iter, int nr_pages)
  	struct file *file = iocb->ki_filp;
  	struct inode *inode = bdev_file_inode(file);
  	struct block_device *bdev = I_BDEV(inode);
-	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
  	struct blkdev_dio *dio;
  	struct bio *bio;
  	bool is_read = (iov_iter_rw(iter) == READ);
@@ -339,7 +338,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct 
iov_iter *iter, int nr_pages)
  	blk_qc_t qc = BLK_QC_T_NONE;
  	int ret;

-	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
  		return -EINVAL;

  	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, blkdev_dio_pool);


-- 
Jens Axboe
