Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 10/12] blk-mq: Document locking assumptions
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-11-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <795753af-8160-e387-f9ed-ab6392d0bb9b@suse.de>
Date: Wed, 21 Jun 2017 08:57:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-11-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Document the locking assumptions in functions that modify
> blk_mq_ctx.rq_list to make it easier for humans to verify
> this code.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c | 2 ++
>  block/blk-mq.c       | 4 ++++
>  2 files changed, 6 insertions(+)
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
