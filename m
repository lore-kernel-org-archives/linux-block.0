Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 09/12] nvme: submit AEN event configuration on startup
Date: Wed, 30 May 2018 18:45:57 +0200
Message-Id: <20180530164600.26856-10-hch@lst.de>
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

We should register for AEN events; some law-abiding targets might
not be sending us AENs otherwise.

Signed-off-by: Hannes Reinecke <hare@suse.com>
[hch: slight cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 86cb78653155..c0bc76d98194 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1030,6 +1030,21 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+#define NVME_AEN_SUPPORTED \
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT)
+
+static void nvme_enable_aen(struct nvme_ctrl *ctrl)
+{
+	u32 result;
+	int status;
+
+	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
+			ctrl->oaes & NVME_AEN_SUPPORTED, NULL, 0, &result);
+	if (status)
+		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
+			 ctrl->oaes & NVME_AEN_SUPPORTED);
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
@@ -2347,6 +2362,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
+	ctrl->oaes = le32_to_cpu(id->oaes);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
@@ -3379,6 +3395,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
+		nvme_enable_aen(ctrl);
 		queue_work(nvme_wq, &ctrl->async_event_work);
 		nvme_start_queues(ctrl);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ec6e4acc4d48..dcf9e9592c1a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -176,6 +176,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u32 oaes;
 	u32 aen_result;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
-- 
2.17.0
