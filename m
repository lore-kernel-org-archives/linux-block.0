Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdJKJxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 05:53:16 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/3] nvme: introduce nvme_reinit_tagset
Date: Wed, 11 Oct 2017 12:53:07 +0300
Message-Id: <1507715588-1041-3-git-send-email-sagi@grimberg.me>
In-Reply-To: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
References: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Move blk_mq_reinit_tagset from blk-mq to nvme core
as the only user of it. Current transports that use
it (rdma, fc) simply implement .reinit_request op.

This patch does not change any functionality.

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/fc.c   |  3 ++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c |  7 +++----
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26c8913435b2..7414e25a75f0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2944,6 +2944,16 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
+{
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
index b8e0822127c1..372a0685b12a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2393,7 +2393,7 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	nvme_fc_init_io_queues(ctrl);
 
-	ret = blk_mq_reinit_tagset(&ctrl->tag_set, nvme_fc_reinit_request);
+	ret = nvme_reinit_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
 	if (ret)
 		goto out_free_io_queues;
 
@@ -2753,6 +2753,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_del_nvme_ctrl,
 	.get_address		= nvmf_get_address,
+	.reinit_request		= nvme_fc_reinit_request,
 };
 
 static void
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index df787f39f4c1..cb9d93048f3d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	int (*reinit_request)(void *data, struct request *rq);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
@@ -311,6 +312,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff5fb4d..039f38cb6987 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -774,8 +774,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			goto out_free_tagset;
 		}
 	} else {
-		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set,
-					     nvme_rdma_reinit_request);
+		error = nvme_reinit_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 		if (error)
 			goto out_free_queue;
 	}
@@ -855,8 +854,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set,
-					   nvme_rdma_reinit_request);
+		ret = nvme_reinit_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
 		if (ret)
 			goto out_free_io_queues;
 
@@ -1845,6 +1843,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_del_ctrl,
 	.get_address		= nvmf_get_address,
+	.reinit_request		= nvme_rdma_reinit_request,
 };
 
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
-- 
2.7.4
