Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D639AD51;
	Tue,  7 Jul 2026 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405508; cv=none; b=dxdWqY+SjwtLnvto7NP7comk+POCVfRsJNZFYU9Lv+7KAUQMNYJM1FIIU9j+PxaT1PS50OJPaQUQ93c2L4bm1C+GbksDOT9o4WXiyc/geCd+crU0z0HL49HDZ7dqEFCV+S9FNE4fOX7DviKKQSZxVjsJMmkdwo2q6qbAq5aB1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405508; c=relaxed/simple;
	bh=R/k0gEBmmI8uk2xvoCXILyOmqBEozzQgG4G16AEBELI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbknE6RbmV+dKaQcqfNmCeBwCVNE4qbgFks+9BcuH7CeXYhI7PdKOsWS21T3NvAy6yZRT7WS4lKA1wfb8hoiGlQ5RFmu5nVI5D+fzBdEC45lWZIYn5sj90tSC57IolqWs9TOERUvBeBcW4snYtwnn9IiVzNNkMIuKqYT4p3qyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvWRX0fttzYQtkV;
	Tue,  7 Jul 2026 14:24:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ED1544057D;
	Tue,  7 Jul 2026 14:24:58 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCntnK5m0xqsZNlAQ--.63951S3;
	Tue, 07 Jul 2026 14:24:58 +0800 (CST)
Message-ID: <5dd82788-aa48-4f11-907f-6f21b57a27fa@huaweicloud.com>
Date: Tue, 7 Jul 2026 14:24:56 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] null_blk: give the file-scope mutex a descriptive
 name
To: Damien Le Moal <dlemoal@kernel.org>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, nilay@linux.ibm.com, linux-block@vger.kernel.org,
 kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
 bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-3-wozizhi@huaweicloud.com>
 <0ab391b1-20e2-4ae9-a606-7111014e489c@kernel.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <0ab391b1-20e2-4ae9-a606-7111014e489c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCntnK5m0xqsZNlAQ--.63951S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5GFWfuFWkuF1xKFyrCrg_yoW5JrWrpF
	WFgayjkr1jgF4xX3y2q39FkryYqw409FyxKrZ7Aa4FkasFvr97Zr1DJrW5Wry8G3s7CrsI
	qF4DJFs3Ga1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/7 12:16, Damien Le Moal 写道:
> On 7/7/26 11:55, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> The file-scope lock mutex serializes access to global null_blk state,
>> including the nullb_list and device creation/removal. Rename it to
>> "nullb_global_lock" to make its purpose clear. No functional change.
>>
>> Suggested-by: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   drivers/block/null_blk/main.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index eba204b27785..98f6935bb502 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -66,7 +66,7 @@ struct nullb_page {
>>   #define NULLB_PAGE_FREE (MAP_SZ - 2)
>>   
>>   static LIST_HEAD(nullb_list);
>> -static DEFINE_MUTEX(lock);
>> +static DEFINE_MUTEX(nullb_global_lock);
> 
> Since this seem to protect only the device list, why not simply call this
> nullb_list_lock ?
> 
>>   static int null_major;
>>   static DEFINE_IDA(nullb_indexes);
>>   static struct blk_mq_tag_set tag_set;
>> @@ -423,9 +423,9 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
>>   {
>>   	int ret;
>>   
>> -	mutex_lock(&lock);
>> +	mutex_lock(&nullb_global_lock);
>>   	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
>> -	mutex_unlock(&lock);
>> +	mutex_unlock(&nullb_global_lock);
> 
> Nothing in nullb_update_nr_hw_queues() touches the device list. So it is very
> odd that nullb_global_lock is used for serialization here instead of a
> nullb_device mutex. If you change this, why not a prep patch to introduce such a
> mutex ?
> 

Thanks for pointing this out. The rename really belongs together with
the locking rework, so I'll drop this patch from v3 and fold the rename
into a separate series that splits the locking (introducing a per-
nullb_device mutex for the updates).

Thanks,
Zizhi Wo

>>   
>>   	return ret;
>>   }
>> @@ -435,9 +435,9 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
>>   {
>>   	int ret;
>>   
>> -	mutex_lock(&lock);
>> +	mutex_lock(&nullb_global_lock);
>>   	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
>> -	mutex_unlock(&lock);
>> +	mutex_unlock(&nullb_global_lock);
> 
> Same here.
> 
>>   
>>   	return ret;
>>   }
> 
> 

