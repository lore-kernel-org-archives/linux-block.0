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
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
Date: Thu, 19 Jul 2018 15:26:18 -0600
Message-Id: <20180719212618.2406-2-keith.busch@intel.com>
In-Reply-To: <20180719212618.2406-1-keith.busch@intel.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The scsi block layer requires requests claimed be the error handling be
completed by the error handler. A previous commit allowed completions
to proceed for blk-mq, breaking that assumption.

This patch prevents completions that may race with the timeout handler
by marking the state to complete, restoring the previous behavior.

Fixes: 12f5b931 ("blk-mq: Remove generation seqeunce")
Signed-off-by: Keith Busch <keith.busch@intel.com>
---

Tested using Jianchao's abort injection to scsi_debug described here:

  https://lore.kernel.org/lkml/a68ad043-26a1-d3d8-2009-504ba4230e0f@oracle.com/

 drivers/scsi/scsi_error.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8932ae81a15a..86ee10b2c775 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -286,6 +286,9 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 	enum blk_eh_timer_return rtn = BLK_EH_DONE;
 	struct Scsi_Host *host = scmd->device->host;
 
+	if (req->q->mq_ops && blk_mq_mark_complete(req))
+		return rtn;
+
 	trace_scsi_dispatch_cmd_timeout(scmd);
 	scsi_log_completion(scmd, TIMEOUT_ERROR);
 
@@ -300,7 +303,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
 		}
-	}
+	} else if (req->q->mq_ops)
+		WRITE_ONCE(req->state, MQ_RQ_IN_FLIGHT);
 
 	return rtn;
 }
-- 
2.14.4
