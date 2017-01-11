Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758175AbdAKVkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:14 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 03/10] block: move rq_ioc() to blk.h
Date: Wed, 11 Jan 2017 14:39:56 -0700
Message-ID: <1484170803-9311-4-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We want to use it outside of blk-core.c.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c | 16 ----------------
 block/blk.h      | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 61ba08c58b64..92baea07acbc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1040,22 +1040,6 @@ static bool blk_rq_should_init_elevator(struct bio *bio)
 }
 
 /**
- * rq_ioc - determine io_context for request allocation
- * @bio: request being allocated is for this bio (can be %NULL)
- *
- * Determine io_context to use for request allocation for @bio.  May return
- * %NULL if %current->io_context doesn't exist.
- */
-static struct io_context *rq_ioc(struct bio *bio)
-{
-#ifdef CONFIG_BLK_CGROUP
-	if (bio && bio->bi_ioc)
-		return bio->bi_ioc;
-#endif
-	return current->io_context;
-}
-
-/**
  * __get_request - get a free request
  * @rl: request list to allocate from
  * @op: operation and flags
diff --git a/block/blk.h b/block/blk.h
index f46c0ac8ae3d..9a716b5925a4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -264,6 +264,22 @@ void ioc_clear_queue(struct request_queue *q);
 int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
 
 /**
+ * rq_ioc - determine io_context for request allocation
+ * @bio: request being allocated is for this bio (can be %NULL)
+ *
+ * Determine io_context to use for request allocation for @bio.  May return
+ * %NULL if %current->io_context doesn't exist.
+ */
+static inline struct io_context *rq_ioc(struct bio *bio)
+{
+#ifdef CONFIG_BLK_CGROUP
+	if (bio && bio->bi_ioc)
+		return bio->bi_ioc;
+#endif
+	return current->io_context;
+}
+
+/**
  * create_io_context - try to create task->io_context
  * @gfp_mask: allocation mask
  * @node: allocation node
-- 
2.7.4

