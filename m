Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BA2D7DE2;
	Fri,  5 Sep 2025 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056765; cv=none; b=JTU7KjfB4lqMlMqMmOFjFGLyOYOhhjqynT64/afECHEMBJqCIKhH789BR2ErMfykyRp11jGbYzLpu5QKvAqoPBnw0HtqokyQFx45DgNhUkYM6ELd/V7S7kZnxlm0WQUmLGTLihLXqoImf15QpD0+Rciu//tQ5uyR2ptQngch61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056765; c=relaxed/simple;
	bh=HLoSeCRQYxL++oAQkD0DlxnGeb/r/Kj9JsB5JDVRpyc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qFkFJb6eaw28UAnHXJQ5e22iKo9UE2Wd/P2IUxcYkkhCvmWMs5XygdQeiLepnIYQx56GqV3IXwt0RCHS/z+hUYcrnrl3Yl8DCaMd8pAjztIoAp86EfJ3KFmJvjRzefAROhNA7Ft+mUmCtL3q7Lc+hWABSaxkYz3vy5WCpddRrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ75313cMzKHN6S;
	Fri,  5 Sep 2025 15:19:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1FCB51A1436;
	Fri,  5 Sep 2025 15:19:19 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY71jrpowczQBQ--.43501S3;
	Fri, 05 Sep 2025 15:19:18 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
To: Han Guangjiang <gj.han@foxmail.com>, yukuai1@huaweicloud.com
Cc: axboe@kernel.dk, fanggeng@lixiang.com, hanguangjiang@lixiang.com,
 liangjie@lixiang.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangchen11@lixiang.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
 <tencent_F6A864CCCE079BE929924EE899C63BC6A705@qq.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <602194b5-e671-5a1e-65cb-0f770c5efb6a@huaweicloud.com>
Date: Fri, 5 Sep 2025 15:19:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_F6A864CCCE079BE929924EE899C63BC6A705@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY71jrpowczQBQ--.43501S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWfJF1fZFy7Jw1fuF1kGrg_yoW7Xr1rpF
	W3K3W5Cr4kXFnrZa17tr1YgryjyaykAa1UJrn3Jr1fuF1q9r1kK3W8tF42kryDAF4UtFyI
	qF1qq3y8KF1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/09/05 14:53, Han Guangjiang Ð´µÀ:
> Hi,
> 
>>>>>     static inline bool blk_throtl_activated(struct request_queue *q)
>>>>>     {
>>>>> -        return q->td != NULL;
>>>>> +        return q->td != NULL &&
>>>>> +               test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>>>>>     }
>>>> You can just remove the fist checking, p->td must be set if policy is
>>>> enabled. And please make blkcg_policy_enabled() inline function in
>>>> blk-cgroup.h and use it here.
>>> We intentionally kept the q->td != NULL check because we cannot guarantee
>>> that the policy module is fully loaded when this function is called.
>>> If the policy module is not loaded yet, blkcg_policy_throtl.plid might not be
>>> assigned, which could cause the test_bit() check to be incorrect.
>>>
>>> By keeping this check, we ensure that we have at least reached the cgroup
>>> configuration flow, indicating that the policy loading is complete.
>>>
>>> I'm wondering if there are any risks here and whether we should remove
>>> the q->td != NULL check?
>>
>> I think there is none. blk-throttle can't be build as module, if config is n,
>> blk_throtl_bio() is a non-function, if config is y, policy is registered during
>> init. And throtl_init() failure will panic, noted blkcg_policy_register() will
>> never fail for blk-throttle. BTW, policy pid is not a dynamic value at runtime.
> 
> I understand your point, but I think there's still a potential race
> condition during kernel initialization. While blk-throttle is built as a
> built-in module, block devices can also be built as built-in modules, and
> at the same initcall level, the loading order may be unpredictable.
> Additionally, the policy plid is allocated during blk-throttle module
> initialization, so we need to verify this timing issue.
> 
> I conducted an experiment on the qemu platform by adding a BUG() statement
> in the blk_throtl_activated() function:
> 
> ------------[ cut here ]------------
> kernel BUG at block/blk-throttle.h:157!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT_RT SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.17-g69f6c99f1c48 #2
> Hardware name: linux,dummy-virt (DT)
> pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : submit_bio_noacct+0xec/0x388
> lr : submit_bio_noacct+0x40/0x388
> sp : ffff80008135b530
> x29: ffff80008135b530 x28: ffff00000180f000 x27: fffffdffc00876c0
> x26: 0000000000000040 x25: ffff800080a405f0 x24: 0000000000000004
> x23: ffff800080393128 x22: ffff000002720000 x21: ffff0000018c0700
> x20: 0000000000000000 x19: ffff00000207b180 x18: 0000000000000020
> x17: 0000000000000002 x16: 0000000000000002 x15: ffffffffffffffff
> x14: 0000000000000000 x13: ffff800080dff350 x12: ffffffffffffffff
> x11: 0000000000000000 x10: 0000000000000020 x9 : ffff8000804cd088
> x8 : ffff00000180f088 x7 : 0000000000000000 x6 : ffff00000207b1f8
> x5 : 0000000000000008 x4 : ffff0000018c0700 x3 : ffff7fffdee71000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>   submit_bio_noacct+0xec/0x388
>   submit_bio+0xb4/0x150
>   submit_bh_wbc+0x14c/0x1d0
>   block_read_full_folio+0x25c/0x398
>   blkdev_read_folio+0x24/0x38
>   filemap_read_folio+0x34/0xf0
>   do_read_cache_folio+0x150/0x290
>   read_cache_folio+0x1c/0x30
>   read_part_sector+0x48/0xd0
>   read_lba+0x9c/0x180
>   efi_partition+0xa0/0x780
>   bdev_disk_changed+0x238/0x608
>   blkdev_get_whole+0xac/0x150
>   bdev_open+0x28c/0x418
>   bdev_file_open_by_dev+0xe0/0x150
>   disk_scan_partitions+0x74/0x160
>   device_add_disk+0x3f4/0x448
>   virtblk_probe+0x74c/0x920
>   virtio_dev_probe+0x1a4/0x250
>   really_probe+0xb4/0x2b0
>   __driver_probe_device+0x80/0x140
>   driver_probe_device+0xdc/0x178
>   __driver_attach+0x9c/0x1b8
>   bus_for_each_dev+0x7c/0xe8
>   driver_attach+0x2c/0x40
>   bus_add_driver+0xec/0x218
>   driver_register+0x68/0x138
>   __register_virtio_driver+0x2c/0x50
>   virtio_blk_init+0x74/0xd0
>   do_one_initcall+0x64/0x290
>   kernel_init_freeable+0x214/0x408
>   kernel_init+0x2c/0x1f0
>   ret_from_fork+0x10/0x20
> 
>>From the experimental results, we can see that virtio block device is 
> executing blk_throtl_activated() during initialization in do_one_initcall()
> when loading virio-blk module_init().
> 
> Combined with the information that blk-throttle is also loaded as a
> built-in module, there exists a scenario where the block device probes
> first, at which point the plid has not been allocated yet, and
> blk_throtl_activated() is executed, followed by the loading of the
> blk-throttle built-in module.
> 
> Given this experimental evidence, I'm wondering if we should consider
> keeping the q->td != NULL check as a safeguard against this initialization
> race condition. I'd appreciate your thoughts on this matter.
> 

Yes, this make sense, thanks for the explanation. Please add comments
about this as well.

Thanks,
Kuai

> Thanks,
> Han Guangjiang
> 
> .
> 

