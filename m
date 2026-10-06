Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4049E14D
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302637; cv=none; b=WoJjwxICnBqM5UgFK04uPDb5GHiSsk4m+pzGoFlakARFSYeQ3C7+oYZ3ajRNHxwSoYoBQ/MGl1VDmJ4C+/V+66JHWx/ItUGH5aeUrRbIMkPD0/rwiQrr6hmbLwFiJuD9NPV3jHyfKZsuGrbBWmztEdtqx02CeX6zqFowju+SOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302637; c=relaxed/simple;
	bh=ejBJ34A0WaeKhICYz9jB7191YUYJRJJt9TTi/tvbCNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhdJWvdkkpnCqECGLC8PhabCZ4mCH7XUABZNGLmoemFcFeiDeYkg/UyXQaf+kAE4/ZszX26BiLLWFO0X34GhLbRjq+zcNvXrc+ez77YpiCK5YuSm5fo3CEy0BfVDDPcEpPDj7Gvn3mb4cDzv1BKE+cn6XDjLouM+HuAUwMxlvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=CTzVepHk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="CTzVepHk"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso2739772f8f.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791302634; x=1791907434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vH6paKGTpK+wu4U0x6N7KJfQorX+loOh90vjv3Up694=;
        b=CTzVepHk5m7IuGxwkuvitKIRaCOgR7gY7sDdsCeljVlSCmEkQC/4mTytVlnlQ37QEy
         Na1Yull+BgUWc2zncwhbNMsWaBkg2zwJxtX/Ljj5iekhNx47ro+BJRcLl7dgIHiutuKo
         tn2sny8+MaQ/qaI4OqEeMNGdGsKwSbu1FcuYWaP6HdHvBYlgpZ6vlyzRJVJN88ljIWWe
         8DtalvX6MfMyIk7XZJ17k8Sn0adFTAy9+KVAYagqUn3V15jI+TbQssvforAQAO0KL03r
         4cYZdQ9QDAsvIp33LF36HtJQkpDA8yLtjU8j9YeAChiaHyMHwumMmcGQlVM8t9m9jWbb
         SfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302634; x=1791907434;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vH6paKGTpK+wu4U0x6N7KJfQorX+loOh90vjv3Up694=;
        b=jWKgzhrQmoNPqHfmud0gF2icEfTSgl5+XH1wEg+UeRZpEJVYaqm8YEtv75M5MAkTUc
         EiYe7IuNXDn0auIfj9S/tuPrFe5np18JZC+WNppT3JIADGVEWvLGY74OUQC4F2gFr/yX
         Pl3w27ZrHyOVFihw0CofzemeskaiFx0oJY2cxw5Ba2Qsaj3OO3C8zJhicwEiAmRFDGR8
         CaY84SfyYAje5TiDOY4obfyL0/nZijaTmHKgj9sT+tL81SFzGkg225FJWvrpIBbM3hce
         Nx2NLfrZOxcSLaaE37KAOjW62cBUcyiMuksFQsD6X7Kxbhi3Dcsp1o8kTv8l5cHI6/6O
         h/rA==
X-Forwarded-Encrypted: i=1; AKwUvByQDyxS3R3aR9hEo9TgCuNffKUuOL36BSytLQUznRXs5Nikh49WKUav6SgrIdMKGLqjRCkUA98CpEuPoA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+cqyXsBne4keJw0siYDaPqiZQDrNMxRHobxcuBdtYHGjeZZ/h
	ep+ac7SCGce09hnsHNJhNlJuD2VWhle1vygTtfgLWdgMF3DPnC8BCEioCk6pD4XPmTY=
X-Gm-Gg: AYBFou1+a1rpGsGQhWt2AliNRMk78c2X/R0yIZ3FYGJxDvwG+xJlnyWkmjVEbi6e3s+
	gECEBnH2UzqW+wya1rpnN2YrBm83u1YGTWq0CkNtpe+P1Zr+jGNFnlT3QG2ysQhGaWn1qVQW4Vj
	+uIMrOnMpy+UqoiAci7fSC3hxyYEpTntwy7VHm8vC/ycZfAlGkCSXHGSPNFohooCdSe9CY7CiRt
	jOqK6317pLkWBTURgcRNdrOF0zm6Zi1nXpYVfZrv59Uzo6BvP63FVb1BBPMIXUyrEmSEx1CAXJy
	yqh0z6nzs3V/tEhVE7oCtzqRQyUVL3WwvldYeRnPgNda0i8uCqGVQxU52m7Mkqz+xtn/CaURIQ+
	/BW1joPE3ZY96jiVFxOtHszmr9AvQcO4opRmdbIfLAnLS9WnkLQ+ef/cDxEh65/12DJrKYqnIf4
	eqye9ijAtLLMn9wxLusbgzTpETYQiRJIChFvO9wreyTPm0E2uk4+4MgzRwQ9DUfEIZ5WZPkTqIo
	ASi8XLbagaq8HzIGzGl5HBV2MsK3yZ+sEkzS+51gPdNEFmSetPI8opj1MxMtWjCkw==
X-Received: by 2002:a05:6000:4313:b0:48a:fbd2:c2b6 with SMTP id ffacd0b85a97d-48c4801c363mr19266196f8f.55.1791302632870;
        Tue, 06 Oct 2026 09:03:52 -0700 (PDT)
Received: from ?IPV6:2001:4bc9:b00f:d376:7c33:9a50:ef33:f391? ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2e2e9sm364931f8f.46.2026.10.06.09.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:03:52 -0700 (PDT)
Message-ID: <0d3a8391-0de9-4b9f-b14a-9d4f33d2e7fd@linbit.com>
Date: Tue, 6 Oct 2026 18:03:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] drbd: add DAX/PMEM support for metadata access
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
 <20261006154607.3936501-7-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20261006154607.3936501-7-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/26 17:45, Christoph Böhmwalder wrote:
> When DRBD's metadata device resides on persistent memory (PMEM/NVDIMM),
> accessing it by reading and writing full blocks is unnecessarily
> costly.
> Add a DAX-based metadata path that directly maps the metadata region,
> enabling byte-granular, IRQ-safe access without having to go through
> the block layer.
> 
> The PMEM path also introduces a more efficient activity log layout:
> instead of writing journal transactions, the in-memory LRU-cache hash
> table is stored directly in persistent memory and updated in-place.
> Similarly, the resync bitmap is accessed directly from PMEM rather than
> being loaded into and flushed from DRAM.
> 
> This is compiled in only when CONFIG_DEV_DAX_PMEM is enabled.
> 
> Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> ---
>   drivers/block/drbd/Makefile        |   1 +
>   drivers/block/drbd/drbd_dax_pmem.c | 172 +++++++++++++++++++++++++++++
>   drivers/block/drbd/drbd_dax_pmem.h |  43 ++++++++
>   3 files changed, 216 insertions(+)
>   create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
>   create mode 100644 drivers/block/drbd/drbd_dax_pmem.h

Sorry, the CCs for DAX got dropped, adding them now. Original link:
https://lore.kernel.org/linux-block/20261006154607.3936501-7-christoph.boehmwalder@linbit.com/
