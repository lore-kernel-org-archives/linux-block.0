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
Subject: [PATCH 06/14] nbd: complete requests from ->timeout
Date: Tue, 29 May 2018 15:52:31 +0200
Message-Id: <20180529135239.27005-7-hch@lst.de>
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

By completing the request entirely in the driver we can remove the
BLK_EH_HANDLED return value and thus the split responsibility between the
driver and the block layer that has been causing trouble.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/block/nbd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 88ae833aabe9..8860b24098bc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -304,7 +304,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
-		return BLK_EH_HANDLED;
+		goto done;
 	}
 	config = nbd->config;
 
@@ -342,8 +342,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	cmd->status = BLK_STS_IOERR;
 	sock_shutdown(nbd);
 	nbd_config_put(nbd);
-
-	return BLK_EH_HANDLED;
+done:
+	blk_mq_complete_request(req);
+	return BLK_EH_DONE;
 }
 
 /*
-- 
2.17.0
