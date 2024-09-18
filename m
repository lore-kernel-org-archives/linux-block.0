Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852A6FB6
	for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726628277; cv=none; b=rEEPz3ZcZQ3948lm1aFi+39KlY6G8cBjHBEp2+GKZwpYLd9yj5BYTsAEx+oKfLNkYDwG6R3ABpDc0jYI66IyBiogszO92eFuKa7BngzpqJhdhjQy/c4TJcUzzF6V+hA9/78Fk4nMl4sVjfuqlLK4umrGnIn82mfvXUS/qNv8/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726628277; c=relaxed/simple;
	bh=ewIXpexPRczWlsaEmOxXFeB7JuGhgri1s7SPzc2fb1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnUjhxVliclqapnNNTHlp/RIGaKOkN+5ZD2kUpjU+h3lwUeLUEj16S2Z0/97XHQZ7ZIjfPDKhYPsjUMuyIGIOfyRF59n9BHJiqWZVWzbog7BXJYdd36d1yTzN+B5/oYkZNdvhn7uuZTpPvBkEYkmOzeFZHfOd59pJix1WYZ3/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoCNlNkM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoCNlNkM"
Message-ID: <e5807f3c-3173-44e6-b222-fc4679be4680@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726628270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZbemlrOrsb66605F738V8QkgMHyO6mSHVvEXeDcmsA=;
	b=QoCNlNkMeBtbbJmvuDwNFcrzvofMLwagzb/52k8ZgAK+Tamika9TIaS3G2AsO4GPEMoBXP
	9TqH0a0HB1bErnD8GSSnmSvE0Hsu6KrlCSqUaBVMFY/Ha+Fwf45nXui9UmAopBqbguVTFT
	2tU+4oq5TpStSQYIcoB02uhfcN2eGWc=
Date: Wed, 18 Sep 2024 10:57:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
To: Yu Kuai <yukuai1@huaweicloud.com>, Damien Le Moal <dlemoal@kernel.org>,
 Aleksandr Mishin <amishin@t-argos.ru>, Shaohua Li <shli@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 John Garry <john.g.garry@oracle.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, "yukuai (C)" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20240917070729.15752-1-amishin@t-argos.ru>
 <c50f7ca2-8f3d-4b7e-bd50-1957e4a09b7b@kernel.org>
 <e1aad556-eab1-4ac4-aec3-1706e302cfb1@kernel.org>
 <df22ea76-f123-4d27-a6ad-e217259a13ba@linux.dev>
 <51b8f03e-4dd3-6abc-235f-fca58ca4cd2e@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <51b8f03e-4dd3-6abc-235f-fca58ca4cd2e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/9/18 10:07, Yu Kuai 写道:
>
>
> 在 2024/09/18 0:29, Zhu Yanjun 写道:
>> 在 2024/9/17 15:24, Damien Le Moal 写道:
>>> On 2024/09/17 16:21, Damien Le Moal wrote:
>>>> On 2024/09/17 16:07, Aleksandr Mishin wrote:
>>>>> In null_alloc_dev() device size is a subject to overflow because 
>>>>> 'g_gb'
>>>>> (which is module parameter, may have any value and is not validated
>>>>> anywhere) is not cast to a larger data type before performing 
>>>>> arithmetic.
>>>>>
>>>>> Cast 'g_gb' to unsigned long to prevent overflow.
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
>>>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>>>> ---
>>>>>   drivers/block/null_blk/main.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/block/null_blk/main.c 
>>>>> b/drivers/block/null_blk/main.c
>>>>> index 2f0431e42c49..5edbf9c0aceb 100644
>>>>> --- a/drivers/block/null_blk/main.c
>>>>> +++ b/drivers/block/null_blk/main.c
>>>>> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>>>>>           return NULL;
>>>>>       }
>>>>> -    dev->size = g_gb * 1024;
>>>>> +    dev->size = (unsigned long)g_gb * 1024;
>>>>
>>>> This still does not prevent overflows... So what about doing a 
>>>> proper check ?
>>>
>>> This still does not prevent overflows on 32-bits architectures.
>>
>> Because "unsigned long" on 32-bits architectures is 32 bit, so 
>> solution 1 is to change the type "unsigned long" to u64, and the diff 
>> is as below:
>>
>> diff --git a/drivers/block/null_blk/main.c 
>> b/drivers/block/null_blk/main.c
>> index 2f0431e42c49..27a453b3094d 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>>                  return NULL;
>>          }
>>
>> -       dev->size = g_gb * 1024;
>> +       dev->size = (u64)g_gb * 1024;
>>          dev->completion_nsec = g_completion_nsec;
>>          dev->submit_queues = g_submit_queues;
>>          dev->prev_submit_queues = g_submit_queues;
>> diff --git a/drivers/block/null_blk/null_blk.h 
>> b/drivers/block/null_blk/null_blk.h
>> index a7bb32f73ec3..e30c011909ad 100644
>> --- a/drivers/block/null_blk/null_blk.h
>> +++ b/drivers/block/null_blk/null_blk.h
>> @@ -74,7 +74,7 @@ struct nullb_device {
>>          bool need_zone_res_mgmt;
>>          spinlock_t zone_res_lock;
>>
>> -       unsigned long size; /* device size in MB */
>> +       u64 size; /* device size in MB */
>
> There is more, g_gb is GB, dev->size is MB, and dev->size will be used
> later for inode size in bytes, and bdev size in sectors.
>
> The max inode size is LONG_MAX, this is still more than UINT_MAX GB, so
> it's right that set the device size by module params won't overflow.
>
> However, take a look at setting the size through configfs, the max value
> is ULONG_MAX MB, this will still overflow.

Thanks a lot.

Add nullb_device_u64_attr_show and nullb_device_u64_attr_store functions.

So configfs should work well. Just a draft patch to try to fix this 
overflow problem.

I just built it and did not make tests.

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f0431e42c49..56ee04277b92 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -289,6 +289,12 @@ static inline ssize_t 
nullb_device_ulong_attr_show(unsigned long val,
         return snprintf(page, PAGE_SIZE, "%lu\n", val);
  }

+static inline ssize_t nullb_device_u64_attr_show(u64 val,
+       char *page)
+{
+       return snprintf(page, PAGE_SIZE, "%llu\n", val);
+}
+
  static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
  {
         return snprintf(page, PAGE_SIZE, "%u\n", val);
@@ -322,6 +328,20 @@ static ssize_t 
nullb_device_ulong_attr_store(unsigned long *val,
         return count;
  }

+static ssize_t nullb_device_u64_attr_store(u64 *val,
+       const char *page, size_t count)
+{
+       int result;
+       u64 tmp;
+
+       result = kstrtou64(page, 0, &tmp);
+       if (result < 0)
+               return result;
+
+       *val = tmp;
+       return count;
+}
+
  static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
         size_t count)
  {
@@ -438,7 +458,7 @@ static int nullb_apply_poll_queues(struct 
nullb_device *dev,
         return ret;
  }

-NULLB_DEVICE_ATTR(size, ulong, NULL);
+NULLB_DEVICE_ATTR(size, u64, NULL);
  NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
  NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
  NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_poll_queues);
@@ -762,7 +782,7 @@ static struct nullb_device *null_alloc_dev(void)
                 return NULL;
         }

-       dev->size = g_gb * 1024;
+       dev->size = (u64)g_gb * 1024;
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

-       unsigned long size; /* device size in MB */
+       u64 size; /* device size in MB */
         unsigned long completion_nsec; /* time in ns to complete a 
request */
         unsigned long cache_size; /* disk cache size in MB */
         unsigned long zone_size; /* zone size in MB if device is zoned */

Zhu Yanjun


>
> Thanks,
> Kuai
>
>>          unsigned long completion_nsec; /* time in ns to complete a 
>> request */
>>          unsigned long cache_size; /* disk cache size in MB */
>>          unsigned long zone_size; /* zone size in MB if device is 
>> zoned */
>>
>> I just built it and did not make tests.
>>
>> Zhu Yanjun
>>
>>>
>>>>
>>>>>       dev->completion_nsec = g_completion_nsec;
>>>>>       dev->submit_queues = g_submit_queues;
>>>>>       dev->prev_submit_queues = g_submit_queues;
>>>>
>>>
>>
>>
>> .
>>
>
-- 
Best Regards,
Yanjun.Zhu

