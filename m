Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35201 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933767AbcLMPUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 10:20:43 -0500
Date: Tue, 13 Dec 2016 08:20:38 -0700
From: Jens Axboe <axboe@fb.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <paolo.valente@linaro.org>, <osandov@fb.com>
Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
Message-ID: <20161213152038.GB32618@kernel.dk>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-6-git-send-email-axboe@fb.com>
 <d013a3c6-39d8-725a-6752-6a02b5284242@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <d013a3c6-39d8-725a-6752-6a02b5284242@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 13 2016, Bart Van Assche wrote:
> On 12/08/2016 09:13 PM, Jens Axboe wrote:
> >+static inline void blk_mq_sched_put_request(struct request *rq)
> >+{
> >+	struct request_queue *q = rq->q;
> >+	struct elevator_queue *e = q->elevator;
> >+
> >+	if (e && e->type->mq_ops.put_request)
> >+		e->type->mq_ops.put_request(rq);
> >+	else
> >+		blk_mq_free_request(rq);
> >+}
> 
> blk_mq_free_request() always triggers a call of blk_queue_exit().
> dd_put_request() only triggers a call of blk_queue_exit() if it is not a
> shadow request. Is that on purpose?

If the scheduler doesn't define get/put requests, then the lifetime
follows the normal setup. If we do define them, then dd_put_request()
only wants to put the request if it's one where we did setup a shadow.

> >+static inline struct request *
> >+blk_mq_sched_get_request(struct request_queue *q, unsigned int op,
> >+			 struct blk_mq_alloc_data *data)
> >+{
> >+	struct elevator_queue *e = q->elevator;
> >+	struct blk_mq_hw_ctx *hctx;
> >+	struct blk_mq_ctx *ctx;
> >+	struct request *rq;
> >+
> >+	blk_queue_enter_live(q);
> >+	ctx = blk_mq_get_ctx(q);
> >+	hctx = blk_mq_map_queue(q, ctx->cpu);
> >+
> >+	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
> >+
> >+	if (e && e->type->mq_ops.get_request)
> >+		rq = e->type->mq_ops.get_request(q, op, data);
> >+	else
> >+		rq = __blk_mq_alloc_request(data, op);
> >+
> >+	if (rq)
> >+		data->hctx->queued++;
> >+
> >+	return rq;
> >+
> >+}
> 
> Some but not all callers of blk_mq_sched_get_request() call blk_queue_exit()
> if this function returns NULL. Please consider to move the blk_queue_exit()
> call from the blk_mq_alloc_request() error path into this function. I think
> that will make it a lot easier to verify whether or not the
> blk_queue_enter() / blk_queue_exit() calls are balanced properly.

Agree, I'll make the change, it'll be easier to read then.

> Additionally, since blk_queue_enter() / blk_queue_exit() calls by
> blk_mq_sched_get_request() and blk_mq_sched_put_request() must be balanced
> and since the latter function only calls blk_queue_exit() for non-shadow
> requests, shouldn't blk_mq_sched_get_request() call blk_queue_enter_live()
> only if __blk_mq_alloc_request() is called?

I'll double check that part, there might be a bug or at least a chance
to clean this up a bit. I did verify most of this at some point, and
tested it with the scheduler switching. That part falls apart pretty
quickly, if the references aren't matched exactly.

-- 
Jens Axboe

