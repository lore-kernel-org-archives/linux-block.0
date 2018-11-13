Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F912C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347482086B
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0Tniim1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347482086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbeKNBla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37027 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbeKNBla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:30 -0500
Received: by mail-io1-f66.google.com with SMTP id a3so2512550ioc.4
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xB9QMEdRFna7WaXJIpl19wRyV9ikGv5wt5z2V2vqbs=;
        b=0Tniim1ZxrOIFfbZQH8gA/qBF/aruBNw22IQXqtMPMPgEEOqOsN7wX7ZKvwNVCOIp+
         7pzuaW9huv0fEOJhPJ/oBNsQ7wnT/thxbHIWyKTZjzqsOClUBa/GZhYH5zGohD9Ed7ma
         bIofcMsAgdHxoa+J3EECrZVfK/JxzvwXoHluj6ZBK4aEU38TAn24qTFjCn/i846J72ql
         JHXGM4NrLNOqsoGDuryeIkEjAjviRNSASSk90n27e7rgDsIVpDw4LCE1ZN0yR2eGc5qi
         7dlyHE9oRFe8+W5hFtj38hpVHaX+hwbk2uY4Gl0MvaQkzssA96mMVW75F9aShnCR27J1
         e5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xB9QMEdRFna7WaXJIpl19wRyV9ikGv5wt5z2V2vqbs=;
        b=hsD0qmQOAeWtEB+y0zqFB8ul47Nawjonh/DffBa3fC7/ysXF8xxNJXUkDoTM8XWgzp
         PkR3ya+phJUKdLRyLykDPGrymTgt/FKeRk+3IRc0zL9Kbo9qanhK9dWY/lBjgPIbw9Fl
         WxaILfIoIxBkXJ5RYM6bSun2MLjhPcROi8MNjr+ydDFlgIVTUmo3m9zXmlEg/jFQzpz7
         AVaF7WkW/+kvT73NhtP1JeYrNnsQasFhATjYZn7t3EiWKOmM1MgQsoqxMQPiU0MuwMRf
         fFFbp7ok5l5EvUwNZKAZPdi+QyupPjheUvpEgHifaopcYnB9IscIP8oTtfykaK8MCBiU
         GsEA==
X-Gm-Message-State: AGRZ1gKTl0+O9drZaOVXkOUot66uQMHMxChER17mENttO87x+znAmY5Y
        7hOOs0Z7NPC/XYI/Z12/JZesWwezalM=
X-Google-Smtp-Source: AJdET5fliCXeSgU0LR463qLSBPiWfAFoeGc45O4mOMwl9RynLp9sZETNkHeY4odAEj144ampjz1BXA==
X-Received: by 2002:a6b:db08:: with SMTP id t8-v6mr4584473ioc.132.1542123771278;
        Tue, 13 Nov 2018 07:42:51 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] block: have ->poll_fn() return number of entries polled
Date:   Tue, 13 Nov 2018 08:42:29 -0700
Message-Id: <20181113154233.15256-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
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
index 6e0cb6adfc90..f8c2e6544903 100644
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
 			set_current_state(TASK_RUNNING);
-			return true;
+			return ret;
 		}
 
 		if (signal_pending_state(state, current))
 			set_current_state(TASK_RUNNING);
 
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
index 5e3cc8c59a39..0484c1f9c8ce 100644
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
index d1ef8cbbea04..b2af6c68b78d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -287,7 +287,7 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
+typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
-- 
2.17.1

