Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FC308F1D;
	Tue,  9 Sep 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403481; cv=none; b=XCVhzF4dJG/O/29MGCQVVNn+gwx0Gy3/9VvXge0Mo3Lgb9Dmi5UInINzRKUCjtFVKI9sHFCpG2CNaq7TUoyLSXsi6uG5PIoY93OSESRzhHDkJYL6LJQLBk4GmdEQHoBRZ6ClcZSXm8yA4QbHeyqdaOBoYQW+58Z6Aw8iPBmYTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403481; c=relaxed/simple;
	bh=c4WUAxAYWcISEvosLLhmcGLg7O31JhI+YfboesKNCdY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eBtUMRg1R85lF+QSI0K8gd15GWWir6zOV41YCcj1OY8UrJG70BgSDZqScaYAwGBy8G3d/Ss/hr0EsZf7t4zsW6YSPIdGIWSMRp5ZBUGHuj1kW761ygnIWlKFRjc2FycBpW7A6exOA32aBnfLISRbD5qoJ7XFVas69bzmsOtdf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cLbJg3HgszYQv9M;
	Tue,  9 Sep 2025 15:37:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EAA9F1A0DAB;
	Tue,  9 Sep 2025 15:37:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncIxO2b9oyyOcBw--.5864S3;
	Tue, 09 Sep 2025 15:37:52 +0800 (CST)
Subject: Re: [PATCH for-6.18/block 08/10] blk-mq: fix potential deadlock while
 nr_requests grown
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-9-yukuai1@huaweicloud.com>
 <484c552e-462f-488f-90bf-18fe5042f1bb@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <628d9525-dcef-2aaa-3434-64c7cdc0fb23@huaweicloud.com>
Date: Tue, 9 Sep 2025 15:37:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <484c552e-462f-488f-90bf-18fe5042f1bb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIxO2b9oyyOcBw--.5864S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy8JF1kKFyDZrWDAw4ktFb_yoW8Zr4kpF
	4rJa1qkr4Syr18u3y8CwnrX34xJws2gr1xCrWfta4agFnFvFn3u3WrCFW5WF4kAr4qkFs2
	gF909FZ3ZFWkJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/09 14:39, Nilay Shroff 写道:
> 
> 
> On 9/8/25 11:45 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Allocate and free sched_tags while queue is freezed can deadlock[1],
>> this is a long term problem, hence allocate memory before freezing
>> queue and free memory after queue is unfreezed.
>>
>> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
>> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> [...]
> [...]
> 
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 7ea15bf68b4b..a0a7ebad378f 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -64,11 +64,12 @@ static ssize_t queue_requests_show(struct gendisk *disk, char *page)
>>   static ssize_t
>>   queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>   {
>> -	unsigned long nr;
>> -	int ret, err;
>> -	unsigned int memflags;
>>   	struct request_queue *q = disk->queue;
>>   	struct blk_mq_tag_set *set = q->tag_set;
>> +	struct elevator_tags *et = NULL;
>> +	unsigned int memflags;
>> +	unsigned long nr;
>> +	int ret;
>>   
>>   	ret = queue_var_store(&nr, page, count);
>>   	if (ret < 0)
>> @@ -90,16 +91,24 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>   		goto unlock;
>>   	}
>>   
>> +	if (q->elevator && nr > q->elevator->et->nr_requests) {
>> +		/* allocate memory before freezing queue to prevent deadlock */
>> +		et = blk_mq_alloc_sched_tags(set, q->nr_hw_queues, nr);
>> +		if (!et) {
>> +			ret = -ENOMEM;
>> +			goto unlock;
>> +		}
>> +	}
>> +
> I think we should add a comment above explaining why is it safe
> to access q->elevator without holding ->elevator_lock.
> 

I already access q->elevator to check input nr from patch 4, and that's
why I add comments to explain switching elevator is serialized, is this
enough?

Thanks,
Kuai

> Thanks,
> --Nilay
> .
> 

