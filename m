Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756692AbdCXPUE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 11:20:04 -0400
Subject: Re: [PATCH v2 2/4] block: add a read barrier in blk_queue_enter()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
 <20170324123621.5227-3-tom.leiming@gmail.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3f3e6ce9-a2e2-75f9-43b9-982eb3b251b0@suse.de>
Date: Fri, 24 Mar 2017 16:18:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170324123621.5227-3-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/24/2017 01:36 PM, Ming Lei wrote:
> Without the barrier, reading DEAD flag of .q_usage_counter
> and reading .mq_freeze_depth may be reordered, then the
> following wait_event_interruptible() may never return.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ad388d5e309a..44eed17319c0 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -669,6 +669,14 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
>  		if (nowait)
>  			return -EBUSY;
>  
> +		/*
> +		 * read pair of barrier in blk_mq_freeze_queue_start(),
> +		 * we need to order reading DEAD flag of .q_usage_counter
> +		 * and reading .mq_freeze_depth, otherwise the following
> +		 * wait may never return if the two read are reordered.
> +		 */
> +		smp_rmb();
> +
>  		ret = wait_event_interruptible(q->mq_freeze_wq,
>  				!atomic_read(&q->mq_freeze_depth) ||
>  				blk_queue_dying(q));
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
