Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FDC433E0
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263AF20714
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 18:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BnvTYMpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGWSJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:09:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56470 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgGWSJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 14:09:07 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C326920B4908;
        Thu, 23 Jul 2020 11:09:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C326920B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595527745;
        bh=uHrnXOZikJH8DshH8Cb6szZjihDhComUUIzQpEmZSwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnvTYMpVe765C2JcC5rEdC+x2pVTiwcftFN2NwG46XCv2pXToEjPSBe4+DyThhWIp
         C+3OhI4W71do3Rgc/DeRCmTDfYAgw+zqeyMmhKb1y/8C0Rl1ONQmlz+T173m0A9UIA
         MtMuiJp6cuASErKXqHnvIEBFKJ9EK2ScLzB0diP0=
Date:   Thu, 23 Jul 2020 13:09:02 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] loop: scale loop device by introducing per device
 lock
Message-ID: <20200723180902.GV3673@sequoia>
References: <20200717205322.127694-1-pasha.tatashin@soleen.com>
 <20200717205322.127694-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717205322.127694-2-pasha.tatashin@soleen.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-07-17 16:53:22, Pavel Tatashin wrote:
> Currently, loop device has only one global lock:
> loop_ctl_mutex.
> 
> This becomes hot in scenarios where many loop devices are used.
> 
> Scale it by introducing per-device lock: lo_mutex that proctests
> field in struct loop_device. Keep loop_ctl_mutex to protect global

s/proctests field/protects the fields/

> data such as loop_index_idr, loop_lookup, loop_add.
> 
> Lock ordering: loop_ctl_mutex > lo_mutex.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/block/loop.c | 86 ++++++++++++++++++++++++--------------------
>  drivers/block/loop.h |  1 +
>  2 files changed, 48 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 475e1a738560..056af3bca6c2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -706,7 +706,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	int		error;
>  	bool		partscan;
>  
> -	error = mutex_lock_killable(&loop_ctl_mutex);
> +	error = mutex_lock_killable(&lo->lo_mutex);
>  	if (error)
>  		return error;
>  	error = -ENXIO;
> @@ -745,9 +745,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	loop_update_dio(lo);
>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	/*
> -	 * We must drop file reference outside of loop_ctl_mutex as dropping
> +	 * We must drop file reference outside of lo_mutex as dropping
>  	 * the file ref can take bd_mutex which creates circular locking
>  	 * dependency.
>  	 */
> @@ -757,7 +757,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	return 0;
>  
>  out_err:
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	if (file)
>  		fput(file);
>  	return error;
> @@ -1096,7 +1096,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  		}
>  	}
>  
> -	error = mutex_lock_killable(&loop_ctl_mutex);
> +	error = mutex_lock_killable(&lo->lo_mutex);
>  	if (error)
>  		goto out_bdev;
>  
> @@ -1176,7 +1176,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
>  	 */
>  	bdgrab(bdev);
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	if (partscan)
>  		loop_reread_partitions(lo, bdev);
>  	if (claimed_bdev)
> @@ -1184,7 +1184,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	return 0;
>  
>  out_unlock:
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  out_bdev:
>  	if (claimed_bdev)
>  		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
> @@ -1205,7 +1205,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	bool partscan = false;
>  	int lo_number;
>  
> -	mutex_lock(&loop_ctl_mutex);
> +	mutex_lock(&lo->lo_mutex);
>  	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
>  		err = -ENXIO;
>  		goto out_unlock;
> @@ -1259,7 +1259,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	lo_number = lo->lo_number;
>  	loop_unprepare_queue(lo);
>  out_unlock:
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	if (partscan) {
>  		/*
>  		 * bd_mutex has been held already in release path, so don't
> @@ -1290,18 +1290,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  	 * protects us from all the other places trying to change the 'lo'
>  	 * device.
>  	 */
> -	mutex_lock(&loop_ctl_mutex);
> +	mutex_lock(&lo->lo_mutex);
>  	lo->lo_flags = 0;
>  	if (!part_shift)
>  		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>  	lo->lo_state = Lo_unbound;
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  
>  	/*
> -	 * Need not hold loop_ctl_mutex to fput backing file.
> -	 * Calling fput holding loop_ctl_mutex triggers a circular
> +	 * Need not hold lo_mutex to fput backing file.
> +	 * Calling fput holding lo_mutex triggers a circular
>  	 * lock dependency possibility warning as fput can take
> -	 * bd_mutex which is usually taken before loop_ctl_mutex.
> +	 * bd_mutex which is usually taken before lo_mutex.
>  	 */
>  	if (filp)
>  		fput(filp);
> @@ -1312,11 +1312,11 @@ static int loop_clr_fd(struct loop_device *lo)
>  {
>  	int err;
>  
> -	err = mutex_lock_killable(&loop_ctl_mutex);
> +	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
>  	if (lo->lo_state != Lo_bound) {
> -		mutex_unlock(&loop_ctl_mutex);
> +		mutex_unlock(&lo->lo_mutex);
>  		return -ENXIO;
>  	}
>  	/*
> @@ -1331,11 +1331,11 @@ static int loop_clr_fd(struct loop_device *lo)
>  	 */
>  	if (atomic_read(&lo->lo_refcnt) > 1) {
>  		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
> -		mutex_unlock(&loop_ctl_mutex);
> +		mutex_unlock(&lo->lo_mutex);
>  		return 0;
>  	}
>  	lo->lo_state = Lo_rundown;
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  
>  	return __loop_clr_fd(lo, false);
>  }
> @@ -1350,7 +1350,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	bool partscan = false;
>  	bool size_changed = false;
>  
> -	err = mutex_lock_killable(&loop_ctl_mutex);
> +	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
>  	if (lo->lo_encrypt_key_size &&
> @@ -1417,7 +1417,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  		partscan = true;
>  	}
>  out_unlock:
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	if (partscan)
>  		loop_reread_partitions(lo, bdev);
>  
> @@ -1431,11 +1431,11 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>  	struct kstat stat;
>  	int ret;
>  
> -	ret = mutex_lock_killable(&loop_ctl_mutex);
> +	ret = mutex_lock_killable(&lo->lo_mutex);
>  	if (ret)
>  		return ret;
>  	if (lo->lo_state != Lo_bound) {
> -		mutex_unlock(&loop_ctl_mutex);
> +		mutex_unlock(&lo->lo_mutex);
>  		return -ENXIO;
>  	}
>  
> @@ -1454,10 +1454,10 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>  		       lo->lo_encrypt_key_size);
>  	}
>  
> -	/* Drop loop_ctl_mutex while we call into the filesystem. */
> +	/* Drop lo_mutex while we call into the filesystem. */
>  	path = lo->lo_backing_file->f_path;
>  	path_get(&path);
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
>  	if (!ret) {
>  		info->lo_device = huge_encode_dev(stat.dev);
> @@ -1643,7 +1643,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
>  {
>  	int err;
>  
> -	err = mutex_lock_killable(&loop_ctl_mutex);
> +	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
>  	switch (cmd) {
> @@ -1659,7 +1659,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
>  	default:
>  		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
>  	}
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	return err;
>  }
>  
> @@ -1890,22 +1890,23 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
>  		return err;
>  	lo = bdev->bd_disk->private_data;
>  	if (!lo) {
> -		err = -ENXIO;
> -		goto out;
> +		mutex_unlock(&loop_ctl_mutex);
> +		return -ENXIO;
>  	}
> -
> -	atomic_inc(&lo->lo_refcnt);
> -out:
> +	err = mutex_lock_killable(&lo->lo_mutex);
>  	mutex_unlock(&loop_ctl_mutex);

I don't see a possibility for deadlock but it bothers me a little that
we're not unlocking in the reverse locking order here, as we do in
loop_control_ioctl(). There should be no perf impact if we move the
mutex_unlock(&loop_ctl_mutex) after mutex_unlock(&lo->lo_mutex).

> -	return err;
> +	if (err)
> +		return err;
> +	atomic_inc(&lo->lo_refcnt);
> +	mutex_unlock(&lo->lo_mutex);
> +	return 0;
>  }
>  
>  static void lo_release(struct gendisk *disk, fmode_t mode)
>  {
> -	struct loop_device *lo;
> +	struct loop_device *lo = disk->private_data;
>  
> -	mutex_lock(&loop_ctl_mutex);
> -	lo = disk->private_data;
> +	mutex_lock(&lo->lo_mutex);
>  	if (atomic_dec_return(&lo->lo_refcnt))
>  		goto out_unlock;
>  
> @@ -1913,7 +1914,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  		if (lo->lo_state != Lo_bound)
>  			goto out_unlock;
>  		lo->lo_state = Lo_rundown;
> -		mutex_unlock(&loop_ctl_mutex);
> +		mutex_unlock(&lo->lo_mutex);
>  		/*
>  		 * In autoclear mode, stop the loop thread
>  		 * and remove configuration after last close.
> @@ -1930,7 +1931,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  }
>  
>  static const struct block_device_operations lo_fops = {
> @@ -1969,10 +1970,10 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
>  	struct loop_device *lo = ptr;
>  	struct loop_func_table *xfer = data;
>  
> -	mutex_lock(&loop_ctl_mutex);
> +	mutex_lock(&lo->lo_mutex);
>  	if (lo->lo_encryption == xfer)
>  		loop_release_xfer(lo);
> -	mutex_unlock(&loop_ctl_mutex);
> +	mutex_unlock(&lo->lo_mutex);
>  	return 0;
>  }
>  
> @@ -2157,6 +2158,7 @@ static int loop_add(struct loop_device **l, int i)
>  		disk->flags |= GENHD_FL_NO_PART_SCAN;
>  	disk->flags |= GENHD_FL_EXT_DEVT;
>  	atomic_set(&lo->lo_refcnt, 0);
> +	mutex_init(&lo->lo_mutex);

We need a corresponding call to mutex_destroy() in loop_remove().

>  	lo->lo_number		= i;
>  	spin_lock_init(&lo->lo_lock);
>  	disk->major		= LOOP_MAJOR;
> @@ -2272,15 +2274,21 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  		ret = loop_lookup(&lo, parm);
>  		if (ret < 0)
>  			break;
> +		ret = mutex_lock_killable(&lo->lo_mutex);
> +		if (ret)
> +			break;
>  		if (lo->lo_state != Lo_unbound) {
>  			ret = -EBUSY;
> +			mutex_unlock(&lo->lo_mutex);
>  			break;
>  		}
>  		if (atomic_read(&lo->lo_refcnt) > 0) {
>  			ret = -EBUSY;
> +			mutex_unlock(&lo->lo_mutex);
>  			break;
>  		}
>  		lo->lo_disk->private_data = NULL;
> +		mutex_unlock(&lo->lo_mutex);
>  		idr_remove(&loop_index_idr, lo->lo_number);
>  		loop_remove(lo);
>  		break;
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index af75a5ee4094..a3c04f310672 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -62,6 +62,7 @@ struct loop_device {
>  	struct request_queue	*lo_queue;
>  	struct blk_mq_tag_set	tag_set;
>  	struct gendisk		*lo_disk;

There's an instance, which is not in this patch's context, of accessing
lo_disk that needs lo_mutex protection. In loop_probe(), we call
get_disk_and_module(lo->lo_disk) and we need to lock and unlock lo_mutex
around that call.

Tyler

> +	struct mutex		lo_mutex;
>  };
>  
>  struct loop_cmd {
> -- 
> 2.25.1
> 
