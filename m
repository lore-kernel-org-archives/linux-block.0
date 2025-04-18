Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA217462
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994302; cv=none; b=lwKYLm5XvDsmwWxdmqcDW6aIHrxR5H91B/6Pkx4m1E+e1Cg5vTmTjdeeMlU1GFgMzaROimAt4ruCkdU+884DMeOzmZfwintoqxC7RmL0THFaIjlrziDDaB82rApW1EborTn3r7Ced3eynIeHMV4h0WupeP/rYDXZF0s/OZX8c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994302; c=relaxed/simple;
	bh=l5iDY4vdG3/Wa1qbY8/v6ioEt/nxba7rJYqtEEy5Ib4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqJGt105AMnCra09SHp+bCGP/ZLWOaqI9ejAhKsTCeiK+1fgtbMbzZudCbenHioSktsJSB5KW2PxYf0tVrkqmhQBHu/ou0ijH0Bb8RGMbrwfPPWLqAWSexV6obVmHy+lOg+U7ndMRJPo8fDp7Ikoqg4Twg9Yv42UEIDJk7sZaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWEykqlu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWEykqlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbQZm7VSQJbTqnwa0krZSA8qprnhb3/LlpIvYBXnaUk=;
	b=WWEykqlu1gPYrsVRb21o+gxiHRJeW+Dl6MxNHmU3GSa9dLurflsM4ef6iPZqH7lvIzE1pZ
	EdYpsanvCsLTiUAySTbNp/84u/OanCq2swGBbsBzBzU43Uw2Zg/9HaqgckQUQoCgxAnN2M
	YvbKqZz1cFiVjVFQehsva4d4ygIWSWw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-MZjpWt8DOXyXkw3aoD43bg-1; Fri,
 18 Apr 2025 12:38:16 -0400
X-MC-Unique: MZjpWt8DOXyXkw3aoD43bg-1
X-Mimecast-MFC-AGG-ID: MZjpWt8DOXyXkw3aoD43bg_1744994295
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00FD219560BD;
	Fri, 18 Apr 2025 16:38:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5BD1954B0B;
	Fri, 18 Apr 2025 16:38:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 13/20] block: unifying elevator change
Date: Sat, 19 Apr 2025 00:36:54 +0800
Message-ID: <20250418163708.442085-14-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

elevator change is one well-define behavior:

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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 18 ++++-------
 block/blk.h       |  5 ++-
 block/elevator.c  | 81 ++++++++++++++++++++++++++---------------------
 block/elevator.h  |  1 +
 block/genhd.c     | 19 +----------
 5 files changed, 55 insertions(+), 69 deletions(-)

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
index be01cb9f3910..0e19c09009ed 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -321,9 +321,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 bool blk_insert_flush(struct request *rq);
 
 int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx);
-void elevator_exit(struct request_queue *q);
-int elv_register_queue(struct request_queue *q, bool uevent);
-void elv_unregister_queue(struct request_queue *q);
+void elevator_set_default(struct request_queue *q);
+void elevator_set_none(struct request_queue *q);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index 836138fc148a..936d8ec9e9f0 100644
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
@@ -485,7 +485,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-void elv_unregister_queue(struct request_queue *q)
+static void elv_unregister_queue(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
@@ -562,60 +562,59 @@ EXPORT_SYMBOL_GPL(elv_unregister);
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
+	struct elv_change_ctx ctx = {
+		.init = true,
+	};
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
+	struct elv_change_ctx ctx = {
+		.name	= "none",
+		.uevent = true,
+		.init = true,
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
@@ -688,7 +687,7 @@ int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	int ret;
 
 	/* Make sure queue is not in the middle of being removed */
-	if (!blk_queue_registered(q))
+	if (!ctx->init && !blk_queue_registered(q))
 		return -ENOENT;
 
 	if (!strncmp(elevator_name, "none", 4)) {
@@ -723,6 +722,16 @@ static int elevator_change(struct request_queue *q,
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
diff --git a/block/elevator.h b/block/elevator.h
index 63fc4cad16cc..e74e27dd6586 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -127,6 +127,7 @@ struct elv_change_ctx {
 	const char *name;
 	bool force;
 	bool uevent;
+	bool init;
 };
 
 /*
diff --git a/block/genhd.c b/block/genhd.c
index 86c3db5b9305..de227aa923ed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -438,12 +438,6 @@ static int __add_disk_fwnode(struct gendisk_data *data)
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
@@ -587,11 +581,7 @@ static int __add_disk_fwnode(struct gendisk_data *data)
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
 
@@ -771,14 +761,7 @@ static int __del_gendisk(struct gendisk_data *data)
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

