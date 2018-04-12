Return-Path: <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <lvivier@redhat.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    stable@vger.kernel.org
Message-Id: <4c79abea0211e267bdd2f290b0a0b83ebf3de609.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 06/10] block/swim: Don't log an error message for an
 invalid ioctl
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
List-ID: <linux-block@vger.kernel.org>

The 'eject' shell command may send various different ioctl commands.
This leads to error messages on the console even though the FDEJECT
ioctl succeeds.

~# eject floppy
SWIM floppy_ioctl: unknown cmd 21257
SWIM floppy_ioctl: unknown cmd 1

Don't log an error message for an invalid ioctl, just do as the
swim3 driver does and return -ENOTTY.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/swim.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0258a96e0c46..7b847170cf71 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -727,14 +727,9 @@ static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 		if (copy_to_user((void __user *) param, (void *) &floppy_type,
 				 sizeof(struct floppy_struct)))
 			return -EFAULT;
-		break;
-
-	default:
-		printk(KERN_DEBUG "SWIM floppy_ioctl: unknown cmd %d\n",
-		       cmd);
-		return -ENOSYS;
+		return 0;
 	}
-	return 0;
+	return -ENOTTY;
 }
 
 static int floppy_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-- 
2.16.1
