Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18041C43217
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D176052B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhJMQ41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhJMQ40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F184C061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d11so400993ilc.8
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaoawFoet/Xh6gz7KFsZtmgLG0LWFGggNfKqp0lP/Uk=;
        b=0dMqOIgJyr7YB+4S1XeW5qzegP8WwSexIsSv6u7JsoRr5aUc64Fj3M0pvIcR4b4fkf
         n+5wzVVmSz60SkA8Zh4EieodX2KvvaMusQ5npgqC7aN4U3MyL3fDgSRWbTMYRnhjwMeU
         Owh0b/tFvq8PDhc52xjIAVWFWbQEGx/LHGwbJVUpTavn7NtFogj2eUFRfKzyKsxHpWTg
         sKsf8Uur1VMkfHzKsbxWFMj2zz1A+v4Jq8P+AXsU0YHuX+VtS3JtBb9yES04khE2Wavr
         SPv1lVpmDeLASi/bhTsqZo37VNv2OO9ArI3uNcRsyD+UQ9JEln6mDZl4jGZoZ9KarRLq
         SS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaoawFoet/Xh6gz7KFsZtmgLG0LWFGggNfKqp0lP/Uk=;
        b=4x0WE2D8qSSssSzEGHNsskoizgeA6DrNaEbJvvNnDQlheKTRbAuI2qRQtUnHXAcUBD
         4D9+5wFRMjOurlR0rBlEtxcIiVabMGEALWMEjhfmN7tg4lUu9pYAweTNiouafV39nKSt
         O/FORmZYN8z+a3mppysX7cAJgBxUZJolr3aDyFrYF+dVSY+ZzSHtm6HGZDZLPR1x6GRJ
         BoPnqamENClkpEsD82lufSxy1V3tP09stkDJo/ImVqcEas11E4dzOdOJppjR+iVJZyUN
         D4ehvPm3GhZT/kIY7zhEK8kb7Bp0bBpThZRswiGVvSQSPFYevrxKcu2/3/olBXYossrR
         Jr5w==
X-Gm-Message-State: AOAM532tAcI+MiJFRc5wvaPt1c4b0cn8cc6uzK+tqYVcxxzyGMpaWd+q
        4kLX6R2ub2+WVKjWnYjPRwhQThxf08e/tA==
X-Google-Smtp-Source: ABdhPJze2azlIySMUtPxQScXsIYo09k7MYazvufALtZKvrccaaYjpdERCraZHg2H6mD1YVj3PXw0yw==
X-Received: by 2002:a05:6e02:12c3:: with SMTP id i3mr109123ilm.145.1634144062818;
        Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] block: add support for blk_mq_end_request_batch()
Date:   Wed, 13 Oct 2021 10:54:12 -0600
Message-Id: <20211013165416.985696-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
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
 block/blk-mq.c         | 85 +++++++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq.h | 13 +++++++
 4 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c43b97201161..b94c3e8ef392 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -207,6 +207,12 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 	}
 }
 
+void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
+{
+	sbitmap_queue_clear_batch(&tags->bitmap_tags, tags->nr_reserved_tags,
+					tag_array, nr_tags);
+}
+
 struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
 	busy_iter_fn *fn;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 71c2f7d8e9b7..78ae2fb8e2a4 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -42,6 +42,7 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 			      unsigned int *offset);
 extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
+void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6eac10fd244e..d603703cf272 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -603,19 +603,22 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 	}
 }
 
-inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
+static inline void __blk_mq_end_request_acct(struct request *rq,
+					     blk_status_t error, u64 now)
 {
-	if (blk_mq_need_time_stamp(rq)) {
-		u64 now = ktime_get_ns();
+	if (rq->rq_flags & RQF_STATS) {
+		blk_mq_poll_stats_start(rq->q);
+		blk_stat_add(rq, now);
+	}
 
-		if (rq->rq_flags & RQF_STATS) {
-			blk_mq_poll_stats_start(rq->q);
-			blk_stat_add(rq, now);
-		}
+	blk_mq_sched_completed_request(rq, now);
+	blk_account_io_done(rq, now);
+}
 
-		blk_mq_sched_completed_request(rq, now);
-		blk_account_io_done(rq, now);
-	}
+inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
+{
+	if (blk_mq_need_time_stamp(rq))
+		__blk_mq_end_request_acct(rq, error, ktime_get_ns());
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
@@ -848,6 +851,68 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
+#define TAG_COMP_BATCH		32
+#define TAG_SCHED_BATCH		(TAG_COMP_BATCH >> 1)
+
+static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
+					  int *tag_array, int nr_tags)
+{
+	struct request_queue *q = hctx->queue;
+
+	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
+	if (q->elevator)
+		blk_mq_put_tags(hctx->sched_tags, &tag_array[TAG_SCHED_BATCH],
+				nr_tags);
+	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
+	blk_mq_sched_restart(hctx);
+}
+
+void blk_mq_end_request_batch(struct io_batch *iob)
+{
+	int tags[TAG_COMP_BATCH], nr_tags = 0, acct_tags = 0;
+	struct blk_mq_hw_ctx *last_hctx = NULL;
+	struct request *rq;
+	u64 now = 0;
+
+	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
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
index 5106c4cc411a..aea7d866a34c 100644
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
@@ -570,6 +577,11 @@ struct blk_mq_ops {
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
@@ -759,6 +771,7 @@ static inline void blk_mq_set_request_complete(struct request *rq)
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
+void blk_mq_end_request_batch(struct io_batch *ib);
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
-- 
2.33.0

