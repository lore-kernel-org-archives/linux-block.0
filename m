Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BA1EB9F2
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898568; cv=none; b=daT3wu3qjTMc/TKGDl7lZ6rl7CHEBk8dOfQu0yiWfqMqqnD1b2kTw+0bhSRjixF0bPXp0gigWf6Y2balIl8cTewOJBTnfKtmuKDxePO2JX0n/ris8onxtBoi/Vieiil0Ir32WXoNuSF76TI2msQrDs5OYvCKjuVQ0YPFiSY+A2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898568; c=relaxed/simple;
	bh=EZ+y7mXBpd9O4iXYm1C5x0cCB4Aiy9JSOa0cJyCwvGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyzNfQJqfUW5AYcRZyzcNcg9vvwl62M62qh74+lKC1k1WGX73zRi7M3HTYJQg0jPP4Lan5Lrnm2khl8JjqTOdMwb9tJ44faM6tVq0YP6CQ2k4VbhZ2mOMUf7LFczAxQeu2+sUY8bQSpDwUJ+fvQ7P4Q4oWXJepLWRUGzD+g10f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY//onz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY//onz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5460CC116C6;
	Tue, 24 Feb 2026 02:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898567;
	bh=EZ+y7mXBpd9O4iXYm1C5x0cCB4Aiy9JSOa0cJyCwvGA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sY//onz+pqwWuXlc0IBYWKhKT3fbxNoXf7jh5Xf/4BwkNVhfp66eA5iASeE1AzVyc
	 XKS2HUIDFmeyWTKgckaCZRiWtq5lv141NCX36k3haJgxdrYD+XgeBAMN7fUxecjm4Q
	 mnxkE/pPSzsRo9zS0yeyRZwXs0IeVtcBxRnvVCwSXRP7jGQHNx6x+bqATv/gc4WXQF
	 rJNZuv+gvhvE9eMQYjc6uwnIIiXR1GvwuxQ6G/nEfedqvvr0UmVMd/RTVYOaMn9xGE
	 0oRejveSDjlr9qsd6uoLaAuHHf5+kWsNaBn4Ae4CyVK3DbMNkBM/fnU1ttRCfE4jfn
	 keQOznxBwtGQQ==
Message-ID: <3a8fdb1f-db52-4264-b9c4-e8339c719dc4@kernel.org>
Date: Tue, 24 Feb 2026 10:57:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix zone write plug removal
To: Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-2-dlemoal@kernel.org>
 <ab25a49b-0732-4d0e-94b7-1785934a1a5e@suse.de>
 <ed42e14c-6378-48f2-891c-87463a6ee9eb@acm.org>
 <03e14c32-8592-421f-992a-84301d1ec692@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <03e14c32-8592-421f-992a-84301d1ec692@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/26 5:21 AM, Bart Van Assche wrote:
> On 2/23/26 11:30 AM, Bart Van Assche wrote:
>> On 2/23/26 3:56 AM, Hannes Reinecke wrote:
>>> On 2/21/26 01:44, Damien Le Moal wrote:
>>>> +static inline void disk_check_and_put_zone_wplug(struct blk_zone_wplug
>>>> *zwplug)
>>>> +{
>>>> +    lockdep_assert_not_held(&zwplug->lock);
>>>> +
>>>> +    /*
>>>> +     * Check for the need to remove the zone write plug from the hash list
>>>> +     * when we see that only the caller is referencing the zone write plug.
>>>> +     * Since this is racy without holding the zone write plug lock, this
>>>> +     * check is done again in  disk_should_remove_zone_wplug().
>>>> +     */
>>>> +    if (refcount_read(&zwplug->ref) <= 2) {
>>>> +        struct gendisk *disk = zwplug->disk;
>>>> +        unsigned long flags;
>>>> +
>>>> +        spin_lock_irqsave(&zwplug->lock, flags);
>>>> +        if (disk_should_remove_zone_wplug(disk, zwplug))
>>>> +            disk_remove_zone_wplug(disk, zwplug);
>>>> +        spin_unlock_irqrestore(&zwplug->lock, flags);
>>>> +    }
>>>> +
>>>> +    disk_put_zone_wplug(zwplug);
>>>> +}
>>>> +
>>>>   static void blk_zone_wplug_bio_work(struct work_struct *work);
>>>>   /*
>>>
>>> This looks slightly odd; a simple 'refcount_read()' always trigger alarm
>>> bells with me as it inevitably races with 'refcount_dec()' /
>>> 'refcount_inc()'.
>>> And similar the check 'refcount <= 2' also looks odd; typically one
>>> would check against '< 1' and let the refcount destructor handle
>>> things.
>> Hmm ... I think that the above code is racy. Here is an example:
>>
>> thread 1                                thread 2
>> -------------------------------         -------------------------------
>> refcount_read() returns 3               refcount_read() returns 3
>>
>> disk_should_remove_zone_wplug() is      disk_should_remove_zone_wplug()
>> is not called                           is not called
>>
>> disk_put_zone_wplug() decreases         disk_put_zone_wplug() decreases
>> zwplug->ref from 3 to 2                 zwplug->ref from 2 to 1
>>
>>
>> Result: zwplug->ref became less than 2 without
>> disk_should_remove_zone_wplug() having been called.
> 
> A correction to the above: three threads are required before it becomes
> possible for the zwplug reference count to drop from 3 to zero without
> disk_should_remove_zone_wplug() having been called.

I do not see how your example is possible... If refcount read are form the BIO
work context, we only have one per zone, so there is not such concurrency.
The additional contexts can be from zone reset or zone finish, but these
unconditionally call disk_should_remove_zone_wplug(), so there is no such race.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
