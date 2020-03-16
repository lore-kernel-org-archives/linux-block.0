Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D7C0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C082071C
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWI3mq9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgCPKBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:01:45 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40176 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgCPKBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id bo3so6950243pjb.5;
        Mon, 16 Mar 2020 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/LmtztrVm5GBvFcccNPu2w9AgpCSWj+xEGNl3taRbcc=;
        b=BWI3mq9ASVMRk6eA05VPOZ1WrcF1iF2gI4wqFMEyzNL2CsjoEOJGab50BmDSEhbLOs
         3evYv35PA2kZnhf/Y4x6UzXwbezX8MI+iPzGfcrfIVyPhC04Nk+GlnxZ4JNybrZTLhoy
         uOq9bKha9hlX7wTBSs/0RfDu4dA7HlOqXbmWgvw97hUFWwbmcbJ1uDOcJidI5Kt6oRSz
         xtp+6PbfYroaAi/I+JwsLDg9yygrA1/HbiPZjf9wbvVAJbN5yOV1c2I13FkbxFwRfiah
         mNChzs3+dclDD1rVjLh0GHtNV5Ge2Sip57OmvLL70FhnwOdsL4x7MQImrffxbPCutYCF
         LyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/LmtztrVm5GBvFcccNPu2w9AgpCSWj+xEGNl3taRbcc=;
        b=FT+TMzezsCgKkCLu4WEIUf/FjlDbNBMZdBVLg4jAfNam48qP/lb02zZFKu/wfS7dYi
         vmqLrf3yxystJ2rsy3L+JulRP+MYdmUwr/qx5zEir050hBG9d00pztZw6m4WouWKkCcz
         sVKjlOZ8jmMb7rmkQpac69ohaWyyOW+1DZvhjvlUoAMigl6h0pUy5F4z/d+Musmu1BTB
         Umxr5AnI5OjFnDWtw+42Qfqgo3KeBjltI5D06jx72uqGYx4ph67wSzhCT+ekdqc6yfU1
         J/sHS7BH6ft8z4eA2Th8y1e16d3GS4pSZbvCgVew1RiGRo8/cPCxAJWXmO/0eQKk/mZK
         nKUQ==
X-Gm-Message-State: ANhLgQ03JpnEFJzvNIz9lQmwdIWwoKKGxQxSg66KGGOoAW3lm63F6uNe
        owvebJ9XBrSs/MimxtDyK4E=
X-Google-Smtp-Source: ADFU+vsQNWdN6ESJ56bAGgS0HoNlD5Fs9pvJI6czZ/XpORGYV7jDdLJ3TGXONdGnMt0NLCxq7e2N0A==
X-Received: by 2002:a17:90b:344:: with SMTP id fh4mr24028543pjb.126.1584352902408;
        Mon, 16 Mar 2020 03:01:42 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:01:42 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 1/8] block: Change the dispatch_request() API to support batch requests
Date:   Mon, 16 Mar 2020 18:01:18 +0800
Message-Id: <08d5beb3981fa306c4a54cd399c4b015a66b2aab.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now some SD/MMC host controllers can support packed command or packed request,
that means we can package several requests to host controller at one time
to improve performence.

But the blk-mq always takes one request from the scheduler and dispatch it to
the device, regardless of the driver or the scheduler, so there should only
ever be one request in the local list in blk_mq_dispatch_rq_list(), that means
the bd.last is always true and the driver can not use bd.last to decide if
there are requests are pending now in hardware queue to help to package
requests.

Thus this is a preparation patch, which tries to change the dispatch_request()
API to allow dispatching more than one request from the scheduler.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 block/bfq-iosched.c      | 12 +++++++++---
 block/blk-mq-sched.c     | 15 ++++-----------
 block/kyber-iosched.c    | 20 +++++++++++++-------
 block/mq-deadline.c      | 12 +++++++++---
 include/linux/elevator.h |  2 +-
 5 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8c436ab..d7a128e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4789,7 +4789,8 @@ static inline void bfq_update_dispatch_stats(struct request_queue *q,
 					     bool idle_timer_disabled) {}
 #endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
-static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
+static int bfq_dispatch_requests(struct blk_mq_hw_ctx *hctx,
+				 struct list_head *list)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 	struct request *rq;
@@ -4811,7 +4812,12 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
 				  idle_timer_disabled);
 
-	return rq;
+	if (!rq)
+		return 0;
+
+	list_add(&rq->queuelist, list);
+
+	return 1;
 }
 
 /*
@@ -6785,7 +6791,7 @@ static ssize_t bfq_low_latency_store(struct elevator_queue *e,
 		.finish_request		= bfq_finish_requeue_request,
 		.exit_icq		= bfq_exit_icq,
 		.insert_requests	= bfq_insert_requests,
-		.dispatch_request	= bfq_dispatch_request,
+		.dispatch_requests	= bfq_dispatch_requests,
 		.next_request		= elv_rb_latter_request,
 		.former_request		= elv_rb_former_request,
 		.allow_merge		= bfq_allow_bio_merge,
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd..f49f9d9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -90,28 +90,21 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	int ret;
 
 	do {
-		struct request *rq;
-
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
-		rq = e->type->ops.dispatch_request(hctx);
-		if (!rq) {
+		ret = e->type->ops.dispatch_requests(hctx, &rq_list);
+		if (ret == 0) {
 			blk_mq_put_dispatch_budget(hctx);
 			break;
 		}
 
-		/*
-		 * Now this rq owns the budget which has to be released
-		 * if this rq won't be queued to driver via .queue_rq()
-		 * in blk_mq_dispatch_rq_list().
-		 */
-		list_add(&rq->queuelist, &rq_list);
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 }
 
@@ -171,7 +164,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
-	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
+	const bool has_sched_dispatch = e && e->type->ops.dispatch_requests;
 	LIST_HEAD(rq_list);
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 34dcea0..8f58434 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -796,12 +796,13 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
 	return NULL;
 }
 
-static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
+static int kyber_dispatch_requests(struct blk_mq_hw_ctx *hctx,
+				   struct list_head *list)
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
 	struct kyber_hctx_data *khd = hctx->sched_data;
 	struct request *rq;
-	int i;
+	int i, ret = 0;
 
 	spin_lock(&khd->lock);
 
@@ -811,8 +812,11 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (khd->batching < kyber_batch_size[khd->cur_domain]) {
 		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
-		if (rq)
+		if (rq) {
+			list_add(&rq->queuelist, list);
+			ret = 1;
 			goto out;
+		}
 	}
 
 	/*
@@ -832,14 +836,16 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			khd->cur_domain++;
 
 		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
-		if (rq)
+		if (rq) {
+			list_add(&rq->queuelist, list);
+			ret = 1;
 			goto out;
+		}
 	}
 
-	rq = NULL;
 out:
 	spin_unlock(&khd->lock);
-	return rq;
+	return ret;
 }
 
 static bool kyber_has_work(struct blk_mq_hw_ctx *hctx)
@@ -1020,7 +1026,7 @@ static int kyber_batching_show(void *data, struct seq_file *m)
 		.finish_request = kyber_finish_request,
 		.requeue_request = kyber_finish_request,
 		.completed_request = kyber_completed_request,
-		.dispatch_request = kyber_dispatch_request,
+		.dispatch_requests = kyber_dispatch_requests,
 		.has_work = kyber_has_work,
 	},
 #ifdef CONFIG_BLK_DEBUG_FS
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b490f47..9fbffba 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -378,7 +378,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
  * different hardware queue. This is because mq-deadline has shared
  * state for all hardware queues, in terms of sorting, FIFOs, etc.
  */
-static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
+static int dd_dispatch_requests(struct blk_mq_hw_ctx *hctx,
+				struct list_head *list)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	struct request *rq;
@@ -387,7 +388,12 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	rq = __dd_dispatch_request(dd);
 	spin_unlock(&dd->lock);
 
-	return rq;
+	if (!rq)
+		return 0;
+
+	list_add(&rq->queuelist, list);
+
+	return 1;
 }
 
 static void dd_exit_queue(struct elevator_queue *e)
@@ -774,7 +780,7 @@ static void deadline_dispatch_stop(struct seq_file *m, void *v)
 static struct elevator_type mq_deadline = {
 	.ops = {
 		.insert_requests	= dd_insert_requests,
-		.dispatch_request	= dd_dispatch_request,
+		.dispatch_requests	= dd_dispatch_requests,
 		.prepare_request	= dd_prepare_request,
 		.finish_request		= dd_finish_request,
 		.next_request		= elv_rb_latter_request,
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 901bda3..a65bf5d 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -42,7 +42,7 @@ struct elevator_mq_ops {
 	void (*prepare_request)(struct request *, struct bio *bio);
 	void (*finish_request)(struct request *);
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
-	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
+	int (*dispatch_requests)(struct blk_mq_hw_ctx *, struct list_head *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
 	void (*requeue_request)(struct request *);
-- 
1.9.1

