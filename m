Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE81D5CD7
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406143; cv=none; b=o7Pmcn6Wv8a5MGPrW7T3z7qljSY8BNtWhuZJFifp/1ImUT5jSTMn2y1bKt7GJAJs1KK2TcLV0k8APceOwY6m7fnbJCy/q3MPckrBnm/rtEW9JiuKS72JJ5tfthDB/7rzqt/omHJA3Bt6+MDVIq9s8rkgPqu9bKgGpDM/DMN874M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406143; c=relaxed/simple;
	bh=w9t3/1ek/8exz9oNLDSc+3WzKrzn3TwJYuz7kG517gU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RjJSoAU15xl6JQFfqCqAOwlYUJo6VLEPaRevYAJ/gzwgqa4tmEX+2TSmQ5+KQ1tvdWum1/fxMXPohSCpI2actgj8wcmBC9uC+xVACGLXVH+iSFiVtOXs7kGXLrS76+RIgoOuy9HtIB/nvKRK6nnwczjIo74xQkuOarpWifU1bcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bp90k4rMMzYQtHg
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 09:15:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 60E641A0DB4
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 09:15:33 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxS02oJoNDOTBQ--.13411S3;
	Fri, 25 Jul 2025 09:15:33 +0800 (CST)
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk,
 shinichiro.kawasaki@wdc.com, gjoyce@ibm.com, "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250718133232.626418-1-nilay@linux.ibm.com>
 <b7cc0c1c-6027-4f1a-8ca1-e7ac4ae9e5ec@huaweicloud.com>
 <43099391-2279-473d-8c13-70486b96f50f@linux.ibm.com>
 <c339715d-4a4b-0a4a-4d53-86eabe7b5d97@huaweicloud.com>
 <50fc4df5-991d-4076-ab72-eea33b9e5e07@linux.ibm.com>
 <a707901a-1d21-313f-0456-01f419181f2c@huaweicloud.com>
 <19972ca9-804e-407b-a784-ba2566bc907a@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6a06b3a9-dbfd-f9c9-3e41-11d2a9841b74@huaweicloud.com>
Date: Fri, 25 Jul 2025 09:15:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <19972ca9-804e-407b-a784-ba2566bc907a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxS02oJoNDOTBQ--.13411S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xJryftF18KrWxCw4UArb_yoW8tFW7pr
	W5uay3AryDJr4Iy3Z2qa1DGFWYywn3uFW3Zr4Fqr1jkwn0vrn7Xr40y3yY9ay8Arsayw12
	qFyUJFnxuFW8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/07/23 19:05, Nilay Shroff 写道:
> 
> 
> On 7/23/25 12:28 PM, Yu Kuai wrote:
>>>>>> BTW, this is not related to this patch. Should we handle fall_back
>>>>>> failure like blk_mq_sysfs_register_hctxs()?
>>>>>>
>>>>> OKay I guess you meant here handle failure case by unwinding the
>>>>> queue instead of looping through it from start to end. If yes, then
>>>>> it could be done but again we may not want to do it the bug fix patch.
>>>>>
>>>>
>>>> Not like that, actually I don't have any ideas for now, the hctxs is
>>>> unregistered first, and if register failed, for example, due to -ENOMEM,
>>>> I can't find a way to fallback :(
>>>>
>>> If registering new hctxs fails, we fall back to the previous value of
>>> nr_hw_queues (prev_nr_hw_queues). When prev_nr_hw_queues is less than
>>> the new nr_hw_queues, we do not reallocate memory for the existing hctxs—
>>> instead, we reuse the memory that was already allocated.
>>>
>>> Memory allocation is only attempted for the additional hctxs beyond
>>> prev_nr_hw_queues. Therefore, if memory allocation for these new hctxs
>>> fails, we can safely fall back to prev_nr_hw_queues because the memory
>>> of the previously allocated hctxs remains intact.
>>
>> No, like I said before, blk_mq_sysfs_unregister_hctxs() will free memory
>> by kobject_del() for hctx->kobj and ctx->kobj, and
>> __blk_mq_update_nr_hw_queues() call that helper in the beginning.
>> And later in the fall back code, blk_mq_sysfs_register_hctxs() can fail
>> by memory allocation in kobject_add(), however, the return value is not
>> checked.
>>
> This can be done checking the kobject state in sysfs: kobj->state_in_sysfs.
> If kobj->state_in_sysfs is 1 then it implies that kobject_add() for this
> kobj was successful and we can safely call kobject_del() on it otherwise
> we can skip it. We already have few places in the kernel using this trick.
> For instance, check sysfs_slab_unlink(). So, IMO, similar technique could be
> used for hctx->kobj and ctx->kobj as well while we attempt to delete these
> kobjects from unregistering queue and nr_hw_queue update.

I don't like missing sysfs attributes, however I don't have better
solution, I'm good with this.

Thanks,
Kuai

> 
> Thanks,
> --Nilay
> .
> 

