Return-Path: <BATV+2972572aac770b70d036+5119+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] bsg: remove #if 0'ed code
Date: Tue, 29 Aug 2017 18:48:38 +0200
Message-Id: <20170829164838.29632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bsg.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 37663b664666..ee1335c68de7 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -932,15 +932,8 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		return ret;
 	}
-	/*
-	 * block device ioctls
-	 */
 	default:
-#if 0
-		return ioctl_by_bdev(bd->bdev, cmd, arg);
-#else
 		return -ENOTTY;
-#endif
 	}
 }
 
-- 
2.11.0
