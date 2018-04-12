Return-Path: <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <lvivier@redhat.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    stable@vger.kernel.org
Message-Id: <bd4e42a4e661ced92849d33bdc3ebf8d4f283dc8.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 08/10] block/swim: Check drive type
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
List-ID: <linux-block@vger.kernel.org>

The SWIM chip is compatible with GCR-mode Sony 400K/800K drives but
this driver only supports MFM mode. Therefore only Sony FDHD drives
are supported. Skip incompatible drives.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index d1ee4670666a..c8c8b9da3edd 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -829,10 +829,12 @@ static int swim_floppy_init(struct swim_priv *swd)
 	/* scan floppy drives */
 
 	swim_drive(base, INTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, INTERNAL_DRIVE);
 	swim_drive(base, EXTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
 
 	/* register floppy drives */
-- 
2.16.1
