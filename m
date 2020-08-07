Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05246C433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FCB22C9F
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHGJGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:06:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbgHGJGp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 05:06:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2538E3DAAE3A2F39DFD7;
        Fri,  7 Aug 2020 17:06:39 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:06:31 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH v2 2/3] blk-mq: introduce async mechanism for quiesce queue
Date:   Fri, 7 Aug 2020 17:06:30 +0800
Message-ID: <20200807090630.29693-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some scenarios we need quiesce lots of queues together, if quiesce
one by one, may need long time.
Introduce async mechanism for quiesce queue: quiesce queues together
but no wait, and then wait until all queues ongoing dispatches complete.
Thus reduce serial wait time.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c         | 28 ++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9aa6d1e44cf..2fc2fd666bda 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -235,6 +235,34 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
+/*
+ * blk_mq_quiesce_queue_async - do not wait until all ongoing dispatches
+ * completed, used for sync lots of queues together to reduce wait time.
+ * Must be used together with blk_mq_quiesce_queue_async_wait.
+ * Caution: do not support concurrent.
+ */
+void blk_mq_quiesce_queue_async(struct request_queue *q, atomic_t *count)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			synchronize_srcu_async(hctx->srcu, count);
+	}
+
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(atomic_t *count)
+{
+	synchronize_rcu();
+	while (atomic_read(count))
+		schedule();
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
 /*
  * blk_mq_unquiesce_queue() - counterpart of blk_mq_quiesce_queue()
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6fcae17da5a..27a713ad73bb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -515,6 +515,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q, atomic_t *count);
+void blk_mq_quiesce_queue_async_wait(atomic_t *count);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
-- 
2.16.4

