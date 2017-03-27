Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33180 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbdC0PoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 11:44:10 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hare@suse.de" <hare@suse.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
Subject: Re: [PATCH v3 2/4] block: add a read barrier in blk_queue_enter()
Date: Mon, 27 Mar 2017 15:44:00 +0000
Message-ID: <1490629427.2461.8.camel@sandisk.com>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
         <20170327120658.29864-3-tom.leiming@gmail.com>
In-Reply-To: <20170327120658.29864-3-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-03-27 at 20:06 +0800, Ming Lei wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ad388d5e309a..5e8963bc98d9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -669,6 +669,15 @@ int blk_queue_enter(struct request_queue *q, bool no=
wait)
>  		if (nowait)
>  			return -EBUSY;
> =20
> +		/*
> +		 * read pair of barrier in blk_mq_freeze_queue_start(),
> +		 * we need to order reading __PERCPU_REF_DEAD flag of
> +		 * .q_usage_counter and reading .mq_freeze_depth,
> +		 * otherwise the following wait may never return if the
> +		 * two reads are reordered.
> +		 */
> +		smp_rmb();
> +
>  		ret =3D wait_event_interruptible(q->mq_freeze_wq,
>  				!atomic_read(&q->mq_freeze_depth) ||
>  				blk_queue_dying(q));

Since patch 4/4 modifies the comment introduced by this patch, I would have
preferred that patches 2/4 and 4/4 would have been combined into a single
patch. Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
