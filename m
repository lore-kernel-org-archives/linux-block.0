Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 5/8] nvme: kick requeue list when requeueing a request instead of when starting the queues
Date: Wed,  5 Jul 2017 09:53:08 +0300
Message-Id: <1499237591-15861-6-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

When we requeue a request, we can always insert the request
back to the scheduler instead of doing it when restarting
the queues and kicking the requeue work, so get rid of
the requeue kick in nvme (core and drivers).

Also, now there is no need start hw queues in nvme_kill_queues
We don't stop the hw queues anymore, so no need to
start them.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 19 ++-----------------
 drivers/nvme/host/fc.c   |  4 +---
 drivers/nvme/host/pci.c  |  1 -
 drivers/nvme/host/rdma.c |  1 -
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d70df1d0072d..48cafaa6fbc5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -131,7 +131,7 @@ void nvme_complete_rq(struct request *req)
 {
 	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
 		nvme_req(req)->retries++;
-		blk_mq_requeue_request(req, !blk_mq_queue_stopped(req->q));
+		blk_mq_requeue_request(req, true);
 		return;
 	}
 
@@ -2694,9 +2694,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 
-	/* Forcibly start all queues to avoid having stuck requests */
-	blk_mq_start_hw_queues(ctrl->admin_q);
-
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
@@ -2709,16 +2706,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 
 		/* Forcibly unquiesce queues to avoid blocking dispatch */
 		blk_mq_unquiesce_queue(ns->queue);
-
-		/*
-		 * Forcibly start all queues to avoid having stuck requests.
-		 * Note that we must ensure the queues are not stopped
-		 * when the final removal happens.
-		 */
-		blk_mq_start_hw_queues(ns->queue);
-
-		/* draining requests in requeue list */
-		blk_mq_kick_requeue_list(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
@@ -2787,10 +2774,8 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unquiesce_queue(ns->queue);
-		blk_mq_kick_requeue_list(ns->queue);
-	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e35fc622680..8d55e7827932 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2321,10 +2321,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queue;
 
-	if (ctrl->ctrl.state != NVME_CTRL_NEW) {
+	if (ctrl->ctrl.state != NVME_CTRL_NEW)
 		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-		blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
-	}
 
 	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df7c8a355075..8d8e2eddb3da 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1353,7 +1353,6 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		}
 	} else {
 		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
-		blk_mq_kick_requeue_list(dev->ctrl.admin_q);
 	}
 
 	return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c8bf2606ba64..f2cf9638b4d2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -792,7 +792,6 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	 * new IO
 	 */
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
 	nvme_start_queues(&ctrl->ctrl);
 
 	nvme_rdma_reconnect_or_remove(ctrl);
-- 
2.7.4
