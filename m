Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36298 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeC0EkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Mar 2018 00:40:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id 91-v6so5594497pld.3
        for <linux-block@vger.kernel.org>; Mon, 26 Mar 2018 21:40:23 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] loop: use killable lock in ioctls
Date: Mon, 26 Mar 2018 21:39:12 -0700
Message-Id: <5637ab0b470930bd180ed7e2436b0f487f27cb9f.1522125370.git.osandov@fb.com>
In-Reply-To: <cover.1522125370.git.osandov@fb.com>
References: <cover.1522125370.git.osandov@fb.com>
In-Reply-To: <cover.1522125370.git.osandov@fb.com>
References: <cover.1522125370.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Even after the previous patch to drop lo_ctl_mutex while calling
vfs_getattr(), there are other cases where we can end up sleeping for a
long time while holding lo_ctl_mutex. Let's avoid the uninterruptible
sleep from the ioctls.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93a60bda7608..264abaaff662 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1360,7 +1360,10 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	mutex_lock_nested(&lo->lo_ctl_mutex, 1);
+	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	if (err)
+		goto out_unlocked;
+
 	switch (cmd) {
 	case LOOP_SET_FD:
 		err = loop_set_fd(lo, mode, bdev, arg);
@@ -1545,16 +1548,20 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		mutex_lock(&lo->lo_ctl_mutex);
-		err = loop_set_status_compat(
-			lo, (const struct compat_loop_info __user *) arg);
-		mutex_unlock(&lo->lo_ctl_mutex);
+		err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		if (!err) {
+			err = loop_set_status_compat(lo,
+						     (const struct compat_loop_info __user *)arg);
+			mutex_unlock(&lo->lo_ctl_mutex);
+		}
 		break;
 	case LOOP_GET_STATUS:
-		mutex_lock(&lo->lo_ctl_mutex);
-		err = loop_get_status_compat(
-			lo, (struct compat_loop_info __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
+		err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		if (!err) {
+			err = loop_get_status_compat(lo,
+						     (struct compat_loop_info __user *)arg);
+			/* loop_get_status() unlocks lo_ctl_mutex */
+		}
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
@@ -1959,7 +1966,9 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		mutex_lock(&lo->lo_ctl_mutex);
+		ret = mutex_lock_killable(&lo->lo_ctl_mutex);
+		if (ret)
+			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
 			mutex_unlock(&lo->lo_ctl_mutex);
-- 
2.16.2
