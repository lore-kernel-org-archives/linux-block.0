Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58212 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeFVUSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 16:18:10 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Andrew Randrianasulu <randrianasulu@gmail.com>
Subject: [PATCH] blk-mq: Fix timeout handling in case the timeout handler returns BLK_EH_DONE
Date: Fri, 22 Jun 2018 13:18:09 -0700
Message-Id: <20180622201809.25519-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make sure that RQF_TIMED_OUT is cleared when a request is reused
after a block driver timeout handler has returned BLK_EH_DONE.

Fixes: da6612673988 ("blk-mq: don't time out requests again that are in the timeout handler")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>
---
 block/blk-mq.c      | 1 -
 block/blk-timeout.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b97cb6fed3bd..8c00fcd300b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -785,7 +785,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
 	}
 
-	req->rq_flags &= ~RQF_TIMED_OUT;
 	blk_add_timer(req);
 }
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index c788255b18ad..d72e9071b17f 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -213,6 +213,7 @@ void blk_add_timer(struct request *req)
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
+	req->rq_flags &= ~RQF_TIMED_OUT;
 	blk_rq_set_deadline(req, jiffies + req->timeout);
 
 	/*
-- 
2.17.1
