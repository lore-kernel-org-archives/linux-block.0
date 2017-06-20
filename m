Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 01/12] blk-mq: Reduce blk_mq_hw_ctx size
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-2-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c5b7cfb5-4de5-7bb9-e20c-e189de65c25a@suse.de>
Date: Tue, 20 Jun 2017 08:31:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 12:07 AM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Since the srcu structure is rather large (184 bytes on an x86-64
> system with kernel debugging disabled), only allocate it if needed.
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq.c         | 30 ++++++++++++++++++++++--------
>  include/linux/blk-mq.h |  5 +++--
>  2 files changed, 25 insertions(+), 10 deletions(-)
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
