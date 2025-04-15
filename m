Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB97288C96;
	Tue, 15 Apr 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712339; cv=none; b=A4exmcYAoO1xXz1Je0J7/F8JfEPkRrsRT8U1gSm2dmFq+/pkxkqoY79ausLbD8rqyrI38r1/35KGimKCYcJ9IUfbfVxHyj/Wq8Fp0P8heCrU0/GZrBSq13x6u94nXLCSFG7eDZTHYgi7cP5axvGslaiS9ZxmJlrG4frqEHdUo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712339; c=relaxed/simple;
	bh=8k9HyLOQVX2DKJes33OnB1ZdwzaKh2WQzdSqAfqGrUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooVvomOvwrmcTXy3cvshcuMnwaNnxOjuCUxC7e/tiHzxmGWTAU9cwjCREatOwV4f7gOm8+Xez3zw15kpsempBmqpJB8Tu0ldaqE7q27ebkadOOk7N8NsGStUOcMuybCBMn/XJiztfRRHTMgGhnLyv7RE9SQg7yBu+fNiAkZJVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0674C4CEDD;
	Tue, 15 Apr 2025 10:18:57 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:18:55 +0200
From: Greg KH <greg@kroah.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>,
	Alyssa Ross <hi@alyssa.is>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, John Ogness <john.ogness@linutronix.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] loop: properly send KOBJ_CHANGED uevent for disk
 device
Message-ID: <2025041548-preplan-reaffirm-510a@gregkh>
References: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>

On Tue, Apr 15, 2025 at 10:51:47AM +0200, Thomas Weiﬂschuh wrote:
> The original commit message and the wording "uncork" in the code comment
> indicate that it is expected that the suppressed event instances are
> automatically sent after unsuppressing.
> This is not the case, instead they are discarded.
> In effect this means that no "changed" events are emitted on the device
> itself by default.
> While each discovered partition does trigger a changed event on the
> device, devices without partitions don't have any event emitted.
> 
> This makes udev miss the device creation and prompted workarounds in
> userspace. See the linked util-linux/losetup bug.
> 
> Explicitly emit the events and drop the confusingly worded comments.
> 
> Link: https://github.com/util-linux/util-linux/issues/2434
> Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Use correct Fixes tag
> - Rework commit message slightly
> - Rebase onto v6.15-rc1
> - Link to v1: https://lore.kernel.org/r/20250317-loop-uevent-changed-v1-1-cb29cb91b62d@linutronix.de
> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc669e982a2b441af1171559aa427c..09a725710a21171e0adf5888f929ccaf94e98992 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -667,8 +667,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  
>  	error = 0;
>  done:
> -	/* enable and uncork uevent now that we are done */
>  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  	return error;
>  
>  out_err:
> @@ -1129,8 +1129,8 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  	if (partscan)
>  		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>  
> -	/* enable and uncork uevent now that we are done */
>  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  
>  	loop_global_unlock(lo, is_loop);
>  	if (partscan)
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250307-loop-uevent-changed-aa3690f43e03
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
