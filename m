Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9542629D;
	Mon, 28 Oct 2024 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081723; cv=none; b=ucnpeGoWaj9hQKDRa3lpc7BmN67VnvwmtEK0yk45Xi/cWPCqKJXawUQVcPvQmEnLK7IUvMy9i+PJ6utCkERcedlLWDeaD+jN2sm/GUrfmzfqaaDw+mUlqyPT3agMrHO1u4QZnduUraRATqxnVUkTG8cmCUDHB5+WG6O9OhJF2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081723; c=relaxed/simple;
	bh=fi4xyBrEXuaTg527LBr5rHF1RhqIopAP2QD9ydHZHBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH9kVfpny/o6f3DC63jL8xkQIBA4VdGeh4xzGiXRbeGJ0G1KWJrq4rjm5WjzO3DanUW6L9ofnVPLlSYrEJIGkP6be5sJIPSGvlzQ0COmku8aPmAYNOaonlW3g/UCNFCmWdVVeKAvYjXLkxQteUJarviLJ6U1VBySaxLn6npRV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XcH5r6pkBz4f3lW8;
	Mon, 28 Oct 2024 10:14:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 607C11A0196;
	Mon, 28 Oct 2024 10:15:15 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoay8x5nxfOWAA--.65400S3;
	Mon, 28 Oct 2024 10:15:15 +0800 (CST)
Message-ID: <a3aefdff-fdbf-b4b8-ed2d-821b332b4664@huaweicloud.com>
Date: Mon, 28 Oct 2024 10:15:14 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Yu Kuai <yukuai1@huaweicloud.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com, axboe@kernel.dk,
 ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
 linux-modules@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
 <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
 <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>
 <a3e499ec-32a3-7e44-c8fd-3d01cdbee25a@huaweicloud.com>
 <544c2ac3-33ff-46a2-b21d-60a53d64efe5@I-love.SAKURA.ne.jp>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <544c2ac3-33ff-46a2-b21d-60a53d64efe5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoay8x5nxfOWAA--.65400S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW8Kw17GF1rtw45uFy7GFg_yoW5GFWxpr
	WxGa13KF4UXr1qk3WDt3WUAr1rtrWIyr48XryrXrWIy3yq9rnava1fKw4Y9F98CF48CF47
	Xrs5GayxAry8CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/10/26 16:06, Tetsuo Handa 写道:
> On 2024/10/26 15:28, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/10/26 13:55, Tetsuo Handa 写道:
>>> On 2024/10/26 10:21, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2024/10/25 18:40, Tetsuo Handa 写道:
>>>>> On 2024/10/25 16:05, Yang Erkun wrote:
>>>>>> From: Yang Erkun <yangerkun@huawei.com>
>>>>>>
>>>>>> My colleague Wupeng found the following problems during fault injection:
>>>>>>
>>>>>> BUG: unable to handle page fault for address: fffffbfff809d073
>>>>>
>>>>> Excuse me, but subject says "null pointer" whereas dmesg says
>>>>> "not a null pointer dereference". Is this a use-after-free bug?
>>>>> Also, what verb comes after "when modprobe brd" ?
>>>>>
>>>>> Is this problem happening with parallel execution? If yes, parallelly
>>>>> running what and what?
>>>>
>>>> The problem is straightforward, to be short,
>>>>
>>>> T1: morprobe brd
>>>> brd_init
>>>>    brd_alloc
>>>>     add_disk
>>>>           T2: open brd
>>>>           bdev_open
>>>>            try_module_get
>>>>     // err path
>>>>     brd_cleanup
>>>>             // dereference brd_fops() while module is freed.
>>>
>>> Then, fault injection is irrelevant, isn't it?
>>
>> Fault injection must involved in the test, brd_init() is unlikely to
>> fail.
>>>
>>> If bdev_open() can grab a reference before module's initialization phase
>>> completes is a problem, I think that we can fix the problem with just
>>
>> Yes, and root cause is that stuff inside module can be freed if module
>> initialization failed, it's not safe to deference disk->fops in this
>> case.
> 
> Too bad. Then, we have to defer disk_alloc() until module initialization phase
> is guaranteed to return success like loop.c does. Please update patch title and
> description to something like below.
> 
> Subject: brd: defer automatic disk creation until module initialization succeeds
> 
> loop_init() is calling loop_add() after __register_blkdev() succeeds and is
> ignoring disk_add() failure from loop_add(), for loop_add() failure is not
> fatal and successfully created disks are already visible to bdev_open().
> 
> brd_init() is currently calling brd_alloc() before __register_blkdev()
> succeeds and is releasing successfully created disks when brd_init()
> returns an error. This can cause UAF when brd_init() failure raced with
> bdev_open(), for successfully created disks are already visible to
> bdev_open(). Fix this problem by following what loop_init() does.

Tetsuo and Kuai,

This commit msg looks good to me. I couldn't reply to some emails the
other day. Thanks a lot for your discussion and review to make this
problem clear!

Thanks,
Erkun.

