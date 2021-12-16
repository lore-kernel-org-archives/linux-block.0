Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhLPQjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLPQjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:39:05 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B2C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d14so20172226ila.1
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=;
        b=OrdIjvCOXY0D0TMhorH3nRbwYFZcB54ze7TN98Pgntko5rub26f5OWcC/o8nw+ATvJ
         ROzMEapHo1abx6igYSx+SJv5yWUw2fodYo3ajfEfxj9MofnbX3x2lrp3et8IeSYo48CS
         ti1UsKR7wA0orUTz52eSlAWp7e0C9m0rtZBJHbUNIq6TzSNBvArOFDLElnPV0DsZ6yDj
         I44eRTDecpJ1D/pLGhoMs6EEa3oNO59aebTWElSx6pYfkf+Oq99xFlTxEy7Q1d/7INDQ
         kC3Fdr2lz8524jQZtl0KlShO4HoqGMtJMi59DNh8isyZ0fBJuGPEjmoyjPZHnCu7/lvT
         m5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pPKkXtT6Xrl9aqdgr4UGNl+ZJEtLSBkw/CIGk0Ps8Y=;
        b=cSq7Zu53RWQzSEZYn7qTWyfrYSRIdazn7zWoGxQDOxpQLaXs2fYVa/bRORxoVIyQo0
         0Io7LoYeinJFVTMlBVH/zu2ZJ6UKwkPkj/NYhZjcZmhlztPhk7wGgytmsD5do/AE8aJG
         x+W63bFiuI9V/dWH3tsLJLX3ALdCyzIZ9n8TjS7JN6mS56gKhMHrlXOu1/eaa8GuY8ha
         9D+x4JbO/+xWU3hIGzTKRukXOg3etbcOBe730LwrsHBrtNsFlGZeZ4tFt9CcY8fwZPs4
         wbux7dgZL47nqikky40YjjiFYylSNQrnscHzhbvfEUEoo2LDDJTJ5yLHJBzSBeOOVvXj
         twGw==
X-Gm-Message-State: AOAM532mS1hx0nverMC6fpbCTSWhwMTidLPuWD3C9Z7YvEGvsxwMofLj
        kxVg7cCN+y5JuqKCg1s/85MxJA==
X-Google-Smtp-Source: ABdhPJwQb6QdZqPg4FFtSRHmv+JA7S9z28uquNJFXf+nY1Sz3Gy2ArQ3OY+7RONlUp8vi3Km9w7CEQ==
X-Received: by 2002:a05:6e02:15c8:: with SMTP id q8mr10367323ilu.21.1639672744121;
        Thu, 16 Dec 2021 08:39:04 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:39:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date:   Thu, 16 Dec 2021 09:38:58 -0700
Message-Id: <20211216163901.81845-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have a list of requests in our plug list, send it to the driver in
one go, if possible. The driver must set mq_ops->queue_rqs() to support
this, if not the usual one-by-one path is used.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 26 +++++++++++++++++++++++---
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 75154cc788db..51991232824a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2553,6 +2553,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
+	struct request *rq;
 	unsigned int depth;
 	LIST_HEAD(list);
 
@@ -2561,7 +2562,28 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		struct request_queue *q = rq_list_peek(&plug->mq_list)->q;
+		struct request_queue *q;
+
+		rq = rq_list_peek(&plug->mq_list);
+		q = rq->q;
+
+		/*
+		 * Peek first request and see if we have a ->queue_rqs() hook.
+		 * If we do, we can dispatch the whole plug list in one go. We
+		 * already know at this point that all requests belong to the
+		 * same queue, caller must ensure that's the case.
+		 *
+		 * Since we pass off the full list to the driver at this point,
+		 * we do not increment the active request count for the queue.
+		 * Bypass shared tags for now because of that.
+		 */
+		if (q->mq_ops->queue_rqs &&
+		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+			blk_mq_run_dispatch_ops(q,
+				q->mq_ops->queue_rqs(&plug->mq_list));
+			if (rq_list_empty(plug->mq_list))
+				return;
+		}
 
 		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug, false));
@@ -2573,8 +2595,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	this_ctx = NULL;
 	depth = 0;
 	do {
-		struct request *rq;
-
 		rq = rq_list_pop(&plug->mq_list);
 
 		if (!this_hctx) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 772f8f921526..550996cf419c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -492,6 +492,14 @@ struct blk_mq_ops {
 	 */
 	void (*commit_rqs)(struct blk_mq_hw_ctx *);
 
+	/**
+	 * @queue_rqs: Queue a list of new requests. Driver is guaranteed
+	 * that each request belongs to the same queue. If the driver doesn't
+	 * empty the @rqlist completely, then the rest will be queued
+	 * individually by the block layer upon return.
+	 */
+	void (*queue_rqs)(struct request **rqlist);
+
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.34.1

