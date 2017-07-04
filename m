Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/8] nvme-fc: quiesce/unquiesce admin_q instead of start/stop its hw queues
Date: Tue,  4 Jul 2017 10:55:06 +0300
Message-Id: <1499154912-10420-3-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.
Also make sure to kick the requeue list when appropriate.

Reviewed-By: James Smart <james.smart@broadcom.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 50cc3b2b0e11..d63263f0b530 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2320,8 +2320,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queue;
 
-	if (ctrl->ctrl.state != NVME_CTRL_NEW)
-		blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+	if (ctrl->ctrl.state != NVME_CTRL_NEW) {
+		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+		blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
+	}
 
 	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (ret)
@@ -2475,7 +2477,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * use blk_mq_tagset_busy_itr() and the transport routine to
 	 * terminate the exchanges.
 	 */
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
-- 
2.7.4
