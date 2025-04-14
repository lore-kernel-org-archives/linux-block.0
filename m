Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F74C74
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661171; cv=none; b=o+5VQSmOu+Z4nhNgf03rp+Y16cjnBhtpSjWGzzFGb+76tlO1WqU8L3du+eLTYa7NWyJSN60nh5ahTWmDmKz/y0tWM7rI0K4DBp9rs05j9H6j6HKtL+xjVYVrrnscGbuhqk70GRgTDLCCI3wZF1tSRprnwV+N3uhrjtNKo2+LHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661171; c=relaxed/simple;
	bh=7QzBv+lkqOSC+PhO+bTu5LtA+8h5miiE9SI7UVjDtQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc+kalSD0PuGdAtvnRdixAQgdNZu8IYwLA1KV0mfE49acI2sSkiSFQl3ygAA4D/R9r9B5YYLxCvjPcN5kaAEBO1xWWW3fIFobY7nLb+crEDqXiLthcTDuZQlLyWR4Au6llHCd+1BvGBUfmIG2lnlVf/WG1NPzRMPrjdMQ0Mvjac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A025OeW+; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A025OeW+"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d445a722b9so23287305ab.3
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744661166; x=1745265966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Duqee7xubW9VwPrOW79L6vjBqgCLOYb+hkAA8GhOEAQ=;
        b=A025OeW+VMM4SXs51/T8Pex3mrK0J1XaS0zZ/XV9YQRCs+uEXdOoHJ2MJzC7Twu7oy
         j2NG9ZbPK4bh0bwDEa8nr1vqc4UkWnZZy3Pe0FUOXXxwN0DvxYwXMm417s5GWlh5zyRG
         vDN8N/EVrXDZUg18FLVJ24uOQu3Nk2Yoj02KYqoH0GBGxDEwqOwY7BIImApidqBhmy8a
         h0GQS7Jx6PtwHtYM34m4/461esK54f5Hh4SgqOlG1aks1f1XM9fR0cdFt/PE7zXqIKxl
         h87LOiQ2AhYXk/0LpB7Ib7cGWk/PXPJaIbQaGjGXR3VxxEXVZs9misbxi7PNgNx5gQ+n
         a16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661166; x=1745265966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duqee7xubW9VwPrOW79L6vjBqgCLOYb+hkAA8GhOEAQ=;
        b=mPo296535YzMZKmbWsp0tmr1Lseh+/Dc7b4ia+fKrMQUnfUnu/rul7k2htJWZwq+7i
         tSt3Eh5lQ4CmLVNRy/CHiwL4zbzytuzE1F/hud5Nz5dubWr/TLeCtIkBKuWEjDyFA7py
         1QGYGeeBm3EiGwLouZ3qLMBmpgLEcFbquoZ0WHUqwN1u7TLyzervQExSq41N7udqMj0x
         /nr+LKJz4O209LSD2BGSB9gDSrml6ANQxY7eANMiDs6bDI8jRz8sZ1iWiS0hHVLadGhg
         IAPLMJnG0+kWGisr8MWMzlqxT5HPuxLW99dbIO9mun4oY2fAw0XwmtDrKfq0+0QHwYWR
         NhJw==
X-Forwarded-Encrypted: i=1; AJvYcCUlWmBhx9vicvHV/IWhCpUKwOD8VgDqA0CYEZ2Bx1ahy9TLo92WsGFKJ8jOBpLYrimQk1EJUWSKY1fGaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xpQkbk1W/NlJyjyyPvqXFP36NPMQUZ64jW2LNYtsjuEn30ED
	eSlDiTh77BLC0jns5oTl2KJJz5uRASsFQ+VhZys9x7o0+2+WmDloQ5efcNsMZu2Fnzbai4Emnzu
	+51DYedX95tZRDS51Sc/zz9eb5mE2SamZvRRm7fTgxDrjCK03
X-Gm-Gg: ASbGncv3DbXEXd7w9pJRc7TTBcDPGHiy5p1Lha3GRlHtYc8R4oxQ/lyb7llJ36YmUfU
	NTqq8kR+5rLgkR/NgjA+cKIwc0uBsE+IFXM0Dnq35OSuZ/Sk1QaLKLnHywTpHKOdsOG10qpVjp+
	RE4HIZP8LJRt97/PaAf0P+9mKuPHTuM2Fses7WeSifUcbD5rWgb9LOjbdG8P4aJQ5jMQLQOmUP1
	p92+cdOASUqXRYXX7mI3L772kDR1JhPmY3HO8LwNLFs2P6pGkyJ2FURTB+HCpCDUhBcucfXGD9i
	cJvdcJPXqZuUJwYcdt4NiveGT0b2PMk=
X-Google-Smtp-Source: AGHT+IFpMV4ix5g8xKkQ/xcb5hneYw+E9CLmd94ecmX5o7KnuHrlp9KC4Fdhqov+wnjPg7s6TFqNzNXromOl
X-Received: by 2002:a05:6e02:3190:b0:3d4:3d63:e070 with SMTP id e9e14a558f8ab-3d7ec276433mr129091415ab.16.1744661165722;
        Mon, 14 Apr 2025 13:06:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d7dba90444sm7010335ab.21.2025.04.14.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 250AA3401C3;
	Mon, 14 Apr 2025 14:06:04 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D5438E402BD; Mon, 14 Apr 2025 14:06:02 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:06:02 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 3/9] ublk: add ublk_force_abort_dev()
Message-ID: <Z/1qqlPqih23w5+u@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-4-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:44PM +0800, Ming Lei wrote:
> Add ublk_force_abort_dev() for handling ublk_nosrv_dev_should_queue_io()
> in ublk_stop_dev(). Then queue quiesce and unquiesce can be paired in
> single function.
> 
> Meantime not change device state to QUIESCED any more, since the disk is
> going to be removed soon.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 79f42ed7339f..7e2c4084c243 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1743,22 +1743,20 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
>  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
>  }
>  
> -static void ublk_unquiesce_dev(struct ublk_device *ub)
> +static void ublk_force_abort_dev(struct ublk_device *ub)
>  {
>  	int i;
>  
> -	pr_devel("%s: unquiesce ub: dev_id %d state %s\n",
> +	pr_devel("%s: force abort ub: dev_id %d state %s\n",
>  			__func__, ub->dev_info.dev_id,
>  			ub->dev_info.state == UBLK_S_DEV_LIVE ?
>  			"LIVE" : "QUIESCED");
> -	/* quiesce_work has run. We let requeued rqs be aborted
> -	 * before running fallback_wq. "force_abort" must be seen
> -	 * after request queue is unqiuesced. Then del_gendisk()
> -	 * can move on.
> -	 */
> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	if (ub->dev_info.state == UBLK_S_DEV_LIVE)
> +		ublk_wait_tagset_rqs_idle(ub);
> +
>  	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>  		ublk_get_queue(ub, i)->force_abort = true;
> -
>  	blk_mq_unquiesce_queue(ub->ub_disk->queue);
>  	/* We may have requeued some rqs in ublk_quiesce_queue() */
>  	blk_mq_kick_requeue_list(ub->ub_disk->queue);
> @@ -1786,11 +1784,8 @@ static void ublk_stop_dev(struct ublk_device *ub)
>  	mutex_lock(&ub->mutex);
>  	if (!ub->ub_disk)
>  		goto unlock;
> -	if (ublk_nosrv_dev_should_queue_io(ub)) {
> -		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
> -			__ublk_quiesce_dev(ub);
> -		ublk_unquiesce_dev(ub);
> -	}
> +	if (ublk_nosrv_dev_should_queue_io(ub))
> +		ublk_force_abort_dev(ub);
>  	del_gendisk(ub->ub_disk);
>  	disk = ublk_detach_disk(ub);
>  	put_disk(disk);
> -- 
> 2.47.0
> 
