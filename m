Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33490 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938977AbcKNW40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:56:26 -0500
Received: by mail-pf0-f179.google.com with SMTP id d2so31869042pfd.0
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:56:26 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] loop: return proper error from loop_queue_rq()
Date: Mon, 14 Nov 2016 14:56:17 -0800
Message-Id: <fad6bce50526f8554f47d83d61ae334073075a6d.1479164136.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

->queue_rq() should return one of the BLK_MQ_RQ_QUEUE_* constants, not
an errno.

f4aa4c7bbac6 ("block: loop: convert to per-device workqueue")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1b7a9..4af8187 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1646,7 +1646,7 @@ static int loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(bd->rq);
 
 	if (lo->lo_state != Lo_bound)
-		return -EIO;
+		return BLK_MQ_RQ_QUEUE_ERROR;
 
 	switch (req_op(cmd->rq)) {
 	case REQ_OP_FLUSH:
-- 
2.10.2

