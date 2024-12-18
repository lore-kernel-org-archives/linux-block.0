Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE717C91;
	Wed, 18 Dec 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485318; cv=none; b=c5enApFPmpg9e7FaNZ0VhO72M2eBUGYUQFuDMdqDVZ26r1+MXg5dXMpMymF/ALigcb03DC2Y+AkZzlz9vBnOoTZ5SwKUmhk/O8RLNPh2A3497sm1H6u2HOIVYLKXLn2YxhTtD3mn1WLC4AYsGPErrbItt56H/JgZRvPPqz7s7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485318; c=relaxed/simple;
	bh=igeJKJyQykoGC+6MnqrpdhPssj1MyB2fRgUggIenoGQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E5doeK6GdRHpxtFcODc8z3AkfFtJGD9CJk9F+aE7BmDS7WSvFDlQ9J2IGGLvytTcHM+VP3vMxO3j72HPsO7H9Ez9wOALE7ogJW6eb8HxEfwg9BWOQC39V2UbmvM10k/sxqhK9GJHf1LEHUu7lqRkrulpXc1Iwzf1SmtZcXNgrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCbfN1FJmz4f3lWJ;
	Wed, 18 Dec 2024 09:28:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AC2461A0194;
	Wed, 18 Dec 2024 09:28:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoI+JWJnjBmjEw--.18993S3;
	Wed, 18 Dec 2024 09:28:32 +0800 (CST)
Subject: Re: [PATCH v2 3/4] block/elevator: choose none elevator for high IO
 concurrency ability disk
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@redhat.com,
 yang.yang@vivo.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-4-yukuai1@huaweicloud.com>
 <ac5aa72f-9944-4436-bed3-43e4e4e97f5e@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <292f069e-023b-2f3c-6cae-0d133190749a@huaweicloud.com>
Date: Wed, 18 Dec 2024 09:28:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ac5aa72f-9944-4436-bed3-43e4e4e97f5e@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoI+JWJnjBmjEw--.18993S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1xur43urWDJFyxAFy7Wrg_yoW8ur1fpr
	s5Aa90krWDtrnakw17Jw17Xa45Ja4Sgw1DWrn2yFyUKrnrZrsF93WfWFnYgrWUJr4xGrsr
	Zr4DXFZ7uF1UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/18 5:50, Bart Van Assche 写道:
> On 12/16/24 6:40 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> The maximal default nr_requests is 256, and if disk can handle more than
>> 256 requests concurrently, use elevator in this case is useless, on the
>> one hand it limits the number of requests to 256, on the other hand,
>> it can't merge or sort IO because requests are dispatched to disk
>> immediately and the elevator is just empty.
>>
>> For example, for nvme megaraid with 512 queue_depth by default, we have
>> to change default elevator to none, otherwise deadline will lose a lot of
>> performance.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/elevator.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 7c3ba80e5ff4..4cce1e7c47d5 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -568,6 +568,17 @@ static struct elevator_type 
>> *elevator_get_default(struct request_queue *q)
>>           !blk_mq_is_shared_tags(q->tag_set->flags))
>>           return NULL;
>> +    /*
>> +     * If nr_queues will be less than disk ability, requests will be
>> +     * dispatched to disk immediately, it's useless to use elevator. 
>> User
>> +     * should set a bigger nr_requests or limit disk ability manually if
>> +     * they really want to use elevator.
>> +     */
>> +    if (q->queue_depth && q->queue_depth >= BLKDEV_DEFAULT_RQ * 2)
>> +        return NULL;
>> +    if (!q->queue_depth && q->tag_set->queue_depth >= 
>> BLKDEV_DEFAULT_RQ * 2)
>> +        return NULL;
>> +
>>       return elevator_find_get("mq-deadline");
>>   }
> 
> Shouldn't this patch be submitted separately since it is independent of
> the rest of the patches in this series?

Yes, this patch was added to this set by mistake. My bad. :(
I'm supposed to use the cleanup patch from v1 to replace this patch.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

