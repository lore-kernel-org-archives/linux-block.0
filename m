Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D0C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8090220B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfGAPrk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:47:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38738 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:47:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id 9so6800849ple.5
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 08:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6l5H13mSrsfRuQLIOpDmNymlYRBWRD7fHHSApahp8XY=;
        b=rQ/sAJdWZKrw8bzIvSkaJbhRYmSCOvyPwCumNGNfmmKfPGFQ3lKHI5tgjqd9AIUvrl
         23ruD1vPQHxXXpHN9xq/fPL7y1IrkwmwC2Y8vvBtg5CXy1Zwkl677BRGoOPCK9Tqtmke
         zHczmqiYIrQpXAHgKU1q41tKu8exqhCCs2s6NX5UoELNxCYrONi9rv5l1KqoAAVSW6jK
         fA3yhjLa4errcKPBgcr30tumpxlJyzWuCXU2krEzVoJHPN5SYaQ6229CP0ZE1EQ2aEzC
         5zoQTX/r+6ASD73JoMyLha16my/ck+5jJJvd16IMp1EKfltZmKvFoUIsZlS9EgKjhIMU
         6ENw==
X-Gm-Message-State: APjAAAUlSuV8NJSAVjxucL1Kir+a18VM2Xp8aPjvf+O5whPUQZoQWQ/E
        UgHg51cPwH3CrBA+LQRo/uA=
X-Google-Smtp-Source: APXvYqwGXa7iN/h3CIi3BKAig/ZBWz5PFmPE78qUDMgP0nL+Y6qO58suDSFShGXtJDZKG1ESMs3j6w==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr28977664plk.180.1561996058935;
        Mon, 01 Jul 2019 08:47:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x7sm11469103pfa.125.2019.07.01.08.47.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:47:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
Date:   Mon,  1 Jul 2019 08:47:29 -0700
Message-Id: <20190701154730.203795-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701154730.203795-1-bvanassche@acm.org>
References: <20190701154730.203795-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No code that occurs between blk_mq_get_ctx() and blk_mq_put_ctx() depends
on preemption being disabled for its correctness. Since removing the CPU
preemption calls does not measurably affect performance, simplify the
blk-mq code by removing the blk_mq_put_ctx() function and also by not
disabling preemption in blk_mq_get_ctx().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sched.c  |  5 +----
 block/blk-mq-tag.c    |  8 --------
 block/blk-mq.c        | 16 +++-------------
 block/blk-mq.h        |  7 +------
 block/kyber-iosched.c |  1 -
 5 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 956a7aa9a637..c9d183d6c499 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -330,10 +330,8 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	bool ret = false;
 	enum hctx_type type;
 
-	if (e && e->type->ops.bio_merge) {
-		blk_mq_put_ctx(ctx);
+	if (e && e->type->ops.bio_merge)
 		return e->type->ops.bio_merge(hctx, bio, nr_segs);
-	}
 
 	type = hctx->type;
 	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
@@ -344,7 +342,6 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		spin_unlock(&ctx->lock);
 	}
 
-	blk_mq_put_ctx(ctx);
 	return ret;
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7513c8eaabee..da19f0bc8876 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -113,7 +113,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	struct sbq_wait_state *ws;
 	DEFINE_SBQ_WAIT(wait);
 	unsigned int tag_offset;
-	bool drop_ctx;
 	int tag;
 
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
@@ -136,7 +135,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		return BLK_MQ_TAG_FAIL;
 
 	ws = bt_wait_ptr(bt, data->hctx);
-	drop_ctx = data->ctx == NULL;
 	do {
 		struct sbitmap_queue *bt_prev;
 
@@ -161,9 +159,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
-		if (data->ctx)
-			blk_mq_put_ctx(data->ctx);
-
 		bt_prev = bt;
 		io_schedule();
 
@@ -189,9 +184,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		ws = bt_wait_ptr(bt, data->hctx);
 	} while (1);
 
-	if (drop_ctx && data->ctx)
-		blk_mq_put_ctx(data->ctx);
-
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2f0b14d2ecdc..4d661545ad1d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -359,13 +359,13 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
-	bool put_ctx_on_error = false;
+	bool clear_ctx_on_error = false;
 
 	blk_queue_enter_live(q);
 	data->q = q;
 	if (likely(!data->ctx)) {
 		data->ctx = blk_mq_get_ctx(q);
-		put_ctx_on_error = true;
+		clear_ctx_on_error = true;
 	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
@@ -391,10 +391,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
-		if (put_ctx_on_error) {
-			blk_mq_put_ctx(data->ctx);
+		if (clear_ctx_on_error)
 			data->ctx = NULL;
-		}
 		blk_queue_exit(q);
 		return NULL;
 	}
@@ -431,8 +429,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
-	blk_mq_put_ctx(alloc_data.ctx);
-
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
@@ -1981,7 +1977,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	plug = current->plug;
 	if (unlikely(is_flush_fua)) {
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio, nr_segs);
 
 		/* bypass scheduler for flush rq */
@@ -1995,7 +1990,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio, nr_segs);
 
 		if (!request_count)
@@ -2029,8 +2023,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_add_rq_to_plug(plug, rq);
 		trace_block_plug(q);
 
-		blk_mq_put_ctx(data.ctx);
-
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			trace_block_unplug(q, 1, true);
@@ -2039,11 +2031,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio, nr_segs);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio, nr_segs);
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 633a5a77ee8b..f4bf5161333e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -151,12 +151,7 @@ static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
  */
 static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 {
-	return __blk_mq_get_ctx(q, get_cpu());
-}
-
-static inline void blk_mq_put_ctx(struct blk_mq_ctx *ctx)
-{
-	put_cpu();
+	return __blk_mq_get_ctx(q, raw_smp_processor_id());
 }
 
 struct blk_mq_alloc_data {
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 3c2602601741..34dcea0ef637 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -575,7 +575,6 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
 	spin_lock(&kcq->lock);
 	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
 	spin_unlock(&kcq->lock);
-	blk_mq_put_ctx(ctx);
 
 	return merged;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

