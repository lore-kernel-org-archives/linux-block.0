Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdFBCC0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jun 2017 22:02:26 -0400
Date: Fri, 2 Jun 2017 10:02:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v3 5/9] blk-mq: fix blk_mq_quiesce_queue
Message-ID: <20170602020210.GF30505@ming.t460p>
References: <20170531123706.20885-1-ming.lei@redhat.com>
 <20170531123706.20885-6-ming.lei@redhat.com>
 <1496245049.2608.7.camel@sandisk.com>
 <20170601022133.GB23563@ming.t460p>
 <1496359149.3075.14.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496359149.3075.14.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 01, 2017 at 11:19:11PM +0000, Bart Van Assche wrote:
> On Thu, 2017-06-01 at 10:21 +0800, Ming Lei wrote:
> > On Wed, May 31, 2017 at 03:37:30PM +0000, Bart Van Assche wrote:
> > > On Wed, 2017-05-31 at 20:37 +0800, Ming Lei wrote:
> > > > 
> > > > +	/* wait until queue is unquiesced */
> > > > +	wait_event_cmd(q->quiesce_wq, !blk_queue_quiesced(q),
> > > > +			may_sleep ?
> > > > +			srcu_read_unlock(&hctx->queue_rq_srcu, *srcu_idx) :
> > > > +			rcu_read_unlock(),
> > > > +			may_sleep ?
> > > > +			*srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu) :
> > > > +			rcu_read_lock());
> > > > +
> > > >  	if (q->elevator)
> > > >  		goto insert;
> > > 
> > > What I see is that in this patch a new waitqueue has been introduced
> > > (quiesce_wq) and also that an explanation of why you think this new waitqueue
> > > is needed is missing completely. Why is it that you think that the
> > > synchronize_scru() and synchronize_rcu() calls in blk_mq_quiesce_queue() are
> > > not sufficient? If this new waitqueue is not needed, please remove that
> > > waitqueue again.
> > 
> > OK, the reason is simple, and it is only related with direct issue.
> > 
> > Under this situation, when the queue is quiesced, we have to
> > 
> > 	- insert the current request into sw queue(scheduler queue)
> > 	OR
> > 	-wait until queue becomes unquiesced like what this patch is doing
> > 
> > The disadvantage of the 1st way is that we have to consider to run queue
> > again in blk_mq_unquiesce_queue() for the queued requests during quiescing.
> > 
> > For the 2nd way(what this patch is doing), one benefit is that application
> > can avoid to submit I/O to a quiesced queue. Another benefit is that we
> > needn't to consider to run queue in blk_mq_unquiesce_queue(). But with cost
> > of one waitqueue, the cost should be cheap, but if you persist on the 1st
> > approach, I am fine to change to that.
> 
> Hello Ming,
> 
> Since the runtime overhead of the alternative approach (insert into queue) is
> significantly smaller and since it will result in a simpler implementation I
> prefer the alternative approach.

OK, no problem, will change to the way of insert & run queue.

Thanks,
Ming
