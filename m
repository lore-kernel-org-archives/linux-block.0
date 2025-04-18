Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3E208A7
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994278; cv=none; b=qnp243ENZjhLZwo7TTUKwpF88IKmv6T/kS7qb4PAhMlIrXEUorKGy8Cs/7uOnvIDuHtdlADruo1cClg9PVBOVCGAjy8rH+Ca2xcgJsbvw308M/wcXArWXiv21/LDXdkerBFcht1nsWQxS/9lU1L3dqIvWG2U9OXNhZgOwkMVuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994278; c=relaxed/simple;
	bh=lSVEvALNSLKI3ZAiS7XJzcwM2mn1yvCus3Ne7vwRfMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srruRph6hHjaqCSE7j3MRT9xTQ7FGByR2c8Gn0SbHJ+/ho7lQm2rHHCmDO/XQibuJfy+kW8r8b2XUNstemded1MYw1aRDKDAdFdUwRDjnyzxLNlOLk80yQOUFWi7D7rj96bEy+rSGpnRvp6C56CGQIAPTrabSOIluBkYCub+k3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKUjGKcN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKUjGKcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuGjHwRqAOnTVi/MB2ZbCXB1MH3VBU/S7SnAnHKEq44=;
	b=JKUjGKcNYf98yUFCBtGqKQgEh/u6iPj1ws9Q6BZ7imURh7UitE1XCywqZXQCHIefBjZ/ta
	qeSsglMQhpBcwG7bDv/0j0Ez+DrOYoLfsQOg6/c15ChCFbSaHtCS6t0bFWcOY8TnFtePse
	oSs03aG6NFH18K9t32w4Js66QVRyFzE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-LaaQyoQWM2GKeRmqhwmqxA-1; Fri,
 18 Apr 2025 12:37:52 -0400
X-MC-Unique: LaaQyoQWM2GKeRmqhwmqxA-1
X-Mimecast-MFC-AGG-ID: LaaQyoQWM2GKeRmqhwmqxA_1744994271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33BEE180048E;
	Fri, 18 Apr 2025 16:37:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F23B19560A3;
	Fri, 18 Apr 2025 16:37:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 07/20] block: prevent adding/deleting disk during updating nr_hw_queues
Date: Sat, 19 Apr 2025 00:36:48 +0800
Message-ID: <20250418163708.442085-8-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Both adding/deleting disk code are reader of `nr_hw_queues`, so we can't
allow them in-progress when updating nr_hw_queues, kernel panic and
kasan has been reported in [1].

Prevent adding/deleting disk during updating nr_hw_queues by setting
set->updating_nr_hwq, and use SRCU to fail & retry to add/delete disk.

This way avoids lot of trouble.

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-block/a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 22 +++++++++++++++++++++-
 block/genhd.c          | 36 ++++++++++++++++++++++++++++++++----
 include/linux/blk-mq.h |  5 +++++
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7cda919fafba..e1662617cc7a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4782,12 +4782,18 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_srcu;
 	}
 
+	mutex_init(&set->update_nr_hwq_lock);
+	init_waitqueue_head(&set->update_nr_hwq_wq);
+	ret = init_srcu_struct(&set->update_nr_hwq_srcu);
+	if (ret)
+		goto out_cleanup_srcu;
+
 	ret = -ENOMEM;
 	set->tags = kcalloc_node(set->nr_hw_queues,
 				 sizeof(struct blk_mq_tags *), GFP_KERNEL,
 				 set->numa_node);
 	if (!set->tags)
-		goto out_cleanup_srcu;
+		goto out_cleanup_hwq_srcu;
 
 	for (i = 0; i < set->nr_maps; i++) {
 		set->map[i].mq_map = kcalloc_node(nr_cpu_ids,
@@ -4816,6 +4822,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	}
 	kfree(set->tags);
 	set->tags = NULL;
+out_cleanup_hwq_srcu:
+	cleanup_srcu_struct(&set->update_nr_hwq_srcu);
 out_cleanup_srcu:
 	if (set->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(set->srcu);
@@ -5077,9 +5085,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
+	mutex_lock(&set->update_nr_hwq_lock);
+	/*
+	 * Mark us in updating nr_hw_queues for preventing reader of
+	 * nr_hw_queues, such as adding/deleting disk.
+	 */
+	set->updating_nr_hwq = true;
+	synchronize_srcu(&set->update_nr_hwq_srcu);
+
 	mutex_lock(&set->tag_list_lock);
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
 	mutex_unlock(&set->tag_list_lock);
+
+	set->updating_nr_hwq = false;
+	wake_up_all(&set->update_nr_hwq_wq);
+	mutex_unlock(&set->update_nr_hwq_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
diff --git a/block/genhd.c b/block/genhd.c
index 4370c5be1f34..d22fdc0d5383 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -396,6 +396,33 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	return ret;
 }
 
+static int retry_on_updating_nr_hwq(struct gendisk_data *data,
+				    int (*cb)(struct gendisk_data *data))
+{
+	struct gendisk *disk = data->disk;
+	struct blk_mq_tag_set *set;
+
+	if (!queue_is_mq(disk->queue))
+		return cb(data);
+
+	set = disk->queue->tag_set;
+	do {
+		int idx, ret;
+
+		idx = srcu_read_lock(&set->update_nr_hwq_srcu);
+		if (set->updating_nr_hwq) {
+			srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
+			goto wait;
+		}
+		ret = cb(data);
+		srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
+		return ret;
+ wait:
+		wait_event_interruptible(set->update_nr_hwq_wq,
+				!set->updating_nr_hwq);
+	} while (true);
+}
+
 static int __add_disk_fwnode(struct gendisk_data *data)
 {
 	struct gendisk *disk = data->disk;
@@ -589,7 +616,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 		.fwnode = fwnode,
 	};
 
-	return __add_disk_fwnode(&data);
+	return retry_on_updating_nr_hwq(&data, __add_disk_fwnode);
 }
 EXPORT_SYMBOL_GPL(add_disk_fwnode);
 
@@ -671,7 +698,7 @@ void blk_mark_disk_dead(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
-static void __del_gendisk(struct gendisk_data *data)
+static int __del_gendisk(struct gendisk_data *data)
 {
 	struct gendisk *disk = data->disk;
 	struct request_queue *q = disk->queue;
@@ -682,7 +709,7 @@ static void __del_gendisk(struct gendisk_data *data)
 	might_sleep();
 
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
-		return;
+		return 0;
 
 	disk_del_events(disk);
 
@@ -764,6 +791,7 @@ static void __del_gendisk(struct gendisk_data *data)
 
 	if (start_drain)
 		blk_unfreeze_release_lock(q);
+	return 0;
 }
 EXPORT_SYMBOL(del_gendisk);
 
@@ -792,7 +820,7 @@ void del_gendisk(struct gendisk *disk)
 		.disk	= disk,
 	};
 
-	__del_gendisk(&data);
+	retry_on_updating_nr_hwq(&data, __del_gendisk);
 }
 
 /**
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8eb9b3310167..afe76dcfaa3c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -527,6 +527,11 @@ struct blk_mq_tag_set {
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
 	struct srcu_struct	*srcu;
+
+	bool			updating_nr_hwq;
+	struct mutex		update_nr_hwq_lock;
+	struct srcu_struct	update_nr_hwq_srcu;
+	wait_queue_head_t	update_nr_hwq_wq;
 };
 
 /**
-- 
2.47.0

