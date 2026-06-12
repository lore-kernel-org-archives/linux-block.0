Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF601395AEC
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280967; cv=none; b=RiBzRRSWWij9Vfvg419pnAdaLEzb8ZmXnfCmjdrFheU0quwFGa86uYmFQfZsvSgUGkDoIfjkm7ty6PNoXrl845LFCC9BGhimCAxBNC9qzK75euVEh35m8p8Cw9oeXSvEDo6mEOpu3bxmS5QRG2MvBZcgjfXcM1f8gA/IP8ctuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280967; c=relaxed/simple;
	bh=YG+l5Sqvv97xQ4D9SdRLCYLLUQatuUzC7tglTWPn6rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQ8vcMw4OyghwCvdVVgNBABs294hDD2Ra+e2oZYhutLgkUyru1eHHSF5S4x+ZDNhuQtWIX5dJg9HLvUmzWtZO3eopt69q9BhYumpsEN7UCVZvhZVoiUkK75HNRNj1gBpfaU9G4fYg1odSWBjww2L8NhLV6Fup6CrU+SwoaSG5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d6WbMa1G; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d6WbMa1G"
Message-ID: <667e352d-afad-412e-8f2a-ad5f5f8a737b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781280963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qINpHuayErACXjh0AoeBOU65EJUliYLSX/8Ct5OL2J0=;
	b=d6WbMa1GTCfYSMTX23bAe7EniyhJG7nuynQLpr6jFRq3h//qVv3ltHA2CDoChE9q3fagWk
	PhVV2oK8cMTmqBUy7donjPTOUQBSm7gbUw3PfhSMHDnehkSbeBfta8xJa4pTYatwnx0yn+
	CRpZp/rB8pOo3jEukiOGr6vNHJRqlMg=
Date: Fri, 12 Jun 2026 18:16:01 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 16/27] loop: Split loop_configure()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Marco Elver <elver@google.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <f001b652198021d586af28c4c2c27be4b1824f3d.1781042470.git.bvanassche@acm.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <f001b652198021d586af28c4c2c27be4b1824f3d.1781042470.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/10/26 00:05, Bart Van Assche wrote:
> Prepare for adding a second __loop_configure() call.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/loop.c | 109 ++++++++++++++++++++++---------------------
>   1 file changed, 57 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6fbea0af144f..80fdb0dee268 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -981,61 +981,28 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
>   		lim->discard_granularity = 0;
>   }
>   
> -static int loop_configure(struct loop_device *lo, blk_mode_t mode,
> -			  struct block_device *bdev,
> -			  const struct loop_config *config)
> +static int __loop_configure(struct loop_device *lo, blk_mode_t mode,
> +			    struct block_device *bdev,
> +			    const struct loop_config *config, struct file *file,
> +			    bool *partscan)
>   {

I wonder if we can add "__must_hold(&lo->lo_mutex)" to this.
Same for the function __loop_change_fd()

> -	struct file *file = fget(config->fd);
>   	struct queue_limits lim;
> -	int error;
>   	loff_t size;
> -	bool partscan;
> -	bool is_loop;
> -
> -	if (!file)
> -		return -EBADF;
> -
> -	error = loop_check_backing_file(file);
> -	if (error) {
> -		fput(file);
> -		return error;
> -	}
> -
> -	is_loop = is_loop_device(file);
> -
> -	/* This is safe, since we have a reference from open(). */
> -	__module_get(THIS_MODULE);
> -
> -	/*
> -	 * If we don't hold exclusive handle for the device, upgrade to it
> -	 * here to avoid changing device under exclusive owner.
> -	 */
> -	if (!(mode & BLK_OPEN_EXCL)) {
> -		error = bd_prepare_to_claim(bdev, loop_configure, NULL);
> -		if (error)
> -			goto out_putf;
> -	}
> -
> -	error = loop_global_lock_killable(lo, is_loop);
> -	if (error)
> -		goto out_bdev;
> +	int error;
>   
> -	error = -EBUSY;
>   	if (lo->lo_state != Lo_unbound)
> -		goto out_unlock;
> +		return -EBUSY;
>   
>   	error = loop_validate_file(file, bdev);
>   	if (error)
> -		goto out_unlock;
> +		return error;
>   
> -	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
> -		error = -EINVAL;
> -		goto out_unlock;
> -	}
> +	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0)
> +		return -EINVAL;
>   
>   	error = loop_set_status_from_info(lo, &config->info);
>   	if (error)
> -		goto out_unlock;
> +		return error;
>   	lo->lo_flags = config->info.lo_flags;
>   
>   	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
> @@ -1046,10 +1013,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   		lo->workqueue = alloc_workqueue("loop%d",
>   						WQ_UNBOUND | WQ_FREEZABLE,
>   						0, lo->lo_number);
> -		if (!lo->workqueue) {
> -			error = -ENOMEM;
> -			goto out_unlock;
> -		}
> +		if (!lo->workqueue)
> +			return -ENOMEM;
>   	}
>   
>   	/* suppress uevents while reconfiguring the device */
> @@ -1066,7 +1031,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	/* No need to freeze the queue as the device isn't bound yet. */
>   	error = queue_limits_commit_update(lo->lo_queue, &lim);
>   	if (error)
> -		goto out_unlock;
> +		return error;
>   
>   	/*
>   	 * We might switch to direct I/O mode for the loop device, write back
> @@ -1087,14 +1052,56 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	WRITE_ONCE(lo->lo_state, Lo_bound);
>   	if (part_shift)
>   		lo->lo_flags |= LO_FLAGS_PARTSCAN;
> -	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> -	if (partscan)
> +	*partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> +	if (*partscan)
>   		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>   
>   	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
>   	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>   
> +	return 0;
> +}
> +
> +static int loop_configure(struct loop_device *lo, blk_mode_t mode,
> +			  struct block_device *bdev,
> +			  const struct loop_config *config)
> +{
> +	struct file *file = fget(config->fd);
> +	int error;
> +	bool partscan;
> +	bool is_loop;
> +
> +	if (!file)
> +		return -EBADF;
> +
> +	error = loop_check_backing_file(file);
> +	if (error) {
> +		fput(file);
> +		return error;
> +	}
> +
> +	is_loop = is_loop_device(file);
> +
> +	/* This is safe, since we have a reference from open(). */
> +	__module_get(THIS_MODULE);
> +
> +	/*
> +	 * If we don't hold exclusive handle for the device, upgrade to it
> +	 * here to avoid changing device under exclusive owner.
> +	 */
> +	if (!(mode & BLK_OPEN_EXCL)) {
> +		error = bd_prepare_to_claim(bdev, loop_configure, NULL);
> +		if (error)
> +			goto out_putf;
> +	}
> +
> +	error = loop_global_lock_killable(lo, is_loop);
> +	if (error)
> +		goto out_bdev;
> +	error = __loop_configure(lo, mode, bdev, config, file, &partscan);
>   	loop_global_unlock(lo, is_loop);
> +	if (error)
> +		goto out_bdev;
>   	if (partscan)
>   		loop_reread_partitions(lo);
>   
> @@ -1103,8 +1110,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   
>   	return 0;
>   
> -out_unlock:
> -	loop_global_unlock(lo, is_loop);
>   out_bdev:
>   	if (!(mode & BLK_OPEN_EXCL))
>   		bd_abort_claiming(bdev, loop_configure);
> 

