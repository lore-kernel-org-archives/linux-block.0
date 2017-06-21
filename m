Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 06/12] blk-mq: Initialize .rq_flags in
 blk_mq_rq_ctx_init()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-7-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5167ae87-33e4-1c47-2408-8741c997ca75@suse.de>
Date: Wed, 21 Jun 2017 08:55:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-7-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Initialization of blk-mq requests is a bit weird: blk_mq_rq_ctx_init()
> is called after a value has been assigned to .rq_flags and .rq_flags
> is initialized in __blk_mq_finish_request(). Initialize .rq_flags in
> blk_mq_rq_ctx_init() instead of relying on __blk_mq_finish_request().
> Moving the initialization of .rq_flags is fine because all changes
> and tests of .rq_flags occur between blk_get_request() and finishing
> a request.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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
