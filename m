Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9038C4332F
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 08:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKEII0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 04:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKEIIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 04:08:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362611FB
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=W1E4KH9lzMyFBntta3Y1BD1DNcmWVX/meY1mLOHsNbk=; b=QudaCbqNmbzEyoo6KPMCx44G5i
        GcF9/hrku82DU8yM6jyBTW5fSeenKSZ8i/8WV2xZxcXxZo2VL5a4TFc2sVNB3lnfXxdHFxtdl1NNu
        pPCMPLGZvz6OnFLU8GkRdOWzeVlpUOXrjhEfSRtOgvbROixcyQ3/7VmLYuCk0Z0gFN7QQvosEieuj
        v8beda8MLmQbPuvdA//d5FdBabvsWX4QdlKQG9M4wFOxMG4pVuMLrT6or7+cUHzcIIu/WGFDQRJx3
        FMGqfEJ6KgeX2AjhF0qEUJe0RaTNv1x0os+rFtY3aS89dBRL5FPJkNtcWc7rckkC2zUtVFqGvuUTp
        djKyjEOQ==;
Received: from [2001:4bb8:182:29ca:2575:8443:617d:3eec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orEE0-0064Je-Ew; Sat, 05 Nov 2022 08:08:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: untangle request_queue refcounting from sysfs
Date:   Sat,  5 Nov 2022 09:08:14 +0100
Message-Id: <20221105080815.775721-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221105080815.775721-1-hch@lst.de>
References: <20221105080815.775721-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kobject embedded into the request_queue is used for the queue
directory in sysfs, but that is a child of the gendisks directory and is
intimately tied to it.  Move this kobject to the gendisk and use a
refcount_t in the request_queue for the actual request_queue refcounting
that is completely unrelated to the device model.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c         | 42 +++++++++++++++++----
 block/blk-crypto-sysfs.c |  4 +-
 block/blk-ia-ranges.c    |  3 +-
 block/blk-sysfs.c        | 79 ++++++++++------------------------------
 block/blk.h              |  4 --
 block/bsg.c              | 11 ++++--
 block/elevator.c         |  2 +-
 include/linux/blkdev.h   |  6 +--
 8 files changed, 68 insertions(+), 83 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e9e2bf15cd909..d14317bfdf654 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -59,12 +59,12 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_split);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_insert);
 
-DEFINE_IDA(blk_queue_ida);
+static DEFINE_IDA(blk_queue_ida);
 
 /*
  * For queue allocation
  */
-struct kmem_cache *blk_requestq_cachep;
+static struct kmem_cache *blk_requestq_cachep;
 
 /*
  * Controlling structure to kblockd
@@ -252,19 +252,46 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
+static void blk_free_queue_rcu(struct rcu_head *rcu_head)
+{
+	kmem_cache_free(blk_requestq_cachep,
+			container_of(rcu_head, struct request_queue, rcu_head));
+}
+
+static void blk_free_queue(struct request_queue *q)
+{
+	might_sleep();
+
+	percpu_ref_exit(&q->q_usage_counter);
+
+	if (q->poll_stat)
+		blk_stat_remove_callback(q, q->poll_cb);
+	blk_stat_free_callback(q->poll_cb);
+
+	blk_free_queue_stats(q->stats);
+	kfree(q->poll_stat);
+
+	if (queue_is_mq(q))
+		blk_mq_release(q);
+
+	ida_free(&blk_queue_ida, q->id);
+	call_rcu(&q->rcu_head, blk_free_queue_rcu);
+}
+
 /**
  * blk_put_queue - decrement the request_queue refcount
  * @q: the request_queue structure to decrement the refcount for
  *
- * Decrements the refcount of the request_queue kobject. When this reaches 0
- * we'll have blk_release_queue() called.
+ * Decrements the refcount of the request_queue and free it when the refcount
+ * reaches 0.
  *
  * Context: Any context, but the last reference must not be dropped from
  *          atomic context.
  */
 void blk_put_queue(struct request_queue *q)
 {
-	kobject_put(&q->kobj);
+	if (refcount_dec_and_test(&q->refs))
+		blk_free_queue(q);
 }
 EXPORT_SYMBOL(blk_put_queue);
 
@@ -399,8 +426,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
 
-	kobject_init(&q->kobj, &blk_queue_ktype);
-
+	refcount_set(&q->refs, 1);
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
@@ -445,7 +471,7 @@ bool blk_get_queue(struct request_queue *q)
 {
 	if (unlikely(blk_queue_dying(q)))
 		return false;
-	kobject_get(&q->kobj);
+	refcount_inc(&q->refs);
 	return true;
 }
 EXPORT_SYMBOL(blk_get_queue);
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index a638a2eecfc89..e74a918ef9f18 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -140,8 +140,8 @@ int blk_crypto_sysfs_register(struct gendisk *disk)
 		return -ENOMEM;
 	obj->profile = q->crypto_profile;
 
-	err = kobject_init_and_add(&obj->kobj, &blk_crypto_ktype, &q->kobj,
-				   "crypto");
+	err = kobject_init_and_add(&obj->kobj, &blk_crypto_ktype,
+				   &disk->queue_kobj, "crypto");
 	if (err) {
 		kobject_put(&obj->kobj);
 		return err;
diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 2bd1d311033b5..2141931ddd37e 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -123,7 +123,8 @@ int disk_register_independent_access_ranges(struct gendisk *disk)
 	 */
 	WARN_ON(iars->sysfs_registered);
 	ret = kobject_init_and_add(&iars->kobj, &blk_ia_ranges_ktype,
-				   &q->kobj, "%s", "independent_access_ranges");
+				   &disk->queue_kobj, "%s",
+				   "independent_access_ranges");
 	if (ret) {
 		disk->ia_ranges = NULL;
 		kobject_put(&iars->kobj);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 440149d0e21b9..6d26cb55de113 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -683,8 +683,8 @@ static struct attribute *queue_attrs[] = {
 static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 				int n)
 {
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
+	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
+	struct request_queue *q = disk->queue;
 
 	if (attr == &queue_io_timeout_entry.attr &&
 		(!q->mq_ops || !q->mq_ops->timeout))
@@ -710,8 +710,8 @@ static ssize_t
 queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
 	struct queue_sysfs_entry *entry = to_queue(attr);
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
+	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
+	struct request_queue *q = disk->queue;
 	ssize_t res;
 
 	if (!entry->show)
@@ -727,63 +727,19 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 		    const char *page, size_t length)
 {
 	struct queue_sysfs_entry *entry = to_queue(attr);
-	struct request_queue *q;
+	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
+	struct request_queue *q = disk->queue;
 	ssize_t res;
 
 	if (!entry->store)
 		return -EIO;
 
-	q = container_of(kobj, struct request_queue, kobj);
 	mutex_lock(&q->sysfs_lock);
 	res = entry->store(q, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
 
-static void blk_free_queue_rcu(struct rcu_head *rcu_head)
-{
-	kmem_cache_free(blk_requestq_cachep,
-			container_of(rcu_head, struct request_queue, rcu_head));
-}
-
-/**
- * blk_release_queue - releases all allocated resources of the request_queue
- * @kobj: pointer to a kobject, whose container is a request_queue
- *
- * This function releases all allocated resources of the request queue.
- *
- * The struct request_queue refcount is incremented with blk_get_queue() and
- * decremented with blk_put_queue(). Once the refcount reaches 0 this function
- * is called.
- *
- * Drivers exist which depend on the release of the request_queue to be
- * synchronous, it should not be deferred.
- *
- * Context: can sleep
- */
-static void blk_release_queue(struct kobject *kobj)
-{
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
-
-	might_sleep();
-
-	percpu_ref_exit(&q->q_usage_counter);
-
-	if (q->poll_stat)
-		blk_stat_remove_callback(q, q->poll_cb);
-	blk_stat_free_callback(q->poll_cb);
-
-	blk_free_queue_stats(q->stats);
-	kfree(q->poll_stat);
-
-	if (queue_is_mq(q))
-		blk_mq_release(q);
-
-	ida_free(&blk_queue_ida, q->id);
-	call_rcu(&q->rcu_head, blk_free_queue_rcu);
-}
-
 static const struct sysfs_ops queue_sysfs_ops = {
 	.show	= queue_attr_show,
 	.store	= queue_attr_store,
@@ -794,10 +750,15 @@ static const struct attribute_group *blk_queue_attr_groups[] = {
 	NULL
 };
 
-struct kobj_type blk_queue_ktype = {
+static void blk_queue_release(struct kobject *kobj)
+{
+	/* nothing to do here, all data is associated with the parent gendisk */
+}
+
+static struct kobj_type blk_queue_ktype = {
 	.default_groups = blk_queue_attr_groups,
 	.sysfs_ops	= &queue_sysfs_ops,
-	.release	= blk_release_queue,
+	.release	= blk_queue_release,
 };
 
 /**
@@ -811,7 +772,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	mutex_lock(&q->sysfs_dir_lock);
 
-	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
+	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
+	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
 		goto unlock;
 
@@ -820,8 +782,7 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_lock(&q->sysfs_lock);
 
 	mutex_lock(&q->debugfs_mutex);
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
+	q->debugfs_dir = debugfs_create_dir(disk->disk_name, blk_debugfs_root);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
 	mutex_unlock(&q->debugfs_mutex);
@@ -845,7 +806,7 @@ int blk_register_queue(struct gendisk *disk)
 	blk_throtl_register(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
-	kobject_uevent(&q->kobj, KOBJ_ADD);
+	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
 	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
@@ -874,7 +835,7 @@ int blk_register_queue(struct gendisk *disk)
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
-	kobject_del(&q->kobj);
+	kobject_del(&disk->queue_kobj);
 
 	return ret;
 }
@@ -921,8 +882,8 @@ void blk_unregister_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 
 	/* Now that we've deleted all child objects, we can delete the queue. */
-	kobject_uevent(&q->kobj, KOBJ_REMOVE);
-	kobject_del(&q->kobj);
+	kobject_uevent(&disk->queue_kobj, KOBJ_REMOVE);
+	kobject_del(&disk->queue_kobj);
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	mutex_lock(&q->debugfs_mutex);
diff --git a/block/blk.h b/block/blk.h
index e85703ae81dd1..a8ac9803fcb36 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -26,10 +26,6 @@ struct blk_flush_queue {
 	spinlock_t		mq_flush_lock;
 };
 
-extern struct kmem_cache *blk_requestq_cachep;
-extern struct kobj_type blk_queue_ktype;
-extern struct ida blk_queue_ida;
-
 bool is_flush_rq(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
diff --git a/block/bsg.c b/block/bsg.c
index 2ab1351eb0823..8eba57b9bb461 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -175,8 +175,10 @@ static void bsg_device_release(struct device *dev)
 
 void bsg_unregister_queue(struct bsg_device *bd)
 {
-	if (bd->queue->kobj.sd)
-		sysfs_remove_link(&bd->queue->kobj, "bsg");
+	struct gendisk *disk = bd->queue->disk;
+
+	if (disk && disk->queue_kobj.sd)
+		sysfs_remove_link(&disk->queue_kobj, "bsg");
 	cdev_device_del(&bd->cdev, &bd->device);
 	put_device(&bd->device);
 }
@@ -216,8 +218,9 @@ struct bsg_device *bsg_register_queue(struct request_queue *q,
 	if (ret)
 		goto out_put_device;
 
-	if (q->kobj.sd) {
-		ret = sysfs_create_link(&q->kobj, &bd->device.kobj, "bsg");
+	if (q->disk && q->disk->queue_kobj.sd) {
+		ret = sysfs_create_link(&q->disk->queue_kobj, &bd->device.kobj,
+					"bsg");
 		if (ret)
 			goto out_device_del;
 	}
diff --git a/block/elevator.c b/block/elevator.c
index 800e0038be0d7..1d47eecad7c65 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -469,7 +469,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	error = kobject_add(&e->kobj, &q->kobj, "%s", "iosched");
+	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
 		struct elv_fs_entry *attr = e->type->elevator_attrs;
 		if (attr) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9188aa3f62595..6e6d172309880 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -155,6 +155,7 @@ struct gendisk {
 	unsigned open_partitions;	/* number of open partitions */
 
 	struct backing_dev_info	*bdi;
+	struct kobject queue_kobj;	/* the queue/ directory */
 	struct kobject *slave_dir;
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	struct list_head slave_bdevs;
@@ -430,10 +431,7 @@ struct request_queue {
 
 	struct gendisk		*disk;
 
-	/*
-	 * queue kobject
-	 */
-	struct kobject kobj;
+	refcount_t		refs;
 
 	/*
 	 * mq queue kobject
-- 
2.30.2

