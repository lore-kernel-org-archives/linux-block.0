Return-Path: <ming.lei@redhat.com>
Date: Wed, 23 May 2018 17:32:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
Message-ID: <20180523093225.GA32067@ming.t460p>
References: <20180519074406.6045-1-ming.lei@redhat.com>
 <7a4499e8-60bb-892a-91cf-f2d2c4be74b7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a4499e8-60bb-892a-91cf-f2d2c4be74b7@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 09:59:17PM -0600, Jens Axboe wrote:
> On 5/19/18 1:44 AM, Ming Lei wrote:
> > When the allocation process is scheduled back and the mapped hw queue is
> > changed, do one extra wake up on orignal queue for compensating wake up
> > miss, so other allocations on the orignal queue won't be starved.
> > 
> > This patch fixes one request allocation hang issue, which can be
> > triggered easily in case of very low nr_request.
> 
> Trying to think of better ways we can fix this, but I don't see
> any right now. Getting rid of the wake_up_nr() kills us on tons
> of tasks waiting. 

I am not sure if I understand your point, but this issue isn't related
with wake_up_nr() actually, and it can be reproduced after reverting
4e5dff41be7b5201c1c47c (blk-mq: improve heavily contended tag case).

All tasks in current sbq_wait_state may be scheduled to other CPUs, and
there may still be tasks waiting for allocation from this sbitmap_queue,
and the root cause is about cross-queue allocation, as you said,
there are too many queues, :-)

> Maybe it might be possible to only go through
> the fake wakeup IFF we have a task waiting on the list, that'd
> spare us the atomic dec and cmpxchg for all cases except if we
> have a task (or more) waiting on the existing wait state.

sbq_wake_ptr() checks if there are waiting tasks, and it will do
nothing if there isn't any.

In theory, the fake wakeup is only needed when the current wakeup
is triggered by the last in-flight request, but it isn't cheap
to figure out that accurately.

Given it is quite unusual to schedule process from one CPU to another,
and the cost of process migration can be much bigger than the wakeup,
I guess we may not need to worry about the performance effect.

> 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 336dde07b230..77607f89d205 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -134,6 +134,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >  	ws = bt_wait_ptr(bt, data->hctx);
> >  	drop_ctx = data->ctx == NULL;
> >  	do {
> > +		struct sbitmap_queue *bt_orig;
> 
> This should be called 'bt_prev'.

OK.

> 
> > diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> > index 841585f6e5f2..b23f50355281 100644
> > --- a/include/linux/sbitmap.h
> > +++ b/include/linux/sbitmap.h
> > @@ -484,6 +484,13 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
> >  void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
> >  
> >  /**
> > + * sbitmap_wake_up() - Do a regular wake up compensation if the queue
> > + * allocated from is changed after scheduling back.
> > + * @sbq: Bitmap queue to wake up.
> > + */
> > +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
> 
> The blk-mq issue is bleeding into sbitmap here. This should just detail
> that this issues a wakeup, similar to how freeing a tag would

Right, will fix it in V3.

Thanks,
Ming
