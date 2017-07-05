Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of start/stop its hw queues
Date: Wed,  5 Jul 2017 20:00:30 +0300
Message-Id: <1499274037-17438-2-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.
Also make sure to kick the requeue list when appropriate.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cfb22531fc16..f2cf9638b4d2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -778,7 +778,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->ctrl.queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->ctrl.queue_count > 1)
@@ -791,7 +791,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	 * queues are not a live anymore, so restart the queues to fail fast
 	 * new IO
 	 */
-	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_start_queues(&ctrl->ctrl);
 
 	nvme_rdma_reconnect_or_remove(ctrl);
@@ -1636,9 +1636,10 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl);
 }
 
-- 
2.7.4
