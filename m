Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169E1E1024
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679687; cv=none; b=uV6qk5T++KV5887B9n5Tq3XmupCWrzVspMcKHzTgcEOIRK8h7Ox3dKxEsf3gHHiEkKqCiycCl1V3s4+19+ok40yIkZFmT4JMi891B6RGUlsq3Og2q2jS3NDyouD4Qr01I9Gi8ettISmkY7NjYimAlJkQ2kNjw/1Z3MxJ4g1C9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679687; c=relaxed/simple;
	bh=DVGBVk+mO7WPLb+Zs+aUZlOHthLb5rGfTXLOLzkiN6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkbrokLO2HBYOPBzXrOKllO6Rlrs1yhRLfY1lKWapLkGGknaj9VaFUgV51EGoqMbYNWQx8JgFeP/y1ngbd1GRQ1EeHNDM3nQ1Jdx4qP0q1xT2X+wb/JSG39dTF2dFS3y6IevMocr1XuA/qrSynFp4F8rxRpx8/ayrKjGmSj8+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Y+ZGEDP2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Y+ZGEDP2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso507805f8f.3
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1783679684; x=1784284484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0hNKws68GKcsqG1qn9goDkKgmOz4q7bVaIJzV/ptteo=;
        b=Y+ZGEDP2flq2OEPBlctnl7vFP3FsaRl0VVTGAtDMwehbuh/57Vv6uCdmyHQiOP7/rr
         C6tGsYhqrKwHu2auQDagKPGtTP0jhiYj+ZHUfqcC/BAwyFrtNMo7Qw/zoiOBJbbAFq17
         wmfaOkdrgoGoHhVktif7u34+8BoF9fNJCwekqTKh+qfewfh5yFYze4GoSkm5K0Gs86Js
         StgBbNRlP8JyRwgJnGwOGQXvyMC40dLqfpuWHDr3hcyH13LEuxQwIHTtb3ImR3ox15C4
         J3N79yNXCIgqWva1y60OJ5M+sgAOL9UmErBms/GwMTxBgEdV55MYa8NHHDwXwuxUQezy
         zQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679684; x=1784284484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0hNKws68GKcsqG1qn9goDkKgmOz4q7bVaIJzV/ptteo=;
        b=mqfFYHRXw7+oIaHpxbn0vISFt8LpzSH62M3sMBSie4v3QFg+OSIRnRo9fc+acGB8/O
         MULcYpDjWkC2bD8c1v0JRdjoouQXQDqfx7Rb1JX/80/ns/dArU9aSl4adEXrvC812wDU
         JTLh4vJt27M50zZdq/uVkBIMlBcGCa/+lykKTv66LL2p+iNI3hzCJi1mL5E3ajCf2q+r
         4su1yMoLm38kNNfwWKvCch1aIbLJR27NNqJNsUTMBqvPrUGZOOx7H9uAm7+2zp0rm2rH
         vQeYNwXO/bc2ZFirduEsskrVA3+DT2CRiFqUN+dsUj6RAzmrp/T+7HxJ+RIq9+fT1Lh8
         5WWw==
X-Forwarded-Encrypted: i=1; AHgh+RovuHeV+voklNVlK6WWywQ3vsvYmHYpDQR/VPwUyKoUi9BXkoArNYz0s6Dr5PvGG4o2qnb9LPgB1f5R2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqzk6i/RHgZmXUvuuYkFyD/pnZcUMaiGWjh3oyRY7iaZf8/i+1
	GxUhckX2/nthKf74pTQBHFacE2DFOxUjD3DIUpO0MRZsfx+7+EkDSHw2OpoLsQbZtvM=
X-Gm-Gg: AfdE7ckOKpWc2vD0p+Yh/GZkxBfqZ8KlBLIEazldvVtqxz/dZmYsoceOCvTgZfuC1I4
	Qn/mfoJFe/jEv+Fjp0y4R4qOjj2oyGKMV5mQ9a/P/Xh3huK1cBJpHQ1nonDROGLmmvZF4XYaHBx
	WdbnqI5qECvjI2GhEvRNedcF+UIOiympxe4YTBPCRUHpP1UMckYHT6zrNHaU/nem6JKitYBPCG+
	jwlLH3kfEe4H+HthYlnRiHo1tJchJd6CDcaITXrON4QSOu9iEaZIQA2JRTdBsZsoirlszjXcIJH
	KwQMIQOpUc9HVIMDvbMXLcKr4vAGXl2uDK8gF81j3NBr9cBWjQ/+yt31FWUMN6Rn+9BYzqWMhhS
	pnh1oRbhMmFogil7IUP7KGcRoXK1fNpoYzMgOU0VFUFgLCkDd//hbgIB3+Q69+DTI0zMQLcCkLI
	CI4Lwke7lQ+qUp6igQAlledOTT06z0X2PqzMouyLcLn9Q1VGTIxGyANYrN
X-Received: by 2002:a05:6000:26c2:b0:47d:f01d:104b with SMTP id ffacd0b85a97d-47df077657cmr11701617f8f.46.1783679683738;
        Fri, 10 Jul 2026 03:34:43 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm61474279f8f.21.2026.07.10.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:34:43 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:34:42 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	axboe@kernel.dk
Subject: Re: [PATCH] drbd: reject oversized DataReply before signed conversion
Message-ID: <alDJWJYBNGpugftk@localhost.localdomain>
Mail-Followup-To: Tianchu Chen <tianchu.chen@linux.dev>, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk
References: <d4924afb559896a4a22258f14e4a97c8d12d8527@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d4924afb559896a4a22258f14e4a97c8d12d8527@linux.dev>

On Tue, Jun 30, 2026 at 10:59:31AM +0000, Tianchu Chen wrote:
>From: Tianchu Chen <flynnnchen@tencent.com>
>
>Discovered by Atuin - Automated Vulnerability Discovery Engine.
>
>Reject DataReply payload lengths that cannot fit in recv_dless_read()'s
>signed size argument so a bogus remote peer cannot wrap the length negative
>and turn it into a huge heap OOB-write.
>
>Fixes: b411b3637fa7 ("The DRBD driver")
>Cc: stable@vger.kernel.org
>Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>

This is similar to [0], but the mentioned patch is a more complete fix. 
There is also a case in recv_dless_read where data_size can underflow 
when a data-integrity-alg is configured.

The other patch catches this case as well by placing the guard later, so 
I would prefer to apply that one instead of this.

Thanks,
Christoph

[0] https://lore.kernel.org/all/20260710022837.3738461-1-michael.bommarito@gmail.com/
