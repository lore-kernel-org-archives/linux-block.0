Return-Path: <gustavo@embeddedor.com>
Date: Tue, 2 Oct 2018 12:24:40 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pktcdvd: fix fall-through annotation
Message-ID: <20181002102440.GA2888@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 6f1d25c..9381f4e 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2645,7 +2645,7 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 		 */
 		if (pd->refcnt == 1)
 			pkt_lock_door(pd, 0);
-		/* fallthru */
+		/* fall through */
 	/*
 	 * forward selected CDROM ioctls to CD-ROM, for UDF
 	 */
-- 
2.7.4
