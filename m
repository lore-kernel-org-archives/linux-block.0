Return-Path: <BATV+880bc34f87153fcb2b61+5191+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 7/7] nvme: create 'slaves' and 'holders' entries for hidden controllers
Date: Thu,  9 Nov 2017 18:44:50 +0100
Message-Id: <20171109174450.17142-8-hch@lst.de>
In-Reply-To: <20171109174450.17142-1-hch@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

When creating nvme multipath devices we should populate the 'slaves' and
'holders' directorys properly to aid userspace topology detection.

Signed-off-by: Hannes Reinecke <hare@suse.com>
[hch: split from a larger patch, compile fix for disable multipath code]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  8 ++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fab4c46e4e50..f52919f8f4dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2879,6 +2879,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (new)
 		nvme_mpath_add_disk(ns->head);
+	nvme_mpath_add_disk_links(ns);
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2902,6 +2903,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
+		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
 		if (ns->ndev)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 850275896e49..78d92151a904 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -245,6 +245,25 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 			head->disk->disk_name);
 }
 
+void nvme_mpath_add_disk_links(struct nvme_ns *ns)
+{
+	struct kobject *slave_disk_kobj, *holder_disk_kobj;
+
+	if (!ns->head->disk)
+		return;
+
+	slave_disk_kobj = &disk_to_dev(ns->disk)->kobj;
+	if (sysfs_create_link(ns->head->disk->slave_dir, slave_disk_kobj,
+			kobject_name(slave_disk_kobj)))
+		return;
+
+	holder_disk_kobj = &disk_to_dev(ns->head->disk)->kobj;
+	if (sysfs_create_link(ns->disk->part0.holder_dir, holder_disk_kobj,
+			kobject_name(holder_disk_kobj)))
+		sysfs_remove_link(ns->head->disk->slave_dir,
+			kobject_name(slave_disk_kobj));
+}
+
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
@@ -259,3 +278,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	blk_cleanup_queue(head->disk->queue);
 	put_disk(head->disk);
 }
+
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	sysfs_remove_link(ns->disk->part0.holder_dir,
+			kobject_name(&disk_to_dev(ns->head->disk)->kobj));
+	sysfs_remove_link(ns->head->disk->slave_dir,
+			kobject_name(&disk_to_dev(ns->disk)->kobj));
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 598525d9c125..0df31a2c7e0a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -404,7 +404,9 @@ bool nvme_req_needs_failover(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk_links(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
@@ -436,6 +438,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_add_disk_links(struct nvme_ns *ns)
+{
+}
+static inline void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+}
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 }
-- 
2.14.2
