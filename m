Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6095BC433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 03:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2879E21D7E
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 03:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIKDaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:30:15 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56161 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgIKDaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 23:30:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U8YFBwg_1599794999;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0U8YFBwg_1599794999)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Sep 2020 11:30:00 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [RFC] block: enqueue splitted bios into same cpu
Date:   Fri, 11 Sep 2020 11:29:58 +0800
Message-Id: <20200911032958.125068-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Splitted bios of one source bio can be enqueued into different CPU since
the submit_bio() routine can be preempted or fall asleep. However this
behaviour can't work well with iopolling.

Currently block iopolling only polls the hardwar queue of the input bio.
If one bio is splitted to several bios, one (bio 1) of which is enqueued
into CPU A, while the others enqueued into CPU B, then the polling of bio 1
will cotinuously poll the hardware queue of CPU A, though the other
splitted bios may be in other hardware queues.

The iopolling logic has no idea if the input bio is splitted bio, or if
it has other splitted siblings. Thus ensure that all splitted bios are
enqueued into one CPU at the beginning.

This is only one RFC patch and it is not complete since dm/mq-scheduler
have not been considered yet. Please let me know if it is on the correct
direction or not.

Besides I have one question on the split routine. Why the split routine
is implemented in a recursive style? Why we can't split the bio one time
and then submit the *already splitted* bios one by one?

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/bio.c               | 5 +++++
 block/blk-core.c          | 4 +++-
 block/blk-mq-sched.c      | 4 +++-
 block/blk-mq.c            | 6 ++++--
 block/blk-mq.h            | 1 +
 include/linux/blk_types.h | 1 +
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..4580cb23ab7b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -281,6 +281,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 	memset(bio, 0, sizeof(*bio));
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
+	bio->bi_cpu_hint = -1;
 
 	bio->bi_io_vec = table;
 	bio->bi_max_vecs = max_vecs;
@@ -687,6 +688,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
+	bio->bi_cpu_hint = bio_src->bi_cpu_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
@@ -1474,6 +1476,9 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
 		return NULL;
 
+	if (bio->bi_cpu_hint == -1)
+		bio->bi_cpu_hint = raw_smp_processor_id();
+
 	split = bio_clone_fast(bio, gfp, bs);
 	if (!split)
 		return NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..f9d1950678d8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -775,7 +775,9 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 			*same_queue_rq = rq;
 		}
 
-		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
+		if (rq->q != q ||
+		   ((bio->bi_cpu_hint != -1) && (rq->mq_ctx->cpu != bio->bi_cpu_hint)) ||
+		   !blk_rq_merge_ok(rq, bio))
 			continue;
 
 		switch (blk_try_merge(rq, bio)) {
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d2790e5b06d1..c2d6f06792a8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -461,7 +461,9 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct elevator_queue *e = q->elevator;
-	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
+	unsigned int cpu = bio->bi_cpu_hint != -1 ?
+				bio->bi_cpu_hint : raw_smp_processor_id();
+	struct blk_mq_ctx *ctx = __blk_mq_get_ctx(q, cpu);
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
 	bool ret = false;
 	enum hctx_type type;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785eefe9..05716a5195d4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -348,7 +348,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
 	u64 alloc_time_ns = 0;
-	unsigned int tag;
+	unsigned int tag, cpu;
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
@@ -370,7 +370,8 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	}
 
 retry:
-	data->ctx = blk_mq_get_ctx(q);
+	cpu = (data->cpu_hint != -1) ? data->cpu_hint : raw_smp_processor_id();
+	data->ctx = __blk_mq_get_ctx(q, cpu);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
 	if (!e)
 		blk_mq_tag_busy(data->hctx);
@@ -2168,6 +2169,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
+	data.cpu_hint = bio->bi_cpu_hint;
 	rq = __blk_mq_alloc_request(&data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 863a2f3346d4..89c4fd34c0bd 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -152,6 +152,7 @@ struct blk_mq_alloc_data {
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
+	int	     cpu_hint;
 
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f..f81dea9ceb56 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -191,6 +191,7 @@ struct bio {
 	unsigned short		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
+	int			bi_cpu_hint;
 	blk_status_t		bi_status;
 	u8			bi_partno;
 	atomic_t		__bi_remaining;
-- 
2.27.0

