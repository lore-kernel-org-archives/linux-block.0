Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/5] blk-mq-debugfs: Show requeue list
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-4-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <aee94c57-7223-1b2d-86b3-72bc920550a6@suse.de>
Date: Fri, 26 May 2017 07:57:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170525233810.23211-4-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/26/2017 01:38 AM, Bart Van Assche wrote:
> When verifying whether or not a blk-mq driver forgot to kick the
> requeue list after having requeued a request it is important to
> be able to verify the contents of the requeue list. Hence export
> that list through debugfs.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-debugfs.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
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
