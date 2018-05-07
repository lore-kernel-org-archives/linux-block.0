Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: tytso@mit.edu, axboe@kernel.dk, syzkaller-bugs@googlegroups.com
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180504021717.9246-1-tytso@mit.edu>
In-Reply-To: <20180504021717.9246-1-tytso@mit.edu>
Message-Id: <201805072016.GAC48495.VSJQFtFHLFMOOO@I-love.SAKURA.ne.jp>
Date: Mon, 7 May 2018 20:16:58 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Oh, your message did not arrive at news.gmane.org and I didn't notice that you
already wrote this patch. But please update yours or review mine shown below.

> @@ -673,14 +703,13 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	if (!file)
>  		goto out;
>  
> +	error = loop_validate_file(file, bdev);
> +	if (error)
> +		goto out_putf;
> +
>  	inode = file->f_mapping->host;
>  	old_file = lo->lo_backing_file;
>  
> -	error = -EINVAL;
> -
> -	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> -		goto out_putf;
> -
>  	/* size of the new backing store needs to be the same */
>  	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
>  		goto out_putf;

error == 0 upon "goto out_putf" is wrong.



>>From eed54c6ae475860a9c63b37b58f34735e792eef7 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 12:59:12 +0900
Subject: [PATCH] block/loop: Add recursion check for LOOP_CHANGE_FD request.

syzbot is reporting hung tasks at blk_freeze_queue() [1]. This is
due to ioctl(loop_fd, LOOP_CHANGE_FD, loop_fd) request which should be
rejected. Fix this by adding same recursion check which is used by
LOOP_SET_FD request.

[1] https://syzkaller.appspot.com/bug?id=078805a692853552e08154b1bcd2bc2c729eda88

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
