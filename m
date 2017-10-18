Return-Path: <BATV+33c0a560d8cf4f6c9bdc+5169+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 09/17] nvme: simplify nvme_open
Date: Wed, 18 Oct 2017 18:52:50 +0200
Message-Id: <20171018165258.23212-10-hch@lst.de>
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we are protected against lookup vs free races for the namespace
by using kref_get_unless_zero we don't need the hack of NULLing out the
disk private data during removal.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3f51bd0326b5..05a6fad89352 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -253,12 +253,6 @@ static void nvme_free_ns(struct kref *kref)
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
-	if (ns->disk) {
-		spin_lock(&dev_list_lock);
-		ns->disk->private_data = NULL;
-		spin_unlock(&dev_list_lock);
-	}
-
 	put_disk(ns->disk);
 	ida_simple_remove(&ns->ctrl->ns_ida, ns->instance);
 	nvme_put_ctrl(ns->ctrl);
@@ -270,29 +264,6 @@ static void nvme_put_ns(struct nvme_ns *ns)
 	kref_put(&ns->kref, nvme_free_ns);
 }
 
-static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
-{
-	struct nvme_ns *ns;
-
-	spin_lock(&dev_list_lock);
-	ns = disk->private_data;
-	if (ns) {
-		if (!kref_get_unless_zero(&ns->kref))
-			goto fail;
-		if (!try_module_get(ns->ctrl->ops->module))
-			goto fail_put_ns;
-	}
-	spin_unlock(&dev_list_lock);
-
-	return ns;
-
-fail_put_ns:
-	kref_put(&ns->kref, nvme_free_ns);
-fail:
-	spin_unlock(&dev_list_lock);
-	return NULL;
-}
-
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags, int qid)
 {
@@ -1056,7 +1027,16 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
-	return nvme_get_ns_from_disk(bdev->bd_disk) ? 0 : -ENXIO;
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+
+	if (!kref_get_unless_zero(&ns->kref))
+		return -ENXIO;
+	if (!try_module_get(ns->ctrl->ops->module)) {
+		kref_put(&ns->kref, nvme_free_ns);
+		return -ENXIO;
+	}
+
+	return 0;
 }
 
 static void nvme_release(struct gendisk *disk, fmode_t mode)
-- 
2.14.1
