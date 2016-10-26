Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:11720
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933860AbcJZW4m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2016 18:56:42 -0400
Subject: [PATCH 12/12] nvme: Fix a race condition related to stopping queues
To: Jens Axboe <axboe@fb.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <c84a33ce-e601-400b-f4c5-9c2ae4904f4f@sandisk.com>
Date: Wed, 26 Oct 2016 15:56:28 -0700
MIME-Version: 1.0
In-Reply-To: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that nvme_queue_rq() is still running when nvme_stop_queues()
returns.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b662416..d6ab9a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -201,13 +201,7 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 
 void nvme_requeue_req(struct request *req)
 {
-	unsigned long flags;
-
-	blk_mq_requeue_request(req, false);
-	spin_lock_irqsave(req->q->queue_lock, flags);
-	if (!blk_mq_queue_stopped(req->q))
-		blk_mq_kick_requeue_list(req->q);
-	spin_unlock_irqrestore(req->q->queue_lock, flags);
+	blk_mq_requeue_request(req, !blk_mq_queue_stopped(req->q));
 }
 EXPORT_SYMBOL_GPL(nvme_requeue_req);
 
@@ -2079,8 +2073,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		blk_mq_cancel_requeue_work(ns->queue);
-		blk_mq_stop_hw_queues(ns->queue);
+		struct request_queue *q = ns->queue;
+
+		blk_mq_cancel_requeue_work(q);
+		blk_mq_stop_hw_queues(q);
+		blk_mq_quiesce_queue(q);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.10.1

