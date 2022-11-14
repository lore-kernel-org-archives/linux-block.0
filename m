Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40937C4332F
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 04:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiKNE0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Nov 2022 23:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiKNE0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:26:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406E167DF
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TykzlUIWx7zb5E+4H/+PuY9/ZI8UfeCj3Dxe8qEGMgI=; b=s5wcOA96bKipmftidTPpjqBhgf
        mrg/y+Ox/pDh99GWtNGVIUxtps8uakJG7au+ezhcaRVtH8jL/vKxcVeuQm0IUuzbaEFpHSZt2lD3M
        RIcG9GpKqQTVD8ESkiYJ2mG0d+LyWqeB+wZYG1yv8nUm+zEOXG55yvAUzHAPsxpJeSqlBYOdIkQd2
        aMLn7eh9TawvtH5Tj0EoN8ckSL051DJA1UTzNH/xS34G9jRjUgHbMu1u7Ppnb/k+FMrkMtos9TMKf
        TNpY7jhnZ38pxwczlkDrtuzJ7KlVm3m8e5oYg8T18uDppC06s18ZmqtAVICFCiehM2dhPNYaLLc3K
        PdKx2meA==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouR3a-00Fv7T-Dg; Mon, 14 Nov 2022 04:26:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: untangle request_queue refcounting from sysfs
Date:   Mon, 14 Nov 2022 05:26:36 +0100
Message-Id: <20221114042637.1009333-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
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
 block/blk-core.c         | 42 ++++++++++++++++----
 block/blk-crypto-sysfs.c |  4 +-
 block/blk-ia-ranges.c    |  3 +-
 block/blk-sysfs.c        | 86 +++++++++++-----------------------------
 block/blk.h              |  4 --
 block/bsg.c              | 11 +++--
 block/elevator.c         |  2 +-
 include/linux/blkdev.h   |  6 +--
 8 files changed, 71 insertions(+), 87 deletions(-)

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
index e05f145cd797f..55268edc06253 100644
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
index abd1784ff05e3..93d9e9c9a6ea8 100644
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
 
 static void blk_debugfs_remove(struct gendisk *disk)
@@ -823,20 +784,20 @@ int blk_register_queue(struct gendisk *disk)
 	int ret;
 
 	mutex_lock(&q->sysfs_dir_lock);
-	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
+	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
+	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
-		goto out_unlock_dir;
+		goto out_put_queue_kobj;
 
 	if (queue_is_mq(q)) {
 		ret = blk_mq_sysfs_register(disk);
 		if (ret)
-			goto out_del_queue_kobj;
+			goto out_put_queue_kobj;
 	}
 	mutex_lock(&q->sysfs_lock);
 
 	mutex_lock(&q->debugfs_mutex);
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
+	q->debugfs_dir = debugfs_create_dir(disk->disk_name, blk_debugfs_root);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
 	mutex_unlock(&q->debugfs_mutex);
@@ -860,7 +821,7 @@ int blk_register_queue(struct gendisk *disk)
 	blk_throtl_register(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
-	kobject_uevent(&q->kobj, KOBJ_ADD);
+	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
 	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
@@ -889,9 +850,8 @@ int blk_register_queue(struct gendisk *disk)
 out_debugfs_remove:
 	blk_debugfs_remove(disk);
 	mutex_unlock(&q->sysfs_lock);
-out_del_queue_kobj:
-	kobject_del(&q->kobj);
-out_unlock_dir:
+out_put_queue_kobj:
+	kobject_put(&disk->queue_kobj);
 	mutex_unlock(&q->sysfs_dir_lock);
 	return ret;
 }
@@ -938,8 +898,8 @@ void blk_unregister_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 
 	/* Now that we've deleted all child objects, we can delete the queue. */
-	kobject_uevent(&q->kobj, KOBJ_REMOVE);
-	kobject_del(&q->kobj);
+	kobject_uevent(&disk->queue_kobj, KOBJ_REMOVE);
+	kobject_del(&disk->queue_kobj);
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	blk_debugfs_remove(disk);
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
index a5bdc3b1e7e5b..e51e4dc96d2e4 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -468,7 +468,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 
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

