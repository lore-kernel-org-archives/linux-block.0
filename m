Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH rfc 05/10] nvme-pci: Support blk_poll_batch
Date: Thu,  9 Mar 2017 15:16:37 +0200
Message-Id: <1489065402-14757-6-git-send-email-sagi@grimberg.me>
In-Reply-To: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7ad514c2451..f8dcd0bd19f8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -789,6 +789,21 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return found;
 }
 
+static int nvme_poll_batch(struct blk_mq_hw_ctx *hctx, unsigned int batch)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	int completed;
+
+	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+		return 0;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	completed = __nvme_process_cq(nvmeq, batch);
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	return completed;
+}
+
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -1174,6 +1189,7 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
+	.poll_batch	= nvme_poll_batch,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
