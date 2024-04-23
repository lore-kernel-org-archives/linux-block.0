Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBF13D8BA
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896386; cv=none; b=TW/y1t5/pB/roI1a2tXQPtUP+fGNuPLvDDKM04kDov+Wdcyh/smx07AW1v2WwvkpTAJVqbwNj4GfBBllaKVoOxbnS5pP925ckTIOjrlubM9I14zmOO8YnjLLMjgYm37JYSBYQ7fbBVdB0P/JHw4yudy0CuDZ4BzEsM8EX4o1nwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896386; c=relaxed/simple;
	bh=5GtsW/o+2Diu3fZ1ZwQ7Z9DcvB3qNbZmB2a/wKUP3Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SDKvMKsHrA1i85nnc+Ygg5gT37L8rhFU4D7P/K9AVLKvpDv8m2eBGpV2zm7RY00H5i9iyPmcxWzy+mlDJg8zlUy+EG4/rxGvh8/wlQsLfAOPZYFfTCTzkvDoVkT0atMfscWGeMl40SFMLyxJSizDMhHLtzcKAnxJxudYJhKG8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jcbw8p1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcbw8p1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C6DC2BD10;
	Tue, 23 Apr 2024 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713896385;
	bh=5GtsW/o+2Diu3fZ1ZwQ7Z9DcvB3qNbZmB2a/wKUP3Ow=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Jcbw8p1ykrrYedLQZb/rbWqEHLJtqITgq2qGNAfirchSG7PZowi0x1WAqZ8zftWps
	 YLcrA6GCBEmHsMK1sDNJa97q8N5QNTm0pouKc684giWAVmWuzoIJSZOp/TuZjZisXo
	 mWfF6DdhFImNpUJmYYqBfV14i+zwC+qGy+y6M45aRl4Ihz6pxxDlli+AzFg0w6uaL/
	 sospSm++cIZgaesIeIoy1Z964EBdvGXjEjGBJbbmtCyCVylxi71zrCFYWBS6qc4tN3
	 BQFQQeB+SPCOQSvxtlQp+/kb6ZMor9J6m/M9NFf4439jzx+iSLbyJ2eMoNgFXGIcix
	 v88ANRODrzXWg==
Message-ID: <61ff5a29-9b16-4a52-b0ae-cfba2ea3c748@kernel.org>
Date: Wed, 24 Apr 2024 04:19:43 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
 <715fd037-a8e5-4e62-939e-a446087eed2a@kernel.dk>
 <4530f039-0698-4cc0-94ab-5465d3f0e255@kernel.org>
 <1d4fb854-3151-41f5-b9a5-2a5cf2a37986@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1d4fb854-3151-41f5-b9a5-2a5cf2a37986@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/24 1:36, Jens Axboe wrote:
> On 4/23/24 9:16 AM, Damien Le Moal wrote:
>> On 2024/04/24 0:21, Jens Axboe wrote:
>>> On 4/20/24 1:58 AM, Damien Le Moal wrote:
>>>> The submission of plugged BIOs is done using a work struct executing the
>>>> function blk_zone_wplug_bio_work(). This function gets and submits a
>>>> plugged zone write BIO and is guaranteed to operate on a valid zone
>>>> write plug (with a reference count higher than 0) on entry as plugged
>>>> BIOs hold a reference on their zone write plugs. However, once a BIO is
>>>> submitted with submit_bio_noacct_nocheck(), the BIO may complete before
>>>> blk_zone_wplug_bio_work(), with the BIO completion trigering a release
>>>> and freeing of the zone write plug if the BIO is the last write to a
>>>> zone (making the zone FULL). This potentially can result in the zone
>>>> write plug being freed while the work is still active.
>>>>
>>>> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().
>>>>
>>>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>> ---
>>>>  block/blk-zoned.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>> index 3befebe6b319..685f0b9159fd 100644
>>>> --- a/block/blk-zoned.c
>>>> +++ b/block/blk-zoned.c
>>>> @@ -526,6 +526,8 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
>>>>  	struct blk_zone_wplug *zwplug =
>>>>  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
>>>>  
>>>> +	flush_work(&zwplug->bio_work);
>>>> +
>>>>  	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
>>>>  }
>>>
>>> This is totally backwards. First of all, if you actually had work that
>>> needed flushing at this point, the kernel would bomb spectacularly.
>>> Secondly, what's the point of using RCU to protect this, if you're now
>>> needing to flush work from the RCU callback? That's a clear sign that
>>> something is very wrong here with your references / RCU usage.. The work
>>> item should hold a reference to it, trying to paper around it like this
>>> is not going to work at all.
>>>
>>> Why is the work item racing with RCU freeing?!
>>
>> The work item is a field of the zone write plug. Zone write plugs have
>> references to them as long as BIOs are in flight and and the zone is
>> not full. The zone write plug freeing through rcu is triggered by the
>> last write to a zone that makes the zone full. But the completion of
>> this last write BIO may happen right after the work issued the BIO
>> with submit_bio_noacct_nocheck() and before blk_zone_wplug_bio_work()
>> returns, while the work item is still active.
>>
>> The actual freeing of the plug happens only after the rcu grace
>> period, and I was not entirely sure if this is enough to guarantee
>> that the work thread is finished. But checking how the workqueue code
>> processes the work item by calling the work function
>> (blk_zone_wplug_bio_work() in this case), there is no issue because
>> the work item (struct work_struct) is not touched once the work
>> function is called. So there are no issues/races with freeing the zone
>> write plug. I was overthinking this. My bad. We can drop this patch.
>> Apologies for the noise.
> 
> I took a closer look at the zone write plug reference handling, and it
> still doesn't look very good. Why are some just atomic_dec and there's
> just one spot that does dec_and_test? This again looks like janky
> referencing, to be honest.
> 
> The relationship seems like it should be pretty clear. Any bio inflight
> against this zone plug should have a reference to it, AND the owner
> should have a reference to it, otherwise any bio completion (which can
> happen at ANY time) could free it. Any dropping of the ref should use a
> helper that does atomic_dec_and_test(), eg what disk_put_zone_wplug()
> does.
> 
> There should be no doubt about the above at all. If the plug has been
> added to a workqueue, it should be quite obvious that of course it has a
> reference to it already, outside of the bio's that are in it.
> 
> I'd strongly encourage getting this sorted out before the merge window,
> I'm not at all convinced it's correct as-is. It's certainly not
> obviously correct, which it should be. The RCU rules are pretty simple
> if the the references are done in the kernel idiomatic way, but they are
> not.

OK. I am traveling this week so I will not be able to send a well-tested cleanup
patch but I will do so first thing next week.

-- 
Damien Le Moal
Western Digital Research

