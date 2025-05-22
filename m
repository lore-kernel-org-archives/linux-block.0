Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777618A6A9;
	Thu, 22 May 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938790; cv=none; b=EJ0O/KpodwFfQyULcpadawFsAuE3QKwnUZPWGZeLbpWOVkxqP7ZsdiB/5ZrFUYUHt3xIqJJmNrEAJ4jEzHoKhLxA7G0wuAOMl0VjtZGKBUJ09iMkbtVAMF2sHt5ej3o3Q+BQQVRxE/jhnw+k5+jjeGAUVGkHwijz8RiGe6BAl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938790; c=relaxed/simple;
	bh=A1CM1UT8eyKoapBImWZbslUoKgIEwhx1xqKnm7PuNKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxfyFW6C7m++wZAvlr567byyaHowPxc6XwbMU22Y6Nv9jAgPm3TFyjVwFdBu113OKe1eJVdO8kJVLPaFcy+eQnhG2guXWajrJy1YRbSbu/zH424JTpIqgSpESSGqxqrADMq61LK971iK4r/ZPN8fIjHTl0/LQj+zb7m9nTwij9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=p/FCFG81; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="p/FCFG81"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3H3R4LPJzltKlX;
	Thu, 22 May 2025 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747938785; x=1750530786; bh=szHamrwcfSf7BkvqV7I/EzTn
	cjeyELQbcBe4C+Nv5Wg=; b=p/FCFG81N/lSCqDoFBHSeGx529D2jas4HePtiwzi
	oMjpUXnaJSw56fxLd85P0vboJ4ZrHUEpXgFxhL/iWDtzJSTQpefw+95qAfa0NUNa
	fCJ0BpEfuR1GOV8RA5jL1ydOZNyhPtWLWK/bt5kHWBeqS+SNTBqN6YrdIaiKXFKM
	/a9rweQmmCWP2TxyClx068l6BEaa4m04vxEwOkGuSHHK9jZ9ryo8xRfNRMjUwilr
	t0Yor6O6NuP7mdUVQ+r8aLl72eVvybOwz1y0D4I9VJI5iRqS1jjncZ8ICTMlcCwe
	05Co6FMk7EiTl8xmggCGuY6/BHDcn1Spg+70fPEhRNouDg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6pAl_gxbm_C9; Thu, 22 May 2025 18:33:05 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3H3J23SCzlvhyX;
	Thu, 22 May 2025 18:32:59 +0000 (UTC)
Message-ID: <78244478-3ce3-4671-b28f-c67c5b21dba9@acm.org>
Date: Thu, 22 May 2025 11:32:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 10:38 AM, Jens Axboe wrote:
> On 5/22/25 11:14 AM, Bart Van Assche wrote:
>>   static void __submit_bio(struct bio *bio)
>>   {
>>   	/* If plug is not used, add new plug here to cache nsecs time. */
>> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>>   
>>   	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>>   		blk_mq_submit_bio(bio);
>> -	} else if (likely(bio_queue_enter(bio) == 0)) {
>> +	} else {
>>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>> +		bool zwp = bio_zone_write_plugging(bio);
>> +
>> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
>> +			goto finish_plug;
>>   	
>>   		if ((bio->bi_opf & REQ_POLLED) &&
>>   		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
>> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>>   		} else {
>>   			disk->fops->submit_bio(bio);
>>   		}
>> -		blk_queue_exit(disk->queue);
>> +
>> +		if (!zwp)
>> +			blk_queue_exit(disk->queue);
>>   	}
> 
> This is pretty ugly, and I honestly absolutely hate how there's quite a
> bit of zoned_whatever sprinkling throughout the core code. What's the
> reason for not unplugging here, unaligned writes? Because you should
> presumable have the exact same issues on non-zoned devices if they have
> IO stuck in a plug (and doesn't get unplugged) while someone is waiting
> on a freeze.
> 
> A somewhat similar case was solved for IOPOLL and queue entering. That
> would be another thing to look at. Maybe a live enter could work if the
> plug itself pins it?

Hi Jens,

q->q_usage_counter is not increased for bios on current->plug_list.
q->q_usage_counter is increased before a bio is added to the zoned 
pluglist. So these two cases are different.

I think it is important to hold a q->q_usage_counter reference for bios
on the zoned plug list because bios are added to that list after bio
splitting happened. Hence, request queue limits must not change while
any bio is on the zoned plug list.

Damien, do you think it would be possible to add a bio to the zoned plug
list before it is split and not to hold q->q_usage_counter for bios on
the zoned plug list?

Thanks,

Bart.
