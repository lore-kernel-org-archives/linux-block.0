Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63538 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCXRYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:24:52 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2 2/4] block: add a read barrier in blk_queue_enter()
Date: Fri, 24 Mar 2017 17:24:41 +0000
Message-ID: <1490376267.3312.1.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
         <20170324123621.5227-3-tom.leiming@gmail.com>
In-Reply-To: <20170324123621.5227-3-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-03-24 at 20:36 +0800, Ming Lei wrote:
> Without the barrier, reading DEAD flag of .q_usage_counter
> and reading .mq_freeze_depth may be reordered, then the
> following wait_event_interruptible() may never return.
>=20
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ad388d5e309a..44eed17319c0 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -669,6 +669,14 @@ int blk_queue_enter(struct request_queue *q, bool no=
wait)
>  		if (nowait)
>  			return -EBUSY;
> =20
> +		/*
> +		 * read pair of barrier in blk_mq_freeze_queue_start(),
> +		 * we need to order reading DEAD flag of .q_usage_counter
> +		 * and reading .mq_freeze_depth, otherwise the following
> +		 * wait may never return if the two read are reordered.
> +		 */
> +		smp_rmb();
> +
>  		ret =3D wait_event_interruptible(q->mq_freeze_wq,
>  				!atomic_read(&q->mq_freeze_depth) ||
>  				blk_queue_dying(q));

Hello Ming,

The code looks fine to me but the comment not. You probably wanted to refer
to the "dying" flag instead of the "dead" flag? The read order has to be
enforced for the "dying" flag and q_usage_counter because of the order in
which these are set by blk_set_queue_dying().

Thanks,

Bart.=
