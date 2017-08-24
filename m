Return-Path: <jack@suse.cz>
Date: Thu, 24 Aug 2017 16:39:23 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk,
	Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, mgorman@suse.de,
	Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block_dev: support RFW_NOWAIT on block device nodes
Message-ID: <20170824143923.GD8969@quack2.suse.cz>
References: <20170822161712.11716-1-hch@lst.de>
 <20170822161712.11716-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170822161712.11716-5-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue 22-08-17 18:17:12, Christoph Hellwig wrote:
> All support is already there in the generic code, we just need to wire
> it up.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9941dc8342df..ea21d18d8e79 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1739,6 +1739,8 @@ static int blkdev_open(struct inode * inode, struct file * filp)
>  	 */
>  	filp->f_flags |= O_LARGEFILE;
>  
> +	filp->f_mode |= FMODE_NOWAIT;
> +
>  	if (filp->f_flags & O_NDELAY)
>  		filp->f_mode |= FMODE_NDELAY;
>  	if (filp->f_flags & O_EXCL)
> @@ -1891,6 +1893,9 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (iocb->ki_pos >= size)
>  		return -ENOSPC;
>  
> +	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
> +		return -EOPNOTSUPP;
> +
>  	iov_iter_truncate(from, size - iocb->ki_pos);
>  
>  	blk_start_plug(&plug);
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
