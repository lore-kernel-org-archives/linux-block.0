Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102025A2C6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454771; cv=none; b=QXkXbAV+f74LTKS3Tg3/xhn3NAZrImkI2AflqAQFzrgmb55NDUfAw3NX9X71u7y6jnRCBYDLxh623oYGtrJ+JLY3nVp/BNZWO+IZCccTzMz8bZQo6r8OUixza3HH7k8oU3b2IerOV+5whrAeco6dkLhapvMQf/op/vK6VCxD58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454771; c=relaxed/simple;
	bh=uD6rN1T7QEknHCxBHc20gYOUhsQqdxn105fZCYrptHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNKjpaWS0tPzZfeV6w4csn6M60fNFdUMtrKlsL7zYt+pwhnv9Oy5CFFTLwfwXOPlP9J7oZCsor4ehbqOwoeMOAHw9mSGjzCyXJJaYZKbIvpjF5Utz8EJxzvXL9LHxovKIykktrSRnRZm//IZ3uU4ABjWNhpYzBCsDO1vMI6S4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvJVIOzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvJVIOzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAAbUtLSPsgljP/7HB9cAqzKx6DHvTLZgAsvtYDyBWA=;
	b=ZvJVIOzgqddwB6lMthoXnLCHBnegJMjnMMPb5gIb/ltYH055n5Wo99JaT+2mKG1NbGAHrp
	fybQpPSInVpJHG7TiZOXjdXunFeKncbdMzqAk0gsKNOL5OwW10v1Eazdi+7Hx7b5ZrQgEb
	E8CCSP1jZXKupRoahO65rOyh+e9Zz3U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-UjwXZqq_O5WHibfvda8yJQ-1; Mon,
 05 May 2025 10:19:26 -0400
X-MC-Unique: UjwXZqq_O5WHibfvda8yJQ-1
X-Mimecast-MFC-AGG-ID: UjwXZqq_O5WHibfvda8yJQ_1746454764
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D4271800984;
	Mon,  5 May 2025 14:19:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66B0230001AB;
	Mon,  5 May 2025 14:19:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 16/25] block: unifying elevator change
Date: Mon,  5 May 2025 22:17:54 +0800
Message-ID: <20250505141805.2751237-17-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Elevator change is one well-define behavior:

- tear down current elevator if it exists

- setup new elevator

It is supposed to cover any case for changing elevator by single
internal API, typically the following cases:

- setup default elevator in add_disk()

- switch to none in del_disk()

- reset elevator in blk_mq_update_nr_hw_queues()

- switch elevator in sysfs `store` elevator attribute

This patch uses elevator_change() to cover all above cases:

- every elevator switch is serialized with each other: add_disk/del_disk/
store elevator is serialized already, blk_mq_update_nr_hw_queues() uses
srcu for syncing with the other three cases

- for both add_disk()/del_disk(), queue freeze works at atomic mode
or has been froze, so the freeze in elevator_change() won't add extra
delay

- `struct elev_change_ctx` instance holds any info for changing elevator

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c |  19 +++-----
 block/blk.h       |   5 +-
 block/elevator.c  | 116 +++++++++++++++++++++-------------------------
 block/genhd.c     |  28 ++---------
 4 files changed, 67 insertions(+), 101 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1f9b45b0b9ee..741e607dfab6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -869,14 +869,9 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		goto out_unregister_ia_ranges;
 
+	if (queue_is_mq(q))
+		elevator_set_default(q);
 	mutex_lock(&q->elevator_lock);
-	if (q->elevator) {
-		ret = elv_register_queue(q, false);
-		if (ret) {
-			mutex_unlock(&q->elevator_lock);
-			goto out_crypto_sysfs_unregister;
-		}
-	}
 	wbt_enable_default(disk);
 	mutex_unlock(&q->elevator_lock);
 
@@ -902,8 +897,6 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 
-out_crypto_sysfs_unregister:
-	blk_crypto_sysfs_unregister(disk);
 out_unregister_ia_ranges:
 	disk_unregister_independent_access_ranges(disk);
 out_debugfs_remove:
@@ -951,9 +944,11 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	mutex_lock(&q->elevator_lock);
-	elv_unregister_queue(q);
-	mutex_unlock(&q->elevator_lock);
+	if (queue_is_mq(q)) {
+		blk_mq_quiesce_queue(q);
+		elevator_set_none(q);
+		blk_mq_unquiesce_queue(q);
+	}
 
 	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
diff --git a/block/blk.h b/block/blk.h
index 98fd3a6f5ec9..23b6ed27e5d1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -323,9 +323,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 bool blk_insert_flush(struct request *rq);
 
 void elv_update_nr_hw_queues(struct request_queue *q);
-void elevator_exit(struct request_queue *q);
-int elv_register_queue(struct request_queue *q, bool uevent);
-void elv_unregister_queue(struct request_queue *q);
+void elevator_set_default(struct request_queue *q);
+void elevator_set_none(struct request_queue *q);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index 6cfac8f77d9f..540542cee21c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -154,7 +154,7 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-void elevator_exit(struct request_queue *q)
+static void elevator_exit(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -458,7 +458,7 @@ static const struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-int elv_register_queue(struct request_queue *q, bool uevent)
+static int elv_register_queue(struct request_queue *q, bool uevent)
 {
 	struct elevator_queue *e = q->elevator;
 	int error;
@@ -488,7 +488,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-void elv_unregister_queue(struct request_queue *q)
+static void elv_unregister_queue(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -561,66 +561,6 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-/*
- * For single queue devices, default to using mq-deadline. If we have multiple
- * queues or mq-deadline is not available, default to "none".
- */
-static struct elevator_type *elevator_get_default(struct request_queue *q)
-{
-	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
-		return NULL;
-
-	if (q->nr_hw_queues != 1 &&
-	    !blk_mq_is_shared_tags(q->tag_set->flags))
-		return NULL;
-
-	return elevator_find_get("mq-deadline");
-}
-
-/*
- * Use the default elevator settings. If the chosen elevator initialization
- * fails, fall back to the "none" elevator (no elevator).
- */
-void elevator_init_mq(struct request_queue *q)
-{
-	struct elevator_type *e;
-	unsigned int memflags;
-	int err;
-
-	WARN_ON_ONCE(blk_queue_registered(q));
-
-	if (unlikely(q->elevator))
-		return;
-
-	e = elevator_get_default(q);
-	if (!e)
-		return;
-
-	/*
-	 * We are called before adding disk, when there isn't any FS I/O,
-	 * so freezing queue plus canceling dispatch work is enough to
-	 * drain any dispatch activities originated from passthrough
-	 * requests, then no need to quiesce queue which may add long boot
-	 * latency, especially when lots of disks are involved.
-	 *
-	 * Disk isn't added yet, so verifying queue lock only manually.
-	 */
-	memflags = blk_mq_freeze_queue(q);
-
-	blk_mq_cancel_work_sync(q);
-
-	err = blk_mq_init_sched(q, e);
-
-	blk_mq_unfreeze_queue(q, memflags);
-
-	if (err) {
-		pr_warn("\"%s\" elevator initialization failed, "
-			"falling back to \"none\"\n", e->elevator_name);
-	}
-
-	elevator_put(e);
-}
-
 /*
  * Switch to new_e io scheduler.
  *
@@ -688,6 +628,16 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
 	memflags = blk_mq_freeze_queue(q);
+	/*
+	 * May be called before adding disk, when there isn't any FS I/O,
+	 * so freezing queue plus canceling dispatch work is enough to
+	 * drain any dispatch activities originated from passthrough
+	 * requests, then no need to quiesce queue which may add long boot
+	 * latency, especially when lots of disks are involved.
+	 *
+	 * Disk isn't added yet, so verifying queue lock only manually.
+	 */
+	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
 		ret = elevator_switch(q, ctx);
@@ -716,6 +666,46 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	mutex_unlock(&q->elevator_lock);
 }
 
+/*
+ * Use the default elevator settings. If the chosen elevator initialization
+ * fails, fall back to the "none" elevator (no elevator).
+ */
+void elevator_set_default(struct request_queue *q)
+{
+	struct elv_change_ctx ctx = {
+		.name = "mq-deadline",
+		.no_uevent = true,
+	};
+	int err = 0;
+
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+		return;
+
+	/*
+	 * For single queue devices, default to using mq-deadline. If we
+	 * have multiple queues or mq-deadline is not available, default
+	 * to "none".
+	 */
+	if (elevator_find_get(ctx.name) && (q->nr_hw_queues == 1 ||
+			 blk_mq_is_shared_tags(q->tag_set->flags)))
+		err = elevator_change(q, &ctx);
+	if (err < 0)
+		pr_warn("\"%s\" elevator initialization, failed %d, "
+			"falling back to \"none\"\n", ctx.name, err);
+}
+
+void elevator_set_none(struct request_queue *q)
+{
+	struct elv_change_ctx ctx = {
+		.name	= "none",
+	};
+	int err;
+
+	err = elevator_change(q, &ctx);
+	if (err < 0)
+		pr_warn("%s: set none elevator failed %d\n", __func__, err);
+}
+
 static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
diff --git a/block/genhd.c b/block/genhd.c
index e0dd8ecc925f..f192fe4808b9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -432,12 +432,6 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		if (disk->fops->submit_bio || disk->fops->poll_bio)
 			return -EINVAL;
-
-		/*
-		 * Initialize the I/O scheduler code and pick a default one if
-		 * needed.
-		 */
-		elevator_init_mq(disk->queue);
 	} else {
 		if (!disk->fops->submit_bio)
 			return -EINVAL;
@@ -454,7 +448,7 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 	ret = -EINVAL;
 	if (disk->major) {
 		if (WARN_ON(!disk->minors))
-			goto out_exit_elevator;
+			goto out;
 
 		if (disk->minors > DISK_MAX_PARTS) {
 			pr_err("block: can't allocate more than %d partitions\n",
@@ -464,14 +458,14 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 		if (disk->first_minor > MINORMASK ||
 		    disk->minors > MINORMASK + 1 ||
 		    disk->first_minor + disk->minors > MINORMASK + 1)
-			goto out_exit_elevator;
+			goto out;
 	} else {
 		if (WARN_ON(disk->minors))
-			goto out_exit_elevator;
+			goto out;
 
 		ret = blk_alloc_ext_minor();
 		if (ret < 0)
-			goto out_exit_elevator;
+			goto out;
 		disk->major = BLOCK_EXT_MAJOR;
 		disk->first_minor = ret;
 	}
@@ -561,12 +555,7 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
-out_exit_elevator:
-	if (disk->queue->elevator) {
-		mutex_lock(&disk->queue->elevator_lock);
-		elevator_exit(disk->queue);
-		mutex_unlock(&disk->queue->elevator_lock);
-	}
+out:
 	return ret;
 }
 
@@ -760,14 +749,7 @@ static void __del_gendisk(struct gendisk *disk)
 	if (queue_is_mq(q))
 		blk_mq_cancel_work_sync(q);
 
-	blk_mq_quiesce_queue(q);
-	if (q->elevator) {
-		mutex_lock(&q->elevator_lock);
-		elevator_exit(q);
-		mutex_unlock(&q->elevator_lock);
-	}
 	rq_qos_exit(q);
-	blk_mq_unquiesce_queue(q);
 
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
-- 
2.47.0

