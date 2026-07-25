Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C5326939;
	Sat, 25 Jul 2026 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942830; cv=none; b=FVs0Pu7HWZjs1p4oF2WkqV6WXAVXY+kvty5d3ANlTWYUcG9NYm1MhFa1ll/5Us6dpopsmmuWlLr14ZPBN1tQk6Qy0aWMoVYaLLEUt1gKWbdwUO7tHseKyqU+PnE4A0aZj+N1zkF+uQ7pvczkFVA+cYJ85C5qR4RH6G4VCMmubPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942830; c=relaxed/simple;
	bh=rkkMwtvnUN4gAh8lxTpq04WYg6vbeKWnZ26WZS8Ujc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Chp9oFCon1wEXN1GEZrnAg821fDr4nHA4ocfUFTAxigf5H3rLeJz1AvATkXjyw0NxoREf9EfCUatIY6ABTucAJNI3lXL7lZasVklDlDjxdYFcZM8D+y+S/Vs6jUH5/WU0X05wHEHQXAJGon5aueKP46Jz6e3s+s/nmBDSof/K8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6Ryv2sJbzYQtpF;
	Sat, 25 Jul 2026 09:26:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BE3FA4056B;
	Sat, 25 Jul 2026 09:27:04 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3PnEGRqZprNCQ--.41106S3;
	Sat, 25 Jul 2026 09:27:04 +0800 (CST)
Message-ID: <26340aba-b93c-47d2-b648-2cf732e884d5@huaweicloud.com>
Date: Sat, 25 Jul 2026 09:27:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 9/9] null_blk: serialize configfs attribute shows with
 the file-scope lock
To: Bart Van Assche <bvanassche@acm.org>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, nilay@linux.ibm.com, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-10-wozizhi@huaweicloud.com>
 <30c062e3-1f8b-43a9-8c85-4bc86cd74336@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <30c062e3-1f8b-43a9-8c85-4bc86cd74336@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHV3PnEGRqZprNCQ--.41106S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Kw43JrW8GrykGF1kAFb_yoW5Jw45pr
	18JryUJryUJr18Xr1UGr1UJryUJr1jyw1UJr1UJF18Jw1UJr1jqr1DXryqgw1UJw48Jr1U
	Xr1UXr17Zr1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/25 5:16, Bart Van Assche 写道:
> 
> On 7/13/26 9:18 PM, Zizhi Wo wrote:
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ 
>> main.c
>> index 67cd32d28887..c8487a630e1a 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -345,8 +345,14 @@ static ssize_t nullb_device_bool_attr_store(bool 
>> *val, const char *page,
>>   static ssize_t                                \
>>   nullb_device_##NAME##_show(struct config_item *item, char *page)    \
>>   {                                    \
>> -    return nullb_device_##TYPE##_attr_show(                \
>> +    ssize_t ret;                            \
>> +                                    \
>> +    mutex_lock(&lock);                        \
>> +    ret = nullb_device_##TYPE##_attr_show(                \
>>                   to_nullb_device(item)->NAME, page);    \
>> +    mutex_unlock(&lock);                        \
>> +                                    \
>> +    return ret;                            \
>>   }                                    \
>>   static ssize_t                                \
>>   nullb_device_##NAME##_store(struct config_item *item, const char 
>> *page,    \
>> @@ -479,7 +485,13 @@ NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
>>   static ssize_t nullb_device_power_show(struct config_item *item, 
>> char *page)
>>   {
>> -    return nullb_device_bool_attr_show(to_nullb_device(item)->power, 
>> page);
>> +    ssize_t ret;
>> +
>> +    mutex_lock(&lock);
>> +    ret = nullb_device_bool_attr_show(to_nullb_device(item)->power, 
>> page);
>> +    mutex_unlock(&lock);
>> +
>> +    return ret;
>>   }
> 
> The above changes would be much more elegant if guard()() would be used 
> instead of explicit mutex_lock() and mutex_unlock() calls.
> 
> Thanks,
> 
> Bart.

Thanks Bart. Will switch to using guard() in the next version :)

Thanks,
Zizhi Wo

