Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1995 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdH3PkJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 11:40:09 -0400
Date: Wed, 30 Aug 2017 23:39:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH 1/2] blk-mq: add requests in the tail of hctx->dispatch
Message-ID: <20170830153929.GB14684@ming.t460p>
References: <20170830151935.24253-1-ming.lei@redhat.com>
 <20170830151935.24253-3-ming.lei@redhat.com>
 <567ad683-d577-1817-cf96-eff5aaf47db6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <567ad683-d577-1817-cf96-eff5aaf47db6@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 30, 2017 at 09:22:42AM -0600, Jens Axboe wrote:
> On 08/30/2017 09:19 AM, Ming Lei wrote:
> > It is more reasonable to add requests to ->dispatch in way
> > of FIFO style, instead of LIFO style.
> > 
> > Also in this way, we can allow to insert request at the front
> > of hw queue, which function is needed to fix one bug
> > in blk-mq's implementation of blk_execute_rq()
> > 
> > Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-sched.c | 2 +-
> >  block/blk-mq.c       | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 4ab69435708c..8d97df40fc28 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -272,7 +272,7 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
> >  	 * the dispatch list.
> >  	 */
> >  	spin_lock(&hctx->lock);
> > -	list_add(&rq->queuelist, &hctx->dispatch);
> > +	list_add_tail(&rq->queuelist, &hctx->dispatch);
> >  	spin_unlock(&hctx->lock);
> >  	return true;
> >  }
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 4603b115e234..fed3d0c16266 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1067,7 +1067,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
> >  		blk_mq_put_driver_tag(rq);
> >  
> >  		spin_lock(&hctx->lock);
> > -		list_splice_init(list, &hctx->dispatch);
> > +		list_splice_tail_init(list, &hctx->dispatch);
> >  		spin_unlock(&hctx->lock);
> 
> I'm not convinced this is safe, there's actually a reason why the
> request is added to the front and not the back. We do have
> reorder_tags_to_front() as a safe guard, but I'd much rather get rid of

reorder_tags_to_front() is for reordering the requests in current list,
this patch is for splicing list into hctx->dispatch, so I can't see
it isn't safe, or could you explain it a bit?

> that than make this change.
> 
> What's your reasoning here? Your changelog doesn't really explain why

Firstly the 2nd patch need to add one rq(such as RQF_PM) to the
front of the hw queue, the simple way is to add it to the front
of hctx->dispatch. Without this change, the 2nd patch can't work
at all.

Secondly this way is still reasonable:

	- one rq is added to hctx->dispatch because queue is busy
	- another rq is added to hctx->dispatch too because of same reason

so it is reasonable to to add list into hctx->dispatch in FIFO style.

Finally my patchset for 'improving SCSI-MQ perf' will change to not
dequeue rq from sw/scheduler if ->dispatch isn't flushed. I believe
it is reasonable and correct thing to do, with that change, there
won't be difference between the two styles.


-- 
Ming
