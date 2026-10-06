Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC746C856
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296104; cv=none; b=aKOQLYdsXuh17fTlN6rH39ZnHgUKZVK8+SOUWrLWRaQ3mSAEDandKvsRzZrAYkPJqNrRzs20T4l2HWzkb1TzZsYipe3JAu3JJYjFPaxN1HKOD7sco7eoXAsVr/+FaCOn91fZfhqPNUJrMmNHPb/FY47zsbp6ogR7eKwtQwwxhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296104; c=relaxed/simple;
	bh=Nt8VaQlj73La3K/WOXPeZWp5Egiw8ElYDzr2tV/tnAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV2usZ/NBdi/lolRb75FBqpeKDJxiWeB1F4kp4bp9Poxp8P2/NpzT7O+b8GlgWkmffmJK8IDfJhTSzekbMQ1E/BnWOdUdiFlx/NOjrKib2tdP1E+wazyR/Owl5CUfBsp+36zI9c0QqFFU5/lzN44YY0Dm6e0DAnyk7YaDjSt5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0fr23E8; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0fr23E8"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-82621039b6bso1517477a34.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791296101; x=1791900901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iyocPZgXU+y/fKJyewKMKQMG8bpfMm3V+MoJuTgAH+Q=;
        b=C0fr23E8OkKiRLmpkJ8gBXyQ3l9t1BuX+90uFkhhPKSw8OOXKAGvU5s4IRpyg6yOyX
         VK3n5Ux1dxLZBviRlBO011IFfOhNPCHypcjCsNQUfTjvwZQRbOpehQOSjmWIGoFK1loz
         NEcyu7noCvoD9gsP4yrIgaNIVQTzeHOi5q4i33uTZvo53tud5x+Ki7DQFrrR/izyO076
         4vhMfFFu4FfBdQW6aC6laVF4pCHesds0SvAWxALMl3iZgVAsc77xAmLYBFbNkMdG6tN+
         GuzsJTiHmrrbnqU1aRgapNiCDSsMEKBRJAAHJGpWZBUQqqOJ4GqfAsRzvEWJra9aIGng
         Co0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296101; x=1791900901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyocPZgXU+y/fKJyewKMKQMG8bpfMm3V+MoJuTgAH+Q=;
        b=t7B7z/Vpgg+xGbCVck0SULkVFIg7koYdPabKlmTc+95AyStowC959drtrh1hB3qJtz
         tCJcVfotkoELaujv3S8NdmlsyqANO4O5nF+jpJ+ziWPZZZIF52z+NmrW3Z+mCHmyJ59R
         YuRcYc2b3w7JazPWkzs97TW8yd7ZqT3liwWd8mPaGfUo/whWREmFgol2WGjJGkb75Eqb
         IeDIhYctU+2v/WK/XLwHLMO8tNyRXjGwH+CItmU5eOQqpXcqtshxzSYREuwWkZ93pIto
         d1W99v2zbzQ1VaWBV9XYEa0MY3seZIIMYA8NUM4bKOfFzy1UkQ4O0DZ+Y34C9aetDhMZ
         cViA==
X-Forwarded-Encrypted: i=1; AKwUvBzq5Bwqn9VWRrvihfTQUSE5zWGoTcBIVLJyI+AjRCkKVdqFInF+gfpvsHIDy0hFKmZrm/ui6Fx1VNW2Lw==@vger.kernel.org
X-Gm-Message-State: AFuF++lMmGF2fhGfOLNryiwLLKoHZBtDEc1/mpSfwLHFfFMGsdCYf7YU
	zbAj9/bPcmUE876IVSi5C7H3wCycI2p9Q/cX2qibCubt+BujRihuxuMpAY6T5A==
X-Gm-Gg: AYBFou0xomrm8x4MI8Ed652xl4O2wsCjl1I9ciMlGP32kCo77LD0LgHAmd7i10bKeKl
	u7m9262wYyhuUgNqD+0aaJAqquvIsWfhQ2GC9viZlHVW/ivVKhw33+hHT88ypQNbqGTi9qKFSQx
	KKY+xYx0JzRncdBunbeZ58jf8zZsa3mnSz/KJwZYFx9kX1zloDMGPE6Akid0npiSMk5YFQFtB5H
	9Ndk86HFxAPXv9USz4GlL3mFlcKwvKlAne9yzAlE2TBlyQAh08bL/ic/nvHQIu5Le5DSJIVhMDP
	mAeCukn+FcSQdvxoCZD0mO3KL7odf+9IcY4D/C65soG2b5yLuLfmmuBaYELo3gJqhgY07M2TE49
	IhfxEa379XOI11GvUIAz59TgMbKhtpTvDIz8oisK1zL9Chtx3zH+yaaDL3TObNAS3QZ7YcI2BUv
	EIReJB7hNMUsknadvEDgcQxMRk0L2zLI8NR11YpZNfSikmOdBvFCrRKNu+M6YmPClWmgrEBH+Gv
	TQeA8dHjbaBZ4UbfJ+MvNum3ILkFYlQAVR2A9hCJrTlce4cV2bl3qDnKWDa2wV6CAFytFo7Vm55
	QTLJZ2Hyvj85Wg==
X-Received: by 2002:a05:6830:349b:b0:81d:8057:9b7f with SMTP id 46e09a7af769-828a30409b5mr1482854a34.28.1791296101506;
        Tue, 06 Oct 2026 07:15:01 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8281acf807csm2432876a34.0.2026.10.06.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:00 -0700 (PDT)
Date: Tue, 6 Oct 2026 09:14:50 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] ublk: refuse to go live after an io command was canceled
Message-ID: <asUCWjKXMxXFwBNQ@fedora-laptop>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
 <9b876f2c061abc401ec4b9b3c2529eda.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b876f2c061abc401ec4b9b3c2529eda.josef@toxicpanda.com>

On Mon, Oct 05, 2026 at 04:23:51PM +0000, Josef Bacik wrote:
> Since commit "ublk: keep a canceled FETCH round canceling until the
> server is gone", a device whose FETCH round saw a cancel keeps its
> queues canceling until the server goes away, but START_DEV and
> END_USER_RECOVERY still bring it up. Without UBLK_F_USER_RECOVERY, or
> with UBLK_F_USER_RECOVERY_FAIL_IO, every request of the new disk fails.
> With UBLK_F_USER_RECOVERY, requests are requeued and never kicked: after
> START_DEV the partition scan hangs under disk->open_mutex, and after
> END_USER_RECOVERY every read parks while the command returned 0. The
> server cannot fetch the canceled commands again, so the device can't
> serve I/O until it restarts anyway.
> 
> Return -ENODEV from START_DEV and END_USER_RECOVERY while ub->canceling
> is set. In ublk_ctrl_start_dev() check it and publish ub->ub_disk in one
> cancel_mutex section, and have ublk_start_cancel() read the disk in its
> cancel_mutex section. Today ublk_start_cancel() samples the disk before
> taking the mutex, so a server dying during its own START_DEV can mark
> the queues without quiescing a disk START_DEV published in between, with
> its first I/O past the canceling check. Now either START_DEV sees the
> cancel, or the cancel sees the disk and quiesces it before marking. The
> END_USER_RECOVERY check is best effort: the disk exists there, and a
> cancel after it is the ordinary death of the new server, which
> ublk_start_cancel() handles by quiescing and marking.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> This applies on top of Ming's "[PATCH 0/8] ublk: don't dispatch to
> canceled io commands" and needs patch 1 of it for ub->canceling to stay
> set for the whole FETCH round. generic_18 still passes with it.
> 
>  Documentation/block/ublk.rst | 10 ++++++++--
>  drivers/block/ublk_drv.c     | 38 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 28300fee22bf..b7875a3cf3fc 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -118,7 +118,11 @@ managing and controlling ublk devices with help of several control commands:
>    After the server prepares userspace resources (such as creating I/O handler
>    threads & io_uring for handling ublk IO), this command is sent to the
>    driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
> -  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
> +  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device. The command
> +  fails with ``-ENODEV`` if an I/O command fetched by the current server
> +  was canceled, because its io_uring is gone. The server can't fetch it
> +  again, and the device can be started again once the server has closed
> +  ``/dev/ublkc*``.
>  
>  - ``UBLK_CMD_STOP_DEV``
>  
> @@ -195,7 +199,9 @@ managing and controlling ublk devices with help of several control commands:
>    command is accepted after ublk device is quiesced and a new process has
>    opened ``/dev/ublkc*`` and get all ublk queues be ready. When this command
>    returns, ublk device is unquiesced and new I/O requests are passed to the
> -  new process.
> +  new process. It fails with ``-ENODEV`` if an I/O command of the new
> +  process was canceled already. The recovery can be started over once the
> +  new process has closed ``/dev/ublkc*``.
>  
>  - user recovery feature description
>  
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f57d544c1da2..39eb7775a351 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2759,9 +2759,11 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  
>  static void ublk_start_cancel(struct ublk_device *ub)
>  {
> -	struct gendisk *disk = ublk_get_disk(ub);
> +	struct gendisk *disk;
>  
> +	/* sync with ublk_ctrl_start_dev() publishing the disk */
>  	mutex_lock(&ub->cancel_mutex);
> +	disk = ublk_get_disk(ub);
>  	if (ub->canceling)
>  		goto out;
>  
> @@ -4575,6 +4577,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  		.dma_alignment		= 3,
>  	};
>  	struct gendisk *disk;
> +	bool canceled;
>  	int ret = -EINVAL;
>  
>  	if (ublksrv_pid <= 0)
> @@ -4665,8 +4668,24 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  	disk->fops = &ub_fops;
>  	disk->private_data = ub;
>  
> +	/*
> +	 * A command of this FETCH round was canceled and can't be fetched
> +	 * again, don't bring up a disk over it.  Check and publish the disk
> +	 * in one cancel_mutex section: either this sees ub->canceling, or
> +	 * ublk_start_cancel() sees the disk and quiesces it before marking
> +	 * the queues.
> +	 */
> +	mutex_lock(&ub->cancel_mutex);
> +	canceled = ub->canceling;
> +	if (!canceled)
> +		ub->ub_disk = disk;
> +	mutex_unlock(&ub->cancel_mutex);
> +	if (canceled) {
> +		put_disk(disk);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
>  	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
> -	ub->ub_disk = disk;
>  
>  	ublk_apply_params(ub);
>  
> @@ -5238,6 +5257,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  		const struct ublksrv_ctrl_cmd *header)
>  {
>  	int ublksrv_pid = (int)header->data[0];
> +	bool canceled;
>  	int ret = -EINVAL;
>  
>  	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
> @@ -5261,6 +5281,20 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  		ret = -EBUSY;
>  		goto out_unlock;
>  	}
> +
> +	/*
> +	 * As in ublk_ctrl_start_dev(), a canceled command can't be fetched
> +	 * again.  Best effort: the disk exists here, and a cancel after this
> +	 * check is the ordinary death of the new server, which
> +	 * ublk_start_cancel() handles by quiescing and marking.
> +	 */
> +	mutex_lock(&ub->cancel_mutex);
> +	canceled = ub->canceling;
> +	mutex_unlock(&ub->cancel_mutex);
> +	if (canceled) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
>  	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
>  	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",

Hi Josef,

Thanks for the follow-up. The check and the cancel_mutex ordering
look right to me, but I'd suggest -EBUSY instead of -ENODEV.

-ENODEV means the ublk device is gone, and it isn't true in the
START_DEV/END_RECOVERY cases.

With -EBUSY:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


thanks,
Ming
