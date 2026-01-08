Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C47253B42
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843584; cv=none; b=k2XqTt2625nXt/Bfih3piYOfqEUPHmZYiJxC/obzabs/boRQyCf1mxyUETecnz3mQee0+kpkn8iKL4qyVlDfnv6h05dtWcyTE2CyWYcBRFAm6wnn/0iJIF+JZGZyAwV0hh3A2HyoTaJM7P9DSX5BMR/76rbs7Y3VpqJwDBi8MTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843584; c=relaxed/simple;
	bh=syi3iZhR2Jzp4fLb7QsVHlnNmB3FfixFcD+4vgpp/Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spQLr2HLlBbuV2fq/KTmgAzCGOPdo3dBCrOYFrrPdsYSHf9sNdXIbOosKiOpx14aX7pLgEDOmaFyPTiRRp8i7tGBfxaFzBM70IW208GsbPMHptr5XAjwDHR+8/2dBIMos8tUZUEvyKjKOxGwQrtxRWMcBRiF8shLBLoCLFgq+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WSKHsXx+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSKHsXx+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-803474aaa8bso833797b3a.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 19:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767843582; x=1768448382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qc8pspNNXQUhdzs3do5S7dhET6IwPPng/8Ra1Z52ecI=;
        b=WSKHsXx+arJAkq/91j+v0EXxP2JFyG7EeAQFThdTmD1zyXZDfXYXYM1qiLFKU1B+8w
         JWH9qphbJFe115A8DeGhf6aX12C5eZsHsIILvCOj1vyYePSrwesAk4ocdRQHiF/i2Uwl
         hLtmyWIM9X5WrlhoOczxHjmaJHWvX35Z25hnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843582; x=1768448382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc8pspNNXQUhdzs3do5S7dhET6IwPPng/8Ra1Z52ecI=;
        b=hnfw7QwIXgH3DWK7OCS6zn14br1RQEu2cgRrK3bX4TRjcM+hIfqMcLK08OdM1cqoCf
         Zzr3Ljswj0BIUV0bOi479+G6dr2KfGQPFrX/fGnFC3Kl+HmeDSmDwyEbsk25V6W8fQRH
         PVfx0FCr35SWoa5QrmxJODIfpGjvALGBCCA9v7bHG6MT2QCoY7ZPmEqGjP/+cin2O1nC
         HWFiK82MzucyT4vVBtt7oAt3wVhV3r9ScXJ+0R0kjLkPx3JFiv8uknkvIJGkBDxlEhn/
         jpR4wMtEe3JnE44TpqBb/9RkAkn/gBXemVGsIKfhBq5AslIOH24vD4KWTh2+jB3rnJaD
         Sn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAzxI/xJ+pAu0zPtVVn1oOxry0ne+RrYVEYYY//wHXL+IBLEaktuxyOqSY17Gv1Xbnmy/+2H91NoIGEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCV3nAZA/MCae2wFz37m4tt/eHvhzdR1CPO+OVdq5bB0QFhXZ
	43BfYbrH99gjSsJni8tYscA12ZzNk6jodGLAd8KbncAVjfJMApMldiNYpKZC1Qb6kw==
X-Gm-Gg: AY/fxX4ueBbaFVT/9zFIE74gGaOW7O7Oc+gNASV4UCMbv9gghRijuCnAh1+N3PMGjOC
	7v4gS1ixfPQmAncnx6PBRCXro1i3Zg0F2uS7/+O8bz20ND1BwqH4J0Uj8DDk76DGP5GDfQv2+uQ
	RY0goYfc8qvAOBcbC6Ju4q0F8X9KgerVkgtO0LzJM0ecCg3zGZhtam/Yc/8pNfKXWG2D7wVfsoS
	NxUNlzBhqwpKnZjxpvXXZ7YzA+Gw3ceUrC8a3FS2IQH6DRqQST060AlIadyuddF71k11umsBoj/
	/1RLFNSX9Hd3ZmE9EcR2W2jR+CiArlAJ3v+oZWU5huA4Px78V2iqEh9NepUHa4DT7ksn3slby6c
	CpKE4pZalSY1W0GttTxLW7rErgr93CjIwbfUoSndKtZeZSn5usgaN6yrJzj3BIy5E+vkOslD2ob
	LdJydrOfJnW+jjQyOCyymmTgZoJoc+/LQ/++lZT8Sx+KEu28zlJy0=
X-Google-Smtp-Source: AGHT+IGpuF6K1P8/mRvNgLohjXoq793u3g5Fu/6kaGkCnnD2ds/AiOp5VHnjWNr5eMZVtkxAGJI1Lw==
X-Received: by 2002:a05:6a00:ab03:b0:7e8:3fcb:bc4c with SMTP id d2e1a72fcca58-81b78e9ae88mr4717233b3a.33.1767843581800;
        Wed, 07 Jan 2026 19:39:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:7bef:7c13:79b4:e9de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52fd904sm6129668b3a.33.2026.01.07.19.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:39:41 -0800 (PST)
Date: Thu, 8 Jan 2026 12:39:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: zhangdongdong <zhangdongdong925@sina.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, 
	David Stevens <stevensd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
Message-ID: <luzn25fgin43cnbmvmxwps7isqeq2pt5kfn26jqzly6hbnedlp@ojpw52ldzmuw>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
 <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
 <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>
 <z22c2qgw2al73yij2ml2hlle2p24twgpmz4jemfqhjoiekc65f@pvap7olsolfp>
 <a527b179-263f-40ad-9d7c-bfa86731bfde@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a527b179-263f-40ad-9d7c-bfa86731bfde@sina.com>

Hi,

On (26/01/08 10:57), zhangdongdong wrote:
> > Do you use any strategies for writeback?  Compressed writeback
> > is supposed to be used for apps for which latency is not critical
> > or sensitive, because of on-demand decompression costs.
> > 
> 
> Hi Sergey,
> 
> Sorry for the delayed reply — I had some urgent matters come up and only
> got back to this now ;)

No worries, you reply in a perfectly reasonable time frame.

> Yes, we do use writeback strategies on our side. The current implementation
> focuses on batched writeback of compressed data from
> zram, managed on a per-app / per-memcg basis. We track and control how
> much data from each app is written back to the backing storage, with the
> same assumption you mentioned: compressed writeback is primarily
> intended for workloads where latency is not critical.
> 
> Accurate prefetching on swap-in is still an open problem for us. As you
> pointed out, both the I/O itself and on-demand decompression introduce
> additional latency on the readback path, and minimizing their impact
> remains challenging.
> 
> Regarding the workqueue choice: initially we used system_dfl_wq for the
> read/decompression path. Later, based on observed scheduling latency
> under memory pressure, we switched to a dedicated workqueue created with
> WQ_HIGHPRI | WQ_UNBOUND. This change helped reduce scheduling
> interference, but it also reinforced our concern that deferring
> decompression to a worker still adds an extra scheduling hop on the
> swap-in path.

How bad (and often) is your memory pressure situation?  I just wonder
if your case is an outlier, so to speak.


Just thinking aloud:

I really don't see a path back to atomic zram read/write.  Those
were very painful and problematic, I do not consider a possibility
of re-introducing them, especially if the reason is an optional
feature (which comp-wb is).  If we want to improve latency, we need
to find a way to do it without going back to atomic read/write,
assuming that latency becomes unbearable.  But at the same time under
memory pressure everything becomes janky at some point, so I don't
know if comp-wb latency is the biggest problem in that case.

Dunno, *maybe* we can explore a possibility of grabbing both entry-lock
and per-CPU compression stream before we queue async bio, so that in
the bio completion we already *sort of* have everything we need.
However, that comes with a bunch of issues:

- the number of per-CPU compression streams is limited, naturally,
  to the number of CPUs.  So if we have a bunch of comp-wb reads we
  can block all other activities: normal zram reads/writes, which
  compete for the same per-CPU compressions streams.

- this still puts atomicity requirements on the compressors.  I haven't
  looked into, for instance, zstd *de*-compression code, but I know for
  sure that zstd compression code allocates memory internally when
  configured to use pre-trained CD-dictionaries, effectively making zstd
  use GFP_ATOMIC allocations internally, if called from atomic context.
  Do we have anything like that in decompression - I don't know.  But in
  general we cannot be sure that all compressors work in atomic context
  in the same way as they do in non-atomic context.

I don't know if solving it on zram side alone is possible.  Maybe we
can get some help from the block layer: some sort of two-stage bio
submission.  First stage: submit chained bio-s, second stage: iterate
over all submitted and completed bio-s and decompress the data.  Again,
just thinking out loud.
