Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 10/14] mmc: complete requests from ->timeout
Date: Tue, 29 May 2018 15:52:35 +0200
Message-Id: <20180529135239.27005-11-hch@lst.de>
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

By completing the request entirely in the driver we can remove the
BLK_EH_HANDLED return value and thus the split responsibility between the
driver and the block layer that has been causing trouble.

[While this keeps existing behavior it seems to mismatch the comment,
 maintainers please chime in!]

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/mmc/core/queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 56e9a803db21..648eb6743ed5 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -111,8 +111,9 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 				__mmc_cqe_recovery_notifier(mq);
 			return BLK_EH_RESET_TIMER;
 		}
-		/* No timeout */
-		return BLK_EH_HANDLED;
+		/* No timeout (XXX: huh? comment doesn't make much sense) */
+		blk_mq_complete_request(req);
+		return BLK_EH_DONE;
 	default:
 		/* Timeout is handled by mmc core */
 		return BLK_EH_RESET_TIMER;
-- 
2.17.0
