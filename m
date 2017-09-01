Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbdIADzz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 23:55:55 -0400
Date: Fri, 1 Sep 2017 11:55:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH 8/9] block: allow to allocate req with REQF_PREEMPT when
 queue is frozen
Message-ID: <20170901035537.GI16525@ming.t460p>
References: <20170831172728.15817-1-ming.lei@redhat.com>
 <20170831172728.15817-9-ming.lei@redhat.com>
 <1504219824.31872.74.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504219824.31872.74.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 31, 2017 at 10:50:25PM +0000, Bart Van Assche wrote:
> On Fri, 2017-09-01 at 01:27 +0800, Ming Lei wrote:
> > @@ -1413,9 +1414,17 @@ static struct request *blk_old_get_request(struct request_queue *q,
> >  	/* create ioc upfront */
> >  	create_io_context(gfp_mask, q->node);
> >  
> > -	ret = blk_queue_enter(q, !(gfp_mask & __GFP_DIRECT_RECLAIM));
> > +	/*
> > +	 * When queue is frozen, we still need to allocate req for
> > +	 * REQF_PREEMPT.
> > +	 */
> > +	if ((flags & BLK_MQ_REQ_PREEMPT) && blk_queue_is_frozen(q))
> > +		blk_queue_enter_live(q);
> > +	else
> > +		ret = blk_queue_enter(q, !(gfp_mask & __GFP_DIRECT_RECLAIM));
> 
> Hello Ming,
> 
> Sorry but I doubt that calling blk_queue_enter_live() from inside
> blk_old_get_request() is safe. Calling blk_queue_enter_live() is only safe
> before a request queue has been marked dead. What prevents a kernel thread
> that holds a reference on a request queue and that is running concurrently
> with blk_cleanup_queue() to call blk_old_get_request() after a queue has
> been marked dead?

I have sent one delta patch in list, which will only call
blk_queue_enter_live() iff SCSI device is in QUIESCE.

-- 
Ming
