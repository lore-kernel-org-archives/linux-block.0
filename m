Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076061DA3D
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676097; cv=none; b=MitxBcRT8UpHMfRDKLHwEzfo+wF2RtdSM7Yd1df+NsztwroS2wn3mXuMzurX2mFyjxRXwAks9ltcITxF8IO0T2Rkh/+hF+3E1x9PaGrevG3+zdUBuDJvkzci040+T1enoIGdaTrY05WMKfs2soNl3kQBb47rmf4grut6zOP3/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676097; c=relaxed/simple;
	bh=SsyPPJMmvaysp22qpQse6GPIGFPyPofA986E/cuuBEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0hDPTDJ0aGdj5aFmCBAx3HeoPOW2kgSrSjYsdg0w57k0Y5N7+L4JfBlzqz7EqaL2PKycvj8rGw6K6ismTkSIzb8KI+bpA+7/7Y7fRXG0HwqpiGsnyU9zeGLiWcdxNKXCY9fyR9J8lAVh93n48w949H9MnStJcacx2rTAoP/W4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MbVenKpN; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MbVenKpN"
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e8e11af0f54so1820064276.2
        for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754676094; x=1755280894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTXWcQ/ORdy560KGcCDZgpcNl80jMFH9ifZEN0ULtpw=;
        b=MbVenKpNubDWXeepj6CHnI4ozTJXBx3Cc82B92KS1DG6XpBKqyKAJwZE2/6UDRNOAl
         d5liW3ELvqByDt+j7v3t8jho3OkFnL3Llg2u2hl3Wx2jDLbbXFDoeUsm1eqzrQClUm2G
         5d53N2+j3WijY9m/68gKEWSxmQ5L3JihaLJmXgFhJqcn9Z12QAtQPuAN/HXLSBvrnD5v
         KaIeKgClt/PoscLgHTcNp8Z1KoFrj6sXM0mfX5AYx+TVpKuLAbN/jXfIU6dJ3wfL30cT
         8X/wzzEpg1IEgOOuttkM0aePHp7LJy77dfPARKXU+53zmuN2Buk86JL+5YE/kUVdpesE
         836A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676094; x=1755280894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTXWcQ/ORdy560KGcCDZgpcNl80jMFH9ifZEN0ULtpw=;
        b=D+24wO+U3L7Ls94w7SBTN/zKJpSlsPwlvONGdD08Z0n8YPCP4Iz2WY/WWMRXv1We5o
         L5oVf27Q71GHjviWuDw3WeF1MfOXWFPuRcKENXczr1V8dblHd8ifzEMCurK3TSCLpvmk
         INPfX/Cm7zYN6jew5zdzqY084xknB+F55F9z7wAVF54qVFhfGlf/w+O+njGLqaswjXmT
         vFovbs6vSn6qUXthVgEHm7beIZWTmEoYsiPY8UKEnimMQ2fe8TxIUxkP+fMlu4Fgt/Xc
         C0ljLJoDNsdopQJ7uboYbf0TRsA+ORdn5G2HVl2cGrRC6FR+Lez2bydmJjlO99ALqwgQ
         /yog==
X-Forwarded-Encrypted: i=1; AJvYcCWgFjvdGltKsHgzgpf+qIezbd6OvEI/AyKmipMYBjjsNsFfgE2/VRtmmCqnsyzkLgZzxAfBJHIjzbfPFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVH2W4AkTRe87gwznE1eg6q+AUyjLvPEZJxWk5Rkh6bOHHmnz
	tRekYfxRmG5mH9F0YLLpTTwa6QgM3Dg386qT0JuiDsI7T635W+6+XMrzx1oypd17Q2/3KNC1vNO
	uzCsU6CTzAjSedJ+HLd4CuOX9/XSOHL9z7W4Rwczvh2qrmrl6q1V/
X-Gm-Gg: ASbGncuHCWxFHze5l5eZXL2i3L5lfxN95mkgNZ1SJGXt9OgA7cmBKvHe+2V8cuLThAW
	7iIinc6aCv5tMOR1L58IyMlvNw+dlh7cuA4nCsFoGPHJSe+4KlRCUUHvp4WA2w8xMxgzoElQmvg
	p4aTmQiZv88Rm0YSslnxg5LgkQm4Nol4HGZ5o0tzBeo5BxMIAi7fz6jTyAaHSlo664j+zlu+9AS
	0hdcYXJl5bvuIWMauIVByf9X9t7pXtfl4BHKSZDSDOGWAXGr33N+zrbBZjARUWhaZNODl5Jolzi
	vT5Ap5Lv1iMe65PQIv6k8pn4gaJefoK2+zwJDwIh/27MHAiZW/UBHqSKqCU=
X-Google-Smtp-Source: AGHT+IGpEJmA8wuiu7bHyM3anAmskWUJ+YGhc4UBossIDwMrUMtN/7LChpLKm0Ze705fw0cHnpIVIV1tP4Tt
X-Received: by 2002:a05:6902:114c:b0:e8e:120b:acc7 with SMTP id 3f1490d57ef6-e904b127023mr4685967276.0.1754676093522;
        Fri, 08 Aug 2025 11:01:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e8fea65c517sm1190001276.21.2025.08.08.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:01:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 66C8E340235;
	Fri,  8 Aug 2025 12:01:32 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 57299E4018A; Fri,  8 Aug 2025 12:01:32 -0600 (MDT)
Date: Fri, 8 Aug 2025 12:01:32 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
Message-ID: <aJY7fPmOLMe7T5A7@dev-ushankar.dev.purestorage.com>
References: <20250808155216.296170-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155216.296170-1-csander@purestorage.com>

On Fri, Aug 08, 2025 at 09:52:15AM -0600, Caleb Sander Mateos wrote:
> Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
> daemon") allowed each ublk I/O to have an independent daemon task.
> However, nr_privileged_daemon is only computed based on whether the last
> I/O fetched in each ublk queue has an unprivileged daemon task.
> Fix this by checking whether every fetched I/O's daemon is privileged.
> Change nr_privileged_daemon from a count of queues to a boolean
> indicating whether any I/Os have an unprivileged daemon.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")

Nice catch!

> ---
>  drivers/block/ublk_drv.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6561d2a561fa..a035070dd690 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -233,11 +233,11 @@ struct ublk_device {
>  
>  	struct ublk_params	params;
>  
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
> -	unsigned int		nr_privileged_daemon;
> +	bool 			unprivileged_daemons;
>  	struct mutex cancel_mutex;
>  	bool canceling;
>  	pid_t 	ublksrv_tgid;
>  };
>  
> @@ -1548,11 +1548,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
>  		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>  
>  	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
>  	ub->mm = NULL;
>  	ub->nr_queues_ready = 0;
> -	ub->nr_privileged_daemon = 0;
> +	ub->unprivileged_daemons = false;
>  	ub->ublksrv_tgid = -1;
>  }
>  
>  static struct gendisk *ublk_get_disk(struct ublk_device *ub)
>  {
> @@ -1978,16 +1978,14 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	__must_hold(&ub->mutex)
>  {
>  	ubq->nr_io_ready++;
> -	if (ublk_queue_ready(ubq)) {
> +	if (ublk_queue_ready(ubq))
>  		ub->nr_queues_ready++;
> -
> -		if (capable(CAP_SYS_ADMIN))
> -			ub->nr_privileged_daemon++;
> -	}
> +	if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
> +		ub->unprivileged_daemons = true;

Shorter:

ub->unprivileged_daemons |= !capable(CAP_SYS_ADMIN);

>  
>  	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
>  		/* now we are ready for handling ublk io request */
>  		ublk_reset_io_flags(ub);
>  		complete_all(&ub->completion);
> @@ -2878,12 +2876,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  	ub->dev_info.ublksrv_pid = ublksrv_pid;
>  	ub->ub_disk = disk;
>  
>  	ublk_apply_params(ub);
>  
> -	/* don't probe partitions if any one ubq daemon is un-trusted */
> -	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
> +	/* don't probe partitions if any daemon task is un-trusted */
> +	if (ub->unprivileged_daemons)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>  
>  	ublk_get_device(ub);
>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
>  
> -- 
> 2.45.2
> 
