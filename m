Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: axboe@kernel.dk, jack@suse.cz, gmazyland@gmail.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH v2] loop: remember whether sysfs_create_group() succeeded
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
	<201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
	<6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
	<201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
	<a3c15779-226c-5e26-6be2-68397a8b3d04@kernel.dk>
In-Reply-To: <a3c15779-226c-5e26-6be2-68397a8b3d04@kernel.dk>
Message-Id: <201805050114.GDF05771.JVtFOQMLOSFFHO@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 01:14:41 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Jens Axboe wrote:
> > The loop module ignores sysfs_create_group() failure and pretends that
> > LOOP_SET_FD request succeeded. I guess that the author of commit
> > ee86273062cbb310 ("loop: add some basic read-only sysfs attributes")
> > assumed that it is not a fatal error enough to abort LOOP_SET_FD request.
> > 
> > Do we want to abort LOOP_SET_FD request if sysfs_create_group() failed?
> 
> Probably safer to retain that behavior.

OK.

> 
> >> If that's not easily done, then my next suggestion would be to
> >> use a loop flag for it, LO_FLAGS_SYSFS_SETUP or something like that.
> > 
> > Yes, that would be possible.
> 
> Let's make that change.

Since LO_FLAGS_* are defined in include/uapi/linux/loop.h as userspace visible
flags, I feel that using "struct loop_device"->lo_flags for recording whether
sysfs entry exists might be strange... Anyway, updated patch is shown below.



>>From c9897b6387b13b533c32dcc624e12a93f23224d0 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 00:52:59 +0900
Subject: [PATCH v2] loop: remember whether sysfs_create_group() succeeded

syzbot is hitting WARN() triggered by memory allocation fault
injection [1] because loop module is calling sysfs_remove_group()
when sysfs_create_group() failed.

Fix this by remembering whether sysfs_create_group() succeeded.
To remember it, userspace visible API flag LO_FLAGS_SYSFS_ENTRY is
introduced. This flag indicates that sysfs entries are available, and
should be always set if CONFIG_SYSFS=y because sysfs entries will be
created unless fault injection prevents it.

[1] https://syzkaller.appspot.com/bug?id=3f86c0edf75c86d2633aeb9dd69eccc70bc7e90b

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+9f03168400f56df89dbc6f1751f4458fe739ff29@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/loop.c      | 6 ++++--
 include/uapi/linux/loop.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5d4e316..499eafd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -951,7 +951,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << 9);
-	loop_sysfs_init(lo);
+	if (IS_ENABLED(CONFIG_SYSFS) && loop_sysfs_init(lo) == 0)
+		lo->lo_flags |= LO_FLAGS_SYSFS_ENTRY;
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 
@@ -1070,7 +1071,8 @@ static int loop_clr_fd(struct loop_device *lo)
 		invalidate_bdev(bdev);
 	}
 	set_capacity(lo->lo_disk, 0);
-	loop_sysfs_exit(lo);
+	if (lo->lo_flags & LO_FLAGS_SYSFS_ENTRY)
+		loop_sysfs_exit(lo);
 	if (bdev) {
 		bd_set_size(bdev, 0);
 		/* let user-space know about this change */
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df..5de1eaa6 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -23,6 +23,7 @@ enum {
 	LO_FLAGS_AUTOCLEAR	= 4,
 	LO_FLAGS_PARTSCAN	= 8,
 	LO_FLAGS_DIRECT_IO	= 16,
+	LO_FLAGS_SYSFS_ENTRY    = 32,
 };
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
-- 
1.8.3.1
