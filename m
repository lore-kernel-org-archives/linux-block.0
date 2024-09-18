Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D819A;
	Wed, 18 Sep 2024 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625250; cv=none; b=ixevS0KbB+2MEfUr2+730WI2Hbn5V4jZ7fm4dEv34nDle091nYIVR/iUi2bkCuYRj7ypfUQXpesVZiKtX36eFDswXi3K2UoHNaKu3gKOVjnlzigkrUu74nrhMaF9wDlr0VM2soL2RtD42YO2Uz5NTRHKUF3xqkRwKXVaECZjT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625250; c=relaxed/simple;
	bh=xSq8OEdnemcLMx6ouPUxqGj5Jm/GW2DYDjFFCRCZRsw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O0OTv6yLBEw+zZdoCR26lHcqUZO2gh4Tvj3oy1MZuuPcuOt6mCdN2BOY1TvJjSnbidChTxLipzNjt2P4SNv3Rr6khn68qQmQWNbENwgc+YmLUsCjwDqYDEpo6VCRMs9i2vgUyGD+zwT99Qwjxuwvc+ugPA6yeM0iL2PS6Uaz8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X7hqH0m18z4f3jkb;
	Wed, 18 Sep 2024 10:07:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 041061A018D;
	Wed, 18 Sep 2024 10:07:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMjTNepmzk+FBg--.778S3;
	Wed, 18 Sep 2024 10:07:17 +0800 (CST)
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Damien Le Moal <dlemoal@kernel.org>,
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <51b8f03e-4dd3-6abc-235f-fca58ca4cd2e@huaweicloud.com>
Date: Wed, 18 Sep 2024 10:07:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df22ea76-f123-4d27-a6ad-e217259a13ba@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMjTNepmzk+FBg--.778S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4UAr15XFyDAryxurWxZwb_yoW5Kw1Upa
	ykKFy8CryUCF18Gr4jyw45XFyrt3WUt3y5WFy7Aa4jgrZIyFy2vFWUXF90gr4UJ3y8AF43
	ZF1DXrZ3ZFyDJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUFku4UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



在 2024/09/18 0:29, Zhu Yanjun 写道:
> 在 2024/9/17 15:24, Damien Le Moal 写道:
>> On 2024/09/17 16:21, Damien Le Moal wrote:
>>> On 2024/09/17 16:07, Aleksandr Mishin wrote:
>>>> In null_alloc_dev() device size is a subject to overflow because 'g_gb'
>>>> (which is module parameter, may have any value and is not validated
>>>> anywhere) is not cast to a larger data type before performing 
>>>> arithmetic.
>>>>
>>>> Cast 'g_gb' to unsigned long to prevent overflow.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
>>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>>> ---
>>>>   drivers/block/null_blk/main.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/block/null_blk/main.c 
>>>> b/drivers/block/null_blk/main.c
>>>> index 2f0431e42c49..5edbf9c0aceb 100644
>>>> --- a/drivers/block/null_blk/main.c
>>>> +++ b/drivers/block/null_blk/main.c
>>>> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>>>>           return NULL;
>>>>       }
>>>> -    dev->size = g_gb * 1024;
>>>> +    dev->size = (unsigned long)g_gb * 1024;
>>>
>>> This still does not prevent overflows... So what about doing a proper 
>>> check ?
>>
>> This still does not prevent overflows on 32-bits architectures.
> 
> Because "unsigned long" on 32-bits architectures is 32 bit, so solution 
> 1 is to change the type "unsigned long" to u64, and the diff is as below:
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 2f0431e42c49..27a453b3094d 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>                  return NULL;
>          }
> 
> -       dev->size = g_gb * 1024;
> +       dev->size = (u64)g_gb * 1024;
>          dev->completion_nsec = g_completion_nsec;
>          dev->submit_queues = g_submit_queues;
>          dev->prev_submit_queues = g_submit_queues;
> diff --git a/drivers/block/null_blk/null_blk.h 
> b/drivers/block/null_blk/null_blk.h
> index a7bb32f73ec3..e30c011909ad 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -74,7 +74,7 @@ struct nullb_device {
>          bool need_zone_res_mgmt;
>          spinlock_t zone_res_lock;
> 
> -       unsigned long size; /* device size in MB */
> +       u64 size; /* device size in MB */

There is more, g_gb is GB, dev->size is MB, and dev->size will be used
later for inode size in bytes, and bdev size in sectors.

The max inode size is LONG_MAX, this is still more than UINT_MAX GB, so
it's right that set the device size by module params won't overflow.

However, take a look at setting the size through configfs, the max value
is ULONG_MAX MB, this will still overflow.

Thanks,
Kuai

>          unsigned long completion_nsec; /* time in ns to complete a 
> request */
>          unsigned long cache_size; /* disk cache size in MB */
>          unsigned long zone_size; /* zone size in MB if device is zoned */
> 
> I just built it and did not make tests.
> 
> Zhu Yanjun
> 
>>
>>>
>>>>       dev->completion_nsec = g_completion_nsec;
>>>>       dev->submit_queues = g_submit_queues;
>>>>       dev->prev_submit_queues = g_submit_queues;
>>>
>>
> 
> 
> .
> 

