Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3 3/3] blk-mq: dequeue request one by one from sw queue
 iff hctx is busy
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20180702093600.10315-1-ming.lei@redhat.com>
 <20180702093600.10315-4-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f120df41-a378-23e5-3dab-28398cd49d4e@kernel.dk>
Date: Mon, 2 Jul 2018 11:30:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180702093600.10315-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 3:36 AM, Ming Lei wrote:
> It won't be efficient to dequeue request one by one from sw queue,
> but we have to do that when queue is busy for better merge performance.
> 
> This patch takes EWMA to figure out if queue is busy, then only dequeue
> request one by one from sw queue when queue is busy.

Just one minor comment, since you're going to be updating this one
anyway:

> @@ -1209,8 +1234,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		else if (needs_restart && (ret == BLK_STS_RESOURCE))
>  			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>  
> +		blk_mq_update_hctx_busy(hctx, true);
> +
>  		return false;

Kill that newline between update and return.

Rest looks fine to me now, though I do agree with Christophs comments on
making the weight and factor in caps.

Applying 1-2/3 so far.

-- 
Jens Axboe
