Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 25 May 2017 17:23:14 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/5] blk-mq: Only register debugfs attributes for blk-mq
 queues
Message-ID: <20170526002314.GB12994@vader>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525233810.23211-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 25, 2017 at 04:38:06PM -0700, Bart Van Assche wrote:
> The code in blk-mq-debugfs.c assumes that it is working on a blk-mq
> queue and is not intended to work on a blk-sq queue. Hence only
> register blk-mq debugfs attributes for blk-mq queues.

Oops. This is probably what David reported here:
https://github.com/ddiss/rapido/pull/13#event-1093484761. Thanks, Bart.

Reviewed-by: Omar Sandoval <osandov@fb.com>

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
> -- 
> 2.12.2
> 
