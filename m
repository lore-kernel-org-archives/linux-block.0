Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65452EF66E
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463069; cv=none; b=oLqd4VZE28grey3VvCfIsIWpNQXxv1Bl2pMCPmA5oW6SIpueizDmxSzRc1rlMRKhSC1fFikxWYyet5SzTv0aIP0MI0wcw1GDzV1Ibd0r5JCtA0j1gYKGd5tge406KCvMzVZZNUPjjGyyMF6TAifoQ6dUe/Dq9lgu39Tiu6xvYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463069; c=relaxed/simple;
	bh=6shwcW6vxfbPyUO+4LON7yqfRMppLSv3cCqoWlpmI1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGJAARLX6SJ0j1Iddz7lHw2K10emGQBTge9/kgm585eCnpmHGMUyMPSUqXNHUp+NjIeuSgmQ2Te0zA01Rp6GIHcwTNIRAd+uzoFsZu7ou7E4GOoc629KBqE0jAJokn32GvBezx9QVgH3E1FuLEGCHhFC+Um7820r/0XtLfvL8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=w4RlXiKJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="w4RlXiKJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso9375907a12.3
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1763463064; x=1764067864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGdM1wJoXGQz7bm128xRbuaPqwpiMtIqZbrUwM7E1+I=;
        b=w4RlXiKJCD0yuZX9nkOseE2b155WLu7SHExaqQL6pG3JT4+3fpUrmFSRaQMmh0/qIT
         mxqFfuvIdLoRBq7D5Aj+ZKGfFXHGPX+DqSQznQUXr9eyGX1XB0fm8jhrFGJDOWOayvmZ
         eW+Y2oAOL3sW0xebXqp2miXhu5cqCf8qSHvD/SVjxzXmSshtzcdYd3CW0ifeuDi+t/HZ
         qqx1RAuFRAqRYE2S4Het35T5qLvHSvrnVEr/k0NJQz4MZ2juVpPPSUtm9DXxlhp4ovyr
         HyFTAbLiAIM127ipxSQK2zYR8rfb+Iwrri0dDkMVn7CZyeqzeTDlCPcSxNGZJu7S2493
         CgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463064; x=1764067864;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGdM1wJoXGQz7bm128xRbuaPqwpiMtIqZbrUwM7E1+I=;
        b=raOQWuU98emHMOddvQgr0Xrkt7YASgVyO1dsYPC+uPm8TkkDKA2VZxDUNnMBW2cNon
         p4Bn4WKcfGzhXMd9jd9tHobjjPhxXOZs7eAsm2vcQD6o95JjGqA/4pluGtgtz7uVheg0
         dazJVBKojkLUIA1BWf3PXhTKu+4amj8xtZXlXu5bT8DlOGRE7tbWB4ArFmAlFdzCio7C
         LnczYv2tQ+UtGZov691W3OTBzwMAPBvWT3tFa52eip9ZyaopHQriSMFqI4900fnYmmj8
         4yb8Fjcpckuhhro6CqTXhWuA9RQ5CN+lmIIkpuME2ZU4mfG5cq9sBiebmaxuOn01XDHk
         LY3g==
X-Forwarded-Encrypted: i=1; AJvYcCUemEHkBQjWQzuwqlLDibMhKmsOIOseJC1dznAXWIzBsiXKOcf3Bb66Jjzuj2wFbOHoyoioi3viP9kEVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoMXDCLtk6i7oxXKO63Uyj0O1CMB9H/jDPmhKKq78RajrL+CL
	W7rCedypkO1NKY89rd5i+NGBIYfKwUl/R5VKR0Msw0SqkFB1k5YaxTsdGg0oqleQa4Q=
X-Gm-Gg: ASbGncureC3Kj1jaKDm0WjDfeat2MQ5VtS92a/dLvJ7g8OZraHT9qg19oG8l9XkyFBZ
	r5+EmqIHXj4iw39uQfY/Bx0xuWLJEHk+wgqdeT9C4kl77RZwCeOF0EaFypXCFfjhufS1L50vBDY
	1HDLXodGCbCwW4Ob/2VUh7zjpor5cauJqqOs9Mxxa3or7RzlVL3+an5SPBO9irIbKjTTTzqIpLr
	dMnQcEmIVqfBUojnOHcugZE9xOmS3VBVe1bOOYb0zyiStZVNb6bpELvgJbTpg76WKJ5cZ6uKkEN
	1plLO3I13kl3y7IN6MGKiDuAafGLlUFmUX7yVM0aPbLCsyL5gBdIxIRJqt6r29NmI75NVdFm/y5
	aVG/Fm1UcbjjTkhZq7rSOVA0/kt9+lomUA7D8pkZqnHyeGi9sT4sTafWqNiP6oyJxRBPBE2wyei
	0uRmHlp2IFQPdTOeQe/gFY8pS0HNU25O6DN1CUBkwHkIuoDvWTSZFxuBPYRAda1eMZGTqg95Yjp
	KUfXmMvIe0eEw==
X-Google-Smtp-Source: AGHT+IEWZK62eDgqge0iEYvyjOKSQ1p48XfRz0kdjUFIlAsN6sWTmoc4BYjlcjTS9bPeI5jtRT4qFw==
X-Received: by 2002:a17:907:3d52:b0:b72:d9f1:75e5 with SMTP id a640c23a62f3a-b73678d9a41mr1737837266b.20.1763463063991;
        Tue, 18 Nov 2025 02:51:03 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad456bsm1351037766b.21.2025.11.18.02.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:51:03 -0800 (PST)
Message-ID: <11f8aaaa-b5de-44dc-9263-5bdb506923ac@linbit.com>
Date: Tue, 18 Nov 2025 11:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: turn bitmap I/O comments into regular block
 comments
To: Sukrut Heroorkar <hsukrut3@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: shuah@kernel.org, david.hunter.linux@gmail.com
References: <20251118090753.390818-1-hsukrut3@gmail.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20251118090753.390818-1-hsukrut3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 18.11.25 um 10:07 schrieb Sukrut Heroorkar:
> W=1 build warns because the bitmap I/O comments use '/**', which
> marks them as kernel-doc comments even though these functions do not
> document an external API.
> 
> Convert these comments to regular block comments so kernel-doc no
> longer parses them.
> 
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
> See: https://lore.kernel.org/all/20251117172557.355797-1-hsukrut3@gmail.com/t/
> 
>  drivers/block/drbd/drbd_bitmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

