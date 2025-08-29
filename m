Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70A186284;
	Fri, 29 Aug 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429791; cv=none; b=Zv2UDe4PYTWh/iWADHhl9j5wmwdMUlO0U1Z/fAYkedr8jrKs/taEeKfelqBvY2qSX5K6dXd3Q/tesKt97WluO+ydoReWblGEa2fA6KHnpl7MmRPBX/Jn4r7/r5imPPxaPwaEScqvMj236aikfMDhKhK0wbUvzTsGCRPgYphXarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429791; c=relaxed/simple;
	bh=OSNJxeb6f8xZ8wTa88MgcauiKVXHafhab4YSBYMMqag=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pM2P23Fgmj9W9WDMZ7IMmhCrtpwzkdNXmJ6nRkuN4Ju4/mBsGDC8T+7ubsPlLcjfzcpXez5VsjRvAlpUHIIOfsBvhQfHvw0mJr2yMbUI4YxwUO8+20fwPPrhsIz2XTk41T50jrDxwBcbBrpYGXbckqpTm+VfAiYA1jwOlECTaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCgCw0mq0zYQv8K;
	Fri, 29 Aug 2025 09:09:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9CEE71A1781;
	Fri, 29 Aug 2025 09:09:46 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY3Z_bBoXC+UAg--.37805S3;
	Fri, 29 Aug 2025 09:09:46 +0800 (CST)
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
To: Jens Axboe <axboe@kernel.dk>, Li Nan <linan666@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jianchao.w.wang@oracle.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
 <aK69gpTnVv3TZtjg@fedora>
 <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
 <a74495d4-27ea-4996-abd2-9239b941f221@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5adb469d-9e4b-e2d9-a77c-a1a4d11a49d5@huaweicloud.com>
Date: Fri, 29 Aug 2025 09:09:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a74495d4-27ea-4996-abd2-9239b941f221@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY3Z_bBoXC+UAg--.37805S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW5KFWfKr1rWrW3KF15Jwb_yoW5Wr4xpF
	WUGa1kKr4Dtr47Zw12vw4xGFyayr1kGr4Yqr95JryUC3s09r95tr4xtr4UuF97Gr1kCr4I
	qa1UJFW3ur18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/29 1:23, Jens Axboe 写道:
> On 8/28/25 3:28 AM, Li Nan wrote:
>>
>>
>> ? 2025/8/27 16:10, Ming Lei ??:
>>> On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
>>>>
>>>>
>>>> ? 2025/8/27 9:35, Ming Lei ??:
>>>>> On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> ? 2025/08/27 8:58, Ming Lei ??:
>>>>>>> On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
>>>>>>>> From: Li Nan <linan122@huawei.com>
>>>>>>>>
>>>>>>>> In __blk_mq_update_nr_hw_queues() the return value of
>>>>>>>> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
>>>>>>>
>>>>>>> Looks we should check its return value and handle the failure in both
>>>>>>> the call site and blk_mq_sysfs_register_hctxs().
>>>>>>
>>>>>>    From __blk_mq_update_nr_hw_queues(), the old hctxs is already
>>>>>> unregistered, and this function is void, we failed to register new hctxs
>>>>>> because of memory allocation failure. I really don't know how to handle
>>>>>> the failure here, do you have any suggestions?
>>>>>
>>>>> It is out of memory, I think it is fine to do whatever to leave queue state
>>>>> intact instead of making it `partial workable`, such as:
>>>>>
>>>>> - try update nr_hw_queues to 1
>>>>>
>>>>> - if it still fails, delete disk & mark queue as dead if disk is attached
>>>>>
>>>>
>>>> If we ignore these non-critical sysfs creation failures, the disk remains
>>>> usable with no loss of functionality. Deleting the disk seems to escalate
>>>> the error?
>>>
>>> It is more like a workaround by ignoring the sysfs register failure. And if
>>> the issue need to be fixed in this way, you have to document it. >
>>> In case of OOM, it usually means that the system isn't usable any more.
>>> But it is NOIO allocation and the typical use case is for error recovery in
>>> nvme pci, so there may not be enough pages for noio allocation only. That is
>>> the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?
>>>
>>> But NVMe has been pretty fragile in this area by using non-owner queue
>>> freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
>>> really necessary to take it into account?
>>
>> I agree with your points about NOIO and NVMe.
>>
>> I hit this issue in null_blk during fuzz testing with memory-fault
>> injection. Changing the number of hardware queues under OOM is
>> extremely rare in real-world usage. So I think adding a workaround and
>> documenting it is sufficient. What do you think?
> 
> Working around it is fine, as it isn't a situation we really need to
> worry about. But let's please not do it by poking at kobject internals.
> 

There is already used in someplaces like sysfs_slab_unlink().

Do we prefre add a new hctx->state like BLK_MQ_S_REGISTERED?

Thanks,
Kuai

