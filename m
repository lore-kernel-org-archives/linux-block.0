Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933604AbcI3NXo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:44 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 1/8] block: Get rid of unused request_queue::nr_queues member
Date: Fri, 30 Sep 2016 15:23:23 +0200
Message-Id: <9f9d9aa76b7bf7868556453822ca3d5f5a68ab59.1475241231.git.agordeev@redhat.com>
In-Reply-To: <cover.1475241231.git.agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c         | 2 --
 include/linux/blkdev.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0be5577..c96a168 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1983,8 +1983,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->nr_queues = nr_cpu_ids;
-
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c47c358..0f1bf55 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -325,7 +325,6 @@ struct request_queue {
 
 	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
-	unsigned int		nr_queues;
 
 	/* hw dispatch queues */
 	struct blk_mq_hw_ctx	**queue_hw_ctx;
-- 
1.8.3.1

