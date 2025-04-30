Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929E1DACB1
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987771; cv=none; b=A2krK/D+2b3Zdo+2eMC6yzYM1/a7Q1WUCr75Wmy67Z5braffZEJOwv6m3rvDqU0acH7UtVfYtcCNnI6lzup49qdHYNdJeOt1YKnjGjJdHttnz0qN5jGJahDfVyKoYLreATR0W1iXSabA85pDd51qEe47qRGWflPd0Hc+9vt09V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987771; c=relaxed/simple;
	bh=8/T3fsRFfz8WcAjHXqWdqFFzTHY1sQa00VVvvgDU0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHhgHNLmaVz8QqiHxEtHFsd2dztZlhUlpGvc4YO+7hHD6m0B8PUtQPNFtk/9GDoUpkgPOys4SNVB68hiUHcRJ8tJ9CXe+iByPXO4lBzZi0L1UUiuQmie9fcPhwH8jUfIP2XNG6pq4boCDKj32rhJmlcHObJd8fGjlZsghvvdSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVbXMxS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVbXMxS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zmlmp60GPfqdAwfKgwoVfkVf4xNsEU2fUKb+WpoCLNo=;
	b=WVbXMxS/I/tgst8jHYXUM2nWxaBhnDsc+9CxPekE9hju+3I6Ei99Nc93M/BmM8Kg+s5i8b
	TYF3XdhiL9gGRLdPpnLmksLN2ytzZEHDVDenlHC4R/QzIQ+I1qFRO+mSQvs/ujbZOk9ogj
	jJmx48Cw6GHKvx6OED2WU3UqdG7WLx0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-Ucj4kZxFPea80yeWPciggA-1; Wed,
 30 Apr 2025 00:36:06 -0400
X-MC-Unique: Ucj4kZxFPea80yeWPciggA-1
X-Mimecast-MFC-AGG-ID: Ucj4kZxFPea80yeWPciggA_1745987765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE7461956096;
	Wed, 30 Apr 2025 04:36:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCFE118001D5;
	Wed, 30 Apr 2025 04:36:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 07/24] block: prevent adding/deleting disk during updating nr_hw_queues
Date: Wed, 30 Apr 2025 12:35:09 +0800
Message-ID: <20250430043529.1950194-8-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Both adding/deleting disk code are reader of `nr_hw_queues`, so we can't
allow them in-progress when updating nr_hw_queues, kernel panic and
kasan has been reported in [1].

Prevent adding/deleting disk during updating nr_hw_queues by adding
rw_semaphore to tagset, write lock is grabbed in blk_mq_update_nr_hw_queues(),
and read lock is acquired when adding/deleting disk.

Also mark GFP_NOIO allocation scope for adding/deleting disk because
blk_mq_update_nr_hw_queues() is part of some driver's error handler.

This way avoids lot of trouble.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-block/a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         |   4 ++
 block/genhd.c          | 104 ++++++++++++++++++++++++++++-------------
 include/linux/blk-mq.h |   3 ++
 3 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29cfc7ce2e0a..3706c0dde2fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4802,6 +4802,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_srcu;
 	}
 
+	init_rwsem(&set->update_nr_hwq_lock);
+
 	ret = -ENOMEM;
 	set->tags = kcalloc_node(set->nr_hw_queues,
 				 sizeof(struct blk_mq_tags *), GFP_KERNEL,
@@ -5097,9 +5099,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
+	down_write(&set->update_nr_hwq_lock);
 	mutex_lock(&set->tag_list_lock);
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
 	mutex_unlock(&set->tag_list_lock);
+	up_write(&set->update_nr_hwq_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
diff --git a/block/genhd.c b/block/genhd.c
index c2bd86cd09de..340fb4555963 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -389,19 +389,9 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	return ret;
 }
 
-/**
- * add_disk_fwnode - add disk information to kernel list with fwnode
- * @parent: parent device for the disk
- * @disk: per-device partitioning information
- * @groups: Additional per-device sysfs groups
- * @fwnode: attached disk fwnode
- *
- * This function registers the partitioning information in @disk
- * with the kernel. Also attach a fwnode to the disk device.
- */
-int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups,
-				 struct fwnode_handle *fwnode)
+static int __add_disk(struct device *parent, struct gendisk *disk,
+		      const struct attribute_group **groups,
+		      struct fwnode_handle *fwnode)
 
 {
 	struct device *ddev = disk_to_dev(disk);
@@ -572,6 +562,37 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
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
+		return __add_disk(parent, disk, groups, fwnode);
+
+	set = disk->queue->tag_set;
+	memflags = memalloc_noio_save();
+	down_read(&set->update_nr_hwq_lock);
+	ret = __add_disk(parent, disk, groups, fwnode);
+	up_read(&set->update_nr_hwq_lock);
+	memalloc_noio_restore(memflags);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(add_disk_fwnode);
 
 /**
@@ -652,26 +673,7 @@ void blk_mark_disk_dead(struct gendisk *disk)
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
@@ -764,6 +766,42 @@ void del_gendisk(struct gendisk *disk)
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
+		down_read(&set->update_nr_hwq_lock);
+		__del_gendisk(disk);
+		up_read(&set->update_nr_hwq_lock);
+		memalloc_noio_restore(memflags);
+	}
+}
 EXPORT_SYMBOL(del_gendisk);
 
 /**
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8eb9b3310167..ef84d53095a6 100644
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
+	struct rw_semaphore	update_nr_hwq_lock;
 };
 
 /**
-- 
2.47.0

