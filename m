Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FF18DB2A;
	Fri, 23 May 2025 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979587; cv=none; b=n4gky6EhNKTU8OU4oBQDc8NDdCFJ1HQ7qdYMM7ErMvND1Tfp8PmHOixeps37j5q01hRu1FGqlM5dsFVTKkllU8br+aAkNr58eEYBNdAOGbuiGYb4dHU3psuwyel1vc+Z7QWf+okMUhDnIdel6f9ldz3O1C50JMZSie/NBVwkED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979587; c=relaxed/simple;
	bh=TZtcOVJD106ONf55ILWcQmCjZ1I1g5TU9bCQr3FdEEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMQ/CH7/wKrP36GBGN175an7xjAaDHX/PnzX9MerH0tYWDCq23gTbposUDiklCbV8QAQ30HtN1bqQrhWXLV+ZqMRXEBE6Hh5jpqP1mvsxYfttdfFBaHuzKFMnEYlFlWur2Q3jvT44jjXRqO/ui4tcGZIcsWMWdnF+QGhAEkTluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ5m5Q9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ5m5Q9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB45C4CEE9;
	Fri, 23 May 2025 05:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747979585;
	bh=TZtcOVJD106ONf55ILWcQmCjZ1I1g5TU9bCQr3FdEEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uZ5m5Q9vbh8N+4SskrqIaukJokVO5ITtbX0mutMrUaUKD7/RNXyKFb3JWLQowYTW5
	 Os2Bd7ALpsCRCPG7FjUyL/ESbWrXl517imZMfCO18WdMbNXW1gRK7xYsrrEYgKYryY
	 8KnRKwkyIJDjfU2h6Gu+TNNU2sfhhkcmg+hsAlRhOON+aE8yQlKWskoIrQ7qeYgLTM
	 kP7XL120FTGQoYFcHeZczTEddWqM42IhuHz91Tq52HhmUM8Qa+GbCndvzpOEJLmB4p
	 CJzjTGfz6dPb3lzaOOOHGmHSTEhFZ2HX59g3oyrGpCM4H8ibv7IXGKyzCRFkhX8CjE
	 N3E+wj1XaiJeg==
Message-ID: <89b84e64-21d1-47cc-9501-44e896917152@kernel.org>
Date: Fri, 23 May 2025 07:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <78244478-3ce3-4671-b28f-c67c5b21dba9@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <78244478-3ce3-4671-b28f-c67c5b21dba9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 20:32, Bart Van Assche wrote:
> On 5/22/25 10:38 AM, Jens Axboe wrote:
>> On 5/22/25 11:14 AM, Bart Van Assche wrote:
>>>   static void __submit_bio(struct bio *bio)
>>>   {
>>>   	/* If plug is not used, add new plug here to cache nsecs time. */
>>> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>>>   
>>>   	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>>>   		blk_mq_submit_bio(bio);
>>> -	} else if (likely(bio_queue_enter(bio) == 0)) {
>>> +	} else {
>>>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>>> +		bool zwp = bio_zone_write_plugging(bio);
>>> +
>>> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
>>> +			goto finish_plug;
>>>   	
>>>   		if ((bio->bi_opf & REQ_POLLED) &&
>>>   		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
>>> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>>>   		} else {
>>>   			disk->fops->submit_bio(bio);
>>>   		}
>>> -		blk_queue_exit(disk->queue);
>>> +
>>> +		if (!zwp)
>>> +			blk_queue_exit(disk->queue);
>>>   	}
>>
>> This is pretty ugly, and I honestly absolutely hate how there's quite a
>> bit of zoned_whatever sprinkling throughout the core code. What's the
>> reason for not unplugging here, unaligned writes? Because you should
>> presumable have the exact same issues on non-zoned devices if they have
>> IO stuck in a plug (and doesn't get unplugged) while someone is waiting
>> on a freeze.
>>
>> A somewhat similar case was solved for IOPOLL and queue entering. That
>> would be another thing to look at. Maybe a live enter could work if the
>> plug itself pins it?
> 
> Hi Jens,
> 
> q->q_usage_counter is not increased for bios on current->plug_list.
> q->q_usage_counter is increased before a bio is added to the zoned 
> pluglist. So these two cases are different.
> 
> I think it is important to hold a q->q_usage_counter reference for bios
> on the zoned plug list because bios are added to that list after bio
> splitting happened. Hence, request queue limits must not change while
> any bio is on the zoned plug list.
> 
> Damien, do you think it would be possible to add a bio to the zoned plug
> list before it is split and not to hold q->q_usage_counter for bios on
> the zoned plug list?

I do not think this is the right thing to do as that will completely mess up the
queue usage counter value with regard to submit_bio() calls. That value is
incremented when a BIO is submitted, and that should stay the same for zoned
write BIOs that endup in a zone write plug instead of going straigth to the device.

The issue comes from the fact that blk_zone_wplug_bio_work() calls
submit_bio_noacct_nocheck() which eventually calls __submit_bio() and that
function calls blk_queue_enter() for DM devices. We still need to preserve that
for the first submission of the BIO but should not/do not need to do the
blk_queue_enter() call again when a BIO is submitted via the zone write plug
work. I am not sure yet how to  best deal with that.

I am traveling today and will not have time to cook something. Will take a look
over the weekend.


-- 
Damien Le Moal
Western Digital Research
