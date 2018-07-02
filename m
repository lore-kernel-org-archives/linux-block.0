Return-Path: <gustavo@embeddedor.com>
Date: Mon, 2 Jul 2018 12:52:06 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] block/loop: mark expected switch fall-through
Message-ID: <20180702175206.GA18848@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6b6f43..ac47c23 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1611,6 +1611,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_GET_STATUS64:
 	case LOOP_SET_STATUS64:
 		arg = (unsigned long) compat_ptr(arg);
+		/* fall through */
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 		err = lo_ioctl(bdev, mode, cmd, arg);
-- 
2.7.4
