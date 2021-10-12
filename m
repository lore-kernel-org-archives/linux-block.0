Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAC4C433FE
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B700160D07
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJLSUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhJLSUC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:20:02 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891BC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:56 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b10so9789789iof.12
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gusiocnwZun+uSAGNDHyAkAkochQi/Puw7FMhKMpRIw=;
        b=6fzgQV6TMmf0gC3PArHqYcvcnVmVp9NAdOCpDXHJyFwvj8i9/vpI9h4ENeKGoNl0XF
         7oyUzcbcntkrTH/U4KT2OdbM8P+FaLNfMG9hrmnEF5aNvAJOQOgslgW5uhpcibhX4mDA
         WAOxLTudOQXioMl9E+A7XS9uk23kBRZki/2i43qLxr1Dv9hZ0MalhRWZHHi/bp6OSvro
         tpHL38hApWOIERrsXc1iqv7Z4qtPtZshxtwZPfb8365og2+NqfPr3kY/5WE4xEueAcVM
         ggSxJn9KSQyZqaafhcECZUhlpOBZVtS2Lb2z1VfRWFm4wofca8djDYl9mN9I3ZPjgt9T
         QUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gusiocnwZun+uSAGNDHyAkAkochQi/Puw7FMhKMpRIw=;
        b=bTaCLAq4SABTfjbp4AKhquQ69pEYdCLebMUX0o5wvrlxr5LVg71g1l7enID/eKdH/R
         VciLgkJufqaETkfMrriVnyxtijeZkRgfLWnKfZaZCYlY+IYsH4UvIlZj35denHcrIy1n
         77vKYz8rFitITxf95QiyKbOnFmCuuZUD8YoFHmfYk8lb/dm1mYOuCVa6OHxEggNSVVlN
         71I9PmWyXgfqLlYT09uH3KxpNWLPjAn7MwppkgQOKZQ1LyrzGipqtQb49QE1xM5EojmQ
         cbLdAyHp/svhmyxVdDcXaV9iMbUJCjYLV8iEb5rv1mif/Di+9jIh75y65stMzUBL5oyx
         4lFQ==
X-Gm-Message-State: AOAM5309M55nD1N2tzW2I8A54Dpmcujp2bG3plC0mUK/z1DYNd0lJ9H0
        pzfvDZcrwjJ33QyjMum681fh8Eqibn49kg==
X-Google-Smtp-Source: ABdhPJzRNBSZ83EHygJYltfqx/qa5EgzjJcrDjUakwWD9TwwYVzNz2a4JSI8/Zw2tH4e7HwKAYq5kQ==
X-Received: by 2002:a6b:6a05:: with SMTP id x5mr25930134iog.6.1634062667723;
        Tue, 12 Oct 2021 11:17:47 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/9] block: add support for blk_mq_end_request_batch()
Date:   Tue, 12 Oct 2021 12:17:37 -0600
Message-Id: <20211012181742.672391-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of calling blk_mq_end_request() on a single request, add a helper
that takes the new struct io_batch and completes any request stored in
there.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c     |  6 +++
 block/blk-mq-tag.h     |  1 +
 block/blk-mq.c         | 83 ++++++++++++++++++++++++++++++++++++++----
 include/linux/blk-mq.h | 13 +++++++
 4 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c43b97201161..70eb276dc870 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -207,6 +207,12 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 	}
 }
 
+void blk_mq_put_tags(struct blk_mq_tags *tags, int *array, int nr_tags)
+{
+	sbitmap_queue_clear_batch(&tags->bitmap_tags, tags->nr_reserved_tags,
+					array, nr_tags);
+}
+
 struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
 	busy_iter_fn *fn;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 71c2f7d8e9b7..e7b6c8dff071 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -42,6 +42,7 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 			      unsigned int *offset);
 extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
+void blk_mq_put_tags(struct blk_mq_tags *tags, int *array, int nr_tags);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a38412dcb55f..9509c52a66a4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -613,21 +613,26 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 	}
 }
 
-inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
+static inline void __blk_mq_end_request_acct(struct request *rq,
+					     blk_status_t error, u64 now)
 {
-	u64 now = 0;
-
-	if (blk_mq_need_time_stamp(rq))
-		now = ktime_get_ns();
-
 	if (rq->rq_flags & RQF_STATS) {
 		blk_mq_poll_stats_start(rq->q);
 		blk_stat_add(rq, now);
 	}
 
 	blk_mq_sched_completed_request(rq, now);
-
 	blk_account_io_done(rq, now);
+}
+
+inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
+{
+	u64 now = 0;
+
+	if (blk_mq_need_time_stamp(rq))
+		now = ktime_get_ns();
+
+	__blk_mq_end_request_acct(rq, error, now);
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
@@ -646,6 +651,70 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
+#define TAG_COMP_BATCH		32
+#define TAG_SCHED_BATCH		(TAG_COMP_BATCH >> 1)
+
+static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
+					  int *tags, int nr_tags)
+{
+	struct request_queue *q = hctx->queue;
+
+	blk_mq_put_tags(hctx->tags, tags, nr_tags);
+	if (q->elevator)
+		blk_mq_put_tags(hctx->sched_tags, &tags[TAG_SCHED_BATCH], nr_tags);
+	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
+	blk_mq_sched_restart(hctx);
+}
+
+void blk_mq_end_request_batch(struct io_batch *ib)
+{
+	int tags[TAG_COMP_BATCH], nr_tags = 0, acct_tags = 0;
+	struct blk_mq_hw_ctx *last_hctx = NULL;
+	u64 now = 0;
+
+	while (ib->req_list) {
+		struct request *rq;
+
+		rq = ib->req_list;
+		ib->req_list = rq->rq_next;
+		if (!now && blk_mq_need_time_stamp(rq))
+			now = ktime_get_ns();
+		blk_update_request(rq, rq->status, blk_rq_bytes(rq));
+		__blk_mq_end_request_acct(rq, rq->status, now);
+
+		if (rq->q->elevator) {
+			blk_mq_free_request(rq);
+			continue;
+		}
+
+		if (!refcount_dec_and_test(&rq->ref))
+			continue;
+
+		blk_crypto_free_request(rq);
+		blk_pm_mark_last_busy(rq);
+		rq_qos_done(rq->q, rq);
+		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
+
+		if (acct_tags == TAG_COMP_BATCH ||
+		    (last_hctx && last_hctx != rq->mq_hctx)) {
+			blk_mq_flush_tag_batch(last_hctx, tags, nr_tags);
+			acct_tags = nr_tags = 0;
+		}
+		tags[nr_tags] = rq->tag;
+		last_hctx = rq->mq_hctx;
+		if (last_hctx->queue->elevator) {
+			tags[nr_tags + TAG_SCHED_BATCH] = rq->internal_tag;
+			acct_tags++;
+		}
+		nr_tags++;
+		acct_tags++;
+	}
+
+	if (nr_tags)
+		blk_mq_flush_tag_batch(last_hctx, tags, nr_tags);
+}
+EXPORT_SYMBOL_GPL(blk_mq_end_request_batch);
+
 static void blk_complete_reqs(struct llist_head *list)
 {
 	struct llist_node *entry = llist_reverse_order(llist_del_all(list));
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 29555673090d..26f9f6b07734 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -183,9 +183,16 @@ struct request {
 	unsigned int timeout;
 	unsigned long deadline;
 
+	/*
+	 * csd is used for remote completions, fifo_time at scheduler time.
+	 * They are mutually exclusive. result is used at completion time
+	 * like csd, but for batched IO. Batched IO does not use IPI
+	 * completions.
+	 */
 	union {
 		struct __call_single_data csd;
 		u64 fifo_time;
+		blk_status_t status;
 	};
 
 	/*
@@ -545,6 +552,11 @@ struct blk_mq_ops {
 	 */
 	void (*complete)(struct request *);
 
+	/**
+	 * @complete_batch: Mark list of requests as complete
+	 */
+	void (*complete_batch)(struct io_batch *);
+
 	/**
 	 * @init_hctx: Called when the block layer side of a hardware queue has
 	 * been set up, allowing the driver to allocate/init matching
@@ -734,6 +746,7 @@ static inline void blk_mq_set_request_complete(struct request *rq)
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
+void blk_mq_end_request_batch(struct io_batch *ib);
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
-- 
2.33.0

