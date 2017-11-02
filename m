Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/5] nvme: introduce a nvme_ns_ids structure
Date: Thu,  2 Nov 2017 21:30:31 +0300
Message-Id: <20171102183034.9320-3-hch@lst.de>
In-Reply-To: <20171102183034.9320-1-hch@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This allows us to manage the various uniqueue namespace identifiers
together instead needing various variables and arguments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/nvme/host/core.c | 69 +++++++++++++++++++++++++++---------------------
 drivers/nvme/host/nvme.h | 14 +++++++---
 2 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f385c35ed2d9..dc0bbbd4ef46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -788,7 +788,7 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 }
 
 static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
-		u8 *eui64, u8 *nguid, uuid_t *uuid)
+		struct nvme_ns_ids *ids)
 {
 	struct nvme_command c = { };
 	int status;
@@ -824,7 +824,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 				goto free_data;
 			}
 			len = NVME_NIDT_EUI64_LEN;
-			memcpy(eui64, data + pos + sizeof(*cur), len);
+			memcpy(ids->eui64, data + pos + sizeof(*cur), len);
 			break;
 		case NVME_NIDT_NGUID:
 			if (cur->nidl != NVME_NIDT_NGUID_LEN) {
@@ -834,7 +834,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 				goto free_data;
 			}
 			len = NVME_NIDT_NGUID_LEN;
-			memcpy(nguid, data + pos + sizeof(*cur), len);
+			memcpy(ids->nguid, data + pos + sizeof(*cur), len);
 			break;
 		case NVME_NIDT_UUID:
 			if (cur->nidl != NVME_NIDT_UUID_LEN) {
@@ -844,7 +844,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 				goto free_data;
 			}
 			len = NVME_NIDT_UUID_LEN;
-			uuid_copy(uuid, data + pos + sizeof(*cur));
+			uuid_copy(&ids->uuid, data + pos + sizeof(*cur));
 			break;
 		default:
 			/* Skip unnkown types */
@@ -1146,22 +1146,31 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
 }
 
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
-		struct nvme_id_ns *id, u8 *eui64, u8 *nguid, uuid_t *uuid)
+		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
 {
+	memset(ids, 0, sizeof(*ids));
+
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
-		memcpy(eui64, id->eui64, sizeof(id->eui64));
+		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
 	if (ctrl->vs >= NVME_VS(1, 2, 0))
-		memcpy(nguid, id->nguid, sizeof(id->nguid));
+		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
 	if (ctrl->vs >= NVME_VS(1, 3, 0)) {
 		 /* Don't treat error as fatal we potentially
 		  * already have a NGUID or EUI-64
 		  */
-		if (nvme_identify_ns_descs(ctrl, nsid, eui64, nguid, uuid))
+		if (nvme_identify_ns_descs(ctrl, nsid, ids))
 			dev_warn(ctrl->device,
 				 "%s: Identify Descriptors failed\n", __func__);
 	}
 }
 
+static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
+{
+	return uuid_equal(&a->uuid, &b->uuid) &&
+		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
+		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0;
+}
+
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
@@ -1217,8 +1226,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
-	u8 eui64[8] = { 0 }, nguid[16] = { 0 };
-	uuid_t uuid = uuid_null;
+	struct nvme_ns_ids ids;
 	int ret = 0;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
@@ -1235,10 +1243,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
-	if (!uuid_equal(&ns->uuid, &uuid) ||
-	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
-	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {
+	nvme_report_ns_ids(ctrl, ns->ns_id, id, &ids);
+	if (!nvme_ns_ids_equal(&ns->ids, &ids)) {
 		dev_err(ctrl->device,
 			"identifiers changed for nsid %d\n", ns->ns_id);
 		ret = -ENODEV;
@@ -2142,18 +2148,19 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	struct nvme_ns_ids *ids = &ns->ids;
 	struct nvme_subsystem *subsys = ns->ctrl->subsys;
 	int serial_len = sizeof(subsys->serial);
 	int model_len = sizeof(subsys->model);
 
-	if (!uuid_is_null(&ns->uuid))
-		return sprintf(buf, "uuid.%pU\n", &ns->uuid);
+	if (!uuid_is_null(&ids->uuid))
+		return sprintf(buf, "uuid.%pU\n", &ids->uuid);
 
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
-		return sprintf(buf, "eui.%16phN\n", ns->nguid);
+	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+		return sprintf(buf, "eui.%16phN\n", ids->nguid);
 
-	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
-		return sprintf(buf, "eui.%8phN\n", ns->eui);
+	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+		return sprintf(buf, "eui.%8phN\n", ids->eui64);
 
 	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
 				  subsys->serial[serial_len - 1] == '\0'))
@@ -2172,7 +2179,7 @@ static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%pU\n", ns->nguid);
+	return sprintf(buf, "%pU\n", ns->ids.nguid);
 }
 static DEVICE_ATTR(nguid, S_IRUGO, nguid_show, NULL);
 
@@ -2180,16 +2187,17 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	struct nvme_ns_ids *ids = &ns->ids;
 
 	/* For backward compatibility expose the NGUID to userspace if
 	 * we have no UUID set
 	 */
-	if (uuid_is_null(&ns->uuid)) {
+	if (uuid_is_null(&ids->uuid)) {
 		printk_ratelimited(KERN_WARNING
 				   "No UUID available providing old NGUID\n");
-		return sprintf(buf, "%pU\n", ns->nguid);
+		return sprintf(buf, "%pU\n", ids->nguid);
 	}
-	return sprintf(buf, "%pU\n", &ns->uuid);
+	return sprintf(buf, "%pU\n", &ids->uuid);
 }
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 
@@ -2197,7 +2205,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->eui);
+	return sprintf(buf, "%8phd\n", ns->ids.eui64);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
@@ -2223,18 +2231,19 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	struct nvme_ns_ids *ids = &ns->ids;
 
 	if (a == &dev_attr_uuid.attr) {
-		if (uuid_is_null(&ns->uuid) ||
-		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
+		if (uuid_is_null(&ids->uuid) ||
+		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			return 0;
 	}
 	if (a == &dev_attr_nguid.attr) {
-		if (!memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
+		if (!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			return 0;
 	}
 	if (a == &dev_attr_eui.attr) {
-		if (!memchr_inv(ns->eui, 0, sizeof(ns->eui)))
+		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
 	return a->mode;
@@ -2467,7 +2476,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, &ns->uuid);
+	nvme_report_ns_ids(ctrl, ns->ns_id, id, &ns->ids);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 767e940d83ed..91b39d816085 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -216,6 +216,15 @@ struct nvme_subsystem {
 	u16			vendor_id;
 };
 
+/*
+ * Container structure for uniqueue namespace identifiers.
+ */
+struct nvme_ns_ids {
+	u8	eui64[8];
+	u8	nguid[16];
+	uuid_t	uuid;
+};
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -226,11 +235,8 @@ struct nvme_ns {
 	struct kref kref;
 	int instance;
 
-	u8 eui[8];
-	u8 nguid[16];
-	uuid_t uuid;
-
 	unsigned ns_id;
+	struct nvme_ns_ids ids;
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
-- 
2.14.2
