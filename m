Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Date: Tue, 19 Jun 2018 15:00:37 +0800
Message-Id: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently, the kobject_del for kobjs of mq, hctx and ctx is invoked
under sysfs_lock, lock inversion will come up when other one is
acessing the associated sysfs file and trying to acquire the
sysfs_lock. To fix it, use mutex_trylock in blk_mq_sysfs_ops and
blk_mq_hw_sysfs_ops, if the lock in on contending, return -EAGAIN.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sysfs.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb442..210804f 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -53,11 +53,14 @@ static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
 	if (!entry->show)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->show(ctx, page);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->show(ctx, page);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
@@ -76,11 +79,14 @@ static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 	if (!entry->store)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->store(ctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->store(ctx, page, length);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
@@ -99,11 +105,14 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	if (!entry->show)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->show(hctx, page);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->show(hctx, page);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
@@ -123,11 +132,14 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 	if (!entry->store)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->store(hctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->store(hctx, page, length);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
-- 
2.7.4
