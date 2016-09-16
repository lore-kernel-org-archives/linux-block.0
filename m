Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34529 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934824AbcIPMZc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 08:25:32 -0400
Received: by mail-pa0-f65.google.com with SMTP id vz6so3449991pab.1
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 05:25:32 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 2/7] nvme: refactor namespaces to support non-gendisk devices
Date: Fri, 16 Sep 2016 14:25:04 +0200
Message-Id: <1474028709-30260-3-git-send-email-m@bjorling.me>
In-Reply-To: <1474028709-30260-1-git-send-email-m@bjorling.me>
References: <1474028709-30260-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

With LightNVM enabled namespaces, the gendisk structure is not exposed
to the user. This prevents LightNVM users from accessing the NVMe device
driver specific sysfs entries, and LightNVM namespace geometry.

Refactor the revalidation process, so that a namespace, instead of a
gendisk, is revalidated. This later allows patches to wire up the
sysfs entries up to a non-gendisk namespace.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c      |   2 +
 drivers/nvme/host/core.c     | 116 +++++++++++++++++++++++++++----------------
 drivers/nvme/host/lightnvm.c |   5 +-
 3 files changed, 79 insertions(+), 44 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9ebd2cf..25c5df9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -581,6 +581,8 @@ static int nvm_core_init(struct nvm_dev *dev)
 	mutex_init(&dev->mlock);
 	spin_lock_init(&dev->lock);
 
+	blk_queue_logical_block_size(dev->q, dev->sec_size);
+
 	return 0;
 err_fmtype:
 	kfree(dev->lun_map);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2feacc7..2c3da33 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -888,42 +888,33 @@ static void nvme_config_discard(struct nvme_ns *ns)
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
@@ -962,8 +953,26 @@ static int nvme_revalidate_disk(struct gendisk *disk)
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
 
@@ -1642,6 +1651,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
+	struct nvme_id_ns *id;
+	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev);
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
@@ -1659,33 +1670,54 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
 
-	disk->fops = &nvme_fops;
-	disk->private_data = ns;
-	disk->queue = ns->queue;
-	disk->flags = GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
-
-	if (nvme_revalidate_disk(ns->disk))
-		goto out_free_disk;
+	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
+
+	if (nvme_revalidate_ns(ns, &id))
+		goto out_free_queue;
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
+		disk->fops = &nvme_fops;
+		disk->private_data = ns;
+		disk->queue = ns->queue;
+		disk->flags = GENHD_FL_EXT_DEVT;
+		memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+		ns->disk = disk;
+
+		__nvme_revalidate_disk(disk, id);
+	}
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	mutex_unlock(&ctrl->namespaces_mutex);
 
 	kref_get(&ctrl->kref);
+
+	kfree(id);
+
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
 
@@ -1695,8 +1727,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		pr_warn("%s: failed to create sysfs group for identification\n",
 			ns->disk->disk_name);
 	return;
- out_free_disk:
-	kfree(disk);
+ out_free_id:
+	kfree(id);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_release_instance:
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 63f483d..7268a7a 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -474,8 +474,9 @@ static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
 	c->ph_rw.length = cpu_to_le16(rqd->nr_ppas - 1);
 
 	if (rqd->opcode == NVM_OP_HBWRITE || rqd->opcode == NVM_OP_HBREAD)
-		c->hb_rw.slba = cpu_to_le64(nvme_block_nr(ns,
-						rqd->bio->bi_iter.bi_sector));
+		/* momentarily hardcode the shift configuration. lba_shift from
+		 * nvm_dev will be available in a follow-up patch */
+		c->hb_rw.slba = cpu_to_le64(rqd->bio->bi_iter.bi_sector >> 3);
 }
 
 static void nvme_nvm_end_io(struct request *rq, int error)
-- 
2.1.4

