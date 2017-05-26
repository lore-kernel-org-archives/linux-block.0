Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/5] blk-mq: Only register debugfs attributes for blk-mq
 queues
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-2-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <050027c6-4132-4051-d28a-19336bfe41e2@suse.de>
Date: Fri, 26 May 2017 07:56:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170525233810.23211-2-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/26/2017 01:38 AM, Bart Van Assche wrote:
> The code in blk-mq-debugfs.c assumes that it is working on a blk-mq
> queue and is not intended to work on a blk-sq queue. Hence only
> register blk-mq debugfs attributes for blk-mq queues.
> 
> Fixes: commit 9c1051aacde8 ("blk-mq: untangle debugfs and sysfs")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 5e7b3924996c..0494baa743a3 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -888,10 +888,10 @@ int blk_register_queue(struct gendisk *disk)
>  		goto unlock;
>  	}
>  
> -	if (q->mq_ops)
> +	if (q->mq_ops) {
>  		__blk_mq_register_dev(dev, q);
> -
> -	blk_mq_debugfs_register(q);
> +		blk_mq_debugfs_register(q);
> +	}
>  
>  	kobject_uevent(&q->kobj, KOBJ_ADD);
>  
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
