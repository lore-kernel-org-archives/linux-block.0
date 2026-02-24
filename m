Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA635207A20
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898922; cv=none; b=B7FIKZt+kdZ0MxvmfJjbZ/M7Zmy4UcE1Lufy4kt3bLYMcxnC7M/voM0DX8xfZ8qdnea5rg86XpxU3APgr6IFdEc5YUCC6KaErRjwkmbcY5IV1oiKzvj/WpaW8rbIBEIiNR7eWMw50FFenZ19MnapwP2bYqxT9XpFwafGn/6ySJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898922; c=relaxed/simple;
	bh=OHE7UEPTR/lcJ2wvylF9W247yZjkErWMSjxNhxTKULI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SPGdAadd3MqSMGfupS69fM8jhp/XY03adfzdF2FAwNJzs1kZq6gPp2dxiX/qE0wndAKNvM8mI3eoY7QLww5Tkc/wT9z2Wj6g+uIV5kqMisxMOisIGpehknqK50eoeQbx0wfnVkNN43tu8LmrjJqZFB8Bop0HVf1f6trZDlF/P+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goGpv3TY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goGpv3TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31304C116C6;
	Tue, 24 Feb 2026 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898921;
	bh=OHE7UEPTR/lcJ2wvylF9W247yZjkErWMSjxNhxTKULI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=goGpv3TY0pjd3BQ0KtBk+aHW3vnMv6v9kECpSbURU8AWqkzburK3D1RsiAy8QmHov
	 33cpFadvbgfLA6QttMAeizP6WIfpfVUpenCeT8efzgaWa2rCBSU5F/8Hnu8Z2B73aY
	 JpjC+1/2oidRisXhG1Wf267Cs1N670lK8ysfaUff26RGY/L7Pw9SDyeqs1gcyvK9iH
	 YN6KBTffhTUYtkJUoLNxoCL5XMxUtkhbXnJFe2i06uECwa2x5oUl/9IxxjcJW1uILR
	 NShTuctFo3u0DG8GTCIT/KJCY7LNjQTdF2iHtSW2ey5FbLAkd6ouHBnNnaGgwq+4pB
	 4DM0yIZBaKwkw==
Message-ID: <1ce157d7-31fe-4a32-8acf-ed337dc1a52f@kernel.org>
Date: Tue, 24 Feb 2026 11:03:24 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-5-dlemoal@kernel.org>
 <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/23/26 8:59 PM, Hannes Reinecke wrote:
> On 2/21/26 01:44, Damien Le Moal wrote:
>> The function disk_zone_wplug_schedule_bio_work() always takes a
>> reference on the zone write plug of the BIO work being scheduled. This
>> ensure that the zone write plug cannot be freed while the BIO work is
>> being scheduled but has not run yet. However, this unconditional
>> reference taking is fragile since the reference taken is realized by the
>> BIO work blk_zone_wplug_bio_work() function, which implies that there
>> always must be a 1:1 relation between the work being scheduled and the
>> work running.
>>
>> Make this less fragile by taking the reference on the BIO work if and
>> only if the BIO work has not been already scheduled.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   block/blk-zoned.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index c5c91f927a71..4b388ae1acaa 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -1205,13 +1205,15 @@ static void disk_zone_wplug_schedule_bio_work(struct
>> gendisk *disk,
>>       lockdep_assert_held(&zwplug->lock);
>>         /*
>> -     * Take a reference on the zone write plug and schedule the submission
>> -     * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
>> -     * reference we take here.
>> +     * Schedule the submission of the next plugged BIO. If the zone write
>> +     * plug BIO work is not already scheduled, take a reference on the zone
>> +     * write plug to ensure that it does not go away while the work is being
>> +     * scheduled but has not run yet. blk_zone_wplug_bio_work() will release
>> +     * the reference we take here.
>>        */
>>       WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
>> -    refcount_inc(&zwplug->ref);
>> -    queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
>> +    if (queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
>> +        refcount_inc(&zwplug->ref);
>>   }
>>     static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
> 
> Urgh. Don't.
> There is a race condition; 'bio_work' might be scheduled directly and
> complete before 'refcount_inc()' is called.
> You have to invert the statement by keeping the 'refcount_inc()'
> before calling 'queue_work()', and then drop the reference again
> if queue_work failed.
> Ugly, I know.

As Bart pointed out, since this is done with the zone write plug spinlock held
and the work takes that lock first when it runs, there is no chance that the
refcount gets bad. That is indeed not super clear though, so I will imrove the
comment to describe that.

Note: the zone write plug refcounting is a bit a mess and needs cleaning up,
which I was planning to do on top of all this.


-- 
Damien Le Moal
Western Digital Research
