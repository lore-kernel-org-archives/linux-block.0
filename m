Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34892 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757077AbdCUP5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2017 11:57:08 -0400
Received: by mail-pg0-f48.google.com with SMTP id t143so29935367pgb.2
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2017 08:57:07 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 1/4] block: remove extra calls to wbt_exit()
Date: Tue, 21 Mar 2017 08:56:05 -0700
Message-Id: <1386deceff74f907b78e3fbea4799b677a45792a.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We always call wbt_exit() from blk_release_queue(), so these are
unnecessary.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c | 1 -
 block/blk-mq.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d772c221cc17..e8a9bc0d4bbb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -889,7 +889,6 @@ int blk_init_allocated_queue(struct request_queue *q)
 		q->exit_rq_fn(q, q->fq->flush_rq);
 out_free_flush_queue:
 	blk_free_flush_queue(q->fq);
-	wbt_exit(q);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(blk_init_allocated_queue);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4546f060e80..534f49a90e3a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2431,8 +2431,6 @@ void blk_mq_free_queue(struct request_queue *q)
 	list_del_init(&q->all_q_node);
 	mutex_unlock(&all_q_mutex);
 
-	wbt_exit(q);
-
 	blk_mq_del_queue_tag_set(q);
 
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
-- 
2.12.0
