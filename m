Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12170 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeHMUIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Aug 2018 16:08:41 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matias Bjorling <mb@lightnvm.io>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] nvme: Fix race conditions related to creation of /dev/nvme0n<x>
Date: Mon, 13 Aug 2018 10:25:31 -0700
Message-Id: <20180813172531.7451-3-bart.vanassche@wdc.com>
In-Reply-To: <20180813172531.7451-1-bart.vanassche@wdc.com>
References: <20180813172531.7451-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For the udev rules that create symbolic links under /dev it is
essential that all sysfs attributes are registered before an object
becomes visible. This patch avoids that udevd fails to create the
/dev/disk/by-id/nvme-uuid.* symbolic link.

Fixes: 2b9b6e86bca7 ("NVMe: Export namespace attributes to sysfs")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/core.c     | 17 +++++------------
 drivers/nvme/host/lightnvm.c | 34 +++++++---------------------------
 drivers/nvme/host/nvme.h     |  9 ++++-----
 3 files changed, 16 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..0121db66d2c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3043,6 +3043,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
+	const struct attribute_group *nvme_attr_groups[3];
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -3080,7 +3081,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		}
 	}
 
-	disk = alloc_disk_node(0, node);
+	nvme_attr_groups[0] = &nvme_ns_id_attr_group;
+	nvme_attr_groups[1] = nvme_nvm_attr_group(ns);
+	nvme_attr_groups[2] = NULL;
+	disk = alloc_disk_node_attr(0, node, nvme_attr_groups);
 	if (!disk)
 		goto out_unlink_ns;
 
@@ -3100,13 +3104,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_get_ctrl(ctrl);
 
 	device_add_disk(ctrl->device, ns->disk);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
-	if (ns->ndev && nvme_nvm_register_sysfs(ns))
-		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
-			ns->disk->disk_name);
 
 	nvme_mpath_add_disk(ns, id);
 	nvme_fault_inject_init(ns);
@@ -3132,10 +3129,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group);
-		if (ns->ndev)
-			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 6fe5923c95d4..11e687f3c36f 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1270,39 +1270,19 @@ static const struct attribute_group nvm_dev_attr_group_20 = {
 	.attrs		= nvm_dev_attrs_20,
 };
 
-int nvme_nvm_register_sysfs(struct nvme_ns *ns)
+const struct attribute_group *nvme_nvm_attr_group(const struct nvme_ns *ns)
 {
-	struct nvm_dev *ndev = ns->ndev;
-	struct nvm_geo *geo = &ndev->geo;
+	const struct nvm_dev *ndev = ns->ndev;
 
 	if (!ndev)
-		return -EINVAL;
+		return NULL;
 
-	switch (geo->major_ver_id) {
+	switch (ndev->geo->major_ver_id) {
 	case 1:
-		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvm_dev_attr_group_12);
+		return &nvm_dev_attr_group_12;
 	case 2:
-		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvm_dev_attr_group_20);
+		return &nvm_dev_attr_group_20;
 	}
 
-	return -EINVAL;
-}
-
-void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
-{
-	struct nvm_dev *ndev = ns->ndev;
-	struct nvm_geo *geo = &ndev->geo;
-
-	switch (geo->major_ver_id) {
-	case 1:
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvm_dev_attr_group_12);
-		break;
-	case 2:
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvm_dev_attr_group_20);
-		break;
-	}
+	return NULL;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..112596ad1ed3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -551,8 +551,7 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
-int nvme_nvm_register_sysfs(struct nvme_ns *ns);
-void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
+const struct attribute_group *nvme_nvm_attr_group(const struct nvme_ns *ns);
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
 #else
 static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
@@ -563,11 +562,11 @@ static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 }
 
 static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
-static inline int nvme_nvm_register_sysfs(struct nvme_ns *ns)
+static inline const struct attribute_group *
+nvme_nvm_attr_group(const struct nvme_ns *ns)
 {
-	return 0;
+	return NULL;
 }
-static inline void nvme_nvm_unregister_sysfs(struct nvme_ns *ns) {};
 static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
 							unsigned long arg)
 {
-- 
2.18.0
