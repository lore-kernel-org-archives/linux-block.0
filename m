Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34762 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdHRGPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 02:15:38 -0400
Received: by mail-yw0-f171.google.com with SMTP id s143so53530551ywg.1
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2017 23:15:37 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt type
Date: Thu, 17 Aug 2017 23:15:26 -0700
Message-Id: <1ae3e2efdaf3f16bfdd4cf12b1350d49bb6a9026.1503036471.git.osandov@fb.com>
In-Reply-To: <cover.1503036471.git.osandov@fb.com>
References: <cover.1503036471.git.osandov@fb.com>
In-Reply-To: <cover.1503036471.git.osandov@fb.com>
References: <cover.1503036471.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In both of these error cases, we need to make sure to unfreeze the queue
before we return.

Fixes: ecdd09597a57 ("block/loop: fix race between I/O and set_status")
Fixes: f2c6df7dbf9a ("loop: support 4k physical blocksize")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 39fa7f48e0c7..6c7609b3305d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1125,11 +1125,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
-		if (type >= MAX_LO_CRYPT)
-			return -EINVAL;
+		if (type >= MAX_LO_CRYPT) {
+			err = -EINVAL;
+			goto exit;
+		}
 		xfer = xfer_funcs[type];
-		if (xfer == NULL)
-			return -EINVAL;
+		if (xfer == NULL) {
+			err = -EINVAL;
+			goto exit;
+		}
 	} else
 		xfer = NULL;
 
@@ -1142,10 +1146,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		if (lo_logical_blocksize != 512 &&
 		    lo_logical_blocksize != 1024 &&
 		    lo_logical_blocksize != 2048 &&
-		    lo_logical_blocksize != 4096)
-			return -EINVAL;
-		if (lo_logical_blocksize > lo->lo_blocksize)
-			return -EINVAL;
+		    lo_logical_blocksize != 4096) {
+			err = -EINVAL;
+			goto exit;
+		}
+		if (lo_logical_blocksize > lo->lo_blocksize) {
+			err = -EINVAL;
+			goto exit;
+		}
 	} else {
 		lo_logical_blocksize = lo->lo_logical_blocksize;
 	}
-- 
2.14.1
