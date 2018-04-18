Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 18 Apr 2018 12:51:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] cdrom: information leak in cdrom_ioctl_media_changed()
Message-ID: <20180418095130.GA26904@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

This cast is wrong.  "cdi->capacity" is an int and "arg" is an unsigned
long.  The way the check is written now, if one of the high 32 bits is
set then we could read outside the info->slots[] array.

This bug is pretty old and it predates git.

Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 8327478effd0..bfc566d3f31a 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2371,7 +2371,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
 		return media_changed(cdi, 1);
 
-	if ((unsigned int)arg >= cdi->capacity)
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
