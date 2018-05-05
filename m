Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: INFO: task hung in blk_freeze_queue
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <001a113f64ee97b27105649a7cb2@google.com>
 <CACT4Y+asg_NsnCsmP_7CmtL+RrTL=boazGM_mig2dhQnfsk70Q@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <69fc11b3-9d6a-5afb-3521-abd007ac9ad0@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 13:26:38 +0900
MIME-Version: 1.0
In-Reply-To: <CACT4Y+asg_NsnCsmP_7CmtL+RrTL=boazGM_mig2dhQnfsk70Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

A patch for this specific report is ready. I don't know whether other
"dup" reports will be solved by this patch. Thus, I "undup" this report.

#syz undup

>From eed54c6ae475860a9c63b37b58f34735e792eef7 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 12:59:12 +0900
Subject: [PATCH] block/loop: Add recursion check for LOOP_CHANGE_FD request.

syzbot is reporting hung tasks at blk_freeze_queue() [1]. This is
due to ioctl(loop_fd, LOOP_CHANGE_FD, loop_fd) request which should be
rejected. Fix this by adding same recursion check which is used by
LOOP_SET_FD request.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/loop.c | 59 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5d4e316..cee3c01 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -644,6 +644,34 @@ static void loop_reread_partitions(struct loop_device *lo,
 			__func__, lo->lo_number, lo->lo_file_name, rc);
 }
 
+static inline int is_loop_device(struct file *file)
+{
+	struct inode *i = file->f_mapping->host;
+
+	return i && S_ISBLK(i->i_mode) && MAJOR(i->i_rdev) == LOOP_MAJOR;
+}
+
+static int check_loop_recursion(struct file *f, struct block_device *bdev)
+{
+	/*
+	 * FIXME: Traversing on other loop devices without corresponding
+	 * lo_ctl_mutex is not safe. l->lo_state can become Lo_rundown and
+	 * l->lo_backing_file can become NULL when raced with LOOP_CLR_FD.
+	 */
+	while (is_loop_device(f)) {
+		struct loop_device *l;
+
+		if (f->f_mapping->host->i_bdev == bdev)
+			return -EBUSY;
+
+		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
+		if (l->lo_state == Lo_unbound)
+			return -EINVAL;
+		f = l->lo_backing_file;
+	}
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -673,6 +701,11 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!file)
 		goto out;
 
+	/* Avoid recursion */
+	error = check_loop_recursion(file, bdev);
+	if (error)
+		goto out_putf;
+
 	inode = file->f_mapping->host;
 	old_file = lo->lo_backing_file;
 
@@ -706,13 +739,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	return error;
 }
 
-static inline int is_loop_device(struct file *file)
-{
-	struct inode *i = file->f_mapping->host;
-
-	return i && S_ISBLK(i->i_mode) && MAJOR(i->i_rdev) == LOOP_MAJOR;
-}
-
 /* loop sysfs attributes */
 
 static ssize_t loop_attr_show(struct device *dev, char *page,
@@ -877,7 +903,7 @@ static int loop_prepare_queue(struct loop_device *lo)
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
-	struct file	*file, *f;
+	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
 	int		lo_flags = 0;
@@ -897,20 +923,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		goto out_putf;
 
 	/* Avoid recursion */
-	f = file;
-	while (is_loop_device(f)) {
-		struct loop_device *l;
-
-		if (f->f_mapping->host->i_bdev == bdev)
-			goto out_putf;
-
-		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
-		if (l->lo_state == Lo_unbound) {
-			error = -EINVAL;
-			goto out_putf;
-		}
-		f = l->lo_backing_file;
-	}
+	error = check_loop_recursion(file, bdev);
+	if (error)
+		goto out_putf;
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
-- 
1.8.3.1
