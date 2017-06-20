Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 03/12] block: Introduce
 request_queue.initialize_rq_fn()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-4-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <759ae60a-fff4-2d3d-4bde-1c8014c07379@suse.de>
Date: Tue, 20 Jun 2017 08:34:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 12:07 AM, Bart Van Assche wrote:
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
>  block/blk-core.c       | 17 +++++++++++++++--
>  include/linux/blk-mq.h |  2 ++
>  include/linux/blkdev.h |  4 ++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
Thanks for doing so. I had been missing this functionality for a long
time; now I can finally go ahead and convert the dasd driver :-)

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
