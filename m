Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 5/8] nvme: kick requeue list when requeueing a request instead of when starting the queues
Date: Wed,  5 Jul 2017 20:00:34 +0300
Message-Id: <1499274037-17438-6-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
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
 1 file changed, 2 insertions(+), 17 deletions(-)

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
-- 
2.7.4
