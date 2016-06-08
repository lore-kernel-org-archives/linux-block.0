Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52514 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423697AbcFHMb2 (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2016 08:31:28 -0400
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@lightbits.io, ming.l@ssi.samsung.com
Subject: [PATCH 06/11] nvme-rdma: set SGL flag on AER
Date: Wed,  8 Jun 2016 14:31:01 +0200
Message-Id: <1465389066-19119-7-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e938ab6..d8574f4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1105,6 +1105,7 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->common.opcode = nvme_admin_async_event;
 	cmd->common.command_id = NVME_RDMA_AQ_BLKMQ_DEPTH;
+	cmd->common.flags |= NVME_CMD_SGL_METABUF;
 	nvme_rdma_set_sg_null(cmd);
 
 	ib_dma_sync_single_for_device(dev, sqe->dma, sizeof(*cmd),
-- 
2.1.4

