Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B9C4360C
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 01:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1EE20650
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 01:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfJNBu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 21:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbfJNBu7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 21:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F263800DF5;
        Mon, 14 Oct 2019 01:50:59 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C75A60BE0;
        Mon, 14 Oct 2019 01:50:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH V4 1/5] blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
Date:   Mon, 14 Oct 2019 09:50:39 +0800
Message-Id: <20191014015043.25029-2-ming.lei@redhat.com>
In-Reply-To: <20191014015043.25029-1-ming.lei@redhat.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Mon, 14 Oct 2019 01:50:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new hw queue state of BLK_MQ_S_INTERNAL_STOPPED, which prepares
for stopping hw queue before all CPUs of this hctx become offline.

We can't reuse BLK_MQ_S_STOPPED because that state can be cleared during IO
completion.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: John Garry <john.garry@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 1 +
 block/blk-mq.h         | 3 ++-
 include/linux/blk-mq.h | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..af40a02c46ee 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -213,6 +213,7 @@ static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(INTERNAL_STOPPED),
 };
 #undef HCTX_STATE_NAME
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 32c62c64e6c2..63717573bc16 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -176,7 +176,8 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
-	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	return test_bit(BLK_MQ_S_STOPPED, &hctx->state) ||
+		test_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
 }
 
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..079c282e4471 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -235,6 +235,9 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
 
+	/* hw queue is internal stopped, driver do not use it */
+	BLK_MQ_S_INTERNAL_STOPPED	= 3,
+
 	BLK_MQ_MAX_DEPTH	= 10240,
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
-- 
2.20.1

