Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE8C04EBF
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409F2080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DKgcnSht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A409F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeKRICH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44414 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeKRICH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so12758639plq.11
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m/skZUFQZ3fxw1cd1nVnD2mYBZ9RX6Jjcd9knLDBuZs=;
        b=DKgcnShtDt480++uiQ24V0eL/a+xa6pemKjcWqULvSS6Y45MFTI5tPLkV0Vd4opgsu
         L+0d6F9JCRLk0fCh3vS+KMTly7zb8WtwFe0jhipFyjGI42AMKTafqtlk602EutxNkA1n
         zU8N+N/a+mDix+/lvHc06Us0nMJrCpjK1ISmxJmu3iE3Fghp2APLDdobJfkY9p4Y6OQ3
         svWgrLwKz25mFUiVdJTAVtD7+Shes56gqRnWP7mhSn0BKMSvwKUVT/U0Tgcjb7sxqQV5
         HGjXrQumj9/5AMdnwvJjB+GHauJwPV1slPyXLt/HAwr/w+ueJCQzPXRAqYijnAgGevag
         O1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m/skZUFQZ3fxw1cd1nVnD2mYBZ9RX6Jjcd9knLDBuZs=;
        b=WwdrE/mODHlMOqvqp//OpafRzidsU7OyeWq8tbrwovGvrXVU8D+u5ZeSBn0CjoYknu
         vzOGmnbJxpjqGbIIa75m7fPrARFbJP8/RKQcGRM0y6e0FWCEVa3mwih9nUuW1ApEisU/
         qgRtYmJFhsWsIgRFEQ57D1ahxpg8T1QG6qeNJ01j6xS+Ut/vWjqi5K6R0niqNZhyQxbi
         tll4SWiyWN7v5EEcn2tM8OeUUc7zRXF+Izxkdb1Ui/OaIY0RXpqJl22rP9vf+3Cnzh5z
         09ZZBxhnmJNTmJ7g3rt9w+So9x8kslgds85YP09Y68WDP6KCxuSzH78W6pWcPaEMTf1k
         H35g==
X-Gm-Message-State: AGRZ1gIRPiyvf8JQtqovN6blvyl+aprMeq8zQBr2x5q5GwnjFpVguXa/
        3uNYDfRxAE/SGhkvn/q4ugQluw1mm+c=
X-Google-Smtp-Source: AJdET5eCx7AhSy9bbTbdkDeGKAuEzJuv/xP6P2W5QuBew1cKVeIXK12Ey+roVyjzrNnB6aZe6W2Nbw==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33-v6mr16756275plh.268.1542491043885;
        Sat, 17 Nov 2018 13:44:03 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:44:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] block: have ->poll_fn() return number of entries polled
Date:   Sat, 17 Nov 2018 14:43:49 -0700
Message-Id: <20181117214354.822-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently only really support sync poll, ie poll with 1
IO in flight. This prepares us for supporting async poll.

Note that the returned value isn't necessarily 100% accurate.
If poll races with IRQ completion, we assume that the fact
that the task is now runnable means we found at least one
entry. In reality it could be more than 1, or not even 1.
This is fine, the caller will just need to take this into
account.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c                | 18 +++++++++---------
 drivers/nvme/host/multipath.c |  4 ++--
 include/linux/blkdev.h        |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7fc4abb4cc36..52b1c97cd7c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -38,7 +38,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -3305,7 +3305,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	return true;
 }
 
-static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 {
 	struct request_queue *q = hctx->queue;
 	long state;
@@ -3318,7 +3318,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	 * straight to the busy poll loop.
 	 */
 	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
-		return true;
+		return 1;
 
 	hctx->poll_considered++;
 
@@ -3332,30 +3332,30 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
-			return true;
+			return ret;
 		}
 
 		if (signal_pending_state(state, current))
 			__set_current_state(TASK_RUNNING);
 
 		if (current->state == TASK_RUNNING)
-			return true;
+			return 1;
 		if (ret < 0)
 			break;
 		cpu_relax();
 	}
 
 	__set_current_state(TASK_RUNNING);
-	return false;
+	return 0;
 }
 
-static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return false;
+		return 0;
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 	if (!blk_qc_t_is_internal(cookie))
@@ -3369,7 +3369,7 @@ static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 		 * so we should be safe with just the NULL check.
 		 */
 		if (!rq)
-			return false;
+			return 0;
 	}
 
 	return __blk_mq_poll(hctx, rq);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b82b0d3ca39a..65539c8df11d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,11 +220,11 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	return ret;
 }
 
-static bool nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
+static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
 {
 	struct nvme_ns_head *head = q->queuedata;
 	struct nvme_ns *ns;
-	bool found = false;
+	int found = 0;
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ad6eafc43f2..e97c0a3b2262 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -283,7 +283,7 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
+typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
-- 
2.17.1

