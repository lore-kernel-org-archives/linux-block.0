Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571015;
	b=IkgpWaNdq3etpMIsGbTQ7GMrsbVm8OBYtar4J3x4voNaOUNP//0dZipw4msJKl3UgYiY
	 AtE9cjSsWyPzPuZSY8qwRX6YD019+5EOhbAtff5f/d7HB14PqXMM5F3cwuKqJ7o/0+mWg
	 5mU+rkgyx2PzfrWzRQ3mOdkiSlMItdM0hnj5sAcxkMKt2iGBnfH3iLTt4LUG5Tnp+TAZY
	 jhDVoe+GhlKIWSC9K5wILOpy5oAxOppQaiJwugBqLnUpnCRBaI/arX11nWg3xoXC8yHwd
	 SBlD2VlsGU2WymWtvyRJ41yp852Ci2scyyPV8eHkvHcgzgjOimRQqfiewvhcCO7Hlmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571015;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=MH3o4FBHHt7qDwNo2lih97+n6LSLplF5mRfnEXmEdN0=;
	b=DpyADc8WaHxVRsL61ZA93nn96fRyjwDrS7mtoe3x+4EtpNG3dFI9ekzB2VaMYqalus6R
	 za9fFFBVZpLqfbhY0owBUeKTWCjXHoom913u9Fgn0klZxNCbfDYDZUzFA5UpDWorLrgad
	 T4XiPtX5ZhsLBi9dc9w1lR/ILemU8/9xr3CVidy2JIrBBtdLwNEOYgrVN85DxasLZZVxs
	 XiWx8HZ6FWikZSs2KqK98XL0CX+D3umg1aC0CvH/xdlfC3zWE231GCY3gsy71a9CUQP5m
	 Ue6C6ksTFFdKb6EdsKbb/G3aqfe7ph3THRrv8ptZRmlHH0NZximZBQ+tzUoOCz5SNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="VA/1+JbP";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="uawk/2nJ";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="VA/1+JbP";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="uawk/2nJ";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A37606A321;
	Fri, 13 Nov 2026 11:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A37606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=VA/1+JbP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uawk/2nJ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=VA/1+JbP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uawk/2nJ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46BE01F8C4;
	Fri, 13 Nov 2026 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794571013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MH3o4FBHHt7qDwNo2lih97+n6LSLplF5mRfnEXmEdN0=;
	b=VA/1+JbPVOVc1KGGH9pk5vRZvn0tDFaTEK3B2azqtClThQpVq0cGP5JBMFH9ZyiLsn0yCP
	783B31vN7K6WHbABTYigDERNZK5LrTPlTZA8F9aL1M+G3GjzydoKfZ1IRyzpmYWz8T8++b
	fTzDgESi8s1Zy8AFeomomL/APg6Ycdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794571013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MH3o4FBHHt7qDwNo2lih97+n6LSLplF5mRfnEXmEdN0=;
	b=uawk/2nJIRiwGGs3KvK4qu5WM2rAjZPUm8CjzgpMF2l5donD33xXlPpbbmtgw/6mt04fg+
	w1QOE6jIxu2vQjDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794571013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MH3o4FBHHt7qDwNo2lih97+n6LSLplF5mRfnEXmEdN0=;
	b=VA/1+JbPVOVc1KGGH9pk5vRZvn0tDFaTEK3B2azqtClThQpVq0cGP5JBMFH9ZyiLsn0yCP
	783B31vN7K6WHbABTYigDERNZK5LrTPlTZA8F9aL1M+G3GjzydoKfZ1IRyzpmYWz8T8++b
	fTzDgESi8s1Zy8AFeomomL/APg6Ycdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794571013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MH3o4FBHHt7qDwNo2lih97+n6LSLplF5mRfnEXmEdN0=;
	b=uawk/2nJIRiwGGs3KvK4qu5WM2rAjZPUm8CjzgpMF2l5donD33xXlPpbbmtgw/6mt04fg+
	w1QOE6jIxu2vQjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1919D1344A;
	Fri, 13 Nov 2026 11:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3n5OAT79mrCXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 11:56:53 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 9BE8622CB5; Fri, 13 Nov 2026 12:56:48 +0100 (CET)
Date: Fri, 13 Nov 2026 12:56:48 +0100
From: Jan Kara <jack@suse.cz>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] loop: protect geometry changes in loop_set_status
Message-ID: <tca2e6diwswopvmhl2qrrt2ibndzepblbubfmxmsclz76xa2wx@urytvddxmq37>
References: <20261112075806.53821-1-zhaogongyi@bytedance.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112075806.53821-1-zhaogongyi@bytedance.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,bytedance.com:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 12-11-26 15:58:06, Zhao Gongyi wrote:
> LOOP_SET_STATUS accepts offset and size-limit changes while a filesystem
> is mounted on the loop device. An offset change can redirect filesystem
> I/O to different backing-file sectors, risking data corruption. Shrinking
> the size limit can remove sectors the filesystem still uses. A rejected
> request to change geometry can also invalidate the block-device cache
> before validation.
> 
> Validate the request before invalidation. Claim the whole loop device for
> geometry changes, including ioctls through a partition fd, so mounted
> sibling partitions also block the change. Keep the claim through partition
> scanning. Leave non-geometry updates such as AUTOCLEAR available while
> mounted.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> The earlier attempt, commit 08e136ebd193 ("loop: don't change loop device
> under exclusive opener in loop_set_status"), claimed every status update.
> It was reverted by commit a6abd64e145c ("loop: revert exclusive opener
> loop status change") after a udisks unmount regression.
> 
> Tests:
> - QEMU A/B: mounted whole-disk and sibling-partition geometry changes
>   returned -EBUSY with this patch.
> - Non-root udisksctl loop-setup/mount/unmount/loop-delete passed.
> - A flag-only AUTOCLEAR update while mounted succeeded.
> 
>  drivers/block/loop.c | 89 ++++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..d122cb008811 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -803,17 +803,7 @@ static void loop_free_idle_workers_timer(struct timer_list *timer)
>  	return loop_free_idle_workers(lo, false);
>  }
>  
> -/**
> - * loop_set_status_from_info - configure device from loop_info
> - * @lo: struct loop_device to configure
> - * @info: struct loop_info64 to configure the device with
> - *
> - * Configures the loop device parameters according to the passed
> - * in loop_info64 configuration.
> - */
> -static int
> -loop_set_status_from_info(struct loop_device *lo,
> -			  const struct loop_info64 *info)
> +static int loop_validate_status_from_info(const struct loop_info64 *info)
>  {
>  	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
>  		return -EINVAL;
> @@ -835,12 +825,18 @@ loop_set_status_from_info(struct loop_device *lo,
>  	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
>  		return -EOVERFLOW;
>  
> +	return 0;
> +}
> +
> +static void
> +loop_set_status_from_info(struct loop_device *lo,
> +			  const struct loop_info64 *info)
> +{
>  	lo->lo_offset = info->lo_offset;
>  	lo->lo_sizelimit = info->lo_sizelimit;
>  
>  	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>  	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
> -	return 0;
>  }
>  
>  static unsigned int loop_default_blocksize(struct loop_device *lo)
> @@ -951,9 +947,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  		goto out_unlock;
>  	}
>  
> -	error = loop_set_status_from_info(lo, &config->info);
> +	error = loop_validate_status_from_info(&config->info);
>  	if (error)
>  		goto out_unlock;
> +	loop_set_status_from_info(lo, &config->info);
>  	lo->lo_flags = config->info.lo_flags;
>  
>  	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
> @@ -1140,24 +1137,47 @@ static int loop_clr_fd(struct loop_device *lo)
>  }
>  
>  static int
> -loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> +loop_set_status(struct loop_device *lo, blk_mode_t mode,
> +		struct block_device *bdev, const struct loop_info64 *info)
>  {
> +	struct block_device *claim_bdev = bdev_whole(bdev);
>  	int err;
>  	bool partscan = false;
>  	bool size_changed = false;
> +	bool claiming = false;
>  	unsigned int memflags;
>  
> +retry:
>  	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
> -		return err;
> +		goto out_abort_claiming;
>  	if (lo->lo_state != Lo_bound) {
>  		err = -ENXIO;
>  		goto out_unlock;
>  	}
>  
> -	if (lo->lo_offset != info->lo_offset ||
> -	    lo->lo_sizelimit != info->lo_sizelimit) {
> -		size_changed = true;
> +	err = loop_validate_status_from_info(info);
> +	if (err)
> +		goto out_unlock;
> +
> +	size_changed = lo->lo_offset != info->lo_offset ||
> +		lo->lo_sizelimit != info->lo_sizelimit;
> +	if (size_changed &&
> +	    !((mode & BLK_OPEN_EXCL) && bdev == claim_bdev) && !claiming) {
> +		/*
> +		 * lo_offset and lo_sizelimit are whole-device geometry.
> +		 * A partition fd does not own sibling partitions, so claim
> +		 * the whole loop device before changing the mapping.
> +		 */
> +		mutex_unlock(&lo->lo_mutex);
> +		err = bd_prepare_to_claim(claim_bdev, loop_set_status, NULL);
> +		if (err)
> +			return err;
> +		claiming = true;
> +		goto retry;
> +	}
> +
> +	if (size_changed) {
>  		sync_blockdev(lo->lo_device);
>  		invalidate_bdev(lo->lo_device);
>  	}
> @@ -1165,9 +1185,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	/* I/O needs to be drained before changing lo_offset or lo_sizelimit */
>  	memflags = blk_mq_freeze_queue(lo->lo_queue);
>  
> -	err = loop_set_status_from_info(lo, info);
> -	if (err)
> -		goto out_unfreeze;
> +	loop_set_status_from_info(lo, info);
>  
>  	partscan = !(lo->lo_flags & LO_FLAGS_PARTSCAN) &&
>  		(info->lo_flags & LO_FLAGS_PARTSCAN);
> @@ -1178,7 +1196,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	/* update the direct I/O flag if lo_offset changed */
>  	loop_update_dio(lo);
>  
> -out_unfreeze:
>  	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
>  	if (partscan)
>  		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
> @@ -1190,6 +1207,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	mutex_unlock(&lo->lo_mutex);
>  	if (partscan)
>  		loop_reread_partitions(lo);
> +out_abort_claiming:
> +	if (claiming)
> +		bd_abort_claiming(claim_bdev, loop_set_status);
>  
>  	return err;
>  }
> @@ -1267,7 +1287,9 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
>  }
>  
>  static int
> -loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
> +loop_set_status_old(struct loop_device *lo, blk_mode_t mode,
> +		    struct block_device *bdev,
> +		    const struct loop_info __user *arg)
>  {
>  	struct loop_info info;
>  	struct loop_info64 info64;
> @@ -1275,17 +1297,19 @@ loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
>  	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
>  		return -EFAULT;
>  	loop_info64_from_old(&info, &info64);
> -	return loop_set_status(lo, &info64);
> +	return loop_set_status(lo, mode, bdev, &info64);
>  }
>  
>  static int
> -loop_set_status64(struct loop_device *lo, const struct loop_info64 __user *arg)
> +loop_set_status64(struct loop_device *lo, blk_mode_t mode,
> +		  struct block_device *bdev,
> +		  const struct loop_info64 __user *arg)
>  {
>  	struct loop_info64 info64;
>  
>  	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
>  		return -EFAULT;
> -	return loop_set_status(lo, &info64);
> +	return loop_set_status(lo, mode, bdev, &info64);
>  }
>  
>  static int
> @@ -1468,14 +1492,14 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
>  	case LOOP_SET_STATUS:
>  		err = -EPERM;
>  		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> -			err = loop_set_status_old(lo, argp);
> +			err = loop_set_status_old(lo, mode, bdev, argp);
>  		break;
>  	case LOOP_GET_STATUS:
>  		return loop_get_status_old(lo, argp);
>  	case LOOP_SET_STATUS64:
>  		err = -EPERM;
>  		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> -			err = loop_set_status64(lo, argp);
> +			err = loop_set_status64(lo, mode, bdev, argp);
>  		break;
>  	case LOOP_GET_STATUS64:
>  		return loop_get_status64(lo, argp);
> @@ -1569,7 +1593,8 @@ loop_info64_to_compat(const struct loop_info64 *info64,
>  }
>  
>  static int
> -loop_set_status_compat(struct loop_device *lo,
> +loop_set_status_compat(struct loop_device *lo, blk_mode_t mode,
> +		       struct block_device *bdev,
>  		       const struct compat_loop_info __user *arg)
>  {
>  	struct loop_info64 info64;
> @@ -1578,7 +1603,7 @@ loop_set_status_compat(struct loop_device *lo,
>  	ret = loop_info64_from_compat(arg, &info64);
>  	if (ret < 0)
>  		return ret;
> -	return loop_set_status(lo, &info64);
> +	return loop_set_status(lo, mode, bdev, &info64);
>  }
>  
>  static int
> @@ -1606,8 +1631,8 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>  	case LOOP_SET_STATUS:
>  		err = -EPERM;
>  		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
> -			err = loop_set_status_compat(lo,
> -				(const struct compat_loop_info __user *)arg);
> +			err = loop_set_status_compat(lo, mode, bdev,
> +						     (const struct compat_loop_info __user *)arg);
>  		break;
>  	case LOOP_GET_STATUS:
>  		err = loop_get_status_compat(lo,
> 
> base-commit: 8bb045949e86cc2e929e868f52de3fa86c379e30
> -- 
> 2.39.5 (Apple Git-154)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
