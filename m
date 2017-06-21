Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 12/12] blk-mq: Warn when attempting to run a hardware
 queue that is not mapped
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-13-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a259a919-9146-6af4-1d25-5cc7a2d8d1b9@suse.de>
Date: Wed, 21 Jun 2017 08:57:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-13-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> A queue must be frozen while the mapped state of a hardware queue
> is changed. Additionally, any change of the mapped state is
> followed by a call to blk_mq_map_swqueue() (see also
> blk_mq_init_allocated_queue() and blk_mq_update_nr_hw_queues()).
> Since blk_mq_map_swqueue() does not map any unmapped hardware
> queue onto any software queue, no attempt will be made to run
> an unmapped hardware queue. Hence issue a warning upon attempts
> to run an unmapped hardware queue.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
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
