Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD1272E46
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253890; cv=none; b=pXCM0IPrBEgkt2/y1DL+3XXzrGvo5K0qLvSqAklEyzvKY1vSX8QnVoZ8a9QeMu1Ou9/zWNf/atZTeMm3kOOmu8Y65mbYKLtWVCfgmI/ZQn6sfx7+gzizQEHdoTiet9MxkbgVLnkGHYR7JnkZeAoaOVAp6tDWsPCnf7WpMVYQ/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253890; c=relaxed/simple;
	bh=CtQP2nuaAI7WAMoSO24m9V4+2cMHWiOfpBQ5nG5hw8U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dgcozY45547hCEYciPU7dWMCDnh8ntY1vcdu9ETBhBBSj6AiTZanM56QC7JvPJqXrxL1NNU1D5ClSlHkTASRDgVv8/8hq0fI0s74lv54b6JBMEzX3yBklgHiIeIKp/bZHxctSjtjFS9UtnZpPGWuW/kpKZx0x2inDCvqwcvl/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bn4hq4RyqzYQv29
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 14:58:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 56AEC1A12D8
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 14:58:02 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP1 (Coremail) with SMTP id cCh0CgBn2LP4h4BoG+G1BA--.3927S3;
	Wed, 23 Jul 2025 14:58:02 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a707901a-1d21-313f-0456-01f419181f2c@huaweicloud.com>
Date: Wed, 23 Jul 2025 14:58:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <50fc4df5-991d-4076-ab72-eea33b9e5e07@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBn2LP4h4BoG+G1BA--.3927S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1rAFW3Cr4rXFW8Kw47twb_yoWxuF45pr
	WSq3W7CrW8Gr48Jw48ta4DGa43t3Z7Ca4UXryfGFykC3WDCw1qvFW8tr4j9FWDJrs3Aw47
	tFnrJ3yIqr1jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/23 14:24, Nilay Shroff 写道:
> 
> 
> On 7/23/25 6:07 AM, Yu Kuai wrote:
>>>>>     static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>>                                 int nr_hw_queues)
>>>>>     {
>>>>> @@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>>         int prev_nr_hw_queues = set->nr_hw_queues;
>>>>>         unsigned int memflags;
>>>>>         int i;
>>>>> +    struct xarray elv_tbl;
>>>>
>>>> Perhaps:
>>>>
>>>> DEFINE_XARRAY(elv_tbl)
>>> It may not work because then we have to initialize it at compile time
>>> at file scope. Then if we've multiple threads running nr_hw_queue update
>>> (for different tagsets) then we can't use that shared copy of elv_tbl
>>> as is and we've to protect it with another lock. So, IMO, instead creating
>>> xarray locally here makes sense.
>>
>> I'm confused, I don't add static and this should still be a stack value,
>> I mean use this help to initialize it is simpler :)
> 
> Using DEFINE_XARRAY() to initialize a local(stack) variable is not safe because
> the xarray structure embeds a spinlock (.xa_lock), and initializing spinlocks
> in local scope can cause issues when lockdep is enabled.
> Lockdep expects lock objects to be initialized at static file scope to correctly
> track lock dependencies, specifically, when locks are initialized at compile time.
> Please note that lockdep assigns unique keys to lock object created at compile time
> which it can use for analysis. This mechanism does not work properly with local
> compile time initialization, and attempting to do so triggers warnings or errors
> from lockdep.
> 
> Therefore, DEFINE_XARRAY() should only be used for static/global declarations. For
> local usage, it's safer to use xa_init() or xa_init_flags() to initialize the xarray
> dynamically at runtime.

Yes, you're right.
> 
>>>> BTW, this is not related to this patch. Should we handle fall_back
>>>> failure like blk_mq_sysfs_register_hctxs()?
>>>>
>>> OKay I guess you meant here handle failure case by unwinding the
>>> queue instead of looping through it from start to end. If yes, then
>>> it could be done but again we may not want to do it the bug fix patch.
>>>
>>
>> Not like that, actually I don't have any ideas for now, the hctxs is
>> unregistered first, and if register failed, for example, due to -ENOMEM,
>> I can't find a way to fallback :(
>>
> If registering new hctxs fails, we fall back to the previous value of
> nr_hw_queues (prev_nr_hw_queues). When prev_nr_hw_queues is less than
> the new nr_hw_queues, we do not reallocate memory for the existing hctxs—
> instead, we reuse the memory that was already allocated.
> 
> Memory allocation is only attempted for the additional hctxs beyond
> prev_nr_hw_queues. Therefore, if memory allocation for these new hctxs
> fails, we can safely fall back to prev_nr_hw_queues because the memory
> of the previously allocated hctxs remains intact.

No, like I said before, blk_mq_sysfs_unregister_hctxs() will free memory
by kobject_del() for hctx->kobj and ctx->kobj, and
__blk_mq_update_nr_hw_queues() call that helper in the beginning.
And later in the fall back code, blk_mq_sysfs_register_hctxs() can fail
by memory allocation in kobject_add(), however, the return value is not
checked.

I do a quick test to inject failue, the following warning will be
trigered because kobject_del() will still be called while removing the
disk:

[  230.783515] ------------[ cut here ]------------
[  230.784841] kernfs: can not remove 'nr_tags', no directory
[  230.786350] WARNING: CPU: 1 PID: 411 at fs/kernfs/dir.c:1706 
kernfs_remove_by_name_ns+0x140
[  230.788826] Modules linked in: null_blk nbd nvme nvme_core [last 
unloaded: nbd]
[  230.790817] CPU: 1 UID: 0 PID: 411 Comm: bash Not tainted 
6.16.0-rc4-00079-g7136d673eb80-d
[  230.793609] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.16.1-2.fc37 04/04
[  230.795942] RIP: 0010:kernfs_remove_by_name_ns+0x14a/0x160
[  230.797426] Code: 0b 48 83 05 d7 8d 04 0c 01 e9 6a ff ff ff 48 c7 c7 
40 3f 0e 83 48 83 05 0
[  230.801783] RSP: 0018:ffa0000000b1fc28 EFLAGS: 00010202
[  230.802753] RAX: 0000000000000000 RBX: ffffffff8a9bcdc8 RCX: 
0000000000000000
[  230.804056] RDX: 0000000000000002 RSI: ff11003f3fd17f48 RDI: 
00000000ffffffff
[  230.805353] RBP: 0000000000000000 R08: 0000000000000000 R09: 
6761745f726e2720
[  230.806659] R10: 6f6e206e6163203a R11: 203a73666e72656b R12: 
ffffffff828973a0
[  230.807983] R13: ffffffff83130a57 R14: ff1100010fea5380 R15: 
0000000000000000
[  230.809283] FS:  00007fc52f16f740(0000) GS:ff11003fb4610000(0000) 
knlGS:0000000000000000
[  230.810759] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.811810] CR2: 000055d6b57f4b60 CR3: 000000011ac5f006 CR4: 
0000000000771ef0
[  230.812756] PKRU: 55555554
[  230.813130] Call Trace:
[  230.813475]  <TASK>
[  230.813774]  remove_files+0x39/0xc0
[  230.814252]  sysfs_remove_group+0x48/0xf0
[  230.814798]  sysfs_remove_groups+0x31/0x70
[  230.815354]  __kobject_del+0x23/0xe0
[  230.815858]  kobject_del+0x17/0x50
[  230.816323]  blk_mq_unregister_hctx+0x5d/0x80
[  230.816921]  blk_mq_sysfs_unregister+0x7e/0x110
[  230.817536]  blk_unregister_queue+0x8a/0x160
[  230.818122]  __del_gendisk+0x1f9/0x530
[  230.818638]  del_gendisk+0xb3/0x100
[  230.819120]  null_del_dev+0x83/0x1b0 [null_blk]
[  230.819749]  nullb_device_power_store+0x149/0x240 [null_blk]
[  230.820515]  configfs_write_iter+0x10c/0x1d0
[  230.821087]  vfs_write+0x26e/0x6f0
[  230.821528]  ksys_write+0x79/0x180
[  230.821878]  __x64_sys_write+0x1d/0x30
[  230.822254]  x64_sys_call+0x45c4/0x45f0
[  230.822648]  do_syscall_64+0xa7/0x500
[  230.823018]  ? clear_bhb_loop+0x40/0x90
[  230.823408]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  230.823921] RIP: 0033:0x7fc52f263387
[  230.824291] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 
1f 00 f3 0f 1e fa 64 4
[  230.826125] RSP: 002b:00007ffc51e3b338 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[  230.826884] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007fc52f263387
[  230.827603] RDX: 0000000000000002 RSI: 000055d6b57f4b60 RDI: 
0000000000000001
[  230.828331] RBP: 000055d6b57f4b60 R08: 000000000000000a R09: 
00007fc52f2f94e0
[  230.829051] R10: 00007fc52f2f93e0 R11: 0000000000000246 R12: 
0000000000000002
[  230.829770] R13: 00007fc52f336520 R14: 0000000000000002 R15: 
00007fc52f336700
[  230.830493]  </TASK>
[  230.830725] ---[ end trace 0000000000000000 ]---
[  230.831190] ------------[ cut here ]------------
[  230.831662] kernfs: can not remove 'nr_reserved_tags', no directory

And I wonder, syzkaller test should catch this.

Thanks,
Kuai

> 
> Thanks,
> --Nilay
> .
> 

