Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FF171BB
	for <linux-block@vger.kernel.org>; Sat, 16 Mar 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710600001; cv=none; b=WYKYx7HSOhFZHk4hprtpPZ0gfi/xxHTCgPtCpRVbFVyjghPsKDHfmm2nFArXPN9vkxToB0O8Ia5ImGY7GiL/EBG+OAZS72ysliqkRTGW3YLjLTgnjNGk7y0/0F29VJ3uLVEsZ0LUpGtNSth9jcvokDmKqiTG2xLqDFR+AaWNu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710600001; c=relaxed/simple;
	bh=73OXW6pTlGLLBW9MfEBQwW+BVRiIDp238X1M+JI7Yxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX7jC+n9+xN2ojJ1aqMuTQ5tMlsTllgsJAaXfh1hRGVJoRfKd5YsUSxGFn0I62uZ4XdVCMsJXKPovZ2A4PoOChzu9osIOMWxtgGqHAAEIOpgJduwJRd7QVG1QNo2/f/rBn/xT8ReIrMo78/mV+DyXijiLDB5v1LYBlIf8KZDdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wJq3dDp3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wJq3dDp3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29d51cdde7eso952072a91.0
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2024 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710599998; x=1711204798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZ4yFo1VyLJ+y6QT4dGRiJ5jwQSp3a2Nf6zrdn6LrkY=;
        b=wJq3dDp3x8JNA0BEpUKNU9cZD1KHMMZYtrE0vOWUOoCUL8GS73DWCKEY4ue+WVhims
         VyN25DXyUu+PMh0R5DzPbxNcWXHOh3PDOlNesJSsf8QHTZNMZkKTTdGbsEDbX+sltiu8
         7MqGDC8CJGKNRrQQBZs/ugxx8c80sUUeAxWju7Bx+rO+c8G03KgOVtWSS4gD71gcjfuu
         D0vXl08DcPzTvkb8xQx7XMDCsdZVJHvet59LuBzQ8NkzbHiAPGCkYSv/XY+hiDemJM9K
         RCM1pUmdHWPa81TWL5m7CzOZH/xNt4eVkxkqUbnzTLIndmx2EkI+hAKCN8h8LspAm1cl
         pvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710599998; x=1711204798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ4yFo1VyLJ+y6QT4dGRiJ5jwQSp3a2Nf6zrdn6LrkY=;
        b=Z9qM2whduJty7qAJCVB3AP9gL4I312BkeD6MDpSzzdp7alIIJvR4n8oQQLHfaD+gMW
         miiPMvkCZjkQLCsIZkgPU7+N+wUx5q/CnjhWu0g8Rj1OlPp6QK94ri4dumEXxfkwmQv0
         +doErUNWPv2Y0vXtILjWNkbag9V9v+Wuw1+utdnBO4CWrZXYMA6Dxxi2Z3AtbKa2WwkS
         +aZYvgYuECyE35H3GkO/GDoyGRHwPNMagyO05lIKE42mah2+kYf2KZfsUovZuwY4vkBp
         aHzoaJqlG9fOx1kovPvCnfi1VszOTC+ZaOq5PRefBhAqafBELrQDEPvkBqRWOa816pAJ
         3u+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq8ihrjujDEJlUplm5F6c2lKaTnLEA1qNa0R752kVnuIvb/8yICaK/l3La50MZPtAnFMs4P5GyqOMNZFbrSxeOjhaR89u63pKPuYQ=
X-Gm-Message-State: AOJu0YxQpfjQ/KeAKZ4j4HqslNqgZvx6+sYoXoYZZc8g2p5wrS3y8xlh
	H8qZPRhnyv4Kcf0gL6qd3rFWI/NaQCxx8Tn2+lrRk7RZWD3/giFLIQbyIbzVK6E=
X-Google-Smtp-Source: AGHT+IH7g+QXYVmugrseha/BLqq3hWUtLMbdjmNSj54K7/SSF/tjFNdICksn4ozdpOP2T2RYQ0+wpg==
X-Received: by 2002:a05:6a20:8e09:b0:1a3:5666:8d79 with SMTP id y9-20020a056a208e0900b001a356668d79mr2477751pzj.6.1710599998490;
        Sat, 16 Mar 2024 07:39:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id gu25-20020a056a004e5900b006e7040519a1sm1641272pfb.216.2024.03.16.07.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 07:39:57 -0700 (PDT)
Message-ID: <f03f3a74-38ad-4ddb-8ce8-d3de2ebfeb3e@kernel.dk>
Date: Sat, 16 Mar 2024 08:39:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 Kanchan Joshi <joshi.k@samsung.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <171054320158.386037.13510354610893597382.b4-ty@kernel.dk>
 <ZfWIFOkN/X9uyJJe@fedora> <29b950aa-d3c3-4237-a146-c6abd7b68b8f@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <29b950aa-d3c3-4237-a146-c6abd7b68b8f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/24 7:27 AM, Pavel Begunkov wrote:
> On 3/16/24 11:52, Ming Lei wrote:
>> On Fri, Mar 15, 2024 at 04:53:21PM -0600, Jens Axboe wrote:
>>>
>>> On Fri, 15 Mar 2024 15:29:50 +0000, Pavel Begunkov wrote:
>>>> Patch 1 is a fix.
>>>>
>>>> Patches 2-7 are cleanups mainly dealing with issue_flags conversions,
>>>> misundertsandings of the flags and of the tw state. It'd be great to have
>>>> even without even w/o the rest.
>>>>
>>>> 8-11 mandate ctx locking for task_work and finally removes the CQE
>>>> caches, instead we post directly into the CQ. Note that the cache is
>>>> used by multishot auxiliary completions.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [02/11] io_uring/cmd: kill one issue_flags to tw conversion
>>>          commit: 31ab0342cf6434e1e2879d12f0526830ce97365d
>>> [03/11] io_uring/cmd: fix tw <-> issue_flags conversion
>>>          commit: b48f3e29b89055894b3f50c657658c325b5b49fd
>>> [04/11] io_uring/cmd: introduce io_uring_cmd_complete
>>>          commit: c5b4c92ca69215c0af17e4e9d8c84c8942f3257d
>>> [05/11] ublk: don't hard code IO_URING_F_UNLOCKED
>>>          commit: c54cfb81fe1774231fca952eff928389bfc3b2e3
>>> [06/11] nvme/io_uring: don't hard code IO_URING_F_UNLOCKED
>>>          commit: 800a90681f3c3383660a8e3e2d279e0f056afaee
>>> [07/11] io_uring/rw: avoid punting to io-wq directly
>>>          commit: 56d565d54373c17b7620fc605c899c41968e48d0
>>> [08/11] io_uring: force tw ctx locking
>>>          commit: f087cdd065af0418ffc8a9ed39eadc93347efdd5
>>> [09/11] io_uring: remove struct io_tw_state::locked
>>>          commit: 339f8d66e996ec52b47221448ff4b3534cc9a58d
>>> [10/11] io_uring: refactor io_fill_cqe_req_aux
>>>          commit: 7b31c3964b769a6a16c4e414baa8094b441e498e
>>> [11/11] io_uring: get rid of intermediate aux cqe caches
>>>          commit: 5a475a1f47412a44ed184aac04b9ff0aeaa31d65
>>
>> Hi Jens and Pavel,
> 
> Jens, I hope you already dropped the series for now, right?

It's just sitting in a branch for now, it's not even in linux-next. I'll
review and look at a v2 of the series. So it hasn't moved anywhere yet.

-- 
Jens Axboe

