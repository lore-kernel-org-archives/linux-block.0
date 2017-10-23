Return-Path: <BATV+e774f35f755d74bf45df+5174+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
Date: Mon, 23 Oct 2017 16:51:25 +0200
Message-Id: <20171023145126.2471-17-hch@lst.de>
In-Reply-To: <20171023145126.2471-1-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
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
 drivers/nvme/host/core.c | 398 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  15 +-
 drivers/nvme/host/pci.c  |   2 +
 3 files changed, 355 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1db26729bd89..22c06cd3bef0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -102,6 +102,20 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static void nvme_failover_req(struct request *req)
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
 static blk_status_t nvme_error_status(struct request *req)
 {
 	switch (nvme_req(req)->status & 0x7ff) {
@@ -129,6 +143,53 @@ static blk_status_t nvme_error_status(struct request *req)
 	}
 }
 
+static bool nvme_req_needs_failover(struct request *req)
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
 static inline bool nvme_req_needs_retry(struct request *req)
 {
 	if (blk_noretry_request(req))
@@ -143,6 +204,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
 void nvme_complete_rq(struct request *req)
 {
 	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
+		if (nvme_req_needs_failover(req)) {
+			nvme_failover_req(req);
+			return;
+		}
+
 		nvme_req(req)->retries++;
 		blk_mq_requeue_request(req, true);
 		return;
@@ -171,6 +237,18 @@ void nvme_cancel_request(struct request *req, void *data, bool reserved)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
 
+static void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (ns->head)
+			kblockd_schedule_work(&ns->head->requeue_work);
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -238,9 +316,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	if (changed)
 		ctrl->state = new_state;
-
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
+	if (changed && ctrl->state == NVME_CTRL_LIVE)
+		nvme_kick_requeue_lists(ctrl);
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -250,6 +329,15 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	del_gendisk(head->disk);
+	blk_set_queue_dying(head->disk->queue);
+	/* make sure all pending bios are cleaned up */
+	kblockd_schedule_work(&head->requeue_work);
+	flush_work(&head->requeue_work);
+	blk_cleanup_queue(head->disk->queue);
+	put_disk(head->disk);
+	ida_simple_remove(&head->subsys->ns_ida, head->instance);
+
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
 	kfree(head);
@@ -266,9 +354,7 @@ static void nvme_free_ns(struct kref *kref)
 
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
-
 	put_disk(ns->disk);
-	ida_simple_remove(&ns->ctrl->ns_ida, ns->instance);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
@@ -1013,11 +1099,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
-static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
+static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
+		unsigned long arg)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
@@ -1040,18 +1124,10 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	}
 }
 
+/* should never be called due to GENHD_FL_HIDDEN */
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-
-	if (!kref_get_unless_zero(&ns->kref))
-		return -ENXIO;
-	return 0;
-}
-
-static void nvme_release(struct gendisk *disk, fmode_t mode)
-{
-	nvme_put_ns(disk->private_data);
+	return WARN_ON_ONCE(-ENXIO);
 }
 
 static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
@@ -1081,8 +1157,10 @@ static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
 	if (blk_get_integrity(disk) &&
 	    (ns->pi_type != pi_type || ns->ms != old_ms ||
 	     bs != queue_logical_block_size(disk->queue) ||
-	     (ns->ms && ns->ext)))
+	     (ns->ms && ns->ext))) {
 		blk_integrity_unregister(disk);
+		blk_integrity_unregister(ns->head->disk);
+	}
 
 	ns->pi_type = pi_type;
 }
@@ -1110,7 +1188,9 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 	}
 	integrity.tuple_size = ns->ms;
 	blk_integrity_register(ns->disk, &integrity);
+	blk_integrity_register(ns->head->disk, &integrity);
 	blk_queue_max_integrity_segments(ns->queue, 1);
+	blk_queue_max_integrity_segments(ns->head->disk->queue, 1);
 }
 #else
 static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
@@ -1128,7 +1208,7 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
+static void nvme_config_discard(struct nvme_ns *ns, struct request_queue *queue)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
@@ -1139,18 +1219,18 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	if (ctrl->nr_streams && ns->sws && ns->sgs) {
 		unsigned int sz = logical_block_size * ns->sws * ns->sgs;
 
-		ns->queue->limits.discard_alignment = sz;
-		ns->queue->limits.discard_granularity = sz;
+		queue->limits.discard_alignment = sz;
+		queue->limits.discard_granularity = sz;
 	} else {
 		ns->queue->limits.discard_alignment = logical_block_size;
 		ns->queue->limits.discard_granularity = logical_block_size;
 	}
-	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
-	blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
-	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
+	blk_queue_max_discard_sectors(queue, UINT_MAX);
+	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, queue);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
-		blk_queue_max_write_zeroes_sectors(ns->queue, UINT_MAX);
+		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1207,17 +1287,25 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
 		nvme_prep_integrity(disk, id, bs);
 	blk_queue_logical_block_size(ns->queue, bs);
+	blk_queue_logical_block_size(ns->head->disk->queue, bs);
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
 		nvme_init_integrity(ns);
-	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
+	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk)) {
 		set_capacity(disk, 0);
-	else
+		if (ns->head)
+			set_capacity(ns->head->disk, 0);
+	} else {
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
+		if (ns->head)
+			set_capacity(ns->head->disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
+	}
 
-	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ns);
+	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
+		nvme_config_discard(ns, ns->queue);
+		nvme_config_discard(ns, ns->head->disk->queue);
+	}
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
@@ -1255,6 +1343,29 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	return ret;
 }
 
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
+static inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
+
+	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
+		ns = __nvme_find_path(head);
+	return ns;
+}
+
 static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -1278,8 +1389,10 @@ static char nvme_pr_type(enum pr_type type)
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	struct nvme_ns *ns;
 	struct nvme_command c;
+	int srcu_idx, ret;
 	u8 data[16] = { 0, };
 
 	put_unaligned_le64(key, &data[0]);
@@ -1287,10 +1400,17 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(ns->head->ns_id);
+	c.common.nsid = cpu_to_le32(head->ns_id);
 	c.common.cdw10[0] = cpu_to_le32(cdw10);
 
-	return nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (likely(ns))
+		ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+	else
+		ret = -EWOULDBLOCK;
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
@@ -1369,15 +1489,16 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
 
+/*
+ * While we don't expose the per-controller devices to userspace we still
+ * need valid file operations for them, for one because the block layer
+ * expects to use the owner field for module refcounting, and also because
+ * we call revalidate_disk internally.
+ */
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
-	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
 	.open		= nvme_open,
-	.release	= nvme_release,
-	.getgeo		= nvme_getgeo,
 	.revalidate_disk= nvme_revalidate_disk,
-	.pr_ops		= &nvme_pr_ops,
 };
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
@@ -1774,6 +1895,7 @@ static void nvme_destroy_subsystem(struct kref *ref)
 	list_del(&subsys->entry);
 	mutex_unlock(&nvme_subsystems_lock);
 
+	ida_destroy(&subsys->ns_ida);
 	device_del(&subsys->dev);
 	put_device(&subsys->dev);
 }
@@ -1803,7 +1925,7 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
-	int ret;
+	int ret = -ENOMEM;
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
@@ -1854,12 +1976,21 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 				"failed to register subsystem device.\n");
 			goto out_unlock;
 		}
+		ida_init(&subsys->ns_ida);
 		list_add_tail(&subsys->entry, &nvme_subsystems);
 	}
 
 	ctrl->subsys = subsys;
 	mutex_unlock(&nvme_subsystems_lock);
 
+	if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
+			dev_name(ctrl->device))) {
+		dev_err(ctrl->device,
+			"failed to create sysfs link from subsystem.\n");
+		/* the transport driver will eventually put the subsystem */
+		return -EINVAL;
+	}
+
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&subsys->lock);
@@ -2375,6 +2506,121 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL,
 };
 
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
+/*
+ * Issue the ioctl on the first available path.  Note that unlike normal block
+ * layer requests we will not retry failed request on another controller.
+ */
+static int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (likely(ns))
+		ret = nvme_ns_ioctl(ns, cmd, arg);
+	else
+		ret = -EWOULDBLOCK;
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
+static const struct block_device_operations nvme_ns_head_ops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_ns_head_open,
+	.release	= nvme_ns_head_release,
+	.ioctl		= nvme_ns_head_ioctl,
+	.compat_ioctl	= nvme_ns_head_ioctl,
+	.getgeo		= nvme_getgeo,
+	.pr_ops		= &nvme_pr_ops,
+};
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
 static struct nvme_ns_head *__nvme_find_ns_head(struct nvme_subsystem *subsys,
 		unsigned nsid)
 {
@@ -2410,15 +2656,23 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid, struct nvme_id_ns *id)
 {
 	struct nvme_ns_head *head;
+	struct request_queue *q;
 	int ret = -ENOMEM;
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
 	if (!head)
 		goto out;
-
+	ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto out_free_head;
+	head->instance = ret;
 	INIT_LIST_HEAD(&head->list);
 	head->ns_id = nsid;
+	bio_list_init(&head->requeue_list);
+	spin_lock_init(&head->requeue_lock);
+	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	init_srcu_struct(&head->srcu);
+	head->subsys = ctrl->subsys;
 	kref_init(&head->ref);
 
 	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
@@ -2427,20 +2681,46 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	if (ret) {
 		dev_err(ctrl->device,
 			"duplicate IDs for nsid %d\n", nsid);
-		goto out_free_head;
+		goto out_release_instance;
 	}
 
+	ret = -ENOMEM;
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	if (!q)
+		goto out_free_head;
+	q->queuedata = head;
+	blk_queue_make_request(q, nvme_ns_head_make_request);
+	q->poll_fn = nvme_ns_head_poll;
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
+	/* set to a default value for 512 until disk is validated */
+	blk_queue_logical_block_size(q, 512);
+	nvme_set_queue_limits(ctrl, q);
+
+	head->disk = alloc_disk(0);
+	if (!head->disk)
+		goto out_cleanup_queue;
+	head->disk->fops = &nvme_ns_head_ops;
+	head->disk->private_data = head;
+	head->disk->queue = q;
+	head->disk->flags = GENHD_FL_EXT_DEVT;
+	sprintf(head->disk->disk_name, "nvme%dn%d",
+			ctrl->subsys->instance, nsid);
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 	return head;
+
+out_cleanup_queue:
+	blk_cleanup_queue(q);
 out_free_head:
 	cleanup_srcu_struct(&head->srcu);
 	kfree(head);
+out_release_instance:
+	ida_simple_remove(&ctrl->subsys->ns_ida, head->instance);
 out:
 	return ERR_PTR(ret);
 }
 
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
-		struct nvme_id_ns *id)
+		struct nvme_id_ns *id, bool *new)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	bool is_shared = id->nmic & (1 << 0);
@@ -2456,6 +2736,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
+
+		*new = true;
 	} else {
 		struct nvme_ns_ids ids;
 
@@ -2467,6 +2749,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = -EINVAL;
 			goto out_unlock;
 		}
+
+		*new = false;
 	}
 
 	list_add_tail(&ns->siblings, &head->list);
@@ -2537,18 +2821,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev);
+	bool new = true;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
 		return;
 
-	ns->instance = ida_simple_get(&ctrl->ns_ida, 1, 0, GFP_KERNEL);
-	if (ns->instance < 0)
-		goto out_free_ns;
-
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue))
-		goto out_release_instance;
+		goto out_free_ns;
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
@@ -2560,8 +2841,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_set_queue_limits(ctrl, ns->queue);
 	nvme_setup_streams_ns(ctrl, ns);
 
-	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
-
 	id = nvme_identify_ns(ctrl, nsid);
 	if (!id)
 		goto out_free_queue;
@@ -2569,9 +2848,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	if (nvme_init_ns_head(ns, nsid, id))
+	if (nvme_init_ns_head(ns, nsid, id, &new))
 		goto out_free_id;
 
+	sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
+			ctrl->cntlid, ns->head->instance);
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
@@ -2586,7 +2867,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
-	disk->flags = GENHD_FL_EXT_DEVT;
+	disk->flags = GENHD_FL_HIDDEN;
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
@@ -2608,6 +2889,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
+
+	if (new)
+		device_add_disk(&ns->head->subsys->dev, ns->head->disk);
+
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2617,8 +2902,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(id);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
- out_release_instance:
-	ida_simple_remove(&ctrl->ns_ida, ns->instance);
  out_free_ns:
 	kfree(ns);
 }
@@ -2633,8 +2916,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
@@ -2642,8 +2923,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
-	if (head)
+	if (head) {
+		if (head->current_path == ns)
+			rcu_assign_pointer(head->current_path, NULL);
 		list_del_rcu(&ns->siblings);
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	mutex_lock(&ns->ctrl->namespaces_mutex);
@@ -2948,12 +3232,12 @@ static void nvme_free_ctrl(struct device *dev)
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
-	ida_destroy(&ctrl->ns_ida);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
 		list_del(&ctrl->subsys_entry);
 		mutex_unlock(&subsys->lock);
+		sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
 	}
 
 	ctrl->ops->free_ctrl(ctrl);
@@ -3006,8 +3290,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_free_name;
 
-	ida_init(&ctrl->ns_ida);
-
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
 	 * be visible to userspace unless the device actually supports APST.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 849413def126..87dd77e8fbdf 100644
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
@@ -136,7 +141,6 @@ struct nvme_ctrl {
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct cdev cdev;
-	struct ida ns_ida;
 	struct work_struct reset_work;
 
 	struct nvme_subsystem *subsys;
@@ -213,6 +217,7 @@ struct nvme_subsystem {
 	char			model[40];
 	char			firmware_rev[8];
 	u16			vendor_id;
+	struct ida		ns_ida;
 };
 
 /*
@@ -232,12 +237,19 @@ struct nvme_ns_ids {
  * only ever has a single entry for private namespaces.
  */
 struct nvme_ns_head {
+	struct nvme_ns __rcu	*current_path;
+	struct gendisk		*disk;
 	struct list_head	list;
 	struct srcu_struct      srcu;
+	struct nvme_subsystem	*subsys;
+	struct bio_list		requeue_list;
+	spinlock_t		requeue_lock;
+	struct work_struct	requeue_work;
 	unsigned		ns_id;
 	struct nvme_ns_ids	ids;
 	struct list_head	entry;
 	struct kref		ref;
+	int			instance;
 };
 
 struct nvme_ns {
@@ -250,7 +262,6 @@ struct nvme_ns {
 	struct nvm_dev *ndev;
 	struct kref kref;
 	struct nvme_ns_head *head;
-	int instance;
 
 	int lba_shift;
 	u16 ms;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7735571ffc9a..bbece5edabff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1050,6 +1050,8 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
+	printk_ratelimited("%s: called\n", __func__);
+
 	return __nvme_poll(nvmeq, tag);
 }
 
-- 
2.14.2
