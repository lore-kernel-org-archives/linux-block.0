Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/6] nvme: move the dying queue check from cancel to completion
Date: Thu,  2 Nov 2017 21:28:51 +0300
Message-Id: <20171102182856.9162-2-hch@lst.de>
In-Reply-To: <20171102182856.9162-1-hch@lst.de>
References: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

With multipath we don't want a hard DNR bit on a request that is cancelled
by a controller reset, but instead want to be able to retry it on another
patch.  To archive this don't always set the DNR bit when the queue is
dying in nvme_cancel_request, but defer that decision to
nvme_req_needs_retry.  Note that it applies to any command there and not
just cancelled commands, but one the queue is dying that is the right
thing to do anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07b9f4e1c283..1c2686d4eaf3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -172,6 +172,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
 		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
+	if (blk_queue_dying(req->q))
+		return false;
 	return true;
 }
 
@@ -189,18 +191,13 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
-	int status;
-
 	if (!blk_mq_request_started(req))
 		return;
 
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
-	status = NVME_SC_ABORT_REQ;
-	if (blk_queue_dying(req->q))
-		status |= NVME_SC_DNR;
-	nvme_req(req)->status = status;
+	nvme_req(req)->status = NVME_SC_ABORT_REQ;
 	blk_mq_complete_request(req);
 
 }
-- 
2.14.2
