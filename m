Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 07/10] nvme: track shared namespaces
Date: Wed, 23 Aug 2017 19:58:12 +0200
Message-Id: <20170823175815.3646-8-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Introduce a new struct nvme_ns_head [1] that holds information about
an actual namespace, unlike struct nvme_ns, which only holds the
per-controller namespace information.  For private namespaces there
is a 1:1 relation of the two, but for shared namespaces this lets us
discover all the paths to it.  For now only the identifiers are moved
to the new structure, but most of the information in struct nvme_ns
should eventually move over.

To allow lockless path lookup the list of nvme_ns structures per
nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
structure through call_srcu.

[1] comments welcome if you have a better name for it, the current one is
    horrible.  One idea would be to rename the current struct nvme_ns
    to struct nvme_ns_link or similar and use the nvme_ns name for the
    new structure.  But that would involve a lot of churn.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c     | 218 +++++++++++++++++++++++++++++++++++--------
 drivers/nvme/host/lightnvm.c |  14 +--
 drivers/nvme/host/nvme.h     |  26 +++++-
 3 files changed, 208 insertions(+), 50 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8884000dfbdd..abc5911a8a66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -249,10 +249,28 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
+static void nvme_destroy_ns_head(struct kref *ref)
+{
+	struct nvme_ns_head *head =
+		container_of(ref, struct nvme_ns_head, ref);
+
+	list_del_init(&head->entry);
+	cleanup_srcu_struct(&head->srcu);
+	kfree(head);
+}
+
+static void nvme_put_ns_head(struct nvme_ns_head *head)
+{
+	kref_put(&head->ref, nvme_destroy_ns_head);
+}
+
 static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	if (ns->head)
+		nvme_put_ns_head(ns->head);
+
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
@@ -422,7 +440,7 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 {
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->common.opcode = nvme_cmd_flush;
-	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
@@ -453,7 +471,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
-	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->dsm.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->dsm.nr = cpu_to_le32(segments - 1);
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
@@ -492,7 +510,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
-	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
@@ -977,7 +995,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
 	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->ns_id);
+	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks);
 	c.rw.control = cpu_to_le16(io.control);
@@ -1041,7 +1059,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
-		return ns->ns_id;
+		return ns->head->ns_id;
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ns->ctrl, NULL, (void __user *)arg);
 	case NVME_IOCTL_IO_CMD:
@@ -1248,7 +1266,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return -ENODEV;
 	}
 
-	id = nvme_identify_ns(ctrl, ns->ns_id);
+	id = nvme_identify_ns(ctrl, ns->head->ns_id);
 	if (!id)
 		return -ENODEV;
 
@@ -1257,12 +1275,12 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
-	if (!uuid_equal(&ns->uuid, &uuid) ||
-	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
-	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {
+	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, eui64, nguid, &uuid);
+	if (!uuid_equal(&ns->head->uuid, &uuid) ||
+	    memcmp(&ns->head->nguid, &nguid, sizeof(ns->head->nguid)) ||
+	    memcmp(&ns->head->eui64, &eui64, sizeof(ns->head->eui64))) {
 		dev_err(ctrl->device,
-			"identifiers changed for nsid %d\n", ns->ns_id);
+			"identifiers changed for nsid %d\n", ns->head->ns_id);
 		ret = -ENODEV;
 	}
 
@@ -1303,7 +1321,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.nsid = cpu_to_le32(ns->head->ns_id);
 	c.common.cdw10[0] = cpu_to_le32(cdw10);
 
 	return nvme_submit_sync_cmd(ns->queue, &c, data, 16);
@@ -1812,6 +1830,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	if (!subsys)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&subsys->ctrls);
+	INIT_LIST_HEAD(&subsys->nsheads);
 	kref_init(&subsys->ref);
 	nvme_init_subnqn(subsys, ctrl, id);
 	mutex_init(&subsys->lock);
@@ -2132,14 +2151,14 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	int serial_len = sizeof(ctrl->serial);
 	int model_len = sizeof(ctrl->model);
 
-	if (!uuid_is_null(&ns->uuid))
-		return sprintf(buf, "uuid.%pU\n", &ns->uuid);
+	if (!uuid_is_null(&ns->head->uuid))
+		return sprintf(buf, "uuid.%pU\n", &ns->head->uuid);
 
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
-		return sprintf(buf, "eui.%16phN\n", ns->nguid);
+	if (memchr_inv(ns->head->nguid, 0, sizeof(ns->head->nguid)))
+		return sprintf(buf, "eui.%16phN\n", ns->head->nguid);
 
-	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
-		return sprintf(buf, "eui.%8phN\n", ns->eui);
+	if (memchr_inv(ns->head->eui64, 0, sizeof(ns->head->eui64)))
+		return sprintf(buf, "eui.%8phN\n", ns->head->eui64);
 
 	while (serial_len > 0 && (ctrl->serial[serial_len - 1] == ' ' ||
 				  ctrl->serial[serial_len - 1] == '\0'))
@@ -2149,7 +2168,8 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 		model_len--;
 
 	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
-		serial_len, ctrl->serial, model_len, ctrl->model, ns->ns_id);
+		serial_len, ctrl->serial, model_len, ctrl->model,
+		ns->head->ns_id);
 }
 static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 
@@ -2157,7 +2177,7 @@ static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%pU\n", ns->nguid);
+	return sprintf(buf, "%pU\n", ns->head->nguid);
 }
 static DEVICE_ATTR(nguid, S_IRUGO, nguid_show, NULL);
 
@@ -2169,12 +2189,12 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	/* For backward compatibility expose the NGUID to userspace if
 	 * we have no UUID set
 	 */
-	if (uuid_is_null(&ns->uuid)) {
+	if (uuid_is_null(&ns->head->uuid)) {
 		printk_ratelimited(KERN_WARNING
 				   "No UUID available providing old NGUID\n");
-		return sprintf(buf, "%pU\n", ns->nguid);
+		return sprintf(buf, "%pU\n", ns->head->nguid);
 	}
-	return sprintf(buf, "%pU\n", &ns->uuid);
+	return sprintf(buf, "%pU\n", &ns->head->uuid);
 }
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 
@@ -2182,7 +2202,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->eui);
+	return sprintf(buf, "%8phd\n", ns->head->eui64);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
@@ -2190,7 +2210,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%d\n", ns->ns_id);
+	return sprintf(buf, "%d\n", ns->head->ns_id);
 }
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 
@@ -2210,16 +2230,16 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
-		if (uuid_is_null(&ns->uuid) ||
-		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
+		if (uuid_is_null(&ns->head->uuid) ||
+		    !memchr_inv(ns->head->nguid, 0, sizeof(ns->head->nguid)))
 			return 0;
 	}
 	if (a == &dev_attr_nguid.attr) {
-		if (!memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
+		if (!memchr_inv(ns->head->nguid, 0, sizeof(ns->head->nguid)))
 			return 0;
 	}
 	if (a == &dev_attr_eui.attr) {
-		if (!memchr_inv(ns->eui, 0, sizeof(ns->eui)))
+		if (!memchr_inv(ns->head->eui64, 0, sizeof(ns->head->eui64)))
 			return 0;
 	}
 	return a->mode;
@@ -2357,12 +2377,122 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL,
 };
 
+static struct nvme_ns_head *__nvme_find_ns_head(struct nvme_subsystem *subsys,
+		unsigned nsid)
+{
+	struct nvme_ns_head *h;
+
+	lockdep_assert_held(&subsys->lock);
+
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		if (h->ns_id == nsid && kref_get_unless_zero(&h->ref))
+			return h;
+	}
+
+	return NULL;
+}
+
+static int __nvme_check_ids(struct nvme_subsystem *subsys,
+		struct nvme_ns_head *new)
+{
+	struct nvme_ns_head *h;
+
+	lockdep_assert_held(&subsys->lock);
+
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		if ((!uuid_is_null(&new->uuid) &&
+		     uuid_equal(&new->uuid, &h->uuid)) ||
+		    (memchr_inv(new->nguid, 0, sizeof(new->nguid)) &&
+		     memcmp(&new->nguid, &h->nguid, sizeof(new->nguid))) ||
+		    (memchr_inv(new->eui64, 0, sizeof(new->eui64)) &&
+		     memcmp(&new->eui64, &h->eui64, sizeof(new->eui64))))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
+		unsigned nsid, struct nvme_id_ns *id)
+{
+	struct nvme_ns_head *head;
+	int ret = -ENOMEM;
+
+	head = kzalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		goto out;
+
+	INIT_LIST_HEAD(&head->list);
+	head->ns_id = nsid;
+	init_srcu_struct(&head->srcu);
+	kref_init(&head->ref);
+
+	nvme_report_ns_ids(ctrl, nsid, id, head->eui64, head->nguid,
+			&head->uuid);
+
+	ret = __nvme_check_ids(ctrl->subsys, head);
+	if (ret) {
+		dev_err(ctrl->device,
+			"duplicate IDs for nsid %d\n", nsid);
+		goto out_free_head;
+	}
+
+	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
+	return head;
+out_free_head:
+	cleanup_srcu_struct(&head->srcu);
+	kfree(head);
+out:
+	return ERR_PTR(ret);
+}
+
+static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
+		struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	bool is_shared = id->nmic & (1 << 0);
+	struct nvme_ns_head *head = NULL;
+	int ret = 0;
+
+	mutex_lock(&ctrl->subsys->lock);
+	if (is_shared)
+		head = __nvme_find_ns_head(ctrl->subsys, nsid);
+	if (!head) {
+		head = nvme_alloc_ns_head(ctrl, nsid, id);
+		if (IS_ERR(head)) {
+			ret = PTR_ERR(head);
+			goto out_unlock;
+		}
+	} else {
+		u8 eui64[8] = { 0 }, nguid[16] = { 0 };
+		uuid_t uuid = uuid_null;
+
+		nvme_report_ns_ids(ctrl, nsid, id, eui64, nguid, &uuid);
+		if (!uuid_equal(&head->uuid, &uuid) ||
+		    memcmp(&head->nguid, &nguid, sizeof(head->nguid)) ||
+		    memcmp(&head->eui64, &eui64, sizeof(head->eui64))) {
+			dev_err(ctrl->device,
+				"IDs don't match for shared namespace %d\n",
+					nsid);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+	}
+
+	list_add_tail(&ns->siblings, &head->list);
+	ns->head = head;
+
+out_unlock:
+	mutex_unlock(&ctrl->subsys->lock);
+	return ret;
+}
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
 	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
 
-	return nsa->ns_id - nsb->ns_id;
+	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
 static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -2371,12 +2501,12 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->ns_id == nsid) {
+		if (ns->head->ns_id == nsid) {
 			kref_get(&ns->kref);
 			ret = ns;
 			break;
 		}
-		if (ns->ns_id > nsid)
+		if (ns->head->ns_id > nsid)
 			break;
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
@@ -2391,7 +2521,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	if (!ctrl->nr_streams)
 		return 0;
 
-	ret = nvme_get_stream_params(ctrl, &s, ns->ns_id);
+	ret = nvme_get_stream_params(ctrl, &s, ns->head->ns_id);
 	if (ret)
 		return ret;
 
@@ -2433,7 +2563,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->ctrl = ctrl;
 
 	kref_init(&ns->kref);
-	ns->ns_id = nsid;
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
@@ -2449,17 +2578,18 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, &ns->uuid);
+	if (nvme_init_ns_head(ns, nsid, id))
+		goto out_free_id;
 
 	if (nvme_nvm_ns_supported(ns, id) &&
 				nvme_nvm_register(ns, disk_name, node)) {
 		dev_warn(ctrl->device, "%s: LightNVM init failure\n", __func__);
-		goto out_free_id;
+		goto out_unlink_ns;
 	}
 
 	disk = alloc_disk_node(0, node);
 	if (!disk)
-		goto out_free_id;
+		goto out_unlink_ns;
 
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
@@ -2487,6 +2617,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
 	return;
+ out_unlink_ns:
+	mutex_lock(&ctrl->subsys->lock);
+	list_del_rcu(&ns->siblings);
+	mutex_unlock(&ctrl->subsys->lock);
  out_free_id:
 	kfree(id);
  out_free_queue:
@@ -2499,6 +2633,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	struct nvme_ns_head *head = ns->head;
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -2513,10 +2649,16 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_cleanup_queue(ns->queue);
 	}
 
+	mutex_lock(&ns->ctrl->subsys->lock);
+	if (head)
+		list_del_rcu(&ns->siblings);
+	mutex_unlock(&ns->ctrl->subsys->lock);
+
 	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
 	mutex_unlock(&ns->ctrl->namespaces_mutex);
 
+	synchronize_srcu(&head->srcu);
 	nvme_put_ns(ns);
 }
 
@@ -2539,7 +2681,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->ns_id > nsid)
+		if (ns->head->ns_id > nsid)
 			nvme_ns_remove(ns);
 	}
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index c1a28569e843..3c9505066b58 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -305,7 +305,7 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 	int ret;
 
 	c.identity.opcode = nvme_nvm_admin_identity;
-	c.identity.nsid = cpu_to_le32(ns->ns_id);
+	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
 	c.identity.chnl_off = 0;
 
 	nvme_nvm_id = kmalloc(sizeof(struct nvme_nvm_id), GFP_KERNEL);
@@ -344,7 +344,7 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 	int ret = 0;
 
 	c.l2p.opcode = nvme_nvm_admin_get_l2p_tbl;
-	c.l2p.nsid = cpu_to_le32(ns->ns_id);
+	c.l2p.nsid = cpu_to_le32(ns->head->ns_id);
 	entries = kmalloc(len, GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;
@@ -402,7 +402,7 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 	int ret = 0;
 
 	c.get_bb.opcode = nvme_nvm_admin_get_bb_tbl;
-	c.get_bb.nsid = cpu_to_le32(ns->ns_id);
+	c.get_bb.nsid = cpu_to_le32(ns->head->ns_id);
 	c.get_bb.spba = cpu_to_le64(ppa.ppa);
 
 	bb_tbl = kzalloc(tblsz, GFP_KERNEL);
@@ -452,7 +452,7 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 	int ret = 0;
 
 	c.set_bb.opcode = nvme_nvm_admin_set_bb_tbl;
-	c.set_bb.nsid = cpu_to_le32(ns->ns_id);
+	c.set_bb.nsid = cpu_to_le32(ns->head->ns_id);
 	c.set_bb.spba = cpu_to_le64(ppas->ppa);
 	c.set_bb.nlb = cpu_to_le16(nr_ppas - 1);
 	c.set_bb.value = type;
@@ -469,7 +469,7 @@ static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd, struct nvme_ns *ns,
 				    struct nvme_nvm_command *c)
 {
 	c->ph_rw.opcode = rqd->opcode;
-	c->ph_rw.nsid = cpu_to_le32(ns->ns_id);
+	c->ph_rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c->ph_rw.spba = cpu_to_le64(rqd->ppa_addr.ppa);
 	c->ph_rw.metadata = cpu_to_le64(rqd->dma_meta_list);
 	c->ph_rw.control = cpu_to_le16(rqd->flags);
@@ -691,7 +691,7 @@ static int nvme_nvm_submit_vio(struct nvme_ns *ns,
 
 	memset(&c, 0, sizeof(c));
 	c.ph_rw.opcode = vio.opcode;
-	c.ph_rw.nsid = cpu_to_le32(ns->ns_id);
+	c.ph_rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c.ph_rw.control = cpu_to_le16(vio.control);
 	c.ph_rw.length = cpu_to_le16(vio.nppas);
 
@@ -728,7 +728,7 @@ static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = vcmd.opcode;
-	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.nsid = cpu_to_le32(ns->head->ns_id);
 	c.common.cdw2[0] = cpu_to_le32(vcmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(vcmd.cdw3);
 	/* cdw11-12 */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 913eaef6fc33..f68a89be654b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -194,25 +194,41 @@ struct nvme_subsystem {
 	struct list_head	entry;
 	struct mutex		lock;
 	struct list_head	ctrls;
+	struct list_head	nsheads;
 	struct kref		ref;
 	char			subnqn[NVMF_NQN_SIZE];
 };
 
+/*
+ * Anchor structure for namespaces.  There is one for each namespace in a
+ * NVMe subsystem that any of our controllers can see, and the namespace
+ * structure for each controller is chained of it.  For private namespaces
+ * there is a 1:1 relation to our namespace structures, that is ->list
+ * only ever has a single entry for private namespaces.
+ */
+struct nvme_ns_head {
+	struct list_head	list;
+	struct srcu_struct      srcu;
+	unsigned		ns_id;
+	u8			eui64[8];
+	u8			nguid[16];
+	uuid_t			uuid;
+	struct list_head	entry;
+	struct kref		ref;
+};
+
 struct nvme_ns {
 	struct list_head list;
 
 	struct nvme_ctrl *ctrl;
 	struct request_queue *queue;
 	struct gendisk *disk;
+	struct list_head siblings;
 	struct nvm_dev *ndev;
 	struct kref kref;
+	struct nvme_ns_head *head;
 	int instance;
 
-	u8 eui[8];
-	u8 nguid[16];
-	uuid_t uuid;
-
-	unsigned ns_id;
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
-- 
2.11.0
