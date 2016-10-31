Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35940 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947958AbcJaXTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 19:19:14 -0400
Received: by mail-oi0-f49.google.com with SMTP id v84so98868291oie.3
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2016 16:19:14 -0700 (PDT)
Date: Mon, 31 Oct 2016 16:19:11 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fast-path for small and simple direct I/O
 requests
Message-ID: <20161031231911.GA20713@vader>
References: <1477936765-8828-1-git-send-email-hch@lst.de>
 <1477936765-8828-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477936765-8828-3-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 31, 2016 at 11:59:25AM -0600, Christoph Hellwig wrote:
> This patch adds a small and simple fast patch for small direct I/O
> requests on block devices that don't use AIO.  Between the neat
> bio_iov_iter_get_pages helper that avoids allocating a page array
> for get_user_pages and the on-stack bio and biovec this avoid memory
> allocations and atomic operations entirely in the direct I/O code
> (lower levels might still do memory allocations and will usually
> have at least some atomic operations, though).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 05b5533..d4134a3 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -30,6 +30,7 @@
>  #include <linux/cleancache.h>
>  #include <linux/dax.h>
>  #include <linux/badblocks.h>
> +#include <linux/task_io_accounting_ops.h>
>  #include <linux/falloc.h>
>  #include <asm/uaccess.h>
>  #include "internal.h"
> @@ -175,12 +176,91 @@ static struct inode *bdev_file_inode(struct file *file)
>  	return file->f_mapping->host;
>  }
>  
> +#define DIO_INLINE_BIO_VECS 4
> +
> +static void blkdev_bio_end_io_simple(struct bio *bio)
> +{
> +	struct task_struct *waiter = bio->bi_private;
> +
> +	WRITE_ONCE(bio->bi_private, NULL);
> +	wake_up_process(waiter);
> +}
> +
> +static ssize_t
> +__blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> +		int nr_pages)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
> +	unsigned blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *bvec;
> +	loff_t pos = iocb->ki_pos;
> +	bool should_dirty = false;
> +	struct bio bio;
> +	ssize_t ret;
> +	blk_qc_t qc;
> +	int i;
> +
> +	if ((pos | iov_iter_alignment(iter)) & ((1 << blkbits) - 1))
> +		return -EINVAL;
> +
> +	bio_init(&bio);
> +	bio.bi_max_vecs = nr_pages;
> +	bio.bi_io_vec = inline_vecs;
> +	bio.bi_bdev = bdev;
> +	bio.bi_iter.bi_sector = pos >> blkbits;
> +	bio.bi_private = current;
> +	bio.bi_end_io = blkdev_bio_end_io_simple;
> +
> +	ret = bio_iov_iter_get_pages(&bio, iter);
> +	if (unlikely(ret))
> +		return ret;
> +	ret = bio.bi_iter.bi_size;
> +
> +	if (iov_iter_rw(iter) == READ) {
> +		bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +		if (iter->type == ITER_IOVEC)

Nit: iter_is_iovec()?

> +			should_dirty = true;
> +	} else {
> +		bio_set_op_attrs(&bio, REQ_OP_WRITE, WRITE_ODIRECT);
> +		task_io_account_write(ret);
> +	}
> +
> +	qc = submit_bio(&bio);
> +	for (;;) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (!READ_ONCE(bio.bi_private))
> +			break;
> +		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> +		    !blk_poll(bdev_get_queue(bdev), qc))
> +			io_schedule();
> +	}
> +	__set_current_state(TASK_RUNNING);
> +
> +	bio_for_each_segment_all(bvec, &bio, i) {
> +		if (should_dirty && !PageCompound(bvec->bv_page))
> +			set_page_dirty_lock(bvec->bv_page);
> +		put_page(bvec->bv_page);
> +	}
> +
> +	if (unlikely(bio.bi_error))
> +		return bio.bi_error;
> +	iocb->ki_pos += ret;
> +	return ret;
> +}
> +
>  static ssize_t
>  blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = bdev_file_inode(file);
> +	int nr_pages;
>  
> +	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
> +	if (!nr_pages)
> +		return 0;
> +	if (is_sync_kiocb(iocb) && nr_pages <= DIO_INLINE_BIO_VECS)
> +		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>  	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
>  				    blkdev_get_block, NULL, NULL,
>  				    DIO_SKIP_DIO_COUNT);

The bio_iov_iter_get_pages() trick is nifty. Jens had a similarly
stripped-down version of blkdev_direct_IO() for blk-mq as part of his
blk-dio branch. Looks like he just had the page array on the stack but
still had to allocate the bio.

-- 
Omar
