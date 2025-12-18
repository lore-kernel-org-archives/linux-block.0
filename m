Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867819E82A
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766028021; cv=none; b=StExQBvuzK2ZCc7r46Bp3OhsaICxgaQ94aZuMVQE4bDN610opieX+/Drkop03ZYjCsz8/Hs78j37Rtgc10iSnzAepICczILFmBg7LBRVfyG5BimyOKSvRrSTDhBHXYjoaqoEHB1XQvxRR9PJxdxAI5RaXr3fN55rUftJlNjwu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766028021; c=relaxed/simple;
	bh=NKEan06xgUdJ6cXxupFMdrgWgOLhA+xCGG8svbww0MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abK85cSQlcWPMoD2DammcJ8jllybgi33YRK+B0ThVoiaxcxZubZ3pkDAVoW1Q2E3ezTO/BecDf4PbJApibt1KOFws9OdJ3VcNHTKWPfig5mlnInwE9tpnqLoum5k8tEPWSjFfXny5Nht6iZ2TLMSQF4UdLyPZxXsGpirrOrdieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iAsCFMRh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iAsCFMRh"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c7533dbd87so124887a34.2
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 19:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766028016; x=1766632816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbI9vGuOaGNVd02X8DiVeutBVykfn04tLns3ZcNmIJU=;
        b=iAsCFMRhi3FhAJ1foX9WNBQjQzSq//RRU49RdxptmMbqsku4ZYUAMdI0DKqsif8DVI
         3RLULA6G7teqcm0BVkH3g+GikuynZXnB8Cr5KV5ZkDPIAKgg10gV1nLSggCm5OBKTE9K
         QAaAq7K0n+UUcNRFc/1/Y79CW/W6LWIZ9mV83VCReFRrE/1pAewQy5Hoa3ztOTMkF5dW
         DNxdxAKIQ+hpxcAuKR6oMP6zhvvSNUpieWhwGCkF7hUCEku7IWJj53oRrFftLM1k8c26
         9gFGk8IJXgYBDXk07LN+6kettl3MqmRE25lvBi1HPku5g61UDeUqvQOfZAdsoffL+aML
         2wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766028016; x=1766632816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbI9vGuOaGNVd02X8DiVeutBVykfn04tLns3ZcNmIJU=;
        b=AWv82HE1pEln5nln8OB0jAlQ0Qcc137jM6AG47+saW/GaS9SQ2si7HxVztz1szBq3q
         VgDU7LxkqFp2sug/EW+N9xeZV5n/jFZMlx43FK736cei6FU8o3IkwWq4D5QT59w/tv7a
         /jVa9SdOnKDxLLxcX+ByuBZMAIbSPs29steWcUlWwgMEaH4FEbEvA7l5gbYLxpoX7F8c
         2akKPk15RYSZ/rV/iZesgCOcBceCi6Iq2lWbgMIXORAHhTD2asr0HNa3wkNdNBpIRT3m
         KZiirUn4KnuvfqTPc3oj0A0JgsJY6N12HvgBgL/xWsxjdb6FtWx7EsBMcgMv6do36h9c
         8rCg==
X-Forwarded-Encrypted: i=1; AJvYcCWAtf3ilOS9N73o3gVdGvPcmQslyykF47Vf11poySNeNOKFH1VDO+wij6Pf5VKdZVvZGcnqZW83Gjfk4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoNAcalZQyFe6vGlwNQ66zJ4iaV7xUXgnJs8hobwBIk4SuX8D
	SR5BlYB/PZXQl4AzgPZ2G8BEBlu//iagZqP40NZTGUwDUUqHcABmjh8zcDZKTfhrRwA=
X-Gm-Gg: AY/fxX4xQbRvgfEIEjnVHOJc45vpptNpaQ34EKF39I9fuoM8/503UT7+Nn3xQQ6wkEU
	whnsx1Y2pwhInv+4B/mqcpgYr2tJWYdMbx88rh3H75Fo1o6DtPIK7+2Km+3MKPqv4IrsHG/c2uD
	CASQMvZgnFjin/hRP6dTpQqq5wFl0VrsZQ8jIs2G3SRDDOZoUHcGPwTYUGTb6X2XUH6W0erSSC3
	vrFH1M/mjhBwrIeLjPwDbX6gqLqtKc+aS4WZXMmrue6/NoUAMSVrqXZb7bZIxgl3Lrfr7tAyYYh
	7zDQHc/ubkwXGGhohexC72JxCfsOm3I+nWjqVvh08eagVJK1L9j8R5x0U4jhCmja8ZVfyJnr61U
	xCCnUrIajUckMDpW/F2Muvm/jSV8qLEPjgSB39OjvwwxIa2ZsQJypZt0OuZkBZWCKF2jk8nIAWa
	gXCJn6G9R2
X-Google-Smtp-Source: AGHT+IFAJin+NRyzqEBUMz8QXuREsN7pguQVRgCpRlCbQ0/YCtgw2Xr6SAf8RYBDkRblLZDKu76I1w==
X-Received: by 2002:a05:6820:4c84:b0:659:9a49:8ea5 with SMTP id 006d021491bc7-65b4523b5cemr8060181eaf.41.1766028016474;
        Wed, 17 Dec 2025 19:20:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65cff2150ccsm600548eaf.11.2025.12.17.19.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:20:15 -0800 (PST)
Message-ID: <7f5a7801-0403-44e1-8629-3196092f32a9@kernel.dk>
Date: Wed, 17 Dec 2025 20:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: fix race between wbt_enable_default and IO
 submission
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai@fnnas.com>,
 Guangwu Zhang <guazhang@redhat.com>
References: <20251212143500.485521-1-ming.lei@redhat.com>
 <CAFj5m9KVcKzEqpXt0J_28L+bHojeAv4+cu8hTyfdfA_c-q4nWw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9KVcKzEqpXt0J_28L+bHojeAv4+cu8hTyfdfA_c-q4nWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 8:18 PM, Ming Lei wrote:
> On Fri, Dec 12, 2025 at 10:35?PM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> When wbt_enable_default() is moved out of queue freezing in elevator_change(),
>> it can cause the wbt inflight counter to become negative (-1), leading to hung
>> tasks in the writeback path. Tasks get stuck in wbt_wait() because the counter
>> is in an inconsistent state.
>>
>> The issue occurs because wbt_enable_default() could race with IO submission,
>> allowing the counter to be decremented before proper initialization. This manifests
>> as:
>>
>>   rq_wait[0]:
>>     inflight:             -1
>>     has_waiters:        True
>>
>> rwb_enabled() checks the state, which can be updated exactly between wbt_wait()
>> (rq_qos_throttle()) and wbt_track()(rq_qos_track()), then the inflight counter
>> will become negative.
>>
>> And results in hung task warnings like:
>>   task:kworker/u24:39 state:D stack:0 pid:14767
>>   Call Trace:
>>     rq_qos_wait+0xb4/0x150
>>     wbt_wait+0xa9/0x100
>>     __rq_qos_throttle+0x24/0x40
>>     blk_mq_submit_bio+0x672/0x7b0
>>     ...
>>
>> Fix this by:
>>
>> 1. Splitting wbt_enable_default() into:
>>    - __wbt_enable_default(): Returns true if wbt_init() should be called
>>    - wbt_enable_default(): Wrapper for existing callers (no init)
>>    - wbt_init_enable_default(): New function that checks and inits WBT
>>
>> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
>>    proper initialization during queue registration
>>
>> 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
>>    disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then the
>>    original lock warning can be avoided.
>>
>> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
>>    code since it's no longer needed
>>
>> This ensures WBT is properly initialized before any IO can be submitted,
>> preventing the counter from going negative.
>>
>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>> Cc: Yu Kuai <yukuai@fnnas.com>
>> Cc: Guangwu Zhang <guazhang@redhat.com>
>> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>> V2:
>>         - explain the race in commit log(Nilay, YuKuai)
> 
> Hi Jens,
> 
> Can you consider this fix for v6.19 if you are fine? Yu Kuai has one
> patchset which depends
> on this fix.

It was queued up on the 12/12, now I'm pondering if the "thanks applied"
email never got sent out? In any case, it is in block-6.19.

-- 
Jens Axboe
