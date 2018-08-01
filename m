Return-Path: <gustavo@embeddedor.com>
Date: Wed, 1 Aug 2018 17:30:20 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] aoe: mark expected switch fall-through
Message-ID: <20180801223020.GA11729@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114722 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/aoe/aoecmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 096882e..136dc50 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1137,6 +1137,7 @@ noskb:		if (buf)
 			break;
 		}
 		bvcpy(skb, f->buf->bio, f->iter, n);
+		/* fall through */
 	case ATA_CMD_PIO_WRITE:
 	case ATA_CMD_PIO_WRITE_EXT:
 		spin_lock_irq(&d->lock);
-- 
2.7.4
