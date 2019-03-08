Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB20C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DEF20868
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCHRjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:39:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:33276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfCHRjf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 12:39:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132430639"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 09:39:35 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/5] blk-mq: Export reading mq request state
Date:   Fri,  8 Mar 2019 10:40:02 -0700
Message-Id: <20190308174006.5032-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers may need to know the state of their requets.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.h         | 9 ---------
 include/linux/blkdev.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index c11353a3749d..99ab7e472e62 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -128,15 +128,6 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-/**
- * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
- * @rq: target request.
- */
-static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
-{
-	return READ_ONCE(rq->state);
-}
-
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index faed9d9eb84c..db113aee48bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -241,6 +241,15 @@ struct request {
 	struct request *next_rq;
 };
 
+/**
+ * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
+ * @rq: target request.
+ */
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
+{
+	return READ_ONCE(rq->state);
+}
+
 static inline bool blk_op_is_scsi(unsigned int op)
 {
 	return op == REQ_OP_SCSI_IN || op == REQ_OP_SCSI_OUT;
-- 
2.14.4

