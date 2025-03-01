Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF286333
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793245; cv=none; b=msKhe5px0bEY2s14CFY24EqIJpkAZUc3LbX3MqvEBq5iVk7NQjbD5Y1bKCqOVe1Sy8w8dnLbNRGM2IlJ9i8+ZbH90xsLQdjfJQByPJ+3U3mKtsbzzrW1liQ0542MtTR1jFV9Fa4MGMRbK6jqOdNihgIMzDjXEjQvzG6akMmkw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793245; c=relaxed/simple;
	bh=obIbRwkWgsRKIPADwNtADTMKBM5+UMFM9KyNy8asg/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPzU1Ngz51xtYfA9bzwTseGuMreYmrdflKRrCEL8fXOZvNPcp5QlgNFRzcWZClZpC7YW7sP8Ls9kx9T7DdYC6NogISMCwWGmswyvcKr5JteeUJJlNOMg8y1QG8obe8OlcShRS5+1lQ+Ise3HcF1HgUia0QnpnpDA7RagEhWLwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z4SSc2RHgz4f3knt
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 09:40:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49A701A06DC
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 09:40:38 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgCH61+UZcJnzpTHFA--.57036S3;
	Sat, 01 Mar 2025 09:40:38 +0800 (CST)
Message-ID: <bd8d7664-fc1d-767a-cceb-9381af688ba4@huaweicloud.com>
Date: Sat, 1 Mar 2025 09:40:36 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [BUG report] WARNING of sysfs in __blk_mq_update_nr_hw_queues()
To: Nilay Shroff <nilay@linux.ibm.com>, Li Nan <linan666@huaweicloud.com>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>,
 "wanghai (M)" <wanghai38@huawei.com>
References: <0ef71f91-eaec-f268-7d29-521fdcecc5ca@huaweicloud.com>
 <7f0a3ae7-9659-426d-9595-fff9b14149fe@linux.ibm.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <7f0a3ae7-9659-426d-9595-fff9b14149fe@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61+UZcJnzpTHFA--.57036S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DCrWDAF1xGw1rAFW5ZFb_yoW8Cr1xpF
	W5Wa9Igw1DG3y8Zw4xAanFgFyYy3Z5Cas8Xrsaqr129w1jy3s5Jr48AF1qvFW8CrZavF4I
	q3W0vrZ3C3WkuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/2/28 15:13, Nilay Shroff 写道:
> 
> 
> On 2/28/25 7:52 AM, Li Nan wrote:
>> Hi,
>>
>> In __blk_mq_update_nr_hw_queues(), we don't check the return value of
>> blk_mq_sysfs_register_hctxs(). When sysfs creation fails, there's no
>> proper error handling. This leads to a kernel warning during subsequent
>> __blk_mq_update_nr_hw_queues() calls or disk removal:
>>
>> ```
>> kernfs: can not remove 'nr_tags', no directory
>> WARNING: CPU: 2 PID: 805 at fs/kernfs/dir.c:1703 kernfs_remove_by_name_ns+0x12e/0x140
>> Call Trace:
>>   <TASK>
>>   remove_files+0x39/0xb0
>>   sysfs_remove_group+0x48/0xf0
>>   sysfs_remove_groups+0x31/0x60
>>   __kobject_del+0x23/0xf0
>>   kobject_del+0x17/0x40
>>   blk_mq_unregister_hctx+0x5d/0x80
>>   blk_mq_sysfs_unregister_hctxs+0x89/0xd0
>>   blk_mq_update_nr_hw_queues+0x31c/0x820
>>   nullb_update_nr_hw_queues+0x71/0xe0 [null_blk]
>>   nullb_device_submit_queues_store+0xa4/0x130 [null_blk]
>> ```
>>
>> Should we add error checking for blk_mq_sysfs_register_hctxs() and
>> propagate the error to abort the update operation when it fails? This
>> would prevent subsequent operations from hitting invalid sysfs entries.
>>
> IMO, yes error checking should be added here. However it will be tricky
> to undo everything as the error might have happened deep inside loop. We
> need to carefully delete all sysfs objects added under each hctx->kobj.
> BTW, typically, we don't abort the nr_hw_queue update operation but
> instead fallback to the previously configured number of hw queues.
> 
> Thanks,
> --Nilay
> 
> .

Yes, this is troublesome and cannot simply return an error because the old
kobj has already been released, and re-alloc is likely to fail again due to
insufficient memory.

-- 
Thanks,
Nan

