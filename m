Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 27 Feb 2017 09:04:34 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] blk-mq: make sure to back-assign the request to
 rq_map in blk_mq_alloc_request_hctx
Message-ID: <20170227170434.GE10715@vader>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
 <1488209781-1084-2-git-send-email-sagi@grimberg.me>
 <20170227165959.GD10715@vader>
 <ad451231-eca0-3f25-fd82-1db44acc1cd9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ad451231-eca0-3f25-fd82-1db44acc1cd9@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 27, 2017 at 10:03:29AM -0700, Jens Axboe wrote:
> On 02/27/2017 09:59 AM, Omar Sandoval wrote:
> > On Mon, Feb 27, 2017 at 05:36:21PM +0200, Sagi Grimberg wrote:
> >> Otherwise we won't be able to retrieve the request from
> >> the tag.
> >>
> >> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >> ---
> >>  block/blk-mq.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index d84c66fb37b7..9611cd9920e9 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -312,6 +312,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> >>  		ret = -EWOULDBLOCK;
> >>  		goto out_queue_exit;
> >>  	}
> >> +	alloc_data.hctx->tags->rqs[rq->tag] = rq;
> >>  
> >>  	return rq;
> >>  
> >> -- 
> >> 2.7.4
> > 
> > This one I think is a little bit cleaner if we just push that assignment
> > into __blk_mq_alloc_request() like this (again, compile tested only):
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 98c7b061781e..7267c9c23529 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -135,8 +135,6 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
> >  			rq = __blk_mq_alloc_request(data, op);
> >  	} else {
> >  		rq = __blk_mq_alloc_request(data, op);
> > -		if (rq)
> > -			data->hctx->tags->rqs[rq->tag] = rq;
> >  	}
> >  
> >  	if (rq) {
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 9e6b064e5339..b4cf9dfa926b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -234,6 +234,7 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
> >  			}
> >  			rq->tag = tag;
> >  			rq->internal_tag = -1;
> > +			data->hctx->tags->rqs[rq->tag] = rq;
> >  		}
> >  
> >  		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
> 
> Agree, let's keep that in one place, if we can.
> 
> > Looking a little closer at the caller, though, this is kind of weird:
> > 
> > struct request *nvme_alloc_request(struct request_queue *q,
> > 		struct nvme_command *cmd, unsigned int flags, int qid)
> > {
> > 	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
> > 	struct request *req;
> > 
> > 	if (qid == NVME_QID_ANY) {
> > 		req = blk_mq_alloc_request(q, op, flags);
> > 	} else {
> > 		req = blk_mq_alloc_request_hctx(q, op, flags,
> > 				qid ? qid - 1 : 0);
> > 	}
> > 	if (IS_ERR(req))
> > 		return req;
> > 
> > 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> > 	nvme_req(req)->cmd = cmd;
> > 
> > 	return req;
> > }
> > 
> > In the "any" case, we allocate a request with a scheduler tag and go
> > through the scheduler as usual. In the hctx case, we're getting a
> > request with a driver tag, meaning we go through the
> > blk_mq_sched_bypass_insert() path when we run the request.
> > 
> > There's nothing really wrong about that, it just seems weird. Not sure
> > if it's weird enough to act on :)
> 
> That's just broken, we need to fix that up. _hctx() request alloc
> should return scheduler request as well.
> 
> Omar, care to rework patch #1 and incorporate a fix for the hctx
> alloc? Then I'll fix up patch #2, adding the carry-over of the
> reserved flag. We'll just rebase for-linus, it's not a stable
> branch.

Will do, I'll make sure to add Sagi's reported-by.
