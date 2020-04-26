Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F3C55191
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC612084D
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2cqL4g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZJjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:39:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E5C061A0C;
        Sun, 26 Apr 2020 02:39:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so7270783pfa.9;
        Sun, 26 Apr 2020 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PUoT34bBPhCjSc7o+tf7Dq6MmnaGvqDhqlxiKWUjYMU=;
        b=k2cqL4g2+/6AHttvV73t3NVqG5x8W9Gc54i3yIrn3GGiM+eykPqFwdOS1S+uJyPS0O
         7lupidCNfZO6EsEUIzqY7h3OU7VrkrzxVhRhh/ieVMBMd9Fd690+4wYmAasBpofzzH34
         mto0hz2ywowdtY062zDhXydRHTgU8JfxjNSFwG+e0/+SLfSjrFGVBEEDUu3IOH8lrtjX
         +rUwZd8qv17wFvBFLM/w2/zVKucJ8cIogxySajrBrCcEa7y/eWIBOxnxslsMPmRQj9pw
         Qg5p2Xo4q33M+3DSBo61qXNkgIZHyrioNodH5wF2421g+ocsp1y3i9CSh5peidMN4zzY
         iOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PUoT34bBPhCjSc7o+tf7Dq6MmnaGvqDhqlxiKWUjYMU=;
        b=ts/jhcIgcglXxseyFEMAhY2KDeP5lGB6jN8OxxLLiBKVi77JWxjO/mDHyNAratxMQ2
         YIm6hqv9XEnhVt2vYUrP2tkVbzxPza7ewlxxisyLfvJIsqccDfVN0RJZOeN+4KQ5PBDd
         zmYkavakUBW7Efc/xpXHl3ijyITmBH+s+WGo3P94Hurt08gYrefO5RtidnPsuUOdPyYu
         zUUMycPe9XKKPUDdNVwpkI1cm1iAeCdUWE3j1EojmXD1zkGADWdH+SttsPB78dCumDsf
         wLTAKHurgbD+3LsqBXukM6YjT6X5Myuv+7deAt0aFA5J2a9ubacGqH8ee7eOMoZ454q3
         biBQ==
X-Gm-Message-State: AGi0Pua2S6MjNvXJ4kwpCJw5DxnPBcAlOV0PU/Es83fJYPNmA84TYFjE
        a8NECQxWTEmtXzizoLwfWyxCT5ICi2c=
X-Google-Smtp-Source: APiQypJ0XZrg7aoTfgqonFDCtnYir77i+0FfN18rfO1yRqJV1+sxGi7f1oU0nV8kopVOpB8EU0oYIQ==
X-Received: by 2002:a62:1bc5:: with SMTP id b188mr18295243pfb.113.1587893964537;
        Sun, 26 Apr 2020 02:39:24 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch processing
Date:   Sun, 26 Apr 2020 17:38:54 +0800
Message-Id: <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Now some SD/MMC host controllers can support packed command or packed request,
that means we can package several requests to host controller at one time
to improve performence.

But the blk-mq always takes one request from the scheduler and dispatch it to
the device, regardless of the driver or the scheduler, so there should only
ever be one request in the local list in blk_mq_dispatch_rq_list(), that means
the bd.last is always true and the driver can not use bd.last to decide if
there are requests are pending now in hardware queue to help to package
requests.

Thus this patch introduces a new 'BLK_MQ_F_FORCE_COMMIT_RQS' flag to call
.commit_rqs() to do batch processing if necessary.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 block/blk-mq-sched.c   | 29 ++++++++++++++++++++---------
 block/blk-mq.c         | 15 ++++++++++-----
 include/linux/blk-mq.h |  1 +
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74cedea56034..3429a71a7364 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
  */
-static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	bool ret = false;
 
 	do {
 		struct request *rq;
@@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+		ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
+	} while (ret);
+
+	return ret;
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
  */
-static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	bool ret = false;
 
 	do {
 		struct request *rq;
@@ -161,10 +166,11 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 
 		/* round robin for fair dispatch */
 		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
-
-	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+		ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
+	} while (ret);
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
+	return ret;
 }
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
@@ -173,6 +179,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
 	LIST_HEAD(rq_list);
+	bool dispatch_ret;
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
 	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
@@ -206,21 +213,25 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
+		dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
+		if (dispatch_ret) {
 			if (has_sched_dispatch)
 				blk_mq_do_dispatch_sched(hctx);
 			else
 				blk_mq_do_dispatch_ctx(hctx);
 		}
 	} else if (has_sched_dispatch) {
-		blk_mq_do_dispatch_sched(hctx);
+		dispatch_ret = blk_mq_do_dispatch_sched(hctx);
 	} else if (hctx->dispatch_busy) {
 		/* dequeue request one by one from sw queue if queue is busy */
-		blk_mq_do_dispatch_ctx(hctx);
+		dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-		blk_mq_dispatch_rq_list(q, &rq_list, false);
+		dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
 	}
+
+	if (dispatch_ret && (hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS))
+		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e56884fd2e9..bde122feef01 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1253,11 +1253,16 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 * Flag last if we have no more requests, or if we have more
 		 * but can't assign a driver tag to it.
 		 */
-		if (list_empty(list))
-			bd.last = true;
-		else {
-			nxt = list_first_entry(list, struct request, queuelist);
-			bd.last = !blk_mq_get_driver_tag(nxt);
+		if (!(hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)) {
+			if (list_empty(list)) {
+				bd.last = true;
+			} else {
+				nxt = list_first_entry(list, struct request,
+						       queuelist);
+				bd.last = !blk_mq_get_driver_tag(nxt);
+			}
+		} else {
+			bd.last = false;
 		}
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f389d7c724bd..6a20f8e8eb85 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -391,6 +391,7 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
+	BLK_MQ_F_FORCE_COMMIT_RQS = 1 << 3,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.17.1

