Return-Path: <BATV+449e860d3caae2166dba+5408+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: [PATCH 1/2] nvme: remove nvme_reinit_tagset
Date: Thu, 14 Jun 2018 14:30:14 +0200
Message-Id: <20180614123015.5989-2-hch@lst.de>
In-Reply-To: <20180614123015.5989-1-hch@lst.de>
References: <20180614123015.5989-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Unused now that all transports stopped using it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 10 ----------
 drivers/nvme/host/nvme.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dee8e71baf62..020a00f932a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3627,16 +3627,6 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
-{
-	if (!ctrl->ops->reinit_request)
-		return 0;
-
-	return blk_mq_tagset_iter(set, set->driver_data,
-			ctrl->ops->reinit_request);
-}
-EXPORT_SYMBOL_GPL(nvme_reinit_tagset);
-
 int __init nvme_core_init(void)
 {
 	int result = -ENOMEM;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 34df07d44f80..231807cbc849 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -321,7 +321,6 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
-	int (*reinit_request)(void *data, struct request *rq);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 };
 
@@ -416,7 +415,6 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
-int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
-- 
2.17.1
