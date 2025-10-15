Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCD1917FB;
	Wed, 15 Oct 2025 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760489792; cv=none; b=SdEwcvy+CZd6mfy7FfNatz0nmEtmUMsw7XTxWoqkeSZVmqv2UA72s2LyQxoznwdBSjhKxn7o1OoVP3jtc6++9obSm6Zre+M0kzIgyEvtXixvrKvAPevhZjT2l8yXJLTL/s9OpROjoum4lSTy1pQgA090padD8GVCRBs24K/fzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760489792; c=relaxed/simple;
	bh=M3qOLY2xWT3CisC6MqMLLaexgYnntVi8tfjTwZFSF+A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XzdH5c4AWnKxitpZL0zR6UUevCOQq+pRD0g2JGLoB6/c7TuznG+78dKJRknQsyqcVep6osPUbHxguWkEclQ8XdlInj2Ih8pzluCm/dl7dIVshA7gZydIiTLxdCwJ5W82C9567tEtxMpYmMCxQTDImyHzCgD3dzLeC+oVZ3Msj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmXgz2Z62zYQtmV;
	Wed, 15 Oct 2025 08:55:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3BDE31A08DC;
	Wed, 15 Oct 2025 08:56:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgCH3UU38e5ov3ubAQ--.50578S3;
	Wed, 15 Oct 2025 08:56:25 +0800 (CST)
Subject: Re: [PATCH v2 for-6.18/block 05/10] blk-mq: cleanup shared tags case
 in blk_mq_update_nr_requests()
To: Nilay Shroff <nilay@linux.ibm.com>, Chris Mason <clm@meta.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20251014130507.4187235-2-clm@meta.com>
 <fd66fda2-8dd9-4009-9c4b-7cebaac64c05@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2ee045ce-2def-0111-4442-27bc90aed152@huaweicloud.com>
Date: Wed, 15 Oct 2025 08:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fd66fda2-8dd9-4009-9c4b-7cebaac64c05@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH3UU38e5ov3ubAQ--.50578S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rtrWfZr45Ww4kuF17Jrb_yoW5Jr1rpr
	WY9a17Kw1Fqr1jvrW2yw13Wa10gwsxKr1xurs5tryfKryqkr4ftF4rWrZ5uFWIyr4kAFWS
	vF4DJFZxXrn2qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/10/15 2:04, Nilay Shroff 写道:
> 
> 
> On 10/14/25 6:35 PM, Chris Mason wrote:
>> Hi everyone,
>>
>> My review automation flagged this one in linux-next, and it looks like a
>> valid bug to me:
>>
>> On Wed, 10 Sep 2025 16:04:40 +0800 Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> For shared tags case, all hctx->sched_tags/tags are the same, it doesn't
>>> make sense to call into blk_mq_tag_update_depth() multiple times for the
>>> same tags.
>>>
>>
>> [ ... ]
>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 9b97f2f3f2c9..80c20700bce8 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4935,34 +4935,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>>
>>>   	blk_mq_quiesce_queue(q);
>>>
>>> -	queue_for_each_hw_ctx(q, hctx, i) {
>>> -		if (!hctx->tags)
>>> -			continue;
>>> -		/*
>>> -		 * If we're using an MQ scheduler, just update the scheduler
>>> -		 * queue depth. This is similar to what the old code would do.
>>> -		 */
>>> -		if (hctx->sched_tags) {
>>> -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
>>> -						      nr);
>>> -		} else {
>>> -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
>>> -		}
>>> -		if (ret)
>>> -			goto out;
>>> -	}
>>> -
>>> -	q->nr_requests = nr;
>>> -	if (q->elevator && q->elevator->type->ops.depth_updated)
>>> -		q->elevator->type->ops.depth_updated(q);
>>> -
>>>   	if (blk_mq_is_shared_tags(set->flags)) {
>>>   		if (q->elevator)
>>>   			blk_mq_tag_update_sched_shared_tags(q);
>>                          ^^^^
>>
>> Does blk_mq_tag_update_sched_shared_tags() use the wrong value here?
>>
>> In the old code, q->nr_requests was updated to nr before calling
>> blk_mq_tag_update_sched_shared_tags(). But in the new code, this
>> function is called while q->nr_requests still contains the old value.
>>
>> Looking at blk_mq_tag_update_sched_shared_tags():
>>
>>      void blk_mq_tag_update_sched_shared_tags(struct request_queue *q)
>>      {
>>          sbitmap_queue_resize(&q->sched_shared_tags->bitmap_tags,
>>                               q->nr_requests - q->tag_set->reserved_tags);
>>      }
>>
>> It reads q->nr_requests to calculate the new sbitmap size. With the
>> reordering, this will resize the sbitmap to the old depth instead of
>> the new depth passed in nr.
>>
> Good catch! Yes, I think this needs to be fixed...
> 

Yeah, I'll send a fix ASAP.

Thanks,
Kuai

> Thanks,
> --Nilay
> 
> 
> .
> 

