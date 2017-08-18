Return-Path: <hare@suse.de>
Subject: Re: [PATCH 05/12] blk-mq-debugfs: Declare a local symbol static
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-6-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8e938dee-99b3-76bd-f8c5-1babfa769b1c@suse.de>
Date: Fri, 18 Aug 2017 09:33:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> This was detected by sparse.
> 
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
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
