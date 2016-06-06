Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32882 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbcFFOqM (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2016 10:46:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id c74so8854603wme.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jun 2016 07:46:12 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 4/6] lightnvm: let drivers control the lifetime of nvm_dev
Date: Mon,  6 Jun 2016 16:46:01 +0200
Message-Id: <1465224363-25797-5-git-send-email-m@bjorling.me>
In-Reply-To: <1465224363-25797-1-git-send-email-m@bjorling.me>
References: <1465224363-25797-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

LightNVM does not currently expose the device driver sysfs specific
entries to user-space, as the device driver skips the initialization of
gendisk.

To enable a device driver sysfs entries to be exposed, we need a struct
device to attach it to. To allow both the device driver and LightNVM to
access the same struct device, we need the device driver to track the
lifetime of the nvm_dev structure.

This patch refactors the two users of LightNVM (NVMe and null_blk),
enables them to allocate and free nvm_dev, and at last removes gendisk
usage when a LightNVM device is used.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/block/null_blk.c     | 22 ++++++++++++++++++++--
 drivers/lightnvm/core.c      | 34 +++++++---------------------------
 drivers/nvme/host/core.c     | 34 ++++++++++++++--------------------
 drivers/nvme/host/lightnvm.c | 21 +++++++++++++++++----
 drivers/nvme/host/nvme.h     |  8 +++++---
 include/linux/lightnvm.h     | 15 +++++++++------
 6 files changed, 72 insertions(+), 62 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 1ffbf4d..55b52d8 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -34,6 +34,7 @@ struct nullb {
 	unsigned int index;
 	struct request_queue *q;
 	struct gendisk *disk;
+	struct nvm_dev *ndev;
 	struct blk_mq_tag_set tag_set;
 	struct hrtimer timer;
 	unsigned int queue_depth;
@@ -550,12 +551,29 @@ static struct nvm_dev_ops null_lnvm_dev_ops = {
 
 static int null_nvm_register(struct nullb *nullb)
 {
-	return nvm_register(nullb->q, nullb->disk_name, &null_lnvm_dev_ops);
+	struct nvm_dev *dev;
+	int rv;
+
+	dev = nvm_alloc_dev(0);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->q = nullb->q;
+	memcpy(dev->name, disk_name, DISK_NAME_LEN);
+	dev->ops = &null_lnvm_dev_ops;
+
+	rv = nvm_register(dev);
+	if (rv) {
+		kfree(dev);
+		return rv;
+	}
+	nullb->ndev = dev;
+	return 0;
 }
 
 static void null_nvm_unregister(struct nullb *nullb)
 {
-	nvm_unregister(nullb->disk_name);
+	nvm_unregister(nullb->ndev);
 }
 #else
 static int null_nvm_register(struct nullb *nullb)
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8a5c2b2..5736c59 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -655,23 +655,15 @@ static void nvm_exit(struct nvm_dev *dev)
 	pr_info("nvm: successfully unloaded\n");
 }
 
-int nvm_register(struct request_queue *q, char *disk_name,
-							struct nvm_dev_ops *ops)
+struct nvm_dev *nvm_alloc_dev(int node)
+{
+	return kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
+}
+
+int nvm_register(struct nvm_dev *dev)
 {
-	struct nvm_dev *dev;
 	int ret;
 
-	if (!ops->identity)
-		return -EINVAL;
-
-	dev = kzalloc(sizeof(struct nvm_dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->q = q;
-	dev->ops = ops;
-	strncpy(dev->name, disk_name, DISK_NAME_LEN);
-
 	ret = nvm_init(dev);
 	if (ret)
 		goto err_init;
@@ -709,29 +701,17 @@ int nvm_register(struct request_queue *q, char *disk_name,
 	return 0;
 err_init:
 	kfree(dev->lun_map);
-	kfree(dev);
 	return ret;
 }
 EXPORT_SYMBOL(nvm_register);
 
-void nvm_unregister(char *disk_name)
+void nvm_unregister(struct nvm_dev *dev)
 {
-	struct nvm_dev *dev;
-
 	down_write(&nvm_lock);
-	dev = nvm_find_nvm_dev(disk_name);
-	if (!dev) {
-		pr_err("nvm: could not find device %s to unregister\n",
-								disk_name);
-		up_write(&nvm_lock);
-		return;
-	}
-
 	list_del(&dev->devices);
 	up_write(&nvm_lock);
 
 	nvm_exit(dev);
-	kfree(dev);
 }
 EXPORT_SYMBOL(nvm_unregister);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f488729..ff20f1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -62,12 +62,14 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
-	if (ns->type == NVME_NS_LIGHTNVM)
-		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
+	if (ns->ndev)
+		nvme_nvm_unregister(ns);
 
-	spin_lock(&dev_list_lock);
-	ns->disk->private_data = NULL;
-	spin_unlock(&dev_list_lock);
+	if (ns->disk) {
+		spin_lock(&dev_list_lock);
+		ns->disk->private_data = NULL;
+		spin_unlock(&dev_list_lock);
+	}
 
 	put_disk(ns->disk);
 	ida_simple_remove(&ns->ctrl->ns_ida, ns->instance);
@@ -604,8 +606,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
 static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 {
 	if (nvme_identify_ns(ns->ctrl, ns->ns_id, id)) {
-		dev_warn(disk_to_dev(ns->disk), "%s: Identify failure\n",
-				__func__);
+		dev_warn(ns->ctrl->dev, "%s: Identify failure\n", __func__);
 		return -ENODEV;
 	}
 
@@ -1271,18 +1272,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
 	if (nvme_nvm_ns_supported(ns, id)) {
-		if (nvme_nvm_register(ns->queue, disk_name)) {
-			dev_warn(ctrl->dev,
-				"%s: LightNVM init failure\n", __func__);
+		if (nvme_nvm_register(ns, disk_name, node)) {
+			dev_warn(ctrl->dev, "%s: LightNVM init failure\n",
+								__func__);
 			goto out_free_id;
 		}
-
-		disk = alloc_disk_node(0, node);
-		if (!disk)
-			goto out_free_id;
-		memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
-		ns->disk = disk;
-		ns->type = NVME_NS_LIGHTNVM;
 	} else {
 		disk = alloc_disk_node(0, node);
 		if (!disk)
@@ -1328,7 +1322,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
-	if (ns->disk->flags & GENHD_FL_UP) {
+	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
@@ -1349,7 +1343,7 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_ns(ctrl, nsid);
 	if (ns) {
-		if (revalidate_disk(ns->disk))
+		if (ns->disk && revalidate_disk(ns->disk))
 			nvme_ns_remove(ns);
 	} else
 		nvme_alloc_ns(ctrl, nsid);
@@ -1559,7 +1553,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		 * Revalidating a dead namespace sets capacity to 0. This will
 		 * end buffered writers dirtying pages that can't be synced.
 		 */
-		if (!test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+		if (ns->disk && !test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 			revalidate_disk(ns->disk);
 
 		blk_set_queue_dying(ns->queue);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a0af055..cd406c5 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -592,14 +592,27 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.max_phys_sect		= 64,
 };
 
-int nvme_nvm_register(struct request_queue *q, char *disk_name)
+int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 {
-	return nvm_register(q, disk_name, &nvme_nvm_dev_ops);
+	struct request_queue *q = ns->queue;
+	struct nvm_dev *dev;
+
+	dev = nvm_alloc_dev(node);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->q = q;
+	memcpy(dev->name, disk_name, DISK_NAME_LEN);
+	dev->ops = &nvme_nvm_dev_ops;
+	ns->ndev = dev;
+
+	return nvm_register(dev);
 }
 
-void nvme_nvm_unregister(struct request_queue *q, char *disk_name)
+void nvme_nvm_unregister(struct nvme_ns *ns)
 {
-	nvm_unregister(disk_name);
+	nvm_unregister(ns->ndev);
+	kfree(ns->ndev);
 }
 
 /* move to shared place when used in multiple places. */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0d0c81d..d62c6fd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
+#include <linux/lightnvm.h>
 
 enum {
 	/*
@@ -110,6 +111,7 @@ struct nvme_ns {
 	struct nvme_ctrl *ctrl;
 	struct request_queue *queue;
 	struct gendisk *disk;
+	struct nvm_dev *ndev;
 	struct kref kref;
 	int instance;
 
@@ -121,7 +123,6 @@ struct nvme_ns {
 	u16 ms;
 	bool ext;
 	u8 pi_type;
-	int type;
 	unsigned long flags;
 
 #define NVME_NS_REMOVING 0
@@ -302,12 +303,13 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 	return (container_of(dev, struct nvm_dev, dev))->private_data;
 }
 #else
-static inline int nvme_nvm_register(struct request_queue *q, char *disk_name)
+static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
+								int node)
 {
 	return 0;
 }
 
-static inline void nvme_nvm_unregister(struct request_queue *q, char *disk_name) {};
+static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
 
 static inline int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ba78b83..5afc263 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -524,9 +524,9 @@ extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *,
 								unsigned long);
 extern void nvm_put_blk(struct nvm_dev *, struct nvm_block *);
 
-extern int nvm_register(struct request_queue *, char *,
-						struct nvm_dev_ops *);
-extern void nvm_unregister(char *);
+extern struct nvm_dev *nvm_alloc_dev(int);
+extern int nvm_register(struct nvm_dev *);
+extern void nvm_unregister(struct nvm_dev *);
 
 void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type);
 
@@ -575,11 +575,14 @@ extern int nvm_dev_factory(struct nvm_dev *, int flags);
 #else /* CONFIG_NVM */
 struct nvm_dev_ops;
 
-static inline int nvm_register(struct request_queue *q, char *disk_name,
-							struct nvm_dev_ops *ops)
+static inline struct nvm_dev *nvm_alloc_dev(int node)
+{
+	return ERR_PTR(-EINVAL);
+}
+static inline int nvm_register(struct nvm_dev *dev)
 {
 	return -EINVAL;
 }
-static inline void nvm_unregister(char *disk_name) {}
+static inline void nvm_unregister(struct nvm_dev *dev) {}
 #endif /* CONFIG_NVM */
 #endif /* LIGHTNVM.H */
-- 
2.1.4

