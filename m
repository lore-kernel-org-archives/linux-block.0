Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:32:05 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 09/10] Sysfs entries for multipath head
Message-ID: <20170912043205.rkk2tjs6rmwgwdnu@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Sysfs entries for active path and ioctl redirecting to active namespace when device handle is head namespace.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4043c00..82f8e10 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1600,6 +1600,18 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_ns *mpath_ns = ns;
+
+	ns = nvme_get_active_ns_for_mpath_ns(mpath_ns);
+	if (!ns) {
+		/* fail IOCTL if no active ns found for mpath */
+		return -ENOTTY;
+	}
+
+	if (test_bit(NVME_NS_REMOVING, &ns->flags) || (ns->ctrl->state != NVME_CTRL_LIVE)) {
+		return -ENOTTY;
+	}
+
 
 	switch (cmd) {
 	case NVME_IOCTL_ID:
@@ -1642,7 +1654,8 @@ static void nvme_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nvme_ns *ns = disk->private_data;
 
-	module_put(ns->ctrl->ops->module);
+	if (!test_bit(NVME_NS_ROOT, &ns->flags))
+		module_put(ns->ctrl->ops->module);
 	nvme_put_ns(ns);
 }
 
@@ -1747,6 +1760,8 @@ static void nvme_config_discard(struct nvme_ns *ns)
 
 static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 {
+	int res = 0;
+	char *buf;
 	if (nvme_identify_ns(ns->ctrl, ns->ns_id, id)) {
 		dev_warn(ns->ctrl->dev, "%s: Identify failure\n", __func__);
 		return -ENODEV;
@@ -1770,6 +1785,17 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 				 "%s: Identify Descriptors failed\n", __func__);
 	}
 
+	/*Retrieve NGUID or UUID from target device as it needs to be persistent across boot.*/
+	if (!test_bit(NVME_NS_ROOT, &ns->flags)) {
+		res = nvme_get_mpath_nguid(ns->ctrl, ns->ns_id, &buf);
+		if (res) {
+			dev_warn(ns->ctrl->dev, "%s: Failed to get NGUID\n", __func__);
+		} else {
+			memcpy(ns->mpath_nguid, buf, NVME_NIDT_NGUID_LEN);
+			kfree(buf);
+		}
+	}
+
 	return 0;
 }
 
@@ -1779,6 +1805,9 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 bs;
 
+	/*For device to shared,  Bit 0 is set nmic.
+	We use this to make device part of multipath group.*/
+	ns->nmic = id->nmic;
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
 	 * block layer can use before failing read/write for 0 capacity.
@@ -1810,15 +1839,19 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 
 static int nvme_revalidate_disk(struct gendisk *disk)
 {
+	struct nvme_ns *mpath_ns;
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_id_ns *id = NULL;
 	int ret;
+	mpath_ns = ns;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
 		set_capacity(disk, 0);
 		return -ENODEV;
 	}
 
+	ns = nvme_get_ns_for_mpath_ns(mpath_ns);
+
 	ret = nvme_revalidate_ns(ns, &id);
 	if (ret)
 		return ret;
@@ -2641,6 +2674,37 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
+static ssize_t active_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	int ret = 0;
+	if (!test_bit(NVME_NS_ROOT, &ns->flags)) {
+		ret = sprintf(buf, "%d\n", ns->active);
+	}
+	return ret;
+}
+static DEVICE_ATTR(active, S_IRUGO, active_show, NULL);
+
+static ssize_t active_path_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *mpath_ns = nvme_get_ns_from_dev(dev);
+	struct nvme_ns *nsa;
+	int ret = 0;
+	if (test_bit(NVME_NS_ROOT, &mpath_ns->flags)) {
+		mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+		list_for_each_entry(nsa, &mpath_ns->ctrl->namespaces, mpathlist) {
+			if (nsa->active) {
+				ret = sprintf(buf, "nvme%dn%d\n", nsa->ctrl->instance, nsa->instance);
+				break;
+			}
+		}
+		mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+	}
+	return ret;
+}
+static DEVICE_ATTR(active_path, S_IRUGO, active_path_show, NULL);
+
 static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -2649,12 +2713,23 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 
+static ssize_t mpath_nguid_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	return sprintf(buf, "%pU\n", ns->mpath_nguid);
+}
+static DEVICE_ATTR(mpath_nguid, S_IRUGO, mpath_nguid_show, NULL);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_active.attr,
+	&dev_attr_active_path.attr,
+	&dev_attr_mpath_nguid.attr,
 	NULL,
 };
 
@@ -2714,6 +2789,9 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
+	if (test_bit(NVME_CTRL_MULTIPATH, &ctrl->flags))
+		return 0;
+
 	if (device_remove_file_self(dev, attr))
 		ctrl->ops->delete_ctrl(ctrl);
 	return count;
@@ -2758,8 +2836,22 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 					 char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subnqn);
+	struct nvme_ns *nsa = NULL;
+	ssize_t ret = 0;
+	if (test_bit(NVME_CTRL_MULTIPATH, &ctrl->flags)) {
+		/* mpath ctrl, iterate and send it to nsa->ctrl */
+		mutex_lock(&ctrl->namespaces_mutex);
+		list_for_each_entry(nsa, &ctrl->namespaces, mpathlist) {
+			if (nsa->ctrl && nsa->ctrl->ops) {
+				ret = snprintf(buf, PAGE_SIZE, "%s\n", nsa->ctrl->subnqn);
+				break;
+			}
+		}
+		mutex_unlock(&ctrl->namespaces_mutex);
+	} else {
+		ret = snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subnqn);
+	}
+	return ret;
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
-- 
2.9.3
