Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
Date: Wed, 23 Aug 2017 19:58:15 +0200
Message-Id: <20170823175815.3646-11-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
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

TODO: implement sysfs interfaces for the new subsystem and
subsystem-namespace object.  Unless we can come up with something
better than sysfs here..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 248 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   6 ++
 2 files changed, 236 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index abc5911a8a66..feec8a708b7d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -77,6 +77,8 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
+static DEFINE_IDA(nvme_disk_ida);
+
 static struct class *nvme_class;
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
@@ -131,16 +133,80 @@ static blk_status_t nvme_error_status(struct request *req)
 	}
 }
 
-static inline bool nvme_req_needs_retry(struct request *req)
+static bool nvme_failover_rq(struct request *req)
 {
-	if (blk_noretry_request(req))
+	struct nvme_ns *ns = req->q->queuedata;
+	unsigned long flags;
+
+	/*
+	 * Only fail over commands that came in through the the multipath
+	 * aware submissions path.  Note that ns->head might not be set up
+	 * for commands used during controller initialization, but those
+	 * must never set REQ_FAILFAST_TRANSPORT.
+	 */
+	if (!(req->cmd_flags & REQ_FAILFAST_TRANSPORT))
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
 		return false;
+	}
+
+	/* Anything else could be a path failure, so should be retried */
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	blk_steal_bios(&ns->head->requeue_list, req);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+
+	nvme_reset_ctrl(ns->ctrl);
+	kblockd_schedule_work(&ns->head->requeue_work);
+	return true;
+}
+
+static inline bool nvme_req_needs_retry(struct request *req)
+{
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
 	if (jiffies - req->start_time >= req->timeout)
 		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
+	if (nvme_failover_rq(req))
+		return false;
+	if (blk_noretry_request(req))
+		return false;
 	return true;
 }
 
@@ -175,6 +241,18 @@ void nvme_cancel_request(struct request *req, void *data, bool reserved)
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
@@ -242,9 +320,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	if (changed)
 		ctrl->state = new_state;
-
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
+	if (changed && ctrl->state == NVME_CTRL_LIVE)
+		nvme_kick_requeue_lists(ctrl);
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -254,6 +333,15 @@ static void nvme_destroy_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	del_gendisk(head->disk);
+	blk_set_queue_dying(head->disk->queue);
+	/* make sure all pending bios are cleaned up */
+	kblockd_schedule_work(&head->requeue_work);
+	flush_work(&head->requeue_work);
+	blk_cleanup_queue(head->disk->queue);
+	put_disk(head->disk);
+	ida_simple_remove(&nvme_disk_ida, head->instance);
+
 	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
 	kfree(head);
@@ -1128,8 +1216,10 @@ static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
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
@@ -1157,7 +1247,9 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 	}
 	integrity.tuple_size = ns->ms;
 	blk_integrity_register(ns->disk, &integrity);
+	blk_integrity_register(ns->head->disk, &integrity);
 	blk_queue_max_integrity_segments(ns->queue, 1);
+	blk_queue_max_integrity_segments(ns->head->disk->queue, 1);
 }
 #else
 static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
@@ -1175,7 +1267,7 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
+static void nvme_config_discard(struct nvme_ns *ns, struct request_queue *queue)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
@@ -1186,18 +1278,18 @@ static void nvme_config_discard(struct nvme_ns *ns)
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
@@ -1238,17 +1330,25 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
 
@@ -2377,6 +2477,73 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
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
+		bio->bi_opf |= REQ_FAILFAST_TRANSPORT;
+		ret = generic_make_request_fast(bio);
+	} else if (!list_empty_careful(&head->list)) {
+		printk_ratelimited("no path available - requeing I/O\n");
+
+		spin_lock_irq(&head->requeue_lock);
+		bio_list_add(&head->requeue_list, bio);
+		spin_unlock_irq(&head->requeue_lock);
+	} else {
+		printk_ratelimited("no path - failing I/O\n");
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
+		generic_make_request_fast(bio);
+	}
+}
+
 static struct nvme_ns_head *__nvme_find_ns_head(struct nvme_subsystem *subsys,
 		unsigned nsid)
 {
@@ -2416,6 +2583,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid, struct nvme_id_ns *id)
 {
 	struct nvme_ns_head *head;
+	struct request_queue *q;
 	int ret = -ENOMEM;
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
@@ -2424,6 +2592,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 
 	INIT_LIST_HEAD(&head->list);
 	head->ns_id = nsid;
+	bio_list_init(&head->requeue_list);
+	spin_lock_init(&head->requeue_lock);
+	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	init_srcu_struct(&head->srcu);
 	kref_init(&head->ref);
 
@@ -2437,8 +2608,37 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
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
+	head->instance = ida_simple_get(&nvme_disk_ida, 1, 0, GFP_KERNEL);
+	if (head->instance < 0)
+		goto out_cleanup_queue;
+
+	head->disk = alloc_disk(0);
+	if (!head->disk)
+		goto out_ida_remove;
+	head->disk->fops = &nvme_subsys_ops;
+	head->disk->private_data = head;
+	head->disk->queue = q;
+	head->disk->flags = GENHD_FL_EXT_DEVT;
+	sprintf(head->disk->disk_name, "nvme/ns%d", head->instance);
+
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 	return head;
+
+out_ida_remove:
+	ida_simple_remove(&nvme_disk_ida, head->instance);
+out_cleanup_queue:
+	blk_cleanup_queue(q);
 out_free_head:
 	cleanup_srcu_struct(&head->srcu);
 	kfree(head);
@@ -2447,7 +2647,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
-		struct nvme_id_ns *id)
+		struct nvme_id_ns *id, bool *new)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	bool is_shared = id->nmic & (1 << 0);
@@ -2463,6 +2663,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
+
+		*new = true;
 	} else {
 		u8 eui64[8] = { 0 }, nguid[16] = { 0 };
 		uuid_t uuid = uuid_null;
@@ -2477,6 +2679,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = -EINVAL;
 			goto out_unlock;
 		}
+
+		*new = false;
 	}
 
 	list_add_tail(&ns->siblings, &head->list);
@@ -2546,6 +2750,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev);
+	bool new = true;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -2578,7 +2783,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	if (nvme_init_ns_head(ns, nsid, id))
+	if (nvme_init_ns_head(ns, nsid, id, &new))
 		goto out_free_id;
 
 	if (nvme_nvm_ns_supported(ns, id) &&
@@ -2616,6 +2821,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
+
+	if (new)
+		add_disk(ns->head->disk);
+
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2650,8 +2859,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
-	if (head)
+	if (head) {
+		rcu_assign_pointer(head->current_path, NULL);
 		list_del_rcu(&ns->siblings);
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	mutex_lock(&ns->ctrl->namespaces_mutex);
@@ -3201,6 +3412,7 @@ int __init nvme_core_init(void)
 
 void nvme_core_exit(void)
 {
+	ida_destroy(&nvme_disk_ida);
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	destroy_workqueue(nvme_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f68a89be654b..e8b28b7d38e8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -207,14 +207,20 @@ struct nvme_subsystem {
  * only ever has a single entry for private namespaces.
  */
 struct nvme_ns_head {
+	struct nvme_ns		*current_path;
+	struct gendisk		*disk;
 	struct list_head	list;
 	struct srcu_struct      srcu;
+	struct bio_list		requeue_list;
+	spinlock_t		requeue_lock;
+	struct work_struct	requeue_work;
 	unsigned		ns_id;
 	u8			eui64[8];
 	u8			nguid[16];
 	uuid_t			uuid;
 	struct list_head	entry;
 	struct kref		ref;
+	int			instance;
 };
 
 struct nvme_ns {
-- 
2.11.0
