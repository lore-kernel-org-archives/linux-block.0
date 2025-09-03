Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4C2C15B0;
	Wed,  3 Sep 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892148; cv=none; b=MOJJyOu18dscuCbZpLA3f9/SuEx4j7554qN4jhqvhF8sRQCpA7nnH62DRyXqhwKZs6WMhyv+1yE7KfECrsJOzPUvhyMlPf1b0Sgb2hSk4UjBaSmA6V0xd+W6Mk5zLVW1jW+lb+TjgbpZhOD8hmmizV/Uv6V3kLcGY+d6E7mw03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892148; c=relaxed/simple;
	bh=Q1BBsx96El0dexZayWEM3U4VriO/Yt3QpKfaSxwlzYw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nm6n502zXl3oOeEVJG3zt3M9xTDFU0LSG+kjS9PObnR4w3fVI+2RBSAwsUWGx4Y4ItQg51VCDaKCc9Tzi1N84sts/qL8aRXPoj2T3VMDhiIYGPWEQ/HomaA63Ig6CmM9UHDFYLVjPUQAyeL74bC3+GdGg03JltIpfKWmsNgohU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGyCL4pt8zKHN9g;
	Wed,  3 Sep 2025 17:35:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8B50C1A13D2;
	Wed,  3 Sep 2025 17:35:42 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzsC7ho0fL2BA--.35813S3;
	Wed, 03 Sep 2025 17:35:42 +0800 (CST)
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, yukuai1@huaweicloud.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <345e9d6e-8bb2-3d43-4c3c-cc16fa7dd8c1@huaweicloud.com>
 <CGME20250903084608epcas5p19a0ad4f0d1bad27889426e525d0c4598@epcas5p1.samsung.com>
 <20250903084135.2860-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
Date: Wed, 3 Sep 2025 17:35:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250903084135.2860-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIzsC7ho0fL2BA--.35813S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGry7Xw48uF1UWw4UtF1UWrg_yoW7JFWUpr
	W3JF42kw1rWr17Ca18t3yUJr1Ykw4DWr1xGr1rtr1kCr1qkr4xtF18tr48ua4xZrWkJF1U
	Wr1kJF9xZryDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/03 16:41, Xue He 写道:
> On 2025/09/02 08:47 AM, Yu Kuai wrote:
>> On 2025/09/01 16:22, Xue He wrote:
> ......
>>> This patch aims to allow the remaining I/O operations to retry batch
>>> allocation of tags, reducing the overhead caused by multiple
>>> individual tag allocations.
>>>
>>> ------------------------------------------------------------------------
>>> test result
>>> During testing of the PCIe Gen4 SSD Samsung PM9A3, the perf tool
>>> observed CPU improvements. The CPU usage of the original function
>>> _blk_mq_alloc_requests function was 1.39%, which decreased to 0.82%
>>> after modification.
>>>
>>> Additionally, performance variations were observed on different devices.
>>> workload:randread
>>> blocksize:4k
>>> thread:1
>>> ------------------------------------------------------------------------
>>>                     PCIe Gen3 SSD   PCIe Gen4 SSD    PCIe Gen5 SSD
>>> native kernel     553k iops       633k iops        793k iops
>>> modified          553k iops       635k iops        801k iops
>>>
>>> with Optane SSDs, the performance like
>>> two device one thread
>>> cmd :sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
>>> -n1 -r4 /dev/nvme0n1 /dev/nvme1n1
>>>
>>
>> How many hw_queues and how many tags in each hw_queues in your nvme?
>> I feel it's unlikely that tags can be exhausted, usually cpu will become
>> bottleneck first.
> 
> the information of my nvme like this:
> number of CPU: 16
> memory: 16G
> nvme nvme0: 16/0/16 default/read/poll queue
> cat /sys/class/nvme/nvme0/nvme0n1/queue/nr_requests
> 1023
> 
> In more precise terms, I think it is not that the tags are fully exhausted,
> but rather that after scanning the bitmap for free bits, the remaining
> contiguous bits are nsufficient to meet the requirement (have but not enough).
> The specific function involved is __sbitmap_queue_get_batch in lib/sbitmap.c.
>                      get_mask = ((1UL << nr_tags) - 1) << nr;
>                      if (nr_tags > 1) {
>                              printk("before %ld\n", get_mask);
>                      }
>                      while (!atomic_long_try_cmpxchg(ptr, &val,
>                                                        get_mask | val))
>                              ;
>                      get_mask = (get_mask & ~val) >> nr;
> 
> where during the batch acquisition of contiguous free bits, an atomic operation
> is performed, resulting in the actual tag_mask obtained differing from the
> originally requested one.

Yes, so this function will likely to obtain less tags than nr_tags,the
mask is always start from first zero bit with nr_tags bit, and
sbitmap_deferred_clear() is called uncondionally, it's likely there are
non-zero bits within this range.

Just wonder, do you consider fixing this directly in
__blk_mq_alloc_requests_batch()?

  - call sbitmap_deferred_clear() and retry on allocation failure, so
that the whole word can be used even if previous allocated request are
done, especially for nvme with huge tag depths;
  - retry blk_mq_get_tags() until data->nr_tags is zero;
> 
> Am I missing something?
> 
>>> base: 6.4 Million IOPS
>>> patch: 6.49 Million IOPS
>>>
>>> two device two thread
>>> cmd: sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
>>> -n1 -r4 /dev/nvme0n1 /dev/nvme1n1
>>>
>>> base: 7.34 Million IOPS
>>> patch: 7.48 Million IOPS
>>> -------------------------------------------------------------------------
>>>
>>> Signed-off-by: hexue <xue01.he@samsung.com>
>>> ---
>>>    block/blk-mq.c | 8 +++++---
>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index b67d6c02eceb..1fb280764b76 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -587,9 +587,9 @@ static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
>>>    	if (blk_queue_enter(q, flags))
>>>    		return NULL;
>>>    
>>> -	plug->nr_ios = 1;
>>> -
>>>    	rq = __blk_mq_alloc_requests(&data);
>>> +	plug->nr_ios = data.nr_tags;
>>> +
>>>    	if (unlikely(!rq))
>>>    		blk_queue_exit(q);
>>>    	return rq;
>>> @@ -3034,11 +3034,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>>    
>>>    	if (plug) {
>>>    		data.nr_tags = plug->nr_ios;
>>> -		plug->nr_ios = 1;
>>>    		data.cached_rqs = &plug->cached_rqs;
>>>    	}
>>>    
>>>    	rq = __blk_mq_alloc_requests(&data);
>>> +	if (plug)
>>> +		plug->nr_ios = data.nr_tags;
>>> +
>>>    	if (unlikely(!rq))
>>>    		rq_qos_cleanup(q, bio);
>>>    	return rq;
>>>
>>
>> In __blk_mq_alloc_requests(), if __blk_mq_alloc_requests_batch() failed,
>> data->nr_tags is set to 1, so plug->nr_ios = data.nr_tags will still set
>> plug->nr_ios to 1 in this case.
>>
>> What am I missing?
> 
> yes, you are right, if __blk_mq_alloc_requests_batch() failed, it will set
> to 1. However, in this case, it did not fail to execute; instead, the
> allocated number of tags was insufficient, as only a partial number were
> allocated. Therefore, the function is considered successfully executed.
> 

Thanks for the explanation, I understand this now.

Thanks,
Kuai

>> Thanks,
>> Kuai
>>
> 
> Thanks,
> Xue
> 
> .
> 

