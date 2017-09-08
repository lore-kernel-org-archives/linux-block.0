Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32924 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932381AbdIHUyu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2017 16:54:50 -0400
Received: by mail-pf0-f173.google.com with SMTP id y29so5432855pff.0
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2017 13:54:50 -0700 (PDT)
Date: Fri, 8 Sep 2017 13:54:48 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 01/14] blk-mq-sched: fix scheduler bad performance
Message-ID: <20170908205448.GC13673@vader.DHCP.thefacebook.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-2-ming.lei@redhat.com>
 <20170908204832.GB13673@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908204832.GB13673@vader.DHCP.thefacebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 08, 2017 at 01:48:32PM -0700, Omar Sandoval wrote:
> On Sat, Sep 02, 2017 at 11:17:16PM +0800, Ming Lei wrote:
> > When hw queue is busy, we shouldn't take requests from
> > scheduler queue any more, otherwise it is difficult to do
> > IO merge.
> > 
> > This patch fixes the awful IO performance on some
> > SCSI devices(lpfc, qla2xxx, ...) when mq-deadline/kyber
> > is used by not taking requests if hw queue is busy.
> > 
> > Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> 
> Jens and I did some testing with xfs/297 and couldn't find any issues,
> so
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>

I take it back, the comment below needs to be updated

> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-sched.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 4ab69435708c..845e5baf8af1 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -94,7 +94,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	struct request_queue *q = hctx->queue;
> >  	struct elevator_queue *e = q->elevator;
> >  	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
> > -	bool did_work = false;
> > +	bool do_sched_dispatch = true;
> >  	LIST_HEAD(rq_list);
> >  
> >  	/* RCU or SRCU read lock is needed before checking quiesced flag */
> > @@ -125,7 +125,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	 */
> >  	if (!list_empty(&rq_list)) {
> >  		blk_mq_sched_mark_restart_hctx(hctx);
> > -		did_work = blk_mq_dispatch_rq_list(q, &rq_list);
> > +		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> >  	} else if (!has_sched_dispatch) {
> >  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
> >  		blk_mq_dispatch_rq_list(q, &rq_list);
> > @@ -136,7 +136,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	 * on the dispatch list, OR if we did have work but weren't able
> >  	 * to make progress.
> >  	 */

This should be updated to say:

We want to dispatch from the scheduler if there was nothing on the
dispatch list or we were able to dispatch from the dispatch list.

> > -	if (!did_work && has_sched_dispatch) {
> > +	if (do_sched_dispatch && has_sched_dispatch) {
> >  		do {
> >  			struct request *rq;
> >  
> > -- 
> > 2.9.5
> > 
