Return-Path: <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <lvivier@redhat.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    stable@vger.kernel.org
Message-Id: <71b97421bda9d3772d6238297b3c93ecd881309b.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 05/10] block/swim: Remove extra put_disk() call from error
 path
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
List-ID: <linux-block@vger.kernel.org>

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 103db8b2dfa5 ("[PATCH] swim: stop sharing request queue across multiple gendisks")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/swim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 2cdfc0db5966..0258a96e0c46 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -861,7 +861,6 @@ static int swim_floppy_init(struct swim_priv *swd)
 							      &swd->lock);
 		if (!swd->unit[drive].disk->queue) {
 			err = -ENOMEM;
-			put_disk(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
 		blk_queue_bounce_limit(swd->unit[drive].disk->queue,
-- 
2.16.1
