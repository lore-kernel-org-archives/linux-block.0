Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: [PATCH 3/9] [RFC] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
To: Jens Axboe <axboe@fb.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <fbe7645f-dd98-6325-ef46-e0f1bde2fa3a@sandisk.com>
Date: Mon, 26 Sep 2016 11:27:09 -0700
MIME-Version: 1.0
In-Reply-To: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Make nvme_requeue_req() check BLK_MQ_S_STOPPED instead of
QUEUE_FLAG_STOPPED. Remove the QUEUE_FLAG_STOPPED manipulations
that became superfluous because of this change. Untested.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bd2156c..057f1fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -205,7 +205,7 @@ void nvme_requeue_req(struct request *req)
 
 	blk_mq_requeue_request(req);
 	spin_lock_irqsave(req->q->queue_lock, flags);
-	if (!blk_queue_stopped(req->q))
+	if (!blk_mq_queue_stopped(req->q))
 		blk_mq_kick_requeue_list(req->q);
 	spin_unlock_irqrestore(req->q->queue_lock, flags);
 }
@@ -2082,10 +2082,6 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		spin_lock_irq(ns->queue->queue_lock);
-		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
-		spin_unlock_irq(ns->queue->queue_lock);
-
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
@@ -2099,7 +2095,6 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
-- 
2.10.0

