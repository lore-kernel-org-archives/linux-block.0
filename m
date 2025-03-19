Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67721CC52
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349493; cv=none; b=KKB0HXKU6si3Bxnr4RCeLC/SNsJEiW6DPeW6QeCOkrY6QyUbM6qrnxkaq2uthFc5xXrDJmL8POnHONuR9Vo9wx4gIoIZmcMeO4jGV5Bj5xQmMeU2Hq0f4b21tK81Xpww9uw9ikZQ1u3u8HYm4GvOogxGVrY7jRuApWo0ekcqTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349493; c=relaxed/simple;
	bh=WZyf3MJ9EOEbObbzPSe9nqueYSpxPvSFo2cK6SEpYhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtyxmDk1PkSDurWtQBBPtRlF5YUYTS+UxqkAqJvO5CWfESA3Dk82n5noQBEIT9JPkYT9A1uua+R74g1kfCaUAD5bpl3I552uoOXvwMiPBmhFWXhCOexDcbFvLOIx/gwo3p6BDDG/CoRCbZvVJeOSa3jr1Y5oemUT/QL/iZ15ZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bov6Vrh7; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bov6Vrh7"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d4436ba324so42398865ab.2
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742349491; x=1742954291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6MK63jhxMlZt6sJeJv41vQot4VyzaKtZyKetUK2DPU=;
        b=bov6Vrh7/TXcnq0zCSvMV3LDpErouJDffvno6PKZFCqfw5KZQkXI96F/JKBuAx9ecI
         MTiCIVHEH97AEc5bxNlFGr18ojOoDDCybiDg855JgqtoDxB+DJMwf41VL+XmMr1S+H1v
         sCOGOh0BCOh4WQC14ChfftqYnpGMNki0RQhHkDo5/2bnv6hKOyhNkPzstKH6Ecls3HFC
         zztgRty8kd9bABS9GgjFTRIvrV+QRsdC0LY79sdn5RDy6EB9J5QKozrTmrkQuVU/reW+
         pyWbvxW3cRGDR1daBTPliMaEXPHbNYtD2uUVGbyIR4RHbFwJPuxVtqeXilduwTngGf5j
         ganw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349491; x=1742954291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6MK63jhxMlZt6sJeJv41vQot4VyzaKtZyKetUK2DPU=;
        b=nKYCZSrZBJn5TsFQg2GyEIV9yfb1udOgFc/LngJArFR5RgWf4TArvftJtiqzMlgu8i
         FuKr2bOGDWKN5KtSn/rohM7jJ9E0jWVKZ3hVc3I3/6yoS8LsvdtA00gUtM8IJsgL7tx2
         LeKQfLeT4wVeXqlFlLWbzB5V2X6sI00ULs6Dm9SQDuq9XGEEDxE1Aicd437ZFSjyLwz8
         2ZvqasJdMNZqQNguCQ2vXCSOAoTjazjFUX6wDmUv6NZBxqJ5GrlTNWc3sjLq7dgUux6T
         kA7P9rwd5LqgzmfisOe7Y7eXCkltzNgxCrwmW62wmEHtB5KuW1K8DC/U2WKrUwZYfu9e
         571Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOLqYQ61KAXAvqvhewIZWP0+z0r778TDrgylgBYya6izVU5NFX6dqvgQI6DoEfQIGyfKXb/t+uzZ6Yeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNO5OsaNDxov7CYVVhqfh1/M+IxoUu7eWlJL+2IiYWiryygd3
	3qeDTc1i4LRtwISK6KRT+zsZo67O+pPBuH9bd0lXLkwgKeiED9wy49eM4guu5sQ=
X-Gm-Gg: ASbGnct1boPY3q1h2pdOlG0l2KVvWBiNRZT/B2yHoN6IfMgp8vBICtlYZiR2ImZXsw2
	uUvRcGX8dBVSyJ2d6m/RJ4iTu8+yvdylKm+9Uezqp40j7TGAo9d7aSQekI+KnQN8pFwVB8p8TpZ
	9G3btR8rc4C1/WcJ3FpXHKs22GKyDFtp/YikiuuBp/ZJluNRzOz2JuEGVzF7KJC9GM6NkSiLIUt
	9vFO0CQDLH4UVJmkd2olI+HgCnF6+9bUU7u4+4Hw2AHIwHS6N3GAeSrbKns//cqPeF9j+SHf7e3
	0Lsd+qRE2mOdwJzUFb0z2kuumhUhXh+QiPNTKOobng==
X-Google-Smtp-Source: AGHT+IHf7JjLapO8/hmnBVRoBaz2gGmSZDSDsmfk5exQlSCqK4QGMo8kuGEcRjSQq1tD6bhcqOIKOw==
X-Received: by 2002:a05:6e02:1549:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d586b1b246mr10865835ab.1.1742349490923;
        Tue, 18 Mar 2025 18:58:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a646eecsm35476115ab.1.2025.03.18.18.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 18:58:10 -0700 (PDT)
Message-ID: <6ebdd2ae-8fc2-4072-b131-a7c0da56d3f2@kernel.dk>
Date: Tue, 18 Mar 2025 19:58:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATC] block: update queue limits atomically
To: Ming Lei <ming.lei@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev
References: <ee66a4f2-ecc4-68d2-4594-a0bcba7ffe9c@redhat.com>
 <Z9mJmlhmZwnOlnqT@fedora> <d5193df0-5944-8cf6-7eb6-26adf191269e@redhat.com>
 <Z9ocUCrvXQRJHFVY@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9ocUCrvXQRJHFVY@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 7:22 PM, Ming Lei wrote:
> On Tue, Mar 18, 2025 at 04:31:35PM +0100, Mikulas Patocka wrote:
>>
>>
>> On Tue, 18 Mar 2025, Ming Lei wrote:
>>
>>> On Tue, Mar 18, 2025 at 03:26:10PM +0100, Mikulas Patocka wrote:
>>>> The block limits may be read while they are being modified. The statement
>>>
>>> It is supposed to not be so for IO path, that is why queue is usually down
>>> or frozen when updating limit.
>>
>> The limits are read at some points when constructing a bio - for example 
>> bio_integrity_add_page, bvec_try_merge_hw_page, bio_integrity_map_user.
> 
> For request based code path, there isn't such issue because queue usage
> counter is grabbed.
> 
> I should be one device mapper specific issue because the above interface
> may not be called from dm_submit_bio().
> 
> One fix is to make sure that queue usage counter is grabbed in dm's bio/clone
> submission code path.
> 
>>
>>> For other cases, limit lock can be held for sync the read/write.
>>>
>>> Or you have cases not covered by both queue freeze and limit lock?
>>
>> For example, device mapper reads the limits of the underlying devices 
>> without holding any lock (dm_set_device_limits,
> 
> dm_set_device_limits() need to be fixed by holding limit lock.
> 
> 
>> __process_abnormal_io, 
>> __max_io_len).
> 
> The two is called with queue usage counter grabbed, so it should be fine.
> 
> 
>> It also writes the limits in the I/O path - 
>> disable_discard, disable_write_zeroes - you couldn't easily lock it here 
>> because it happens in the interrupt contex.
> 
> IMO it is one bad implementation, why does device mapper have to clear
> it in bio->end_io() or request's blk_mq_ops->complete()?
> 
>>
>> I'm not sure how many other kernel subsystems do it and whether they could 
>> all be converted to locking.
> 
> Most request based driver should have been converted to new API.
> 
> I guess only device mapper / raid / other bio based driver should have such
> kind of risk.
> 
>>
>>>> "q->limits = *lim" is not really atomic. The compiler may turn it into
>>>> memcpy (clang does).
>>>>
>>>> On x86-64, the kernel uses the "rep movsb" instruction for memcpy - it is
>>>> optimized on modern CPUs, but it is not atomic, it may be interrupted at
>>>> any byte boundary - and if it is interrupted, the readers may read
>>>> garbage.
>>>>
>>>> On sparc64, there's an instruction that zeroes a cache line without
>>>> reading it from memory. The kernel memcpy implementation uses it (see
>>>> b3a04ed507bf) to avoid loading the destination buffer from memory. The
>>>> problem is that if we copy a block of data to q->limits and someone reads
>>>> it at the same time, the reader may read zeros.
>>>>
>>>> This commit changes it to use WRITE_ONCE, so that individual words are
>>>> updated atomically.
>>>
>>> It isn't necessary, for this particular problem, it is also fragile to
>>> provide atomic word update in this low level way, such as, what if
>>> sizeof(struct queue_limits) isn't 8byte aligned?
>>
>> struct queue_limits contains two "unsigned long" fields, so it must be 
>> aligned on "unsigned long" boundary.
>>
>> In order to make it future-proof, we could use __alignof__(struct 
>> queue_limits) to determine the size of the update step.
> 
> Yeah, it looks fine, but I feel it is still fragile, and not sure it is one
> accepted solution.

Agree - it'd be much better to have the bio drivers provide the same
guarantees that we get on the request side, rather than play games with
this and pretend that concurrent update and usage is fine.

-- 
Jens Axboe
