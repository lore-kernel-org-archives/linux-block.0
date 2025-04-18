Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8959208A7
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994275; cv=none; b=uFCoDI2ot8UTRnkJhgqyKicyTUkdphkA9AucEaTakosL0qp9uDLNH1WYipsP+grnP1SPBlx8l0u4pdNTnRxcPrQkqr2VsF4FYXq45EV55uzZXq+M6K4b895K3lStDS51v5tl6HJwWAoSfz+JIvqGu+YP0+RC8CLkq4KWRnetZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994275; c=relaxed/simple;
	bh=b/MSZZsD+HCnboRalqnYxzjKQ8CYWeV0BzzDNKGiOdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8zqZlYWI3O6wnlt6esl0Lv+hsIpigTnAJ9u0sdoC7swCnf1vcmhMhbVEAB6iOlX3o/iq8tl+MKWlFkAdaqMA/2y5TU6iPas0sGrsXnECo69TEiWg5ohwR+X0NQTC50qFrkxgNsyswZ/vmOBPw35nPiqD5+8n8WcWHAuyUgvQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=He6TsD+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He6TsD+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76SV8HuxVR187jaN0G5ISTMO24o9l6sktx4O1GP+5hs=;
	b=He6TsD+2kCIwsL6mWtHAHcg8YwGVhs3+fHB4xgQVJYwbBK4anZmtAAI2oXp71yeFpUmP+p
	SSbaq3mm2sdDa7yPHXxp+5NSB6EjhefbkKo71JNDP/ka0Gd+48yliMPQvQ1uzGBElrDKm8
	CFA7zf9ZA5JDagn8Blch2ojhudYlaVY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-mo8bE56hOjms3fup_aGOnQ-1; Fri,
 18 Apr 2025 12:37:48 -0400
X-MC-Unique: mo8bE56hOjms3fup_aGOnQ-1
X-Mimecast-MFC-AGG-ID: mo8bE56hOjms3fup_aGOnQ_1744994267
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F2011800263;
	Fri, 18 Apr 2025 16:37:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE6A819560A3;
	Fri, 18 Apr 2025 16:37:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 06/20] block: add & pass 'struct gendisk_data' for retrying add/del disk in updating nr_hw_queues
Date: Sat, 19 Apr 2025 00:36:47 +0800
Message-ID: <20250418163708.442085-7-ming.lei@redhat.com>
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

Add/del gendisk code is actually reader of 'nr_hw_queues' in case of blk-mq:

- debugfs / hctx sysfs register

- setup scheduler since ->sched_tags depends on hctx, which relies on
'nr_hw_queues'

Add & pass 'struct gendisk_data' to add/del disk helper and prepare for
retrying add/del disk when updating nr_hw_queues is in-progress.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 105 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 38 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c2bd86cd09de..4370c5be1f34 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -33,6 +33,13 @@
 #include "blk-rq-qos.h"
 #include "blk-cgroup.h"
 
+struct gendisk_data {
+	struct gendisk *disk;
+	struct device *parent;
+	const struct attribute_group **groups;
+	struct fwnode_handle *fwnode;
+};
+
 static struct kobject *block_depr;
 
 /*
@@ -389,21 +396,9 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
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
-
+static int __add_disk_fwnode(struct gendisk_data *data)
 {
+	struct gendisk *disk = data->disk;
 	struct device *ddev = disk_to_dev(disk);
 	int ret;
 
@@ -463,11 +458,11 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
 
-	ddev->parent = parent;
-	ddev->groups = groups;
+	ddev->parent = data->parent;
+	ddev->groups = data->groups;
 	dev_set_name(ddev, "%s", disk->disk_name);
-	if (fwnode)
-		device_set_node(ddev, fwnode);
+	if (data->fwnode)
+		device_set_node(ddev, data->fwnode);
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
@@ -572,6 +567,30 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
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
+	struct gendisk_data data = {
+		.disk	= disk,
+		.parent	= parent,
+		.groups	= groups,
+		.fwnode = fwnode,
+	};
+
+	return __add_disk_fwnode(&data);
+}
 EXPORT_SYMBOL_GPL(add_disk_fwnode);
 
 /**
@@ -652,27 +671,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
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
+static void __del_gendisk(struct gendisk_data *data)
 {
+	struct gendisk *disk = data->disk;
 	struct request_queue *q = disk->queue;
 	struct block_device *part;
 	unsigned long idx;
@@ -766,6 +767,34 @@ void del_gendisk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(del_gendisk);
 
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
+	struct gendisk_data data = {
+		.disk	= disk,
+	};
+
+	__del_gendisk(&data);
+}
+
 /**
  * invalidate_disk - invalidate the disk
  * @disk: the struct gendisk to invalidate
-- 
2.47.0

