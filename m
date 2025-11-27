Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CFC35979
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211631; cv=none; b=tJ3N300bIsggJZREU/yFIozpovb0ichzmHeqZixxhUW2QCc1O0VN+bS2E4H7XPWkBBF9YGD3q7dR8JdC8jW5UtVS+FVJ4/etLOVMYXvP9GfWhVeBoUE2NIWtTUneUjLB6UQCzzG+4iEKZK873UKpnH62CSj/4M63tvgmK7B8VtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211631; c=relaxed/simple;
	bh=ihbqWsGCwDzXFCb0D2cdE+6dW31NKUbgW1uM4LkFMmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVO/ixLkN08jWyjAe3xc/l1VsmSR/GndaL03HvdJESRALU3xR8laaC3CmtcoUuvqyzkeP4Z2xTjw99uipgNCHE/krZPdeKwaSlbMjBKAxWhu1WLc/mzFhYnHRE81xa2upgNKI8XtwXvmno+98eHmWZsfTladetFDU66KjXJmUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nSmcwmbp; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nSmcwmbp"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-948614ceac0so18018139f.0
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 18:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764211625; x=1764816425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfEtl3WHcPt8pXCfObmqCBecPErvS+4p/iCXCHXK3RA=;
        b=nSmcwmbpYHjPhaxNaQ3etHUqu7cyDjDK+vAgjqFdbKOV7q5S1eqI5X/VTyOS10ME0k
         XPrfgEG6A73sYJWegJuHKTNod4KTftXyU8I4Th3entYkgLnqe0fz9NPW30hkyLhRm2EC
         wh2GJmbWzsfwjr0Oeybix0hSIzAs1K5vIj41QMwRERu2SXH0Q3WMWX5lt8x5Tl9F6xPS
         QHcFdkRXkouumSEux0Uo+N/3js9kS836er1eJWXI6/7bNZo89OndSS1dKXUprY5VNyM/
         x9TIPr2Zp5W1VQl6fwf3QK/dxB6X7Tr4gQ39G5LrykJZYl7ptSTbpZ/d4i2KYz8Us0UH
         CjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764211625; x=1764816425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfEtl3WHcPt8pXCfObmqCBecPErvS+4p/iCXCHXK3RA=;
        b=RknqMc+9lA1b6YuQuWT5SZoXPR19FGiB+2V+kgY+ClYDbKfxbDWKaUUKDzb0aLkcKa
         hHxEV4DO5ZYHv7A/HxfJ3CEga4As+BkpCxT6y1jZNFgqVoobnpDngskGgdxi1FrjXyXJ
         LmaFTbCh4ZLj3wH9bNMfayy/evNWQcoRJbadAokfWOSOfEFpPSnXlul+qkqE/j/onRa9
         8cptV71Gd0bsnkQPLQEINzAhuaoYj8sWbgyrC+xCYpRerXLAS1ol+YKtnD1GeGFur6zj
         5Mk0B8tXUqIJo/qAxA5uv9Q33DNQS7amTDSpimXnrIS1DlNLbrDi09RsEztyg8fwVltO
         OL+g==
X-Forwarded-Encrypted: i=1; AJvYcCWsLZDw7N0bRojScRGe25SFy0jB1dmfBbatovTVTy0VTwi5YC181XcYKq6/7xGDTFAH0yUeREJgtC1ROw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2Nw5Y2XJxCyrqAX8Zf08jief5+wFzPYiuEF76C2sMrpv97rb
	CXLX9XUYej5SGNVGx/q4Ep19yCfh0NjER62ZdsQZgjyEkDhkVlBDb/h7xX3KAk6kOa0=
X-Gm-Gg: ASbGncsrrRqTiKy40qbHy6uicOoTSQ3rleegGZVqFewaFo4yKea5tdCK7idwuPFauwz
	CtNadMrYJXus+AgF9GC6B0g6t+xLrboCffE7Ez86HkVX4KCziwEJL2ep5LT2nDf3YktLL9H7IM7
	xVuYQzZ/5M45FQEHCnvPYN1MSiRXTan9PDCe86/PbPdT6bVOVkyFFBojC5J6VZE6eKs1dBKefy0
	diB7M0X/h9oDkbk8Dgqdreia4CozM+igkD8KNnu8Ww2XQzKr/gHIUBfFI1jDaNsUYZ7j1Ib0RG5
	l+4GYu1MzYEVXLBsGC+Ab3S8RFcRMIFm0Rb6KV9GRofaD8ppUmYXk65jLFtmxhPxQI/4384koKL
	gDMBpPK7Ighd7KytRt9S7jZqSFyz3kJ8rObDSYzoyoMu9VXFVMu1B9Dqu+1On0atfL6s5QX/NZv
	MX+hfln/33XEJ5BNj4x9A=
X-Google-Smtp-Source: AGHT+IHGyv86TwjQjgAijemD23kIZH/Z6bm++NMEAbLQPsVSJUHQ3EBOcudp4W1PMMs6RBmWlAw8Yg==
X-Received: by 2002:a05:6638:1ee:b0:5b9:9bd2:6193 with SMTP id 8926c6da1cb9f-5b99bd262a3mr5044984173.10.1764211625366;
        Wed, 26 Nov 2025 18:47:05 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc79c0e3sm42672173.53.2025.11.26.18.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 18:47:04 -0800 (PST)
Message-ID: <448a22ed-b28d-4cf3-bb8d-956df0660533@kernel.dk>
Date: Wed, 26 Nov 2025 19:47:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] blk-mq: use array manage hctx map instead of
 xarray
To: Fengnan Chang <fengnanchang@gmail.com>, linux-block@vger.kernel.org,
 ming.lei@redhat.com, hare@suse.de, hch@lst.de, yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
References: <20251127013908.66118-1-fengnanchang@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251127013908.66118-1-fengnanchang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 6:39 PM, Fengnan Chang wrote:
> From: Fengnan Chang <changfengnan@bytedance.com>
> 
> After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
> an xarray instead of array to store hctx, but in poll mode, each time
> in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> introduce some costs. In my test, xa_load may cost 3.8% cpu.
> 
> After revert previous change, eliminates the overhead of xa_load and can
> result in a 3% performance improvement.
> 
> potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
> avoid, same as Yu Kuai did in [1].
> 
> [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

What changed in v2? Neither this cover letter nor the patches have any
mention of that.

-- 
Jens Axboe

