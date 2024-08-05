Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8CEDC
	for <linux-block@vger.kernel.org>; Mon,  5 Aug 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722823674; cv=none; b=dbZa69/pDimKpXAL699ictezF2+YeP8W9MYCVDuxkHPQWshI4ZlTicdvQGiPRzchzYeLGjITZEFzfu7Umzjt3KhxFeWoXzYjW0ds1gd1Wn+hzGKS0pz2ww8pFMqGA0A8B7itFp6kVyCgP/M6zTxnOgxHLq2h0+DC6veZKyGAzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722823674; c=relaxed/simple;
	bh=02Ixq5pIp+8djUolzGHBcTS7t76QR9r1pFKOmxfuU7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utFMd1M/itkkiuyREdeUWLeTqEW8+2F6ISa59TSfTfStdQr9f1JzG0lOX6qZ2hIA9CuHRSZLOMB9L5x8paEMF0c8g14cQho3/+Qhy8itM26rYew7MdiT+EF6LkjXda8vripo2GO5VoGPM1ZaadL/DkTaQ6dVROT/2yLZEjr40Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KO+Z5U8s; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KO+Z5U8s"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36887ca3da2so4834426f8f.2
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2024 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722823671; x=1723428471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XSioxKrr0MxfwKg7nWg+cSl77s3pzKy5vnGE/4EXcRw=;
        b=KO+Z5U8sPkRFl/wbU66U8ujWE7nN0P5j7U290spzYUUAxxw3I3tBcC4MKxCUclkHQ8
         XMHCF+e6jhfBAW6Kyy42R2ALL6fKzNWiYLO1IMPR8cVdUOQHEsUp/LgI388e0sVoVnch
         8TtFbQDeGfihkQw6TCcdo0g1fCRp0XEa0wLfw41iBMaoK+LkEPHyc7XHvvg/l2evVGsf
         DE1R5Q3GobswZbfWRrr6Bib2CnU6XFlh0EF3XwAoJA6Cd9u5UrEyjHqHr36+mmSokuiQ
         mTlqhNHvLhKmhSypGsZiJFHNlUhoGQbNlc3FdHYz6YeQyssWQfo78Zqpa7Sg3B+ip6PH
         YJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722823671; x=1723428471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSioxKrr0MxfwKg7nWg+cSl77s3pzKy5vnGE/4EXcRw=;
        b=iBavqttEcACqddB7Qfayw47xZ5c/MgLwTBKs1HjY+9/mAPuDy7LQLPgjVZWK8Lzlx6
         JT9ely9fDG6u0T4rXXhkyrKQAiuvvi3k0g++RJPgy2yLiufElIe+MqeFi2gL2vpb6I9y
         Dlxuva9H1/gsipehJ43IELzko/h+aWLhL7nVkO3FD3sESDaln9PvmDOjJ7jDgnAwMrk3
         GW0Gb4jFxuIz1FcHL3e/BoGarFwFB9fWUF1d2NMo1duxezJXElAv5FEQq9Ny0Wdk5xRn
         2KTAND8Dbd0+YE9zKyZIOIDi3rGdikYQldx1+nzZ4JIK5Qjjh9IUqyYQPIzeFbFvFn0C
         1vtw==
X-Forwarded-Encrypted: i=1; AJvYcCW6T4tRDAADzhyKuK0OAEUtzQGfot0MMzs1Pq28fogN72uBseSGLiKeAs+Jtnf/VaXA4BisQfNHyypfDZ2u8htxrhEkkt0tcNvoQMQ=
X-Gm-Message-State: AOJu0YyTTD8eiTQmrKYlZawHCBZyCbr4PgfZMPqtCPYQnWlIwnlUwir5
	X/YLdGLgL6CuQliX3U71LrFiJW8RMzZrgsDlQq8+q3lmmQi4QAwLsVy+31FzDTXuVvBH8dKVw1c
	Y
X-Google-Smtp-Source: AGHT+IHLnpAN7TNRPW+ZvAIh2Zaaba6wDGNIN+vTtPEOccA72wszIfnLmWKjlTgAHB4qJ/x8tB2MCw==
X-Received: by 2002:adf:ed01:0:b0:367:f245:d847 with SMTP id ffacd0b85a97d-36bbc0e565fmr5895243f8f.2.1722823670466;
        Sun, 04 Aug 2024 19:07:50 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06df9esm8268729f8f.100.2024.08.04.19.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 19:07:50 -0700 (PDT)
Date: Mon, 5 Aug 2024 03:07:48 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: MANISH PANDEY <quic_mapa@quicinc.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-block@vger.kernel.org,
	sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240805020748.d2tvt7c757hi24na@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3feb5226-7872-432b-9781-29903979d34a@arm.com>

On 08/02/24 10:03, Christian Loehle wrote:
> On 7/31/24 14:46, MANISH PANDEY wrote:
> > Hi Qais Yousef,
> 
> Qais already asked the important question, still some from my end.
> 
> > Recently we observed below patch has been merged
> > https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io
> > 
> > This patch is causing performance degradation ~20% in Random IO along with significant drop in Sequential IO performance. So we would like to revert this patch as it impacts MCQ UFS devices heavily. Though Non MCQ devices are also getting impacted due to this.
> 
> I'm curious about the sequential IO part in particular, what's the blocksize and throughput?
> If blocksize is large enough the completion and submission parts are hopefully not as critical.
> 
> > 
> > We have several concerns with the patch
> > 1. This patch takes away the luxury of affining best possible cpus from   device drivers and limits driver to fall in same group of CPUs.
> > 
> > 2. Why can't device driver use irq affinity to use desired CPUs to complete the IO request, instead of forcing it from block layer.
> > 
> > 3. Already CPUs are grouped based on LLC, then if a new categorization is required ?
> 
> As Qais hinted at, because of systems that share LLC on all CPUs but are HMP.
> 
> > 
> >> big performance impact if the IO request
> >> was done from a CPU with higher capacity but the interrupt is serviced
> >> on a lower capacity CPU.
> > 
> > This patch doesn't considers the issue of contention in submission path and completion path. Also what if we want to complete the request of smaller capacity CPU to Higher capacity CPU?
> > Shouldn't a device driver take care of this and allow the vendors to use the best possible combination they want to use?
> > Does it considers MCQ devices and different SQ<->CQ mappings?
> 
> So I'm assuming you're seeing something like the following:
> Some CPU(s) (call them S) are submitting IO, hardirq triggers on
> S.
> Before the patch the completion softirq could run on a !S CPU,
> now it runs on S. Am I then correct in assuming your workload
> is CPU-bound on S? Would you share some details about the
> workload, too?
> 
> What's the capacity of CPU(s) S then?
> IOW does this help?
> 
> -->8--
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..a4a2500c4ef6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
>         if (cpu == rq->mq_ctx->cpu ||
>             (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>              cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
> +            arch_scale_cpu_capacity(cpu) >= arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>                 return false;
>  
>         /* don't try to IPI to an offline CPU */

FWIW, that's what I had in the first version of the patch, but moved away from
it. I think this will constitute a policy.

Keep in mind that driver setting affinity like Manish case is not something
represent a kernel driver as I don't anticipate in-kernel driver to hardcode
affinities otherwise they won't be portable. irqbalancers usually move the
interrupts, and I'm not sure we can make an assumption about the reason an
interrupt is triggering on different capacity CPU.

My understanding of rq_affinity=1 is to match the perf of requester. Given that
the characteristic of HMP system is that power has an equal importance to perf
(I think this now has become true for all systems by the way), saying that the
match in one direction is better than the other is sort of forcing a policy of
perf first which I don't think is a good thing to enforce. We don't have enough
info to decide at this level. And our users care about both.

If no matching is required, it makes sense to set rq_affinity to 0. When
matching is enabled, we need to rely on per-task iowait boost to help the
requester to run at a bigger CPU, and naturally the completion will follow when
rq_affinity=1. If the requester doesn't need the big perf, but the irq
triggered on a bigger core, I struggle to understand why it is good for
completion to run on bigger core without the requester also being on a similar
bigger core to truly maximize perf.

By the way, if we assume LLC wasn't the same, then assuming HMP system too, and
reverting my patch, then the behavior was to move the completion from bigger
core to little core.

So two things to observe:

1. The patch keeps the behavior when LLC truly is not shared on such systems,
   which was in the past.
2. LLC in this case is most likely L2, and the usual trend is that the bigger
   the core the bigger L2. So the LLC characteristic is different and could
   have impacted performance. No one seem to have cared in the past. I think
   capacity gives this notion now implicitly.
