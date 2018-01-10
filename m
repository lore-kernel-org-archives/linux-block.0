Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933445AbeAJQde (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jan 2018 11:33:34 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] blk-mq: Explain when 'active_queues' is decremented
Date: Wed, 10 Jan 2018 08:33:33 -0800
Message-Id: <20180110163333.14345-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is nontrivial to derive from the blk-mq source code when
blk_mq_tags.active_queues is decremented. Hence add a comment that
explains this.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9aa24c9508f9..266fc4f6b046 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -954,6 +954,12 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		data.next = blk_rq_timeout(round_jiffies_up(data.next));
 		mod_timer(&q->timeout, data.next);
 	} else {
+		/*
+		 * Request timeouts are handled as a forward rolling timer. If
+		 * we end up here it means that no requests are pending and
+		 * also that no request has been pending for a while. Mark
+		 * each hctx as idle.
+		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
 			if (blk_mq_hw_queue_mapped(hctx))
-- 
2.15.1
