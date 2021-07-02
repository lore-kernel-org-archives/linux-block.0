Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E1C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 17:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7912061430
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 17:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGBRbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 13:31:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57435 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 13:31:41 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 162HSpgW026914;
        Sat, 3 Jul 2021 02:28:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 03 Jul 2021 02:28:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 162HSpnU026907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Jul 2021 02:28:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: reintroduce global lock for safe
 loop_validate_file() traversal
To:     Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <288edd89-a33f-2561-cee9-613704c3da20@i-love.sakura.ne.jp>
Date:   Sat, 3 Jul 2021 02:28:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/07/03 0:30, Tetsuo Handa wrote:
>  drivers/block/loop.c | 138 ++++++++++++++++++++++++++++---------------
>  1 file changed, 89 insertions(+), 49 deletions(-)
> 
> This is a submission as a patch based on comments from Christoph Hellwig
> at https://lkml.kernel.org/r/20210623144130.GA738@lst.de . I don't know
> this patch can close all race windows.
> 
> For example, loop_change_fd() says
> 
>   This can only work if the loop device is used read-only, and if the
>   new backing store is the same size and type as the old backing store.
> 
> and has
> 
>         /* size of the new backing store needs to be the same */
>         if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
>                 goto out_err;
> 
> check. Then, do we also need to apply this global lock for
> lo_simple_ioctl(LOOP_SET_CAPACITY) path because it changes the size
> by loop_set_size(lo, get_loop_size(lo, lo->lo_backing_file)) ?
> How serious if this check is racy?
> 
> Any other locations to apply this global lock?
> 

Well, apart from questions above, is this smaller patch safe?

 drivers/block/loop.c |   72 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc0e8c39a48b..d3bb9c34a3e0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -88,6 +88,29 @@
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
+static DEFINE_MUTEX(loop_validate_mutex);
+
+static int loop_global_lock_killable(struct loop_device *lo, bool global)
+{
+	int err;
+
+	if (global) {
+		err = mutex_lock_killable(&loop_validate_mutex);
+		if (err)
+			return err;
+	}
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err && global)
+		mutex_unlock(&loop_validate_mutex);
+	return err;
+}
+
+static void loop_global_unlock(struct loop_device *lo, bool global)
+{
+	mutex_unlock(&lo->lo_mutex);
+	if (global)
+		mutex_unlock(&loop_validate_mutex);
+}
 
 static int max_part;
 static int part_shift;
@@ -672,13 +695,13 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 	while (is_loop_device(f)) {
 		struct loop_device *l;
 
+		lockdep_assert_held(&loop_validate_mutex);
 		if (f->f_mapping->host->i_rdev == bdev->bd_dev)
 			return -EBADF;
 
 		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
-		if (l->lo_state != Lo_bound) {
+		if (l->lo_state != Lo_bound)
 			return -EINVAL;
-		}
 		f = l->lo_backing_file;
 	}
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
@@ -697,13 +720,20 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
-	struct file	*file = NULL, *old_file;
+	struct file *file = fget(arg);
+	struct file *old_file;
 	int		error;
 	bool		partscan;
+	bool is_loop;
 
-	error = mutex_lock_killable(&lo->lo_mutex);
-	if (error)
+	if (!file)
+		return -EBADF;
+	is_loop = is_loop_device(file);
+	error = loop_global_lock_killable(lo, is_loop);
+	if (error) {
+		fput(file);
 		return error;
+	}
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
 		goto out_err;
@@ -713,11 +743,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		goto out_err;
 
-	error = -EBADF;
-	file = fget(arg);
-	if (!file)
-		goto out_err;
-
 	error = loop_validate_file(file, bdev);
 	if (error)
 		goto out_err;
@@ -740,7 +765,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, is_loop);
 	/*
 	 * We must drop file reference outside of lo_mutex as dropping
 	 * the file ref can take open_mutex which creates circular locking
@@ -752,9 +777,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	return 0;
 
 out_err:
-	mutex_unlock(&lo->lo_mutex);
-	if (file)
-		fput(file);
+	loop_global_unlock(lo, is_loop);
+	fput(file);
 	return error;
 }
 
@@ -1143,6 +1167,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loff_t		size;
 	bool		partscan;
 	unsigned short  bsize;
+	bool is_loop;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -1162,7 +1187,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 			goto out_putf;
 	}
 
-	error = mutex_lock_killable(&lo->lo_mutex);
+	is_loop = is_loop_device(file);
+	error = loop_global_lock_killable(lo, is_loop);
 	if (error)
 		goto out_bdev;
 
@@ -1253,7 +1279,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, is_loop);
 	if (partscan)
 		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
@@ -1261,7 +1287,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return 0;
 
 out_unlock:
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, is_loop);
 out_bdev:
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
@@ -1283,6 +1309,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	int lo_number;
 	struct loop_worker *pos, *worker;
 
+	/*
+	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
+	 * loop_validate_file() to succeed, for actual clear operation has not
+	 * started yet (i.e. effectively lo->lo_state == Lo_bound state).
+	 */
+	mutex_lock(&loop_validate_mutex);
+	mutex_unlock(&loop_validate_mutex);
+	/*
+	 * loop_validate_file() now fails because lo->lo_state != Lo_bound
+	 * became visible.
+	 */
+
 	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
 		err = -ENXIO;
