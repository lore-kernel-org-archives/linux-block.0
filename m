Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87416F9EA
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273623; cv=none; b=Kea8vO6t93HfSHFMYUtd86B9g7X/yb/XVEYNf881AZ3NzThaOkRfEkI9/CfeFWq1F9nAEFV9YaVZ8LT0NRYXKTCcN/b5MVen6ooITHvnXnK18gLPNzABqAXvZR8IGpfYavhcUcmdNxpnXiStdY00O5hAjnRUv9fqA9h2mgA+FMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273623; c=relaxed/simple;
	bh=kUqfwxK1QpC8LhAgyWrU8gwvBZ7OMcJL9BwKxIE0YVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYpKnnQW+80NG/Hl2oNnAKxpxjcVUihnXYPX1T3UiKP4Zlbi8r4HfjguU4Is1dfKs+WKSpF+Lo7erfBqxTjNLjUmCQ6D7PHDLQIurMgrm6hQ69IwTPP+mFwz+u8UBl+b8nb9AxXCmq0aQ439eIpJezYX1zhxtLZqJC5rOLhdfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fmUzH23H; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fmUzH23H"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5a0dc313058so32462a12.0
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707273620; x=1707878420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGLRIz4PleG1MMDw3pED7/+S5jJzek6N0KE9rRwcTu8=;
        b=fmUzH23HLCxHeGeBRKeXMGqrrtabCs1gZAvLlwXbnLMfI4q5ENSiilVbuQv+Yf50GL
         gjiMU4t7gyPiFaC46aL0GisisR9ilugrKdir2KmScm2bN/60PkfaDvzXHQQw9Ipru48D
         pSginxuxmI9tOsSkaSecOpp5zPDULkcpGGW3aevDwuj3BjKOcRtsBJkPs660qlYDQSQj
         KswZfIoRj9YZTH5mL862AygA045SCNm7WT9yJ/BeXPU7JxnFY1VU7VDpUJo3Rv/zqUGf
         v5Yelil4aV0U4kX4vnziWrEvMAgY5NaqVjGY9AbS1mrhQEreLmjkFkUlKLhp1ZZNjYd/
         wecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707273620; x=1707878420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGLRIz4PleG1MMDw3pED7/+S5jJzek6N0KE9rRwcTu8=;
        b=BK65zlSKsN+L/Pi0M1q/pMFHDnlcD6QLYbvW40mMtNIZBnSGNSDLsEtBAlWKvPiGa0
         n6Wj3EOeZQaclCTlEBIw1IpPdEUFZGiV9t+mj3OuTthV0ILoZ9mPF0vc5WUT37o3RJ9q
         9glpBSK5OD+yTM2ZRZBgGs2qwybAeVvkPecE9gRHZBUSbfZiFyUwIMPj665JoNcGQ9kS
         y+DVsTf6prqp5OfrCnQaNedEjsq/8vG2SFVhQGpElHi9fdK3oURzYxNJ/I7hrncqbeFD
         148sZGIIFAu6/kIWY/SKo0t5IYcvEgnrSHh6Pzo1hF2jzffRt+1B1eDKv8QvYQaeU3ic
         hDTQ==
X-Gm-Message-State: AOJu0YyIkXx78Lwtey8VilOYPufcQl4/QTH7dqCLiRk4DFFf7QITmGIz
	kPWb5N0VcabYOW8EvW/vB4nYH7/03SWMTROFTYWVpxhWrfafSdgtI+WoOCqdNek=
X-Google-Smtp-Source: AGHT+IEYBYr5lmkHFfWNBNEhDHgtY6ATzOfg+Mwl4gq3W1cSveAMJ1lrT/HMPgXFNMaadEotVc0c5g==
X-Received: by 2002:a05:6a00:1d11:b0:6e0:3a9b:12dd with SMTP id a17-20020a056a001d1100b006e03a9b12ddmr4886395pfx.0.1707273619823;
        Tue, 06 Feb 2024 18:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcAcqop88oCJLWAdYUZ6jsjsAqmgZoMOWFM/cgoraBdQrB5AOgMwwg34IVaMDbbfftejEQguH+LXcNUTt9remm9kbO2vqDU0+wnEwam0QZ2kMfjh8lPGvLgCYHggrRoDJ4MA+imp6BrxxdRzZr3PjJ7mzfYss6ku8WN9Tm3XSYJUR09cjE8OQihDxxvonPBMF9zod3KvWOJUp+Q6eQdjPEzUdgFYQdVWTQKnOJyE/xIk4RL7cWu3kzWsHzMcQ=
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id t22-20020a62d156000000b006dd6c439996sm230080pfl.161.2024.02.06.18.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 18:40:19 -0800 (PST)
Message-ID: <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
Date: Tue, 6 Feb 2024 19:40:17 -0700
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
 Barry Song <21cnbao@gmail.com>, Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240207014442.GI69174@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/24 6:44 PM, Sergey Senozhatsky wrote:
> On (24/02/07 09:25), Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> Firstly, there is no need to keep zcomp_strm's buffers contiguous
>> physically.
>>
>> Secondly, The recent mTHP project has provided the possibility to
>> swapout and swapin large folios. Compressing/decompressing large
>> blocks can hugely decrease CPU consumption and improve compression
>> ratio. This requires us to make zRAM support the compression and
>> decompression for large objects.
>> With the support of large objects in zRAM of our out-of-tree code,
>> we have observed many allocation failures during CPU hotplug as
>> large objects need larger buffers. So this change is also more
>> future-proof once we begin to bring up multiple sizes in zRAM.
>>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Note:
> Taking it in NOT because of the out-of-tree code (we don't really
> do that), but because this is executed from CPU offline/online
> paths, which can happen on devices with fragmented memory (a valid
> concern IMHO).
> 
> Minchan, if you have any objections, please chime in.

Not Minchan, but I do have an issue with the title of the commit, it
doesn't make any sense. Can the maintainer please re-write that to be
something that is appropriate and actually describes what the patch
does?

-- 
Jens Axboe

