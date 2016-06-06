Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32857 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbcFFOqK (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2016 10:46:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id c74so8854278wme.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jun 2016 07:46:10 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 1/6] nvme: refactor namespaces to support non-gendisk devices
Date: Mon,  6 Jun 2016 16:45:58 +0200
Message-Id: <1465224363-25797-2-git-send-email-m@bjorling.me>
In-Reply-To: <1465224363-25797-1-git-send-email-m@bjorling.me>
References: <1465224363-25797-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

With LightNVM enabled namespaces, the gendisk structure is not exposed
to the user. This prevents LightNVM users from accessing the NVMe device
driver specific sysfs entries, and LightNVM namespace geometry.

Refactor the revalidation process, so that a namespace, instead of a
gendisk, is revalidated. This later allows patches to wire up the sysfs
entries up to a non-gendisk namespace.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/core.c | 134 +++++++++++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h |  16 +++++-
 2 files changed, 96 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..f488729 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -601,42 +601,33 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
 }
 
-static int nvme_revalidate_disk(struct gendisk *disk)
+static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 {
-	struct nvme_ns *ns = disk->private_data;
-	struct nvme_id_ns *id;
-	u8 lbaf, pi_type;
-	u16 old_ms;
-	unsigned short bs;
-
-	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
-		set_capacity(disk, 0);
-		return -ENODEV;
-	}
-	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
+	if (nvme_identify_ns(ns->ctrl, ns->ns_id, id)) {
 		dev_warn(disk_to_dev(ns->disk), "%s: Identify failure\n",
 				__func__);
 		return -ENODEV;
 	}
-	if (id->ncap == 0) {
-		kfree(id);
-		return -ENODEV;
-	}
 
-	if (nvme_nvm_ns_supported(ns, id) && ns->type != NVME_NS_LIGHTNVM) {
-		if (nvme_nvm_register(ns->queue, disk->disk_name)) {
-			dev_warn(disk_to_dev(ns->disk),
-				"%s: LightNVM init failure\n", __func__);
-			kfree(id);
-			return -ENODEV;
-		}
-		ns->type = NVME_NS_LIGHTNVM;
+	if ((*id)->ncap == 0) {
+		kfree(*id);
+		return -ENODEV;
 	}
 
 	if (ns->ctrl->vs >= NVME_VS(1, 1))
-		memcpy(ns->eui, id->eui64, sizeof(ns->eui));
+		memcpy(ns->eui, (*id)->eui64, sizeof(ns->eui));
 	if (ns->ctrl->vs >= NVME_VS(1, 2))
-		memcpy(ns->uuid, id->nguid, sizeof(ns->uuid));
+		memcpy(ns->uuid, (*id)->nguid, sizeof(ns->uuid));
+
+	return 0;
+}
+
+static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
+{
+	struct nvme_ns *ns = disk->private_data;
+	u8 lbaf, pi_type;
+	u16 old_ms;
+	unsigned short bs;
 
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
@@ -675,8 +666,26 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 	blk_mq_unfreeze_queue(disk->queue);
+}
 
+static int nvme_revalidate_disk(struct gendisk *disk)
+{
+	struct nvme_ns *ns = disk->private_data;
+	struct nvme_id_ns *id = NULL;
+	int ret;
+
+	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
+		set_capacity(disk, 0);
+		return -ENODEV;
+	}
+
+	ret = nvme_revalidate_ns(ns, &id);
+	if (ret)
+		return ret;
+
+	__nvme_revalidate_disk(disk, id);
 	kfree(id);
+
 	return 0;
 }
 
@@ -1228,6 +1237,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
+	struct nvme_id_ns *id;
+	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev);
 
 	lockdep_assert_held(&ctrl->namespaces_mutex);
@@ -1247,44 +1258,63 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
 
-	disk = alloc_disk_node(0, node);
-	if (!disk)
-		goto out_free_queue;
-
 	kref_init(&ns->kref);
 	ns->ns_id = nsid;
-	ns->disk = disk;
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
 
-
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 
-	disk->major = nvme_major;
-	disk->first_minor = 0;
-	disk->fops = &nvme_fops;
-	disk->private_data = ns;
-	disk->queue = ns->queue;
-	disk->driverfs_dev = ctrl->device;
-	disk->flags = GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
-
-	if (nvme_revalidate_disk(ns->disk))
-		goto out_free_disk;
+	if (nvme_revalidate_ns(ns, &id))
+		goto out_free_queue;
+
+	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
+
+	if (nvme_nvm_ns_supported(ns, id)) {
+		if (nvme_nvm_register(ns->queue, disk_name)) {
+			dev_warn(ctrl->dev,
+				"%s: LightNVM init failure\n", __func__);
+			goto out_free_id;
+		}
+
+		disk = alloc_disk_node(0, node);
+		if (!disk)
+			goto out_free_id;
+		memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+		ns->disk = disk;
+		ns->type = NVME_NS_LIGHTNVM;
+	} else {
+		disk = alloc_disk_node(0, node);
+		if (!disk)
+			goto out_free_id;
+
+		disk->major = nvme_major;
+		disk->first_minor = 0;
+		disk->fops = &nvme_fops;
+		disk->private_data = ns;
+		disk->queue = ns->queue;
+		disk->driverfs_dev = ctrl->device;
+		disk->flags = GENHD_FL_EXT_DEVT;
+		memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+		ns->disk = disk;
+
+		__nvme_revalidate_disk(disk, id);
+
+		add_disk(ns->disk);
+
+		if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
+							&nvme_ns_attr_group))
+			pr_warn("%s: failed to create sysfs group for identification\n",
+				ns->disk->disk_name);
+	}
 
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
-	if (ns->type == NVME_NS_LIGHTNVM)
-		return;
 
-	add_disk(ns->disk);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
+	kfree(id);
 	return;
- out_free_disk:
-	kfree(disk);
+ out_free_id:
+	kfree(id);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_release_instance:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f846da4..0d0c81d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -291,8 +291,16 @@ int nvme_sg_get_version_num(int __user *ip);
 
 #ifdef CONFIG_NVM
 int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id);
-int nvme_nvm_register(struct request_queue *q, char *disk_name);
-void nvme_nvm_unregister(struct request_queue *q, char *disk_name);
+int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
+void nvme_nvm_unregister(struct nvme_ns *ns);
+
+static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
+{
+	if (dev->type->devnode)
+		return dev_to_disk(dev)->private_data;
+
+	return (container_of(dev, struct nvm_dev, dev))->private_data;
+}
 #else
 static inline int nvme_nvm_register(struct request_queue *q, char *disk_name)
 {
@@ -305,6 +313,10 @@ static inline int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *i
 {
 	return 0;
 }
+static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
+{
+	return dev_to_disk(dev)->private_data;
+}
 #endif /* CONFIG_NVM */
 
 int __init nvme_core_init(void);
-- 
2.1.4

