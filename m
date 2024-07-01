Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85014381C4
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867803; cv=none; b=HaEHgt11d4pVtvO/HeOeSsq4qI578vBJycv0i+/5topzEVnjfF4p6z+HhMZAbzD+dhiul8x1MqjG1G/hoqgUIyN2el9zftZAqNDN29brE/nxomF3EOC2MFV47uVv06Q06VyUQoaQM19HnQrRSGjQ5kPw3KrzAC7RBHNUVSV6Aso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867803; c=relaxed/simple;
	bh=LR0b/O13CTgzTuYWkjcpZsu7TTutw6ZnD6dz55Udfp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYT1f0WxSy4yaRK2e48QIh1J46+xlOM7Yjx8LI6kHJA154AyKDEYrxXnKXpoVRmDz7O5JJCtOIVNsf3zauMmhwDSLmrcwmjXFkGBPY7dF51JzxU/rt4VNM9sTxtohTsIBKjAoOUUCS8yqI/m+rme6RVyYQtHnPilg6XtYYmwGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fWRHQVLW; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fWRHQVLW"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-4ef780ae561so1937371e0c.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2024 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719867800; x=1720472600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqGG29yuvpaxq8YxBPYIVI2DBBbkQ+aDkAyAZUIZKG4=;
        b=fWRHQVLWgQ83kBgHwEohsTeNYMXQG+jxXVrjpTKZ4dOPtcP8fTZp6dd5ndnbZak6Wf
         tEGSLy70SG1glnBv2T0vFqlPmU9/hgrgg9V7liiDmefQw0DCsd3rurOYJKsgjyghIQ0Z
         2dnumoqpXD9uJ7WCYb+mfF1UH9B+4g/B9IwcZayBB1+BOYbZq9BPg+pUbaTgnpVbPWD7
         O7WSvjY0xUrK/rhs7vLahwNoAGNWeyv7BljychajmeL1iw2wccCSVEGUBhLuHughpIDf
         ga4RHVbww+kkHrXCSrm1d5M9sFP9ZfneAamy6i+Fm1+kYhrWVXdO2lJAbgk0tfdbcM67
         nmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719867800; x=1720472600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqGG29yuvpaxq8YxBPYIVI2DBBbkQ+aDkAyAZUIZKG4=;
        b=S9SxF4KJuSVJc14QBueQ3UfdrvjFYFIl4+wFp/PUsdqmrPQT5kIfWyQpKqXPbd8Jol
         bR4AVTRSiopDhh1KDpBzrxZIBJMY6dfGvZgKM2mRh9uWbCXs1iA1xfcDkB9qXvH/3Qi7
         89mdsmLvk7CuY4fgZJpr8a2dOzZ2IqAdEnCXkuBVcm/Z7EsavXaqUl2Kabj94QCL9dFp
         90ZMj5bVT3WImd15bLwnfSnUMXuje/SCugZqjVsZJ9KAUlwftvFaRMm2a1nHkS643Hcz
         E01GagEyQkB3YPjFGOl3cmOgyjNQDyiKtpNie/z/baPiCQp9SVi/Ev2MgLIEN4IY8tLs
         5Yqw==
X-Forwarded-Encrypted: i=1; AJvYcCXgGafIyW6i7vDeJHcouNdBQX9pFveB22Ynb4zgrifWeTZqITT33upi/+fopa0jp8jpK9wZ62iKcnIdVchfQ8339jcnyXzFmdh/mkU=
X-Gm-Message-State: AOJu0Yy9VEYhB/Wdwy9k0r651rW5KQneib1V3hV3aXOJvLNCVGGJ7aY3
	+gBqcunsNzhOn6Eiyh4OCvBuRC6n3nl84zMPY26gx6LPzMcqdbUByLy3hHvwwKY5v8jmN3Eu9jN
	o1j2OeQNfQXEvmlcCIx01dmBDI2A1DzlB9rzzrWutr2ZES8Zg
X-Google-Smtp-Source: AGHT+IHmmWr1SgkPXfYy0+vwxILRWcMdybEndT2rqnzFvYVTmWb2oK2QCC6XJzx+KUV1IM5fSyx1SYt7YuYi
X-Received: by 2002:a05:6122:3706:b0:4da:ae51:b755 with SMTP id 71dfb90a1353d-4f2a57045d8mr4464950e0c.3.1719867800330;
        Mon, 01 Jul 2024 14:03:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-4f2922677d3sm356116e0c.14.2024.07.01.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:03:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8518C3401FD;
	Mon,  1 Jul 2024 15:03:19 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 85368E42CA2; Mon,  1 Jul 2024 15:02:49 -0600 (MDT)
Date: Mon, 1 Jul 2024 15:02:49 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZoMZeWrQclRu2k9s@dev-ushankar.dev.purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZnDs5zLc5oA1jPVA@fedora>
 <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
 <Zny9vr/2iHIkc2bC@fedora>
 <Zn2cuwpM+/dK/682@dev-ushankar.dev.purestorage.com>
 <ZoFkFB8Fcw5gCDln@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoFkFB8Fcw5gCDln@fedora>

On Sun, Jun 30, 2024 at 09:56:36PM +0800, Ming Lei wrote:
> I meant that the following one-line patch may address your issue:
> 
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4e159948c912..a89240f4f7b0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1068,7 +1068,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
>  		struct request *rq)
>  {
>  	/* We cannot process this rq so just requeue it. */
> -	if (ublk_queue_can_use_recovery(ubq))
> +	if (ublk_queue_can_use_recovery_reissue(ubq))
>  		blk_mq_requeue_request(rq, false);
>  	else
>  		blk_mq_end_request(rq, BLK_STS_IOERR);

It does not work (ran the same test from my previous email, got the same
results), and how could it? As I've already mentioned several times, the
root of the issue is that when UBLK_F_USER_RECOVERY is set, the request
queue remains quiesced when the server has exited. Quiescing the queue
means that the block layer will not call the driver's queue_rq when I/Os
are submitted. Instead the block layer will queue those I/Os internally,
only submitting them to the driver when the queue is unquiesced, which,
in the current ublk_drv, only happens when the device is recovered or
deleted.

Having ublk_drv return errors to I/Os issued while there is no ublk
server requires the queue to be unquiesced. My patchset actually does
this (see patch 4/4).

