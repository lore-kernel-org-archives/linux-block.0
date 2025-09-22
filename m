Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77C1E502
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511065; cv=none; b=pjqoZlHVBc7l1qy6VsQ+MFPN48IYyZGEwRGjzjfV1zoplF6wyilZ5CUjuXi/4pVPodF+UtCbmjQhvCRteGdUuyAoO770Vo7zIPkHCK6eaIhJYPIUlDsTRxSebYwAhmFDJeGHRaXhc5X7ZXHwcngN9r4LbHkGY0Dh6wBOCfLC5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511065; c=relaxed/simple;
	bh=QQ42ZZ8O4LGeiJOjis/pjV0iVMMyly84yb3jPiPnG6I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pEI3RrJ32Ggluh//fDAzmy5M3hb9AckVsNiKZBDCOgvYtl/mMneizUXomnl5LcB6IKnqcXWyup0ZXTSlSGrNYoR/DHydEPjF1v5b2i5c7zfI4gQMr9ppMeWqQFcSbeUawCFiuWG5GYE7QwKjIj6grifasMhoKetNYGzXgvP4UoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cVSwJ0rlLzKHLxs
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 11:17:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F6191A0D5E
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 11:17:39 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHRv9BoGLudAQ--.16913S3;
	Mon, 22 Sep 2025 11:17:39 +0800 (CST)
Subject: Re: [PATCH 0/1] tests/throtl: add a deadlock regression test
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: ming.lei@redhat.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
 <669ded18-b383-493d-a9a2-839929a10a92@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a86cfb3e-acab-44ca-2fbb-1039bb6f6b80@huaweicloud.com>
Date: Mon, 22 Sep 2025 11:17:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <669ded18-b383-493d-a9a2-839929a10a92@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mHRv9BoGLudAQ--.16913S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr47GrWkArW5Jw4DJr47urg_yoW7tw18p3
	y3GryxArn8JryUArWrAr4kK34xAF4DG34UAr93Krn3uF1UAr1DX3WUCF18Kr9rCrykArWF
	y3W7Cr1DJwnrJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/21 20:19, Nilay Shroff 写道:
> 
> 
> On 9/18/25 2:23 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> While I'm looking at another deadlock issue for blk-throtl, it's found
>> during test that lockdep is reporting another issue quite eazy, I'm
>> adding regerssion test for now, if anyone is interested. Otherwise, I'll
>> go back for this after I finish the problem at hand later.
>>
>> BTW, maybe we can support to test for scsi_debug instead of null_blk for
>> all the throtl tests.
>>
>> Kernel log with patch:
>>
>> [  233.277591] run blktests throtl/004 at 2025-09-18 08:40:41
>> [  233.933598] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
>> [  234.034150] scsi 0:0:0:0: Power-on or device reset occurred
>> [  237.418408]
>> [  237.419010] ======================================================
>> [  237.420951] WARNING: possible circular locking dependency detected
>> [  237.422523] 6.17.0-rc3-00124-ga12c2658ced0 #1665 Not tainted
>> [  237.423760] ------------------------------------------------------
>> [  237.425088] check/1334 is trying to acquire lock:
>> [  237.426111] ff1100011d9d0678 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0x53/0x180
>> [  237.427995]
>> [  237.427995] but task is already holding lock:
>> [  237.429254] ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gendisk+0xba/0x110
>> [  237.431193]
>> [  237.431193] which lock already depends on the new lock.
>> [  237.431193]
>> [  237.432940]
>> [  237.432940] the existing dependency chain (in reverse order) is:
>> [  237.434550]
>> [  237.434550] -> #2 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
>> [  237.435946]        blk_queue_enter+0x40b/0x470
>> [  237.436620]        blkg_conf_prep+0x7b/0x3c0
>> [  237.437261]        tg_set_limit+0x10a/0x3e0
>> [  237.437905]        cgroup_file_write+0xc6/0x420
>> [  237.438596]        kernfs_fop_write_iter+0x189/0x280
>> [  237.439334]        vfs_write+0x256/0x490
>> [  237.439934]        ksys_write+0x83/0x190
>> [  237.440533]        __x64_sys_write+0x21/0x30
>> [  237.441172]        x64_sys_call+0x4608/0x4630
>> [  237.441833]        do_syscall_64+0xdb/0x6b0
>> [  237.442460]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  237.443283]
>> [  237.443283] -> #1 (&q->rq_qos_mutex){+.+.}-{4:4}:
>> [  237.444201]        __mutex_lock+0xd8/0xf50
>> [  237.444823]        mutex_lock_nested+0x2b/0x40
>> [  237.445491]        wbt_init+0x17e/0x280
>> [  237.446068]        wbt_enable_default+0xe9/0x140
>> [  237.446768]        blk_register_queue+0x1da/0x2e0
>> [  237.447477]        __add_disk+0x38c/0x5d0
>> [  237.448079]        add_disk_fwnode+0x89/0x250
>> [  237.448741]        device_add_disk+0x18/0x30
>> [  237.449394]        virtblk_probe+0x13a3/0x1800
>> [  237.450073]        virtio_dev_probe+0x389/0x610
>> [  237.450648]        really_probe+0x136/0x620
>> [  237.451141]        __driver_probe_device+0xb3/0x230
>> [  237.451719]        driver_probe_device+0x2f/0xe0
>> [  237.452267]        __driver_attach+0x158/0x250
>> [  237.452802]        bus_for_each_dev+0xa9/0x130
>> [  237.453330]        driver_attach+0x26/0x40
>> [  237.453824]        bus_add_driver+0x178/0x3d0
>> [  237.454342]        driver_register+0x7d/0x1c0
>> [  237.454862]        __register_virtio_driver+0x2c/0x60
>> [  237.455468]        virtio_blk_init+0x6f/0xe0
>> [  237.455982]        do_one_initcall+0x94/0x540
>> [  237.456507]        kernel_init_freeable+0x56a/0x7b0
>> [  237.457086]        kernel_init+0x2b/0x270
>> [  237.457566]        ret_from_fork+0x268/0x4c0
>> [  237.458078]        ret_from_fork_asm+0x1a/0x30
>> [  237.458602]
>> [  237.458602] -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
>> [  237.459304]        __lock_acquire+0x1835/0x2940
>> [  237.459840]        lock_acquire+0xf9/0x450
>> [  237.460323]        __mutex_lock+0xd8/0xf50
>> [  237.460813]        mutex_lock_nested+0x2b/0x40
>> [  237.461332]        blk_unregister_queue+0x53/0x180
>> [  237.461905]        __del_gendisk+0x226/0x690
>> [  237.462421]        del_gendisk+0xba/0x110
>> [  237.462903]        sd_remove+0x49/0xb0 [sd_mod]
>> [  237.463457]        device_remove+0x87/0xb0
>> [  237.463939]        device_release_driver_internal+0x11e/0x230
>> [  237.464607]        device_release_driver+0x1a/0x30
>> [  237.465162]        bus_remove_device+0x14d/0x220
>> [  237.465700]        device_del+0x1e1/0x5a0
>> [  237.466167]        __scsi_remove_device+0x1ff/0x2f0
>> [  237.466735]        scsi_remove_device+0x37/0x60
>> [  237.467260]        sdev_store_delete+0x77/0x100
>> [  237.467789]        dev_attr_store+0x1f/0x40
>> [  237.468277]        sysfs_kf_write+0x65/0x90
>> [  237.468766]        kernfs_fop_write_iter+0x189/0x280
>> [  237.469339]        vfs_write+0x256/0x490
>> [  237.469800]        ksys_write+0x83/0x190
>> [  237.470266]        __x64_sys_write+0x21/0x30
>> [  237.470767]        x64_sys_call+0x4608/0x4630
>> [  237.471276]        do_syscall_64+0xdb/0x6b0
>> [  237.471766]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  237.472404]
>> [  237.472404] other info that might help us debug this:
>> [  237.472404]
>> [  237.473304] Chain exists of:
>> [  237.473304]   &q->sysfs_lock --> &q->rq_qos_mutex --> &q->q_usage_counter(queue)#3
>> [  237.473304]
> 
> I think we should acquire ->freeze_lock first followed by ->rq_qos_mutex.
> For reference, please see blkg_conf_open_bdev_frozen().
> 
This is a bit complicated, blkg_conf_prep() can be called when user set
per blkg limit, and blk_queue_enter() is called in this case to protect
concurrent deactivating policy.

We can blk blk_queue_enter() before rq_qos_mutex(), however, we can't do
this in blkg_conf_open_bdev() as it's also called when queue is about to
be freezed. And add a new helper to do this will need lots of code
chagnes.

Just wonder, we have blkcg_mutex grabbed in blkcg_deactivate_policy(),
can we use this lock instead of q_usage_counter to protect creating new
blkg in blkg_conf_prep()?

Thanks,
Kuai

> Thanks,
> --Nilay
> 
> .
> 

