Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23013B7BD
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886596; cv=none; b=RNOVMAVTRQm+846H8F1BwDWQTFANDodhxoklFlrJZLbXymYJWWN8TXbEtO9hV5uwSu4LU6SSVV3ep2Ewx9FP5iXWxv3w5d4BRnRvJrLMNwOG5Rk1AWB3lq1n3e5Yd2hQ9hq5MSISfiVpBxzKiPUu0Z7jUB+fRzzwkH8PBQB+EjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886596; c=relaxed/simple;
	bh=83TTS5zfSIGeM+ashRs8ec9gCYwr+trtpC6/LnrHaOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cS3L++vWdwA9IM5w098JqcIU3GM6anH8HsWHqikzdnGLrYeNPYksqgzpigdH+SuYtYLcmRczN1l37tVTJv77iZF3Fqf1p5kHEKdhrF1WqAL+V6Jc0iPeMwz9LauDaLvxacfCtCMRcXp5O/n3cMu65tqqatxfzwTVJiFmrD/ybmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Xi3jrcLx; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xi3jrcLx"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7de06f7560fso3978439f.3
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713886592; x=1714491392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKlEbCbo07UJPSp3QBV/5UL5F45k+RLcgangFiyAsCo=;
        b=Xi3jrcLxU/H/b8tQeWTCtySOzYuaEtNVT4waNXzBVvzSlZR+ciraWnS6nnWAP2tCll
         KjSkMor0er7RFxOnq3COf2EfHYYZzgZhr+PNUXmbmh6+oGJ5lAjITg3lyz9vJuaku33q
         LOMhsdq5GrilcKsz+s1rMQVYVvUQ7lC8qKDK2eVUQlWOgTZVmGYoJMsDe3salfKZHA2N
         Rj6Wyq8qYjpAd9RwAsWNFynq2wGIJ8ZooQRSkN7v7ikcIPB06lmVn5EEhte++uYI4TFn
         gvWeG+640iPlub1jjLoTrp16zs4dUlrEzjOtHQc4B7uBeNMqmAHm7vVJYirO+AtFIrOp
         ccYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886592; x=1714491392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKlEbCbo07UJPSp3QBV/5UL5F45k+RLcgangFiyAsCo=;
        b=OJ9Gn/Tp4ReROBXMEJkJiYRyOsoAQaG1F/xBbWKRZSY8w9g0DVA8CG3qiSiY9pSy24
         Y1VPPvavLkQ/u+bccPTc5qN1U52jnVwG734yuPe4XtG5Rfaz1zIDYhLpb9hPmd2th9tX
         2e4YG1GDwk+MVx49nOB38UCo8nXYJwz7cA+guO6UzJfP0dcNrYS7J8OYJYOZ5EGroLgu
         Y4Ud+vbcf4SOUsGfyfA0tbwsOPQmtdFKWD3Abn2oBJjFBfAd5DRHKjPBg3VoMXj53qX5
         yO3gz8vaKATj7fjjd4GlJ3aSR5N95Hoh5ZjEx8AzyfBXOmKKiGGKRXUGLZnyQgKWv6hg
         CFaw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Y8NoRlDvZ4aYGrxVpzfDJH9W6+Mk9LRhXEwjKDeImDzqAZNAYzMFa1Mk3paRMyJq66YqNKXSNj7pTLjvOE6hSMRZWzFbk1g0fxA=
X-Gm-Message-State: AOJu0YwO/Q7Ze36ploIRGjMqupWdySsPSFQktbDw2y5JOnxyKKxPlppR
	JuZpaircBLJg4ICTnAmvbr76oWoWmFm7N2ji0Q3M3HJ45NcYF1ChCyXMqqCQlJwr42iwubF4/0v
	i
X-Google-Smtp-Source: AGHT+IH37L863Lj4xRyrYfjVSskMCmLor8sZ3ZRWP8HciWFd0eXmPhUK2hjrR7Q7bAPMEmouVblvDQ==
X-Received: by 2002:a5d:9282:0:b0:7da:d6ff:7f53 with SMTP id s2-20020a5d9282000000b007dad6ff7f53mr5581984iom.0.1713886592565;
        Tue, 23 Apr 2024 08:36:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ja12-20020a056638888c00b0048569383229sm783480jab.121.2024.04.23.08.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:36:31 -0700 (PDT)
Message-ID: <1d4fb854-3151-41f5-b9a5-2a5cf2a37986@kernel.dk>
Date: Tue, 23 Apr 2024 09:36:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
 <715fd037-a8e5-4e62-939e-a446087eed2a@kernel.dk>
 <4530f039-0698-4cc0-94ab-5465d3f0e255@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4530f039-0698-4cc0-94ab-5465d3f0e255@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 9:16 AM, Damien Le Moal wrote:
> On 2024/04/24 0:21, Jens Axboe wrote:
>> On 4/20/24 1:58 AM, Damien Le Moal wrote:
>>> The submission of plugged BIOs is done using a work struct executing the
>>> function blk_zone_wplug_bio_work(). This function gets and submits a
>>> plugged zone write BIO and is guaranteed to operate on a valid zone
>>> write plug (with a reference count higher than 0) on entry as plugged
>>> BIOs hold a reference on their zone write plugs. However, once a BIO is
>>> submitted with submit_bio_noacct_nocheck(), the BIO may complete before
>>> blk_zone_wplug_bio_work(), with the BIO completion trigering a release
>>> and freeing of the zone write plug if the BIO is the last write to a
>>> zone (making the zone FULL). This potentially can result in the zone
>>> write plug being freed while the work is still active.
>>>
>>> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().
>>>
>>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>  block/blk-zoned.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 3befebe6b319..685f0b9159fd 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -526,6 +526,8 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
>>>  	struct blk_zone_wplug *zwplug =
>>>  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
>>>  
>>> +	flush_work(&zwplug->bio_work);
>>> +
>>>  	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
>>>  }
>>
>> This is totally backwards. First of all, if you actually had work that
>> needed flushing at this point, the kernel would bomb spectacularly.
>> Secondly, what's the point of using RCU to protect this, if you're now
>> needing to flush work from the RCU callback? That's a clear sign that
>> something is very wrong here with your references / RCU usage.. The work
>> item should hold a reference to it, trying to paper around it like this
>> is not going to work at all.
>>
>> Why is the work item racing with RCU freeing?!
> 
> The work item is a field of the zone write plug. Zone write plugs have
> references to them as long as BIOs are in flight and and the zone is
> not full. The zone write plug freeing through rcu is triggered by the
> last write to a zone that makes the zone full. But the completion of
> this last write BIO may happen right after the work issued the BIO
> with submit_bio_noacct_nocheck() and before blk_zone_wplug_bio_work()
> returns, while the work item is still active.
> 
> The actual freeing of the plug happens only after the rcu grace
> period, and I was not entirely sure if this is enough to guarantee
> that the work thread is finished. But checking how the workqueue code
> processes the work item by calling the work function
> (blk_zone_wplug_bio_work() in this case), there is no issue because
> the work item (struct work_struct) is not touched once the work
> function is called. So there are no issues/races with freeing the zone
> write plug. I was overthinking this. My bad. We can drop this patch.
> Apologies for the noise.

I took a closer look at the zone write plug reference handling, and it
still doesn't look very good. Why are some just atomic_dec and there's
just one spot that does dec_and_test? This again looks like janky
referencing, to be honest.

The relationship seems like it should be pretty clear. Any bio inflight
against this zone plug should have a reference to it, AND the owner
should have a reference to it, otherwise any bio completion (which can
happen at ANY time) could free it. Any dropping of the ref should use a
helper that does atomic_dec_and_test(), eg what disk_put_zone_wplug()
does.

There should be no doubt about the above at all. If the plug has been
added to a workqueue, it should be quite obvious that of course it has a
reference to it already, outside of the bio's that are in it.

I'd strongly encourage getting this sorted out before the merge window,
I'm not at all convinced it's correct as-is. It's certainly not
obviously correct, which it should be. The RCU rules are pretty simple
if the the references are done in the kernel idiomatic way, but they are
not.

-- 
Jens Axboe

