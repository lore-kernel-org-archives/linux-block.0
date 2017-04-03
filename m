Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/3] blk-mq: Introduce blk_mq_ops.restart_queues
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170331231205.16640-1-bart.vanassche@sandisk.com>
 <20170331231205.16640-2-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4627591c-16be-40a7-888c-68fe9cf9d444@suse.de>
Date: Mon, 3 Apr 2017 08:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170331231205.16640-2-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/01/2017 01:12 AM, Bart Van Assche wrote:
> If a tag set is shared among multiple request queues, leave
> it to the block driver to restart queues. Hence remove
> QUEUE_FLAG_RESTART and introduce blk_mq_ops.restart_queues.
> Remove blk_mq_sched_mark_restart_queue() because this
> function has no callers.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  block/blk-mq-sched.c   | 11 +++--------
>  block/blk-mq-sched.h   | 14 --------------
>  include/linux/blk-mq.h |  4 ++++
>  include/linux/blkdev.h |  1 -
>  4 files changed, 7 insertions(+), 23 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
