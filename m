Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIRPpe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 11:45:34 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/3] nvme: don't drain IO in nvme_reset_work()
Date: Tue, 18 Sep 2018 18:13:10 +0800
Message-Id: <20180918101310.13154-4-ming.lei@redhat.com>
In-Reply-To: <20180918101310.13154-1-ming.lei@redhat.com>
References: <20180918101310.13154-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

After the controller is recovered, it isn't necessary to wait for
completion of all in-flight IO. More importantly, it is easy to trigger
deadlock if there is new IO timeout triggered.

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 12 ++++++++----
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/pci.c  |  3 +--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..cf6a2267d44e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1203,7 +1203,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	if (effects & NVME_CMD_EFFECTS_LBCC)
 		nvme_update_formats(ctrl);
 	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
-		nvme_unfreeze(ctrl);
+		nvme_unfreeze(ctrl, true);
 	if (effects & NVME_CMD_EFFECTS_CCC)
 		nvme_init_identify(ctrl);
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
@@ -3602,13 +3602,17 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
-void nvme_unfreeze(struct nvme_ctrl *ctrl)
+void nvme_unfreeze(struct nvme_ctrl *ctrl, bool check_io_drained)
 {
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unfreeze_queue(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if  (check_io_drained)
+			blk_mq_unfreeze_queue(ns->queue);
+		else
+			blk_mq_unfreeze_queue_no_drain_io(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..fd56270637d1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -432,7 +432,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
-void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_unfreeze(struct nvme_ctrl *ctrl, bool check_io_drained);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..1c26a2e92063 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2328,11 +2328,10 @@ static void nvme_reset_work(struct work_struct *work)
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+		nvme_unfreeze(&dev->ctrl, false);
 	}
 
 	/*
-- 
2.9.5
