Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbdIVCP4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 22:15:56 -0400
Date: Fri, 22 Sep 2017 10:15:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 05/14] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170922021539.GL6854@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-6-ming.lei@redhat.com>
 <937c6abf-8438-5e04-76a6-8485eb8be141@kernel.dk>
 <20170920122057.GA27867@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920122057.GA27867@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 20, 2017 at 08:20:58PM +0800, Ming Lei wrote:
> On Tue, Sep 19, 2017 at 02:37:50PM -0600, Jens Axboe wrote:
> > On 09/02/2017 09:17 AM, Ming Lei wrote:
> > > @@ -142,18 +178,31 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > >  	if (!list_empty(&rq_list)) {
> > >  		blk_mq_sched_mark_restart_hctx(hctx);
> > >  		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> > > -	} else if (!has_sched_dispatch) {
> > > +	} else if (!has_sched_dispatch && !q->queue_depth) {
> > > +		/*
> > > +		 * If there is no per-request_queue depth, we
> > > +		 * flush all requests in this hw queue, otherwise
> > > +		 * pick up request one by one from sw queue for
> > > +		 * avoiding to mess up I/O merge when dispatch
> > > +		 * is busy, which can be triggered easily by
> > > +		 * per-request_queue queue depth
> > > +		 */
> > >  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
> > >  		blk_mq_dispatch_rq_list(q, &rq_list);
> > >  	}
> > 
> > I don't like this part at all. It's a heuristic, and on top of that,
> > it's a heuristic based on a weak assumption that if q->queue_depth == 0,
> > then we never run into BUSY constraints. I think that would be stronger
> > if it was based on "is this using shared tags", but even that is not
> > great at all. It's perfectly possible to have a shared tags setup and
> > never run into resource constraints. The opposite condition is also true
> > - you can run without shared tags, and yet hit resource constraints
> > constantly. Hence this is NOT a good test for deciding whether to flush
> > everything at once or not. In short, I think a much better test case
> > would be "has this device ever returned BLK_STS_RESOURCE. As it so
> > happens, that's easy enough to keep track of and base this test on.
> 
> Hi Jens,
> 
> The attached patch follows your suggestion, and uses EWMA to
> compute the average length of hctx->dispatch, then only flush
> all requests from ctxs if the average length is zero, what do
> you think about this approach? Or other suggestions?

Hi Jens,

I am going to prepare for V5, as suggested by Omar.

Could you suggest which way you prefer to?  Keeping to check
q->queue_depth, or the approach of using average length of
hctx->dispath, or others? 


-- 
Ming
