Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536293595C;
	Wed, 27 Aug 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256699; cv=none; b=ukahdxI4gcPybLZyrcQoV3zAy9YXOSAIPumh8IlSfBsyx9APxaTxTClg6+MHy/gDQQtNiUgfH2ZhhrlwyqCSO3k6AnxqRvbbQP9nY+pS8FmIG+N7Tj0ffWbyY78V7xA1BQdrFAhS+4c19dsenIr1yjC27jmYpBvKE6dYtDTgaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256699; c=relaxed/simple;
	bh=im/yyJPWw9z8MWz+oN+9i7p6GI5Cr82VhO+TZb7vWvo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FDmK6dF+NMZhMjs8Do/0qGjMuvaqFI2xOHxyM3M3razJCNeTGyo2mcS2Gzim+FOYEySEpvIEeySZU3H98XlygrzbRVHNb1qm08eNj3e80TJP8AQ9pVmt5hnQ0h/Ipct9eiglBLAnjaEJ5pbKr8JOwr/kxVPt+Np3pplvqOkuKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cBRC43lNZzYQvKR;
	Wed, 27 Aug 2025 09:04:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0F1A61A0CD9;
	Wed, 27 Aug 2025 09:04:47 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY2tWa5oSKmtAQ--.45380S3;
	Wed, 27 Aug 2025 09:04:46 +0800 (CST)
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
To: Ming Lei <ming.lei@redhat.com>, linan666@huaweicloud.com
Cc: axboe@kernel.dk, jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
Date: Wed, 27 Aug 2025 09:04:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aK5YH4Jbt3ZNngwR@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY2tWa5oSKmtAQ--.45380S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3uFyUur4fGr13KF47XFb_yoW5Jr17pr
	Z3G3Wak34Dtr4jva12van7Wryaka1kJr18ZrZ3ZryFq34q9rnaqr4vyFyUJFW0yrZ3CF4I
	qa1UJasxCr409aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/27 8:58, Ming Lei Ð´µÀ:
> On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> In __blk_mq_update_nr_hw_queues() the return value of
>> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> 
> Looks we should check its return value and handle the failure in both
> the call site and blk_mq_sysfs_register_hctxs().

 From __blk_mq_update_nr_hw_queues(), the old hctxs is already
unregistered, and this function is void, we failed to register new hctxs
because of memory allocation failure. I really don't know how to handle
the failure here, do you have any suggestions?

Thanks,
Kuai

> 
>> fails, later changing the number of hw_queues or removing disk will
>> trigger the following warning:
>>
>>    kernfs: can not remove 'nr_tags', no directory
>>    WARNING: CPU: 2 PID: 637 at fs/kernfs/dir.c:1707 kernfs_remove_by_name_ns+0x13f/0x160
>>    Call Trace:
>>     remove_files.isra.1+0x38/0xb0
>>     sysfs_remove_group+0x4d/0x100
>>     sysfs_remove_groups+0x31/0x60
>>     __kobject_del+0x23/0xf0
>>     kobject_del+0x17/0x40
>>     blk_mq_unregister_hctx+0x5d/0x80
>>     blk_mq_sysfs_unregister_hctxs+0x94/0xd0
>>     blk_mq_update_nr_hw_queues+0x124/0x760
>>     nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>>     nullb_device_submit_queues_store+0x92/0x120 [null_blk]
>>
>> kobjct_del() was called unconditionally even if sysfs creation failed.
>> Fix it by checkig the kobject creation statusbefore deleting it.
>>
>> Fixes: 477e19dedc9d ("blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   block/blk-mq-sysfs.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>> index 24656980f443..5c399ac562ea 100644
>> --- a/block/blk-mq-sysfs.c
>> +++ b/block/blk-mq-sysfs.c
>> @@ -150,9 +150,11 @@ static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
>>   		return;
>>   
>>   	hctx_for_each_ctx(hctx, ctx, i)
>> -		kobject_del(&ctx->kobj);
>> +		if (ctx->kobj.state_in_sysfs)
>> +			kobject_del(&ctx->kobj);
>>   
>> -	kobject_del(&hctx->kobj);
>> +	if (hctx->kobj.state_in_sysfs)
>> +		kobject_del(&hctx->kobj);
> 
> It is bad to use kobject internal state in block layer.
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 

