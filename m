Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A5217F3D
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930023; cv=none; b=FPxBCfNAjdOyjsf5f44kKQ1CRGdMJfWS4ZrwWZhTLuOx4KBm1pE9EaOWBSwJRpMhnsZVtUdPhEZrsnhKYEb/MgVqLs7jghPeQga4188mVvqvikNv0RLSGOJDiu+wq8/5mr7OXHLdUG2J4IrJkKNvzgNYMZ9WoanZZxtCBClXcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930023; c=relaxed/simple;
	bh=UTa26hzgajtXGWzJ/Y1O1U83nIdYd2PVEIeqzCr9WwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JH6H2AbVSEq3GC68omYbYqKQMU0/40rQVs5Y2GNtOk4VkV/96l/xU+TeL56TAQFqSRVrs/v6JQD2kPbUJkRnuLmSgadAS6n5QSeuFWF86/Y9JoLGa99bkWImbdc3BJBymhGpy886N4IKsao/dZwv7/xSwBIRDElz7YL5vgYVjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49Q86wGd058110;
	Sat, 26 Oct 2024 17:06:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49Q86wlk058105
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 26 Oct 2024 17:06:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <544c2ac3-33ff-46a2-b21d-60a53d64efe5@I-love.SAKURA.ne.jp>
Date: Sat, 26 Oct 2024 17:06:59 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Yu Kuai <yukuai1@huaweicloud.com>, Yang Erkun
 <yangerkun@huaweicloud.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com, axboe@kernel.dk,
        ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
        linux-modules@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
 <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
 <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>
 <a3e499ec-32a3-7e44-c8fd-3d01cdbee25a@huaweicloud.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <a3e499ec-32a3-7e44-c8fd-3d01cdbee25a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/26 15:28, Yu Kuai wrote:
> Hi,
> 
> 在 2024/10/26 13:55, Tetsuo Handa 写道:
>> On 2024/10/26 10:21, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/10/25 18:40, Tetsuo Handa 写道:
>>>> On 2024/10/25 16:05, Yang Erkun wrote:
>>>>> From: Yang Erkun <yangerkun@huawei.com>
>>>>>
>>>>> My colleague Wupeng found the following problems during fault injection:
>>>>>
>>>>> BUG: unable to handle page fault for address: fffffbfff809d073
>>>>
>>>> Excuse me, but subject says "null pointer" whereas dmesg says
>>>> "not a null pointer dereference". Is this a use-after-free bug?
>>>> Also, what verb comes after "when modprobe brd" ?
>>>>
>>>> Is this problem happening with parallel execution? If yes, parallelly
>>>> running what and what?
>>>
>>> The problem is straightforward, to be short,
>>>
>>> T1: morprobe brd
>>> brd_init
>>>   brd_alloc
>>>    add_disk
>>>          T2: open brd
>>>          bdev_open
>>>           try_module_get
>>>    // err path
>>>    brd_cleanup
>>>            // dereference brd_fops() while module is freed.
>>
>> Then, fault injection is irrelevant, isn't it?
> 
> Fault injection must involved in the test, brd_init() is unlikely to
> fail.
>>
>> If bdev_open() can grab a reference before module's initialization phase
>> completes is a problem, I think that we can fix the problem with just
> 
> Yes, and root cause is that stuff inside module can be freed if module
> initialization failed, it's not safe to deference disk->fops in this
> case.

Too bad. Then, we have to defer disk_alloc() until module initialization phase
is guaranteed to return success like loop.c does. Please update patch title and
description to something like below.

Subject: brd: defer automatic disk creation until module initialization succeeds

loop_init() is calling loop_add() after __register_blkdev() succeeds and is
ignoring disk_add() failure from loop_add(), for loop_add() failure is not
fatal and successfully created disks are already visible to bdev_open().

brd_init() is currently calling brd_alloc() before __register_blkdev()
succeeds and is releasing successfully created disks when brd_init()
returns an error. This can cause UAF when brd_init() failure raced with
bdev_open(), for successfully created disks are already visible to
bdev_open(). Fix this problem by following what loop_init() does.

