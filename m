Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A191D9663;
	Fri,  5 Sep 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055555; cv=none; b=qBJxNz1+LeOJlgzKqE2cI9w6oO1QpNN9xncDG8+lOynocZDOpkKAzSvF/3lWYOcuWmcEZLuVTBwAhASOoUp49N8t6iLy5PYCXV2DU3bEpCptJndB/jqg+DdiVKlxDqHAZgCWLaYVeRtOtYyDOhcvPWVstLxhDhcHnhXQMQoMbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055555; c=relaxed/simple;
	bh=GCymIAAz+qgJ568yGWceZTlQrmAP9ECs9uIP5Bj7Z6k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DIJ6Vzzy25b69M/11g5iLln/P23KjsO6AsvjNKjo/Pk+lDNB1MBQO8b6vPTlTAvrhRHMq5vPzowO7o7b3XyGDj9n3KMgAwFa9KZVHmQM55GaUF+R4GYwIyBPWqD1CdXB2goY+nrtSPshRh1kbFNxg3z0cNf42TofwhCQo2S4Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bZL3kugS; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bZL3kugS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757055243;
	bh=zG32oskllLDTV9iENtVUUWrH0a2xe00cXMqSoc2pacs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZL3kugSRKfgnTui3iHwqVFrfDNpT5Y1O6ycIGOUmHGHdbSWZAbn2dGS6QLhK/36J
	 vYOAxu6ceJFzRcCUAE0t5U/z0/7NwOU69JVRebfA9Xk3LqN8KEdXn/T3ybwZq9KmHH
	 +YKbSpYI/SpShc1gUWEcHdXmO9bPjnPjTUQ7Zvo8=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D6F050B6; Fri, 05 Sep 2025 14:53:47 +0800
X-QQ-mid: xmsmtpt1757055227t6bzsb5ab
Message-ID: <tencent_F6A864CCCE079BE929924EE899C63BC6A705@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NzFK+BtdDdfkcQNPpMJOdx0xsk2IqOcb1TU1n/qMItJiYqME34F
	 4T5hqRG90iZduHwBfSx50kjl9upmQFMO+250lD9+poS/vMTUrR9qdnQuwwJSuTbunzVvUzGRdqTO
	 hePgOo0LkSJrWQVrn7WhaiFd7BDkgJhlIlTidIKmDhF9GFzNooa6aBC6oqQNHdwHhVvB5haGFRO0
	 rSvnCThEMMpEe2azlR7B2CE9ereGGL9mPSmW386TKMqJGVKZfQnxf+7k5Sx0Myk76K7bq4SQP61v
	 V35YRXUPT3mTFk8JhHjjd1mFLi1WtDVNhHpWEoBe+gmn1VwPfbtQ/5r1Wkd/ekSQL8UDY9cHZJlB
	 mGsVVRbUiOvb3la0poGBhTM5vEQjamcQYu8udMbvkcAcSSrBFiR8D8fjP5suir+5DvjuyEvozetH
	 JSc2tlnNqTsEj+5BpZLpibHG0xXbIT+cNNfWdRggH5auYv4fEoIflV0oKPsUG0PXLpoynQW9Hb6x
	 uuEJnRKjqVwsm+uvuH5Ad5BfLLNt6T+nXuPY41DfGgCCmnKHicgLCfGLYBjqNmb4bs4MM4kRqiKS
	 P6fMJuSMTWndRHu+m4GfbSZYRAQnW94SH2w6qm3y3N85TKVyNOScXYKcL6lDxIXnLfKZC/luQIHi
	 LGY3p4WxDR4v+u8R3Mqdzt6v61mr4DdhgdihgHE0tgajjfc49x8RSr7k+Q8H5flJsyOeiC8B+YRH
	 3r6/7xX/4/a3KDxEQOtchtp1XBotL7fug3tRCzcAeIyoKKoEiFebV13yZTTUK/zUlm7xvwFXY53A
	 759vPY2kAW69LLNJNkDEo+vTfbC+6fGY14t0z4sfQeucXYHgUNPqf4xJnyL4QH7id0FfacbgFCTX
	 DlYCyR5daLBsoHOm7AKcjB7SGL6OseAFZqSW2jCqLsj46NXI2MT+NHC+u7jN4n2jr6CXN83+oOmZ
	 YBmvVGMmgRHuMAjajxE/7BjWMd7a6fMwDpAby497wUu3K4/N9XeYyrM1ARNBatZU/FhMoBInzq2C
	 SDnbk2uA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Han Guangjiang <gj.han@foxmail.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com,
	yukuai3@huawei.com
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Fri,  5 Sep 2025 14:53:46 +0800
X-OQ-MSGID: <20250905065346.3345118-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
References: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> >>>    static inline bool blk_throtl_activated(struct request_queue *q)
> >>>    {
> >>> -        return q->td != NULL;
> >>> +        return q->td != NULL && 
> >>> +               test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
> >>>    }
> >> You can just remove the fist checking, p->td must be set if policy is
> >> enabled. And please make blkcg_policy_enabled() inline function in
> >> blk-cgroup.h and use it here.
> > We intentionally kept the q->td != NULL check because we cannot guarantee
> > that the policy module is fully loaded when this function is called.
> > If the policy module is not loaded yet, blkcg_policy_throtl.plid might not be
> > assigned, which could cause the test_bit() check to be incorrect.
> >
> > By keeping this check, we ensure that we have at least reached the cgroup
> > configuration flow, indicating that the policy loading is complete.
> >
> > I'm wondering if there are any risks here and whether we should remove
> > the q->td != NULL check?
> 
> I think there is none. blk-throttle can't be build as module, if config is n,
> blk_throtl_bio() is a non-function, if config is y, policy is registered during
> init. And throtl_init() failure will panic, noted blkcg_policy_register() will
> never fail for blk-throttle. BTW, policy pid is not a dynamic value at runtime.

I understand your point, but I think there's still a potential race 
condition during kernel initialization. While blk-throttle is built as a 
built-in module, block devices can also be built as built-in modules, and 
at the same initcall level, the loading order may be unpredictable. 
Additionally, the policy plid is allocated during blk-throttle module 
initialization, so we need to verify this timing issue.

I conducted an experiment on the qemu platform by adding a BUG() statement 
in the blk_throtl_activated() function:

------------[ cut here ]------------
kernel BUG at block/blk-throttle.h:157!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT_RT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.17-g69f6c99f1c48 #2
Hardware name: linux,dummy-virt (DT)
pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : submit_bio_noacct+0xec/0x388
lr : submit_bio_noacct+0x40/0x388
sp : ffff80008135b530
x29: ffff80008135b530 x28: ffff00000180f000 x27: fffffdffc00876c0
x26: 0000000000000040 x25: ffff800080a405f0 x24: 0000000000000004
x23: ffff800080393128 x22: ffff000002720000 x21: ffff0000018c0700
x20: 0000000000000000 x19: ffff00000207b180 x18: 0000000000000020
x17: 0000000000000002 x16: 0000000000000002 x15: ffffffffffffffff
x14: 0000000000000000 x13: ffff800080dff350 x12: ffffffffffffffff
x11: 0000000000000000 x10: 0000000000000020 x9 : ffff8000804cd088
x8 : ffff00000180f088 x7 : 0000000000000000 x6 : ffff00000207b1f8
x5 : 0000000000000008 x4 : ffff0000018c0700 x3 : ffff7fffdee71000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 submit_bio_noacct+0xec/0x388
 submit_bio+0xb4/0x150
 submit_bh_wbc+0x14c/0x1d0
 block_read_full_folio+0x25c/0x398
 blkdev_read_folio+0x24/0x38
 filemap_read_folio+0x34/0xf0
 do_read_cache_folio+0x150/0x290
 read_cache_folio+0x1c/0x30
 read_part_sector+0x48/0xd0
 read_lba+0x9c/0x180
 efi_partition+0xa0/0x780
 bdev_disk_changed+0x238/0x608
 blkdev_get_whole+0xac/0x150
 bdev_open+0x28c/0x418
 bdev_file_open_by_dev+0xe0/0x150
 disk_scan_partitions+0x74/0x160
 device_add_disk+0x3f4/0x448
 virtblk_probe+0x74c/0x920
 virtio_dev_probe+0x1a4/0x250
 really_probe+0xb4/0x2b0
 __driver_probe_device+0x80/0x140
 driver_probe_device+0xdc/0x178
 __driver_attach+0x9c/0x1b8
 bus_for_each_dev+0x7c/0xe8
 driver_attach+0x2c/0x40
 bus_add_driver+0xec/0x218
 driver_register+0x68/0x138
 __register_virtio_driver+0x2c/0x50
 virtio_blk_init+0x74/0xd0
 do_one_initcall+0x64/0x290
 kernel_init_freeable+0x214/0x408
 kernel_init+0x2c/0x1f0
 ret_from_fork+0x10/0x20

From the experimental results, we can see that virtio block device is 
executing blk_throtl_activated() during initialization in do_one_initcall() 
when loading virio-blk module_init(). 

Combined with the information that blk-throttle is also loaded as a 
built-in module, there exists a scenario where the block device probes 
first, at which point the plid has not been allocated yet, and 
blk_throtl_activated() is executed, followed by the loading of the 
blk-throttle built-in module.

Given this experimental evidence, I'm wondering if we should consider 
keeping the q->td != NULL check as a safeguard against this initialization 
race condition. I'd appreciate your thoughts on this matter.

Thanks,
Han Guangjiang

