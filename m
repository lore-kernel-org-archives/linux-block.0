Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:25:45 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 05/10] Init multipath head controller.
Message-ID: <20170912042544.z7iufguhozjimmty@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Initialize the multipath head controller. This multipath head controller is created as soon as we identify a namespace which can be shared. It will be added to global multipath controller list. Memory pool is created to allocate private structure to maintain bio data between head device and child devices. Retrieve block device handle for future communication through generic_make_request function if device is shared.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/core.c | 229 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 208 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3839d1c..2987e0a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -750,6 +750,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
+		schedule_work(&ctrl->failover_work);
 		return;
 	}
 
@@ -2435,17 +2436,19 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	return 0;
 }
 
-static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static struct nvme_ns *nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
+	char devpath[DISK_NAME_LEN+4];
 	int node = dev_to_node(ctrl->dev);
+	static char *_claim_ptr = "I belong to mpath device";
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return;
+		return NULL;
 
 	ns->instance = ida_simple_get(&ctrl->ns_ida, 1, 0, GFP_KERNEL);
 	if (ns->instance < 0)
@@ -2465,8 +2468,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 	nvme_setup_streams_ns(ctrl, ns);
+	blk_queue_rq_timeout(ns->queue, nvme_io_timeout * HZ);
 
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
+	sprintf(devpath, "/dev/nvme%dn%d", ctrl->instance, ns->instance);
 
 	if (nvme_revalidate_ns(ns, &id))
 		goto out_free_queue;
@@ -2496,17 +2501,36 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	kref_get(&ctrl->kref);
 
-	kfree(id);
-
 	device_add_disk(ctrl->device, ns->disk);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group))
+					&nvme_ns_attr_group)) {
 		pr_warn("%s: failed to create sysfs group for identification\n",
 			ns->disk->disk_name);
+		goto out_del_gendisk;
+	}
+
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
-	return;
+
+	if (ns->nmic &  0x1) {
+		ns->bdev = blkdev_get_by_path(devpath,
+				 FMODE_READ | FMODE_WRITE | FMODE_EXCL, _claim_ptr);
+		if (IS_ERR(ns->bdev)) {
+			goto out_sysfs_remove_group;
+		}
+	}
+
+	kfree(id);
+
+	return ns;
+ out_sysfs_remove_group:
+	pr_err("%s: failed to get block device handle %p\n",
+			ns->disk->disk_name, ns->bdev);
+	sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+			&nvme_ns_attr_group);
+ out_del_gendisk:
+	del_gendisk(ns->disk);
  out_free_id:
 	kfree(id);
  out_free_queue:
@@ -2515,22 +2539,50 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ida_simple_remove(&ctrl->ns_ida, ns->instance);
  out_free_ns:
 	kfree(ns);
+	return NULL;
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	struct nvme_ctrl *mpath_ctrl = NULL;
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
-	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		if (blk_get_integrity(ns->disk))
-			blk_integrity_unregister(ns->disk);
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_attr_group);
-		if (ns->ndev)
-			nvme_nvm_unregister_sysfs(ns);
-		del_gendisk(ns->disk);
-		blk_cleanup_queue(ns->queue);
+	if (test_bit(NVME_NS_ROOT, &ns->flags))
+		nvme_mpath_cancel_ios(ns);
+
+	if (ns->active)
+		nvme_trigger_failover(ns->ctrl);
+	if (ns->mpath_ctrl) {
+		mpath_ctrl = ns->mpath_ctrl;
+		if (nvme_del_ns_mpath_ctrl(ns) == NVME_NO_MPATH_NS_AVAIL) {
+			mpath_ctrl = NULL;
+		}
+		if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+			if (blk_get_integrity(ns->disk))
+				blk_integrity_unregister(ns->disk);
+			sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+						&nvme_ns_attr_group);
+			if (ns->nmic &  0x1)
+				blkdev_put(ns->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+			del_gendisk(ns->disk);
+			blk_cleanup_queue(ns->queue);
+		}
+
+	} else {
+		if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+			if (blk_get_integrity(ns->disk))
+				blk_integrity_unregister(ns->disk);
+
+			sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+				&nvme_ns_attr_group);
+			if (ns->ndev)
+				nvme_nvm_unregister_sysfs(ns);
+			if (ns->bdev)
+				blkdev_put(ns->bdev, FMODE_READ | FMODE_WRITE);
+			del_gendisk(ns->disk);
+			blk_cleanup_queue(ns->queue);
+		}
 	}
 
 	mutex_lock(&ns->ctrl->namespaces_mutex);
@@ -2538,6 +2590,20 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->namespaces_mutex);
 
 	nvme_put_ns(ns);
+	if (mpath_ctrl) {
+		mpath_ctrl->cleanup_done = 1;
+	}
+}
+
+void nvme_mpath_ns_remove(struct nvme_ns *ns)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	nvme_ns_remove(ns);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
+	spin_lock(&dev_list_lock);
+	list_del(&ctrl->node);
+	spin_unlock(&dev_list_lock);
+	nvme_put_ctrl(ctrl);
 }
 
 static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -2549,8 +2615,12 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->disk && revalidate_disk(ns->disk))
 			nvme_ns_remove(ns);
 		nvme_put_ns(ns);
-	} else
-		nvme_alloc_ns(ctrl, nsid);
+	} else {
+		ns = nvme_alloc_ns(ctrl, nsid);
+		if (ns && (ns->nmic &  0x1)) {
+			nvme_shared_ns(ns);
+		}
+	}
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -2761,9 +2831,11 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(ctrl);
-	flush_work(&ctrl->async_event_work);
-	flush_work(&ctrl->scan_work);
+	if (!test_bit(NVME_CTRL_MULTIPATH, &ctrl->flags)) {
+		nvme_stop_keep_alive(ctrl);
+		flush_work(&ctrl->async_event_work);
+		flush_work(&ctrl->scan_work);
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
@@ -2782,11 +2854,19 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	struct task_struct *tmp = NULL;
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
+	if (list_empty(&nvme_mpath_ctrl_list) && !IS_ERR_OR_NULL(nvme_mpath_thread)) {
+		tmp = nvme_mpath_thread;
+		nvme_mpath_thread = NULL;
+	}
 	spin_unlock(&dev_list_lock);
+	if (tmp) {
+		kthread_stop(tmp);
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
@@ -2798,7 +2878,15 @@ static void nvme_free_ctrl(struct kref *kref)
 	nvme_release_instance(ctrl);
 	ida_destroy(&ctrl->ns_ida);
 
-	ctrl->ops->free_ctrl(ctrl);
+	if (test_bit(NVME_CTRL_MULTIPATH, &ctrl->flags)) {
+		if (ctrl->mpath_req_pool) {
+			mempool_destroy(ctrl->mpath_req_pool);
+			kmem_cache_destroy(ctrl->mpath_req_slab);
+		}
+		kfree(ctrl);
+	} else {
+		ctrl->ops->free_ctrl(ctrl);
+	}
 }
 
 void nvme_put_ctrl(struct nvme_ctrl *ctrl)
@@ -2825,6 +2913,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
+	INIT_WORK(&ctrl->failover_work, nvme_trigger_failover_work);
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 
@@ -2863,6 +2952,103 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
+struct nvme_ctrl *nvme_init_mpath_ctrl(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ctrl *mpath_ctrl;
+	bool changed;
+	int ret;
+	bool start_thread = false;
+
+	mpath_ctrl = kzalloc(sizeof(*mpath_ctrl), GFP_KERNEL);
+	if (!mpath_ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	set_bit(NVME_CTRL_MULTIPATH, &mpath_ctrl->flags);
+	mpath_ctrl->state = NVME_CTRL_NEW;
+	mpath_ctrl->cleanup_done = 1;
+	spin_lock_init(&mpath_ctrl->lock);
+	INIT_LIST_HEAD(&mpath_ctrl->namespaces);
+	INIT_LIST_HEAD(&mpath_ctrl->mpath_namespace);
+	mutex_init(&mpath_ctrl->namespaces_mutex);
+	kref_init(&mpath_ctrl->kref);
+	mpath_ctrl->dev = ctrl->dev;
+	mpath_ctrl->ops = ctrl->ops;
+
+	ret = nvme_set_instance(mpath_ctrl);
+	if (ret)
+		goto out;
+
+	mpath_ctrl->device = device_create_with_groups(nvme_class, mpath_ctrl->dev,
+		MKDEV(nvme_char_major, mpath_ctrl->instance),
+		mpath_ctrl, nvme_dev_attr_groups,
+		"nvme%d", mpath_ctrl->instance);
+
+	if (IS_ERR(mpath_ctrl->device)) {
+		goto out_release_instance;
+	}
+
+	get_device(mpath_ctrl->device);
+	ida_init(&mpath_ctrl->ns_ida);
+
+	if (list_empty(&nvme_mpath_ctrl_list) && IS_ERR_OR_NULL(nvme_mpath_thread)) {
+		start_thread = true;
+		nvme_mpath_thread = NULL;
+	}
+	spin_lock(&dev_list_lock);
+	list_add_tail(&mpath_ctrl->node, &nvme_mpath_ctrl_list);
+	spin_unlock(&dev_list_lock);
+
+	changed = nvme_change_ctrl_state(mpath_ctrl, NVME_CTRL_LIVE);
+
+	sprintf(mpath_ctrl->mpath_req_cache_name, "mpath_req%d", mpath_ctrl->instance);
+
+	/* allocate a slab cache for priv structure to maintain bio data*/
+	mpath_ctrl->mpath_req_slab = kmem_cache_create(
+		mpath_ctrl->mpath_req_cache_name,
+		 sizeof(struct nvme_mpath_priv),
+		 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (mpath_ctrl->mpath_req_slab == NULL) {
+		dev_err(mpath_ctrl->device,
+			"failed allocating mpath request cache\n");
+		goto out_release_instance;
+	}
+
+	/* allocate a memory pool which uses the slab cache */
+	mpath_ctrl->mpath_req_pool = mempool_create(NVME_MAX_MPATH_PRIV,
+		mempool_alloc_slab,
+		mempool_free_slab,
+		mpath_ctrl->mpath_req_slab);
+	if (mpath_ctrl->mpath_req_pool == NULL) {
+		dev_err(mpath_ctrl->device,
+			"failed allocating mpath request pool\n");
+		goto out_release_req_slab;
+	}
+
+	if (start_thread) {
+		nvme_mpath_thread = kthread_run(nvme_mpath_kthread, NULL, "nvme_mpath");
+	} else
+		wait_event_killable(nvme_mpath_kthread_wait, nvme_mpath_thread);
+
+	if (IS_ERR_OR_NULL(nvme_mpath_thread)) {
+		ret = nvme_mpath_thread ? PTR_ERR(nvme_mpath_thread) : -EINTR;
+		goto out_release_req_pool;
+	}
+	dev_info(mpath_ctrl->device, "multipath request pool allocated\n");
+
+	return mpath_ctrl;
+ out_release_req_pool:
+	mempool_destroy(mpath_ctrl->mpath_req_pool);
+ out_release_req_slab:
+	kmem_cache_destroy(mpath_ctrl->mpath_req_slab);
+	mpath_ctrl->mpath_req_slab = NULL;
+ out_release_instance:
+	nvme_release_instance(mpath_ctrl);
+ out:
+	kfree(mpath_ctrl);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(nvme_init_mpath_ctrl);
+
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -2970,6 +3156,7 @@ int __init nvme_core_init(void)
 {
 	int result;
 
+	init_waitqueue_head(&nvme_mpath_kthread_wait);
 	nvme_wq = alloc_workqueue("nvme-wq",
 			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
 	if (!nvme_wq)
-- 
2.9.3
