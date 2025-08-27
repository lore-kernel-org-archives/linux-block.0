Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A330CD98;
	Wed, 27 Aug 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264934; cv=none; b=FbPIRzoaIjFaTisz7OVFK1P+rQlOStBqw9hjbcnerLd0a4fo8TDFWPfV3dOF1ByY/egTPIsL9Eb2Aby8DoJwH3Nz8V7GWDuozEVPqqYEOn7+66U5zCRH0OGsF8hvGFKHIbsdvZB8hbLuX5gpkUo60dqdoqZ9yadANdkPgNzXYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264934; c=relaxed/simple;
	bh=XfOhz1jxPWqok8rdhjGzlCjQcqFV+0wL+yVgmuQ/ziQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B24kBpSRgcRcpZ0YjGzm87Ly/bgsZBMBqEeQ0BMmzyKLhWEz5aRhCd2seLe7Qydwj3chpQ/pVkiGRrePiVEpZtNnaCup2KHxFpftxiGg3ulFDlHZVoi9aYZHVGBI+mnBOl7Qgu45j4m6nNT2IINItn6zw94xcXi49ByV/EHx6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cBVFY6hLdzYQv5q;
	Wed, 27 Aug 2025 11:22:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 734D81A018D;
	Wed, 27 Aug 2025 11:22:08 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izeea5o0qi4AQ--.46201S3;
	Wed, 27 Aug 2025 11:22:08 +0800 (CST)
Message-ID: <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
Date: Wed, 27 Aug 2025 11:22:06 +0800
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
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk, jianchao.w.wang@oracle.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <aK5g-38izFqjPk9v@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Izeea5o0qi4AQ--.46201S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Gry7XFWkAF1xZrWxtF4UXFb_yoW8Jry7pF
	Z5Ca48Kr1Dtr4293Wjvws7GFyYkrs7Gr43Zr98JryS9wnF9r95tr4xKF4DWFW8Ars7A3WI
	qa1UXFZ3ZFy8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



在 2025/8/27 9:35, Ming Lei 写道:
> On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/27 8:58, Ming Lei 写道:
>>> On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
>>>> From: Li Nan <linan122@huawei.com>
>>>>
>>>> In __blk_mq_update_nr_hw_queues() the return value of
>>>> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
>>>
>>> Looks we should check its return value and handle the failure in both
>>> the call site and blk_mq_sysfs_register_hctxs().
>>
>>  From __blk_mq_update_nr_hw_queues(), the old hctxs is already
>> unregistered, and this function is void, we failed to register new hctxs
>> because of memory allocation failure. I really don't know how to handle
>> the failure here, do you have any suggestions?
> 
> It is out of memory, I think it is fine to do whatever to leave queue state
> intact instead of making it `partial workable`, such as:
> 
> - try update nr_hw_queues to 1
> 
> - if it still fails, delete disk & mark queue as dead if disk is attached
> 

If we ignore these non-critical sysfs creation failures, the disk remains 
usable with no loss of functionality. Deleting the disk seems to escalate
the error?

-- 
Thanks,
Nan

