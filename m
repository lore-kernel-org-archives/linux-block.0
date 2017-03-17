Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22006 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdCQX0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 19:26:36 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "yizhan@redhat.com" <yizhan@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting
 dying
Date: Fri, 17 Mar 2017 23:26:26 +0000
Message-ID: <1489793173.2826.23.camel@sandisk.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
         <20170317095711.5819-4-tom.leiming@gmail.com>
In-Reply-To: <20170317095711.5819-4-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-03-17 at 17:57 +0800, Ming Lei wrote:
> Given blk_set_queue_dying() is always called in remove path
> of block device, and queue will be cleaned up later, we don't
> need to worry about undoing the counter.
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d772c221cc17..62d4967c369f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -500,9 +500,12 @@ void blk_set_queue_dying(struct request_queue *q)
>  	queue_flag_set(QUEUE_FLAG_DYING, q);
>  	spin_unlock_irq(q->queue_lock);
> =20
> -	if (q->mq_ops)
> +	if (q->mq_ops) {
>  		blk_mq_wake_waiters(q);
> -	else {
> +
> +		/* block new I/O coming */
> +		blk_mq_freeze_queue_start(q);
> +	} else {
>  		struct request_list *rl;
> =20
>  		spin_lock_irq(q->queue_lock);

Hello Ming,

The blk_freeze_queue() call in blk_cleanup_queue() waits until q_usage_coun=
ter
drops to zero. Since the above blk_mq_freeze_queue_start() call increases t=
hat
counter by one, how is blk_freeze_queue() expected to finish ever?

Bart.=
