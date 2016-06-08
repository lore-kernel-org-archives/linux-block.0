Return-Path: <BATV+10e0b2ba6b8830823af0+4672+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@lightbits.io,
	ming.l@ssi.samsung.com
Subject: [PATCH 05/11] nvme-loop: set SGL flag on AER
Date: Wed,  8 Jun 2016 14:31:00 +0200
Message-Id: <1465389066-19119-6-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 08b4fbb..94e7829 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -209,6 +209,7 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	memset(&iod->cmd, 0, sizeof(iod->cmd));
 	iod->cmd.common.opcode = nvme_admin_async_event;
 	iod->cmd.common.command_id = NVME_LOOP_AQ_BLKMQ_DEPTH;
+	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
 			&nvme_loop_ops)) {
-- 
2.1.4
