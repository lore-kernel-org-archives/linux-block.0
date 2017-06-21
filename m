Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 02/12] block: Make request operation type argument
 declarations consistent
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-3-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <68044f59-364a-eecf-734a-437691f3fde7@suse.de>
Date: Wed, 21 Jun 2017 08:53:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Instead of declaring the second argument of blk_*_get_request()
> as int and passing it to functions that expect an unsigned int,
> declare that second argument as unsigned int. Also because of
> consistency, rename that second argument from 'rw' into 'op'.
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c       | 13 +++++++------
>  block/blk-mq.c         | 10 +++++-----
>  include/linux/blk-mq.h |  6 +++---
>  include/linux/blkdev.h |  3 ++-
>  4 files changed, 17 insertions(+), 15 deletions(-)
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
