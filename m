Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AADDC3
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663046; cv=none; b=gotWDOy8sg8Xp9dT0Cmxk5zOzqr4a4cZK+A+6BPVpqIST1HcnNUjbu571nZ73O4Kl0ra8colPgfqn0FQ+JLd5ZSyo40h0+s6eo0lz+s0c8KtLTL6mJlDSxEQPOQUFnHkPuKTP2KfVgKqlfKRlmBTSiGWLnpWehPoJRJ4Vw+UHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663046; c=relaxed/simple;
	bh=VUEzcRjDG5fCbTcD9DiAjIHymy7yXVS0IHNZMDGOXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQZlAYn66B5UBh1/Etjgu+FtGKRLxtPiFjnVOqsfahCkDdhU+W+5mt5mK0S5nGBvFHAnbImpDCHfamskWwuM6e3Cdge2CDneIvF1g7IdfLxOmtJO2raw/e0yp75Cn+31OpxOjApuNzQ4bvB1IY9wfLnBopDLp+RllzBF1dsYR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QIWdzvSb; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QIWdzvSb"
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3d445a722b9so23401855ab.3
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744663043; x=1745267843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wR8wYeXJT4Y8xbNzaq3h5dzY16Yz/6JV7BwbfdxRf3g=;
        b=QIWdzvSbMIIThMLVBjVzIrQMo4/13qrKRbbZK4AQ0O15748QJyKWAHe8ejOQLP7Vw8
         xNn0d0Pnhv99+XXHTk89Kxx42Om6VKswfnVR1QRHdPaKdW/7C8B926A8MTDF5w1qmbRY
         E0beHjIW8vGGuYfd+JTZYvDrA0jH+Tzx8GU2FNfaDsKrIT0s57uEL6aQJQSMu51wX3lb
         FOHCP12+mKgPd61WMsGUPlETZ3H4yuXgC8BikGwS3ZegKS4nZhdgl5laycVqtsEv76zN
         twZ+U1yTfs+nF/tu6XaCvvEbyWUBjdMEDculzPP1mZ3OpCtYihaifzChGfjsmN5v5Df1
         1hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663043; x=1745267843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR8wYeXJT4Y8xbNzaq3h5dzY16Yz/6JV7BwbfdxRf3g=;
        b=fRgT2mFLDX3jZ8brxPVS2C0GOl6RPeJfGWrHSvHB24Jc3IWBcAUmDz+lr1PB5mJiQq
         vh26QiRgjDNGkrLGmPT21D89G0R5F4Mq+yl4Tjap3gdnMOt2y4iT3cXy+T8slTpnvmnZ
         nGv2CQyJdc3/YqF06Vzuc8sw+tFn2hb6WzpfEtwRl9V6KYceCND5KI/Osau6jUhXbJCp
         GdFnoK7txyDJKCJufvhBv6XgS/zMMXLMmtdkxQ7LvARp4gueBx7/XG3MJq8z9OJE/b/+
         0Tq5l7dLv/l1ZFcloeh2jTmm0461/ThlYHC1yDidJHLhjelcCNlit7BQpR1ZC6WCr5cw
         keew==
X-Forwarded-Encrypted: i=1; AJvYcCXrXLNaiiDQWn1uHVQ/xZPbMjnV+598ZHwm5YcVZqegg9pUpJOJB15H2jGHJOSjZ5Od/46me5mvQOkPGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWiPNcejJLqYT1s6Lt1PTW3lMmTlizyD+gihac6oD+G1MPXIYP
	lBfosoBGH4+pbdBi6NzIxBOLKx7YdTY4exvxUhsvS5dCDIdX91ouLcGWoYRCpzfxQyX9dXBqHVQ
	T1xU0BmYV1UvMMZ6QBwKDg74b+UWv+StP
X-Gm-Gg: ASbGnctsJIZbWW/Zm+KKVJqJRIdVkncEVSiuzAZ/l5yQQvJIhyNSpdF/zPtV8l7nVhw
	RC0EGyuF3cTtkpC0hX9PG0MJwfN/lcgXr8AagKHDUbJ6sSgvn8f6Nd6qaqqfm/H4HDamTVqgIzC
	5/BWt88Z4io0+4psxd0vJb/1iMjFXSJQg7boxZ0WjYDqThaDFTzrIWp0KFdSFItNEd2GwjMwO7w
	xvWsz6j0EtuW1b8CGGGy7h/Buu4SJDyJSweodoj9hFM91OEu1wl2LF7WWdavuQGz2friFy6sJZf
	sBuoUNkJzmqQQfc1mMEPA4jVTII76MBXlGXT8vWMFg7u0g==
X-Google-Smtp-Source: AGHT+IFzE5rkgj+bJw1NoJM1fDbCXJIdWQoyXpkck11/9z07ZM22ym3HDd169pUhws5dYgqDNtAf2bHZw/Jc
X-Received: by 2002:a05:6e02:198d:b0:3d2:bac3:b45f with SMTP id e9e14a558f8ab-3d7ec1dc7e0mr129868415ab.4.1744663043567;
        Mon, 14 Apr 2025 13:37:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d7dbaa43d5sm6681385ab.38.2025.04.14.13.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:37:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E16AC3401C3;
	Mon, 14 Apr 2025 14:37:22 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 900E8E40725; Mon, 14 Apr 2025 14:37:22 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:37:22 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 7/9] ublk: remove __ublk_quiesce_dev()
Message-ID: <Z/1yAhw6IZplHTXg@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-8-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-8-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:48PM +0800, Ming Lei wrote:
> Remove __ublk_quiesce_dev() and open code for updating device state as
> QUIESCED.
> 
> We needn't to drain inflight requests in __ublk_quiesce_dev() any more,
> because all inflight requests are aborted in ublk char device release
> handler.
> 
> Also we needn't to set ->canceling in __ublk_quiesce_dev() any more
> because it is done unconditionally now in ublk_ch_release().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e02f205f6da4..f827c2ef00a9 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -209,7 +209,6 @@ struct ublk_params_header {
>  
>  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> -static void __ublk_quiesce_dev(struct ublk_device *ub);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
>  		struct ublk_queue *ubq, int tag, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
> @@ -1589,11 +1588,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
>  			/*
>  			 * keep request queue as quiesced for queuing new IO
>  			 * during QUIESCED state
> -			 *
> -			 * request queue will be unquiesced in ending
> -			 * recovery, see ublk_ctrl_end_recovery
>  			 */
> -			__ublk_quiesce_dev(ub);
> +			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
>  		} else {
>  			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
>  			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> @@ -1839,22 +1835,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
>  	}
>  }
>  
> -/* Now all inflight requests have been aborted */
> -static void __ublk_quiesce_dev(struct ublk_device *ub)
> -{
> -	int i;
> -
> -	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
> -			__func__, ub->dev_info.dev_id,
> -			ub->dev_info.state == UBLK_S_DEV_LIVE ?
> -			"LIVE" : "QUIESCED");
> -	/* mark every queue as canceling */
> -	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> -		ublk_get_queue(ub, i)->canceling = true;
> -	ublk_wait_tagset_rqs_idle(ub);
> -	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> -}
> -
>  static void ublk_force_abort_dev(struct ublk_device *ub)
>  {
>  	int i;
> -- 
> 2.47.0
> 
