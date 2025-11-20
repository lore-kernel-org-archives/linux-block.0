Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209628CF49
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649900; cv=none; b=rGW0xspQdRTpfpy3PfnseovWb/f0/c0aoXBXA3Aeu8dicB7nMVjQyweF0nhgFE1qRzVGB+zqgm7hW/OgfMj+dNSWzXAXJmF6d+UbL+aw2svqxrnR4b8U2aZ4F3ogP8SProdX2SrVBCcfs72JisrokEcPHG3jWQ5LZat4SzxqyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649900; c=relaxed/simple;
	bh=ONNkBGi+pAcXAGfOCa4th/uzV5GK3jLbFcpMbgswvGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gosxo/xXg5rGDJ27iEaJmiG2mTkkJB9p0sehFDwnXD6XcTR0vmH69KPyLheQhhYGzAh8xpAbYySrVTYOKew537qClegQI//bz4Fi8gaFDfB3Sk9mpiKVojWQm93icuYLvpQMDcnNq+qGv1RHX/HvSj0UDFqNZSUpLhAAMqeuN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nuiVj335; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nuiVj335"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-433100c59dcso3898755ab.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763649896; x=1764254696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIxJYE0wvk3wLqfYeDU58+f9Hu//Bm8wil67l0346m4=;
        b=nuiVj335IoySHCd5luaPE97MZ0Dk4VSukc1ZbgfDl39ep4bvbv8EfLH5YOJy0hY5NH
         /JPwKejoyOxaLVlawIJpej0B7dCREpkK4rVaG7Mw7zwBT01grcKpkrlqgku3FVdrp3iW
         L0w3choL0SRI0FirwVpbvHIaHj/04iCmXxZj39Nt55X/K2kOPDjNwIPk80byDFbBEM3T
         JG3XBK695M3riS7Sa1B8SqRa8hbTWiCvIS8HbwVfUhXh68bUjQRpVgmvO3CH4b8+9pD2
         ftGBkUQITW1bn/iFbuTQzV4bYTOTTTzmZAmr+U2X160XHKMjxK5kaKyYNcB7TrxRFVoW
         xiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649896; x=1764254696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIxJYE0wvk3wLqfYeDU58+f9Hu//Bm8wil67l0346m4=;
        b=ottpEIzWxsv9llUunHVbczjZ7IXrJ1vVYLtiD0LC7WsRsKiAbTdzStUEufWXSlFb1Q
         ssv0wZZEIKK9oU1XvFaSk+vbmgPedKBdC3vNmT6MAYKei2tLCw+/cy1jWl6a2EbIqgiH
         n6BGCv1lWLNPPjh8qOgwVSX81RwEBBHRK2XnM60xLKJLs7rmgL6h6KkeJwsUCKcEG8Oi
         4mrNevRL5uSzi2e962Gz4qoOLC9Z3ZBmrZ+W4wKa++dlDR97IRITLw71HeWpQ0OkdXOR
         M79oh3tbzhFMBnSldcbeGymxcKx63HsUFX6wrbMG298gmpd56cnUk2vzek1sCt7oW6be
         5ZaA==
X-Forwarded-Encrypted: i=1; AJvYcCXDSELXWfFeQElvWPcsThKB1YzKIr+WmDWkQCIvEDGei3G/se5k3msQdb8OjuK4vQnHhVLjovCLALJs4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmfi4/rz0Z7huHhqz8s16UHKwLR8E5UsLdDLkk1oITrj2Kp3C
	aEoLA1lnyMUjwXPSakRo9MtA7aKeCMTmGgkcisksMVsSY6O1wtARh1CIbGk9BjIKNa7Ls/3Z6fE
	3mYmu
X-Gm-Gg: ASbGncv5qFt9seFNqTP5H2PnH4aRS5+TNjR3VagcgqFQuk4DWyhxDli0wye51a43mXA
	PoSto9Xnv+6OOfAUsVHURiShVDobxp/ew9F1noh9c30vKJXJSojivRqBeGbBQK1Qh/rhZolRKG1
	3Zp8+dtN/X8U5sGrxv+6hwhYBCgtuiTE444PSnicdgEiLz64sRPT5ZtFOoB2RjWEqAcvTEIm/8C
	GBhTRhfxQBxsn6ZjmAgdXbFe8CT2lDFoTIfL5UsO04rGYgFW9Fw9UnY96QmsiVlhm5goOARQt0U
	gcTQ3HedkkxFY6vc2ZfNxjfaiLjGUcgACBMMcdO3i0//GWTxy2M4flofSZrVAgo4oClnh7jeiLU
	1YvVKqRpxqHRDFNvqftr5nLvGC4vXDPCkSEi/cZvS5Hsy85a9bcGWcK2qlGOZlWzx4jb874GGyO
	/VXdP/Jg==
X-Google-Smtp-Source: AGHT+IGH129qdY0Bs8r1fTwuv2Zd+f3v8A11zGOrfEH1/mLJCq3AZQFHWR1rZfoTVBVyrWsHXJBc/w==
X-Received: by 2002:a05:6e02:3a03:b0:433:7e2f:839d with SMTP id e9e14a558f8ab-435a9074d95mr27932015ab.21.1763649896290;
        Thu, 20 Nov 2025 06:44:56 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a905e7fasm11606795ab.14.2025.11.20.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:44:55 -0800 (PST)
Message-ID: <32c1c5a1-840c-4faa-91e1-cc9165a7f241@kernel.dk>
Date: Thu, 20 Nov 2025 07:44:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/44] block: use min() instead of min_t()
To: david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-efi@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Josef Bacik <josef@toxicpanda.com>,
 Tejun Heo <tj@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-13-david.laight.linux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251119224140.8616-13-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 3:41 PM, david.laight.linux@gmail.com wrote:
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index d74b13ec8e54..4e0c23e68fac 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -472,7 +472,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  		seg_size = lim->max_segment_size;
>  	else
>  		seg_size = lim->seg_boundary_mask + 1;
> -	lim->min_segment_size = min_t(unsigned int, seg_size, PAGE_SIZE);
> +	lim->min_segment_size = min(seg_size, PAGE_SIZE);
>  
>  	/*
>  	 * We require drivers to at least do logical block aligned I/O, but

This doesn't exist in the 6.19 branch, dropped.

-- 
Jens Axboe
