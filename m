Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2B185B52
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590622; cv=none; b=CxkjnvmBDW9oPrQXAnlRHZiW2T+B3AkGBZYV7CHr6HOtXvZT4mfKNV1xqFzHHsP3xq4lGqufrukFLS27Jty41xlxogXoBmkexWkUQGCeYFYPmPmWO3M5Y+K4+3co8dkvOb63DMeUk5nU0aNjvjGjt/ml+3H92zYr5XQIqF0axrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590622; c=relaxed/simple;
	bh=+AYSP8Iks0rfQFv9IxI04uwjRGftLRsEP71GVxeE45E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYBZF3Evh1WobK2Wn4hUydINK0nvXWH28dzIV2tmPLOSMfoiwPwWOiayiq5FTzipEL4JFfP4nDpZ5t2Ze+sVJzQthypB9tmUQCoQf/VUoRa4geLJFCNx8nBSapCjGM+1gyi1MBWJ4qi8rIK0AwKIpFvdlMovuu+gSl6nemM3yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MyAv6M6z; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MyAv6M6z"
Message-ID: <df22ea76-f123-4d27-a6ad-e217259a13ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726590613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5Ya9iuPd9IkAM5QyBlkxjJ8I+vb80CLXkQAfeniDks=;
	b=MyAv6M6zCA97kWp6nDjqcuGq8WknhSt5x9diJk6Pdua4KmJwmk+dcpeOAPWR8kZd/hSlBa
	Ac52o2G7XaP2wOEKkUEQzBJ6KYlcrxBVxCXXzRjMXFYMTNvEexXt6OnVVTnuej7x03QldW
	GCsWoD0Ob9wlZFJdLFA8pT1plzi3/JE=
Date: Wed, 18 Sep 2024 00:29:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
To: Damien Le Moal <dlemoal@kernel.org>, Aleksandr Mishin
 <amishin@t-argos.ru>, Shaohua Li <shli@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 John Garry <john.g.garry@oracle.com>, Yu Kuai <yukuai3@huawei.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240917070729.15752-1-amishin@t-argos.ru>
 <c50f7ca2-8f3d-4b7e-bd50-1957e4a09b7b@kernel.org>
 <e1aad556-eab1-4ac4-aec3-1706e302cfb1@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e1aad556-eab1-4ac4-aec3-1706e302cfb1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/17 15:24, Damien Le Moal 写道:
> On 2024/09/17 16:21, Damien Le Moal wrote:
>> On 2024/09/17 16:07, Aleksandr Mishin wrote:
>>> In null_alloc_dev() device size is a subject to overflow because 'g_gb'
>>> (which is module parameter, may have any value and is not validated
>>> anywhere) is not cast to a larger data type before performing arithmetic.
>>>
>>> Cast 'g_gb' to unsigned long to prevent overflow.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>> ---
>>>   drivers/block/null_blk/main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index 2f0431e42c49..5edbf9c0aceb 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>>>   		return NULL;
>>>   	}
>>>   
>>> -	dev->size = g_gb * 1024;
>>> +	dev->size = (unsigned long)g_gb * 1024;
>>
>> This still does not prevent overflows... So what about doing a proper check ?
> 
> This still does not prevent overflows on 32-bits architectures.

Because "unsigned long" on 32-bits architectures is 32 bit, so solution 
1 is to change the type "unsigned long" to u64, and the diff is as below:

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f0431e42c49..27a453b3094d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
                 return NULL;
         }

-       dev->size = g_gb * 1024;
+       dev->size = (u64)g_gb * 1024;
         dev->completion_nsec = g_completion_nsec;
         dev->submit_queues = g_submit_queues;
         dev->prev_submit_queues = g_submit_queues;
diff --git a/drivers/block/null_blk/null_blk.h 
b/drivers/block/null_blk/null_blk.h
index a7bb32f73ec3..e30c011909ad 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -74,7 +74,7 @@ struct nullb_device {
         bool need_zone_res_mgmt;
         spinlock_t zone_res_lock;

-       unsigned long size; /* device size in MB */
+       u64 size; /* device size in MB */
         unsigned long completion_nsec; /* time in ns to complete a 
request */
         unsigned long cache_size; /* disk cache size in MB */
         unsigned long zone_size; /* zone size in MB if device is zoned */

I just built it and did not make tests.

Zhu Yanjun

> 
>>
>>>   	dev->completion_nsec = g_completion_nsec;
>>>   	dev->submit_queues = g_submit_queues;
>>>   	dev->prev_submit_queues = g_submit_queues;
>>
> 

