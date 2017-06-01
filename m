Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 3/4] blk-mq-debugfs: Show busy requests
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
 <20170531213050.30276-4-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d4be7f33-2ac3-e935-6687-0e3618956e49@suse.de>
Date: Thu, 1 Jun 2017 07:48:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170531213050.30276-4-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/31/2017 11:30 PM, Bart Van Assche wrote:
> Requests that got stuck in a block driver are neither on
> blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
> visible in debugfs through the "busy" attribute.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-debugfs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
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
