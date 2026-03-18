Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C02264D6
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868600; cv=none; b=PRIg/eG5VqTkp87k+Vrx/KoiM10J4L/aBRir9+VXEXeZvbz9WU3h3yS/JICyQ/RViPH+2OY7d5psCJggK6ebmR/3zkav9Vpnq5uUYsIa0IPQE1DI2anzO1wfP1YJbZt9tG4bu9z99WqP7qYN5t4EOr4gmyb/VFgWglhwMwoD2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868600; c=relaxed/simple;
	bh=P//KxE6W/5Y+HAxi/f5cOXKna4n5LLIU7027UToyg34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miT2sBuhQWZ45/9ZL4zwYhq+NTEnvVcMncFjs34pguGuxQjSxUF4PigXqoDWB3+q2jYmtLsMOKGTW6LuRzs0Y4bGCrT4fY0ccjrHcNq/hbmRRxm2cIKYfE1WV7CYLIf9WhfECI2rJZYpk+OLNh2yOQquiPBUrpXwxh428Ee/wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Uh+4QSff; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Uh+4QSff"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso2835245e9.0
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773868597; x=1774473397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JSbsrYhFg+Au4jgvX758AnPNxCSSto/QgL2aLSvMGI=;
        b=Uh+4QSffM1uGTLyOEOiMET9Q9ElpLzCKb4XanROgT477VE+9Z7Imhlvsbho+yNIPn/
         edWoCR/vrz4sOfms3aCJk2GXaXp2BB7vQ0c3By8j7A+p+dBzfw3wxMpSL9kuBqByFlOa
         jfVZeQQS+NyWj6eAT5LYWSwgsc2nPYQ3Q9oO5wjeUmCW/56DH2QmP/av+CgqUY9sFedv
         GG74szR+s1k8eICg6667X6jFJTG42+2ACKcGpARFX7Bdo+aad+qUFXxfNubA+21WP39I
         KVIzj7YOZ8gJ07/eygvoApUPGkQ9vOuodL9AWwguT+7Rsuhja8VWzSOIFkm0jbIpckep
         7KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868597; x=1774473397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JSbsrYhFg+Au4jgvX758AnPNxCSSto/QgL2aLSvMGI=;
        b=TSlYGVTZgpxU+Y2xos3vKlkDIYJAAwPgD5CWvM1RnGDxyFWuQAnI+NJspvUjPkHIhm
         avEbDAfcTs2IbFtgRAslTinfYBEPfNo1hVK7ezwt0YT0Zyo+yZ2B8pqvDAVuZpyWg3zj
         XOGXlTK2Kik1OGGrHgm1orPE8VKfHnZus5eFHPCjDiPgpyeT0sBN26T2Cot3ee/l5rer
         3Q+pBwrukgqUVKAv1QbvtIb5SNrwfr0FFdsYjKff1mCtzfpor4Q6T+KGMFDMXqDPw/gN
         Laj6DO+g9Ii6agbOA7C9aVnbnkHus0nv9/v0Dkhopo3O7C6G9ALYOm08pxLzd8p7mTKJ
         y3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZUY/f+v1ibGg6tTjvGQkbCrbZDz+2Lb/KezhBt/awgf1nZNaPikFet1kSO/S1TrQZpNmt3zov+7PdaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcG8YR1SnmIQH1NSdDWO5uzxQX34nhGQfIMtJGO3P1GyDthW/o
	E7yeTKDLTmcMQKPmj7atwvzaAn9+L20fna6gkx6OOKFpAFqi4IMJF+8pIHvZCzdepTs=
X-Gm-Gg: ATEYQzwDGI7B6tJ63ArEjtAwk0m+CCjHCR3f/CqrPw+suVoc2nzqdVJJWbKkYVu0PHl
	gMpx0a+D88LtJz9juG9DlnCP7ffTgAbwnrrSmayjz3sWWGl+wUkHBiTGxHP+a+sfGKUIk1pGRPU
	81d/mHTxU6fv0GvHSQaXlM5Ou/2x4lOZABRj8guZoYFs1uxFaQGqYzl3i5BWgL66d9b02uXHsq4
	WnNvHfCiiDXhqLRC3Fm5pk4hhpPrjKikd2uOHnTsCOPAC9fUvNWuziUsotb2gKcx9HGBZBuT8N/
	pvzJqvHaVoG0B/Yw+QswF/sJmUVX3Yt9WGf4B2YcevXxf/cPWi1ZQVYwIQJgWyDCnd443br9xDj
	lhRC7QKp/KTd8kPRV8Y3hcLit/KjeCL2PlV7Av0oQHoUjeSoirk1F+beQFZv5HrUYOhFMY/dSIt
	wrPNRhvWTmd7NoB1ekodd5vMNqpWSPxog+1NF6iRp1T1+j1wXBYi1RQvOzbDjlqdzzXFoEXBhcD
	FSPAaVd6OQqwv4=
X-Received: by 2002:a05:6000:608:b0:439:c69f:503a with SMTP id ffacd0b85a97d-43b527c4df0mr8143039f8f.27.1773868596733;
        Wed, 18 Mar 2026 14:16:36 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892244sm11628020f8f.22.2026.03.18.14.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 14:16:36 -0700 (PDT)
Message-ID: <6b696861-ac39-4a87-a2fa-ad47a75031c6@linbit.com>
Date: Wed, 18 Mar 2026 22:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drbd: select CONFIG_NET_HANDSHAKE
To: Arnd Bergmann <arnd@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@google.com>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260318104858.1868731-1-arnd@kernel.org>
 <20260318104858.1868731-2-arnd@kernel.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260318104858.1868731-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The TLS handshake code is optional and has to be enabled for DRBD:
> 
> ERROR: modpost: "tls_handshake_cancel" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_server_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_client_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_get_record_type" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_alert_recv" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> 
> Select the option whenever DRBD is eanbled and rework the dependency in
> the symbol so it can be selected more easily.
> 
> Fixes: fa8ef6960ebd ("drbd: add TCP transport implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/Kconfig | 1 +
>  net/Kconfig                | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
> index 29ec6ed84251..de9e232d6479 100644
> --- a/drivers/block/drbd/Kconfig
> +++ b/drivers/block/drbd/Kconfig
> @@ -11,6 +11,7 @@ config BLK_DEV_DRBD
>  	depends on PROC_FS && INET
>  	select LRU_CACHE
>  	select CRC32
> +	select NET_HANDSHAKE
>  	help
>  
>  	  NOTE: In order to authenticate connections you have to select
> diff --git a/net/Kconfig b/net/Kconfig
> index 62266eaf0e95..769880113740 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -92,9 +92,7 @@ source "drivers/dibs/Kconfig"
>  source "net/xdp/Kconfig"
>  
>  config NET_HANDSHAKE
> -	bool
> -	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP
> -	default y
> +	def_bool SUNRPC || NVME_TARGET_TCP || NVME_TCP
>  
>  config NET_HANDSHAKE_KUNIT_TEST
>  	tristate "KUnit tests for the handshake upcall mechanism" if !KUNIT_ALL_TESTS

Thanks for the fix, I applied it to our drbd-next tree (which should end
up in linux-next).

I would prefer to squash these kinds of fixups to keep the history in
our patch series clean.
Arnd, does that work for you? How do you prefer we handle attribution?

Unfortunately I couldn't really find a clear precedence pattern for
this, how is this usually handled?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

