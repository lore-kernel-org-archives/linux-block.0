Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33375 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdHXHD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:03:56 -0400
Received: by mail-pg0-f54.google.com with SMTP id t3so12573991pgt.0
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2017 00:03:56 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 3/4] loop: add ioctl for changing logical block size
Date: Thu, 24 Aug 2017 00:03:43 -0700
Message-Id: <f82c988df9c0e3c543089360e3d562c751b63d0f.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is a different approach from the first attempt in f2c6df7dbf9a
("loop: support 4k physical blocksize"). Rather than extending
LOOP_{GET,SET}_STATUS, add a separate ioctl just for setting the block
size.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c      | 24 ++++++++++++++++++++++++
 include/uapi/linux/loop.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1a5b4ecf54ec..6b1d932028e3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1047,6 +1047,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
 	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
+	blk_queue_logical_block_size(lo->lo_queue, 512);
 	if (bdev) {
 		bdput(bdev);
 		invalidate_bdev(bdev);
@@ -1330,6 +1331,24 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 	return error;
 }
 
+static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
+{
+	if (lo->lo_state != Lo_bound)
+		return -ENXIO;
+
+	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
+		return -EINVAL;
+
+	blk_mq_freeze_queue(lo->lo_queue);
+
+	blk_queue_logical_block_size(lo->lo_queue, arg);
+	loop_update_dio(lo);
+
+	blk_mq_unfreeze_queue(lo->lo_queue);
+
+	return 0;
+}
+
 static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
@@ -1378,6 +1397,11 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
 			err = loop_set_dio(lo, arg);
 		break;
+	case LOOP_SET_BLOCK_SIZE:
+		err = -EPERM;
+		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
+			err = loop_set_block_size(lo, arg);
+		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index c8125ec1f4f2..23158dbe2424 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -88,6 +88,7 @@ struct loop_info64 {
 #define LOOP_CHANGE_FD		0x4C06
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
+#define LOOP_SET_BLOCK_SIZE	0x4C09
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.14.1
