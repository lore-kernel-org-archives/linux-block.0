Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D21D5CC4
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508152; cv=none; b=EQgQzAGVhkHcl3LzlV/PLWDZ1IQ7O0sxykjzl4ZwzSlJNF9dmr9rn46PB2MumytvdaJ5kkuA0X4ETD9z6tQTeiXr9gYdUIjB/MRWdVThh/7Z1pDDPfUcsxsIjLe3k9A2JHTCnHJJrrZb1T3OMenBin0Iqd5j7fDGe4C9X73TsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508152; c=relaxed/simple;
	bh=BV4QMJRG5usj4c5JfdS3jHBtdM+P4932cGmpygotk/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgqLCXdl8qGIG83s5SB8gj6aTiOf5dN0/heQEi2XXJO8H2XVTbkomA7WnpHJJ3vTXMBT5RSN4EE/ow9V+uEEEQMF2b8L6+znzyEkZbq/llBFzJF5y5dG1G155YLP1Ov+7CXQdx6OqzQ4ZbZrMPZqfBVfeMjBoNaAz1VocXVcGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMwfEtCc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMwfEtCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VUUo1lhZ72I7d7KU36WoSjvS6CFeFhiUDeqcdtGzHQ=;
	b=QMwfEtCc0inahUdfOkj21eC4m1YdvHrl8gFMQPeZcAaVCR2J4H5ilY1iUx+sCOMQr0M4p7
	u9NGQeKWx/VHxcbljRc7CBNTEdqWFArlAg12bYBdMR7l2FbXgtNVU9bfG6KlgFpWzkyW2G
	cQu1hCz8J6Aw1FPAKyj6cxk0dppHfqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-757cxl-4PU-uusASUjaGXw-1; Thu,
 24 Apr 2025 11:22:24 -0400
X-MC-Unique: 757cxl-4PU-uusASUjaGXw-1
X-Mimecast-MFC-AGG-ID: 757cxl-4PU-uusASUjaGXw_1745508143
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D26A180087C;
	Thu, 24 Apr 2025 15:22:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B2CA30001A2;
	Thu, 24 Apr 2025 15:22:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 07/20] block: prevent adding/deleting disk during updating nr_hw_queues
Date: Thu, 24 Apr 2025 23:21:30 +0800
Message-ID: <20250424152148.1066220-8-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Both adding/deleting disk code are reader of `nr_hw_queues`, so we can't
allow them in-progress when updating nr_hw_queues, kernel panic and
kasan has been reported in [1].

Prevent adding/deleting disk during updating nr_hw_queues by adding
rw_semaphore to tagset, write lock is grabbed in blk_mq_update_nr_hw_queues(),
and read lock is acquired when adding/deleting disk.

Also mark GFP_NOIO allocation scope for adding/deleting disk because
blk_mq_update_nr_hw_queues() is part of some driver's error handler.

This way avoids lot of trouble.

Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-block/a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         |  4 ++
 block/genhd.c          | 94 +++++++++++++++++++++++++++++++-----------
 include/linux/blk-mq.h |  3 ++
 3 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29cfc7ce2e0a..1ed2d183f912 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4802,6 +4802,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_srcu;
 	}
 
+	init_rwsem(&set->update_nr_hwq_sema);
+
 	ret = -ENOMEM;
 	set->tags = kcalloc_node(set->nr_hw_queues,
 				 sizeof(struct blk_mq_tags *), GFP_KERNEL,
@@ -5097,9 +5099,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
+	down_write(&set->update_nr_hwq_sema);
 	mutex_lock(&set->tag_list_lock);
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
 	mutex_unlock(&set->tag_list_lock);
+	up_write(&set->update_nr_hwq_sema);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
diff --git a/block/genhd.c b/block/genhd.c
index c2bd86cd09de..7f3ae3d23b26 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -399,9 +399,9 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
  * This function registers the partitioning information in @disk
  * with the kernel. Also attach a fwnode to the disk device.
  */
-int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups,
-				 struct fwnode_handle *fwnode)
+static int __add_disk_fwnode(struct device *parent, struct gendisk *disk,
+			     const struct attribute_group **groups,
+			     struct fwnode_handle *fwnode)
 
 {
 	struct device *ddev = disk_to_dev(disk);
@@ -572,6 +572,37 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 	}
 	return ret;
 }
+
+/**
+ * add_disk_fwnode - add disk information to kernel list with fwnode
+ * @parent: parent device for the disk
+ * @disk: per-device partitioning information
+ * @groups: Additional per-device sysfs groups
+ * @fwnode: attached disk fwnode
+ *
+ * This function registers the partitioning information in @disk
+ * with the kernel. Also attach a fwnode to the disk device.
+ */
+int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups,
+				 struct fwnode_handle *fwnode)
+{
+	struct blk_mq_tag_set *set;
+	unsigned int memflags;
+	int ret;
+
+	if (!queue_is_mq(disk->queue))
+		return __add_disk_fwnode(parent, disk, groups, fwnode);
+
+	set = disk->queue->tag_set;
+	memflags = memalloc_noio_save();
+	down_read(&set->update_nr_hwq_sema);
+	ret = __add_disk_fwnode(parent, disk, groups, fwnode);
+	up_read(&set->update_nr_hwq_sema);
+	memalloc_noio_restore(memflags);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(add_disk_fwnode);
 
 /**
@@ -652,26 +683,7 @@ void blk_mark_disk_dead(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
-/**
- * del_gendisk - remove the gendisk
- * @disk: the struct gendisk to remove
- *
- * Removes the gendisk and all its associated resources. This deletes the
- * partitions associated with the gendisk, and unregisters the associated
- * request_queue.
- *
- * This is the counter to the respective __device_add_disk() call.
- *
- * The final removal of the struct gendisk happens when its refcount reaches 0
- * with put_disk(), which should be called after del_gendisk(), if
- * __device_add_disk() was used.
- *
- * Drivers exist which depend on the release of the gendisk to be synchronous,
- * it should not be deferred.
- *
- * Context: can sleep
- */
-void del_gendisk(struct gendisk *disk)
+static void __del_gendisk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct block_device *part;
@@ -764,6 +776,42 @@ void del_gendisk(struct gendisk *disk)
 	if (start_drain)
 		blk_unfreeze_release_lock(q);
 }
+
+/**
+ * del_gendisk - remove the gendisk
+ * @disk: the struct gendisk to remove
+ *
+ * Removes the gendisk and all its associated resources. This deletes the
+ * partitions associated with the gendisk, and unregisters the associated
+ * request_queue.
+ *
+ * This is the counter to the respective __device_add_disk() call.
+ *
+ * The final removal of the struct gendisk happens when its refcount reaches 0
+ * with put_disk(), which should be called after del_gendisk(), if
+ * __device_add_disk() was used.
+ *
+ * Drivers exist which depend on the release of the gendisk to be synchronous,
+ * it should not be deferred.
+ *
+ * Context: can sleep
+ */
+void del_gendisk(struct gendisk *disk)
+{
+	struct blk_mq_tag_set *set;
+	unsigned int memflags;
+
+	if (!queue_is_mq(disk->queue)) {
+		__del_gendisk(disk);
+	} else {
+		set = disk->queue->tag_set;
+		memflags = memalloc_noio_save();
+		down_read(&set->update_nr_hwq_sema);
+		__del_gendisk(disk);
+		up_read(&set->update_nr_hwq_sema);
+		memalloc_noio_restore(memflags);
+	}
+}
 EXPORT_SYMBOL(del_gendisk);
 
 /**
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8eb9b3310167..28bc03b2b0dc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -9,6 +9,7 @@
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
 #include <linux/rw_hint.h>
+#include <linux/rwsem.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -527,6 +528,8 @@ struct blk_mq_tag_set {
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
 	struct srcu_struct	*srcu;
+
+	struct rw_semaphore	update_nr_hwq_sema;
 };
 
 /**
-- 
2.47.0

