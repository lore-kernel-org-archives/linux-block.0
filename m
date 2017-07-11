Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20242 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbdGKSlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 14:41:32 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/6] xen-blkfront: avoid to use start/stop queue
Date: Tue, 11 Jul 2017 18:41:29 +0000
Message-ID: <1499798488.2586.27.camel@wdc.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
         <20170711182103.11461-2-ming.lei@redhat.com>
In-Reply-To: <20170711182103.11461-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-07-12 at 02:20 +0800, Ming Lei wrote:
> This interfaces will be removed soon, so use quiesce and
> unquiesce instead, which should be more safe.
>=20
> The only one usage will be removed in the following
> congestion control patches.

Hello Ming,

The title of this patch is misleading since this patch does not touch the c=
alls
related to queue congestion (blk_mq_stop_hw_queue() and
blk_mq_start_stopped_hw_queues()). I assume that you meant that this patch =
avoids
that the xen-blkfront driver uses blk_mq_(start|stop)_hw_queues() (with que=
ues in
plural form)? Can you please reflect that in the subject of this and relate=
d
patches?

Additionally, it's probably a good idea that this is not just an interface =
change
but that this kind of patches fix a (hard to trigger?) race condition.

>  static inline void kick_pending_request_queues_locked(struct blkfront_ri=
ng_info *rinfo)
>  {
> -	if (!RING_FULL(&rinfo->ring))
> +	if (!RING_FULL(&rinfo->ring)) {
>  		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
> +		blk_mq_kick_requeue_list(rinfo->dev_info->rq);
> +	}
>  }
> =20
>  static void kick_pending_request_queues(struct blkfront_ring_info *rinfo=
)
> @@ -1225,7 +1227,8 @@ static void kick_pending_request_queues(struct blkf=
ront_ring_info *rinfo)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&rinfo->ring_lock, flags);
> -	kick_pending_request_queues_locked(rinfo);
> +	if (!RING_FULL(&rinfo->ring))
> +		blk_mq_run_hw_queues(rinfo->dev_info->rq, true);
>  	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
>  }

Why do some kick_pending_request_queues_locked() kick the requeue list and =
why
has the above kick_pending_request_queues_locked() call been converted into=
 a
blk_mq_run_hw_queues() call and thereby ignores the requeue list?

Thanks,

Bart.=
