Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 4/8] nvme-pci: quiesce/unquiesce admin_q instead of start/stop its hw queues
Date: Wed,  5 Jul 2017 20:00:33 +0300
Message-Id: <1499274037-17438-5-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eb729ff70e7d..d9c0010a9bbc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1125,7 +1125,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
+		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
 
 	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
 
@@ -1315,7 +1315,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 * user requests may be waiting on a stopped queue. Start the
 		 * queue to flush these to completion.
 		 */
-		blk_mq_start_stopped_hw_queues(dev->ctrl.admin_q, true);
+		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
@@ -1352,7 +1352,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			return -ENODEV;
 		}
 	} else
-		blk_mq_start_stopped_hw_queues(dev->ctrl.admin_q, true);
+		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 
 	return 0;
 }
-- 
2.7.4
