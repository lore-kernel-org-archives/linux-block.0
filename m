Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FBBA20;
	Thu, 15 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686865; cv=none; b=VP3Im9mC27effFVF48YQkXh8LULiqlIXykFZKawK0OSfkMTDwo+g5vcA0/FyjMaimTsmsAPtQs6BARaj7zMGSDtAbqDZFXA1Gm2VLBpnXUxU0mm2y3nL30Ws9VvMHmQqMxhQ2byPySm0pAfaFCCOYxyoAKDmVBzaSuCbV33dKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686865; c=relaxed/simple;
	bh=9Vt7bZj3r8ykVXUlYSK9XbLtW9JOWLDtf3YeFYfQX9A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QTpiQuYMkHpWFVerwC49QWCde3hr2KfqqAPLUws1MtVVLpVPFIjplgBMkcNzhP/HdceirMPKvSd9ryV3c4KhrwISZGiIrj1HiuTeRElT3m31QNK6hL8aES3DP8etLvIFGuSj3JoxphMxQmzgoamxR4rODv98jzieTgUrkicY/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wkp7x4Qxcz4f3js2;
	Thu, 15 Aug 2024 09:54:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 66BDB1A0568;
	Thu, 15 Aug 2024 09:54:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4XJX71mMjTkBg--.10385S3;
	Thu, 15 Aug 2024 09:54:19 +0800 (CST)
Subject: Re: [PATCH] block: Fix potential deadlock warning in
 blk_mq_mark_tag_wait
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Li Lingfeng <lilingfeng@huaweicloud.com>, hch@lst.de, jack@suse.cz,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, lilingfeng3@huawei.com, "yukuai (C)"
 <yukuai3@huawei.com>
References: <20240814113542.911023-1-lilingfeng@huaweicloud.com>
 <ad92f738-9ba5-4cfc-aef5-3918a35e77ec@acm.org>
 <6e729890-7374-4335-ab7d-ead00775057e@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a3271107-f6d2-a689-78d5-f98d53fd497b@huaweicloud.com>
Date: Thu, 15 Aug 2024 09:54:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6e729890-7374-4335-ab7d-ead00775057e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4XJX71mMjTkBg--.10385S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rCFWxJrWxJr17Jw1UZFb_yoW8Zw45pF
	WxXan8Kan8JrZ29w4jkrsFvr1S9ws5Wr13Jrn5Wr45Z34jvr1fWa4xAF1q9FWvgrs3AF4q
	vr1jq395KF4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/15 4:22, Jens Axboe 写道:
> On 8/14/24 1:52 PM, Bart Van Assche wrote:
>> On 8/14/24 4:35 AM, Li Lingfeng wrote:
>>> When interrupt is turned on while a lock holding by spin_lock_irq it
>>> throws a warning because of potential deadlock.
>>
>> Which tool reported the warning? Please mention this in the patch
>> description.
>>>
>>> blk_mq_mark_tag_wait
>>>    spin_lock_irq(&wq->lock)
>>>         --> turn off interrupt and get lockA
>>>    blk_mq_get_driver_tag
>>>     __blk_mq_tag_busy
>>>      spin_lock_irq(&tags->lock)
>>>      spin_unlock_irq(&tags->lock)
>>>         --> release lockB and turn on interrupt accidentally

This looks correct, however, many details are hidden:

t1: IO dispatch
blk_mq_prep_dispatch_rq
  blk_mq_get_driver_tag
   __blk_mq_get_driver_tag
    __blk_mq_alloc_driver_tag
     blk_mq_tag_busy -> tag is already busy
     // failed to get driver tag

  blk_mq_mark_tag_wait
   spin_lock_irq(&wq->lock) -> lock A
   __add_wait_queue(wq, wait) -> wait queue active
   blk_mq_get_driver_tag
   __blk_mq_tag_busy
-> 1) tag must be idle, which means there can't be inflight IO
    spin_lock_irq(&tags->lock) -> lock B
    spin_unlock_irq(&tags->lock) -> unlock B
-> 2) context must be preempt by IO interrupt to trigger deadlock.

So, the deadlock is not possible in theory, there can't be inflight IO
if __blk_mq_tag_busy what to hold the second lock, while deadlock
require IO to be done.

Any way, the change looks good to me.

Thanks,
Kuai

>>
>> The above call chain does not match the code in Linus' master tree.
>> Please fix this.
>>
>>> Fix it by using spin_lock_irqsave to get lockB instead of spin_lock_irq.
>>> Fixes: 4f1731df60f9 ("blk-mq: fix potential io hang by wrong 'wake_batch'")
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> Please leave a blank line between the patch description and the section
>> with tags.
> 
> Please just include the actual lockdep trace rather than a doctored up
> one, it's a lot more descriptive. And use the real lock names rather
> than turn it into hypotheticals.
> 

