Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
Date: Thu,  2 Nov 2017 21:30:33 +0300
Message-Id: <20171102183034.9320-5-hch@lst.de>
In-Reply-To: <20171102183034.9320-1-hch@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds native multipath support to the nvme driver.  For each
namespace we create only single block device node, which can be used
to access that namespace through any of the controllers that refer to it.
The gendisk for each controllers path to the name space still exists
inside the kernel, but is hidden from userspace.  The character device
nodes are still available on a per-controller basis.  A new link from
the sysfs directory for the subsystem allows to find all controllers
for a given subsystem.

Currently we will always send I/O to the first available path, this will
be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
ratified and implemented, at which point we will look at the ANA state
for each namespace.  Another possibility that was prototyped is to
use the path that is closes to the submitting NUMA code, which will be
mostly interesting for PCI, but might also be useful for RDMA or FC
transports in the future.  There is not plan to implement round robin
or I/O service time path selectors, as those are not scalable with
the performance rates provided by NVMe.

The multipath device will go away once all paths to it disappear,
any delay to keep it alive needs to be implemented at the controller
level.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/Kconfig     |   9 ++
 drivers/nvme/host/Makefile    |   1 +
 drivers/nvme/host/core.c      | 133 +++++++++++++++++++---
 drivers/nvme/host/multipath.c | 255 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  57 ++++++++++
 5 files changed, 440 insertions(+), 15 deletions(-)
 create mode 100644 drivers/nvme/host/multipath.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 46d6cb1e03bd..45886800a1df 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -13,6 +13,15 @@ config BLK_DEV_NVME
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme.
 
+config NVME_MULTIPATH
+	bool "NVMe multipath support"
+	depends on NVME_CORE
+	---help---
+	   This option enables support for multipath access to NVMe
+	   subsystems.  If this option is enabled only a single
+	   /dev/nvneXnY device will show up for each NVMe namespaces,
+	   even if it is accessible through multiple controllers.
+
 config NVME_FABRICS
 	tristate
 
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index cc0aacb4c8b4..b856f2f549cd 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 
 nvme-core-y				:= core.o
+nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
 nvme-y					+= pci.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a9ea44814ed..09f0e826b426 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -177,17 +177,22 @@ static inline bool nvme_req_needs_retry(struct request *req)
 		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
-	if (blk_queue_dying(req->q))
-		return false;
 	return true;
 }
 
 void nvme_complete_rq(struct request *req)
 {
 	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
-		nvme_req(req)->retries++;
-		blk_mq_requeue_request(req, true);
-		return;
+		if (nvme_req_needs_failover(req)) {
+			nvme_failover_req(req);
+			return;
+		}
+
+		if (!blk_queue_dying(req->q)) {
+			nvme_req(req)->retries++;
+			blk_mq_requeue_request(req, true);
+			return;
+		}
 	}
 
 	blk_mq_end_request(req, nvme_error_status(req));
@@ -278,7 +283,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		ctrl->state = new_state;
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
-
+	if (changed && ctrl->state == NVME_CTRL_LIVE)
+		nvme_kick_requeue_lists(ctrl);
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -288,6 +294,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
@@ -1051,11 +1058,33 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
-static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
+/*
+ * Issue ioctl requests on the first available path.  Note that unlike normal
+ * block layer requests we will not retry failed request on another controller.
+ */
+static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
+		struct nvme_ns_head **head, int *srcu_idx)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
+#ifdef CONFIG_NVME_MULTIPATH
+	if (disk->fops == &nvme_ns_head_ops) {
+		*head = disk->private_data;
+		*srcu_idx = srcu_read_lock(&(*head)->srcu);
+		return nvme_find_path(*head);
+	}
+#endif
+	*head = NULL;
+	*srcu_idx = -1;
+	return disk->private_data;
+}
 
+static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
+{
+	if (head)
+		srcu_read_unlock(&head->srcu, idx);
+}
+
+static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
+{
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
@@ -1078,10 +1107,31 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	}
 }
 
+static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	struct nvme_ns_head *head = NULL;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		ret = -EWOULDBLOCK;
+	else
+		ret = nvme_ns_ioctl(ns, cmd, arg);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	return ret;
+}
+
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
+#ifdef CONFIG_NVME_MULTIPATH
+	/* should never be called due to GENHD_FL_HIDDEN */
+	if (WARN_ON_ONCE(ns->head->disk))
+		return -ENXIO;
+#endif
 	if (!kref_get_unless_zero(&ns->kref))
 		return -ENXIO;
 	return 0;
@@ -1242,6 +1292,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	nvme_update_disk_info(disk, ns, id);
+#ifdef CONFIG_NVME_MULTIPATH
+	if (ns->head->disk)
+		nvme_update_disk_info(ns->head->disk, ns, id);
+#endif
 }
 
 static int nvme_revalidate_disk(struct gendisk *disk)
@@ -1301,8 +1355,10 @@ static char nvme_pr_type(enum pr_type type)
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_ns_head *head = NULL;
+	struct nvme_ns *ns;
 	struct nvme_command c;
+	int srcu_idx, ret;
 	u8 data[16] = { 0, };
 
 	put_unaligned_le64(key, &data[0]);
@@ -1310,10 +1366,16 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(ns->head->ns_id);
+	c.common.nsid = cpu_to_le32(head->ns_id);
 	c.common.cdw10[0] = cpu_to_le32(cdw10);
 
-	return nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		ret = -EWOULDBLOCK;
+	else
+		ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	return ret;
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
@@ -1403,6 +1465,32 @@ static const struct block_device_operations nvme_fops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+#ifdef CONFIG_NVME_MULTIPATH
+static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+
+	if (!kref_get_unless_zero(&head->ref))
+		return -ENXIO;
+	return 0;
+}
+
+static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
+{
+	nvme_put_ns_head(disk->private_data);
+}
+
+const struct block_device_operations nvme_ns_head_ops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_ns_head_open,
+	.release	= nvme_ns_head_release,
+	.ioctl		= nvme_ioctl,
+	.compat_ioctl	= nvme_ioctl,
+	.getgeo		= nvme_getgeo,
+	.pr_ops		= &nvme_pr_ops,
+};
+#endif /* CONFIG_NVME_MULTIPATH */
+
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 {
 	unsigned long timeout =
@@ -2468,6 +2556,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_cleanup_srcu;
 	}
 
+	ret = nvme_mpath_alloc_disk(ctrl, head);
+	if (ret)
+		goto out_cleanup_srcu;
+
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 	return head;
 out_cleanup_srcu:
@@ -2580,7 +2672,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
-	int node = dev_to_node(ctrl->dev);
+	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
 	bool new = true;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
@@ -2611,7 +2703,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_init_ns_head(ns, nsid, id, &new))
 		goto out_free_id;
 	
-	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
+#ifdef CONFIG_NVME_MULTIPATH
+	if (ns->head->disk) {
+		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
+				ctrl->cntlid, ns->head->instance);
+		flags = GENHD_FL_HIDDEN;
+	} else
+#endif
+		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
@@ -2627,7 +2726,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
-	disk->flags = GENHD_FL_EXT_DEVT;
+	disk->flags = flags;
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
@@ -2649,6 +2748,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
+
+	if (new)
+		nvme_mpath_add_disk(ns->head);
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2681,6 +2783,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
+	nvme_mpath_clear_current_path(ns);
 	if (head)
 		list_del_rcu(&ns->siblings);
 	mutex_unlock(&ns->ctrl->subsys->lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
new file mode 100644
index 000000000000..062754ebebfd
--- /dev/null
+++ b/drivers/nvme/host/multipath.c
@@ -0,0 +1,255 @@
+/*
+ * Copyright (c) 2017 Christoph Hellwig.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/moduleparam.h>
+#include "nvme.h"
+
+static bool multipath = true;
+module_param(multipath, bool, 0644);
+MODULE_PARM_DESC(multipath,
+	"turn on native support for multiple controllers per subsystem");
+
+void nvme_failover_req(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	blk_steal_bios(&ns->head->requeue_list, req);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	blk_mq_end_request(req, 0);
+
+	nvme_reset_ctrl(ns->ctrl);
+	kblockd_schedule_work(&ns->head->requeue_work);
+}
+
+bool nvme_req_needs_failover(struct request *req)
+{
+	if (!(req->cmd_flags & REQ_NVME_MPATH))
+		return false;
+
+	switch (nvme_req(req)->status & 0x7ff) {
+	/*
+	 * Generic command status:
+	 */
+	case NVME_SC_INVALID_OPCODE:
+	case NVME_SC_INVALID_FIELD:
+	case NVME_SC_INVALID_NS:
+	case NVME_SC_LBA_RANGE:
+	case NVME_SC_CAP_EXCEEDED:
+	case NVME_SC_RESERVATION_CONFLICT:
+		return false;
+
+	/*
+	 * I/O command set specific error.  Unfortunately these values are
+	 * reused for fabrics commands, but those should never get here.
+	 */
+	case NVME_SC_BAD_ATTRIBUTES:
+	case NVME_SC_INVALID_PI:
+	case NVME_SC_READ_ONLY:
+	case NVME_SC_ONCS_NOT_SUPPORTED:
+		WARN_ON_ONCE(nvme_req(req)->cmd->common.opcode ==
+			nvme_fabrics_command);
+		return false;
+
+	/*
+	 * Media and Data Integrity Errors:
+	 */
+	case NVME_SC_WRITE_FAULT:
+	case NVME_SC_READ_ERROR:
+	case NVME_SC_GUARD_CHECK:
+	case NVME_SC_APPTAG_CHECK:
+	case NVME_SC_REFTAG_CHECK:
+	case NVME_SC_COMPARE_FAILED:
+	case NVME_SC_ACCESS_DENIED:
+	case NVME_SC_UNWRITTEN_BLOCK:
+		return false;
+	}
+
+	/* Everything else could be a path failure, so should be retried */
+	return true;
+}
+
+void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (ns->head->disk)
+			kblockd_schedule_work(&ns->head->requeue_work);
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+
+static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (ns->ctrl->state == NVME_CTRL_LIVE) {
+			rcu_assign_pointer(head->current_path, ns);
+			return ns;
+		}
+	}
+
+	return NULL;
+}
+
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
+
+	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
+		ns = __nvme_find_path(head);
+	return ns;
+}
+
+static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
+		struct bio *bio)
+{
+	struct nvme_ns_head *head = q->queuedata;
+	struct device *dev = disk_to_dev(head->disk);
+	struct nvme_ns *ns;
+	blk_qc_t ret = BLK_QC_T_NONE;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (likely(ns)) {
+		bio->bi_disk = ns->disk;
+		bio->bi_opf |= REQ_NVME_MPATH;
+		ret = direct_make_request(bio);
+	} else if (!list_empty_careful(&head->list)) {
+		dev_warn_ratelimited(dev, "no path available - requeing I/O\n");
+
+		spin_lock_irq(&head->requeue_lock);
+		bio_list_add(&head->requeue_list, bio);
+		spin_unlock_irq(&head->requeue_lock);
+	} else {
+		dev_warn_ratelimited(dev, "no path - failing I/O\n");
+
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+	}
+
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
+static bool nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
+{
+	struct nvme_ns_head *head = q->queuedata;
+	struct nvme_ns *ns;
+	bool found = false;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = srcu_dereference(head->current_path, &head->srcu);
+	if (likely(ns && ns->ctrl->state == NVME_CTRL_LIVE))
+		found = ns->queue->poll_fn(q, qc);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return found;
+}
+
+static void nvme_requeue_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head =
+		container_of(work, struct nvme_ns_head, requeue_work);
+	struct bio *bio, *next;
+
+	spin_lock_irq(&head->requeue_lock);
+	next = bio_list_get(&head->requeue_list);
+	spin_unlock_irq(&head->requeue_lock);
+
+	while ((bio = next) != NULL) {
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+
+		/*
+		 * Reset disk to the mpath node and resubmit to select a new
+		 * path.
+		 */
+		bio->bi_disk = head->disk;
+		generic_make_request(bio);
+	}
+}
+
+int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
+{
+	struct request_queue *q;
+	bool vwc = false;
+
+	bio_list_init(&head->requeue_list);
+	spin_lock_init(&head->requeue_lock);
+	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+
+	/*
+	 * Add a multipath node if the subsystems supports multiple controllers.
+	 * We also do this for private namespaces as the namespace sharing data could
+	 * change after a rescan.
+	 */
+	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
+		return 0;
+
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	if (!q)
+		goto out;
+	q->queuedata = head;
+	blk_queue_make_request(q, nvme_ns_head_make_request);
+	q->poll_fn = nvme_ns_head_poll;
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
+	/* set to a default value for 512 until disk is validated */
+	blk_queue_logical_block_size(q, 512);
+
+	/* we need to propagate up the VMC settings */
+	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
+		vwc = true;
+	blk_queue_write_cache(q, vwc, vwc);
+
+	head->disk = alloc_disk(0);
+	if (!head->disk)
+		goto out_cleanup_queue;
+	head->disk->fops = &nvme_ns_head_ops;
+	head->disk->private_data = head;
+	head->disk->queue = q;
+	head->disk->flags = GENHD_FL_EXT_DEVT;
+	sprintf(head->disk->disk_name, "nvme%dn%d",
+			ctrl->subsys->instance, head->instance);
+	return 0;
+
+out_cleanup_queue:
+	blk_cleanup_queue(q);
+out:
+	return -ENOMEM;
+}
+
+void nvme_mpath_add_disk(struct nvme_ns_head *head)
+{
+	if (!head->disk)
+		return;
+	device_add_disk(&head->subsys->dev, head->disk);
+}
+
+void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+{
+	if (!head->disk)
+		return;
+	del_gendisk(head->disk);
+	blk_set_queue_dying(head->disk->queue);
+	/* make sure all pending bios are cleaned up */
+	kblockd_schedule_work(&head->requeue_work);
+	flush_work(&head->requeue_work);
+	blk_cleanup_queue(head->disk->queue);
+	put_disk(head->disk);
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 73179a7749f6..d98064d4ed76 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -95,6 +95,11 @@ struct nvme_request {
 	u16			status;
 };
 
+/*
+ * Mark a bio as coming in through the mpath node.
+ */
+#define REQ_NVME_MPATH		REQ_DRV
+
 enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 };
@@ -234,6 +239,13 @@ struct nvme_ns_ids {
  * only ever has a single entry for private namespaces.
  */
 struct nvme_ns_head {
+#ifdef CONFIG_NVME_MULTIPATH
+	struct gendisk		*disk;
+	struct nvme_ns __rcu	*current_path;
+	struct bio_list		requeue_list;
+	spinlock_t		requeue_lock;
+	struct work_struct	requeue_work;
+#endif
 	struct list_head	list;
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
@@ -384,6 +396,51 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
+extern const struct block_device_operations nvme_ns_head_ops;
+
+#ifdef CONFIG_NVME_MULTIPATH
+void nvme_failover_req(struct request *req);
+bool nvme_req_needs_failover(struct request *req);
+void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
+int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
+void nvme_mpath_add_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+
+static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
+{
+	struct nvme_ns_head *head = ns->head;
+
+	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
+		rcu_assign_pointer(head->current_path, NULL);
+}
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+#else
+static inline void nvme_failover_req(struct request *req)
+{
+}
+static inline bool nvme_req_needs_failover(struct request *req)
+{
+	return false;
+}
+static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
+{
+}
+static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
+		struct nvme_ns_head *head)
+{
+	return 0;
+}
+static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
+{
+}
+static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+{
+}
+static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
+{
+}
+#endif /* CONFIG_NVME_MULTIPATH */
+
 #ifdef CONFIG_NVM
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
-- 
2.14.2
