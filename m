Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EC4DA15
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815990; cv=none; b=mCCHtWYss+FNswZ3gzc+kIB4T3pJP5llxpveNmyJLm4EugwBDgrOlxrQ9Vs/vM/57hr7JTbBLJ5d5fujNbzq9i7zXeSDH4l8Px2yF86LqNZwTpXEF4fyYedOc7DVHXxO0HuBGc7N3ITjyxW/H3v/rfkXc4hezD6ugkjFxVcegg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815990; c=relaxed/simple;
	bh=kmA44JGlXCXr3hZ+2v5RomkzveC40+e4T6lxFB1zYms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrZWnmO3/FZdUIfanoAaLSOTnx2/YUuJtvszYDoxuAJyrsy3wsadhkq+0bB7JEAjT+b87WSoUjQPNmME1OPneBDOGCir4xsgPe24scBRvIkI3VjKUPMIUDz3GflLs8WD+2Qhtts61HgrvOB/vZ4gh/aEHEJyi5NAmkpfik5AV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KOixnNfK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KOixnNfK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a13075e5so1475115e9.1
        for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708815987; x=1709420787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STRW+sDRKgDfYJ1/C7WIi910D5D2SyAksTFspCka2rw=;
        b=KOixnNfKmo2/odIIn5pMB5Sbj4C+GhG3hUzG8DsseQnmCC8JVbtMDNUthcGZDpICzb
         TltFkYyywNstc6GlyT351Eh0jQ3DAIKXWeHV5c+IX9J/etYzzwCDcSB1+cS6qQF/UPPG
         s8TXD8LSSV/DizWuckxU19GUskjGQ4nw7kT7FSiQlf4cyx9LQHOWwA+AGf/4ERAbc0lW
         i7QCgnj/n4Vm4B2gT+/pYUYiZkxqcg2HLgbMVW8XJ7sitRvocxz8ARbNs2NVUio1uTe+
         iucDlPAhgmdYeaausY+sS3asxuWmV87H+bAQmSxIqU+cGkeHfzi7/eUQSqWK2wbVamaA
         JCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708815987; x=1709420787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STRW+sDRKgDfYJ1/C7WIi910D5D2SyAksTFspCka2rw=;
        b=KUdF++KP+zCMNkxMDsbFY5c5OWrKkRuk4qXjxEqidqjUjAOx9dlNScZEVg49Pgcshx
         +RaKpsWjT9TBinAuYsdWtFgs8RKUmEmn00PCQr1OB8oJHAH9vjFWMxg5lD0SZjnB2bOJ
         jnM4DoewYlbObtZ+dGWKP+fv4nQcbr5k+PCLCKU53bEEBLpxLonn0IhPaor9NIS+sVdL
         rfOJ079qBHhGGimoGGsU5S3DA+W41rJh0GkHwHd0zp7Xy3CiSJ/6KX1RkalGTHYJa5dC
         87/ZvHm4W2D+qrxqbo0w+OQiwrcvmUiI2zYrzd13IrCp6vtaFZAhw1yU/akF+BnLHRfi
         vwyA==
X-Forwarded-Encrypted: i=1; AJvYcCXwTKYm1Sqd6OdYnjZXUU56Iqn5JPRwdOMp8XjsPCUuv34S40yOGjER51I9c7kBJFFVlcpEpJxc2lSjGV9+N/3RUNEXUotk9G02GS4=
X-Gm-Message-State: AOJu0Yy9RA5IWP0fQ+1l3j80I/SRTUrbkwKV/aQTIxhnuEIwKPCD/mID
	o3bqFNKxg5spJa2T898R9K4HLjKjlwYQnwSAFSMgpzpFhec4rHtXUsp2EgiGVu0=
X-Google-Smtp-Source: AGHT+IEvQspgkkNJog6GXKb1zuOkkB3e9OVOtJyq3aKqvY6fQ0XbacweAbTHzk40zRVnU7XEU7uXOA==
X-Received: by 2002:a05:600c:3d09:b0:412:a1eb:4ef1 with SMTP id bh9-20020a05600c3d0900b00412a1eb4ef1mr231783wmb.9.1708815986783;
        Sat, 24 Feb 2024 15:06:26 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c229400b004120675e057sm3415928wmf.0.2024.02.24.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 15:06:26 -0800 (PST)
Date: Sat, 24 Feb 2024 23:06:24 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] block/blk-mq: Don't complete locally if
 capacities are different
Message-ID: <20240224230624.3sk3b5pmhoi67c3r@airbuntu>
References: <20240223155749.2958009-1-qyousef@layalina.io>
 <20240223155749.2958009-3-qyousef@layalina.io>
 <8fc70827-9785-48d0-9a43-e1e3674317e9@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fc70827-9785-48d0-9a43-e1e3674317e9@acm.org>

On 02/23/24 08:09, Bart Van Assche wrote:
> On 2/23/24 07:57, Qais Yousef wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 2dc01551e27c..ea69047e12f7 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1167,10 +1167,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
> >   	if (force_irqthreads())
> >   		return false;
> > -	/* same CPU or cache domain?  Complete locally */
> > +	/* same CPU or cache domain and capacity?  Complete locally */
> >   	if (cpu == rq->mq_ctx->cpu ||
> >   	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
> > -	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
> > +	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> > +	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
> >   		return false;
> >   	/* don't try to IPI to an offline CPU */
> 
> I think it's worth mentioning that this change is intended for storage
> controllers that only support a single completion interrupt. Anyway:

Sorry I didn't realize it is only applied for this scenario.

> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the reviews!
