Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126A1369B6;
	Sat, 26 Oct 2024 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924149; cv=none; b=GFk4uyF7yRrwsLzZdhkcRBjQJGV03J/Q4NMAJGDvvvgFFFIlnPlfgR0rKfbrF5kDDJHmpZtH58TxT7c89mDufcj21+rfo58LV7WadfpGMedw/dRn2cb4YUmrzGDPY8bCvNr2JiIHdd2RW7RXoHs6edVVxyhGtFuDtYjxpofpD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924149; c=relaxed/simple;
	bh=+tr7RhxKC7S7ky4N4xFlG/RokkXa1CiUGH6xxNL5blw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BR0DdPYriutlwKprAFlPgREHzsiMlFZKXNH/RdFRP+dLDkMznCEpPKrzeD+jgJswRifU3HdVUubpG7SU8xwms+RQExBMrhX6BTmGS41k1YpOgO5MqbxBbQmO4JfVTPT9hY+0uGwu6l/iKuNaJMg8W+xYFjNu5CkKLceSvp7yFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xb8qj51Cqz4f3kKy;
	Sat, 26 Oct 2024 14:28:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 248861A018D;
	Sat, 26 Oct 2024 14:29:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCn28csjBxniZidFA--.30722S3;
	Sat, 26 Oct 2024 14:29:01 +0800 (CST)
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Yu Kuai <yukuai1@huaweicloud.com>, Yang Erkun <yangerkun@huaweicloud.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com, axboe@kernel.dk,
 ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
 linux-modules@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
 <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
 <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a3e499ec-32a3-7e44-c8fd-3d01cdbee25a@huaweicloud.com>
Date: Sat, 26 Oct 2024 14:28:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28csjBxniZidFA--.30722S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyrAry3uFW8urW3ur43trb_yoW5WFWrpF
	WxWayfKFWkXrWkua1xt3WDZr45KryIyr40qFy3Gr93Zr9Ygry0vF4xGw15CF9rJr1vyry7
	WFW3Ja1xJFyUAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
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

在 2024/10/26 13:55, Tetsuo Handa 写道:
> On 2024/10/26 10:21, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/10/25 18:40, Tetsuo Handa 写道:
>>> On 2024/10/25 16:05, Yang Erkun wrote:
>>>> From: Yang Erkun <yangerkun@huawei.com>
>>>>
>>>> My colleague Wupeng found the following problems during fault injection:
>>>>
>>>> BUG: unable to handle page fault for address: fffffbfff809d073
>>>
>>> Excuse me, but subject says "null pointer" whereas dmesg says
>>> "not a null pointer dereference". Is this a use-after-free bug?
>>> Also, what verb comes after "when modprobe brd" ?
>>>
>>> Is this problem happening with parallel execution? If yes, parallelly
>>> running what and what?
>>
>> The problem is straightforward, to be short,
>>
>> T1: morprobe brd
>> brd_init
>>   brd_alloc
>>    add_disk
>>          T2: open brd
>>          bdev_open
>>           try_module_get
>>    // err path
>>    brd_cleanup
>>            // dereference brd_fops() while module is freed.
> 
> Then, fault injection is irrelevant, isn't it?

Fault injection must involved in the test, brd_init() is unlikely to
fail.
> 
> If bdev_open() can grab a reference before module's initialization phase
> completes is a problem, I think that we can fix the problem with just

Yes, and root cause is that stuff inside module can be freed if module
initialization failed, it's not safe to deference disk->fops in this
case.
> 
>   int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>   	      const struct blk_holder_ops *hops, struct file *bdev_file)
>   {
>   (...snipped...)
>   	ret = -ENXIO;
>   	if (!disk_live(disk))
>   		goto abort_claiming;
> -	if (!try_module_get(disk->fops->owner))
> +	if ((disk->fops->owner && module_is_coming(disk->fops->owner)) || !try_module_get(disk->fops->owner))

This is not a common issue, do you see similiar behaviour for other
drivers? If not, I'll suggest to fix this in brd.

Thanks,
Kuai
>   		goto abort_claiming;
>   	ret = -EBUSY;
>   	if (!bdev_may_open(bdev, mode))
>   (...snipped...)
>   }
> 
> change. It would be cleaner if we can do
> 
>   bool try_module_get(struct module *module)
>   {
>   	bool ret = true;
>   
>   	if (module) {
>   		/* Note: here, we can fail to get a reference */
> -		if (likely(module_is_live(module) &&
> +		if (likely(module_is_live(module) && !module_is_coming(module) &&
>   			   atomic_inc_not_zero(&module->refcnt) != 0))
>   			trace_module_get(module, _RET_IP_);
>   		else
>   			ret = false;
>   	}
>   	return ret;
>   }
> 
> but I don't know if this change breaks something.
> Maybe we can introduce a variant like
> 
> bool try_module_get_safe(struct module *module)
> {
> 	bool ret = true;
> 
> 	if (module) {
> 		/* Note: here, we can fail to get a reference */
> 		if (likely(module_is_live(module) && !module_is_coming(module) &&
> 			   atomic_inc_not_zero(&module->refcnt) != 0))
> 			trace_module_get(module, _RET_IP_);
> 		else
> 			ret = false;
> 	}
> 	return ret;
> }
> 
> and use it from bdev_open().
> 
> 
> .
> 

