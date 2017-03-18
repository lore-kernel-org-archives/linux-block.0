Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35179 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdCRBHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 21:07:47 -0400
Date: Sat, 18 Mar 2017 09:01:00 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting
 dying
Message-ID: <20170318010058.GA3430@ming.t460p>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
 <20170317095711.5819-4-tom.leiming@gmail.com>
 <1489793173.2826.23.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489793173.2826.23.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 17, 2017 at 11:26:26PM +0000, Bart Van Assche wrote:
> On Fri, 2017-03-17 at 17:57 +0800, Ming Lei wrote:
> > Given blk_set_queue_dying() is always called in remove path
> > of block device, and queue will be cleaned up later, we don't
> > need to worry about undoing the counter.
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index d772c221cc17..62d4967c369f 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -500,9 +500,12 @@ void blk_set_queue_dying(struct request_queue *q)
> >  	queue_flag_set(QUEUE_FLAG_DYING, q);
> >  	spin_unlock_irq(q->queue_lock);
> >  
> > -	if (q->mq_ops)
> > +	if (q->mq_ops) {
> >  		blk_mq_wake_waiters(q);
> > -	else {
> > +
> > +		/* block new I/O coming */
> > +		blk_mq_freeze_queue_start(q);
> > +	} else {
> >  		struct request_list *rl;
> >  
> >  		spin_lock_irq(q->queue_lock);
> 
> Hello Ming,
> 
> The blk_freeze_queue() call in blk_cleanup_queue() waits until q_usage_counter
> drops to zero. Since the above blk_mq_freeze_queue_start() call increases that
> counter by one, how is blk_freeze_queue() expected to finish ever?

It is q->mq_freeze_depth which is increased by blk_mq_freeze_queue_start(), not
q->q_usage_counter, otherwise blk_freeze_queue() would never return, :-)

Thanks,
Ming
