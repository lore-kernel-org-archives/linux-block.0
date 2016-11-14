Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 14 Nov 2016 11:33:39 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: fast-path for small and simple direct I/O
 requests
Message-ID: <20161114193339.GA31821@vader.DHCP.thefacebook.com>
References: <1478927487-12998-1-git-send-email-axboe@fb.com>
 <1478927487-12998-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478927487-12998-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 11, 2016 at 10:11:25PM -0700, Jens Axboe wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This patch adds a small and simple fast patch for small direct I/O
> requests on block devices that don't use AIO.  Between the neat
> bio_iov_iter_get_pages helper that avoids allocating a page array
> for get_user_pages and the on-stack bio and biovec this avoid memory
> allocations and atomic operations entirely in the direct I/O code
> (lower levels might still do memory allocations and will usually
> have at least some atomic operations, though).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  fs/block_dev.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 

[snip]

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

__blockdev_direct_IO() does a few cache prefetches that we're now
bypassing, do we want to do the same in __blkdev_direct_IO_simple()?
That's the stuff added in 65dd2aa90aa1 ("dio: optimize cache misses in
the submission path").

> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Omar
