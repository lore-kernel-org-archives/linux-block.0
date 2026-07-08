Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33351991CB;
	Wed,  8 Jul 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504175; cv=none; b=RTrWg86ewshlVDSl32EurGYBFmLjH6emzY+LWJzuHVaVlC5PoUvkVess64PszuB/6GdstYfuNiu7iWqU/jEqSsJVAzryN1WWTsw/Am912kQShwId+gKQh1MSOKyiL0UgHKI4tezvW9uc/B9O35Ckl47acNmSjgGzX5xWJm+cJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504175; c=relaxed/simple;
	bh=Bbvbooug9ksNfIf0Q4PjtVcF0CcnK+CEJzW/KO4ywg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSe6NtkjrBZleXc1C2+5zDJXHvsL5ellP5/xVRTLhJAtM1S05LkdulM9Ctd7iYh6OJYeC2ImqWKHBTGRSU8hspVrFUjb4Mys9PDKeHEZTxP5GcPjHegaR8BSxK2fsqewlPAxcoXHuOjOmrz/FI9aSgps/w5iZHg9ukLvFzBNBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wp7Iglff; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wp7Iglff"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783504162; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JNgRgvf1+7hQQWJ1H0OO8n9K8Oex7OrYyU/TacLCQX4=;
	b=wp7IglffTemuX08QrhThhcL8E0do/Ek7LEvkwuF2MvnW2U3dXsbOJNcZBvKvK442WhN+2mXR14IHDeRfFGtLmFyvihR5AskaswZXCslDFUCJurAePup9Wd++0YK+d9E7+FF5OTajNbDCYzYkPfpGPHFkr3n63VYSpzh53KTs7is=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6hJdtT_1783504140;
Received: from 30.221.144.195(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6hJdtT_1783504140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 17:49:21 +0800
Message-ID: <b8b95aeb-8443-404b-a320-e3bd3fed1598@linux.alibaba.com>
Date: Wed, 8 Jul 2026 17:49:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bio_alloc_bioset() percpu cache fallback for
 non-reclaim contexts
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun@linux.alibaba.com>
References: <20260708011413.1710118-1-joseph.qi@linux.alibaba.com>
 <20260708084547.GA3591@lst.de>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260708084547.GA3591@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/26 4:45 PM, Christoph Hellwig wrote:
> On Wed, Jul 08, 2026 at 09:14:13AM +0800, Joseph Qi wrote:
>> This causes virtio-pmem flush (async_pmem_flush) to fail with -ENOMEM
>> whenever the percpu bio cache happens to be empty (common right after
>> boot), making the device effectively unmountable:
> 
> Please fix that to not sure GFP_ATOMIC instead.  Flushes are used
> in file system writeabck and must not use potential failing allocations.
> 
> Even if you slightly increase the chance of it not failing, it still
> can and this code is simply broken.
> 

Looks sane. So commit b520c4eef83d exposed the bug but not introduced it.

>> Fix this by restructuring the allocation so that the percpu cache is
>> tried first when applicable, and the slab allocation is always attempted
>> as a common fallback path when the bio is still NULL.
> 
> I don;
> 
>>
>> Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
>> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>> ---
>>  block/bio.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index f2a5f4d0a9672..9e7939861b94a 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -553,6 +553,11 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>>  		 */
>>  		opf |= REQ_ALLOC_CACHE;
>>  		bio = bio_alloc_percpu_cache(bs);
>> +		if (!bio) {
>> +			p = kmem_cache_alloc(bs->bio_slab, gfp);
>> +			if (p)
>> +				bio = p + bs->front_pad;
>> +		}
> 
> But even if we wanted this, this code should not be duplicated by
> share the common version.

This is because I want to keep REQ_ALLOC_CACHE set.
Thanks for comments. I'll try to fix it in virtio-pmem driver.

Thanks,
Joseph
