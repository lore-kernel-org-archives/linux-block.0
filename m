Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58617 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbcEZGYv (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 26 May 2016 02:24:51 -0400
From: Ming Lin <mlin@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: clear q->mq_ops if init fail
Date: Wed, 25 May 2016 23:23:27 -0700
Message-id: <1464243807-27526-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ming Lin <ming.l@samsung.com>

blk_mq_init_queue() calls blk_mq_init_allocated_queue(), but q->mq_ops
was not cleared when blk_mq_init_allocated_queue() fails.
Then blk_cleanup_queue() calls blk_mq_free_queue() which will crash because:
- q->all_q_node is not added to all_q_list yet
- q->tag_set is NULL
- hctx was not setup yet or already freed

Fixed it by clearing q->mq_ops on error path.

Signed-off-by: Ming Lin <ming.l@samsung.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 67bf8ed..86f08b1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2054,7 +2054,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
 	if (!q->queue_ctx)
-		return ERR_PTR(-ENOMEM);
+		goto err_exit;
 
 	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
 						GFP_KERNEL, set->numa_node);
@@ -2118,6 +2118,8 @@ err_map:
 	kfree(q->queue_hw_ctx);
 err_percpu:
 	free_percpu(q->queue_ctx);
+err_exit:
+	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(blk_mq_init_allocated_queue);
-- 
1.9.1

