Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAB2DC79B
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400327; cv=none; b=aeCwoteHKQRflWyvbhDf88FfLYTRt1xYocJqw0/mmpNvQkOUt+kx1gIBtM64rXst7/FnJcWyVlYQriq+vZYP7cv6bn28KEBwDTVr1pf+LVooqBUo+ZrAgmvt3r1UFbI5BbIksgPSClLumefuZrDEkFU1nkWoMDMz59/9132BZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400327; c=relaxed/simple;
	bh=7+gRkfm59qK+7ElFGGaNpKfS9GoaGOi5elApG51p2G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ7z/+9ASzyksEgsL6JkiqHcFS/qxxjn4/EM9Lr9+qkHBRUZ4YuSrvKi+9v7ip3ZVePFMMWpmFWTs7W0/owUsMFE6cNi1plpCaJ5DQEbb5q57mHR4RiSVlJ8Y6P6bWEIXNSdcC6BbGfeXl2GD02pFpecK3FJKmCJ8CszQWU+XCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RF95N2dQ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RF95N2dQ"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd9061b1aso6031469a34.2
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779400323; x=1780005123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H56J4U5QYxBm+hNtW+E8MvJdLhUAnsTvJUfnbIdlVNQ=;
        b=RF95N2dQSR586TDAmMqT2sVW8NT1x0Sea9XurEDhAjZkVaunfMuBRACG8oaJBSLh3m
         TibZjFDjdzUORjXaFyLx3aaFZhd9TOrCntAhCl2dziNy2t0wJRDnmYOjdrcELk70EGzq
         HhCaGGFH4fJm9GgiRfdnsgNrOYqsa/a+OA2BuUDgf8d/fgdE29BA7MS72sNurlcwmMGv
         jk606a+YlZuIOeurCCEktbrUL1Rls9dVKSRDfoF3XwUa770E2R9mbaW5p4GAvawyLl3b
         jmW8ZdoGrw+lIJ9ueXJFiEniBABnDVaRjfaFov5oXaY5NQtWOtTEd08J5h8CNyNhKFCx
         +IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779400323; x=1780005123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H56J4U5QYxBm+hNtW+E8MvJdLhUAnsTvJUfnbIdlVNQ=;
        b=nvjZ5CmAnPEBtRVo2Faun1pJwytqKowRA4IyVctfz84MyjdZFCPC68VuOHOaJFvFJF
         +L4hzeTxL2QF6Le12flKpyOEvw6o4qD+NxpWvD0QJrWkguOP5oIS29l/dpN+Kf8FZefN
         5cOWJqBuekGoJ8E6doG0s8oesOUnJcSLvLgwk06l5PHkVWUAsOF0OidRY3pjkZ+MJV2L
         aIL2JdHCqJvazwktKkf12JsioVaddo3U+8jJD+oqtOQa8oFrq76x4Q3t7g46vHcRmUD8
         zAaisIPLKLMrmbQbl0B7USp22ESk/GPF6eLiY3lHY71Oamsjlko0bByh7/Yd07KiJitE
         Yl+Q==
X-Forwarded-Encrypted: i=1; AFNElJ94Uy3kM4MPfDgUSeEMMA2T7VxOVZi6Wl8TpvhX9X4HcAx0T7L/EyFudrPssUXw8UA+zoXYMKxk8JLUCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0HWjVGQYyllhUr4IUpUEWEFEeV/YFQlFkFQ7BznW/VPD4IJF
	U4FR2SGXEOFG0xRifNNEYptpczbrPyItPgU1BXM/nBXMfDcKWsMeHhe8PMVhFLQvAEw=
X-Gm-Gg: Acq92OGHs9vCvM17cGguK1GYlqh6qkfHFxHuzDtwizN6nUMDtlKfUO1aYUHz3SKE0JJ
	/tYzJFUdbCoJn5+gAVKSvxVh/U4h8zgJaE0SkTZ05eME9nDkHSULQ1YWm2A2zSShY290uFCWehh
	2m4kowxTqEZN9Rp4kg+eC2/Vaqv6FsnNmHHmzhoFHl0YZh8CzebWIp69VwwEOrEEPdLWoeebP04
	lKOaMV4kDwNNZMKsIDC8rluezU1AJlfZuCKVoARjEW4bNsQegGL6XE7lWo6UYFd20l/JEhwoqCL
	bViIhk13H8NDODQv/RDCd03U2bPIY9hSf83xS9l7AdN23oH34ThyJtR4O341s6MFEJvZYfvOhnL
	j64VenTFSCy6dm1k2VT8yGSyvIewefo6gT/md3vIcgYot2atuJdLs68h7EvbdRBzeOyIGP2LU6F
	15U7UUvn/R+ZEknRUKdNaAueSph/adOLnUFCAFQF7scDJ0zyapBG9/3ttejlIwo8LiguXMSqw/y
	gNb7YIFZw==
X-Received: by 2002:a05:6830:6182:b0:7dc:cd0b:58ac with SMTP id 46e09a7af769-7e5feda98ccmr716525a34.9.1779400323596;
        Thu, 21 May 2026 14:52:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6008af257sm262462a34.18.2026.05.21.14.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 14:52:02 -0700 (PDT)
Message-ID: <1cb74987-34e2-422f-93cf-9174fe913538@kernel.dk>
Date: Thu, 21 May 2026 15:52:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observing higher CPU utilization during random IO fio testing
To: Wen Xiong <wenxiong@linux.ibm.com>, linux-block@vger.kernel.org
Cc: tom.leiming@gmail.com, jmoyer@redhat.com, Gjoyce <gjoyce@linux.ibm.com>,
 wenxiong@us.ibm.com, Yu Kuai <yukuai@fnnas.com>
References: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/26 1:44 PM, Wen Xiong wrote:
> Hi All,
> 
> Our performance team observed the higher CPU utilization in RHEL10 compared to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc4) as well when running FIO random IO tests.
> 
> System configuration:
> 47 dedicate cores
> 120 GB memory
> PCIe4 2-Port 64Gb FC Adapter
> FlashSystem: FS9500, 12 LUNs/FC port, 100G each LUN.
> 
> Random IO tests are more CPU intensive than sequential IO tests due to several factors: more context switching, Interrupt Handling,  cache Inefficiency etc. We found out the following patch which caused the higher CPU utilization in rhel10 and newer linux kernel:
> 
> commit 060406c61c7cb4bbd82a02d179decca9c9bb3443 (HEAD)
> Author: Yu Kuai <yukuai3@huawei.com>
> Date:   Thu May 9 20:38:25 2024 +0800
> 
> block: add plug while submitting IO
> 
> So that if caller didn't use plug, for example, __blkdev_direct_IO_simple()
> and __blkdev_direct_IO_async(), block layer can still benefit from caching
> nsec time in the plug.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Link: https://lore.kernel.org/r/20240509123825.3225207-1-yukuai1@huaweicloud.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> We reverted above patch in rhel10 kernel and upstream 7.1-rc4, saw lower CPU utilization when doing the same FIO test.
> 
> The patch adds plugging in __submit_bio() in block layer, maybe cause performance degradation:
> - Random IO tests have less merging, flush overhead.
> - More IO scheduler interaction, forces requests through scheduler instead of direct dispatch(direct dispatch to hardware queue)
> - Poor cache locality during plug operation
> 
> Below are some performance data that our performance team collected:
> 
> RHEL9.8 comparison RHEL10.0
> Iotype     qd        nj         rmix      mpstat busy delta    lparstat delta
> Randrw     1         20         100       135%                 109%
> Randrw     1         40         100       72%                  81%
> Randrw     1         20         70        278%                 174%
> Randrw     1         40         70        272%                 191%
> Randrw     1         20         0         93%                  30%
> Randrw     1         40         0         104%                 36%
> 
> RHEL 9.8 comparison RHEL10 with reverting above plugging patch in block layer.h
> Iotype     qd        nj         rmix       mpstat busy delta    lparstat deltab
> Randrw     1         20         100        -12%                 20%
> Randrw     1         40         100        -42%                 -4%
> Randrw     1         20         70         70%                  71%
> Randrw     1         40         70         %51                  60%
> Randrw     1         20         0          -14%                 -43%
> Randrw     1         40         0          -33%                 -51%
> 
> Can a block layer expert help us resolve this high CPU utilization performance issue?
> Let us know if you need more performance data or other perf data.

Let's CC Yu Kuai who wrote that commit, that might help.

-- 
Jens Axboe

