Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E61DFEF
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270268; cv=none; b=TnSvfax4B1WR/c+9Z+Vs1pOq/z1UVwj6diMjALEFnMTeRhFnYN68WEG7f6Hw2SV0KchOoyovHvqYLo7T/uunyMB7KCa5nc+GmtFo3cEkutvep//RKEOsR7Z1CbdbB8JojY5QGYPM7HQ3UMatSgBFswkXNnFbrEOtwFQ3uJU9Goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270268; c=relaxed/simple;
	bh=JHmQWtliapR73c2isL5syFN0KpY1JYfjAntD0OnQfJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owgWjf06k41ycuNxrPdCRD6CR0OGNZNx+CyryhuRYf8rfGYggJRXZnoqU77g5KfPXm5OOV1jLxWPxgQahai39e2OoDREui8xbzBfzxYbTf/sz/VX9APHNk81VaV2TzXQnsXlyfqFKso2AcepeUiLVnBiD59TdYI5U2OhFeauNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rL+JhP/Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rL+JhP/Y"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4edcde7a1so9509515ad.0
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713270266; x=1713875066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyPcXToXo9DelQ/q921/3NLHfEPtUQCQAx9Aed7N8wQ=;
        b=rL+JhP/YfGLtFj+R0U+4miO210l1P0nhCwJ6Zh9Fe+R4bQOkiVa2mIox26JRmA8ZSj
         tkJVCacISnYFhVhMCnVUHZc9PiaNOuSL7PqXEkSlkyrKPcmRPhaeXcsyTeGDyBGhwcLB
         QItuJoKOHriZwRL1JVeSy3sQ64kHBS4P1hblHDWKgaPvCK7xGcLctTak/i6tKrZ+f6qi
         n9+nJS8Qqb6jicAPWiICiFCVWVwEZCmTfyyQmRevlPDqIcjfl/VWnQYE4pO/gt6oIwsq
         DE6TUiABJk1VNq07/QA44QO69M4HmfCk7ahhmFYA01sBMRVv9oKsibkloEXICWaC5Wgy
         PjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270266; x=1713875066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyPcXToXo9DelQ/q921/3NLHfEPtUQCQAx9Aed7N8wQ=;
        b=OmlNQzJCeU1/dQBVkkdhLN21fn/XpFeovOvoCzUiP+dOVF1NNkQXCFMaK4Vp46HBGB
         m6ONk/EI4cixck6DOHCUvrVyvUvw+075EfFtkRxk98r636R6uwyqGgYjB3K/ZY40FICk
         74KnsRk+jVJwPiq+H3qTIXKmuV22GQ9AXm1jkr0at2LHzFJ5eeU9EuP+jV5P2l5Vj7Q6
         5R1ht8dFnXX/CF1s92F8JWqsVAi31F1ugEimWb9Hp2A7I4omfZjQu0dk9OIyxAbBmPy7
         xG0UCGh15iUXVOS3kS+SOHWRLIsODPYFfbuzDpSeFPV2D9PrPfTE4PAnsu8QXA9Ov0kO
         ESRg==
X-Gm-Message-State: AOJu0YzOADIaQszh0EguzufP9JHy8ThwrjNsoO8IICHe3YGQC50+UX06
	ohF9ZhXvroOfHbuJ1cCFdGiNmUd51CezTQNA/GdDX3PBNz4TgqgP2hpmxQXTSAA=
X-Google-Smtp-Source: AGHT+IE8/7bSBz77fVQbzSw/3CpWGR1txbJpwAWt2+KBytS5ZC7yA2gh33jGIPTjPi86zf9W9dyuGA==
X-Received: by 2002:a17:903:41cf:b0:1dd:85eb:b11 with SMTP id u15-20020a17090341cf00b001dd85eb0b11mr16047163ple.1.1713270266511;
        Tue, 16 Apr 2024 05:24:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001e2a42a2e34sm9663994plb.65.2024.04.16.05.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 05:24:25 -0700 (PDT)
Message-ID: <34d7e331-e258-4dda-a21b-5327664d0d04@kernel.dk>
Date: Tue, 16 Apr 2024 06:24:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at io_uring/io_uring.c:2835
 io_ring_exit_work+0x2b6/0x2e0
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>,
 io-uring <io-uring@vger.kernel.org>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk> <Zh3TjqD1763LzXUj@fedora>
 <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
 <Zh5MSQVk54tN7Xx4@fedora> <28cc0bbb-fa85-48f1-9c8a-38d7ecf6c67e@kernel.dk>
 <d56d21d5-f8c2-435e-84ca-946927a32197@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d56d21d5-f8c2-435e-84ca-946927a32197@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 6:14 AM, Pavel Begunkov wrote:
> On 4/16/24 12:38, Jens Axboe wrote:
>> On 4/16/24 4:00 AM, Ming Lei wrote:
>>> On Tue, Apr 16, 2024 at 10:26:16AM +0800, Changhui Zhong wrote:
>>>>>>
>>>>>> I can't reproduce this here, fwiw. Ming, something you've seen?
>>>>>
>>>>> I just test against the latest for-next/block(-rc4 based), and still can't
>>>>> reproduce it. There was such RH internal report before, and maybe not
>>>>> ublk related.
>>>>>
>>>>> Changhui, if the issue can be reproduced in your machine, care to share
>>>>> your machine for me to investigate a bit?
>>>>>
>>>>> Thanks,
>>>>> Ming
>>>>>
>>>>
>>>> I still can reproduce this issue on my machine?
>>>> and I shared machine to Ming?he can do more investigation for this issue?
>>>>
>>>> [ 1244.207092] running generic/006
>>>> [ 1246.456896] blk_print_req_error: 77 callbacks suppressed
>>>> [ 1246.456907] I/O error, dev ublkb1, sector 2395864 op 0x1:(WRITE)
>>>> flags 0x8800 phys_seg 1 prio class 0
>>>
>>> The failure is actually triggered in recovering qcow2 target in generic/005,
>>> since ublkb0 isn't removed successfully in generic/005.
>>>
>>> git-bisect shows that the 1st bad commit is cca6571381a0 ("io_uring/rw:
>>> cleanup retry path").
>>>
>>> And not see any issue in uring command side, so the trouble seems
>>> in normal io_uring rw side over XFS file, and not related with block
>>> device.
>>
>> Indeed, I can reproduce it on XFS as well. I'll take a look.
> 
> Looking at this patch, that io_rw_should_reissue() path is for when
> we failed via the kiocb callback but came there off of the submission
> path, so when we unwind back it finds the flag, preps and resubmits
> the req. If it's not the case but we still return "true", it'd leaks
> the request, which would explains why exit_work gets stuck.

Yep, this is what happens. I have a test patch that just punts any
reissue to task_work, it'll insert to iowq from there. Before we would
fail it, even though we didn't have to, but that check was killed and
then it just lingers for this case and it's lost.

-- 
Jens Axboe

