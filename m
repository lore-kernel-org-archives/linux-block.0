Return-Path: <BATV+df5a2477ff0fa86e9985+5386+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 05/14] mtip32xx: complete requests from ->timeout
Date: Wed, 23 May 2018 14:19:32 +0200
Message-Id: <20180523121941.8632-6-hch@lst.de>
In-Reply-To: <20180523121941.8632-1-hch@lst.de>
References: <20180523121941.8632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

By completing the request entirely in the driver we can remove the
BLK_EH_HANDLED return value and thus the split responsibility between the
driver and the block layer that has been causing trouble.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 6df5b0b1517a..beace13effe4 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3720,7 +3720,8 @@ static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
 		struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 
 		cmd->status = BLK_STS_TIMEOUT;
-		return BLK_EH_HANDLED;
+		blk_mq_complete_request(req);
+		return BLK_EH_DONE;
 	}
 
 	if (test_bit(req->tag, dd->port->cmds_to_issue))
-- 
2.17.0
