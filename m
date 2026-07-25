Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79E30B51E;
	Sat, 25 Jul 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942554; cv=none; b=gZcvFhCzQu6oe8A/FtLxLI5FN4CBZN/2QsPpfRwyuNkvCD8IGpv/eBOK4u4s8Er75/SaGmaK77vMnWljeJgxMJVSL1Rfsb4tEV41jfkS3DcSKhsNqpz7nykMF3VdN/hE0HotKMrqurnDOht6DftitBsKfe589tUMqB0i3aPMmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942554; c=relaxed/simple;
	bh=GbvpRuuN3KLEXeCYsfnIfsyX/7Jdz3+jh8QZnOeWMbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNcuBP4LZ7NjO3vfXIb6phKXXSnzKLHdDA1l+tqrHyaA/EVghlroGwOd42E8IsOghdoldDatowOkXTWUWZVGH/duaH5vWec2AswhEMOzGM19fQs/63/9h+apPjHlrtortSjtcJ8JP0851ixjha0EP7VJeD1dHEpp9P8wjaXrjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6RsR2ZGbzYQtpF;
	Sat, 25 Jul 2026 09:21:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AFD06409D1;
	Sat, 25 Jul 2026 09:22:20 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCXp3PKD2RqEzLNCQ--.38826S3;
	Sat, 25 Jul 2026 09:22:20 +0800 (CST)
Message-ID: <0059ce6d-5614-4424-8a1a-56e13c2e8081@huaweicloud.com>
Date: Sat, 25 Jul 2026 09:22:18 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 8/9] null_blk: serialize configfs attribute stores with
 device setup
To: Bart Van Assche <bvanassche@acm.org>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, nilay@linux.ibm.com, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-9-wozizhi@huaweicloud.com>
 <75009f4e-7f03-4911-bf51-27377c1ee11a@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <75009f4e-7f03-4911-bf51-27377c1ee11a@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXp3PKD2RqEzLNCQ--.38826S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr45CFyxWry7Gw4kGFyDJrb_yoW8uF18pr
	18Jr1UJryUJr1rJr1UJr1UJryUJr1UJw1UJr1UJF1UJr1UJr1jqr1UXr1jgr1UJr48Jr1U
	Jr1UXr1UZr1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/25 5:13, Bart Van Assche 写道:
> On 7/13/26 9:18 PM, Zizhi Wo wrote:
>>       ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>>       if (ret < 0)                            \
>>           return ret;                        \
>> +    ret = 0;                            \
>> +    mutex_lock(&lock);                        \
>>       if (apply_fn)                            \
>>           ret = apply_fn(dev, new_value);                \
>>       else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))     \
>>           ret = -EBUSY;                        \
>> +    if (!ret)                            \
>> +        dev->NAME = new_value;                    \
>> +    mutex_unlock(&lock);                        \
>>       if (ret < 0)                            \
>>           return ret;                        \
>> -    dev->NAME = new_value;                        \
>>       return count;                            \
>>   }                                    \
> 
> If guard()() would be used instead of explicit mutex_lock() and
> mutex_unlock() calls, the if (ret) test wouldn't have to be duplicated,
> isn't it?

Yes.

> 
> Additionally, the above changes modify the behavior if apply_fn()
> returns a strictly positive value (> 0).
> 
> Bart.

Yes, I made this change because the current apply_fn() never return a
value greater than 0. Thanks for the suggestion. I'll switch to using
guard() in the next version.

Thanks,
Zizhi Wo

