Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 07/17] nvme: use ida_simple_{get,remove} for the controller instance
Date: Wed, 18 Oct 2017 18:52:48 +0200
Message-Id: <20171018165258.23212-8-hch@lst.de>
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Switch to the ida_simple_* helpers instead of opencoding them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 573cc3b59bfa..bdae1e4fcd0b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -74,6 +74,8 @@ EXPORT_SYMBOL_GPL(nvme_wq);
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
+static DEFINE_IDA(nvme_instance_ida);
+
 static struct class *nvme_class;
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
@@ -2696,35 +2698,6 @@ void nvme_queue_async_events(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_queue_async_events);
 
-static DEFINE_IDA(nvme_instance_ida);
-
-static int nvme_set_instance(struct nvme_ctrl *ctrl)
-{
-	int instance, error;
-
-	do {
-		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
-			return -ENODEV;
-
-		spin_lock(&dev_list_lock);
-		error = ida_get_new(&nvme_instance_ida, &instance);
-		spin_unlock(&dev_list_lock);
-	} while (error == -EAGAIN);
-
-	if (error)
-		return -ENODEV;
-
-	ctrl->instance = instance;
-	return 0;
-}
-
-static void nvme_release_instance(struct nvme_ctrl *ctrl)
-{
-	spin_lock(&dev_list_lock);
-	ida_remove(&nvme_instance_ida, ctrl->instance);
-	spin_unlock(&dev_list_lock);
-}
-
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
@@ -2762,7 +2735,7 @@ static void nvme_free_ctrl(struct kref *kref)
 	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
 
 	put_device(ctrl->device);
-	nvme_release_instance(ctrl);
+	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	ida_destroy(&ctrl->ns_ida);
 
 	ctrl->ops->free_ctrl(ctrl);
@@ -2796,9 +2769,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 
-	ret = nvme_set_instance(ctrl);
-	if (ret)
+	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
 		goto out;
+	ctrl->instance = ret;
 
 	ctrl->device = device_create_with_groups(nvme_class, ctrl->dev,
 				MKDEV(nvme_char_major, ctrl->instance),
@@ -2825,7 +2799,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_release_instance:
-	nvme_release_instance(ctrl);
+	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
 	return ret;
 }
-- 
2.14.1
