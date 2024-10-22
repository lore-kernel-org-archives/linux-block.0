Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8D18037
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563349; cv=none; b=utzEhcBp3IC+LHkTDJwOszddlAMe3cjJ28gV3+O4L5smypH3PicpXaCw9ppwfx9jVNzcWnGyeVn6iT9t2U23S7qnXDEvIbspUPKJcn1MBF+5CU+tuJOb27hIUiWY8XZ60wXKUHyGjhJRPiHcteV+VylCMYvUIYOCkePyISnnbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563349; c=relaxed/simple;
	bh=pbeqm/4lDticn44T/H1lEAozJ185Yn/JSE8ABYd2Pdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOND6tUgEYKwFIaVdWk9j83VpDSu0sY4v46nR+WWn8C9UMT8TygRU+hfZBJ530GQON4ZmhiAhxAb8meJvAijh4omTg46mpRo5DpH+cDeiH7oNY8f84Cj5x9lnwa8pJAotJ4eacONaw4/fCstVkVndablMiuseCJgKkqCj2vbQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ARUH4Qhu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ARUH4Qhu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so4180683a91.2
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 19:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729563347; x=1730168147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNlJRbWNX8TeaxenMAs/1dyZVD2NFdZT3ufrI/c9QqU=;
        b=ARUH4QhusZ6+rw3u1HMIcnhbCOSWKDPlwB7vVKX9vB+kJQike667NRVbZfTIep3KJO
         5FJrHPrmp6Sae2eNlqLxCs3ndb7vKH38bVWg1hAM89arLurjTooH8QjCMo8OqtlrxT6r
         ga46f5fMuN6jEw3meI3306ADww4wDQq7BC4uTQfF+qvEWaAXdqsYMdI+icelRtv1HZEs
         lDtbJpY5QpmIiv12fX63rXBHimOtsyR8iM2vFzmTcSH4phUDWpU0wUP7fObbs0RRQ5zH
         7XhCvD+6+VZrlif97Cca0qfFpW85nt2XmCxXXvkfQkDxGZdiaD28MB8WhSHcQoxVRhuI
         2V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563347; x=1730168147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNlJRbWNX8TeaxenMAs/1dyZVD2NFdZT3ufrI/c9QqU=;
        b=RcKwcat+5DfvJIQ8Jmo5OoLXMERTt0n9gN9ErVZiGFnFr/M2RV+0WaQQHwdA1xlbcK
         K0dJnTbnYrTpbMfMdf6SUQxn6ZD2XmBNWwFeokFZ0BJy9om172iu2Ej/mc2ys+SeOGOk
         Y6REIhgrmsat6F5pv8rqiCY7lnDCxtwnNJ5HYmz23EgvxUZxEfCuRTpBxhzk1ihFisAA
         aRVBMmsrUhr1a3S5PyWwqNukiPKw9Qt1tyw+LZstQjh0STnG+5B/V+heQrdSt7ncQQHa
         lFJRnD+uydWtiLFvTxe0KrFHtxPzD1TnirrkhowAZcfA9pz/kd9nH43GItOn1+DNPqW0
         xKFw==
X-Gm-Message-State: AOJu0YyB6oAZ92DvAvsx21bEGkLtsLkt7hhL7kNqBHv0uJgm+Y+QWFMt
	FXEVp76kXAe8GYaSTV4WEbTkiDihjWQeyky5deqI9ZEjZjjJndqj89FjY64WjxQ=
X-Google-Smtp-Source: AGHT+IEtMx3N774bFTm8H+5RinJQCu4GEmpvSWPjvaljYWd5L1x3yvpVMmhWgemDhGVamDKLS0tgqA==
X-Received: by 2002:a17:90a:bb89:b0:2e2:e743:74f7 with SMTP id 98e67ed59e1d1-2e5616e20f5mr15954496a91.2.1729563346921;
        Mon, 21 Oct 2024 19:15:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad5106f8sm4658559a91.49.2024.10.21.19.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 19:15:46 -0700 (PDT)
Message-ID: <45d605c0-848c-4253-8636-4d72d3fd3f6d@kernel.dk>
Date: Mon, 21 Oct 2024 20:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <Zw6a7SlNGMlsHJ19@fedora> <20241016080419.GA30713@lst.de>
 <Zw958YtMExrNhUxy@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zw958YtMExrNhUxy@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 2:31 AM, Ming Lei wrote:
> On Wed, Oct 16, 2024 at 10:04:19AM +0200, Christoph Hellwig wrote:
>> On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
>>> Hello Guys,
>>>
>>> Turns out host controller's DMA alignment is often too relax, so two DMA
>>> buffers may cross same cache line easily, and trigger the warning of
>>> "cacheline tracking EEXIST, overlapping mappings aren't supported".
>>>
>>> The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
>>> enabled when reading from one scsi disk which queue DMA alignment is 3.
>>>
>>
>> We should not allow smaller than cache line alignment on architectures
>> that are not cache coherent indeed.
> 
> Yes, something like the following change:
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a446654ddee5..26bd0e72c68e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -348,7 +348,9 @@ static int blk_validate_limits(struct queue_limits *lim)
>  	 */
>  	if (!lim->dma_alignment)
>  		lim->dma_alignment = SECTOR_SIZE - 1;
> -	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
> +	else if (lim->dma_alignment < L1_CACHE_BYTES - 1)
> +		lim->dma_alignment = L1_CACHE_BYTES - 1;
> +	else if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
>  		return -EINVAL;
>  
>  	if (lim->alignment_offset) {

This will break existing applications, running on an architecture
that are cache coherent.

-- 
Jens Axboe

