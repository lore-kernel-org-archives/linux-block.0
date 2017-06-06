Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdFFEVi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 00:21:38 -0400
Date: Tue, 6 Jun 2017 12:21:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v4 01/11] blk-mq: fix direct issue
Message-ID: <20170606042121.GB3633@ming.t460p>
References: <20170605155925.7896-1-ming.lei@redhat.com>
 <20170605155925.7896-2-ming.lei@redhat.com>
 <1496697927.2623.23.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496697927.2623.23.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 05, 2017 at 09:25:29PM +0000, Bart Van Assche wrote:
> On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> > +static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > +					struct request *rq,
> > +					blk_qc_t *cookie, bool may_sleep)
> >  {
> >  	struct request_queue *q = rq->q;
> >  	struct blk_mq_queue_data bd = {
> >  		.rq = rq,
> >  		.last = true,
> >  	};
> > -	struct blk_mq_hw_ctx *hctx;
> >  	blk_qc_t new_cookie;
> >  	int ret;
> > +	bool run_queue = true;
> > +
> > +	if (blk_mq_hctx_stopped(hctx)) {
> > +		run_queue = false;
> > +		goto insert;
> > +	}
> >  
> >  	if (q->elevator)
> >  		goto insert;
> >  
> > -	if (!blk_mq_get_driver_tag(rq, &hctx, false))
> > +	if (!blk_mq_get_driver_tag(rq, NULL, false))
> >  		goto insert;
> >  
> >  	new_cookie = request_to_qc_t(hctx, rq);
> > @@ -1439,7 +1445,7 @@ static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
> >  
> >  	__blk_mq_requeue_request(rq);
> >  insert:
> > -	blk_mq_sched_insert_request(rq, false, true, false, may_sleep);
> > +	blk_mq_sched_insert_request(rq, false, run_queue, false, may_sleep);
> >  }
> >  
> >  static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > @@ -1447,7 +1453,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >  {
> >  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> >  		rcu_read_lock();
> > -		__blk_mq_try_issue_directly(rq, cookie, false);
> > +		__blk_mq_try_issue_directly(hctx, rq, cookie, false);
> >  		rcu_read_unlock();
> >  	} else {
> >  		unsigned int srcu_idx;
> > @@ -1455,7 +1461,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >  		might_sleep();
> >  
> >  		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> > -		__blk_mq_try_issue_directly(rq, cookie, true);
> > +		__blk_mq_try_issue_directly(hctx, rq, cookie, true);
> >  		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> >  	}
> >  }
> 
> Hello Ming,
> 
> It seems like you are assuming that the hardware queue of the rq argument
> passed to __blk_mq_try_issue_directly() matches the hctx argument? Sorry
> but I think that's an incorrect assumption. Please have a look at the
> following code in blk_mq_make_request():
> 
> 		if (same_queue_rq)
> 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
> 					&cookie);

IMO it is a bug which need to be fixed, since
blk_mq_try_issue_directly() may take a wrong SRCU lock
and performance can be hurt under this situation.

Thanks,
Ming
