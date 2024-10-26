Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1B217F2E
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729905702; cv=none; b=HvKW+JPY0B/6vFFqxY6BYNGaMke0N1unQ9BDF3jvk1Pmti3HbxflUYZqv6eXmU8v917609GG8DgpANsB2+brNf/CU1o+Mrr9JviKF3b9wsIIiYbH/jzLks/RehvXhrlOH3gbGR+6OfSCx33gAP9vnptAmFif6AkooLlyJ/ru0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729905702; c=relaxed/simple;
	bh=g9mKErK/mQ/hhN1sq44PPWG3gUnqta159UnSw0Xecpw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FEI4CE6Y8mz1SxlOi1n2Aeg9m0JFz6gFOzU/TX/7XHY9v4fjDMvVROaD/mOjlVowFOWBkbCMah0nV9WV+KzCrw22p0T7s/v7wGXJJLjhTHikX+hTYvyZPJ2j852E8sid9YnHSvHRuGBbiXBKIP9DViwZY88Tsuspq/q9ObViT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xb20s5Nfxz4f3k5Y
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 09:21:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 309521A058E
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 09:21:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYYRBxnDVKJFA--.12434S3;
	Sat, 26 Oct 2024 09:21:29 +0800 (CST)
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Yang Erkun <yangerkun@huaweicloud.com>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com, axboe@kernel.dk,
 ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
Date: Sat, 26 Oct 2024 09:21:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYYRBxnDVKJFA--.12434S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kCr4fGFWrKF43CryUKFg_yoW8WFW8pr
	yxGayakw4kXa1qyFsFy3Z29rW8taySy3yxWr92gr1Skay5Zrnaqa17tayYva4DGr18CayI
	k398Way8JryrA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/10/25 18:40, Tetsuo Handa 写道:
> On 2024/10/25 16:05, Yang Erkun wrote:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> My colleague Wupeng found the following problems during fault injection:
>>
>> BUG: unable to handle page fault for address: fffffbfff809d073
> 
> Excuse me, but subject says "null pointer" whereas dmesg says
> "not a null pointer dereference". Is this a use-after-free bug?
> Also, what verb comes after "when modprobe brd" ?
> 
> Is this problem happening with parallel execution? If yes, parallelly
> running what and what?

The problem is straightforward, to be short,

T1: morprobe brd
brd_init
  brd_alloc
   add_disk
		T2: open brd
		bdev_open
		 try_module_get
   // err path
   brd_cleanup
  		 // dereference brd_fops() while module is freed.

Thanks,
Kuai

> 
> Is this problem happening with what fault injection?
> What function (exact location in source code with call trace) has
> failed due to fault injection?
> 
>> Call Trace:
>>   <TASK>
>>   blkdev_put_whole+0x41/0x70
>>   bdev_release+0x1a3/0x250
>>   blkdev_release+0x11/0x20
>>   __fput+0x1d7/0x4a0
>>   task_work_run+0xfc/0x180
>>   syscall_exit_to_user_mode+0x1de/0x1f0
>>   do_syscall_64+0x6b/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This suggests that a userspace process has open()ed the device
> before brd_init() from modprobe completed?
> 
> Please show more context including execution flow until crash.
> 
>    CPU0: (or Process1)    CPU1: (or Process2)
>      does what?
>                             does what?
>      does what?
>                             does what and is wrong?
> 
> Also, you don't need to embed brd_cleanup() into the caller
> just because the caller becomes 1 by this change.
> 
> .
> 

