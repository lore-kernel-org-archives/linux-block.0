Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/5] nvme: also expose the namespace identification sysfs files for mpath nodes
Date: Thu,  2 Nov 2017 21:30:34 +0300
Message-Id: <20171102183034.9320-6-hch@lst.de>
In-Reply-To: <20171102183034.9320-1-hch@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We do this by adding a helper that returns the ns_head for a device that
can belong to either the per-controller or per-subsystem block device
nodes, and otherwise reuse all the existing code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c      | 57 +++++++++++++++++++++++--------------------
 drivers/nvme/host/multipath.c |  6 +++++
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09f0e826b426..9209b8bca64b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2258,12 +2258,22 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (disk->fops == &nvme_fops)
+		return nvme_get_ns_from_dev(dev)->head;
+	else
+		return disk->private_data;
+}
+
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
-								char *buf)
+		char *buf)
 {
-	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ns_ids *ids = &ns->head->ids;
-	struct nvme_subsystem *subsys = ns->ctrl->subsys;
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct nvme_ns_ids *ids = &head->ids;
+	struct nvme_subsystem *subsys = head->subsys;
 	int serial_len = sizeof(subsys->serial);
 	int model_len = sizeof(subsys->model);
 
@@ -2285,23 +2295,21 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
 		serial_len, subsys->serial, model_len, subsys->model,
-		ns->head->ns_id);
+		head->ns_id);
 }
 static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 
 static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+		char *buf)
 {
-	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%pU\n", ns->head->ids.nguid);
+	return sprintf(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
 }
 static DEVICE_ATTR(nguid, S_IRUGO, nguid_show, NULL);
 
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
-								char *buf)
+		char *buf)
 {
-	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ns_ids *ids = &ns->head->ids;
+	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	/* For backward compatibility expose the NGUID to userspace if
 	 * we have no UUID set
@@ -2316,22 +2324,20 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 
 static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
-								char *buf)
+		char *buf)
 {
-	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->head->ids.eui64);
+	return sprintf(buf, "%8phd\n", dev_to_ns_head(dev)->ids.eui64);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
 static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
-								char *buf)
+		char *buf)
 {
-	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%d\n", ns->head->ns_id);
+	return sprintf(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
 }
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 
-static struct attribute *nvme_ns_attrs[] = {
+static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
@@ -2340,12 +2346,11 @@ static struct attribute *nvme_ns_attrs[] = {
 	NULL,
 };
 
-static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
+static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ns_ids *ids = &ns->head->ids;
+	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	if (a == &dev_attr_uuid.attr) {
 		if (uuid_is_null(&ids->uuid) ||
@@ -2363,9 +2368,9 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static const struct attribute_group nvme_ns_attr_group = {
-	.attrs		= nvme_ns_attrs,
-	.is_visible	= nvme_ns_attrs_are_visible,
+const struct attribute_group nvme_ns_id_attr_group = {
+	.attrs		= nvme_ns_id_attrs,
+	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
 
 #define nvme_show_str_function(field)						\
@@ -2742,7 +2747,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	device_add_disk(ctrl->device, ns->disk);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group))
+					&nvme_ns_id_attr_group))
 		pr_warn("%s: failed to create sysfs group for identification\n",
 			ns->disk->disk_name);
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
@@ -2775,7 +2780,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group);
+					&nvme_ns_id_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 062754ebebfd..850275896e49 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -239,12 +239,18 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 	if (!head->disk)
 		return;
 	device_add_disk(&head->subsys->dev, head->disk);
+	if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
+			&nvme_ns_id_attr_group))
+		pr_warn("%s: failed to create sysfs group for identification\n",
+			head->disk->disk_name);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
+	sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
+			   &nvme_ns_id_attr_group);
 	del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d98064d4ed76..ac71e21e313b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -396,6 +396,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
+extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.14.2
