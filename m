Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DBC07E9B
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 13:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3DC6100C
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 13:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhGSMyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:54:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58296 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbhGSMyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 08:54:17 -0400
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16JDYao6046544;
        Mon, 19 Jul 2021 22:34:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Mon, 19 Jul 2021 22:34:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16JDYamF046455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Jul 2021 22:34:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] loop: reintroduce global lock for safe
 loop_validate_file() traversal
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <288edd89-a33f-2561-cee9-613704c3da20@i-love.sakura.ne.jp>
 <20210706054622.GE17027@lst.de>
 <6049597b-693e-e3df-d4f0-f2cb43381b84@i-love.sakura.ne.jp>
 <521eb103-db46-3f34-e878-0cdd585ee8bd@i-love.sakura.ne.jp>
Message-ID: <184a83b5-e028-4d6e-4a8a-1019085503d3@i-love.sakura.ne.jp>
Date:   Mon, 19 Jul 2021 22:34:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <521eb103-db46-3f34-e878-0cdd585ee8bd@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, any questions?

I'm testing this patch in linux-next.git since next-20210714, and got
no regression reports. I think this patch is ready to be merged.

On 2021/07/06 23:40, Tetsuo Handa wrote:
> Commit 6cc8e7430801fa23 ("loop: scale loop device by introducing per
> device lock") re-opened a race window for NULL pointer dereference at
> loop_validate_file() where commit 310ca162d779efee ("block/loop: Use
> global lock for ioctl() operation.") has closed.
> 
> Although we need to guarantee that other loop devices will not change
> during traversal, we can't take remote "struct loop_device"->lo_mutex
> inside loop_validate_file() in order to avoid AB-BA deadlock. Therefore,
> introduce a global lock dedicated for loop_validate_file() which is
> conditionally taken before local "struct loop_device"->lo_mutex is taken.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 6cc8e7430801fa23 ("loop: scale loop device by introducing per device lock")
> ---
> Changes in v3:
>   Add memory barrier between loop_configure() and loop_validate_file().
>   Flush at loop_change_fd() to avoid possible use-after-free.
> 
> Changes in v2:
>   Minimize lock duration in __loop_clr_fd().
>   Add kerneldoc to lock/unlock helper functions.
>   Reformat local variables declaration.
> 
>  drivers/block/loop.c | 128 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 97 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cc0e8c39a48b..2a5b3d365250 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -88,6 +88,47 @@
>  
>  static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
> +static DEFINE_MUTEX(loop_validate_mutex);
> +
> +/**
> + * loop_global_lock_killable() - take locks for safe loop_validate_file() test
> + *
> + * @lo: struct loop_device
> + * @global: true if @lo is about to bind another "struct loop_device", false otherwise
> + *
> + * Returns 0 on success, -EINTR otherwise.
> + *
> + * Since loop_validate_file() traverses on other "struct loop_device" if
> + * is_loop_device() is true, we need a global lock for serializing concurrent
> + * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
> + */
> +static int loop_global_lock_killable(struct loop_device *lo, bool global)
> +{
> +	int err;
> +
> +	if (global) {
> +		err = mutex_lock_killable(&loop_validate_mutex);
> +		if (err)
> +			return err;
> +	}
> +	err = mutex_lock_killable(&lo->lo_mutex);
> +	if (err && global)
> +		mutex_unlock(&loop_validate_mutex);
> +	return err;
> +}
> +
> +/**
> + * loop_global_unlock() - release locks taken by loop_global_lock_killable()
> + *
> + * @lo: struct loop_device
> + * @global: true if @lo was about to bind another "struct loop_device", false otherwise
> + */
> +static void loop_global_unlock(struct loop_device *lo, bool global)
> +{
> +	mutex_unlock(&lo->lo_mutex);
> +	if (global)
> +		mutex_unlock(&loop_validate_mutex);
> +}
>  
>  static int max_part;
>  static int part_shift;
> @@ -672,13 +713,15 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  	while (is_loop_device(f)) {
>  		struct loop_device *l;
>  
> +		lockdep_assert_held(&loop_validate_mutex);
>  		if (f->f_mapping->host->i_rdev == bdev->bd_dev)
>  			return -EBADF;
>  
>  		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
> -		if (l->lo_state != Lo_bound) {
> +		if (l->lo_state != Lo_bound)
>  			return -EINVAL;
> -		}
> +		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
> +		rmb();
>  		f = l->lo_backing_file;
>  	}
>  	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> @@ -697,13 +740,18 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  			  unsigned int arg)
>  {
> -	struct file	*file = NULL, *old_file;
> -	int		error;
> -	bool		partscan;
> +	struct file *file = fget(arg);
> +	struct file *old_file;
> +	int error;
> +	bool partscan;
> +	bool is_loop;
>  
> -	error = mutex_lock_killable(&lo->lo_mutex);
> +	if (!file)
> +		return -EBADF;
> +	is_loop = is_loop_device(file);
> +	error = loop_global_lock_killable(lo, is_loop);
>  	if (error)
> -		return error;
> +		goto out_putf;
>  	error = -ENXIO;
>  	if (lo->lo_state != Lo_bound)
>  		goto out_err;
> @@ -713,11 +761,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
>  		goto out_err;
>  
> -	error = -EBADF;
> -	file = fget(arg);
> -	if (!file)
> -		goto out_err;
> -
>  	error = loop_validate_file(file, bdev);
>  	if (error)
>  		goto out_err;
> @@ -740,7 +783,16 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	loop_update_dio(lo);
>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> -	mutex_unlock(&lo->lo_mutex);
> +	loop_global_unlock(lo, is_loop);
> +
> +	/*
> +	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
> +	 * might be pointing at old_file which might be the last reference.
> +	 */
> +	if (!is_loop) {
> +		mutex_lock(&loop_validate_mutex);
> +		mutex_unlock(&loop_validate_mutex);
> +	}
>  	/*
>  	 * We must drop file reference outside of lo_mutex as dropping
>  	 * the file ref can take open_mutex which creates circular locking
> @@ -752,9 +804,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	return 0;
>  
>  out_err:
> -	mutex_unlock(&lo->lo_mutex);
> -	if (file)
> -		fput(file);
> +	loop_global_unlock(lo, is_loop);
> +out_putf:
> +	fput(file);
>  	return error;
>  }
>  
> @@ -1136,22 +1188,22 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  			  struct block_device *bdev,
>  			  const struct loop_config *config)
>  {
> -	struct file	*file;
> -	struct inode	*inode;
> +	struct file *file = fget(config->fd);
> +	struct inode *inode;
>  	struct address_space *mapping;
> -	int		error;
> -	loff_t		size;
> -	bool		partscan;
> -	unsigned short  bsize;
> +	int error;
> +	loff_t size;
> +	bool partscan;
> +	unsigned short bsize;
> +	bool is_loop;
> +
> +	if (!file)
> +		return -EBADF;
> +	is_loop = is_loop_device(file);
>  
>  	/* This is safe, since we have a reference from open(). */
>  	__module_get(THIS_MODULE);
>  
> -	error = -EBADF;
> -	file = fget(config->fd);
> -	if (!file)
> -		goto out;
> -
>  	/*
>  	 * If we don't hold exclusive handle for the device, upgrade to it
>  	 * here to avoid changing device under exclusive owner.
> @@ -1162,7 +1214,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  			goto out_putf;
>  	}
>  
> -	error = mutex_lock_killable(&lo->lo_mutex);
> +	error = loop_global_lock_killable(lo, is_loop);
>  	if (error)
>  		goto out_bdev;
>  
> @@ -1242,6 +1294,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	size = get_loop_size(lo, file);
>  	loop_set_size(lo, size);
>  
> +	/* Order wrt reading lo_state in loop_validate_file(). */
> +	wmb();
> +
>  	lo->lo_state = Lo_bound;
>  	if (part_shift)
>  		lo->lo_flags |= LO_FLAGS_PARTSCAN;
> @@ -1253,7 +1308,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
>  	 */
>  	bdgrab(bdev);
> -	mutex_unlock(&lo->lo_mutex);
> +	loop_global_unlock(lo, is_loop);
>  	if (partscan)
>  		loop_reread_partitions(lo);
>  	if (!(mode & FMODE_EXCL))
> @@ -1261,13 +1316,12 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	return 0;
>  
>  out_unlock:
> -	mutex_unlock(&lo->lo_mutex);
> +	loop_global_unlock(lo, is_loop);
>  out_bdev:
>  	if (!(mode & FMODE_EXCL))
>  		bd_abort_claiming(bdev, loop_configure);
>  out_putf:
>  	fput(file);
> -out:
>  	/* This is safe: open() is still holding a reference. */
>  	module_put(THIS_MODULE);
>  	return error;
> @@ -1283,6 +1337,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	int lo_number;
>  	struct loop_worker *pos, *worker;
>  
> +	/*
> +	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
> +	 * loop_validate_file() to succeed, for actual clear operation has not
> +	 * started yet.
> +	 */
> +	mutex_lock(&loop_validate_mutex);
> +	mutex_unlock(&loop_validate_mutex);
> +	/*
> +	 * loop_validate_file() now fails because l->lo_state != Lo_bound
> +	 * became visible.
> +	 */
> +
>  	mutex_lock(&lo->lo_mutex);
>  	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
>  		err = -ENXIO;
> 

