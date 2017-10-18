Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:55199 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934046AbdJRMkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 08:40:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id o44so4857466wrf.11
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2017 05:40:25 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: [PATCH] block: move CAP_SYS_ADMIN check in blkdev_roset()
Date: Wed, 18 Oct 2017 14:38:38 +0200
Message-Id: <1508330318-19456-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Check for CAP_SYS_ADMIN before calling into the driver, similar to
blkdev_flushbuf().  This is safer and can spare a check in the driver.

(Currently BLKROSET is overridden by md and rbd, rbd is missing the
check.  md has the check, but it covers a lot more than BLKROSET.)

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
Al, this appears to go back to your "[PATCH] block ioctl cleanup",
history commit c6973580141c.  2002 was a long time ago, but still ;)
Was there a reason you made BLKFLSBUF check for CAP_SYS_ADMIN before
->ioctl() and BLKROSET after?
---
 block/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 0de02ee67eed..3f81bc50ac00 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -437,11 +437,12 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 {
 	int ret, n;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	ret = __blkdev_driver_ioctl(bdev, mode, cmd, arg);
 	if (!is_unrecognized_ioctl(ret))
 		return ret;
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
 	set_device_ro(bdev, n);
-- 
2.4.3
