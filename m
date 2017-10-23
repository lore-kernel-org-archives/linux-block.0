Return-Path: <BATV+e774f35f755d74bf45df+5174+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/17] nvme: switch controller refcounting to use struct device
Date: Mon, 23 Oct 2017 16:51:19 +0200
Message-Id: <20171023145126.2471-11-hch@lst.de>
In-Reply-To: <20171023145126.2471-1-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Instead of allocating a separate struct device for the character device
handle embedd it into struct nvme_ctrl and use it for the main controller
refcounting.  This removes double refcounting and gets us an automatic
reference for the character device operations.  We keep ctrl->device as a
pointer for now to avoid chaning printks all over, but in the future we
could look into message printing helpers that take a controller structure
similar to what other subsystems do.

Note the delete_ctrl operation always already has a reference (either
through sysfs due this change, or because every open file on the
/dev/nvme-fabrics node has a refernece) when it is entered now, so we
don't need to do the unless_zero variant there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c   | 43 ++++++++++++++++++++++---------------------
 drivers/nvme/host/fc.c     |  8 ++------
 drivers/nvme/host/nvme.h   | 12 +++++++++++-
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  5 ++---
 drivers/nvme/target/loop.c |  2 +-
 6 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9f8ae15c9fe8..3a97daa163f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1915,7 +1915,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 			ret = -EWOULDBLOCK;
 			break;
 		}
-		if (!kref_get_unless_zero(&ctrl->kref))
+		if (!kobject_get_unless_zero(&ctrl->device->kobj))
 			break;
 		file->private_data = ctrl;
 		ret = 0;
@@ -2374,7 +2374,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	mutex_unlock(&ctrl->namespaces_mutex);
 
-	kref_get(&ctrl->kref);
+	nvme_get_ctrl(ctrl);
 
 	kfree(id);
 
@@ -2703,7 +2703,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
-	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
+	device_del(ctrl->device);
 
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
@@ -2711,23 +2711,17 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
-static void nvme_free_ctrl(struct kref *kref)
+static void nvme_free_ctrl(struct device *dev)
 {
-	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
+	struct nvme_ctrl *ctrl =
+		container_of(dev, struct nvme_ctrl, ctrl_device);
 
-	put_device(ctrl->device);
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	ida_destroy(&ctrl->ns_ida);
 
 	ctrl->ops->free_ctrl(ctrl);
 }
 
-void nvme_put_ctrl(struct nvme_ctrl *ctrl)
-{
-	kref_put(&ctrl->kref, nvme_free_ctrl);
-}
-EXPORT_SYMBOL_GPL(nvme_put_ctrl);
-
 /*
  * Initialize a NVMe controller structures.  This needs to be called during
  * earliest initialization so that we have the initialized structured around
@@ -2742,7 +2736,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	spin_lock_init(&ctrl->lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	mutex_init(&ctrl->namespaces_mutex);
-	kref_init(&ctrl->kref);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -2755,15 +2748,21 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		goto out;
 	ctrl->instance = ret;
 
-	ctrl->device = device_create_with_groups(nvme_class, ctrl->dev,
-				MKDEV(nvme_char_major, ctrl->instance),
-				ctrl, nvme_dev_attr_groups,
-				"nvme%d", ctrl->instance);
-	if (IS_ERR(ctrl->device)) {
-		ret = PTR_ERR(ctrl->device);
+	device_initialize(&ctrl->ctrl_device);
+	ctrl->device = &ctrl->ctrl_device;
+	ctrl->device->devt = MKDEV(nvme_char_major, ctrl->instance);
+	ctrl->device->class = nvme_class;
+	ctrl->device->parent = ctrl->dev;
+	ctrl->device->groups = nvme_dev_attr_groups;
+	ctrl->device->release = nvme_free_ctrl;
+	dev_set_drvdata(ctrl->device, ctrl);
+	ret = dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
+	if (ret)
 		goto out_release_instance;
-	}
-	get_device(ctrl->device);
+	ret = device_add(ctrl->device);
+	if (ret)
+		goto out_free_name;
+
 	ida_init(&ctrl->ns_ida);
 
 	spin_lock(&dev_list_lock);
@@ -2779,6 +2778,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
 	return 0;
+out_free_name:
+	kfree_const(dev->kobj.name);
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index c6c903f1b172..aa9aec6923bb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2692,14 +2692,10 @@ nvme_fc_del_nvme_ctrl(struct nvme_ctrl *nctrl)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	int ret;
 
-	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
-		return -EBUSY;
-
+	nvme_get_ctrl(&ctrl->ctrl);
 	ret = __nvme_fc_del_ctrl(ctrl);
-
 	if (!ret)
 		flush_workqueue(nvme_wq);
-
 	nvme_put_ctrl(&ctrl->ctrl);
 
 	return ret;
@@ -2918,7 +2914,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		return ERR_PTR(ret);
 	}
 
-	kref_get(&ctrl->ctrl.kref);
+	nvme_get_ctrl(&ctrl->ctrl);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cb9d93048f3d..ae60d8342e60 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -127,12 +127,12 @@ struct nvme_ctrl {
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
 	struct device *dev;
-	struct kref kref;
 	int instance;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
 	struct mutex namespaces_mutex;
+	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct list_head node;
 	struct ida ns_ida;
@@ -279,6 +279,16 @@ static inline void nvme_end_request(struct request *req, __le16 status,
 	blk_mq_complete_request(req);
 }
 
+static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)
+{
+	get_device(ctrl->device);
+}
+
+static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
+{
+	put_device(ctrl->device);
+}
+
 void nvme_complete_rq(struct request *req);
 void nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 11e6fd9d0ba4..7735571ffc9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2292,7 +2292,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 {
 	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
 
-	kref_get(&dev->ctrl.kref);
+	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	if (!schedule_work(&dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4552744eff45..62b58f9b7d00 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1793,8 +1793,7 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 	 * Keep a reference until all work is flushed since
 	 * __nvme_rdma_del_ctrl can free the ctrl mem
 	 */
-	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
-		return -EBUSY;
+	nvme_get_ctrl(&ctrl->ctrl);
 	ret = __nvme_rdma_del_ctrl(ctrl);
 	if (!ret)
 		flush_work(&ctrl->delete_work);
@@ -1955,7 +1954,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
-	kref_get(&ctrl->ctrl.kref);
+	nvme_get_ctrl(&ctrl->ctrl);
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index c56354e1e4c6..f83e925fe64a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -642,7 +642,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device,
 		 "new ctrl: \"%s\"\n", ctrl->ctrl.opts->subsysnqn);
 
-	kref_get(&ctrl->ctrl.kref);
+	nvme_get_ctrl(&ctrl->ctrl);
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
-- 
2.14.2
