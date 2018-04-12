Return-Path: <fthain@telegraphics.com.au>
Message-Id: <5aceb51a.1c69fb81.faceb.eaf8SMTPIN_ADDED_MISSING@mx.google.com>
Date: Thu, 12 Apr 2018 11:23:38 +1000
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-m68k@lists.linux-m68k.org,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] block/amiflop: Don't log an error message for an invalid
 ioctl
ReSent-Message-ID: <alpine.LNX.2.21.1804121123240.14@nippy.intranet>
List-ID: <linux-block@vger.kernel.org>

Do as the swim3 driver does and just return -ENOTTY.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/amiflop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 3aaf6af3ec23..b9fb794c1255 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1533,9 +1533,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 			return p->type->read_size;
 #endif
 	default:
-		printk(KERN_DEBUG "fd_ioctl: unknown cmd %d for drive %d.",
-		       cmd, drive);
-		return -ENOSYS;
+		return -ENOTTY;
 	}
 	return 0;
 }
-- 
2.16.1
