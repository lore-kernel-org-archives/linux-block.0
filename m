Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D42264D5;
	Tue,  9 Sep 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436039; cv=pass; b=nC+G4EaYH68DWm+x/An/uaw1mT9QtAMAMm9k8xmIUGK4Hbo0sQC61ozJTQOhmk72I2xhBMvYrpW5FoqeAzOlGtWh3VhTXmWWpSXm6l68i2xnDSuEyHVcKJVPGzJD1XY7pgB0N94vgOlYSx2UDRbAyLQQkbhR3fxQoS/ELRtjqXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436039; c=relaxed/simple;
	bh=xwTdNVGntl/WyiRwz22zt6mGRkZoq8qi1F558qxpero=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7sCUszTP+fWObkJ1pvYmaX3BT5IUwr7Kuz71gqZOAYu0KZz4j1E73zKGn+heSygUnYusbaGBmKezHtjyly2WKlGvYHgVeqBRQdii9386LX/tx4vq/0cxV37mHgSEldHPgDWu5E1EQI0+m4zN254kWbg9XR0z9XgRHUUgxrPIzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=B8ouFWqd; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="B8ouFWqd"
ARC-Seal: i=1; a=rsa-sha256; t=1757436015; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gv8GV6rRG5Jb7hAWqmD5ER/1d0mM+JfKw4xpPZh/0s3Y8i5a0+dRuCKjJn7RnoMhhxfV3MU8fKccj6fpIhMrOFA/ZfxDAHN6xf+yHkZnrXSKLVBZekbDNlwM3oiwMpaGm5KvqymORB8Emy1KL7ssXEtiktms8R8Y+u5S8jTGWvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757436015; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9vrgL/+kl5uyRE7ByyiVzWPCWsoDk4jEde9g5wb1A1U=; 
	b=Px4Vw/MDfw5WjuFFc7IVut3/hNzvGfL4oLuPYFBokhmXJPrxj06cC7e0L+jxG3DjMHRwsWstRWwpIVAraHJFC9bDbPZ3t1qi2iD011LsUMkDcPh3O80mZDn8RQT96hQWUvOrcoKhs0wbA8gH78G+vnjwhblUK2VxeDS1bNzqK7M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757436015;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9vrgL/+kl5uyRE7ByyiVzWPCWsoDk4jEde9g5wb1A1U=;
	b=B8ouFWqdqV24DmFpiBjIG+kCuima/iaHEv/2NfNqJFVF5V15pIuffzHoJrpUw6GC
	jsCpJ1KWLloFKG7rSZHztEuvS07dYWt+frL4WI50D7cBuWi4+y33ArbRA74fFKuuWtk
	PubcA6IOut8JxwwcNW0zLkG71pmV4ZJSysRQ1+Dc=
Received: by mx.zohomail.com with SMTPS id 1757436012464672.9661036833609;
	Tue, 9 Sep 2025 09:40:12 -0700 (PDT)
Message-ID: <8ab0b2e2-a3da-43b1-9fb8-141e85aee3b2@yukuai.org.cn>
Date: Wed, 10 Sep 2025 00:39:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 06/10] blk-mq: split bitmap grow and resize
 case in blk_mq_update_nr_requests()
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-7-yukuai1@huaweicloud.com>
 <85259339-d832-468a-a9b0-0c326c896370@linux.ibm.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <85259339-d832-468a-a9b0-0c326c896370@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/9 20:18, Nilay Shroff 写道:
>
> On 9/8/25 11:45 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> No functional changes are intended, make code cleaner and prepare to fix
>> the grow case in following patches.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq.c | 28 ++++++++++++++++------------
>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 1ff6370f7314..82fa81036115 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4931,21 +4931,25 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>   			blk_mq_tag_update_sched_shared_tags(q);
>>   		else
>>   			blk_mq_tag_resize_shared_tags(set, nr);
>> -	} else {
>> +	} else if (!q->elevator) {
>>   		queue_for_each_hw_ctx(q, hctx, i) {
>>   			if (!hctx->tags)
>>   				continue;
>> -			/*
>> -			 * If we're using an MQ scheduler, just update the
>> -			 * scheduler queue depth. This is similar to what the
>> -			 * old code would do.
>> -			 */
>> -			if (hctx->sched_tags)
>> -				ret = blk_mq_tag_update_depth(hctx,
>> -							&hctx->sched_tags, nr);
>> -			else
>> -				ret = blk_mq_tag_update_depth(hctx,
>> -							&hctx->tags, nr);
>> +			sbitmap_queue_resize(&hctx->tags->bitmap_tags,
>> +				nr - hctx->tags->nr_reserved_tags);
>> +		}
>> +	} else if (nr <= q->elevator->et->nr_requests) {
>> +		queue_for_each_hw_ctx(q, hctx, i) {
>> +			if (!hctx->sched_tags)
>> +				continue;
>> +			sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
>> +				nr - hctx->sched_tags->nr_reserved_tags);
>> +		}
>> +	} else {
>> +		queue_for_each_hw_ctx(q, hctx, i) {
>> +			if (!hctx->sched_tags)
>> +				continue;
>> +			blk_mq_tag_update_depth(hctx, &hctx->sched_tags, nr);
>>   			if (ret)
>>   				goto out;
>>   		}
> The above code is good however can this be bit simplified?
> It's a bit difficult to follow through all nesting and so
> could it be simplified as below:
>
> if (shared-tags) {
>      if (elevator)
>         // resize sched-shared-tags bitmap
>      else
>         // resize shared-tags bitmap
> } else {
>      // non-shared tags
>      if (elevator) {
>          if (new-depth-is-less-than-the-current-depth)
>              // resize sched-tags bitmap
>          else
>              // handle sched tags grow
>      } else
>          // resize tags bitmap
> }

AFAIK, if - else if chain should be better than nested if - else, right?

If you don't mind, I can add comments to each else if chain to make code cleaner:

if () {
	/* shared tags */
	...
} else if () {
	/* non-shared tags and elevator is none */
	...
} else if () {
	/* non-shared tags and elevator is not none, nr_requests doesn't grow */
	...
} else () {
	/* non-shared tags and elevator is not none, nr_requests grow */
	...
}

Thanks,
Kuai

>
> Thanks,
> --Nilay
>
>
