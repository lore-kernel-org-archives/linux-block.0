Return-Path: <jack@suse.cz>
Date: Thu, 27 Sep 2018 13:27:44 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Subject: Re: [PATCH 4/4] block/loop: Fix circular locking dependency at
 blkdev_reread_part().
Message-ID: <20180927112744.GB16469@quack2.suse.cz>
References: <1537889209-7208-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1537889209-7208-4-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537889209-7208-4-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

Hi,

On Wed 26-09-18 00:26:49, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between bdev->bd_mutex
> and lo->lo_ctl_mutex [1] which is caused by calling blkdev_reread_part()
> with lock held. We need to drop lo->lo_ctl_mutex in order to fix it.
> 
> This patch fixes it by combining loop_index_mutex and loop_ctl_mutex into
> loop_mutex, and releasing loop_mutex before calling blkdev_reread_part()
> or fput() or path_put() or leaving ioctl().
> 
> The rule is that current thread calls lock_loop() before accessing
> "struct loop_device", and current thread no longer accesses "struct
> loop_device" after unlock_loop() is called.
> 
> Since syzbot is reporting various bugs [2] where a race in the loop module
> is suspected, let's check whether this patch affects these bugs too.
> 
> [1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> [2] https://syzkaller.appspot.com/bug?id=b3c7e1440aa8ece16bf557dbac427fdff1dad9d6
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
> ---
>  drivers/block/loop.c | 187 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 101 insertions(+), 86 deletions(-)

I still don't like this patch. I'll post a patch series showing what I have
in mind. Admittedly, it's a bit tedious but the locking is much saner
afterwards...

								Honza

> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 4b05a27..04389bb 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -84,12 +84,50 @@
>  #include <linux/uaccess.h>
>  
>  static DEFINE_IDR(loop_index_idr);
> -static DEFINE_MUTEX(loop_index_mutex);
> -static DEFINE_MUTEX(loop_ctl_mutex);
> +static DEFINE_MUTEX(loop_mutex);
> +static void *loop_mutex_owner; /* == __mutex_owner(&loop_mutex) */
>  
>  static int max_part;
>  static int part_shift;
>  
> +/*
> + * lock_loop - Lock loop_mutex.
> + */
> +static void lock_loop(void)
> +{
> +	mutex_lock(&loop_mutex);
> +	loop_mutex_owner = current;
> +}
> +
> +/*
> + * lock_loop_killable - Lock loop_mutex unless killed.
> + */
> +static int lock_loop_killable(void)
> +{
> +	int err = mutex_lock_killable(&loop_mutex);
> +
> +	if (err)
> +		return err;
> +	loop_mutex_owner = current;
> +	return 0;
> +}
> +
> +/*
> + * unlock_loop - Unlock loop_mutex as needed.
> + *
> + * Explicitly call this function before calling fput() or blkdev_reread_part()
> + * in order to avoid circular lock dependency. After this function is called,
> + * current thread is no longer allowed to access "struct loop_device" memory,
> + * for another thread would access that memory as soon as loop_mutex is held.
> + */
> +static void unlock_loop(void)
> +{
> +	if (loop_mutex_owner == current) {
> +		loop_mutex_owner = NULL;
> +		mutex_unlock(&loop_mutex);
> +	}
> +}
> +
>  static int transfer_xor(struct loop_device *lo, int cmd,
>  			struct page *raw_page, unsigned raw_off,
>  			struct page *loop_page, unsigned loop_off,
> @@ -637,6 +675,7 @@ static void loop_reread_partitions(struct loop_device *lo,
>  	const int count = atomic_read(&lo->lo_refcnt);
>  
>  	memcpy(filename, lo->lo_file_name, sizeof(filename));
> +	unlock_loop();
>  
>  	/*
>  	 * bd_mutex has been held already in release path, so don't
> @@ -699,6 +738,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	struct file	*file, *old_file;
>  	int		error;
>  
> +	lockdep_assert_held(&loop_mutex);
>  	error = -ENXIO;
>  	if (lo->lo_state != Lo_bound)
>  		goto out;
> @@ -737,10 +777,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  
>  	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
>  		loop_reread_partitions(lo, bdev);
> +	unlock_loop();
>  	fput(old_file);
>  	return 0;
>  
>   out_putf:
> +	unlock_loop();
>  	fput(file);
>   out:
>  	return error;
> @@ -918,6 +960,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	int		error;
>  	loff_t		size;
>  
> +	lockdep_assert_held(&loop_mutex);
>  	/* This is safe, since we have a reference from open(). */
>  	__module_get(THIS_MODULE);
>  
> @@ -991,6 +1034,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	return 0;
>  
>   out_putf:
> +	unlock_loop();
>  	fput(file);
>   out:
>  	/* This is safe: open() is still holding a reference. */
> @@ -1042,6 +1086,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	struct block_device *bdev = lo->lo_device;
>  	bool reread;
>  
> +	lockdep_assert_held(&loop_mutex);
>  	if (lo->lo_state != Lo_bound)
>  		return -ENXIO;
>  
> @@ -1057,7 +1102,6 @@ static int loop_clr_fd(struct loop_device *lo)
>  	 */
>  	if (atomic_read(&lo->lo_refcnt) > 1) {
>  		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
> -		mutex_unlock(&loop_ctl_mutex);
>  		return 0;
>  	}
>  
> @@ -1111,13 +1155,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>  	if (reread)
>  		loop_reread_partitions(lo, bdev);
> -	mutex_unlock(&loop_ctl_mutex);
> -	/*
> -	 * Need not hold loop_ctl_mutex to fput backing file.
> -	 * Calling fput holding loop_ctl_mutex triggers a circular
> -	 * lock dependency possibility warning as fput can take
> -	 * bd_mutex which is usually taken before loop_ctl_mutex.
> -	 */
> +	unlock_loop();
>  	fput(filp);
>  	return 0;
>  }
> @@ -1129,6 +1167,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	struct loop_func_table *xfer;
>  	kuid_t uid = current_uid();
>  
> +	lockdep_assert_held(&loop_mutex);
>  	if (lo->lo_encrypt_key_size &&
>  	    !uid_eq(lo->lo_key_owner, uid) &&
>  	    !capable(CAP_SYS_ADMIN))
> @@ -1220,10 +1259,9 @@ static int loop_clr_fd(struct loop_device *lo)
>  	struct kstat stat;
>  	int ret;
>  
> -	if (lo->lo_state != Lo_bound) {
> -		mutex_unlock(&loop_ctl_mutex);
> +	lockdep_assert_held(&loop_mutex);
> +	if (lo->lo_state != Lo_bound)
>  		return -ENXIO;
> -	}
>  
>  	memset(info, 0, sizeof(*info));
>  	info->lo_number = lo->lo_number;
> @@ -1240,10 +1278,10 @@ static int loop_clr_fd(struct loop_device *lo)
>  		       lo->lo_encrypt_key_size);
>  	}
>  
> -	/* Drop loop_ctl_mutex while we call into the filesystem. */
> +	/* Drop loop_mutex while we call into the filesystem. */
>  	path = lo->lo_backing_file->f_path;
>  	path_get(&path);
> -	mutex_unlock(&loop_ctl_mutex);
> +	unlock_loop();
>  	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
>  	if (!ret) {
>  		info->lo_device = huge_encode_dev(stat.dev);
> @@ -1334,10 +1372,8 @@ static int loop_clr_fd(struct loop_device *lo)
>  	struct loop_info64 info64;
>  	int err;
>  
> -	if (!arg) {
> -		mutex_unlock(&loop_ctl_mutex);
> +	if (!arg)
>  		return -EINVAL;
> -	}
>  	err = loop_get_status(lo, &info64);
>  	if (!err)
>  		err = loop_info64_to_old(&info64, &info);
> @@ -1352,10 +1388,8 @@ static int loop_clr_fd(struct loop_device *lo)
>  	struct loop_info64 info64;
>  	int err;
>  
> -	if (!arg) {
> -		mutex_unlock(&loop_ctl_mutex);
> +	if (!arg)
>  		return -EINVAL;
> -	}
>  	err = loop_get_status(lo, &info64);
>  	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
>  		err = -EFAULT;
> @@ -1365,6 +1399,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  
>  static int loop_set_capacity(struct loop_device *lo)
>  {
> +	lockdep_assert_held(&loop_mutex);
>  	if (unlikely(lo->lo_state != Lo_bound))
>  		return -ENXIO;
>  
> @@ -1374,6 +1409,8 @@ static int loop_set_capacity(struct loop_device *lo)
>  static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  {
>  	int error = -ENXIO;
> +
> +	lockdep_assert_held(&loop_mutex);
>  	if (lo->lo_state != Lo_bound)
>  		goto out;
>  
> @@ -1387,6 +1424,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  
>  static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>  {
> +	lockdep_assert_held(&loop_mutex);
>  	if (lo->lo_state != Lo_bound)
>  		return -ENXIO;
>  
> @@ -1409,11 +1447,10 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  	unsigned int cmd, unsigned long arg)
>  {
>  	struct loop_device *lo = bdev->bd_disk->private_data;
> -	int err;
> +	int err = lock_loop_killable();
>  
> -	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
>  	if (err)
> -		goto out_unlocked;
> +		return err;
>  
>  	switch (cmd) {
>  	case LOOP_SET_FD:
> @@ -1423,10 +1460,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  		err = loop_change_fd(lo, bdev, arg);
>  		break;
>  	case LOOP_CLR_FD:
> -		/* loop_clr_fd would have unlocked loop_ctl_mutex on success */
>  		err = loop_clr_fd(lo);
> -		if (!err)
> -			goto out_unlocked;
>  		break;
>  	case LOOP_SET_STATUS:
>  		err = -EPERM;
> @@ -1436,8 +1470,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  		break;
>  	case LOOP_GET_STATUS:
>  		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
> -		/* loop_get_status() unlocks loop_ctl_mutex */
> -		goto out_unlocked;
> +		break;
>  	case LOOP_SET_STATUS64:
>  		err = -EPERM;
>  		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
> @@ -1446,8 +1479,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  		break;
>  	case LOOP_GET_STATUS64:
>  		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
> -		/* loop_get_status() unlocks loop_ctl_mutex */
> -		goto out_unlocked;
> +		break;
>  	case LOOP_SET_CAPACITY:
>  		err = -EPERM;
>  		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
> @@ -1466,9 +1498,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  	default:
>  		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
>  	}
> -	mutex_unlock(&loop_ctl_mutex);
> -
> -out_unlocked:
> +	unlock_loop();
>  	return err;
>  }
>  
> @@ -1582,10 +1612,8 @@ struct compat_loop_info {
>  	struct loop_info64 info64;
>  	int err;
>  
> -	if (!arg) {
> -		mutex_unlock(&loop_ctl_mutex);
> +	if (!arg)
>  		return -EINVAL;
> -	}
>  	err = loop_get_status(lo, &info64);
>  	if (!err)
>  		err = loop_info64_to_compat(&info64, arg);
> @@ -1600,20 +1628,16 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  	switch(cmd) {
>  	case LOOP_SET_STATUS:
> -		err = mutex_lock_killable(&loop_ctl_mutex);
> -		if (!err) {
> +		err = lock_loop_killable();
> +		if (!err)
>  			err = loop_set_status_compat(lo,
>  						     (const struct compat_loop_info __user *)arg);
> -			mutex_unlock(&loop_ctl_mutex);
> -		}
>  		break;
>  	case LOOP_GET_STATUS:
> -		err = mutex_lock_killable(&loop_ctl_mutex);
> -		if (!err) {
> +		err = lock_loop_killable();
> +		if (!err)
>  			err = loop_get_status_compat(lo,
>  						     (struct compat_loop_info __user *)arg);
> -			/* loop_get_status() unlocks loop_ctl_mutex */
> -		}
>  		break;
>  	case LOOP_SET_CAPACITY:
>  	case LOOP_CLR_FD:
> @@ -1630,6 +1654,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  		err = -ENOIOCTLCMD;
>  		break;
>  	}
> +	unlock_loop();
>  	return err;
>  }
>  #endif
> @@ -1637,37 +1662,31 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  static int lo_open(struct block_device *bdev, fmode_t mode)
>  {
>  	struct loop_device *lo;
> -	int err = 0;
> +	int err = lock_loop_killable();
>  
> -	mutex_lock(&loop_index_mutex);
> +	if (err)
> +		return err;
>  	lo = bdev->bd_disk->private_data;
> -	if (!lo) {
> +	if (!lo)
>  		err = -ENXIO;
> -		goto out;
> -	}
> -
> -	atomic_inc(&lo->lo_refcnt);
> -out:
> -	mutex_unlock(&loop_index_mutex);
> +	else
> +		atomic_inc(&lo->lo_refcnt);
> +	unlock_loop();
>  	return err;
>  }
>  
>  static void __lo_release(struct loop_device *lo)
>  {
> -	int err;
> -
>  	if (atomic_dec_return(&lo->lo_refcnt))
>  		return;
>  
> -	mutex_lock(&loop_ctl_mutex);
> +	lockdep_assert_held(&loop_mutex);
>  	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
>  		/*
>  		 * In autoclear mode, stop the loop thread
>  		 * and remove configuration after last close.
>  		 */
> -		err = loop_clr_fd(lo);
> -		if (!err)
> -			return;
> +		loop_clr_fd(lo);
>  	} else if (lo->lo_state == Lo_bound) {
>  		/*
>  		 * Otherwise keep thread (if running) and config,
> @@ -1676,15 +1695,13 @@ static void __lo_release(struct loop_device *lo)
>  		blk_mq_freeze_queue(lo->lo_queue);
>  		blk_mq_unfreeze_queue(lo->lo_queue);
>  	}
> -
> -	mutex_unlock(&loop_ctl_mutex);
>  }
>  
>  static void lo_release(struct gendisk *disk, fmode_t mode)
>  {
> -	mutex_lock(&loop_index_mutex);
> +	lock_loop();
>  	__lo_release(disk->private_data);
> -	mutex_unlock(&loop_index_mutex);
> +	unlock_loop();
>  }
>  
>  static const struct block_device_operations lo_fops = {
> @@ -1723,10 +1740,8 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
>  	struct loop_device *lo = ptr;
>  	struct loop_func_table *xfer = data;
>  
> -	mutex_lock(&loop_ctl_mutex);
>  	if (lo->lo_encryption == xfer)
>  		loop_release_xfer(lo);
> -	mutex_unlock(&loop_ctl_mutex);
>  	return 0;
>  }
>  
> @@ -1738,8 +1753,14 @@ int loop_unregister_transfer(int number)
>  	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
>  		return -EINVAL;
>  
> +	/*
> +	 * cleanup_cryptoloop() cannot handle errors because it is called
> +	 * from module_exit(). Thus, don't give up upon SIGKILL here.
> +	 */
> +	lock_loop();
>  	xfer_funcs[n] = NULL;
>  	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
> +	unlock_loop();
>  	return 0;
>  }
>  
> @@ -1982,20 +2003,18 @@ static int loop_lookup(struct loop_device **l, int i)
>  static struct kobject *loop_probe(dev_t dev, int *part, void *data)
>  {
>  	struct loop_device *lo;
> -	struct kobject *kobj;
> -	int err;
> +	struct kobject *kobj = NULL;
> +	int err = lock_loop_killable();
>  
> -	mutex_lock(&loop_index_mutex);
> +	*part = 0;
> +	if (err)
> +		return NULL;
>  	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
>  	if (err < 0)
>  		err = loop_add(&lo, MINOR(dev) >> part_shift);
> -	if (err < 0)
> -		kobj = NULL;
> -	else
> +	if (err >= 0)
>  		kobj = get_disk_and_module(lo->lo_disk);
> -	mutex_unlock(&loop_index_mutex);
> -
> -	*part = 0;
> +	unlock_loop();
>  	return kobj;
>  }
>  
> @@ -2003,9 +2022,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  			       unsigned long parm)
>  {
>  	struct loop_device *lo;
> -	int ret = -ENOSYS;
> +	int ret = lock_loop_killable();
>  
> -	mutex_lock(&loop_index_mutex);
> +	if (ret)
> +		return ret;
> +	ret = -ENOSYS;
>  	switch (cmd) {
>  	case LOOP_CTL_ADD:
>  		ret = loop_lookup(&lo, parm);
> @@ -2019,21 +2040,15 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  		ret = loop_lookup(&lo, parm);
>  		if (ret < 0)
>  			break;
> -		ret = mutex_lock_killable(&loop_ctl_mutex);
> -		if (ret)
> -			break;
>  		if (lo->lo_state != Lo_unbound) {
>  			ret = -EBUSY;
> -			mutex_unlock(&loop_ctl_mutex);
>  			break;
>  		}
>  		if (atomic_read(&lo->lo_refcnt) > 0) {
>  			ret = -EBUSY;
> -			mutex_unlock(&loop_ctl_mutex);
>  			break;
>  		}
>  		lo->lo_disk->private_data = NULL;
> -		mutex_unlock(&loop_ctl_mutex);
>  		idr_remove(&loop_index_idr, lo->lo_number);
>  		loop_remove(lo);
>  		break;
> @@ -2043,7 +2058,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  		ret = loop_add(&lo, -1);
>  	}
> -	mutex_unlock(&loop_index_mutex);
> +	unlock_loop();
>  
>  	return ret;
>  }
> @@ -2127,10 +2142,10 @@ static int __init loop_init(void)
>  				  THIS_MODULE, loop_probe, NULL, NULL);
>  
>  	/* pre-create number of devices given by config or max_loop */
> -	mutex_lock(&loop_index_mutex);
> +	lock_loop();
>  	for (i = 0; i < nr; i++)
>  		loop_add(&lo, i);
> -	mutex_unlock(&loop_index_mutex);
> +	unlock_loop();
>  
>  	printk(KERN_INFO "loop: module loaded\n");
>  	return 0;
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
