Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/7] sbitmap: add helper to inform the core about shallow depth limiting
Date: Wed,  9 May 2018 14:49:24 -0600
Message-Id: <1525898967-13425-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

If a user of sbitmap limits the shallow depth on his own, then
we need to inform the lower layers. Otherwise we can run into
a situation where the user has limited the depth to something
smaller than our wake batch count, which can cause hangs.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/sbitmap.h | 11 +++++++++++
 lib/sbitmap.c           | 19 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 841585f6e5f2..99059789f45f 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -164,6 +164,17 @@ static inline void sbitmap_free(struct sbitmap *sb)
 void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
 
 /**
+ * sbitmap_queue_shallow_depth() - Inform sbitmap about shallow depth changes
+ * @sbq: Bitmap queue in question
+ * @depth: Shallow depth limit
+ *
+ * Due to how sbitmap does batched wakes, if a user of sbitmap updates the
+ * shallow depth, then we might need to update our batched wake counts.
+ *
+ */
+void sbitmap_queue_shallow_depth(struct sbitmap_queue *sbq, unsigned int depth);
+
+/**
  * sbitmap_get() - Try to allocate a free bit from a &struct sbitmap.
  * @sb: Bitmap to allocate from.
  * @alloc_hint: Hint for where to start searching for a free bit.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index e6a9c06ec70c..a4fb48e4c26b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -327,7 +327,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
 
-void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
+static void sbitmap_queue_update_batch_wake(struct sbitmap_queue *sbq,
+					    unsigned int depth)
 {
 	unsigned int wake_batch = sbq_calc_wake_batch(depth);
 	int i;
@@ -342,6 +343,11 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
 			atomic_set(&sbq->ws[i].wait_cnt, 1);
 	}
+}
+
+void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
+{
+	sbitmap_queue_update_batch_wake(sbq, depth);
 	sbitmap_resize(&sbq->sb, depth);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
@@ -403,6 +409,17 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get_shallow);
 
+/*
+ * User has limited the shallow depth to 'depth', update batch wake counts
+ * if depth is smaller than the sbitmap_queue depth
+ */
+void sbitmap_queue_shallow_depth(struct sbitmap_queue *sbq, unsigned int depth)
+{
+	if (depth < sbq->sb.depth)
+		sbitmap_queue_update_batch_wake(sbq, depth);
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_shallow_depth);
+
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;
-- 
2.7.4
