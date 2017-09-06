Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvme: introduce nvme_reinit_tagset
Date: Wed,  6 Sep 2017 18:30:31 +0300
Message-Id: <1504711832-28425-3-git-send-email-sagi@grimberg.me>
In-Reply-To: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
References: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Move blk_mq_reinit_tagset from blk-mq to nvme core
as the only user of it. Current transports that use
it (rdma, fc) simply implement .reinit_request op.

This patch does not change any functionality.

Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 13 +++++++++++++
 drivers/nvme/host/fc.c   |  3 ++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c |  7 +++----
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 277a7a02cba5..beeb51d0eecc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2942,6 +2942,19 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+int nvme_reinit_tagset(struct nvme_ctrl *ctrl, bool admin)
+{
+	struct blk_mq_tag_set *set = admin ?
+			ctrl->admin_tagset : ctrl->tagset;
+
+	if (!ctrl->ops->reinit_request)
+		return 0;
+
+	return blk_mq_tagset_iter(set, set->driver_data,
+			ctrl->ops->reinit_request);
+}
+EXPORT_SYMBOL_GPL(nvme_reinit_tagset);
+
 int __init nvme_core_init(void)
 {
 	int result;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d2e882c0f496..310be96543f8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2336,7 +2336,7 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	nvme_fc_init_io_queues(ctrl);
 
-	ret = blk_mq_reinit_tagset(&ctrl->tag_set, nvme_fc_reinit_request);
+	ret = nvme_reinit_tagset(&ctrl->ctrl, false);
 	if (ret)
 		goto out_free_io_queues;
 
@@ -2696,6 +2696,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_del_nvme_ctrl,
 	.get_address		= nvmf_get_address,
+	.reinit_request		= nvme_fc_reinit_request,
 };
 
 static void
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a19a587d60ed..ce51fc55a502 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -229,6 +229,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	int (*reinit_request)(void *data, struct request *rq);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
@@ -303,6 +304,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+int nvme_reinit_tagset(struct nvme_ctrl *ctrl, bool admin);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6a7682620d87..4697af602ad4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -767,8 +767,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			goto out_free_tagset;
 		}
 	} else {
-		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set,
-					     nvme_rdma_reinit_request);
+		error = nvme_reinit_tagset(&ctrl->ctrl, true);
 		if (error)
 			goto out_free_queue;
 	}
@@ -848,8 +847,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set,
-					   nvme_rdma_reinit_request);
+		ret = nvme_reinit_tagset(&ctrl->ctrl, false);
 		if (ret)
 			goto out_free_io_queues;
 
@@ -1821,6 +1819,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_del_ctrl,
 	.get_address		= nvmf_get_address,
+	.reinit_request		= nvme_rdma_reinit_request,
 };
 
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
-- 
2.7.4
