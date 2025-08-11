Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C284414;
	Mon, 11 Aug 2025 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903966; cv=none; b=hbOGFhSWypCayrrkvukoF/TMQi8ECyH1L2nnZKFTOxmI7zK+G07O3L6Mt+1NFAIlsweSm2oCpk4Iv72K5NEHA/eVxjljrJyxFuYTvW+VgGsOgCnHUCsDTAqcuQ8zdvtCCcwDLZ7QAkcNsRDOYjcKbqpJXXBfBOzZp+jWU63Elsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903966; c=relaxed/simple;
	bh=Ql1zhFW5m8nhVPYnR1Nif2CLro6WoVkAbY1qIz1B3xM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C+/urgatwQGJzWs39iULMG8gq12eNY9j9/zqLHo5Ds3Fs6tSxGEp2hkok4KaOJ1vwdUudSsVwsOMIdgvNnffV6yaH0yEbhaFz8wj6+yVkaMnptf85CUIROX2U/KEJKfqgs6H1ZVuHy7uYzO9dtKEPGkgJxaTtIIfTRolcvkErKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c0px44SnRzYQvHh;
	Mon, 11 Aug 2025 17:19:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4143A1A14D7;
	Mon, 11 Aug 2025 17:19:19 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3MxSRtZlou9M9DQ--.29180S3;
	Mon, 11 Aug 2025 17:19:15 +0800 (CST)
Subject: Re: v6.17-rc1 cpu_hotplug_lock deadlock splat - blk_mq_alloc_queue vs
 fs_reclaim
To: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Thomas Gleixner <tglx@linutronix.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <17eb28791641e13b9d8fac4ad3681d6c0fbc2216.camel@gmx.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2a033ce4-184f-9e4e-4438-4c4d2e65315a@huaweicloud.com>
Date: Mon, 11 Aug 2025 17:19:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <17eb28791641e13b9d8fac4ad3681d6c0fbc2216.camel@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3MxSRtZlou9M9DQ--.29180S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4fKw1rur4rZF1xuw1rJFb_yoW3Zr1UpF
	yfKryfCr48WrW5Ar4Utw18Jayjva1UCF17Jrn7Jr1fAF48Zr1jyr1UGF47tryrG3yxAa13
	Ja4Dta18tryqqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/11 14:00, Mike Galbraith 写道:
> [    7.007387] ======================================================
> [    7.007710] WARNING: possible circular locking dependency detected
> [    7.007951] 6.17.0.g8f5ae30d-master #193 Not tainted
> [    7.008170] ------------------------------------------------------
> [    7.008387] (udev-worker)/708 is trying to acquire lock:
> [    7.008602] ffffffff88675e90 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_inc+0x12/0x30
> [    7.008826]
>                 but task is already holding lock:
> [    7.009244] ffff8a1a9994cb28 (&q->q_usage_counter(io)#68){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x20
> [    7.009464]
>                 which lock already depends on the new lock.
> 
> [    7.010096]
>                 the existing dependency chain (in reverse order) is:
> [    7.010509]
>                 -> #2 (&q->q_usage_counter(io)#68){++++}-{0:0}:
> [    7.011047]        __lock_acquire+0x550/0xbc0
> [    7.011364]        lock_acquire.part.0+0xa1/0x210
> [    7.011640]        blk_alloc_queue+0x30a/0x350
> [    7.011894]        blk_mq_alloc_queue+0x62/0xd0
> [    7.012152]        scsi_alloc_sdev+0x273/0x3a0 [scsi_mod]
> [    7.012436]        scsi_probe_and_add_lun+0x1e0/0x3f0 [scsi_mod]
> [    7.012833]        __scsi_add_device+0x109/0x120 [scsi_mod]
> [    7.013136]        ata_scsi_scan_host+0x9c/0x1b0 [libata]
> [    7.013398]        async_run_entry_fn+0x2c/0x110
> [    7.013749]        process_one_work+0x21f/0x5b0
> [    7.014072]        worker_thread+0x1ce/0x3c0
> [    7.014346]        kthread+0x119/0x210
> [    7.014639]        ret_from_fork+0x1a6/0x1f0
> [    7.014872]        ret_from_fork_asm+0x11/0x20
> [    7.015216]
>                 -> #1 (fs_reclaim){+.+.}-{0:0}:
> [    7.015689]        __lock_acquire+0x550/0xbc0
> [    7.015921]        lock_acquire.part.0+0xa1/0x210
> [    7.016185]        fs_reclaim_acquire+0x95/0xd0
> [    7.016460]        __kmalloc_cache_node_noprof+0x58/0x460
> [    7.016731]        intel_cpuc_prepare+0x5e/0x1c0
> [    7.017026]        cpuhp_invoke_callback+0x19e/0x650
> [    7.017272]        __cpuhp_invoke_callback_range+0x6d/0xd0
> [    7.017551]        _cpu_up+0xeb/0x230
> [    7.017757]        cpu_up+0xb4/0xd0
> [    7.017962]        cpuhp_bringup_mask+0x58/0x90
> [    7.018168]        bringup_nonboot_cpus+0x6b/0xf0
> [    7.018371]        smp_init+0x2a/0x80
> [    7.018570]        kernel_init_freeable+0x14e/0x1d0
> [    7.018769]        kernel_init+0x1a/0x130
> [    7.018968]        ret_from_fork+0x1a6/0x1f0
> [    7.019166]        ret_from_fork_asm+0x11/0x20
> [    7.019363]
>                 -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> [    7.019766]        check_prev_add+0xe8/0xca0
> [    7.019956]        validate_chain+0x48c/0x530
> [    7.020141]        __lock_acquire+0x550/0xbc0
> [    7.020326]        lock_acquire.part.0+0xa1/0x210
> [    7.020509]        cpus_read_lock+0x40/0xe0
> [    7.020690]        static_key_slow_inc+0x12/0x30
> [    7.020873]        rq_qos_add+0xc7/0x130
> [    7.021074]        wbt_init+0x156/0x1b0
> [    7.021253]        elevator_change_done+0x189/0x1d0
> [    7.021432]        elevator_change+0xeb/0x1a0
> [    7.021610]        elv_iosched_store+0x13d/0x170
> [    7.021788]        kernfs_fop_write_iter+0x14a/0x220
> [    7.021965]        vfs_write+0x213/0x520
> [    7.022139]        ksys_write+0x69/0xe0
> [    7.022311]        do_syscall_64+0x94/0xa10
> [    7.022483]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    7.022655]
>                 other info that might help us debug this:
> 
> [    7.023174] Chain exists of:
>                   cpu_hotplug_lock --> fs_reclaim --> &q->q_usage_counter(io)#68
> 
> [    7.023677]  Possible unsafe locking scenario:
> 
> [    7.024021]        CPU0                    CPU1
> [    7.024182]        ----                    ----
> [    7.024338]   lock(&q->q_usage_counter(io)#68);
> [    7.024496]                                lock(fs_reclaim);
> [    7.024653]                                lock(&q->q_usage_counter(io)#68);
> [    7.024813]   rlock(cpu_hotplug_lock);
> [    7.024971]
>                  *** DEADLOCK ***
> 
> [    7.025422] 7 locks held by (udev-worker)/708:
> [    7.025576]  #0: ffff8a1a872ad428 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x69/0xe0
> [    7.025737]  #1: ffff8a1a99733a88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x103/0x220
> [    7.025903]  #2: ffff8a1aa66e7428 (kn->active#23){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x10c/0x220
> [    7.026069]  #3: ffff8a1a82414380 (&set->update_nr_hwq_lock){.+.+}-{4:4}, at: elv_iosched_store+0xfe/0x170
> [    7.026237]  #4: ffff8a1a9994cd30 (&q->rq_qos_mutex){+.+.}-{4:4}, at: wbt_init+0x141/0x1b0
> [    7.026404]  #5: ffff8a1a9994cb28 (&q->q_usage_counter(io)#68){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x20
> [    7.026576]  #6: ffff8a1a9994cb60 (&q->q_usage_counter(queue)#68){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x20
> [    7.026766]
>                 stack backtrace:
> [    7.027385] CPU: 0 UID: 0 PID: 708 Comm: (udev-worker) Not tainted 6.17.0.g8f5ae30d-master #193 PREEMPT(lazy)  51b04e6fd63e725774bb751c4ffe0152e5eaa466
> [    7.027388] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [    7.027390] Call Trace:
> [    7.027392]  <TASK>
> [    7.027395]  dump_stack_lvl+0x5b/0x80
> [    7.027399]  print_circular_bug.cold+0x38/0x45
> [    7.027403]  check_noncircular+0x12c/0x150
> [    7.027406]  ? save_trace+0x65/0x1e0
> [    7.027411]  check_prev_add+0xe8/0xca0
> [    7.027415]  validate_chain+0x48c/0x530
> [    7.027419]  __lock_acquire+0x550/0xbc0
> [    7.027423]  lock_acquire.part.0+0xa1/0x210
> [    7.027425]  ? static_key_slow_inc+0x12/0x30
> [    7.027430]  ? rcu_is_watching+0x11/0x40
> [    7.027434]  ? lock_acquire+0xee/0x130
> [    7.027437]  cpus_read_lock+0x40/0xe0
> [    7.027439]  ? static_key_slow_inc+0x12/0x30
> [    7.027441]  static_key_slow_inc+0x12/0x30
> [    7.027444]  rq_qos_add+0xc7/0x130
> [    7.027447]  wbt_init+0x156/0x1b0
> [    7.027450]  elevator_change_done+0x189/0x1d0
> [    7.027454]  elevator_change+0xeb/0x1a0
> [    7.027458]  elv_iosched_store+0x13d/0x170
> [    7.027463]  kernfs_fop_write_iter+0x14a/0x220
> [    7.027467]  vfs_write+0x213/0x520
> [    7.027474]  ksys_write+0x69/0xe0
> [    7.027477]  do_syscall_64+0x94/0xa10
> [    7.027480]  ? do_sys_openat2+0x8a/0xc0
> [    7.027484]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    7.027486]  ? lockdep_hardirqs_on+0x78/0x100
> [    7.027488]  ? do_syscall_64+0x139/0xa10
> [    7.027490]  ? find_held_lock+0x2b/0x80
> [    7.027493]  ? mntput_no_expire+0x91/0x470
> [    7.027495]  ? __lock_release.isra.0+0x5d/0x180
> [    7.027507]  ? rcu_is_watching+0x11/0x40
> [    7.027510]  ? mntput_no_expire+0x91/0x470
> [    7.027512]  ? mntput_no_expire+0x91/0x470
> [    7.027514]  ? lock_release+0x86/0x150
> [    7.027517]  ? __x64_sys_close+0x3d/0x80
> [    7.027519]  ? kmem_cache_free+0x13b/0x460
> [    7.027523]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    7.027525]  ? lockdep_hardirqs_on+0x78/0x100
> [    7.027527]  ? do_syscall_64+0x139/0xa10
> [    7.027529]  ? do_sys_openat2+0x8a/0xc0
> [    7.027531]  ? kmem_cache_free+0x13b/0x460
> [    7.027533]  ? lock_release+0x86/0x150
> [    7.027535]  ? __seccomp_filter+0x37/0x4e0
> [    7.027541]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    7.027543]  ? lockdep_hardirqs_on+0x78/0x100
> [    7.027545]  ? do_syscall_64+0x139/0xa10
> [    7.027548]  ? exc_page_fault+0x116/0x210
> [    7.027552]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    7.027554] RIP: 0033:0x7f8889921000
> [    7.027557] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> [    7.027559] RSP: 002b:00007ffeb10faba8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [    7.027562] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f8889921000
> [    7.027563] RDX: 000000000000000b RSI: 00007ffeb10fae60 RDI: 0000000000000006
> [    7.027564] RBP: 00007ffeb10fae60 R08: 00007f88899fe2a8 R09: 00007ffeb10fac50
> [    7.027565] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000b
> [    7.027567] R13: 000055e71aef5fa0 R14: 00007f88899fdf60 R15: 0000000000000000
> [    7.027573]  </TASK>
> 

This is a known problem:

https://lore.kernel.org/all/20250805171749.3448694-1-nilay@linux.ibm.com/

Thanks,
Kuai

