Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 09/12] block: Document what queue type each function is
 intended for
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-10-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a98c6fed-3ca4-df93-b58a-db86646a5ffa@suse.de>
Date: Tue, 20 Jun 2017 08:41:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-10-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 12:07 AM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Some functions in block/blk-core.c must only be used on blk-sq queues
> while others are safe to use against any queue type. Document which
> functions are intended for blk-sq queues and issue a warning if the
> blk-sq API is misused. This does not only help block driver authors
> but will also make it easier to remove the blk-sq code once that code
> is declared obsolete.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c | 33 +++++++++++++++++++++++++++++++++
>  block/blk.h      |  2 ++
>  2 files changed, 35 insertions(+)
> Now _that_ is indeed a good idea.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
