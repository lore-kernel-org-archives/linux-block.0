Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
Date: Mon, 23 Jul 2018 08:37:51 -0600
Message-Id: <20180723143751.10843-2-keith.busch@intel.com>
In-Reply-To: <20180723143751.10843-1-keith.busch@intel.com>
References: <20180723143751.10843-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The scsi block layer requires requests claimed by the error handling be
completed by the error handler. A previous commit allowed completions
to proceed for blk-mq, breaking that assumption.

This patch prevents completions that may race with the timeout handler
by marking the state to complete, restoring the previous behavior.

Fixes: 12f5b931 ("blk-mq: Remove generation seqeunce")
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

  Document why this is necessary in code comments.

  Update to API's changed return value

 drivers/scsi/scsi_error.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8932ae81a15a..2715cdaa669c 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -296,6 +296,20 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 		rtn = host->hostt->eh_timed_out(scmd);
 
 	if (rtn == BLK_EH_DONE) {
+		/*
+		 * For blk-mq, we must set the request state to complete now
+		 * before sending the request to the scsi error handler. This
+		 * will prevent a use-after-free in the event the LLD manages
+		 * to complete the request before the error handler finishes
+		 * processing this timed out request.
+		 *
+		 * If the request was already completed, then the LLD beat the
+		 * time out handler from transferring the request to the scsi
+		 * error handler. In that case we can return immediately as no
+		 * further action is required.
+		 */
+		if (req->q->mq_ops && !blk_mq_mark_complete(req))
+			return rtn;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
-- 
2.14.4
