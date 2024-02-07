Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2812E47
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275840; cv=none; b=PfNtoK2SvFDKSrgHtTLzRD+ZT70JhV9znZS06POB0mlVyWQZZrdOxKu2Ly+clFVgE7F8ciNiw4ZYyKLQmL8DzyBw/0cDws2/xD7sZpEqgHHJQXRLKkrIhg7pWFB2F7I4tldRtR5ROYRsFi0th4VQcRVdN7v5DW4DwWX51bmZlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275840; c=relaxed/simple;
	bh=WJe9IrwiBEVpqejHfVug3sy1LZ/48BArVTcHpWvhxyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSB60pSr+viE5GPSnfMPthpKOWJE6FZgqiPYUZJSjk8USwmsa5R5SUHpJ4/QeMnZcd3Z1rn1bv8h80zlg0c+1DCglPYnjE4c8OnT6R/kLtXPnbn2FnwX4NZ5WS+y6cPXRitGB+Owkdyw7AupDRjDS9TGyctL+6o/0b5WGF79dLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rx98Sy7D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rx98Sy7D"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d987a58baaso498845ad.1
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707275837; x=1707880637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGZrx2GFcYFKGySsPMA6BF/60Bvnn5WUH7P7wf0A/fI=;
        b=rx98Sy7DRsVEFVy/+aeimKiDSzcgT3qSEZvWzLedNFoK/ADWVD4H2iUw6llY1WTY3A
         yO0tfBhUTsbnYOtVn3hqbJvJyyOhMClmV+fxFhNOdvrl9e1nYYoxSbdEy9Pu1Lzx5vhg
         rMQONSOjJrgnnGKPRueqFxuc1yA6aUKAsY8fXj1k7cwICN28Sbjf/V4Ofgje5W4wLs86
         BgtllZS450DdZEvvMaSw0R3EyVPOIvc536Dt8LbHWCuu7umzzu+cZhZi2dUhmA7zBFgp
         sMWHXStvIW3vpnv1g5A5LXDaJ93ftF/jhw16vL2XkxdSoDoL0MPLT8RPjbV8K+JFqnat
         4EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275837; x=1707880637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGZrx2GFcYFKGySsPMA6BF/60Bvnn5WUH7P7wf0A/fI=;
        b=K1om//aRKRgnvLmEDVe0Lm/czw24vFoyIPyAI964XXWqM8GxywYBsEK3yqrR3/Rpdo
         O2hZ6I4yvHfrG9DKkt9mcJbXF9r12TsHY4KtiQ4PSV+6i7+xFXdoMJtvayx9kZEWVU1X
         0l80p7YFUC7Xwe0ys+EaeQtLwEI97Qbf8Z1HQTvtWWi3TAonKH5YDZ07zDHXO2shPRNO
         1uaffGOmnKZfj0Mm1hF5uwrT4vSrHu+Ptw/ZbPbjpbPAiNrcKH/pCiMDJqXaHROlnqa2
         fs7lIHSMPLRJUK+o8AV2hePmCl0bL4YbIvp0o9MZmISYKFa9zWWlHByiNUAlApUNBEh0
         NUaw==
X-Forwarded-Encrypted: i=1; AJvYcCXAlTxjZgIF5t7yI3COd8NGHoMoWWOvSec4WZjwKMWe/iGP2LWp8dcIckewIYFRJ1exfcpbJuAooKPE4clBFI5SCpQe5o8rR99ajEs=
X-Gm-Message-State: AOJu0YwpXsJ8WRBdZRJi4A9Mc4eYdDJ/scEjnPwftmNq1/JZoX3nhF5H
	dpD+mkvLEhAC8nRYFmbymR7+TZ1WQxBoICuuwSLjoQx14fNRmP65o/I4K2jQdhc=
X-Google-Smtp-Source: AGHT+IH6/77r4A9b8Q2lN6ZzK9PsDjygC6B2KjqUxFdCbfJfQtZFdudeU8jNBALRUGJy9JtfhK/P1A==
X-Received: by 2002:a17:902:eb44:b0:1d8:dcd2:661 with SMTP id i4-20020a170902eb4400b001d8dcd20661mr4673737pli.5.1707275837539;
        Tue, 06 Feb 2024 19:17:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0p2QMcsLljMvXolcMb1ZVXqX086fNgw/+9Q427dN5ypJ1WbluENu67Dy2Hz1cGQYuR+hgKoJBfvtrP6Dj7eSf6q6894GXAF1t+rtb+R3fficOJiTqqYg1NLPtI7MeBkax0KZGmEVTn0k/om4vEu77gVImzjhkBu/EVZcBgz8jLvlslTOkr2qiXiiKL8SAO2xeEBekpIC8nuHSjavqpMVi8FkXVZs1pFnaZJNQgfYz37Spj9T8Yl1mF837nx1qoOTz6tiSWdU=
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d8fe502661sm279837plh.19.2024.02.06.19.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 19:17:16 -0800 (PST)
Message-ID: <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk>
Date: Tue, 6 Feb 2024 20:17:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Barry Song <21cnbao@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengtangquan@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
 <20240207031447.GA489524@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240207031447.GA489524@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/24 8:14 PM, Sergey Senozhatsky wrote:
> On (24/02/06 19:40), Jens Axboe wrote:
>> On 2/6/24 6:44 PM, Sergey Senozhatsky wrote:
>>> On (24/02/07 09:25), Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> Firstly, there is no need to keep zcomp_strm's buffers contiguous
>>>> physically.
>>>>
>>>> Secondly, The recent mTHP project has provided the possibility to
>>>> swapout and swapin large folios. Compressing/decompressing large
>>>> blocks can hugely decrease CPU consumption and improve compression
>>>> ratio. This requires us to make zRAM support the compression and
>>>> decompression for large objects.
>>>> With the support of large objects in zRAM of our out-of-tree code,
>>>> we have observed many allocation failures during CPU hotplug as
>>>> large objects need larger buffers. So this change is also more
>>>> future-proof once we begin to bring up multiple sizes in zRAM.
>>>>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>>
>>> Note:
>>> Taking it in NOT because of the out-of-tree code (we don't really
>>> do that), but because this is executed from CPU offline/online
>>> paths, which can happen on devices with fragmented memory (a valid
>>> concern IMHO).
>>>
>>> Minchan, if you have any objections, please chime in.
>>
>> Not Minchan, but I do have an issue with the title of the commit, it
>> doesn't make any sense. Can the maintainer please re-write that to be
>> something that is appropriate and actually describes what the patch
>> does?
> 
> Thanks Jens. I fully agree, I requested a better commit message in
> v1 feedback, we probably still can improve on this.
> 
> 
> Something like this?
> 
> ---
> 
> zram: do not allocate physically contiguous strm buffers
> 
> Currently zram allocates 2 physically contigous pages per-CPU's
> compression stream (we may have up to 3 streams per-CPU). Since
> those buffers are per-CPU we allocate them from CPU hotplug path,
> which may have higher risks of failed allocations on devices with
> fragmented memory.
> 
> Switch to virtually contiguos allocations - crypto comp does not
> seem impose requirements on compression working buffers to be
> physically contiguous.

Yep, this is much better! Thanks.

-- 
Jens Axboe

