Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 10/12] nvme: mark nvme_queue_scan static
Date: Wed, 30 May 2018 18:45:58 +0200
Message-Id: <20180530164600.26856-11-hch@lst.de>
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

And move it toward the top of the file to avoid a forward declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c | 19 +++++++++----------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c0bc76d98194..06cd04dcffbc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -100,6 +100,15 @@ static struct class *nvme_subsys_class;
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 
+static void nvme_queue_scan(struct nvme_ctrl *ctrl)
+{
+	/*
+	 * Only new queue scan work when admin and IO queues are both alive
+	 */
+	if (ctrl->state == NVME_CTRL_LIVE)
+		queue_work(nvme_wq, &ctrl->scan_work);
+}
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -3214,16 +3223,6 @@ static void nvme_scan_work(struct work_struct *work)
 	kfree(id);
 }
 
-void nvme_queue_scan(struct nvme_ctrl *ctrl)
-{
-	/*
-	 * Only new queue scan work when admin and IO queues are both alive
-	 */
-	if (ctrl->state == NVME_CTRL_LIVE)
-		queue_work(nvme_wq, &ctrl->scan_work);
-}
-EXPORT_SYMBOL_GPL(nvme_queue_scan);
-
 /*
  * This function iterates the namespace list unlocked to allow recovery from
  * controller failure. It is up to the caller to ensure the namespace list is
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dcf9e9592c1a..11681278fdf6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -395,7 +395,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
-void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
-- 
2.17.0
