Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Josef Bacik <jbacik@fb.com>
Subject: [PATCH 5/8] nbd: quiesce request queues to make sure no submissions are inflight
Date: Tue,  4 Jul 2017 10:55:09 +0300
Message-Id: <1499154912-10420-6-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

We must make sure that no requests are being queued before we iterate
over the tags. quiesce/unquiesce the request queue istead of start/stop
hw queues.

Cc: Josef Bacik <jbacik@fb.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 977ec960dd2f..dea7d85134ee 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -661,9 +661,9 @@ static void nbd_clear_req(struct request *req, void *data, bool reserved)
 
 static void nbd_clear_que(struct nbd_device *nbd)
 {
-	blk_mq_stop_hw_queues(nbd->disk->queue);
+	blk_mq_quiesce_queue(nbd->disk->queue);
 	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
-	blk_mq_start_hw_queues(nbd->disk->queue);
+	blk_mq_unquiesce_queue(nbd->disk->queue);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
-- 
2.7.4
