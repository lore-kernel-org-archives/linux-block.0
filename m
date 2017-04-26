Return-Path: <BATV+8090579d37507300b01f+4994+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/3] ide-pm: always pass 0 error to __blk_end_request_all
Date: Wed, 26 Apr 2017 09:34:21 +0200
Message-Id: <20170426073422.14511-3-hch@lst.de>
In-Reply-To: <20170426073422.14511-1-hch@lst.de>
References: <20170426073422.14511-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

ide_pm_execute_rq exectures a PM request synchronously, and in the failure
case where it calls __blk_end_request_all it never checks the error field
passed to the end_io callback, so don't bother setting it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 277c2bb7616f..0977fc1f40ce 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -57,7 +57,7 @@ static int ide_pm_execute_rq(struct request *rq)
 	if (unlikely(blk_queue_dying(q))) {
 		rq->rq_flags |= RQF_QUIET;
 		scsi_req(rq)->result = -ENXIO;
-		__blk_end_request_all(rq, scsi_req(rq)->result);
+		__blk_end_request_all(rq, 0);
 		spin_unlock_irq(q->queue_lock);
 		return -ENXIO;
 	}
-- 
2.11.0
