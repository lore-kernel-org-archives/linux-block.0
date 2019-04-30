Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D1C46460
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF7C21670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N19U9oDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfD3HfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45548 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3HfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id w12so42439ljh.12;
        Tue, 30 Apr 2019 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtTeypozSEdVW8H84rjErApUVCz52elY8ixwIbauNlE=;
        b=N19U9oDaIa0WH54p4wVwJulsqsAi7JJpPotAcBQKUnrnOLXGyWemV6NBT+9ikDwQMr
         +9ww2vlWtsrIZTrG8M0yXoa8oMIDULAusp8o8tjuuJXTlK2ic4WjZHcE6Eoz5hlHTmh8
         5MzaXAO7YcIe0z2eIYuY9ZzgqsQKdJoKcQ33p7i0P5bsoI7hxBavjeJzufy2M5NYJ+7Z
         r7VtfJCu/PWAYEcXg/gld+oXXfSSxc89hXrTNhvRKXYzFP3R5OOFlZw2SMIsbZ/Nh5Zx
         QUfMz1EZl+OBxJwENe4k7GKa+i4xYu5awaRXN9Nw1TkhxqWUrl8IAlNlb8bLqMNHk7Fn
         2gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtTeypozSEdVW8H84rjErApUVCz52elY8ixwIbauNlE=;
        b=d1nwZl/qneIu3EV0DZ5PoM8SLu+PFqIQvn/B05MMkwUNtXTW9PoqMAnMA3uOzjlLs0
         LTDq1LQj44grN5Cangjksa13T6kwjo3B3Fh5VIntsohtqKJOrcFJ6SwjBbOj7+Y9wXy8
         8ULKdOb5Hpf5vVYjuDCUwZ99RAq/Rm6YBpANoUhtkLsaobvlDuxTLaUGPOi0kipF1U8J
         fdimrOswD2y9TEUYyJPBE3/lnrYO+2yny0JY5ueINOf4jyiQ1/x+UPiX0BKVZSnrdFxs
         aa1900EcU9eWzdhxk1HWuksCZFAu41+f8ecYmEoBSq87PgdJoK4gH7osRHYHKtIRfbwL
         tH8A==
X-Gm-Message-State: APjAAAUhf3uArzoTKOMQbpbwCY8Rc+X+dbf4Bnfb8+AkWI832cDgEFNA
        N/EpbXldP/grQZsZWEHZwG0=
X-Google-Smtp-Source: APXvYqxlzXiycrEmuePqR2+Qh9TD8x6HKtIy1DSOa8Jhg8qnv5FqJtTZmY2KgpulLigr5KphIx9tGQ==
X-Received: by 2002:a2e:8e93:: with SMTP id z19mr15920182ljk.159.1556609705372;
        Tue, 30 Apr 2019 00:35:05 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:35:04 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 5/7] blk-mq: Precalculate hybrid polling time
Date:   Tue, 30 Apr 2019 10:34:17 +0300
Message-Id: <25f7593a0350e07997fc31d1317218ffeec4f6bf.1556609582.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1556609582.git.asml.silence@gmail.com>
References: <cover.1556609582.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Calculation of sleep time for adaptive hybrid polling on per-request
basis could become time consuming in the future.
Precalculate it once per statistics gathering round.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c       |  5 ++++-
 block/blk-mq-debugfs.c |  4 ++--
 block/blk-mq.c         | 39 ++++++++++++++++++++++-----------------
 include/linux/blkdev.h |  8 +++++++-
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a55389ba8779..daadce545e43 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -474,7 +474,7 @@ static void blk_timeout_work(struct work_struct *work)
 struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	struct request_queue *q;
-	int ret;
+	int ret, bucket;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep,
 				gfp_mask | __GFP_ZERO, node_id);
@@ -536,6 +536,9 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (blkcg_init_queue(q))
 		goto fail_ref;
 
+	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++)
+		q->poll_info[bucket].sleep_ns = 0;
+
 	return q;
 
 fail_ref:
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b62bd4468db3..ab55446cb570 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -44,11 +44,11 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
 
 	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS/2; bucket++) {
 		seq_printf(m, "read  (%d Bytes): ", 1 << (9+bucket));
-		print_stat(m, &q->poll_stat[2*bucket]);
+		print_stat(m, &q->poll_info[2*bucket].stat);
 		seq_puts(m, "\n");
 
 		seq_printf(m, "write (%d Bytes): ",  1 << (9+bucket));
-		print_stat(m, &q->poll_stat[2*bucket+1]);
+		print_stat(m, &q->poll_info[2*bucket+1].stat);
 		seq_puts(m, "\n");
 	}
 	return 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cc3f73e4e01c..4e54a004e345 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3312,14 +3312,32 @@ static void blk_mq_poll_stats_start(struct request_queue *q)
 	blk_stat_activate_msecs(q->poll_cb, 100);
 }
 
+static void blk_mq_update_poll_info(struct poll_info *pi,
+				    struct blk_rq_stat *stat)
+{
+	u64 sleep_ns;
+
+	if (!stat->nr_samples)
+		sleep_ns = 0;
+	else
+		sleep_ns = (stat->mean + 1) / 2;
+
+	pi->stat = *stat;
+	pi->sleep_ns = sleep_ns;
+}
+
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
 {
 	struct request_queue *q = cb->data;
 	int bucket;
 
 	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
-		if (cb->stat[bucket].nr_samples)
-			q->poll_stat[bucket] = cb->stat[bucket];
+		if (cb->stat[bucket].nr_samples) {
+			struct poll_info *pi = &q->poll_info[bucket];
+			struct blk_rq_stat *stat = &cb->stat[bucket];
+
+			blk_mq_update_poll_info(pi, stat);
+		}
 	}
 }
 
@@ -3327,7 +3345,6 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
-	unsigned long ret = 0;
 	int bucket;
 
 	/*
@@ -3337,23 +3354,11 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	if (!blk_poll_stats_enable(q))
 		return 0;
 
-	/*
-	 * As an optimistic guess, use half of the mean service time
-	 * for this type of request. We can (and should) make this smarter.
-	 * For instance, if the completion latencies are tight, we can
-	 * get closer than just half the mean. This is especially
-	 * important on devices where the completion latencies are longer
-	 * than ~10 usec. We do use the stats for the relevant IO size
-	 * if available which does lead to better estimates.
-	 */
 	bucket = blk_mq_poll_stats_bkt(rq);
 	if (bucket < 0)
-		return ret;
-
-	if (q->poll_stat[bucket].nr_samples)
-		ret = (q->poll_stat[bucket].mean + 1) / 2;
+		return 0;
 
-	return ret;
+	return q->poll_info[bucket].sleep_ns;
 }
 
 static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..40c77935fd61 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -385,6 +385,12 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+struct poll_info
+{
+	struct blk_rq_stat	stat;
+	u64			sleep_ns;
+};
+
 struct request_queue {
 	/*
 	 * Together with queue_head for cacheline sharing
@@ -477,7 +483,7 @@ struct request_queue {
 	int			poll_nsec;
 
 	struct blk_stat_callback	*poll_cb;
-	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
+	struct poll_info	poll_info[BLK_MQ_POLL_STATS_BKTS];
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
-- 
2.21.0

