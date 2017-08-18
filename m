Return-Path: <gmazyland@gmail.com>
Return-Path: <gmazyland@gmail.com>
From: Milan Broz <gmazyland@gmail.com>
To: linux-block@vger.kernel.org
Cc: kzak@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] loop: Fix freeze if configured block size is not supported
Date: Fri, 18 Aug 2017 15:07:33 +0200
Message-Id: <20170818130733.11254-1-gmazyland@gmail.com>
List-ID: <linux-block@vger.kernel.org>

The commit f2c6df7dbf9a60e1cd9941f9fb376d4d9ad1e8dd

    loop: support 4k physical blocksize

adds support for loop block size with only specific block sizes.

If the size is not supported, the code returns -EINVAL keeping
the loop queue frozen. This causes that device could be locked
for a long time by processes trying to scan device (udev).
(And also causing subsequent LOOP_CLR_FD operations noop.)

Fix it by using goto to proper exit location with queue unfreeze.

(The same bug is for setting crypt attribute but this code is
probably no more used. Patch fixes it as well though.)

Signed-off-by: Milan Broz <gmazyland@gmail.com>
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
