Return-Path: <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <lvivier@redhat.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    stable@vger.kernel.org
Message-Id: <7f3cf4519b38aeadb3c2211629689dce920fe610.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 10/10] block/swim: Select appropriate drive on device open
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
List-ID: <linux-block@vger.kernel.org>

The driver supports internal and external FDD units so the floppy_open
function must not hard-code the drive location.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 2c75761b61e8..0e31884a9519 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -648,7 +648,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
 	udelay(10);
-	swim_drive(base, INTERNAL_DRIVE);
+	swim_drive(base, fs->location);
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
 	if (fs->ejected)
-- 
2.16.1
