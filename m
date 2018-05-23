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
Subject: [PATCH 04/14] nbd: complete requests from ->timeout
Date: Wed, 23 May 2018 14:19:31 +0200
Message-Id: <20180523121941.8632-5-hch@lst.de>
In-Reply-To: <20180523121941.8632-1-hch@lst.de>
References: <20180523121941.8632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

By completing the request entirely in the driver we can remove the
BLK_EH_HANDLED return value and thus the split responsibility between the
driver and the block layer that has been causing trouble.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 09d9959287fe..30a851b8a99c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -300,7 +300,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
-		return BLK_EH_HANDLED;
+		goto done;
 	}
 	config = nbd->config;
 
@@ -338,8 +338,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
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
