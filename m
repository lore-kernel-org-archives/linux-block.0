Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34846 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRT1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 15:27:46 -0400
Received: by mail-pg0-f43.google.com with SMTP id v189so69865143pgd.2
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 12:27:45 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 1/3] loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt type
Date: Fri, 18 Aug 2017 12:27:35 -0700
Message-Id: <e2dd7f3047089488cf30b3cb71e0d1293285bb2f.1503084216.git.osandov@fb.com>
In-Reply-To: <cover.1503084216.git.osandov@fb.com>
References: <cover.1503084216.git.osandov@fb.com>
In-Reply-To: <cover.1503084216.git.osandov@fb.com>
References: <cover.1503084216.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In both of these error cases, we need to make sure to unfreeze the queue
before we return.

Fixes: ecdd09597a57 ("block/loop: fix race between I/O and set_status")
Fixes: f2c6df7dbf9a ("loop: support 4k physical blocksize")
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef8334949b42..26548e07bc31 100644
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
 
@@ -1144,10 +1148,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		if (LO_INFO_BLOCKSIZE(info) != 512 &&
 		    LO_INFO_BLOCKSIZE(info) != 1024 &&
 		    LO_INFO_BLOCKSIZE(info) != 2048 &&
-		    LO_INFO_BLOCKSIZE(info) != 4096)
-			return -EINVAL;
-		if (LO_INFO_BLOCKSIZE(info) > lo->lo_blocksize)
-			return -EINVAL;
+		    LO_INFO_BLOCKSIZE(info) != 4096) {
+			err = -EINVAL;
+			goto exit;
+		}
+		if (LO_INFO_BLOCKSIZE(info) > lo->lo_blocksize) {
+			err = -EINVAL;
+			goto exit;
+		}
 	}
 
 	if (lo->lo_offset != info->lo_offset ||
-- 
2.14.1
