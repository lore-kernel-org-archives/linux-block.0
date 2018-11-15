Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E6AC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E1E2146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WAHT/Cdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E1E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeKPGBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34254 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so9984247plo.1
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEomzWGyNQSltl7n4uFzYYpxk2U93JIuvGhRDl2wTS4=;
        b=WAHT/CdtxhpfrRLOwqLki37Sd1i9P8q4k9QyLqjTCGobXKSJLt7o7Ivh3eozwL/u5O
         KmCX3gsMLO4Ut8ThlYX6Q4bx1oEeiZkR/DjJoeMetfL8aMnIZZ01jdMZu+2pD2byj8E9
         +MxHbIRF8qCKSq0ecWbJEeAIRlj2VdFnwCOV81BsL7jZg5bNvq+/QY19Y+vyBEoMnyNL
         TWtBq6uJBBaehw+EMiH8Rcq2foMpob+eKZTkMdLDrQsZBHYsmtT5zVQch2vJRVeFZjyR
         DnciBAVOJ6Chw0oRvWOLBD3JE8YSFn8WRUVRoEcpkvFl2K/ZX/wv4su98siwgZaaFZFd
         CQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEomzWGyNQSltl7n4uFzYYpxk2U93JIuvGhRDl2wTS4=;
        b=uOPWt7eL3fm8tWEEDkO6T4JJG1WbRPiKHXvwAydnhCmHId2XGHYHHOBJZ/fUqM9vOA
         HzTJRaxpFNRTqmUoJyr7fdHH4uik3dk5qopqRl8MIB5E9Z0INYXWtAdATaWbJ/nO0oD0
         PPKtQp5THIMfXOvJLmimBuYy9u+TpAQMnpFI5Mzw6xdeXVngjU1n0i3FUbmpD9Zym7lU
         lgkv1ce9D0FbGFtssJU2f3aILh9GvqLa9CBSoEmZU67yPTSw5EQi+PXFjTwJAX+fYiIU
         n/keaykxdu0PJigxo+Dama3mPbzG8TKbuAk1yfT8mzt6aylFDX0A/NHH2BSoCrxAVTgE
         yT2w==
X-Gm-Message-State: AGRZ1gJkhd92GXLxSm3Ga41EgEzsCZAq8kY/frwsDRndli4AVjwL5Pti
        sm2iAwDoaTZ+3qFMLpat+B73Vr7oDN4=
X-Google-Smtp-Source: AJdET5c76YU2UKow5wsiosXlK1NI9obmubFXNRBl49ArSazLKvc0T4YcVhIsC29pjlpRcxak46orvA==
X-Received: by 2002:a17:902:70cb:: with SMTP id l11-v6mr7884739plt.30.1542311512716;
        Thu, 15 Nov 2018 11:51:52 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] block: have ->poll_fn() return number of entries polled
Date:   Thu, 15 Nov 2018 12:51:30 -0700
Message-Id: <20181115195135.22812-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
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
index 91c44f7a7f62..e96dc16ef8aa 100644
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

