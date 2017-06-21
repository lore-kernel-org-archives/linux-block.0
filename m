Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 09/12] block: Document what queue type each function is
 intended for
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-10-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56ce79c6-339e-925a-2b0b-c0fc42576871@suse.de>
Date: Wed, 21 Jun 2017 08:56:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-10-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
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
