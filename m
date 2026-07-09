Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270E43935A;
	Thu,  9 Jul 2026 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563433; cv=none; b=Jn0OymuDw38+MPHKCsdylOL3zxSlHlehg/17pq+epxOw47SKhLNkpKcPwNRRFOSPF6AsfRaEjkRKUp1Q73bP+z0Q5RQ3JOvOugQ0KCAjnUK2ojCgdSkwvxkXSTDNJcpf84WHIKDXB2DIG49UUicjEy7qUQ/Vt6hy8a6YHFqv1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563433; c=relaxed/simple;
	bh=qADnxcUJrVnwjGLrsspxP8/PbZ/PpfWZkF01+IcWgRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuFh5XQ2im7++j9KJLbT2Jrty+HHZDTKMxcnqAwMn1Nwxhp1MLqq3OwQgOd6KP6dvE4t25WHhZ5OLovDNsgjsVvtPFe5qhh/Ox9vRS+22WjJn1LMb+191AF4eF62Ot8zkS3db4xCbGfYLzo55lRqAdF2OqasfrQJphSRcaJEdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwdrW57PMzYQtj2;
	Thu,  9 Jul 2026 10:16:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B2C074056B;
	Thu,  9 Jul 2026 10:17:05 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgDH1nKdBE9qzIpBAg--.32466S3;
	Thu, 09 Jul 2026 10:17:05 +0800 (CST)
Message-ID: <264a41dd-b072-490b-aada-c50c46c7a6c6@huaweicloud.com>
Date: Thu, 9 Jul 2026 10:17:01 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/6] null_blk: mark racy configfs attribute accesses
 with READ_ONCE/WRITE_ONCE
To: Nilay Shroff <nilay@linux.ibm.com>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, bvanassche@acm.org,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
 <20260708073917.2172392-7-wozizhi@huaweicloud.com>
 <eef66514-5f53-420c-9b42-5af9c261852c@linux.ibm.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <eef66514-5f53-420c-9b42-5af9c261852c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDH1nKdBE9qzIpBAg--.32466S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF48Wr4ktF1UZF45tr4xWFg_yoW5tr17pr
	18JryUJryUJr18JF4UJr1UJFyUJr1Utw1UJr1UJF18Aw1UJr1jqr1UXFyYgw1UGw4rJr1U
	Xr1UXr1UZryUJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



在 2026/7/9 1:49, Nilay Shroff 写道:
> On 7/8/26 1:09 PM, Zizhi Wo wrote:
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ 
>> main.c
>> index 9e0002e4aeec..fd3c993a67b2 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -346,7 +346,7 @@ static ssize_t                                \
>>   nullb_device_##NAME##_show(struct config_item *item, char *page)    \
>>   {                                    \
>>       return nullb_device_##TYPE##_attr_show(                \
>> -                to_nullb_device(item)->NAME, page);    \
>> +            READ_ONCE(to_nullb_device(item)->NAME), page);    \
>>   }                                    \
>>   static ssize_t                                \
>>   nullb_device_##NAME##_store(struct config_item *item, const char 
>> *page,    \
>> @@ -366,7 +366,7 @@ nullb_device_##NAME##_store(struct config_item 
>> *item, const char *page,    \
>>       else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))     \
>>           ret = -EBUSY;                        \
>>       if (!ret)                            \
>> -        dev->NAME = new_value;                    \
>> +        WRITE_ONCE(dev->NAME, new_value);            \
>>       mutex_unlock(&lock);                        \
>>       if (ret < 0)                            \
>>           return ret;                        \
> 
> So in this series I see that all attribute _store() methods are now 
> protected
> by the file-scoped mutex, which wasn't the case before. If this is 
> intentional,
> have you considered protecting _show() with the same mutex as well? If 
> yes, then
> that would avoid the lockless read/write races without requiring the 
> additional
> READ_ONCE()/WRITE_ONCE() annotations throughout the code.
> 
> Since these configfs attribute accesses are not on the I/O hot path, 
> taking the
> mutex in _show() also seems acceptable from a performance perspective. 
> Earlier
> in the previous series, I suggested using READ_ONCE/WRITE_ONCE because only
> _store() methods using apply_fn attributes were using the lock but that's
> not the case now.
> 
> Thanks,
> --Nilay

Thanks for the suggestion.

Indeed, _store() now takes the lock unconditionally. Otherwise the
else-branch of _store() could run concurrently with
nullb_device_power_store() -> null_add_dev() during power-on and cause
other problems. So taking the lock in _show() directly avoids the races,
without scattering ~a dozen WRITE_ONCE() across two files.

Since this is not a hot path, and I/O hot paths such as
null_complete_cmd() are rejected from writing during power-on anyway,
this is fine.

I'll drop this patch and instead take "lock" in _show() (and in
power_show()) in the next revision.

Thanks,
Zizhi Wo






