Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C83C2774
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052366; cv=none; b=Y0M+LekoMQ8z4Y/niM47ELsURqzkZcRSKjxMakAGOEHBUMJGOkdYZCmqIHjRLrf5C1XdGaO6oAJajpLFDwruuP3lQhE22EXQdvHdQUu4ikHzDiCpGKb6cgqmE70tQa6zfaCnrbEOGHCg7SKyYnQ8NJC5/Ani3jBcKbbidltsdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052366; c=relaxed/simple;
	bh=OALE1Pc/rF8dgWSwkPtQJkCEVXfiJcU73/nCbwbqG6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATnUFZZMXDx5Mk2c+a+KdZDQv6LJX3nnykXTsMKh2ZUZMdnSfk1e5yk7pWIXlKhi47eGUfjZ0yj8MHJR7LvXofPZriLYGKNB7NxEKdulE4mYtXjfNCxZa5tdTzV/VXDjrwnrrFpHDQlaZOnNUM5vTCOyxyBW58KBRQdcu6Azssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fmoDnVBf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fmoDnVBf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49068493267so38636525e9.1
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780052363; x=1780657163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F21Dsc8xJ3JaBQAyJr3DbcWUQMZ4eqao7aBELV86M4c=;
        b=fmoDnVBfKy1QnDiVAyyFZbMss3DphTuiFrppppmYcuQiGm8/fLRpy+eGRUQS5j4a/q
         SjOzGEPIeW8hGM80k72OQnM982Rw8pMyA4HZ+HVJH94QP67dIYaXsWb9EBLKJMB+o24c
         u+5f+YQmRrlPc8Bnvlt649rVSBfB3o4y9izPJeQ1m3znXBXA1QLvNvDs7ne2dZAJ4k5R
         zcgDIiRadGGP51C6myPSqrBN76Iq9oqdbbxeIwjtOEyacbxYlhDCMcOdPSXHUnoS9q8o
         bc494ETZcj8FuYeLqPqLd2jSvd0jafNl5CL7ydsx9nS4PosZHrvrtY4COOIKV63hu0Tp
         CiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052363; x=1780657163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F21Dsc8xJ3JaBQAyJr3DbcWUQMZ4eqao7aBELV86M4c=;
        b=pBJYXesVg69UmY5uw/4r69QlUiAlP9wrVSmKlzYpuiPlDLkkZto1TwOf+6xHlWPz0E
         TzrTsoZthW5pjPTMYmREAh9vMb4LSHSTQ33Syi99cOJj5C574uenO+qjxhnxdBmApd5D
         U+kuwVmS+8EHbRH07qhIrzm34c4EeeVvDuOQWifQs4fxz6rA0x/ESEWMr6evkynMVc0O
         0yQClx2SCXvWC4OAOfvNuK8Tn7GlsNDWIkg0hsPpg7XahUZI22eMZFgdRajjuTE9rSyw
         1JGzUNnDHYaUvqpAD16d5sYhNU4UWjqydG18H+34SfQjf6hBvyF/iUXlVOcJbrAv6p4r
         FBQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2/XOQzGiVOWd4e6mbmqxQL6/JUMqd1L8hum5PPnI9TnoJVtkODjRiCybG1V+v91dB8mxWySF05IxBSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKORdR1QwdvP+ByDKzXwO/FFV+fETI0H+2bQiTcR5m8VQe7Aa
	hGatx+G+iUfeoKWYOxNlJPMMjVKcXkBuRfnD2SoFCY+t5tjIzub0woE=
X-Gm-Gg: Acq92OEK5HaIuvrb9w/mbrt101bHUBzYn8B5kP/kzHeVMPFADoGnXdfUtSn4HwXK+39
	8y4DyYg/LpyaDk1W3rh14y+whfx3Q3yxDLRv2Yuf9m+kxaorQAmk6hBMh9CkWHWIQ1FO39HvXh2
	8IgbizRTFMxpdWqShu5wAwdX95nbMiri51Ev4QTI1dwVv4VRunZes/6EZvIblmZQySWU/YSL2IM
	7n6jjSdlc8DsvQFh45CGTDLejpjUYhTvDpGamhQgU7W1+BQliX7h6hwspOar/th6gn3UGiI1j5Z
	nsDvdjwvS8rv972UbMLptPHZd9Ch9KZEgYP6XyMLK3tk5JizEoLh82cqstIBbhCEQ6cek9jRJih
	taZBl4os8L6TWxLmHm8aejectavdIu+9vnf3o+mdGG1XNLcOLd9J/CwieKqLszic7jfnfiaa6qT
	a6AF3afidH1zjHvktzCRuNLzLh6lwwAVQEPbqxG1bZavATBHKSj2kz5FIh6+W8yzkqnPsaur1Ji
	xzkKSinEp+IwA==
X-Received: by 2002:a05:600c:a55:b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-4909c0af305mr44771955e9.18.1780052362946;
        Fri, 29 May 2026 03:59:22 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ac5.dip0.t-ipconnect.de. [91.43.74.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c1263dfsm12436465e9.30.2026.05.29.03.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:59:22 -0700 (PDT)
Message-ID: <9b886b8c-f3cb-4497-a4d3-159cddb0dec1@googlemail.com>
Date: Fri, 29 May 2026 12:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/272] 6.12.92-rc1 review
Content-Language: de-DE
To: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260528194629.379955525@linuxfoundation.org>
 <20260529060918.123155-1-ojeda@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260529060918.123155-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.05.2026 um 08:09 schrieb Miguel Ojeda:
> On Thu, 28 May 2026 21:46:14 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.12.92 release.
>> There are 272 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 30 May 2026 19:45:52 +0000.
>> Anything received after that time might be too late.
> 
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64:
> 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> I am seeing:
> 
>      In file included from kernel/trace/blktrace.c:23:
>      In file included from kernel/trace/../../block/blk.h:5:
>      ./include/linux/bio-integrity.h:101:12: error: unused function 'bio_integrity_map_user' [-Werror,-Wunused-function]
>        101 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>            |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> This looks like it needs:
> 
>    546d191427cf ("block: make bio_integrity_map_user() static inline")
> 
> (and indeed in my run `CONFIG_BLK_DEV_INTEGRITY` is not set like the
> commit message says).


I didn't see this error message on x86_64; I built with CONFIG_WERROR=y and CONFIG_BLK_DEV_INTEGRITY=y


Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
