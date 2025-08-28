Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BB2E0910;
	Thu, 28 Aug 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373313; cv=none; b=NlR9bT2syrd6krbkbdcfmFM907PxwaeGScOqOOgIfal0+aD+crUEZfvNpXbawgZDgF4JWM4pb3Y+mhTnRB6Svr+c8oUa1GZdBBeghMY1ppPIJukCsUn7jHNFpo+mrkLyC0sFPjCOkmxj87ppH3dPrHXUlhQfv4gxPOG6i8ir/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373313; c=relaxed/simple;
	bh=3LP8Z+RPW5dloclFNTs7hN4RIE1n53EWxwbnP6KzdUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wnz+SkAJw+1GaTSTm8DmRnaMDvZ7w3NcpubSu/GQ10Wpr1GhuL8ixt8sSrSFV8LLpglOeQHk7kE+LsC+dhI+/yMnJhYxWi1L8mSaBU2kqbdqROjjQb1BQ9k9bCV1X8W4k4M2MqVxVezXqKtTd8YcS5BJAqdzrqPHt3U/NzHN9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCGKm2XqPzKHMwh;
	Thu, 28 Aug 2025 17:28:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0D5321A1773;
	Thu, 28 Aug 2025 17:28:28 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY06IbBoUOhIAg--.19147S3;
	Thu, 28 Aug 2025 17:28:27 +0800 (CST)
Message-ID: <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
Date: Thu, 28 Aug 2025 17:28:26 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
To: Ming Lei <ming.lei@redhat.com>, Li Nan <linan666@huaweicloud.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
 <aK69gpTnVv3TZtjg@fedora>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <aK69gpTnVv3TZtjg@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY06IbBoUOhIAg--.19147S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF18Aw48CFy5KFyxAFWUurg_yoW8KF45pF
	WrJa1kKr1DAF47Z3Wjvw4xGFyakrs7Gr4Yvr98Jry5A3sI9r95tr4xKr4DWFWv9rykC3WI
	qa1UXFWfWry8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	vtAUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/27 16:10, Ming Lei 写道:
> On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
>>
>>
>> 在 2025/8/27 9:35, Ming Lei 写道:
>>> On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/08/27 8:58, Ming Lei 写道:
>>>>> On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
>>>>>> From: Li Nan <linan122@huawei.com>
>>>>>>
>>>>>> In __blk_mq_update_nr_hw_queues() the return value of
>>>>>> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
>>>>>
>>>>> Looks we should check its return value and handle the failure in both
>>>>> the call site and blk_mq_sysfs_register_hctxs().
>>>>
>>>>   From __blk_mq_update_nr_hw_queues(), the old hctxs is already
>>>> unregistered, and this function is void, we failed to register new hctxs
>>>> because of memory allocation failure. I really don't know how to handle
>>>> the failure here, do you have any suggestions?
>>>
>>> It is out of memory, I think it is fine to do whatever to leave queue state
>>> intact instead of making it `partial workable`, such as:
>>>
>>> - try update nr_hw_queues to 1
>>>
>>> - if it still fails, delete disk & mark queue as dead if disk is attached
>>>
>>
>> If we ignore these non-critical sysfs creation failures, the disk remains
>> usable with no loss of functionality. Deleting the disk seems to escalate
>> the error?
> 
> It is more like a workaround by ignoring the sysfs register failure. And if
> the issue need to be fixed in this way, you have to document it. >
> In case of OOM, it usually means that the system isn't usable any more.
> But it is NOIO allocation and the typical use case is for error recovery in
> nvme pci, so there may not be enough pages for noio allocation only. That is
> the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?
> 
> But NVMe has been pretty fragile in this area by using non-owner queue
> freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
> really necessary to take it into account?

I agree with your points about NOIO and NVMe.

I hit this issue in null_blk during fuzz testing with memory-fault
injection. Changing the number of hardware queues under OOM is extremely 
rare in real-world usage. So I think adding a workaround and documenting it
is sufficient. What do you think?

> 
> Thanks,
> Ming
> 


-- 
Thanks,
Nan

