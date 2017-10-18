Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 17/17] nvme: also expose the namespace identification sysfs files for mpath nodes
Date: Wed, 18 Oct 2017 18:52:58 +0200
Message-Id: <20171018165258.23212-18-hch@lst.de>
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We do this by adding a helper that returns the ns_head for a device that
can belong to either the per-controller or per-subsystem block device
nodes, and otherwise reuse all the existing code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 67 +++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 49a81118c9f8..529a1cf97e61 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -76,6 +76,7 @@ static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
+static const struct attribute_group nvme_ns_id_attr_group;
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 {
@@ -329,6 +330,8 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
+			   &nvme_ns_id_attr_group);
 	del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
@@ -2267,12 +2270,22 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
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
 
@@ -2294,23 +2307,21 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 
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
@@ -2325,22 +2336,20 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
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
@@ -2349,12 +2358,11 @@ static struct attribute *nvme_ns_attrs[] = {
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
@@ -2372,9 +2380,9 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static const struct attribute_group nvme_ns_attr_group = {
-	.attrs		= nvme_ns_attrs,
-	.is_visible	= nvme_ns_attrs_are_visible,
+static const struct attribute_group nvme_ns_id_attr_group = {
+	.attrs		= nvme_ns_id_attrs,
+	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
 
 #define nvme_show_str_function(field)						\
@@ -2851,15 +2859,20 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	device_add_disk(ctrl->device, ns->disk);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group))
+					&nvme_ns_id_attr_group))
 		pr_warn("%s: failed to create sysfs group for identification\n",
 			ns->disk->disk_name);
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
 
-	if (new)
+	if (new) {
 		device_add_disk(&ns->head->subsys->dev, ns->head->disk);
+		if (sysfs_create_group(&disk_to_dev(ns->head->disk)->kobj,
+				&nvme_ns_id_attr_group))
+			pr_warn("%s: failed to create sysfs group for identification\n",
+				ns->head->disk->disk_name);
+	}
 
 	return;
  out_unlink_ns:
@@ -2884,6 +2897,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
+		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+				   &nvme_ns_id_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
-- 
2.14.1
