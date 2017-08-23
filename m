Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 04/10] nvme: remove nvme_revalidate_ns
Date: Wed, 23 Aug 2017 19:58:09 +0200
Message-Id: <20170823175815.3646-5-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The function is used in two places, and the shared code for those will
diverge later in this series.

Instead factor out a new helper to get the ids for a namespace, simplify
the calling conventions for nvme_identify_ns and just open code the
sequence.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 100 +++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f91c649c9ca5..157dbb7b328d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -783,7 +783,8 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
-static int nvme_identify_ns_descs(struct nvme_ns *ns, unsigned nsid)
+static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
+		u8 *eui64, u8 *nguid, uuid_t *uuid)
 {
 	struct nvme_command c = { };
 	int status;
@@ -799,7 +800,7 @@ static int nvme_identify_ns_descs(struct nvme_ns *ns, unsigned nsid)
 	if (!data)
 		return -ENOMEM;
 
-	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, data,
+	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
 				      NVME_IDENTIFY_DATA_SIZE);
 	if (status)
 		goto free_data;
@@ -813,33 +814,33 @@ static int nvme_identify_ns_descs(struct nvme_ns *ns, unsigned nsid)
 		switch (cur->nidt) {
 		case NVME_NIDT_EUI64:
 			if (cur->nidl != NVME_NIDT_EUI64_LEN) {
-				dev_warn(ns->ctrl->device,
+				dev_warn(ctrl->device,
 					 "ctrl returned bogus length: %d for NVME_NIDT_EUI64\n",
 					 cur->nidl);
 				goto free_data;
 			}
 			len = NVME_NIDT_EUI64_LEN;
-			memcpy(ns->eui, data + pos + sizeof(*cur), len);
+			memcpy(eui64, data + pos + sizeof(*cur), len);
 			break;
 		case NVME_NIDT_NGUID:
 			if (cur->nidl != NVME_NIDT_NGUID_LEN) {
-				dev_warn(ns->ctrl->device,
+				dev_warn(ctrl->device,
 					 "ctrl returned bogus length: %d for NVME_NIDT_NGUID\n",
 					 cur->nidl);
 				goto free_data;
 			}
 			len = NVME_NIDT_NGUID_LEN;
-			memcpy(ns->nguid, data + pos + sizeof(*cur), len);
+			memcpy(nguid, data + pos + sizeof(*cur), len);
 			break;
 		case NVME_NIDT_UUID:
 			if (cur->nidl != NVME_NIDT_UUID_LEN) {
-				dev_warn(ns->ctrl->device,
+				dev_warn(ctrl->device,
 					 "ctrl returned bogus length: %d for NVME_NIDT_UUID\n",
 					 cur->nidl);
 				goto free_data;
 			}
 			len = NVME_NIDT_UUID_LEN;
-			uuid_copy(&ns->uuid, data + pos + sizeof(*cur));
+			uuid_copy(uuid, data + pos + sizeof(*cur));
 			break;
 		default:
 			/* Skip unnkown types */
@@ -864,9 +865,10 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
 }
 
-static int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
-		struct nvme_id_ns **id)
+static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
+		unsigned nsid)
 {
+	struct nvme_id_ns *id;
 	struct nvme_command c = { };
 	int error;
 
@@ -875,15 +877,18 @@ static int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 	c.identify.nsid = cpu_to_le32(nsid);
 	c.identify.cns = NVME_ID_CNS_NS;
 
-	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
-	if (!*id)
-		return -ENOMEM;
+	id = kmalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return NULL;
 
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
-			sizeof(struct nvme_id_ns));
-	if (error)
-		kfree(*id);
-	return error;
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	if (error) {
+		dev_warn(ctrl->device, "Identify namespace failed\n");
+		kfree(id);
+		return NULL;
+	}
+
+	return id;
 }
 
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
@@ -1174,32 +1179,21 @@ static void nvme_config_discard(struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(ns->queue, UINT_MAX);
 }
 
-static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
+static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
+		struct nvme_id_ns *id, u8 *eui64, u8 *nguid, uuid_t *uuid)
 {
-	if (nvme_identify_ns(ns->ctrl, ns->ns_id, id)) {
-		dev_warn(ns->ctrl->device, "Identify namespace failed\n");
-		return -ENODEV;
-	}
-
-	if ((*id)->ncap == 0) {
-		kfree(*id);
-		return -ENODEV;
-	}
-
-	if (ns->ctrl->vs >= NVME_VS(1, 1, 0))
-		memcpy(ns->eui, (*id)->eui64, sizeof(ns->eui));
-	if (ns->ctrl->vs >= NVME_VS(1, 2, 0))
-		memcpy(ns->nguid, (*id)->nguid, sizeof(ns->nguid));
-	if (ns->ctrl->vs >= NVME_VS(1, 3, 0)) {
+	if (ctrl->vs >= NVME_VS(1, 1, 0))
+		memcpy(eui64, id->eui64, sizeof(id->eui64));
+	if (ctrl->vs >= NVME_VS(1, 2, 0))
+		memcpy(nguid, id->nguid, sizeof(id->nguid));
+	if (ctrl->vs >= NVME_VS(1, 3, 0)) {
 		 /* Don't treat error as fatal we potentially
 		  * already have a NGUID or EUI-64
 		  */
-		if (nvme_identify_ns_descs(ns, ns->ns_id))
-			dev_warn(ns->ctrl->device,
+		if (nvme_identify_ns_descs(ctrl, nsid, eui64, nguid, uuid))
+			dev_warn(ctrl->device,
 				 "%s: Identify Descriptors failed\n", __func__);
 	}
-
-	return 0;
 }
 
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
@@ -1240,22 +1234,28 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 static int nvme_revalidate_disk(struct gendisk *disk)
 {
 	struct nvme_ns *ns = disk->private_data;
-	struct nvme_id_ns *id = NULL;
-	int ret;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_id_ns *id;
+	int ret = 0;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
 		set_capacity(disk, 0);
 		return -ENODEV;
 	}
 
-	ret = nvme_revalidate_ns(ns, &id);
-	if (ret)
-		return ret;
+	id = nvme_identify_ns(ctrl, ns->ns_id);
+	if (!id)
+		return -ENODEV;
 
-	__nvme_revalidate_disk(disk, id);
-	kfree(id);
+	if (id->ncap == 0) {
+		ret = -ENODEV;
+		goto out;
+	}
 
-	return 0;
+	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, &ns->uuid);
+out:
+	kfree(id);
+	return ret;
 }
 
 static char nvme_pr_type(enum pr_type type)
@@ -2347,9 +2347,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
-	if (nvme_revalidate_ns(ns, &id))
+	id = nvme_identify_ns(ctrl, nsid);
+	if (!id)
 		goto out_free_queue;
 
+	if (id->ncap == 0)
+		goto out_free_id;
+
+	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, &ns->uuid);
+
 	if (nvme_nvm_ns_supported(ns, id) &&
 				nvme_nvm_register(ns, disk_name, node)) {
 		dev_warn(ctrl->device, "%s: LightNVM init failure\n", __func__);
-- 
2.11.0
