Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9C17A2F6;
	Fri, 23 May 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747980403; cv=none; b=sKW+9ypYhw5L1lGKWMWpUZEI9knMx2IWUGTyDgsxtEopxt4yi892P3N6liuhqTg5wIk35wqPFxhNVvTYHMocPIPMwXvKRCY+IQOYvOr270Mc0hRZhlwsgu0ye/LFxBNXsu72Bz+HyfUmbPQEsG1imZlJ+myRqRB2UkOCc1flM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747980403; c=relaxed/simple;
	bh=92eAN8csFAkBa/h97hweMHUpwVrSxLPQX1gSWGO2pWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wxehl+zWc3CRXi3vq5b6dkOuIRhYrho4ymMn1Ip4DPjdegRAjjzuGmtIPPGt2pxhI8ZqPtIxxbq1++Jfz4I5x+r3zU3EwY9ZEhjgbZvRgvNRNXsGGLT+x+eOERoHkByz6RvPKkueryauy3CLsWWhkeDHubq+M6SkEcQPaBxAwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV2yyoTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV2yyoTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADFBC4CEE9;
	Fri, 23 May 2025 06:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747980402;
	bh=92eAN8csFAkBa/h97hweMHUpwVrSxLPQX1gSWGO2pWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GV2yyoTcTNGOfgbctyC/bsDUvh2PxzfK82GvxAZCWIDAiQ8/QTwHAG9ObjB7i79Ep
	 CdCAElfDbdDvfLiowQ06KQ4DzBrxocBU82de6MVyf5V6nIn9Ey0rbfsiT5aF2v/BfR
	 a8W8m+nw+4oWIE/hdC41oodBoLfdQSH1lziEH1+YVI7aDfvSFTtqBYs9w+EE6ZWTmc
	 gAqeEx3UCHFHL3WOypXeaSaFFpjmlZ/BeXIiQBlr8OX/XNHRLMFQd7NlEVhIEfE+Dn
	 TNLZ3lOAaafvqj+qGTBKDXOTHPCVEZFcaqDgiFADwz9gZ1lv3C/fi4LP+Pq91TaUl8
	 mwYDDFy1EVyBQ==
Message-ID: <1359a818-f95f-4827-9f8a-7e5f362b8e87@kernel.org>
Date: Fri, 23 May 2025 08:06:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>,
 stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <78244478-3ce3-4671-b28f-c67c5b21dba9@acm.org> <aC_ZFIICdxzSOxCt@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aC_ZFIICdxzSOxCt@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 04:10, Ming Lei wrote:
> On Thu, May 22, 2025 at 11:32:58AM -0700, Bart Van Assche wrote:
>> On 5/22/25 10:38 AM, Jens Axboe wrote:
>>> On 5/22/25 11:14 AM, Bart Van Assche wrote:
>>>>   static void __submit_bio(struct bio *bio)
>>>>   {
>>>>   	/* If plug is not used, add new plug here to cache nsecs time. */
>>>> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>>>>   	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>>>>   		blk_mq_submit_bio(bio);
>>>> -	} else if (likely(bio_queue_enter(bio) == 0)) {
>>>> +	} else {
>>>>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>>>> +		bool zwp = bio_zone_write_plugging(bio);
>>>> +
>>>> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
>>>> +			goto finish_plug;
>>>>   	
>>>>   		if ((bio->bi_opf & REQ_POLLED) &&
>>>>   		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
>>>> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>>>>   		} else {
>>>>   			disk->fops->submit_bio(bio);
>>>>   		}
>>>> -		blk_queue_exit(disk->queue);
>>>> +
>>>> +		if (!zwp)
>>>> +			blk_queue_exit(disk->queue);
>>>>   	}
>>>
>>> This is pretty ugly, and I honestly absolutely hate how there's quite a
>>> bit of zoned_whatever sprinkling throughout the core code. What's the
>>> reason for not unplugging here, unaligned writes? Because you should
>>> presumable have the exact same issues on non-zoned devices if they have
>>> IO stuck in a plug (and doesn't get unplugged) while someone is waiting
>>> on a freeze.
>>>
>>> A somewhat similar case was solved for IOPOLL and queue entering. That
>>> would be another thing to look at. Maybe a live enter could work if the
>>> plug itself pins it?
>>
>> Hi Jens,
>>
>> q->q_usage_counter is not increased for bios on current->plug_list.
>> q->q_usage_counter is increased before a bio is added to the zoned pluglist.
>> So these two cases are different.
>>
>> I think it is important to hold a q->q_usage_counter reference for bios
>> on the zoned plug list because bios are added to that list after bio
>> splitting happened. Hence, request queue limits must not change while
>> any bio is on the zoned plug list.
> 
> Hi Bart,
> 
> Can you share why request queue limit can't be changed after bio is added
> to zoned plug list?

Because BIOs on a zone write plug list have already been split according to the
current request queue limits. So until these BIOs are executed, we cannot change
the limits as that potentially would require again splitting and that would
completely messup the zone write pointer tracking of zone write plugging.

> If it is really true, we may have to drain zoned plug list when freezing
> queue.

Yes, that is what we need. But we currently endup deadlocking on a queue freeze
because the internal issuing of plugged zone write BIOs uses
submit_bio_noacct_nocheck() which calls __submit_bio() and that function will
call blk_queue_enter() again for DM device BIOs. We need to somehow cleanly
avoid calling that queue enter without sprinkling around lots of zone stuff in
this core block layer submission path.

> 
> 
> Thanks, 
> Ming
> 


-- 
Damien Le Moal
Western Digital Research
