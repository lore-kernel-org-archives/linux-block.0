Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180116014009.GD3213@ming.t460p>
References: <20180115165810.2515-1-ming.lei@redhat.com> <20180115165810.2515-2-ming.lei@redhat.com>
 <2b698c6c-9d9d-8555-7fe8-272bcdd65086@kernel.dk> <20180116014009.GD3213@ming.t460p>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 16 Jan 2018 12:05:17 +0800
Message-ID: <CACVXFVNKfO6RHkK4_KERUJoeO5SRvgLJYk9V86JwWh62FAWotw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] blk-mq: move actual issue into one helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 16, 2018 at 9:40 AM, Ming Lei <ming.lei@redhat.com> wrote:
> On Mon, Jan 15, 2018 at 10:29:46AM -0700, Jens Axboe wrote:
>> On 1/15/18 9:58 AM, Ming Lei wrote:
>> > No functional change, just to clean up code a bit, so that the following
>> > change of using direct issue for blk_mq_request_bypass_insert() which is
>> > needed by DM can be easier to do.
>> >
>> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> > ---
>> >  block/blk-mq.c | 39 +++++++++++++++++++++++++++------------
>> >  1 file changed, 27 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/block/blk-mq.c b/block/blk-mq.c
>> > index edb1291a42c5..bf8d6651f40e 100644
>> > --- a/block/blk-mq.c
>> > +++ b/block/blk-mq.c
>> > @@ -1696,15 +1696,37 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
>> >     return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
>> >  }
>> >
>> > -static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>> > -                                   struct request *rq,
>> > -                                   blk_qc_t *cookie)
>> > +static blk_status_t __blk_mq_issue_req(struct blk_mq_hw_ctx *hctx,
>> > +                                  struct request *rq,
>> > +                                  blk_qc_t *new_cookie)
>> >  {
>> > +   blk_status_t ret;
>> >     struct request_queue *q = rq->q;
>> >     struct blk_mq_queue_data bd = {
>> >             .rq = rq,
>> >             .last = true,
>> >     };
>> > +
>> > +   if (!blk_mq_get_driver_tag(rq, NULL, false))
>> > +           return BLK_STS_AGAIN;
>> > +
>> > +   if (!blk_mq_get_dispatch_budget(hctx)) {
>> > +           blk_mq_put_driver_tag(rq);
>> > +           return BLK_STS_AGAIN;
>> > +   }
>> > +
>> > +   *new_cookie = request_to_qc_t(hctx, rq);
>> > +
>> > +   ret = q->mq_ops->queue_rq(hctx, &bd);
>> > +
>> > +   return ret;
>>
>>       return q->mq_ops->queue_rq(hctx, &bd);
>>
>> and kill 'ret', it's not used. But more importantly, who puts the
>
> OK.
>
>> driver tag and the budget if we get != OK for ->queue_rq()?
>
> For the budget, the current protocol is that driver is responsible for the
> release once .queue_rq is called, see scsi_mq_queue_rq() and comment in
> blk_mq_do_dispatch_sched().
>
> For driver tag, it is released in blk_mq_free_request(), which is done
> in failure handling of != OK.

Actually the driver tag should be released here when .queue_rq()
returns !OK, and this patch does follow the current logic:

- call __blk_mq_requeue_request() to release tag and make it ready
for requeue if STS_RESOURCE is returned.

- For other !OK cases, let driver free the request.

-- 
Ming Lei
