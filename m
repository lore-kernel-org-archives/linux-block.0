Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E568633A
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291900; cv=none; b=JrYa3yw0havGz85qqPmyFliyNRaMT0cKoE8cCsFsfE2AA1Vw9H33bVRRH7SDwqLurbXhbx3Ubmf7Yj7RewDz1LRMghmVPQWIQhluAyt9cZpC7PZ7F15UGtVU1PZ42u8mx1svSoOEcQmnMKGWJWNF4xL7jnCZXFPQF+zVOh9jjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291900; c=relaxed/simple;
	bh=vdEJFDcxGrpnjUG1It7djsmMU2zQFFKmKunGB0vqonA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu+Wg45/DM6qRyezW1YSeVUdnbvZJYLZGHd7x12yKfWYxRGkn3nwnTTiVLSVvM7ecslcS5jTau5cIovJW0P+qYF6XR3clbRDMLz4TClvPC+hK/lObb8ih5Y4Oick7h+4WwBu1bFsRn9sz9G1KD05fWago2j2LYO3wDwDklmCaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9ffmJ2T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9ffmJ2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVjMXIjSo8E5kVtN6suOJX1JQdUEtPaI6atDmbgJDok=;
	b=g9ffmJ2TZPVZBRNT8FHalkw2BOzZYP91tdH92qyPliazQd4Umrxxe8SVcIlwV9VhCPK3ZD
	NPzyabOrXT2hpnQpjBJ7yT9WCaEbhpiX0JHTKYg5nzCSqA30kc+9Ilz3aH1twF/6A3Cj0s
	yJcbqgr909m2QwYv3OUHl2FF1AFhstM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-GT2IqPFgMh-THUyXfd8zvg-1; Thu,
 10 Apr 2025 09:31:34 -0400
X-MC-Unique: GT2IqPFgMh-THUyXfd8zvg-1
X-Mimecast-MFC-AGG-ID: GT2IqPFgMh-THUyXfd8zvg_1744291892
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAB5319560B0;
	Thu, 10 Apr 2025 13:31:32 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63B1D180174E;
	Thu, 10 Apr 2025 13:31:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 09/15] block: unifying elevator change
Date: Thu, 10 Apr 2025 21:30:21 +0800
Message-ID: <20250410133029.2487054-10-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

elevator change is one well-define behavior:

- tear down current elevator if it exists

- setup new elevator

It is supposed to cover any case for changing elevator, typically the
following cases:

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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 18 ++++-------
 block/blk.h       |  5 ++--
 block/elevator.c  | 76 +++++++++++++++++++++++++----------------------
 block/genhd.c     | 19 +-----------
 4 files changed, 50 insertions(+), 68 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a2882751f0d2..58c50709bc14 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -869,14 +869,8 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		goto out_unregister_ia_ranges;
 
+	elevator_set_default(q);
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
 
@@ -902,8 +896,6 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 
-out_crypto_sysfs_unregister:
-	blk_crypto_sysfs_unregister(disk);
 out_unregister_ia_ranges:
 	disk_unregister_independent_access_ranges(disk);
 out_debugfs_remove:
@@ -949,9 +941,11 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	mutex_lock(&q->elevator_lock);
-	elv_unregister_queue(q);
-	mutex_unlock(&q->elevator_lock);
+	if (q->elevator) {
+		blk_mq_quiesce_queue(q);
+		elevator_set_none(q);
+		blk_mq_unquiesce_queue(q);
+	}
 
 	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
diff --git a/block/blk.h b/block/blk.h
index 922a429b5363..4626beedfdce 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -321,9 +321,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 bool blk_insert_flush(struct request *rq);
 
 int __elevator_change(struct request_queue *q, struct elev_change_ctx *ctx);
-void elevator_exit(struct request_queue *q);
-int elv_register_queue(struct request_queue *q, bool uevent);
-void elv_unregister_queue(struct request_queue *q);
+void elevator_set_default(struct request_queue *q);
+void elevator_set_none(struct request_queue *q);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index 2bc1679dcd1f..7d2a56ef0be6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -151,7 +151,7 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-void elevator_exit(struct request_queue *q)
+static void elevator_exit(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -455,7 +455,7 @@ static const struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-int elv_register_queue(struct request_queue *q, bool uevent)
+static int elv_register_queue(struct request_queue *q, bool uevent)
 {
 	struct elevator_queue *e = q->elevator;
 	int error;
@@ -484,7 +484,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-void elv_unregister_queue(struct request_queue *q)
+static void elv_unregister_queue(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -560,60 +560,56 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  * For single queue devices, default to using mq-deadline. If we have multiple
  * queues or mq-deadline is not available, default to "none".
  */
-static struct elevator_type *elevator_get_default(struct request_queue *q)
+static bool use_default_elevator(struct request_queue *q)
 {
 	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
-		return NULL;
+		return false;
 
 	if (q->nr_hw_queues != 1 &&
 	    !blk_mq_is_shared_tags(q->tag_set->flags))
-		return NULL;
+		return false;
 
-	return elevator_find_get("mq-deadline");
+	return true;
 }
 
 /*
  * Use the default elevator settings. If the chosen elevator initialization
  * fails, fall back to the "none" elevator (no elevator).
  */
-void elevator_init_mq(struct request_queue *q)
+void elevator_set_default(struct request_queue *q)
 {
-	struct elevator_type *e;
-	unsigned int memflags;
+	struct elev_change_ctx ctx = { };
 	int err;
 
-	WARN_ON_ONCE(blk_queue_registered(q));
-
-	if (unlikely(q->elevator))
+	if (!queue_is_mq(q))
 		return;
 
-	e = elevator_get_default(q);
-	if (!e)
+	ctx.name = use_default_elevator(q) ? "mq-deadline" : "none";
+	if (!q->elevator && !strcmp(ctx.name, "none"))
 		return;
+	err = elevator_change(q, &ctx);
+	if (err < 0)
+		pr_warn("\"%s\" set elevator failed %d, "
+			"falling back to \"none\"\n", ctx.name, err);
+}
 
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
+void elevator_set_none(struct request_queue *q)
+{
+	struct elev_change_ctx ctx = {
+		.name	= "none",
+		.uevent = 1,
+	};
+	int err;
 
-	blk_mq_unfreeze_queue(q, memflags);
+	if (!queue_is_mq(q))
+		return;
 
-	if (err) {
-		pr_warn("\"%s\" elevator initialization failed, "
-			"falling back to \"none\"\n", e->elevator_name);
-	}
+	if (!q->elevator)
+		return;
 
-	elevator_put(e);
+	err = elevator_change(q, &ctx);
+	if (err < 0)
+		pr_warn("%s: set none elevator failed %d\n", __func__, err);
 }
 
 /*
@@ -718,6 +714,16 @@ static int elevator_change(struct request_queue *q,
 	}
 
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
 	ret = __elevator_change(q, ctx);
 	mutex_unlock(&q->elevator_lock);
diff --git a/block/genhd.c b/block/genhd.c
index f426c13edf55..d7264546a178 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -416,12 +416,6 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
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
@@ -565,11 +559,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
 out_exit_elevator:
-	if (disk->queue->elevator) {
-		mutex_lock(&disk->queue->elevator_lock);
-		elevator_exit(disk->queue);
-		mutex_unlock(&disk->queue->elevator_lock);
-	}
+	elevator_set_none(disk->queue);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(add_disk_fwnode);
@@ -743,14 +733,7 @@ void del_gendisk(struct gendisk *disk)
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

