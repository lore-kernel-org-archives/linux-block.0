Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 15/17] nvme: track shared namespaces
Date: Wed, 18 Oct 2017 18:52:56 +0200
Message-Id: <20171018165258.23212-16-hch@lst.de>
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Introduce a new struct nvme_ns_head that holds information about an actual
namespace, unlike struct nvme_ns, which only holds the per-controller
namespace information.  For private namespaces there is a 1:1 relation of
the two, but for shared namespaces this lets us discover all the paths to
it.  For now only the identifiers are moved to the new structure, but most
of the information in struct nvme_ns should eventually move over.

To allow lockless path lookup the list of nvme_ns structures per
nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
structure through call_srcu.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c     | 192 +++++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/lightnvm.c |  14 ++--
 drivers/nvme/host/nvme.h     |  21 ++++-
 3 files changed, 192 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 30a60643881b..d294792d8584 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -244,10 +244,28 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
+static void nvme_free_ns_head(struct kref *ref)
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
+	kref_put(&head->ref, nvme_free_ns_head);
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
 
@@ -388,7 +406,7 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 {
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->common.opcode = nvme_cmd_flush;
-	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
@@ -419,7 +437,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
-	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->dsm.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->dsm.nr = cpu_to_le32(segments - 1);
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
@@ -458,7 +476,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
-	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
@@ -939,7 +957,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
 	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->ns_id);
+	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks);
 	c.rw.control = cpu_to_le16(io.control);
@@ -1004,7 +1022,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
-		return ns->ns_id;
+		return ns->head->ns_id;
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ns->ctrl, NULL, (void __user *)arg);
 	case NVME_IOCTL_IO_CMD:
@@ -1155,6 +1173,13 @@ static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 	}
 }
 
+static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
+{
+	return !uuid_is_null(&ids->uuid) ||
+		memchr_inv(ids->nguid, 0, sizeof(ids->nguid)) ||
+		memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1210,7 +1235,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return -ENODEV;
 	}
 
-	id = nvme_identify_ns(ctrl, ns->ns_id);
+	id = nvme_identify_ns(ctrl, ns->head->ns_id);
 	if (!id)
 		return -ENODEV;
 
@@ -1219,10 +1244,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, &ids);
-	if (!nvme_ns_ids_equal(&ns->ids, &ids)) {
+	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
+	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
 		dev_err(ctrl->device,
-			"identifiers changed for nsid %d\n", ns->ns_id);
+			"identifiers changed for nsid %d\n", ns->head->ns_id);
 		ret = -ENODEV;
 	}
 
@@ -1263,7 +1288,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.nsid = cpu_to_le32(ns->head->ns_id);
 	c.common.cdw10[0] = cpu_to_le32(cdw10);
 
 	return nvme_submit_sync_cmd(ns->queue, &c, data, 16);
@@ -1773,6 +1798,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	if (!subsys)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&subsys->ctrls);
+	INIT_LIST_HEAD(&subsys->nsheads);
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
@@ -2096,7 +2122,7 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ns_ids *ids = &ns->ids;
+	struct nvme_ns_ids *ids = &ns->head->ids;
 	struct nvme_subsystem *subsys = ns->ctrl->subsys;
 	int serial_len = sizeof(subsys->serial);
 	int model_len = sizeof(subsys->model);
@@ -2119,7 +2145,7 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
 		serial_len, subsys->serial, model_len, subsys->model,
-		ns->ns_id);
+		ns->head->ns_id);
 }
 static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 
@@ -2127,7 +2153,7 @@ static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%pU\n", ns->ids.nguid);
+	return sprintf(buf, "%pU\n", ns->head->ids.nguid);
 }
 static DEVICE_ATTR(nguid, S_IRUGO, nguid_show, NULL);
 
@@ -2135,7 +2161,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ns_ids *ids = &ns->ids;
+	struct nvme_ns_ids *ids = &ns->head->ids;
 
 	/* For backward compatibility expose the NGUID to userspace if
 	 * we have no UUID set
@@ -2153,7 +2179,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->ids.eui64);
+	return sprintf(buf, "%8phd\n", ns->head->ids.eui64);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
@@ -2161,7 +2187,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%d\n", ns->ns_id);
+	return sprintf(buf, "%d\n", ns->head->ns_id);
 }
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 
@@ -2179,7 +2205,7 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	struct nvme_ns_ids *ids = &ns->ids;
+	struct nvme_ns_ids *ids = &ns->head->ids;
 
 	if (a == &dev_attr_uuid.attr) {
 		if (uuid_is_null(&ids->uuid) ||
@@ -2331,12 +2357,114 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
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
+		if (nvme_ns_ids_valid(&new->ids) &&
+		    nvme_ns_ids_equal(&new->ids, &h->ids))
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
+	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
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
+		struct nvme_ns_ids ids;
+
+		nvme_report_ns_ids(ctrl, nsid, id, &ids);
+		if (!nvme_ns_ids_equal(&head->ids, &ids)) {
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
@@ -2345,13 +2473,13 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->ns_id == nsid) {
+		if (ns->head->ns_id == nsid) {
 			if (!kref_get_unless_zero(&ns->kref))
 				continue;
 			ret = ns;
 			break;
 		}
-		if (ns->ns_id > nsid)
+		if (ns->head->ns_id > nsid)
 			break;
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
@@ -2366,7 +2494,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	if (!ctrl->nr_streams)
 		return 0;
 
-	ret = nvme_get_stream_params(ctrl, &s, ns->ns_id);
+	ret = nvme_get_stream_params(ctrl, &s, ns->head->ns_id);
 	if (ret)
 		return ret;
 
@@ -2408,7 +2536,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->ctrl = ctrl;
 
 	kref_init(&ns->kref);
-	ns->ns_id = nsid;
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
@@ -2424,18 +2551,19 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	nvme_report_ns_ids(ctrl, ns->ns_id, id, &ns->ids);
+	if (nvme_init_ns_head(ns, nsid, id))
+		goto out_free_id;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
-			goto out_free_id;
+			goto out_unlink_ns;
 		}
 	}
 
 	disk = alloc_disk_node(0, node);
 	if (!disk)
-		goto out_free_id;
+		goto out_unlink_ns;
 
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
@@ -2463,6 +2591,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -2475,6 +2607,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	struct nvme_ns_head *head = ns->head;
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -2489,10 +2623,16 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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
 
@@ -2515,7 +2655,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->ns_id > nsid)
+		if (ns->head->ns_id > nsid)
 			nvme_ns_remove(ns);
 	}
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 1f79e3f141e6..44e46276319c 100644
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
index 650e38d21fd2..487641ab2ef2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -201,6 +201,7 @@ struct nvme_subsystem {
 	struct list_head	entry;
 	struct mutex		lock;
 	struct list_head	ctrls;
+	struct list_head	nsheads;
 	char			subnqn[NVMF_NQN_SIZE];
 	char			serial[20];
 	char			model[40];
@@ -217,18 +218,34 @@ struct nvme_ns_ids {
 	uuid_t	uuid;
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
+	struct nvme_ns_ids	ids;
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
 
-	unsigned ns_id;
-	struct nvme_ns_ids ids;
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
-- 
2.14.1
