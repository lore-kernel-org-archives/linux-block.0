Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AA2472AE;
	Tue,  7 Jul 2026 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412661; cv=none; b=Sg9uWDzlkyBRBszHBi45tbKvP/NgpOV1BO9xtJSMTZCX25qFTqex15N8fdVlOp7BYmdqMsH9+JSrNf2rK8Qf/Cl5YyT3jen2y8K51svNYKjG6yT2VJoC3z13NoJQIH38dg9eqxe6Wpfmrp+82/MhCbXnIfn29MUuMZqs1GvTaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412661; c=relaxed/simple;
	bh=RdcY0+BSF7zN8poPmSC1SmtJ9BTekWE1dFvECPIYLT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Du5HJqZ+cHt6YW6d4JlB3A972Um/cUMQHBsYcifosnet9erxc272irF7qGm4Gkm1W/S5Ac4RNi1fexbGuMtQntBXikKDKWwjlnLdReAvUf1ezYocpqqN5X6fPIxkLMswU7GA21DrEjlCeKhqjNADCxERZZINBnwmtOp3fuI5ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvZ5002wTzYQtkV;
	Tue,  7 Jul 2026 16:24:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 06C464056E;
	Tue,  7 Jul 2026 16:24:07 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgC3xnKlt0xqV5pvAQ--.791S3;
	Tue, 07 Jul 2026 16:24:06 +0800 (CST)
Message-ID: <13de8932-e9a4-4d29-8d98-4d3eb0bd91cd@huaweicloud.com>
Date: Tue, 7 Jul 2026 16:24:04 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] null_blk: don't locklessly overwrite dev state
 after apply_fn
To: Nilay Shroff <nilay@linux.ibm.com>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org,
 kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
 bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-6-wozizhi@huaweicloud.com>
 <94fcb5aa-0b1a-4d32-bc07-fd939367c6ee@linux.ibm.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <94fcb5aa-0b1a-4d32-bc07-fd939367c6ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3xnKlt0xqV5pvAQ--.791S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1kJr43ZF4fWFW3Wr15Jwb_yoWrKr1xpr
	48Jr1UJryUJr1xJr4UJw1UXFyrJr1UJw1UGr1UJF1UA34UJr1jqr1UXF1jgw1UJw48Jr15
	Xr1UXr1UZr1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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



在 2026/7/7 15:33, Nilay Shroff 写道:
> On 7/7/26 8:25 AM, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> The NULLB_DEVICE_ATTR macro unconditionally writes dev->NAME = new_value
>> after apply_fn() returns. For attributes with an apply_fn (submit_queues,
>> poll_queues), apply_fn already sets dev->NAME under &nullb_list_lock.
>>
>> configfs serializes writes via a per-open-file mutex (buffer->mutex), so
>> two threads writing to the same attribute through separate open file
>> descriptions run the store callback concurrently. The macro's write is
>> redundant and lockless, so a concurrent store's losing thread can 
>> overwrite
>> the winner's value after apply_fn set it, making dev->submit_queues
>> mismatch the hardware state. null_map_queues() then hits a 
>> WARN_ON_ONCE and
>> falls back to a single queue.
>>
>> Restructure the macro so that apply_fn attributes return directly after
>> apply_fn, and only non-apply_fn attributes write dev->NAME -- those are
>> only changeable while not CONFIGURED and have no live hardware state to
>> mismatch.
>>
>> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after 
>> an instance has been configured")
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   drivers/block/null_blk/main.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ 
>> main.c
>> index cab51301560e..e7555c47b671 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -360,13 +360,15 @@ nullb_device_##NAME##_store(struct config_item 
>> *item, const char *page,    \
>>       ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>>       if (ret < 0)                            \
>>           return ret;                        \
>> -    if (apply_fn)                            \
>> +    if (apply_fn) {                            \
>>           ret = apply_fn(dev, new_value);                \
>> -    else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))     \
>> -        ret = -EBUSY;                        \
>> -    if (ret < 0)                            \
>> -        return ret;                        \
>> -    dev->NAME = new_value;                        \
>> +        if (ret < 0)                        \
>> +            return ret;                    \
>> +    } else {                            \
>> +        if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))    \
>> +            return -EBUSY;                    \
>> +        dev->NAME = new_value;                    \
>> +    }                                \
>>       return count;                            \
>>   }                                    \
>>   CONFIGFS_ATTR(nullb_device_, NAME);
> 
> Your patch correctly addresses the synchronization issue regarding the
> apply_fn attributes under the nullb_list_lock. However, even with this
> restructuring, the 'else' block remains vulnerable to concurrent
> unmarked accesses to dev->NAME.
> 
> It seems when the device is not powered on, multiple threads can still
> concurrently call the _show and _store callbacks on the same attribute
> across separate open configfs file descriptions.
> 
> While this may be considered a benign data race, it can trigger KCSAN
> splats and may allow the compiler to perform potentially unsafe 
> optimization
> heuristics (such as load/store tearing or merging). So I think we should
> at-least mark those accesses using WRITE_ONCE() and READ_ONCE(). This also
> help silence the KCSAN splat if it's configured.
> 
> Thanks,
> --Nilay
> 

Thanks for catching this! The 'else' path can indeed be accessed
concurrently; I'd left it alone earlier assuming there was no real
impact, but from the angle you described, adding READ_ONCE()/
WRITE_ONCE() does make sense. I'll fix this in the next version.

Thanks,
Zizhi Wo





