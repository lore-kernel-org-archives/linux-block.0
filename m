Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/6] nvme: register ns_id attributes as default sysfs groups
Date: Mon, 30 Jul 2018 09:12:24 +0200
Message-Id: <20180730071227.22887-4-hare@suse.de>
In-Reply-To: <20180730071227.22887-1-hare@suse.de>
References: <20180730071227.22887-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

We should be registering the ns_id attribute as default sysfs
attribute groups, otherwise we have a race condition between
the uevent and the attributes appearing in sysfs.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c      | 13 ++++++-------
 drivers/nvme/host/multipath.c | 15 ++++-----------
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1b61ebceaf1..39bdfe806d1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2696,6 +2696,11 @@ const struct attribute_group nvme_ns_id_attr_group = {
 	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
 
+const struct attribute_group *nvme_ns_id_attr_groups[] = {
+	&nvme_ns_id_attr_group,
+	NULL,
+};
+
 #define nvme_show_str_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
@@ -3061,11 +3066,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	nvme_get_ctrl(ctrl);
 
-	device_add_disk(ctrl->device, ns->disk, NULL);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
+	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
@@ -3094,8 +3095,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e4d786467129..7d3c30324da9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -281,13 +281,9 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	if (!head->disk)
 		return;
 
-	if (!(head->disk->flags & GENHD_FL_UP)) {
-		device_add_disk(&head->subsys->dev, head->disk, NULL);
-		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-				&nvme_ns_id_attr_group))
-			dev_warn(&head->subsys->dev,
-				 "failed to create id group.\n");
-	}
+	if (!(head->disk->flags & GENHD_FL_UP))
+		device_add_disk(&head->subsys->dev, head->disk,
+				nvme_ns_id_attr_groups);
 
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
@@ -493,11 +489,8 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	if (head->disk->flags & GENHD_FL_UP) {
-		sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
-				   &nvme_ns_id_attr_group);
+	if (head->disk->flags & GENHD_FL_UP)
 		del_gendisk(head->disk);
-	}
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8b356f1d941c..7f156367bd18 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -466,7 +466,7 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 		void *log, size_t size, u64 offset);
 
-extern const struct attribute_group nvme_ns_id_attr_group;
+extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.12.3
