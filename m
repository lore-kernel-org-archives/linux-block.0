Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 3/8] nvme-loop: quiesce/unquiesce admin_q instead of start/stop its hw queues
Date: Wed,  5 Jul 2017 09:53:06 +0300
Message-Id: <1499237591-15861-4-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 3d51341e62ee..6a0b70685e77 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -434,9 +434,10 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_loop_destroy_admin_queue(ctrl);
 }
 
-- 
2.7.4
