Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04219343C
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083733; cv=none; b=ovHKkx4rbhZ0GQJKfLXT08TOIWi0lZEw5qMsZ/W1kTIw3SjbXdgl6boOhIynTHljBQ9nOPx52EnUbGGkjQcFjQBiywihSCj4nTUpXKmjvKsPyvHHqyrzJ9vbAAziLOmUusfCBglffjIvvtVdnjdfzvD1xIFC0qA9Vpf/+dTfmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083733; c=relaxed/simple;
	bh=IDdHYd6EVjEy3bOtamyFWT9a8bDTzWpHibtGeRrpO6o=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FU8xrcQQdeMYRnR7E+hZcsDQZeQTG1E2dD9Ne7XrmBB2GAAdooaSKINDYTB5qMQsRFGiR2H/J9PnCw5RwMwoQ5GfJnu2XA/RDuQq7pMzcMztJBGf2BY+ii3B6TXojY9M4nENT1dujDBUeQS151EAUwi9DLOZaUU88Fr08GJ105U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XByNF20M9z4f3jXy
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 17:28:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 60CEC1A08FC
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 17:28:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHusbLNPFmFHh5CA--.22599S3;
	Mon, 23 Sep 2024 17:28:45 +0800 (CST)
Subject: Re: [PATCH 1/1] null_blk: Use u64 to avoid overflow in
 null_alloc_dev()
To: Damien Le Moal <dlemoal@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 yukuai1@huaweicloud.com, amishin@t-argos.ru, shli@fb.com, axboe@kernel.dk,
 hare@suse.de, linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <e5807f3c-3173-44e6-b222-fc4679be4680@linux.dev>
 <20240922085941.14832-1-yanjun.zhu@linux.dev>
 <2bb3f66f-e1a7-4c72-8933-4e6aaf373133@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <da0db67d-a35b-873e-e066-f424d2cb1fb1@huaweicloud.com>
Date: Mon, 23 Sep 2024 17:28:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2bb3f66f-e1a7-4c72-8933-4e6aaf373133@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusbLNPFmFHh5CA--.22599S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWkJF45WF17Jw1DWw13CFg_yoW5CFy7pF
	W7GF1YyrWDtr17ur1Skw4DXF1Yvw1IvFyUWrW7C348CF15tr1xAFyDAFW5u3WkG3yUAF12
	vanrtF93CF4UWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Damien

在 2024/09/23 16:11, Damien Le Moal 写道:
> On 2024/09/22 10:59, Zhu Yanjun wrote:
>> The member variable size in struct nullb_device is the type
>> unsigned long, and the module parameter g_gb is the type int.
>> In 32 bit architecture, unsigned long has 32 bit. This
>> introduces overflow risks.
>>
>> Use the type u64 in struct nullb_device and configfs. This
>> can avoid overflow risks.
>>
>> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/block/null_blk/main.c     | 23 +++++++++++++++++++++--
>>   drivers/block/null_blk/null_blk.h |  2 +-
>>   2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 2f0431e42c49..88c6d6277d09 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -289,6 +289,11 @@ static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
>>   	return snprintf(page, PAGE_SIZE, "%lu\n", val);
>>   }
>>   
>> +static inline ssize_t nullb_device_u64_attr_show(u64 val, char *page)
>> +{
>> +	return snprintf(page, PAGE_SIZE, "%llu\n", val);
>> +}
>> +
>>   static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
>>   {
>>   	return snprintf(page, PAGE_SIZE, "%u\n", val);
>> @@ -322,6 +327,20 @@ static ssize_t nullb_device_ulong_attr_store(unsigned long *val,
>>   	return count;
>>   }
>>   
>> +static ssize_t nullb_device_u64_attr_store(u64 *val, const char *page,
>> +	size_t count)
>> +{
>> +	int result;
>> +	u64 tmp;
>> +
>> +	result = kstrtou64(page, 0, &tmp);
>> +	if (result < 0)
>> +		return result;
>> +
>> +	*val = tmp;
>> +	return count;
>> +}
>> +
>>   static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
>>   	size_t count)
>>   {
>> @@ -438,7 +457,7 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
>>   	return ret;
>>   }
>>   
>> -NULLB_DEVICE_ATTR(size, ulong, NULL);
>> +NULLB_DEVICE_ATTR(size, u64, NULL);
>>   NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
>>   NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
>>   NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_poll_queues);
>> @@ -762,7 +781,7 @@ static struct nullb_device *null_alloc_dev(void)
>>   		return NULL;
>>   	}
>>   
>> -	dev->size = g_gb * 1024;
>> +	dev->size = (u64)g_gb * 1024;
> 
> As already commented on your previous version that was casting to an unsigned
> long, this is *not* avoiding an overflow. It is only changing the overflow value
> to a bigger one. So as suggested before, if you really want to fix this, fix it
> properly using check_mul_overflow().

g_gb is 32-bit value in GB, hence the result won't overflow if size
is changed to 64-bit value now.

And please also use a specific store function instead of
nullb_device_u64_attr_store(), and using check_mul_overflow() to check
overflow, because dev->size will used later for inode size, and 64-bit
value in MB can overflow after switching to 64-bit value in sectors.

Thanks,
Kuai

> 
> 

