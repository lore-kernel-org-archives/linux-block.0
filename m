Return-Path: <axboe@kernel.dk>
Subject: Re: Regression: nvme timeouts and oopses
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
 <6cd8bb58-6749-02e2-ee27-46d8813cbfd2@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <01578594-1b99-a80d-8032-c18a67f1ed3f@kernel.dk>
Date: Fri, 11 Nov 2016 12:24:12 -0700
MIME-Version: 1.0
In-Reply-To: <6cd8bb58-6749-02e2-ee27-46d8813cbfd2@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/11/2016 12:18 PM, Jens Axboe wrote:
> On 11/11/2016 11:47 AM, Jens Axboe wrote:
>> Hi,
>>
>> I've been running into problems when stability testing my 4.10 branch,
>> and I finally got an easy reproducer today (on the laptop, no less) and
>> was able to bisect it. Boils down to this:
>>
>> 2253efc850c4cf690516bbc07854eeb1077202ba is the first bad commit
>> commit 2253efc850c4cf690516bbc07854eeb1077202ba
>> Author: Bart Van Assche <bart.vanassche@sandisk.com>
>> Date:   Fri Oct 28 17:20:02 2016 -0700
>>
>>     blk-mq: Move more code into blk_mq_direct_issue_request()
>
> I think I see what it is - you're grabbing a request off the plug list,
> and then you assume that it's the same hardware queue. That's not safe.
> So you end up issuing a request from hwq A to hwq B, oops. Let me test
> that theory with a patch.

Yep that's it. With the below patch, things work fine again.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d180c989a0e5..77110aed24ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1291,11 +1291,11 @@ static struct request *blk_mq_map_request(struct 
request_queue *q,
  	return rq;
  }

-static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-				      struct request *rq, blk_qc_t *cookie)
+static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
  {
  	int ret;
  	struct request_queue *q = rq->q;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
  	struct blk_mq_queue_data bd = {
  		.rq = rq,
  		.list = NULL,
@@ -1414,11 +1414,11 @@ static blk_qc_t blk_mq_make_request(struct 
request_queue *q, struct bio *bio)

  		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
  			rcu_read_lock();
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+			blk_mq_try_issue_directly(old_rq, &cookie);
  			rcu_read_unlock();
  		} else {
  			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+			blk_mq_try_issue_directly(old_rq, &cookie);
  			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
  		}
  		goto done;

-- 
Jens Axboe
