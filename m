Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A2AC43217
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB8E60F9D
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJQCIi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJQCIh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 22:08:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B21C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:29 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x1so11287743ilv.4
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InJDaECD8ya3uBxdjuGJF1Ibtx52SHkhp5ABM0rQclM=;
        b=mccYOhXf+sxjF2+TBadRmeorH+j66d1REZlgZ1iPEhV8qyIHhnZJqpQDOoTC6vp+io
         Y3R2vBcqgKGOCkIHD2jbalAt8j+C2C8LNkEUY3TM+QDYiUA/i4ac2s6BSMhONVhuvHXg
         PXB0T593q/CWupVdNbX6RIBDzKP0LBcg9eF9cqInTFuLFi4eYNJoU/s16Sd9s6L65q8Y
         +wLnNz4YywV0IAmW2W2vl8AmY+DvXcIBE5MCitn4B+SV9cIhmkh2P9dLmYEHdQCXF2LJ
         Zx2QyDjOyPtLJiO1vgIObou0IRCeqDQzJefKp3BkaIsUs3agDimv85kbkGrkWn6y3r5i
         VnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InJDaECD8ya3uBxdjuGJF1Ibtx52SHkhp5ABM0rQclM=;
        b=CUQu5pTJtt5snHaKrHKwQTa/GnhUg3tIPY1MHp1H/Q9cc6mLNFnSW8vgjbtn1zvX6F
         nzmX4XN5mBWvuSIEoFdZnXotBOonF0RbCqM9Ml058lACxiUyEGdyPu+JaqlLfxWM8aKO
         hUOEAeMHZO1fxteU2piWNBpOBs7jUpno9Ahv3EtuXZ6Lk1QAXqjWUKTe/cCRcNrco/gV
         PT02kjuh8KXNUJtto9DyDniP4yE23GDdk1T73nf231x1jsTO+aeZI4opZyE2xCJzkizz
         IvvV2j4zbpSiqTiZRbTl6PdVMdwrtUH7juy8flSaCPGAnjRyT7PqLXQABI9tBw72NXCX
         odxw==
X-Gm-Message-State: AOAM532+8tycC9cauR1VIvrTtyjWVuQlIbJowiNdkpp6mjbMDoanQMG/
        v5XFmTtenhOMvuw/uVapS+/Xxk3p0U+z4w==
X-Google-Smtp-Source: ABdhPJz37fTNSMroyVu6rqFIRF/D7bOhaiOL/yrc3Q4yQndi3Rx2ZiTDaUtAiE/6SgHUEh5CLJ/sng==
X-Received: by 2002:a05:6e02:4b1:: with SMTP id e17mr9428836ils.119.1634436388335;
        Sat, 16 Oct 2021 19:06:28 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n25sm5072127ioz.51.2021.10.16.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 19:06:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] block: add support for blk_mq_end_request_batch()
Date:   Sat, 16 Oct 2021 20:06:20 -0600
Message-Id: <20211017020623.77815-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017020623.77815-1-axboe@kernel.dk>
References: <20211017020623.77815-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of calling blk_mq_end_request() on a single request, add a helper
that takes the new struct io_comp_batch and completes any request stored
in there.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c     |  6 ++++
 block/blk-mq-tag.h     |  1 +
 block/blk-mq.c         | 81 ++++++++++++++++++++++++++++++++----------
 include/linux/blk-mq.h | 29 +++++++++++++++
 4 files changed, 98 insertions(+), 19 deletions(-)

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
index e617c7220626..df787b5a23bd 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -19,6 +19,7 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 			      unsigned int *offset);
 extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
+void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8eb80e70e8ea..58dc0c0c24ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -292,15 +292,6 @@ void blk_mq_wake_waiters(struct request_queue *q)
 			blk_mq_tag_wakeup_all(hctx->tags, true);
 }
 
-/*
- * Only need start/end time stamping if we have iostat or
- * blk stats enabled, or using an IO scheduler.
- */
-static inline bool blk_mq_need_time_stamp(struct request *rq)
-{
-	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
-}
-
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, u64 alloc_time_ns)
 {
@@ -754,19 +745,21 @@ bool blk_update_request(struct request *req, blk_status_t error,
 }
 EXPORT_SYMBOL_GPL(blk_update_request);
 
-inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
+static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
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
+		__blk_mq_end_request_acct(rq, ktime_get_ns());
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
@@ -785,6 +778,56 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
+#define TAG_COMP_BATCH		32
+
+static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
+					  int *tag_array, int nr_tags)
+{
+	struct request_queue *q = hctx->queue;
+
+	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
+	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
+}
+
+void blk_mq_end_request_batch(struct io_comp_batch *iob)
+{
+	int tags[TAG_COMP_BATCH], nr_tags = 0;
+	struct blk_mq_hw_ctx *last_hctx = NULL;
+	struct request *rq;
+	u64 now = 0;
+
+	if (iob->need_ts)
+		now = ktime_get_ns();
+
+	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
+		prefetch(rq->bio);
+		prefetch(rq->rq_next);
+
+		blk_update_request(rq, BLK_STS_OK, blk_rq_bytes(rq));
+		__blk_mq_end_request_acct(rq, now);
+
+		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
+		if (!refcount_dec_and_test(&rq->ref))
+			continue;
+
+		blk_crypto_free_request(rq);
+		blk_pm_mark_last_busy(rq);
+		rq_qos_done(rq->q, rq);
+
+		if (nr_tags == TAG_COMP_BATCH ||
+		    (last_hctx && last_hctx != rq->mq_hctx)) {
+			blk_mq_flush_tag_batch(last_hctx, tags, nr_tags);
+			nr_tags = 0;
+		}
+		tags[nr_tags++] = rq->tag;
+		last_hctx = rq->mq_hctx;
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
index 938ca6e86556..4dbf7948b0e4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -761,6 +761,35 @@ static inline void blk_mq_set_request_complete(struct request *rq)
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
+void blk_mq_end_request_batch(struct io_comp_batch *ib);
+
+/*
+ * Only need start/end time stamping if we have iostat or
+ * blk stats enabled, or using an IO scheduler.
+ */
+static inline bool blk_mq_need_time_stamp(struct request *rq)
+{
+	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
+}
+
+/*
+ * Batched completions only work when there is no I/O error and no special
+ * ->end_io handler.
+ */
+static inline bool blk_mq_add_to_batch(struct request *req,
+				       struct io_comp_batch *iob, int ioerror,
+				       void (*complete)(struct io_comp_batch *))
+{
+	if (!iob || (req->rq_flags & RQF_ELV) || req->end_io || ioerror)
+		return false;
+	if (!iob->complete)
+		iob->complete = complete;
+	else if (iob->complete != complete)
+		return false;
+	iob->need_ts |= blk_mq_need_time_stamp(req);
+	rq_list_add(&iob->req_list, req);
+	return true;
+}
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
-- 
2.33.1

