Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54513 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeARQhI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 11:37:08 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] dm rq: Avoid that request processing stalls sporadically
Date: Thu, 18 Jan 2018 08:37:07 -0800
Message-Id: <20180118163707.11825-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If the .queue_rq() implementation of a block driver returns
BLK_STS_RESOURCE then that block driver is responsible for
rerunning the queue once the condition that caused it to return
BLK_STS_RESOURCE has been cleared. The dm-mpath driver tells the
dm core to requeue a request if e.g. not enough memory is
available for cloning a request or if the underlying path is
busy. Since the dm-mpath driver does not receive any kind of
notification if the condition that caused it to return "requeue"
is cleared, the only solution to avoid that dm-mpath request
processing stalls is to call blk_mq_delay_run_hw_queue(). Hence
this patch.

Fixes: ec3eaf9a6731 ("dm mpath: don't call blk_mq_delay_run_hw_queue() in case of BLK_STS_RESOURCE")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-rq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index f16096af879a..c59c59cfd2a5 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -761,6 +761,7 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		/* Undo dm_start_request() before requeuing */
 		rq_end_stats(md, rq);
 		rq_completed(md, rq_data_dir(rq), false);
+		blk_mq_delay_run_hw_queue(hctx, 100/*ms*/);
 		return BLK_STS_RESOURCE;
 	}
 
-- 
2.15.1
