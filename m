Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35647 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbdCAVeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2017 16:34:46 -0500
Received: by mail-pg0-f43.google.com with SMTP id b129so24286805pgc.2
        for <linux-block@vger.kernel.org>; Wed, 01 Mar 2017 13:34:32 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <tom.leiming@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] loop: fix LO_FLAGS_PARTSCAN hang
Date: Wed,  1 Mar 2017 10:42:38 -0800
Message-Id: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

loop_reread_partitions() needs to do I/O, but we just froze the queue,
so we end up waiting forever. This can easily be reproduced with losetup
-P. Fix it by moving the reread to after we unfreeze the queue.

Fixes: ecdd09597a57 ("block/loop: fix race between I/O and set_status")
Reported-by: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4b52a1690329..132c9f371dce 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1142,13 +1142,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
 		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
 
-	if ((info->lo_flags & LO_FLAGS_PARTSCAN) &&
-	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
-		lo->lo_flags |= LO_FLAGS_PARTSCAN;
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		loop_reread_partitions(lo, lo->lo_device);
-	}
-
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
 	lo->lo_init[0] = info->lo_init[0];
 	lo->lo_init[1] = info->lo_init[1];
@@ -1163,6 +1156,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
  exit:
 	blk_mq_unfreeze_queue(lo->lo_queue);
+
+	if (!err && (info->lo_flags & LO_FLAGS_PARTSCAN) &&
+	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
+		lo->lo_flags |= LO_FLAGS_PARTSCAN;
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+		loop_reread_partitions(lo, lo->lo_device);
+	}
+
 	return err;
 }
 
-- 
2.12.0
