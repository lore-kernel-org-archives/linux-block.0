Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEB1A9FA0
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704250; cv=pass; b=iFVVnlw0IYip2zxYcGy0ZWYx2kn31tUBlDAhv4yOBGN3xbVcj4o1EbPReto/riiKlht6cT47McnAURDdZvOs/5WnWCb4cCl3rEHVtVUVFaLXgi2PGlnXwW2bMUQaFHmittXaM25UBMtN29EmM4Jg9xwZNmxZtleDLRkDbWO/Agg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704250; c=relaxed/simple;
	bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLOZFAVzhNpd3ILJdl7hZmaQ8WjbPQf58vT6aJM44wnCyyPIn/mDmm7FavAnO9c+F9HLBEznX3qnnyUk37APIEdz7z8FJG2JHjNcfkW0oJnCcVDhEC6KrWvJafI5owfLS54ZNXavkguDvcKNgLF29Huc38SYTIs7l3KRcdl30cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqaIKzeo; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqaIKzeo"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7942b9663f8so11208667b3.2
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 08:30:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704248; cv=none;
        d=google.com; s=arc-20240605;
        b=DgbnEF3uEHyH9ljor3jzl/5uyCq8N5/09VIBZaXvLmona9sZSi/7RINlQiVqHyx6fM
         Fa5KuK600AytNp9iSLPAzAHik9MI3Dzria5dcT1ciydP3HeHf1G+lCi19e6YrX7BpyT9
         4WdnRq6UBGJDsy4HxJOajFog8LDkZ7qAJsIFg3Lz3hCIBn/+vjEgV54YCqRq5luD8br6
         FQeuEDj94rSKRfBJh1XWswgNPFtugGFs55UbVkFrh5nQh+I4570rehUuDssRlI6w97DS
         7xcYCyzLqG1tVPbhuQvUN1WYJFR7gQ7few/T03VphBHCY/CuXa+cKfC3F30V+1THEC51
         YpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
        fh=Q+FypyAvpZ6jxU5JDC/i+HXGWMpJQD7h3wpusJFMR3I=;
        b=e5onNEgl/aIMtORs276Vs/+WWBxp8tkz853DuPfpTmsgheO84QQVQr+Gz/0xVXojFX
         E20Hx/7OxY4xul3mqr/WcAhbw2pkzizFwO5nvhI+MtdgzvcH+EZUHUUPPx/XMkZ3+UDh
         PlGXUpLUO/d7/cam89aVwwU7whPIhbNtB6ZjDOcMfa9g9TbrVWjDYdDcRcnX3wYs4XuA
         ETjj4h8H4K2JWOxO/FDJnHRA82g+UGa6ge16NH9++FD9xyLhBBeRtDDveS/w2D/q0LSa
         xlLQTLMlxnJjz2HByb1cuTg68U2Juvv+Xftxb2dKZyloKmFv1TgkKR+tkrY3R5kV9h1m
         ullw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769704248; x=1770309048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
        b=LqaIKzeo89i+1D9ITmdHiEvD24E8B9oYrgGqHzTgS6mBq8I+OcyiUhgxZKXjDJgjZ7
         L+Sml4oRdBFNSvkRes0cBfH9lNLxJoxH+gG9tvKjSL4Q2lll3DdMjIWK2TPpdRb6xt5c
         ECLRn0NBwEQusZLgbQnT7lzQPz32sWHZE4+b3f0nIbAHGVHU9sVYG1P5hlqf8fR+kgIi
         jxER+AEGMZ465KJh8ykKS1XheD4jRT7a+uleMyjGiZ26HXwINVxLRE6PYRIBKaHkWwqc
         XhL/9ntsNpgL2e+AOkvc/tbYFPsN7j02r6MwlbvRyAM2bHfgCc9UUWp3OtZQxmgd0BjZ
         +N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769704248; x=1770309048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
        b=bl7SIfbqIQPx5Oc8X937KgCazQzqw0gOPikWsk4a8vzp9ylplwR42DoIgwUHrnAuU2
         05eiRXXwBVkoqSf8HFNSgNzxXHakAHPjuCbXw3jZnwu8Bv0X3lEnWwpez4JhISP9PZAu
         Owvt5MBrvJ4fGKBxQQwnfOpTMYx83bjP486Gux0I7gz6OPZ/6P9QsQkXxqgK7ZuITkuy
         pLRfWoORRRUtIUW2xY0MdnLdlzsEHRHOpSsKfjN8EoYBlLkUKBI8lrVsmsop8WElOakF
         OPmY5hTGhiUwSAAWCXOuZgBFKHkUVvTdC0dfpB+L3YFzlrRvhhkvBzyFeNS5lM9POzse
         ME+w==
X-Forwarded-Encrypted: i=1; AJvYcCVW5XMvEDP9LORAOcCWEFeFIOMyTf6rR5zlqSIRcy3PmmfAfJI2G19AX0DviLys/gTbnCkneUuiCrIUDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0yF8egzyqq3Uxc7kNIB89B3p++ICJDhezVArXxT0r/9qr1xV
	ydN+IgqqX5XI+OLtJMQ3UyxkU4hzcL/eCYutfkrtnwZuTDxBzv4r6IVnNM4ZF5t7Mah3mTHhiBP
	AucxGEV+uICD8T5gcWaTOg4z1l5+KaBmp20rnAgSEDQ==
X-Gm-Gg: AZuq6aJwfA1RHugPghL5T3+dtiB/wREjVyWAG/CZNe+l1n2gMPJ/yh9DY2d4V1fiDu5
	dCRuhrl2VtRbo9hjroj/IGSKWncF+8NU8SGdx0SNl3LOfjFBuKV353oNZu7iooCl1iQRrGVLpNe
	FYYIO2smyeFQS2BnCHxCzliFfKM9U2T7ixR1x+0i1oFuPii9/0UquLKx5HS541M+g0GjAt9tXql
	4wl7seSAgxbny8tnoZIOcCokC3++63+ZRld7Djvby7fn9OnNn6TRQm13pJVoLMISslJ7RCm
X-Received: by 2002:a05:690e:1289:b0:640:d038:faf9 with SMTP id
 956f58d0204a3-6498fbea031mr7601190d50.25.1769704247594; Thu, 29 Jan 2026
 08:30:47 -0800 (PST)
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
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
In-Reply-To: <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 17:30:09 +0100
X-Gm-Features: AZwV_QjytStzTOurWO3CXaL0g7b2jcLaq-PrDPAkELLOYAXi76jWAbJAWB6sOTA
Message-ID: <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 18:14, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/28/26 5:23 AM, Ulf Hansson wrote:
> > How does other block device drivers do this?
>
> The role of the Linux kernel is to provide mechanisms while remaining as
> policy-neutral as possible. In other words, it is up to user space to
> decide whether to enable or to disable runtime PM.

I agree.

>
> For UFS devices some form of runtime PM is enabled by default for
> battery-powered devices because otherwise the impact on battery life
> would be unacceptable. If the latency impact of runtime resume is not
> acceptable for some applications then it is up to user space software to
> tune runtime power management as necessary.

Seems reasonable to me, but how do we distinguish that it's a
battery-powered device?

Are we considering UFS a technology that is used solely for
battery-powered devices or is there something else we consider?

>
> Additionally, cpu_latency_qos_update_request() is called by the UFS
> driver during runtime suspend and resume to prevent that CPU frequency
> scaling negatively affects UFS processing latency. I'd like to move
> these cpu_latency_qos_update_request() calls from the UFS driver into
> the block layer core because I think that every block driver that
> supports runtime power management needs this.

While this is more about performance tuning rather than I/O request
latency in regards to runtime PM, I certainly agree that this belongs
in the common block code.

Although, a tricky part when moving it upwards into the more common
layers, is that those latency constraint values may have a very
different impact, as the numbers are platform specific, right?

Thanks a lot for your comments!

Kind regards
Uffe
