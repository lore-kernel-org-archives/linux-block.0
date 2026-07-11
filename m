Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3B35893;
	Sat, 11 Jul 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731135; cv=none; b=GNYo8VMZi9rP71UPsx5RMSFNRU7DzMv9L5EqJx8uLlU1fVjed+Seyv4HQsPXU7+uUc+gs3tUwewbidhSLS01c3qtmmubKJ58KiOAeI3RYcXaPfku+6WKKPppvWW+okVh0YlON8ejqjvqKlzElOp6k0DtlAjlcNb9cSose3dWuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731135; c=relaxed/simple;
	bh=yI1q8qgRPVDzKxMy/O0O+bROmu7ntceN8wiHDVITLMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw1rsIBd8bYaQAyZriB6UHSDy416jWko/ENhlqvr+z0SsUDmiaggwrjOpEVn/iwF/7D94vXNQJY7aERXuJhCUbg1KDdIhmM1QDTaBhqjpeEDlVwKmd1qgfYlGbrRWnZwR+zDqb/jH5QXBiLmFJqj0Gw9OlYAL9j4ZZSladCVkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gxqsC1TmmzKHLxF;
	Sat, 11 Jul 2026 08:51:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3BFBB4057D;
	Sat, 11 Jul 2026 08:52:08 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCXp3O2k1FqopYrAw--.982S3;
	Sat, 11 Jul 2026 08:52:08 +0800 (CST)
Message-ID: <6c02c3eb-3277-4522-8d14-3409c5951d9d@huaweicloud.com>
Date: Sat, 11 Jul 2026 08:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/9] null_blk: free zones array on device power-off
To: Nilay Shroff <nilay@linux.ibm.com>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, dlemoal@kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, bvanassche@acm.org,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-6-wozizhi@huaweicloud.com>
 <c110c8bf-52eb-4f01-b01d-b042178a6002@linux.ibm.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <c110c8bf-52eb-4f01-b01d-b042178a6002@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXp3O2k1FqopYrAw--.982S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfJFyUuFyDCFW8uryfWFg_yoW8Xw47pr
	WfW3Z8tw1DJr17AFykuF1UWF1ru3ykAa4rGry3J34F93s8Ary3trW7CF4rZayDG3ykCr1S
	va98uF1fJ3W5WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Nilay!

在 2026/7/10 22:24, Nilay Shroff 写道:
> On 7/9/26 3:34 PM, Zizhi Wo wrote:
>> null_init_zoned_dev() allocates dev->zones when a zoned device is powered
>> on, but null_del_dev() never frees it on power-off; dev->zones is only
>> freed later in null_free_dev(), when the configfs directory is 
>> removed. If
>> the device is powered off and then on again, null_init_zoned_dev()
>> allocates a new array and overwrites the dev->zones pointer, leaking the
>> previous allocation each power cycle.
>>
>> Free dev->zones in null_del_dev() via null_free_zoned_dev() to solve it.
>> And calling null_del_dev() in null_free_dev() is no longer necessary
>> because every caller already invokes null_del_dev() first: via
>> nullb_group_drop_item() before nullb_device_release(), in the
>> null_add_dev() error path of null_create_dev(), and in 
>> null_destroy_dev().
>> Remove the redundant call.
> 
> Looks good to me.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks for the review!

However, I just checked Sashiko and found that modifying it this way
directly would introduce a problem:

the caller of zone_cond_store() is lock-free, and internally it checks
whether dev->zones exists. This would then create a race with my patch.
The reason there was no problem before is that only
nullb_device_release() or null_exit() frees the dev->zones, which
guarantees that subsequent users won't access the configfs interface.
I'll address this issue in the next version by adding locking to them.

Thanks,
Zizhi Wo

