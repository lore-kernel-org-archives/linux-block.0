Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8C41D638
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206459; cv=none; b=YdXqbOuNENw5eJcTlkvok4fDhzB7QXQ0tLqN9Ql12Rt+7ehd1VzDCV8+TUWwN/TJ8Qq4F4cgArZjmsCSawC2bmW4BXT9uDOVrwDa9FosruEuFDlsPhQWz0U3DPKONrb2ujPfOlfFyCDpJEECpLDI143N4+zxUKULNj/si60hDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206459; c=relaxed/simple;
	bh=VLvepFLbLnMw4+j5aVxMqNrtA5wOAZxiUEu7BvqkcO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrxWivnl+3bJrPeobRog5pLPSmwJt8yYeKeCw0EWMXBoj2wHe1x+27eITI/WddwVL70dN8Xn1fCqpecasdHnUq9B/6Sidm2mC6ZsbIqPjg0m9XZfYUxRPHz08cTLJ0026aHgDkiAnuTCTup/CZ2afl0OvCxvba+Nl2XCDRRjQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAjkLfCe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAjkLfCe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace91f112so63455515ad.0
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784206457; x=1784811257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlkKCvRMizikKPPQV5+qMzDl1ZZFHbMqGmdaZXVWNSc=;
        b=WAjkLfCeaOrVV/9tbRE1ASOadH3HX1O4PU3ubZhV14xtRWEksUExL/4NDqtgZX2Hwq
         Ur9tPhueAtUkdJ5afPcWFjgIdm1W5qFNbCn0/Nvx0xhvr8eimivvdi+0mfqXfq+WXnro
         V/2LVevZ+216RRVAHzFhXwV7WT5hH2uBFfxVHsfg5uUM0HHCAqIECpK+ESIjH7Ty4O20
         yf1xPAxpglm3yrwbuAetUB17emXAC0BHPXAGHP3GPxV83CDyEkzPfOEvGZ/59QhDAXH7
         m13h+GpiZCA0j7QgDksL5qF6Ql6/D3giD0eCgAO4dl3WPv1Mwd1iWz2ZX/G1DDnxOWNU
         Bu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206457; x=1784811257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlkKCvRMizikKPPQV5+qMzDl1ZZFHbMqGmdaZXVWNSc=;
        b=l76d5ZMSGUKBSz5QiGVcg/pexjxB94RNwd4F4YMrFPRa3VoKP9SjQr3oV7fJPapse0
         P2THvzY/C0lzkWUYU9UNFr9OYdElHJaXmOgmY47D1RfCLY/hBSVGHaxUoEdWQ51rh9gV
         n4ZsNpTPnBX36MDuIQuBNyr5JN+7I04Dvyq6Y8MCpYfXgfAkKsOrq/9mVc08xpBwN1ZR
         Ztk4lkqbVUomqrxCe/aHAiG/nwqW0exikV81Xnt35L/x8h9+OVm2clrBvHYJToU6Z9Be
         Jg9pDk5s5G3mLmUiWv+m5QS1BKmgpBmP5t/eKIRVAn1ZZizkU3OcUdz2URyVLsxQJcx6
         tPYg==
X-Forwarded-Encrypted: i=1; AHgh+RoN4IPiXSfDaIhXTPEtL3LQJwmB9PLOJkp/RRA2W1jwIr1XmSNNWuWyIqqxGtP2/A9WoB//zPOG8/sVOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBmsXJwIc5ETcU4ThyLCesypDKPY6B2CpEJPTgQOTOxAJe0vA
	Q//hNvkiHS+fjG0NEKeuCFTF7Yd7DjYUe9pLcn7K/tjQQMROwYmxaY3Zc9dQ/WsMfzM=
X-Gm-Gg: AfdE7cnltd+/CuifMejx7oFS3S5njAe74p+1t1YaOgkUqT8cFu4nZ9aCCTanHHT7kMV
	Ehj1kbrdteUsDejwewECbwMnCJBCzbzE0gcDqdHN2044e6llKg8PpRcO2JUDupCO1ATIy+DAX18
	ZVhqlbfqqbuSCd2UTuYUVFJrqjSZQGDZ67VCOb4oG4/hDfbgtM7VfnR8P3x4tl+7GztkhGoAnxb
	ppVfMToWZXeucfgjjyG2cHxbLXnRXL3BHXs0az9O7INKCY6NZ/4a1/LAKe9/PvFbvFh6OrW0Jld
	sMnUrygIwCV5fGazkTzbxX4yQLsnM4VHx8+KR7z8+GIFHQCCqkCD6rW2pobgOH6XD3mxpNePdNp
	35ufpuh8Uxw9+mbOadFks6QW1P80nhw1tachO2IMe/q7/va8Pkl1Oo+8VsYqiOStbcTfJ+2bSJc
	+OATDlD04JZ5ppDL51zcteEYbXkJQmIm7unOdJtXBej/Q/GtZ4ypui7t7PSr18UjZVW853kzap0
	Mqo
X-Received: by 2002:a17:902:fdab:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2cf03ca9c33mr65942925ad.16.1784206457145;
        Thu, 16 Jul 2026 05:54:17 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:e174:fd48:2cf7:d01e? ([2400:79e0:1203:64b0:e174:fd48:2cf7:d01e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1012fe86sm19726645ad.26.2026.07.16.05.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 05:54:16 -0700 (PDT)
Message-ID: <ed8b92b3-18d8-43d4-b204-8ae82d0f5e38@gmail.com>
Date: Thu, 16 Jul 2026 20:54:13 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: avoid 32-bit overflow in root io.stat byte
 accounting
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk
Cc: tj@kernel.org, josef@toxicpanda.com, boris@bur.io,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260714063118.1153083-1-cui.tao@linux.dev>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260714063118.1153083-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/7/26 2:31 pm, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> blkcg_fill_root_iostats() converts per-CPU sector counts to bytes with
> 
>     tmp.bytes[BLKG_IOSTAT_READ] += cpu_dkstats->sectors[STAT_READ] << 9;
> 
> but disk_stats.sectors is `unsigned long`, and the shift is carried out in
> that type before the result is promoted to the u64 accumulator.  On 32-bit
> kernels (unsigned long is 32 bits) this wraps, so once a per-CPU counter
> reaches 2**23 sectors (~4 GiB) the computed byte count is wrong, corrupting
> the root cgroup's io.stat.
> 
> Every other sector->byte conversion in the tree casts to a wide type first
> ((loff_t)sectors << SECTOR_SHIFT in bdev.c, (u64)max_sectors << SECTOR_SHIFT
> in blk-settings.c); do the same here.
> 
> Fixes: ef45fe470e1e5 ("blk-cgroup: show global disk stats in root cgroup io.stat")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-cgroup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index d2a1f5903f24..a778aa9d2bb9 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1112,11 +1112,11 @@ static void blkcg_fill_root_iostats(void)
>  				cpu_dkstats->ios[STAT_DISCARD];
>  			// convert sectors to bytes
>  			tmp.bytes[BLKG_IOSTAT_READ] +=
> -				cpu_dkstats->sectors[STAT_READ] << 9;
> +				(u64)cpu_dkstats->sectors[STAT_READ] << SECTOR_SHIFT;
>  			tmp.bytes[BLKG_IOSTAT_WRITE] +=
> -				cpu_dkstats->sectors[STAT_WRITE] << 9;
> +				(u64)cpu_dkstats->sectors[STAT_WRITE] << SECTOR_SHIFT;
>  			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
> -				cpu_dkstats->sectors[STAT_DISCARD] << 9;
> +				(u64)cpu_dkstats->sectors[STAT_DISCARD] << SECTOR_SHIFT;
>  		}
>  
>  		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);

Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

-- 
Best Regards,
Yi

