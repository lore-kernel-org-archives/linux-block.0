Return-Path: <axboe@kernel.dk>
Date: Thu, 15 Dec 2016 13:14:36 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	paolo.valente@linaro.org, osandov@fb.com
Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
Message-ID: <20161215201436.GA29056@kernel.dk>
References: <1481779568-10642-1-git-send-email-axboe@fb.com>
 <1481779568-10642-6-git-send-email-axboe@fb.com>
 <20161215192940.GA29747@vader.dhcp.TheFacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161215192940.GA29747@vader.dhcp.TheFacebook.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 15 2016, Omar Sandoval wrote:
> Hey, Jens, a couple of minor nits below.
> 
> One bigger note: adding the blk_mq_sched_*() helpers and keeping the
> blk_mq_*() helpers that they replaced seems risky. For example,
> blk_mq_free_request() is superseded by blk_mq_sched_put_request(), but
> we kept blk_mq_free_request(). There are definitely some codepaths that
> are still using blk_mq_free_request() that are now wrong
> (__nvme_submit_user_cmd() is the most obvious one I saw).
> 
> Can we get rid of the old, non-sched functions? Or maybe even make old
> interface do the sched stuff instead of adding blk_mq_sched_*()?

You are right, that is a concern. I'll think of some ways to lessen that
risk, it's much better to have build time breakage than runtime.

> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 8d1cec8e25d1..d10a246a3bc7 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2267,10 +2229,10 @@ static int blk_mq_queue_reinit_dead(unsigned int cpu)
> >   * Now CPU1 is just onlined and a request is inserted into ctx1->rq_list
> >   * and set bit0 in pending bitmap as ctx1->index_hw is still zero.
> >   *
> > - * And then while running hw queue, flush_busy_ctxs() finds bit0 is set in
> > - * pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
> > - * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list
> > - * is ignored.
> > + * And then while running hw queue, blk_mq_flush_busy_ctxs() finds bit0 is set
> > + * in pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
> > + * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list is
> > + * ignored.
> >   */
> 
> This belongs in patch 4 where flush_busy_ctxs() got renamed.

Fixed, thanks!

> >  static int blk_mq_queue_reinit_prepare(unsigned int cpu)
> >  {
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index e59f5ca520a2..a5ddc860b220 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -47,6 +47,9 @@ struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
> >   */
> >  void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
> >  				bool at_head);
> > +void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
> > +				struct list_head *list);
> > +void blk_mq_process_sw_list(struct blk_mq_hw_ctx *hctx);
> 
> Looks like the declaration of blk_mq_process_sw_list() survived a rebase
> even though it doesn't exist anymore.

Indeed, now killed.

-- 
Jens Axboe
