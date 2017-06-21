Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 07/12] block: Add a comment above
 queue_lockdep_assert_held()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-8-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8ca92c31-d5d8-06bc-16b6-3efe8e528318@suse.de>
Date: Wed, 21 Jun 2017 08:55:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-8-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Add a comment above the queue_lockdep_assert_held() macro that
> explains the purpose of the q->queue_lock test.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/blkdev.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ff0ae83235ea..c00a6b99e77c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -635,6 +635,13 @@ struct request_queue {
>  				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
>  				 (1 << QUEUE_FLAG_POLL))
>  
> +/*
> + * @q->queue_lock is set while a queue is being initialized. Since we know
> + * that no other threads access the queue object before @q->queue_lock has
> + * been set, it is safe to manipulate queue flags without holding the
> + * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
> + * blk_init_allocated_queue().
> + */
>  static inline void queue_lockdep_assert_held(struct request_queue *q)
>  {
>  	if (q->queue_lock)
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
