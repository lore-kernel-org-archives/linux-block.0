Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: cleanup blk_mq_register_dev
Date: Fri, 22 Jun 2018 15:11:19 +0800
Message-Id: <1529651480-1734-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

nobody invokes blk_mq_register_dev, remove it and change
__blk_mq_register_dev to blk_mq_register_dev. In addition, move
the declaration of blk_mq_register/unregister_dev to block/blk-mq.h
because they are only used by block layer.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sysfs.c   | 14 +-------------
 block/blk-mq.h         |  3 +++
 block/blk-sysfs.c      |  2 +-
 include/linux/blk-mq.h |  3 ---
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb442..ec26745 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -295,7 +295,7 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
+int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
@@ -330,18 +330,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
-int blk_mq_register_dev(struct device *dev, struct request_queue *q)
-{
-	int ret;
-
-	mutex_lock(&q->sysfs_lock);
-	ret = __blk_mq_register_dev(dev, q);
-	mutex_unlock(&q->sysfs_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(blk_mq_register_dev);
-
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89231e4..7f87e03 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -30,6 +30,9 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+int blk_mq_register_dev(struct device *dev, struct request_queue *q);
+void blk_mq_unregister_dev(struct device *dev, struct request_queue *q);
+
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 159c586..96dcbb9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -897,7 +897,7 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	if (q->mq_ops) {
-		__blk_mq_register_dev(dev, q);
+		blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
 	}
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0a509ae..61b3833 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -201,9 +201,6 @@ enum {
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q);
-int blk_mq_register_dev(struct device *, struct request_queue *);
-void blk_mq_unregister_dev(struct device *, struct request_queue *);
-
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
-- 
2.7.4
