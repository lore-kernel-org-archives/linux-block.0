Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:13657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeJPJW3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Oct 2018 05:22:29 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: Jens Axboe <axboe@kernel.dk>
CC: YueHaibing <yuehaibing@huawei.com>, <linux-block@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] null_blk: remove set but not used variable 'q'
Date: Tue, 16 Oct 2018 01:45:26 +0000
Message-ID: <1539654326-165410-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/block/null_blk_main.c: In function 'end_cmd':
drivers/block/null_blk_main.c:609:24: warning:
 variable 'q' set but not used [-Wunused-but-set-variable]

It not used any more after commit
e50b1e327aeb ("null_blk: remove legacy IO path")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/null_blk_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 0b302d7..e945910 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -606,12 +606,8 @@ static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, int can_wait)
 
 static void end_cmd(struct nullb_cmd *cmd)
 {
-	struct request_queue *q = NULL;
 	int queue_mode = cmd->nq->dev->queue_mode;
 
-	if (cmd->rq)
-		q = cmd->rq->q;
-
 	switch (queue_mode)  {
 	case NULL_Q_MQ:
 		blk_mq_end_request(cmd->rq, cmd->error);
