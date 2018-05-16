Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH V6 03/11] nvme: pci: unquiesce admin queue after controller is shutdown
Date: Wed, 16 May 2018 12:03:05 +0800
Message-Id: <20180516040313.13596-4-ming.lei@redhat.com>
In-Reply-To: <20180516040313.13596-1-ming.lei@redhat.com>
References: <20180516040313.13596-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Given timeout event can come during reset, nvme_dev_disable() shouldn't
keep admin queue as quiesced after controller is shutdown. Otherwise
it may block admin IO in reset, and cause reset hang forever.

This patch fixes this issue by unquiescing admin queue at the end
of nvme_dev_disable().

Cc: James Smart <james.smart@broadcom.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>
Reported-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b60f727b844c..9e28d7118232 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1557,8 +1557,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			dev->ctrl.admin_q = NULL;
 			return -ENODEV;
 		}
-	} else
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+	}
 
 	return 0;
 }
@@ -2303,6 +2302,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 */
 	if (shutdown)
 		nvme_start_queues(&dev->ctrl);
+
+	/*
+	 * Avoid to stuck reset because timeout may happen during reset and
+	 * reset may hang forever if admin queue is kept as quiesced.
+	 *
+	 * Druing reset, if admin queue isn't ready, the command will be
+	 * failed immediately, that means we don't need to quiesce admin
+	 * queue.
+	 */
+	if (dev->ctrl.admin_q)
+		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
2.9.5
