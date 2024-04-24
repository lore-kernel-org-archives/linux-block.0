Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56315AABA
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967108; cv=none; b=i1uuTXoYWKlLYHkhtyRGLsAz/C6pcikdtmvftaAumG5nr3eSOFMi8zltqI+bW/rFptj2Yv4zNpsRcL1tNvX7tD2rbsLQ9TYS2UDkhfRPRg1qrFhtdrsRJ5I/OjRAR2piw99O8f83XVtTlmXJjY4KIM2bivI4hwUn7yJedHe8mk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967108; c=relaxed/simple;
	bh=BW+Pq6GKBfS9eNSmXeTBK6qJ87TVMgIjkpqY+MOrmL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=APz9qBQScHlSwdA5aTygXvcI2sha1AEYMhoNhIs0MQYVXI4/YlERGAfVUsqlxq0kgK7gZ+2vy5jTPRwn+vyxYNPNjwzgARaafe0Qo7FdncAvHrtpApARLXoqerG1dN/5helr/KEyRYQqwhhzejAv2CM4lcT7oGVDQ4fSZLAm8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vmp7wPmO; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vmp7wPmO"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7da9f6c9c17so27542239f.2
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713967104; x=1714571904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5AgsSYH2ZXztFqvLT0BzKeyqgnTVgWsg369g6M5uJA=;
        b=Vmp7wPmOHBBGDV0LjrPHZ9TuOI6w7hunHsYn1M8BhjpmiikFpUce8AXHscl+o0WUHj
         PtUBIu2eSVSpnW89jrKlSHlnRz6CV7r+wPqIQ4wb7NW6Z9ljGOeTaedW2AVKRwSMInhB
         N/uFEt5F4zl67uUBJuQySlDc4qungcChi6aV2BLicNEbOO8CQaX6lVyxP36Tq/cgnIqK
         zBWTH7pc0gF0HW+vK13F8yhdu4VKvgzQn2RR0B9JPzqy++CmE7wAIgfMTupA6oKHkUsa
         naVOihpQjs+cTBgo7Ynij92VMWzY6SNk5c9HFv8mD/+ANE4ETAalEpO4KSBA5Vaf70+1
         +EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967104; x=1714571904;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5AgsSYH2ZXztFqvLT0BzKeyqgnTVgWsg369g6M5uJA=;
        b=LH+ojAt3IEwnVDcKPzcmFxbatyMB5SoiP2NeKH5O1WNwPgu9JReGXIkTntmnjjlncA
         o5lE6rNAzYhF1bEeqt9NVBG2E3vUxtMQ8yliPGGlF+NM5pKlcAjfQW7k/qrEbK1jjZz0
         h5DJIMQbJzvPFkJayabjIZR8x+TisD5wzIheD4s6E2R1bl/PtRM6q8pgAd4xVHo/kh/0
         cJJfvVBWATai+Ze0K+0h60lneCp43UfQ0bF4FUKZS01bie92oypjMqSlRDSAJjg/gsHz
         q0MY+Gk0OgPAsRsQx1UYXI7MvQluBcXOshsDErXd8oSoiqqfD07JPknJBEVM0x+olXua
         eiHg==
X-Forwarded-Encrypted: i=1; AJvYcCUJZThtARn+v7Mkuy5DXaLF0ADbk9iomDyQJGdfupFpHofpsrQe70PfZyCJ0b7AF3t0glx/VEjt2OtSxQ13V/zb14wEA91vxM7Y+B8=
X-Gm-Message-State: AOJu0YwhRh1Szw2J0kvRB5Zq/JaIKXdCa0Nl9Q1piZ8ODKrDrO+VaiwF
	JwKF3cSoITQGqkiAftG4/GMeNyQHDHqo22bIc8ZPui9wDQqUUFkohoz+aeNSsdYgOHb7Ry3Te7U
	o
X-Google-Smtp-Source: AGHT+IHeUYhJ+SVUfItfCo9mtv7Z4FbeAXvXMUi2Pio17o8EpgdLRJLyUkYhl+UgHWqb5yBWCA4WEQ==
X-Received: by 2002:a5d:954f:0:b0:7da:7278:be09 with SMTP id a15-20020a5d954f000000b007da7278be09mr2753649ios.2.1713967103774;
        Wed, 24 Apr 2024 06:58:23 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x5-20020a056638160500b00484f72550ccsm2984056jas.174.2024.04.24.06.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:58:23 -0700 (PDT)
Message-ID: <2787b6ed-c5a2-4f5a-9214-3fab75bfe1ee@kernel.dk>
Date: Wed, 24 Apr 2024 07:58:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
 <715fd037-a8e5-4e62-939e-a446087eed2a@kernel.dk>
 <4530f039-0698-4cc0-94ab-5465d3f0e255@kernel.org>
 <1d4fb854-3151-41f5-b9a5-2a5cf2a37986@kernel.dk>
 <61ff5a29-9b16-4a52-b0ae-cfba2ea3c748@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <61ff5a29-9b16-4a52-b0ae-cfba2ea3c748@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 12:19 PM, Damien Le Moal wrote:
> On 2024/04/24 1:36, Jens Axboe wrote:
>> On 4/23/24 9:16 AM, Damien Le Moal wrote:
>>> On 2024/04/24 0:21, Jens Axboe wrote:
>>>> On 4/20/24 1:58 AM, Damien Le Moal wrote:
>>>>> The submission of plugged BIOs is done using a work struct executing the
>>>>> function blk_zone_wplug_bio_work(). This function gets and submits a
>>>>> plugged zone write BIO and is guaranteed to operate on a valid zone
>>>>> write plug (with a reference count higher than 0) on entry as plugged
>>>>> BIOs hold a reference on their zone write plugs. However, once a BIO is
>>>>> submitted with submit_bio_noacct_nocheck(), the BIO may complete before
>>>>> blk_zone_wplug_bio_work(), with the BIO completion trigering a release
>>>>> and freeing of the zone write plug if the BIO is the last write to a
>>>>> zone (making the zone FULL). This potentially can result in the zone
>>>>> write plug being freed while the work is still active.
>>>>>
>>>>> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().
>>>>>
>>>>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>>> ---
>>>>>  block/blk-zoned.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>> index 3befebe6b319..685f0b9159fd 100644
>>>>> --- a/block/blk-zoned.c
>>>>> +++ b/block/blk-zoned.c
>>>>> @@ -526,6 +526,8 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
>>>>>  	struct blk_zone_wplug *zwplug =
>>>>>  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
>>>>>  
>>>>> +	flush_work(&zwplug->bio_work);
>>>>> +
>>>>>  	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
>>>>>  }
>>>>
>>>> This is totally backwards. First of all, if you actually had work that
>>>> needed flushing at this point, the kernel would bomb spectacularly.
>>>> Secondly, what's the point of using RCU to protect this, if you're now
>>>> needing to flush work from the RCU callback? That's a clear sign that
>>>> something is very wrong here with your references / RCU usage.. The work
>>>> item should hold a reference to it, trying to paper around it like this
>>>> is not going to work at all.
>>>>
>>>> Why is the work item racing with RCU freeing?!
>>>
>>> The work item is a field of the zone write plug. Zone write plugs have
>>> references to them as long as BIOs are in flight and and the zone is
>>> not full. The zone write plug freeing through rcu is triggered by the
>>> last write to a zone that makes the zone full. But the completion of
>>> this last write BIO may happen right after the work issued the BIO
>>> with submit_bio_noacct_nocheck() and before blk_zone_wplug_bio_work()
>>> returns, while the work item is still active.
>>>
>>> The actual freeing of the plug happens only after the rcu grace
>>> period, and I was not entirely sure if this is enough to guarantee
>>> that the work thread is finished. But checking how the workqueue code
>>> processes the work item by calling the work function
>>> (blk_zone_wplug_bio_work() in this case), there is no issue because
>>> the work item (struct work_struct) is not touched once the work
>>> function is called. So there are no issues/races with freeing the zone
>>> write plug. I was overthinking this. My bad. We can drop this patch.
>>> Apologies for the noise.
>>
>> I took a closer look at the zone write plug reference handling, and it
>> still doesn't look very good. Why are some just atomic_dec and there's
>> just one spot that does dec_and_test? This again looks like janky
>> referencing, to be honest.
>>
>> The relationship seems like it should be pretty clear. Any bio inflight
>> against this zone plug should have a reference to it, AND the owner
>> should have a reference to it, otherwise any bio completion (which can
>> happen at ANY time) could free it. Any dropping of the ref should use a
>> helper that does atomic_dec_and_test(), eg what disk_put_zone_wplug()
>> does.
>>
>> There should be no doubt about the above at all. If the plug has been
>> added to a workqueue, it should be quite obvious that of course it has a
>> reference to it already, outside of the bio's that are in it.
>>
>> I'd strongly encourage getting this sorted out before the merge window,
>> I'm not at all convinced it's correct as-is. It's certainly not
>> obviously correct, which it should be. The RCU rules are pretty simple
>> if the the references are done in the kernel idiomatic way, but they are
>> not.
> 
> OK. I am traveling this week so I will not be able to send a
> well-tested cleanup patch but I will do so first thing next week.

Sounds good, thanks.

-- 
Jens Axboe

