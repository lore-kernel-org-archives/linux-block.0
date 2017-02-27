Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as
 specified in the original queue tagset
To: Sagi Grimberg <sagi@grimberg.me>, Omar Sandoval <osandov@osandov.com>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
 <20170227154939.GA10715@vader>
 <4829b70c-53fd-f622-310e-0a30e4ede6fa@kernel.dk>
 <eb51d324-62df-629e-8a7b-fea50ef7543e@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <353bb44b-7180-7a78-47f5-2ebf03b714bc@kernel.dk>
Date: Mon, 27 Feb 2017 09:15:27 -0700
MIME-Version: 1.0
In-Reply-To: <eb51d324-62df-629e-8a7b-fea50ef7543e@grimberg.me>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/27/2017 09:10 AM, Sagi Grimberg wrote:
> 
>>> Hm, this may fix the crash, but I'm not sure it'll work as intended.
>>> When we allocate the request, we'll get a reserved scheduler tag, but
>>> then when we go to dispatch the request and call
>>> blk_mq_get_driver_tag(), we'll be competing with all of the normal
>>> requests for a regular driver tag. So maybe on top of this we should add
>>> the BLK_MQ_REQ_RESERVED flag to the allocation attempt in
>>> blk_mq_get_driver_tag() if the scheduler tag is reserved? I'm hazy on
>>> what we expect from reserved tags, so feel free to call me crazy.
>>
>> Yeah good point, we need to carry it through. Reserved tags exist
>> because drivers often need a request/tag for error handling. If all
>> tags currently are used up for regular IO that is stuck, you need
>> a reserved tag for error handling to guarantee progress.
>>
>> So Sagi's patch does take it half the way there, but get_driver_tag
>> really needs to know about this as well, or we will just get stuck
>> there as well. Two solutions, I can think of:
>>
>> 1) Check the tag value in get_driver_tag, add BLK_MQ_REQ_RESERVED
>>    when allocating a driver tag if above X.
>> 2) Add an RQF_SOMETHING_RESERVED. Add BLK_MQ_REQ_RESERVED in
>>    get_driver_tag if that is set.
>>
>> Comments?
> 
> Can't we just not go through the scheduler for reserved tags? Obviously
> there is no point in scheduling them...

Right, that would be possible. But I'd rather not treat any requests
differently, it's a huge pain in the ass that flush request currently
insert with a driver tag already allocated. So it's not because
scheduling will add anything at all, it's more that I'd like to move
flush requests to use regular inserts as well and not deal with some
request being "special" in any way.

The below should hopefully work. Totally untested...

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 54c84363c1b2..e48bc2c72615 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -181,7 +181,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
 		    struct blk_mq_ctx *ctx, unsigned int tag)
 {
-	if (tag >= tags->nr_reserved_tags) {
+	if (!blk_mq_tag_is_reserved(tags, tag)) {
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 63497423c5cd..5cb51e53cc03 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -85,4 +85,10 @@ static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
 	hctx->tags->rqs[tag] = rq;
 }
 
+static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
+					  unsigned int tag)
+{
+	return tag < tags->nr_reserved_tags;
+}
+
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9611cd9920e9..293e79c1ee95 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -853,6 +853,9 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 		return true;
 	}
 
+	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
+		data.flags |= BLK_MQ_REQ_RESERVED;
+
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
 		if (blk_mq_tag_busy(data.hctx)) {


-- 
Jens Axboe
