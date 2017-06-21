Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 03/12] block: Introduce
 request_queue.initialize_rq_fn()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-4-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <30832651-18b9-e1e1-b3e9-f7ab678a3fe7@suse.de>
Date: Wed, 21 Jun 2017 08:54:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Several block drivers need to initialize the driver-private request
> data after having called blk_get_request() and before .prep_rq_fn()
> is called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
> that initialization code has to be repeated after every
> blk_get_request() call by adding new callback functions to struct
> request_queue and to struct blk_mq_ops.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-core.c       | 17 +++++++++++++----
>  include/linux/blk-mq.h |  2 ++
>  include/linux/blkdev.h |  4 ++++
>  3 files changed, 19 insertions(+), 4 deletions(-)
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
