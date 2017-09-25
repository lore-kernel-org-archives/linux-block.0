Return-Path: <BATV+21c581e1042956a70a85+5146+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Date: Mon, 25 Sep 2017 15:40:30 +0200
Message-Id: <20170925134031.10548-9-hch@lst.de>
In-Reply-To: <20170925134031.10548-1-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds initial multipath support to the nvme driver.  For each
namespace we create a new block device node, which can be used to access
that namespace through any of the controllers that refer to it.

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

The new block devices nodes for multipath access will show up as

	/dev/nvm-subXnZ

where X is the local instance number of the subsystems, and Z is the index
for the namespace.

To get persistent devices names the following lines can be added to
/lib/udev/rules.d/60-persistent-storage.rules:

---------------------------------- snip ----------------------------------
KERNEL=="nvm-sub*[0-9]n*[0-9]", ATTR{wwid}=="?*", SYMLINK+="disk/by-id/nvme-sub-$attr{wwid}"
KERNEL=="nvm-sub*[0-9]n*[0-9]p*[0-9]", ENV{DEVTYPE}=="partition", ATTRS{wwid}=="?*", SYMLINK+="disk/by-id/nvme-sub-$attr{wwid}-part%n"
KERNEL=="nvm-sub*[0-9]n*[0-9]", ENV{DEVTYPE}=="disk", ATTRS{wwid}=="?*", ENV{ID_WWN}="$attr{wwid}"
---------------------------------- snip ----------------------------------

Note that these create the new persistent names.  Overriding the existing
nvme ones would be nicer, but while that works for the first path, the
normal rule will override it again for each subsequent path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 277 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  11 ++
 2 files changed, 269 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c1be5a0a69b1..faef0241c6b5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -72,6 +72,7 @@ struct workqueue_struct *nvme_wq;
 EXPORT_SYMBOL_GPL(nvme_wq);
 
 static LIST_HEAD(nvme_subsystems);
+static DEFINE_IDA(nvme_subsystems_ida);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static LIST_HEAD(nvme_ctrl_list);
@@ -104,6 +105,20 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
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
@@ -131,6 +146,53 @@ static blk_status_t nvme_error_status(struct request *req)
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
@@ -145,6 +207,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
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
@@ -173,6 +240,18 @@ void nvme_cancel_request(struct request *req, void *data, bool reserved)
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
@@ -240,9 +319,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	if (changed)
 		ctrl->state = new_state;
-
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
+	if (changed && ctrl->state == NVME_CTRL_LIVE)
+		nvme_kick_requeue_lists(ctrl);
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -252,6 +332,14 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	del_gendisk(head->disk);
+	blk_set_queue_dying(head->disk->queue);
+	/* make sure all pending bios are cleaned up */
+	kblockd_schedule_work(&head->requeue_work);
+	flush_work(&head->requeue_work);
+	blk_cleanup_queue(head->disk->queue);
+	put_disk(head->disk);
+
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
 	kfree(head);
@@ -1123,8 +1211,10 @@ static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
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
@@ -1152,7 +1242,9 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 	}
 	integrity.tuple_size = ns->ms;
 	blk_integrity_register(ns->disk, &integrity);
+	blk_integrity_register(ns->head->disk, &integrity);
 	blk_queue_max_integrity_segments(ns->queue, 1);
+	blk_queue_max_integrity_segments(ns->head->disk->queue, 1);
 }
 #else
 static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
@@ -1170,7 +1262,7 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
+static void nvme_config_discard(struct nvme_ns *ns, struct request_queue *queue)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
@@ -1181,18 +1273,18 @@ static void nvme_config_discard(struct nvme_ns *ns)
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
@@ -1249,17 +1341,25 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
 
@@ -1796,6 +1896,12 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	memset(subsys->subnqn + off, 0, sizeof(subsys->subnqn) - off);
 }
 
+static void __nvme_free_subsystem(struct nvme_subsystem *subsys)
+{
+	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	kfree(subsys);
+}
+
 static void nvme_free_subsystem(struct kref *ref)
 {
 	struct nvme_subsystem *subsys =
@@ -1804,8 +1910,7 @@ static void nvme_free_subsystem(struct kref *ref)
 	mutex_lock(&nvme_subsystems_lock);
 	list_del(&subsys->entry);
 	mutex_unlock(&nvme_subsystems_lock);
-
-	kfree(subsys);
+	__nvme_free_subsystem(subsys);
 }
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys)
@@ -1833,10 +1938,16 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
+	int ret;
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
+	subsys->instance = ret = ida_simple_get(&nvme_subsystems_ida, 0, 0,
+			GFP_KERNEL);
+	if (ret < 0)
+		goto out_free_subsys;
+
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->nsheads);
 	kref_init(&subsys->ref);
@@ -1854,7 +1965,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		 * Verify that the subsystem actually supports multiple
 		 * controllers, else bail out.
 		 */
-		kfree(subsys);
+		__nvme_free_subsystem(subsys);
 		if (!(id->cmic & (1 << 1))) {
 			dev_err(ctrl->device,
 				"ignoring ctrl due to duplicate subnqn (%s).\n",
@@ -1876,6 +1987,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	mutex_unlock(&subsys->lock);
 
 	return 0;
+out_free_subsys:
+	kfree(subsys);
+	return ret;
 }
 
 /*
@@ -2403,6 +2517,80 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL,
 };
 
+static struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
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
+static blk_qc_t nvme_make_request(struct request_queue *q, struct bio *bio)
+{
+	struct nvme_ns_head *head = q->queuedata;
+	struct device *dev = disk_to_dev(head->disk);
+	struct nvme_ns *ns;
+	blk_qc_t ret = BLK_QC_T_NONE;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = srcu_dereference(head->current_path, &head->srcu);
+	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
+		ns = nvme_find_path(head);
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
+static const struct block_device_operations nvme_subsys_ops = {
+	.owner		= THIS_MODULE,
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
@@ -2438,6 +2626,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid, struct nvme_id_ns *id)
 {
 	struct nvme_ns_head *head;
+	struct request_queue *q;
 	int ret = -ENOMEM;
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
@@ -2446,6 +2635,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 
 	INIT_LIST_HEAD(&head->list);
 	head->ns_id = nsid;
+	bio_list_init(&head->requeue_list);
+	spin_lock_init(&head->requeue_lock);
+	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	init_srcu_struct(&head->srcu);
 	kref_init(&head->ref);
 
@@ -2458,8 +2650,31 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_free_head;
 	}
 
+	ret = -ENOMEM;
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	if (!q)
+		goto out_free_head;
+	q->queuedata = head;
+	blk_queue_make_request(q, nvme_make_request);
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
+	/* set to a default value for 512 until disk is validated */
+	blk_queue_logical_block_size(q, 512);
+	nvme_set_queue_limits(ctrl, q);
+
+	head->disk = alloc_disk(0);
+	if (!head->disk)
+		goto out_cleanup_queue;
+	head->disk->fops = &nvme_subsys_ops;
+	head->disk->private_data = head;
+	head->disk->queue = q;
+	head->disk->flags = GENHD_FL_EXT_DEVT;
+	sprintf(head->disk->disk_name, "nvm-sub%dn%d",
+			ctrl->subsys->instance, nsid);
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 	return head;
+
+out_cleanup_queue:
+	blk_cleanup_queue(q);
 out_free_head:
 	cleanup_srcu_struct(&head->srcu);
 	kfree(head);
@@ -2468,7 +2683,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
-		struct nvme_id_ns *id)
+		struct nvme_id_ns *id, bool *new)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	bool is_shared = id->nmic & (1 << 0);
@@ -2484,6 +2699,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
+
+		*new = true;
 	} else {
 		struct nvme_ns_ids ids;
 
@@ -2495,6 +2712,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = -EINVAL;
 			goto out_unlock;
 		}
+
+		*new = false;
 	}
 
 	list_add_tail(&ns->siblings, &head->list);
@@ -2564,6 +2783,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev);
+	bool new = true;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -2596,7 +2816,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	if (nvme_init_ns_head(ns, nsid, id))
+	if (nvme_init_ns_head(ns, nsid, id, &new))
 		goto out_free_id;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
@@ -2635,6 +2855,19 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
+
+	if (new)
+		add_disk(ns->head->disk);
+
+	if (sysfs_create_link(&disk_to_dev(ns->disk)->kobj,
+			&disk_to_dev(ns->head->disk)->kobj, "mpath"))
+		pr_warn("%s: failed to create sysfs link to mpath device\n",
+			ns->disk->disk_name);
+	if (sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
+			&disk_to_dev(ns->disk)->kobj, ns->disk->disk_name))
+		pr_warn("%s: failed to create sysfs link from mpath device\n",
+			ns->disk->disk_name);
+
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2662,6 +2895,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_attr_group);
+		sysfs_remove_link(&disk_to_dev(ns->disk)->kobj, "mpath");
+		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
+				ns->disk->disk_name);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
@@ -2669,8 +2905,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
-	if (head)
+	if (head) {
+		rcu_assign_pointer(head->current_path, NULL);
 		list_del_rcu(&ns->siblings);
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	mutex_lock(&ns->ctrl->namespaces_mutex);
@@ -3221,6 +3459,7 @@ int __init nvme_core_init(void)
 
 void nvme_core_exit(void)
 {
+	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	destroy_workqueue(nvme_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da30df2668f5..7e21cce0aefe 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -94,6 +94,11 @@ struct nvme_request {
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
@@ -206,6 +211,7 @@ struct nvme_subsystem {
 	char			model[40];
 	char			firmware_rev[8];
 	u16			vendor_id;
+	int			instance;
 };
 
 /*
@@ -225,8 +231,13 @@ struct nvme_ns_ids {
  * only ever has a single entry for private namespaces.
  */
 struct nvme_ns_head {
+	struct nvme_ns __rcu	*current_path;
+	struct gendisk		*disk;
 	struct list_head	list;
 	struct srcu_struct      srcu;
+	struct bio_list		requeue_list;
+	spinlock_t		requeue_lock;
+	struct work_struct	requeue_work;
 	unsigned		ns_id;
 	struct nvme_ns_ids	ids;
 	struct list_head	entry;
-- 
2.14.1
