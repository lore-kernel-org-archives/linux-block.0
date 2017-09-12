Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:26:27 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 06/10] Init multipath head namespace.
Message-ID: <20170912042627.2ut7onndfmeqxd5r@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Initialize multipath head namespace. The way generic namespace is related to a generic controller, similarly multipath head namespace is related to multipath head controller. It is initialized as part of a single shared namespace enumeration. We will initialize the bio list and congestion wait queue for given multipath head namespace, this queue will be used during failover to requeue any IO returned from active path for resubmission. nvme_mpath_flush_io_work is implemented to take care of condition when both interfaces is down and IO is queued up on head mulitpath devices congestion queue. Added functionality to add and delete namespace to head multipath namespace list. This logic is similar to namespace list we have per controller. On deletion of namespaces, check if this was last namespace part of multipath head device and remove the head multipath namespace.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 233 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2987e0a..cefa506 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2436,6 +2436,239 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	return 0;
 }
 
+static struct nvme_ns *nvme_find_get_mpath_ns(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns = NULL;
+	mutex_lock(&ctrl->namespaces_mutex);
+    list_for_each_entry(ns, &ctrl->mpath_namespace, list) {
+		if (ns)
+			break;
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+	return ns;
+}
+
+/*Adding namespace to multipath list under multipath controller*/
+static void nvme_add_ns_mpath_ctrl(struct nvme_ns *ns)
+{
+	struct nvme_ns *mpath_ns = NULL;
+	mpath_ns = nvme_find_get_mpath_ns(ns->mpath_ctrl);
+	mutex_lock(&ns->mpath_ctrl->namespaces_mutex);
+	list_add_tail(&ns->mpathlist, &ns->mpath_ctrl->namespaces);
+	test_and_set_bit(NVME_CTRL_MPATH_CHILD, &ns->ctrl->flags);
+	test_and_set_bit(NVME_NS_MULTIPATH, &ns->flags);
+	mutex_unlock(&ns->mpath_ctrl->namespaces_mutex);
+	kref_get(&mpath_ns->kref);
+}
+
+/*Deleting namespace from multipath list under multipath controller*/
+static int nvme_del_ns_mpath_ctrl(struct nvme_ns *ns)
+{
+
+	struct nvme_ns *mpath_ns = NULL, *nsa = NULL, *next;
+
+	if (!ns->mpath_ctrl)
+		return NVME_NO_MPATH_NS_AVAIL;
+	mpath_ns = nvme_find_get_mpath_ns(ns->mpath_ctrl);
+	mutex_lock(&mpath_ns->ctrl->namespaces_mutex);
+	test_and_clear_bit(NVME_NS_MULTIPATH, &ns->flags);
+	list_del_init(&ns->mpathlist);
+	list_for_each_entry_safe(nsa, next, &mpath_ns->ctrl->namespaces, mpathlist) {
+		if (nsa == ns) {
+			list_del_init(&ns->mpathlist);
+			continue;
+		}
+	}
+	mutex_unlock(&mpath_ns->ctrl->namespaces_mutex);
+
+	/*Check if we were the last device to a given head or parent device.
+	If last device then remove head device also.*/
+	if (mpath_ns == nvme_get_ns_for_mpath_ns(mpath_ns)) {
+		nvme_put_ns(mpath_ns);
+		nvme_mpath_ns_remove(mpath_ns);
+		/*cancel delayed work as we are the last device */
+		cancel_delayed_work_sync(&ns->mpath_ctrl->cu_work);
+		return NVME_NO_MPATH_NS_AVAIL;
+	} else {
+		blk_mq_freeze_queue(ns->disk->queue);
+		set_capacity(ns->disk, 0);
+		blk_mq_unfreeze_queue(ns->disk->queue);
+		revalidate_disk(ns->disk);
+		nvme_put_ns(mpath_ns);
+		return NVME_MPATH_NS_AVAIL;
+	}
+}
+
+
+static struct nvme_ns *nvme_alloc_mpath_ns(struct nvme_ns *nsa)
+{
+	struct gendisk *disk;
+	struct nvme_id_ns *id;
+	char disk_name[DISK_NAME_LEN];
+	char devpath[DISK_NAME_LEN+4];
+	struct nvme_ctrl *ctrl = NULL;
+	struct nvme_ns *ns = NULL;
+	int node;
+
+	ctrl = nvme_init_mpath_ctrl(nsa->ctrl);
+	if (!ctrl)
+		return NULL;
+
+	node = dev_to_node(ctrl->dev);
+	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
+	if (!ns)
+		goto out_free_ctrl;
+	ns->ctrl = ctrl;
+	ns->instance = ida_simple_get(&ns->ctrl->ns_ida, 1, 0, GFP_KERNEL);
+	if (ns->instance < 0)
+		goto out_free_ns;
+
+	ns->queue = blk_alloc_queue(GFP_KERNEL);
+	if (IS_ERR(ns->queue))
+		goto out_release_instance;
+
+	blk_queue_make_request(ns->queue, nvme_mpath_make_request);
+
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+	ns->queue->queuedata = ns;
+	kref_init(&ns->kref);
+	ns->ns_id = nsa->ns_id;
+	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
+
+	test_and_set_bit(NVME_NS_ROOT, &ns->flags);
+	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
+	nvme_set_queue_limits(ctrl, ns->queue);
+	blk_queue_rq_timeout(ns->queue, mpath_io_timeout * HZ);
+	sprintf(disk_name, "mpnvme%dn%d", ctrl->instance, ns->instance);
+	sprintf(devpath, "/dev/mpnvme%dn%d", ctrl->instance, ns->instance);
+	if (nvme_revalidate_ns(nsa, &id))
+		goto out_free_queue;
+
+	disk = alloc_disk_node(0, node);
+	if (!disk)
+		goto out_free_id;
+
+	disk->fops = &nvme_fops;
+	disk->private_data = ns;
+	disk->queue = ns->queue;
+	disk->flags = GENHD_FL_EXT_DEVT;
+	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+	ns->disk = disk;
+	__nvme_revalidate_disk(disk, id);
+	init_waitqueue_head(&ns->fq_full);
+	init_waitqueue_entry(&ns->fq_cong_wait, nvme_mpath_thread);
+	bio_list_init(&ns->fq_cong);
+	nsa->mpath_ctrl = ns->ctrl;
+	nsa->ctrl->mpath_ctrl = (void *)ns->ctrl;
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_add_tail(&ns->list, &ctrl->mpath_namespace);
+	mutex_unlock(&ctrl->namespaces_mutex);
+	nvme_add_ns_mpath_ctrl(nsa);
+
+	memcpy(&ns->mpath_nguid, &nsa->mpath_nguid, NVME_NIDT_NGUID_LEN);
+	kref_get(&ns->ctrl->kref);
+
+	device_add_disk(ctrl->device, ns->disk);
+
+
+	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
+		&nvme_ns_attr_group)) {
+		pr_warn("%s: failed to create sysfs group for identification\n",
+			ns->disk->disk_name);
+		goto out_del_gendisk;
+	}
+
+	ns->bdev = blkdev_get_by_path(devpath,
+			 FMODE_READ | FMODE_WRITE, NULL);
+	if (IS_ERR(ns->bdev)) {
+		pr_warn("%s: failed to get block device\n",
+			 ns->disk->disk_name);
+		goto out_sysfs_remove_group;
+	}
+
+	kfree(id);
+
+	if (nvme_set_ns_active(nsa, ns, NVME_FAILOVER_RETRIES)) {
+		pr_info("%s:%d Failed to set active Namespace nvme%dn%d\n", __FUNCTION__, __LINE__, nsa->ctrl->instance, nsa->instance);
+	}
+
+    /* init delayed work for IO cleanup when both iface are down */
+    INIT_DELAYED_WORK(&ctrl->cu_work, nvme_mpath_flush_io_work);
+    return ns;
+
+ out_sysfs_remove_group:
+	sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+			&nvme_ns_attr_group);
+ out_del_gendisk:
+	del_gendisk(ns->disk);
+	mutex_lock(&ctrl->namespaces_mutex);
+	test_and_clear_bit(NVME_NS_MULTIPATH, &nsa->flags);
+	list_del_init(&nsa->mpathlist);
+	mutex_unlock(&ctrl->namespaces_mutex);
+	nsa->mpath_ctrl = NULL;
+	nsa->ctrl->mpath_ctrl = NULL;
+ out_free_id:
+	kfree(id);
+ out_free_queue:
+	blk_cleanup_queue(ns->queue);
+ out_release_instance:
+	ida_simple_remove(&ctrl->ns_ida, ns->instance);
+ out_free_ns:
+	kfree(ns);
+ out_free_ctrl:
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
+	spin_lock(&dev_list_lock);
+	list_del(&ctrl->node);
+	spin_unlock(&dev_list_lock);
+	nvme_put_ctrl(ctrl);
+	return NULL;
+}
+
+static void nvme_shared_ns(struct nvme_ns *shared_ns)
+{
+	struct nvme_ctrl *ctrl = NULL;
+	struct nvme_ns *ns, *ret = NULL;
+	/*
+	  Check if the namespace is shared and another namespace with same
+	  serial number exist amount the controllers.
+	*/
+
+	spin_lock(&dev_list_lock);
+	list_for_each_entry(ctrl, &nvme_ctrl_list, node) {
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			if (ns == shared_ns)
+				continue;
+			/*
+			 * Revalidating a dead namespace sets capacity to 0. This will
+			 * end buffered writers dirtying pages that can't be synced.
+			 */
+			if (!ns->disk || test_bit(NVME_NS_DEAD, &ns->flags))
+				continue;
+
+			if (!strncmp(ns->nguid, shared_ns->nguid, NVME_NIDT_NGUID_LEN)) {
+				if (test_bit(NVME_NS_MULTIPATH, &ns->flags)) {
+					shared_ns->mpath_ctrl = ns->mpath_ctrl;
+					shared_ns->ctrl->mpath_ctrl = (void *)ns->mpath_ctrl;
+					ret = shared_ns;
+				} else {
+					ret = ns;
+				}
+				goto found_ns;
+			}
+		}
+	}
+	spin_unlock(&dev_list_lock);
+
+	if (shared_ns->nmic & 0x1) {
+		shared_ns->active = 1;
+		nvme_alloc_mpath_ns(shared_ns);
+	}
+	return;
+ found_ns:
+	spin_unlock(&dev_list_lock);
+	if (ret == shared_ns)
+		nvme_add_ns_mpath_ctrl(shared_ns);
+}
 static struct nvme_ns *nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
-- 
2.9.3
