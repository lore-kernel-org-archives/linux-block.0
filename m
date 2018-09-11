Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme-pci: discard the cq_vector checking in nvme_queue_rq
Date: Tue, 11 Sep 2018 17:48:14 +0800
Message-Id: <1536659294-2321-5-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

updating nr_hw_queue uses bios retrieving to drain queues, so we
needn't the the cq_vector checking any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e60edf..615192f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -813,13 +813,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(nvmeq->cq_vector < 0))
-		return BLK_STS_IOERR;
-
 	ret = nvme_setup_cmd(ns, req, &cmnd);
 	if (ret)
 		return ret;
-- 
2.7.4
