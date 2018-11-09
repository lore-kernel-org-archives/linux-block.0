Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/6] skd_main: don't use req->special
Date: Fri,  9 Nov 2018 19:32:05 +0100
Message-Id: <20181109183208.19879-4-hch@lst.de>
In-Reply-To: <20181109183208.19879-1-hch@lst.de>
References: <20181109183208.19879-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Add a retries field to the internal request structure instead, which gets
set to zero on the first submission.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/skd_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a0196477165f..88f29b06d90e 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -181,6 +181,7 @@ struct skd_request_context {
 	struct fit_completion_entry_v1 completion;
 
 	struct fit_comp_error_info err_info;
+	int retries;
 
 	blk_status_t status;
 };
@@ -495,6 +496,11 @@ static blk_status_t skd_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(skdev->state != SKD_DRVR_STATE_ONLINE))
 		return skd_fail_all(q) ? BLK_STS_IOERR : BLK_STS_RESOURCE;
 
+	if (!(req->rq_flags & RQF_DONTPREP)) {
+		skreq->retries = 0;
+		req->rq_flags |= RQF_DONTPREP;
+	}
+
 	blk_mq_start_request(req);
 
 	WARN_ONCE(tag >= skd_max_queue_depth, "%#x > %#x (nr_requests = %lu)\n",
@@ -1426,7 +1432,7 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
 		break;
 
 	case SKD_CHECK_STATUS_REQUEUE_REQUEST:
-		if ((unsigned long) ++req->special < SKD_MAX_RETRIES) {
+		if ((unsigned long) skreq->retries < SKD_MAX_RETRIES) {
 			skd_log_skreq(skdev, skreq, "retry");
 			blk_mq_requeue_request(req, true);
 			break;
-- 
2.19.1
