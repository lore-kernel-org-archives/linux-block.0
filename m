Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7584C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C812465D
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgBKTSE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:18:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:61854 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgBKTSD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 14:18:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 11:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="266372345"
Received: from unknown (HELO localhost.localdomain) ([10.232.115.123])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2020 11:18:02 -0800
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To:     axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: [PATCH v2 1/2] block: reintroduce polling on bio level
Date:   Tue, 11 Feb 2020 12:17:28 -0700
Message-Id: <20200211191729.4745-2-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current implementation it is possible to perform IO polling if
underlying device is block-mq device. It is not possible however to do
polled IO on stackable block devices like MD.

This patch does following:
 - reintroduces polling on bio level that was removed some time ago.
   Implementation for that has been pulled from commit
   529262d56dbe ("block: remove ->poll_fn").

 - modifies blk_poll() to introduce fastpath access for blk_mq_poll().
   In other words bio_poll() calls poll_fn() for stackable block
   devices supporting polling, otherwise it invokes blk_mq_poll()
   directly.

We managed to collect performance data on RAID-0 volume built on top of
2xP4800X devices with polling on and off. Here are results for pvsync2:

Polling      QD       Latency         IOPS
----------------------------------------------
off           1       12.20us         78400
on            1        8.80us        111000

Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
---
 block/blk-core.c       | 28 ++++++++++++++++++++++++++++
 block/blk-mq.c         | 23 ++---------------------
 block/blk-mq.h         |  2 ++
 include/linux/blkdev.h |  2 ++
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..48001538de92 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1201,6 +1201,34 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
+/**
+ * blk_poll - poll for IO completions
+ * @q:  the queue
+ * @cookie: cookie passed back at IO submission time
+ * @spin: whether to spin for completions
+ *
+ * Description:
+ *    Poll for completions on the passed in queue. Returns number of
+ *    completed entries found. If @spin is true, then blk_poll will continue
+ *    looping until at least one completion is found, unless the task is
+ *    otherwise marked running (or we need to reschedule).
+ */
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+{
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags) ||
+	    !blk_qc_t_valid(cookie))
+		return 0;
+
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+
+	if (q->poll_fn)
+		return q->poll_fn(q, cookie, spin);
+
+	return blk_mq_poll(q, cookie, spin);
+}
+EXPORT_SYMBOL_GPL(blk_poll);
+
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for new the queue limits
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..868aab100692 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3509,30 +3509,11 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
-/**
- * blk_poll - poll for IO completions
- * @q:  the queue
- * @cookie: cookie passed back at IO submission time
- * @spin: whether to spin for completions
- *
- * Description:
- *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found. If @spin is true, then blk_poll will continue
- *    looping until at least one completion is found, unless the task is
- *    otherwise marked running (or we need to reschedule).
- */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
 	long state;
 
-	if (!blk_qc_t_valid(cookie) ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return 0;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
@@ -3573,7 +3554,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	__set_current_state(TASK_RUNNING);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(blk_poll);
+EXPORT_SYMBOL_GPL(blk_mq_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..def2f85926b2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -75,6 +75,8 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
+
 /*
  * CPU -> queue mappings
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 053ea4b51988..ab703d655be0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -288,6 +288,7 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
+typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t, bool spin);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
@@ -399,6 +400,7 @@ struct request_queue {
 	struct rq_qos		*rq_qos;
 
 	make_request_fn		*make_request_fn;
+	poll_q_fn		*poll_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 
 	const struct blk_mq_ops	*mq_ops;
-- 
2.20.1

