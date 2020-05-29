Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8596C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB58208B8
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763926;
	bh=yUjck9Ck5IqzAHsdyjVWD/HT7fy28nfsAzucztHoAM0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XuDA8VQe+BEw/5QSCssIJyHdbkp//cc9JNiV3yhkoGmGOIObIsGSjxpDW6ZnS9zWy
	 4bqICCZetWUjcAvATfbsorsAMkyCtpB02tyPE+FGdlWMDFtsW8Nv9vOp/CJgRvaIYu
	 3hs8kbrajuQtP2o7a0iEVEHwizlsj9tKambzHshw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2OwF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 10:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2OwF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:52:05 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A526820776;
        Fri, 29 May 2020 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763925;
        bh=yUjck9Ck5IqzAHsdyjVWD/HT7fy28nfsAzucztHoAM0=;
        h=From:To:Cc:Subject:Date:From;
        b=qbrkbGBeJGHgxgFWZUWLHHUJdWJAg8Wk2z/h7hD4+sTXnI2I8ggMrWafS0+IDEhIY
         SkmHtQfxbHRzMfo6iA8VsfbaBnmIxjGovwcES4zPnG7kWewMc6Haz0vYuiq4mVYG2X
         YNdGYYuowMN9zHxzMwLJ91c+GKdv9ZWUT4LF4y88=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alan.adamson@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/2] blk-mq: blk-mq: provide forced completion method
Date:   Fri, 29 May 2020 07:51:59 -0700
Message-Id: <20200529145200.3545747-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers may need to bypass error injection for error recovery. Rename
__blk_mq_complete_request() to blk_mq_force_complete_rq() and export
that function so drivers may skip potential fake timeouts after they've
reclaimed lost requests.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 15 +++++++++++++--
 include/linux/blk-mq.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f602..560a114a82f8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -556,7 +556,17 @@ static void __blk_mq_complete_request_remote(void *data)
 	q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+/**
+ * blk_mq_force_complete_rq() - Force complete the request, bypassing any error
+ * 				injection that could drop the completion.
+ * @rq: Request to be force completed
+ *
+ * Drivers should use blk_mq_complete_request() to complete requests in their
+ * normal IO path. For timeout error recovery, drivers may call this forced
+ * completion routine after they've reclaimed timed out requests to bypass
+ * potentially subsequent fake timeouts.
+ */
+void blk_mq_force_complete_rq(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -602,6 +612,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 	put_cpu();
 }
+EXPORT_SYMBOL_GPL(blk_mq_force_complete_rq);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
@@ -635,7 +646,7 @@ bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return false;
-	__blk_mq_complete_request(rq);
+	blk_mq_force_complete_rq(rq);
 	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a..856bb10993cf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void blk_mq_force_complete_rq(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.24.1

