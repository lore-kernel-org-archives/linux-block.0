Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF1C282DD
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B939A20879
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEVRxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 13:53:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:57850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbfEVRxQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 13:53:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 10:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,500,1549958400"; 
   d="scan'208";a="174471731"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2019 10:53:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] blk-mq: provide way to reset rq deadline
Date:   Wed, 22 May 2019 11:48:11 -0600
Message-Id: <20190522174812.5597-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190522174812.5597-1-keith.busch@intel.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If hardware has temporarily paused processing requests that its driver
has dispatched, the driver may need to halt timeout detection during that
temporary stoppage. When the hardware has un-paused request processing,
the driver needs a way to rebase all dispatched request dealines using
current jiffies so that time accrued during the paused state doesn't
count against that request.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         | 30 ++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 08a6248d8536..9d85903d4e0c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -960,6 +960,36 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_queue_exit(q);
 }
 
+static bool blk_mq_reset_rq(struct blk_mq_hw_ctx *hctx, struct request *rq,
+			    void *priv, bool reserved)
+{
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
+		blk_add_timer(rq);
+	return true;
+}
+
+/**
+ * blk_mq_reset_rqs - reset the timers on all inflight requests
+ *
+ * @q - request queue to iterate
+ *
+ * This is intended for use when a driver detects its hardware has temporarily
+ * paused processing commands. When the condition is initially detected, the
+ * driver should call blk_mq_quiesce_queue() to block new requests from
+ * dispatching, then blk_sync_queue() to halt any timeout work. When the
+ * hardware becomes operational again, the driver should call this function to
+ * reset previously dispatched request timers who's processing had been paused
+ * by the hardware, then call blk_mq_unquiesce_queue() to unblock future
+ * dispatch.
+ */
+void blk_mq_reset_rqs(struct request_queue *q)
+{
+	if (WARN_ON(!blk_queue_quiesced(q)))
+		return;
+	blk_mq_queue_tag_busy_iter(q, blk_mq_reset_rq, NULL);
+}
+EXPORT_SYMBOL_GPL(blk_mq_reset_rqs);
+
 struct flush_busy_ctx_data {
 	struct blk_mq_hw_ctx *hctx;
 	struct list_head *list;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa53d96c..28c421ba5094 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -327,6 +327,7 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+void blk_mq_reset_rqs(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.14.4

