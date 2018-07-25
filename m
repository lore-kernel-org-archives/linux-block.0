Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <martin.wilck@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/5] nvme: register ns_id attributes as default sysfs groups
Date: Wed, 25 Jul 2018 08:28:38 +0200
Message-Id: <20180725062840.94114-4-hare@suse.de>
In-Reply-To: <20180725062840.94114-1-hare@suse.de>
References: <20180725062840.94114-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

We should be registering the ns_id attribute as default sysfs
attribute groups, otherwise we have a race condition between
the uevent and the attributes appearing in sysfs.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/nvme/host/core.c      | 14 +++++++-------
 drivers/nvme/host/multipath.c | 12 +++---------
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e77e6418a21c..45dab8d4aff2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2689,6 +2689,11 @@ const struct attribute_group nvme_ns_id_attr_group = {
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
@@ -3056,11 +3061,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	kfree(id);
 
-	device_add_disk(ctrl->device, ns->disk);
-	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			ns->disk->disk_name);
+	device_add_disk_with_groups(ctrl->device, ns->disk,
+				    nvme_ns_id_attr_groups);
 	if (ns->ndev && nvme_nvm_register_sysfs(ns))
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
@@ -3087,8 +3089,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
-		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
-					&nvme_ns_id_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1ffd3e8b13a1..2f57ff69e26d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -226,13 +226,9 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 		return;
 
 	mutex_lock(&head->subsys->lock);
-	if (!(head->disk->flags & GENHD_FL_UP)) {
-		device_add_disk(&head->subsys->dev, head->disk);
-		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-				&nvme_ns_id_attr_group))
-			pr_warn("%s: failed to create sysfs group for identification\n",
-				head->disk->disk_name);
-	}
+	if (!(head->disk->flags & GENHD_FL_UP))
+		device_add_disk_with_groups(&head->subsys->dev, head->disk,
+					    nvme_ns_id_attr_groups);
 	mutex_unlock(&head->subsys->lock);
 }
 
@@ -240,8 +236,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	sysfs_remove_group(&disk_to_dev(head->disk)->kobj,
-			   &nvme_ns_id_attr_group);
 	del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4ad0c8ad2a27..4b911274150d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -446,7 +446,7 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		u8 log_page, void *log, size_t size, u64 offset);
 
-extern const struct attribute_group nvme_ns_id_attr_group;
+extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.12.3
