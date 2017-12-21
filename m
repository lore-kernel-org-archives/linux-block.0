Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/3] nvme/pci: Start request after doorbell ring
Date: Thu, 21 Dec 2017 13:46:34 -0700
Message-Id: <20171221204636.2924-2-keith.busch@intel.com>
In-Reply-To: <20171221204636.2924-1-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This is a performance optimization that allows the hardware to work on
a command in parallel with the kernel's stats and timeout tracking.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3c9082..df5550ce0531 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -886,8 +886,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_cleanup_iod;
 	}
 
-	blk_mq_start_request(req);
-
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
 		ret = BLK_STS_IOERR;
@@ -895,6 +893,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_cleanup_iod;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
+	blk_mq_start_request(req);
 	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
-- 
2.13.6
