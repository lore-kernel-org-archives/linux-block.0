Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F740FDA4
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303381; cv=pass; b=qthvYOkZMZ5orTRfP4qdy5KKH5sB+7IUYaeh+OH4/BThjWpTAerEKdvW+rGWeorV5DCDdYD1awDQ3rEbzh4VF15XCMR1H4SerBTgJNvg8hQL/mxTwJEU7/OLkzmxJNEQlc71ckgPTpuwF6QXu+UdkTIj6RVreuD0CsybSAuGXSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303381; c=relaxed/simple;
	bh=a8UGlQ4it/4rjmlTSwbY3biq3UiTr0x4Cw6OqgopNZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTBoCrQHbYhfiLkwKN7mqBkZC+BZc/f+oNXtspQzRUe/QOeUd6aHxrlazUCSZvoLpg4Cp6pxdHqy2IGXHixlj1lPvxoovjAbGpk4jmQdmz23LPcHv+YMNJD1t8etO4HRdOWNafom7ZP08WdNuYa1ku7ENxJKdJrnajebrilgyBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZt6dC5H; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZt6dC5H"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e17afd2d5so1412910e87.3
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 06:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770303379; cv=none;
        d=google.com; s=arc-20240605;
        b=DsG0v9wwD/vNAuhOH0u6Tj7gToFTU6pShLSPd9xXYLIXud8YhCqRaq1csjhrp73bTy
         Qdro84BJKv2//whJrCtrwOX3KYVW14sd0Y8yzUHhsUS3iU+fQG2/UUkyT1YYfxkrkk1E
         msI5QmfBdua/j5wf3M41CRPbdYWYid4NOYleLFrJfV8fFy0wX5WD1GG12Lpesuoj71U9
         dpLhDI3sm6/Zs+oUvmFjoHXOKnqXb4Xv9fj8qH+yBeWgUg8RIUS22PDIsEfb4JIXUvqv
         ALzrrqiAH7oprNGdfI3LuVuf6HX+UIlp7qLqBGNodb3v5O0RWtje3k70G8WwiRqAdBFk
         2iZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a8UGlQ4it/4rjmlTSwbY3biq3UiTr0x4Cw6OqgopNZ8=;
        fh=ZKiLjvecGSYoTDXShPa6nOlbpGQ0qXBqqTOoGoKg0+8=;
        b=HHgHcyK/fQ0QsiRA93F0BbPXhruwkUTVAk2rNpxiXfYhSQJo3bZPl1BvC9LbbIedOK
         sBOox6/MalqQ2XcMnKDwnuwi/HbBZ6j8aL+KtmKk4RO6Hd69kj8lxH72vUViAdGqXs5Q
         fSM1ICC9QrlxQKvWdHpeGtt2cWN72lEbaGf9HDo/73/hwM5BKObwf6Zz/SD0XcKqlW7+
         U7hEtbOkTTZ5SRcSJuvsIFJnYe1GZ0fbndC2TSoVnQdrSrQ/lGSvZgKwEot38YRifrEE
         buPF5bHaRNqrV23zXpTtXxmpmvu344P1x/KlzpvMBazjrKKRCXGP00d6H5ptmXQihbo0
         fVBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770303379; x=1770908179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a8UGlQ4it/4rjmlTSwbY3biq3UiTr0x4Cw6OqgopNZ8=;
        b=zZt6dC5HbiB2zRJV65Iim6TsolfX1HXSI4TBaFPbEMYkZz9fDi4iohN+6FXfPO7FhX
         XwnTtAYbjStJ7o2mE+vvsXbQ8ml61gOkLroHe9wubAJghxEvCBDhsYzQP0bvsQdmFkNG
         ctRGtFOB7tRkWi69iKkp4g89QKTgkHLBC4I7PDHDBumBkfL9TxJzq3d7zwbJJwU25ZZP
         QMBD9RhkCPdmO9NYZMW+SWi+kstfzC4dSx/YQClk60qvCfw1wwwZ9B4VS7Rjl2e3yvv1
         o3PFfoSxrSGGG8bcVRWcFUbK1O3V3mfUhGy8ptcM9JneOXG1j4Kd8aGc6prwjhsrgEn5
         QVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303379; x=1770908179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8UGlQ4it/4rjmlTSwbY3biq3UiTr0x4Cw6OqgopNZ8=;
        b=FKGnRFxtEE59vhngpUiZ5SZiFTVBVP+OrQOgk70ELulumZBitqeaobANWICVGyYbbQ
         UcFJqL5zfpvoMSvexRZTXJcVqDxeZIeJG1JiKSpypFwrjeYjAKNGU4VZp+kZo1+I3evG
         gYg9O+S8+LJI5fqwKZanmfrWMmil7PdKx6eUwhrjMLrjXtNuzV1Kk2pcyOpQGmLaodXG
         W9GElw/tca+I9j3gtBWk9TS7lNKt4iSBch3QY2Lwy9FABfB/wKUd+Wfh/CUzcN5ZEepY
         JgWDyiSHo3fmdEzlBv8aWjtGYiboKzFXgeCfJZ2eslV9eJG/mLDYQVwT4vDEkGfEqL1M
         hM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZzr0ubAbMDEEMd5liGmbPyI2SYr8SIVRXoKiwGfAkGJ8KdWeejjKNO8W/IJBEmHLzJXvkbzd67W92Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1EaR1KR5QGitMeNEuqsa7nUbhrtnMMqTzYwiFW+Vy4ukNBbX
	cuQ+fg//aa9KkgwUHoONOR+m70rt7hpOff5rxDuqlm7jnAumWoz702aoRDQaGhnoHy2XE5vqlTj
	liTQqYhVEbvbd2CGxHqv+ur5AF1M2odW//XRYA2oWeQ==
X-Gm-Gg: AZuq6aKcsBXy666l97mghCvATdjOZLad0Ao0XS9asKtFrQksCxkwVRU6XoUXORILRQ2
	ETKS+OpXASpsws8a0ZGLpO8dcXN/S8AP2z0ty74y5/5hjXZaNAykoZ74eg2tcooZbrmZYWUty/a
	M+LJ8x4lNsKLoeK6CUx2vU9M4gphBvNw4vaHzhQY1uEROtPji/2TovOwfF0+6Jl9e9YjqjsuMwP
	CbL3wMJwClXyEcNSLvsYFPSdBBkItAGp/cR/VLqN/3q52K+/nE3SVcua5d0Y2HVOUcTftEG
X-Received: by 2002:a05:6512:2523:b0:59d:f473:aa8e with SMTP id
 2adb3069b0e04-59e38c27a3emr2431070e87.27.1770303378986; Thu, 05 Feb 2026
 06:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com> <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org> <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org> <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
 <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org> <CAPDyKFqQCtXzRruVSy0RLfWw11=TB+HAqN=+0P7St=aovZOoEg@mail.gmail.com>
 <4f1d5c9a-f261-49da-9ae6-f068bcd7402c@acm.org>
In-Reply-To: <4f1d5c9a-f261-49da-9ae6-f068bcd7402c@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Feb 2026 15:55:42 +0100
X-Gm-Features: AZwV_QiIMgeILf_6udDuquP88lDGVGj5C32chTiT5zTMK1nwYFJwXumF4IHZ8Ic
Message-ID: <CAPDyKFqUw-HaKpvqBzoYm8K5gTjdwskAEcWGxnMHaj17QcKLjQ@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Feb 2026 at 15:21, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/5/26 3:26 AM, Ulf Hansson wrote:
> > The other concern I was trying to point out, is that using the runtime
> > PM suspend/resume callbacks for managing the QoS constraint isn't
> > really a good fit in my opinion, because of the potential idle period
> > beyond the point when I/O was completed and when we may be waiting for
> > the device to be runtime suspended (especially when runtime PM
> > autosuspend is used).
> >
> > More precisely, during this idle period there is no point in keeping
> > the QoS constraint as it would mean potentially wasting unnecessary
> > energy by preventing low power states for CPUs. Ideally, I think it
> > would be better if we could monitor the I/O request queue to manage
> > the QoS constraint directly. Perhaps that is what you suggested too, I
> > just didn't get it. :-)
>
> Hmm ... the block layer RPM code monitors the request queue, isn't it?
> I don't see how the request queue could be monitored more directly than
> how the block layer RPM code does it today - by checking the counter of
> the number of requests that is in flight?
>
> Deciding that the I/O request queue is empty is not possible without
> waiting until the idle period has expired, isn't it?

Right, this is how it works today. We would need something additional
to what we have, to allow us to better manage performance
optimizations dynamically for block I/O. Exactly how to implement
this, needs further exploring, at least from my side.

FYI, related to this, there is a series from Qcom [1], that in
principle wants to allow some of the CPUs to enter deep idle states,
while keeping others to only shallow idle states. This is especially
useful for some UFS based platforms it seems.

>
> > That said, speaking about runtime suspend for UFS. Is runtime PM
> > enabled for the UFS card too or is it just the UFS host controller
> > that supports it?
>
> It depends on the decisions made by the manufacturer of the device that
> includes the UFS device.
>
> In multiple recent UFS-powered devices RPM is enabled for both the UFS
> device and the UFS host controller.

Okay, thanks for letting me know and taking your time to answer all my
questions!

Kind regards
Uffe

[1]
[PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
resctrl integration
https://lore.kernel.org/all/20250721124104.806120-1-quic_zhonhan@quicinc.com/
