Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754769AbdGLC7z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 22:59:55 -0400
Date: Wed, 12 Jul 2017 10:59:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/6] xen-blkfront: avoid to use start/stop queue
Message-ID: <20170712025942.GD13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-2-ming.lei@redhat.com>
 <1499798488.2586.27.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499798488.2586.27.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 06:41:29PM +0000, Bart Van Assche wrote:
> On Wed, 2017-07-12 at 02:20 +0800, Ming Lei wrote:
> > This interfaces will be removed soon, so use quiesce and
> > unquiesce instead, which should be more safe.
> > 
> > The only one usage will be removed in the following
> > congestion control patches.
> 
> Hello Ming,
> 
> The title of this patch is misleading since this patch does not touch the calls
> related to queue congestion (blk_mq_stop_hw_queue() and
> blk_mq_start_stopped_hw_queues()). I assume that you meant that this patch avoids
> that the xen-blkfront driver uses blk_mq_(start|stop)_hw_queues() (with queues in
> plural form)? Can you please reflect that in the subject of this and related
> patches?

OK, will do it in V2.

> 
> Additionally, it's probably a good idea that this is not just an interface change
> but that this kind of patches fix a (hard to trigger?) race condition.
> 
> >  static inline void kick_pending_request_queues_locked(struct blkfront_ring_info *rinfo)
> >  {
> > -	if (!RING_FULL(&rinfo->ring))
> > +	if (!RING_FULL(&rinfo->ring)) {
> >  		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
> > +		blk_mq_kick_requeue_list(rinfo->dev_info->rq);
> > +	}
> >  }
> >  
> >  static void kick_pending_request_queues(struct blkfront_ring_info *rinfo)
> > @@ -1225,7 +1227,8 @@ static void kick_pending_request_queues(struct blkfront_ring_info *rinfo)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&rinfo->ring_lock, flags);
> > -	kick_pending_request_queues_locked(rinfo);
> > +	if (!RING_FULL(&rinfo->ring))
> > +		blk_mq_run_hw_queues(rinfo->dev_info->rq, true);
> >  	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
> >  }
> 
> Why do some kick_pending_request_queues_locked() kick the requeue list and why
> has the above kick_pending_request_queues_locked() call been converted into a
> blk_mq_run_hw_queues() call and thereby ignores the requeue list?

kick_pending_request_queues_locked() is used in req completion path,
which belongs to congestion control, so this patch doesn't touch
kick_pending_request_queues_locked(), which will be switched to
generic congestion control in patch 5.

For kick_pending_request_queues(), this patch replaces
blk_mq_start_stopped_hw_queues() with blk_mq_run_hw_queues()
because run queue is often the real purpose of this function,
especially in non-congestion control path.


Thanks,
Ming
