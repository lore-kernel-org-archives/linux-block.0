Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD5C282E1
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183EC2175B
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfDWM37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDWM36 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 08:29:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C69AFAE2B;
        Tue, 23 Apr 2019 12:29:57 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes@suse.de
Subject: [PATCH 5/5] blk-mq: free q->queue_hw_ctx in blk_mq_exit_queue()
Date:   Tue, 23 Apr 2019 14:29:51 +0200
Message-Id: <20190423122951.134531-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_exit_queue() already frees up all hardware contexts, so it should
be freeing up the holding array, too.

Signed-off-by: Hannes Reinecke <hare@suse.com.
---
 block/blk-mq.c | 11 +++++++++--
 block/blk-mq.h |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f620462dc4d1..ae873d333f5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -462,7 +462,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
-	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
+	if (q->queue_hw_ctx)
+		alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EXDEV);
@@ -2673,7 +2674,8 @@ void blk_mq_release(struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	kfree(q->queue_hw_ctx);
+	/* Ensure that blk_mq_exit_queue() has been called */
+	WARN_ON(q->queue_hw_ctx);
 
 	/*
 	 * release .mq_kobj and sw queue's kobject now because
@@ -2930,6 +2932,8 @@ void blk_mq_exit_queue(struct request_queue *q)
 
 	blk_mq_del_queue_tag_set(q);
 	blk_mq_exit_hw_queues(q, set);
+	kfree(q->queue_hw_ctx);
+	q->queue_hw_ctx = NULL;
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
@@ -3477,6 +3481,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
+	if (!q->queue_hw_ctx)
+		return 0;
+
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c421e3a16e36..14589b9fca84 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -188,7 +188,7 @@ static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 {
-	return hctx->nr_ctx && hctx->tags;
+	return hctx && hctx->nr_ctx && hctx->tags;
 }
 
 unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
-- 
2.16.4

