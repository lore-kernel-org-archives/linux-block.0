Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F358625;
	Sat, 11 Jul 2026 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728827; cv=none; b=Pt0l7AuKMIqvo+MyM7WUJbLenQ2bLcPsPW1Pc4IqddoD3sOQu5yp9Pu4ek2d3KL6H1Wdg1GFBcvTJU4uV9I7ttVhNAU6dZBfVWx5LIjCIafg0DFSwE0kOl3WXpX9nu7HyQNtx0ZBFBabxa+FzhaTyB3p7940iFwUlT7fa0Lql9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728827; c=relaxed/simple;
	bh=ltu+sKcFmvGqrMvoAk1UMeE+WTljzI2ckcTUw6f6F6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZO0JNU2vG5PHADQ9vJx4JcZGgzG8dsawLnuV0R9/OGVj2KpCNgZpJMFFKTp/hiyDXKNckgxMDx6VhQdMyLeE9s3Sq9h3lyYQTCaP/pzMoBsc56NVbiCyiuTbNoDWL0481MLPyvU6aFze87RZgSJmGEi7MWA0MiEe7xdItgNn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gxq105dhKzYQtdl;
	Sat, 11 Jul 2026 08:13:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1381C40753;
	Sat, 11 Jul 2026 08:13:34 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3OsilFq4GIoAw--.417S3;
	Sat, 11 Jul 2026 08:13:33 +0800 (CST)
Message-ID: <6a6fb589-d103-4950-b3f1-533d6b741800@huaweicloud.com>
Date: Sat, 11 Jul 2026 08:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 7/9] null_blk: reject per-device queue resize for
 shared tag set
To: Nilay Shroff <nilay@linux.ibm.com>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, bvanassche@acm.org,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-8-wozizhi@huaweicloud.com>
 <4dbcbb4a-852e-4ae8-b909-79d1aeeb0799@linux.ibm.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <4dbcbb4a-852e-4ae8-b909-79d1aeeb0799@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3OsilFq4GIoAw--.417S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGry8Xr1Duw1fJFW7WF4fuFg_yoWrCFyfpF
	WkKayUKrW8GF18J3yjg3ZrWFy5AF4kAa4UJrn3KFyrCw47Zr9Y9F1DZw1qgw4DC3ykC3yS
	q3WDZrsa9a4UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/10 20:34, Nilay Shroff 写道:
> On 7/9/26 3:34 PM, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> When shared_tags is enabled, null_setup_tagset() makes the device use the
>> global tag_set, whose driver_data stays NULL. null_map_queues() therefore
>> falls back to the module-wide g_submit_queues/g_poll_queues instead of 
>> any
>> per-device value.
>>
>> Resizing submit_queues or poll_queues via configfs on such a device calls
>> blk_mq_update_nr_hw_queues() on the shared set, shrinking
>> set->nr_hw_queues.  __blk_mq_realloc_hw_ctxs() only grows the
>> q->queue_hw_ctx[] allocation, so on shrink it merely exits and NULLs the
>> now-excess hctx slots. null_map_queues(), however, keeps mapping CPUs 
>> with
>> the unchanged g_submit_queues/g_poll_queues, so mq_map[] ends up pointing
>> at those NULLed hctx slots. blk_mq_map_swqueue() then dereferences the 
>> NULL
>> hctx (hctx->cpumask), crashing the kernel:
>>
>> [  460.218374] KASAN: null-ptr-deref in range 
>> [0x0000000000000098-0x000000000000009f]
>> [  460.219003] CPU: 24 UID: 0 PID: 1492 Comm: sh Not tainted 7.2.0- 
>> rc2+ #67 PREEMPT(full)
>> [  460.219792] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>> BIOS 1.17.0-4.fc41 04/01/2014
>> [  460.220452] RIP: 0010:blk_mq_map_swqueue+0x4db/0x1430
>> ......
>> [  460.228977] Call Trace:
>> [  460.229175]  <TASK>
>> [  460.229354]  blk_mq_update_nr_hw_queues+0xd49/0x11c0
>> [  460.229779]  ? __pfx_blk_mq_update_nr_hw_queues+0x10/0x10
>> [  460.230200]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
>> [  460.230694]  nullb_device_submit_queues_store+0xd9/0x170 [null_blk]
>> [  460.231190]  ? __pfx_nullb_device_submit_queues_store+0x10/0x10 
>> [null_blk]
>> [  460.231776]  ? configfs_write_iter+0x35c/0x4e0
>> [  460.232122]  configfs_write_iter+0x286/0x4e0
>> [  460.232460]  vfs_write+0x52d/0xd00
>> [  460.232779]  ? __x64_sys_openat+0x108/0x1d0
>> [  460.233106]  ? __pfx_vfs_write+0x10/0x10
>> [  460.233413]  ? fdget_pos+0x1cf/0x4c0
>> [  460.233745]  ? fput_close+0x133/0x190
>> [  460.234038]  ? __pfx_expand_files+0x10/0x10
>> [  460.234368]  ksys_write+0xfc/0x1d0
>>
>> Reproducer:
>> modprobe null_blk shared_tags=1 submit_queues=64 poll_queues=1
>> mkdir /sys/kernel/config/nullb/dev
>> echo 1 > /sys/kernel/config/nullb/dev/power
>> echo 1 > /sys/kernel/config/nullb/dev/submit_queues
>>
>> A per-device resize of a shared tag set is meaningless anyway, so 
>> reject it
>> with -EINVAL in nullb_update_nr_hw_queues() when the device is bound 
>> to the
>> global tag_set.
>>
>> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after 
>> an instance has been configured")
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   drivers/block/null_blk/main.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ 
>> main.c
>> index 6d30591abb28..340ecc0a331e 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -380,10 +380,19 @@ static int nullb_update_nr_hw_queues(struct 
>> nullb_device *dev,
>>       int ret, nr_hw_queues;
>>       if (!dev->nullb)
>>           return 0;
>> +    /*
>> +     * A shared tag_set is mapped via the module-wide queue counts, so a
>> +     * per-device resize is meaningless. On shrink it would also leave
>> +     * mq_map[] pointing at NULLed hctx slots, causing a NULL deref in
>> +     * blk_mq_map_swqueue(). Reject it.
>> +     */
>> +    if (dev->nullb->tag_set == &tag_set)
>> +        return -EINVAL;
>> +
> 
> Wouldn't it be simpler to check dev->shared_tags here instead? Since the 
> restriction
> is specifically for devices configured with shared tags, that seems a 
> bit easier to
> reason about than checking whether dev->nullb->tag_set points to the 
> global tag_set.
> Something like this:
> 
> if (dev->shared_tags)
>          return -EINVAL;
> Thanks,
> --Nilay
> 
> 

Thanks for the suggetsion. I'll switch to it in the next version.

Thanks,
Zizhi Wo





