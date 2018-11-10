Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
To: Jens Axboe <axboe@kernel.dk>
CC: YueHaibing <yuehaibing@huawei.com>, <linux-block@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] block: remove set but not used variable 'et'
Date: Sat, 10 Nov 2018 02:41:14 +0000
Message-ID: <1541817674-19370-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

block/blk-ioc.c: In function 'put_io_context_active':
block/blk-ioc.c:174:24: warning:
 variable 'et' set but not used [-Wunused-but-set-variable]

It not used any more after commit
a1ce35fa4985 ("block: remove dead elevator code")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 block/blk-ioc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 007aac6..56755ad 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -171,7 +171,6 @@ void put_io_context(struct io_context *ioc)
  */
 void put_io_context_active(struct io_context *ioc)
 {
-	struct elevator_type *et;
 	unsigned long flags;
 	struct io_cq *icq;
 
@@ -190,7 +189,6 @@ void put_io_context_active(struct io_context *ioc)
 		if (icq->flags & ICQ_EXITED)
 			continue;
 
-		et = icq->q->elevator->type;
 		ioc_exit_icq(icq);
 	}
 	spin_unlock_irqrestore(&ioc->lock, flags);
