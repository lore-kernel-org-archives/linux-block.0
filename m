Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88417A304
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828526; cv=none; b=ks9/x/obbb6kMwu54D2snwKXwcK0hPEEwg/tfLGf5iUO+5md7c7h5gp4zXnjRM2FQMx0GAkLL8P3BFxt78ol5r8O3u069KDDUVmfRzdB0hGJeshq3718/JGf8zKD7ikMZdwHrt58fM6P/Tr8/JvNLZuAEr9/koLzyZeoxAJ8ag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828526; c=relaxed/simple;
	bh=ejZ02aGnV55kmoixtT3aBmu2BQnYITm/JRtfslz2Gro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dem++qSV9eJl/4+NA9eByLpD+E8IeTAJpPWH7vfwrs+7B31s0Vfrt9xQ2r/pMtUvwjxlpskk6LCri807NrmzGxyP4clkjiQaZM7iQEvc+/2tdW2Y0JCchygrkvTzBdMMsow69cLHaktBLPstVvUf/iNPVun0whBpQm1FA+5sb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B07Bp/yK; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B07Bp/yK"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-85da5a3667bso193985639f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744828524; x=1745433324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAD/3m2XpwXguQYOgtcDYZGmR/oIrcSUpGTic20xf6Y=;
        b=B07Bp/yKEIhVPb0JLRWIqumDikX3RO8J+4h2/1yuTkkzFp+1vOXWX5NaDVltapivWi
         Yk3fOcuvNzPGisY4TBzyXo1kx4wxXiNZ9P7uO0BLZPf0ViNUtHG0H0ThtHA2mRF3cc68
         dPIN1N35Rev5agjhUqa9JxzWV2ksdNQ8OI4aJcgqxwCAu1ZCPOoQo8l+lWL+xUapsLqM
         HV2yXe5DNNVQ+ha1CT+dBqjQ0Vh3why2et9sZ//a9ecz4z5++tw7bXw0JajeRhkh5y+L
         Fp0PkbaGMpjTu+ZEKHqaDjklF8br03gTaovGZgQxgqfkR8ptjMTXLF2qrM+As8dxOXCL
         JT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744828524; x=1745433324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAD/3m2XpwXguQYOgtcDYZGmR/oIrcSUpGTic20xf6Y=;
        b=PV2f/6LSjOS2TQcp6LRq3lBQtzC9ZlADp8ypAur4mWZSWjoki72selrsPtM4en0mVK
         44JWmM9EIzbQvjYUjGIoeTFeiR3VFAVJQIv04sdmds3rCCGj3Zp+BvPvK0pD/4jOcF2F
         UfO/VCM3GnzIGlNiJZcV4dPtrjvxvRiBLRr9FD0xpuRJUGaQ+aQmQNtAS0gQkpwIAIgJ
         XyOjZwnR8FZ6uwZAAQUvJYZ4qgBnoWuDhnfnyVre5h1ITX3AC2MDjL21vKj4Gq9zTI/E
         HtrPulx14kCkVKUmoUjbhZ5eAC4H5x50ssLhUDMXGE9QsXCugMcesfuOvyDuIpaLJ5Pb
         O5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8BEGN1/Ll3lPtfZ2BcezBHGZDsC/n8U1mY2z4nq9yp+F0UUdFUy9KhqoLQs2OHmIW8NLBuv1r4v1hFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTiytcgvpqxIEPHAjn3XHka7A/LUv7Q2xOBTjhqxpQIFmzyOj
	wE1vE2GZO38B0oi4qU9sXUiZj+bF4u6S2yKzdRGiWfu0/cNI545XLUlJ77jE4oGh0e3GWrrG8CC
	5y+RMEO7D1rM+jqoey8e7HMkVzGiC+Un9ho5cORqEAF170Gpi
X-Gm-Gg: ASbGncuzeHhru9SvyAO6vE6kFmrwpY9ZaCmNC05oOUWCoUxDywA+5KxJywHoJkPxUsv
	qDDUQUrs9GKQWQ1Ck6rAL3we64GHN9HqJcBoh3r13xWA/sIaC0RCGyCXrmbS7vP1j2AJSIx+4Xs
	wylLJpEgO4S+O6mjqq/dia7oUQgFRlcZHHuzfLW4KZUeUkQzvcC18JA+8IXeMQZE5wuO5IoilsZ
	iRPLE4FBgnmqzsTKutDCdkwXGJ8qmjBbk84+NyMbt48pzKkpZxhO+oMb69rFIogufptMYUS7dHU
	RDDt62DfC2eEZOHPm8iMkNG1WMfe+5w=
X-Google-Smtp-Source: AGHT+IG4NAu7Q7dGfYYM/lEODF7SkxZYCqLD0Q1kkTWhvEYbY+yjUyqvZFcYDQo2UbBgE2Kof2eFr0R8hlr0
X-Received: by 2002:a05:6e02:144a:b0:3d5:8922:77a0 with SMTP id e9e14a558f8ab-3d815b5e58dmr34258835ab.18.1744828523866;
        Wed, 16 Apr 2025 11:35:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d7dbaa4248sm9072865ab.42.2025.04.16.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 11:35:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2325834035E;
	Wed, 16 Apr 2025 12:35:23 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 16BF3E40371; Wed, 16 Apr 2025 12:35:23 -0600 (MDT)
Date: Wed, 16 Apr 2025 12:35:23 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2 3/8] ublk: rely on ->canceling for dealing with
 ublk_nosrv_dev_should_queue_io
Message-ID: <Z//4ax6RhR7kz3VA@dev-ushankar.dev.purestorage.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
 <20250416035444.99569-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416035444.99569-4-ming.lei@redhat.com>

On Wed, Apr 16, 2025 at 11:54:37AM +0800, Ming Lei wrote:
> Now ublk deals with ublk_nosrv_dev_should_queue_io() by keeping request
> queue as quiesced. This way is fragile because queue quiesce crosses syscalls
> or process contexts.
> 
> Switch to rely on ubq->canceling for dealing with
> ublk_nosrv_dev_should_queue_io(), because it has been used for this purpose
> during io_uring context exiting, and it can be reused before recovering too.
> In ublk_queue_rq(), the request will be added to requeue list without
> kicking off requeue in case of ubq->canceling, and finally requests added in
> requeue list will be dispatched from either ublk_stop_dev() or
> ublk_ctrl_end_recovery().
> 
> Meantime we have to move reset of ubq->canceling from ublk_ctrl_start_recovery()
> to ublk_ctrl_end_recovery(), when IO handling can be recovered completely.
> 
> Then blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() are always used
> in same context.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e1b4db2f8a56..a479969fd77e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1734,13 +1734,19 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
>  
>  static void __ublk_quiesce_dev(struct ublk_device *ub)
>  {
> +	int i;
> +
>  	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
>  			__func__, ub->dev_info.dev_id,
>  			ub->dev_info.state == UBLK_S_DEV_LIVE ?
>  			"LIVE" : "QUIESCED");
>  	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	/* mark every queue as canceling */
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_get_queue(ub, i)->canceling = true;
>  	ublk_wait_tagset_rqs_idle(ub);
>  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> +	blk_mq_unquiesce_queue(ub->ub_disk->queue);
>  }
>  
>  static void ublk_force_abort_dev(struct ublk_device *ub)
> @@ -2961,7 +2967,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>  	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
>  	ubq->ubq_daemon = NULL;
>  	ubq->timeout = false;
> -	ubq->canceling = false;
>  
>  	for (i = 0; i < ubq->q_depth; i++) {
>  		struct ublk_io *io = &ubq->ios[i];
> @@ -3048,20 +3053,18 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
>  			__func__, ublksrv_pid, header->dev_id);
>  
> -	if (ublk_nosrv_dev_should_queue_io(ub)) {
> -		ub->dev_info.state = UBLK_S_DEV_LIVE;
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -		pr_devel("%s: queue unquiesced, dev id %d.\n",
> -				__func__, header->dev_id);
> -		blk_mq_kick_requeue_list(ub->ub_disk->queue);
> -	} else {
> -		blk_mq_quiesce_queue(ub->ub_disk->queue);
> -		ub->dev_info.state = UBLK_S_DEV_LIVE;
> -		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -			ublk_get_queue(ub, i)->fail_io = false;
> -		}
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		ubq->canceling = false;
> +		ubq->fail_io = false;
>  	}
> +	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +	pr_devel("%s: queue unquiesced, dev id %d.\n",
> +			__func__, header->dev_id);
> +	blk_mq_kick_requeue_list(ub->ub_disk->queue);
>  
>  	ret = 0;
>   out_unlock:
> -- 
> 2.47.0
> 
