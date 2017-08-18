Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 17 Aug 2017 23:52:23 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 05/12] blk-mq-debugfs: Declare a local symbol static
Message-ID: <20170818065223.GF2459@vader>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817232311.25948-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17, 2017 at 04:23:04PM -0700, Bart Van Assche wrote:
> This was detected by sparse.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 55940ddacd96..e53b6129ca5a 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -739,7 +739,7 @@ static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
>  		return seq_release(inode, file);
>  }
>  
> -const struct file_operations blk_mq_debugfs_fops = {
> +static const struct file_operations blk_mq_debugfs_fops = {
>  	.open		= blk_mq_debugfs_open,
>  	.read		= seq_read,
>  	.write		= blk_mq_debugfs_write,
> -- 
> 2.14.0
> 
