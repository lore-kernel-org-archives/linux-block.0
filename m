Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D21A23AF
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676470; cv=none; b=lJ521r9mJzR1cXuP88IjP/nbpkYtTTJGp8rFKTUdkHNPmqmmid+qicsYID6f9+1vJK5izViSsGgUdjz67Fd5gTO6ju7K917OYgHT6q/T3w90njgjyCpzFNhBmtWTPaRLleiBwAD1j84VVyYWdIF/EC/mOfRk9YJeiQdBb/+9lU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676470; c=relaxed/simple;
	bh=j8uh+HYX36AUfAtv1dwjpELizBwODlXOxPJ6AP/NsaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bz7cOpRIcnpJ2QOdkjgMsstmHAzvMOUzgt8VtdLMU+xym+p1np+NWO5tVwK0SEGHPRDMgLy6HO9jisJtRwrvVdCfWt4OjiNihLbGoeKZh9aoU9U+rmo45+ZxI1k4nlvqFW6B52yVDdi8f9TlYvIr+NN10YZWX9PZWMRLQsPlJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AE0gybGi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE0gybGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758676463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFRMAMqpmJNdkSPjFUoC1L+k/Opfx2ubpUAsdgk8Ocw=;
	b=AE0gybGitWGRNgRWivgI7sd+dCPHR+k0RZtykVF9URT5NbG8W6GlJp2Nc3LGykTOa3PgeA
	3NsjF5R0c8we7IAZ/mejQ1yogCdY/rhtBvmo/Zsgm+7tI2gkp3C6bySxmY/zKvCTQyhb1t
	2NeZ2sPcfrabi2QTxFlGGVJB4vV9Jxo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-EY_f7JbRMTWhXuwTpAWqVg-1; Tue, 23 Sep 2025 21:14:21 -0400
X-MC-Unique: EY_f7JbRMTWhXuwTpAWqVg-1
X-Mimecast-MFC-AGG-ID: EY_f7JbRMTWhXuwTpAWqVg_1758676460
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-36b57abe6d0so14803941fa.3
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 18:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676459; x=1759281259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFRMAMqpmJNdkSPjFUoC1L+k/Opfx2ubpUAsdgk8Ocw=;
        b=cMglsuV6d9DBp7Pd1BxKH/tD60NUpDxj+7TOXZh7IUrfx5Fr55ZfAZGQx9Ngjln8ZC
         lEsnGQjbwPRU5k29W0837bS4oxH7Dv1Q50pSt2XZ7lxS0yWfUZef391lgDIT0oEhfKvh
         AgfXy/2I1mZfzqaX2LawgBtFuZMQidKjQhQARFd1wQ5OQ+zyt7bRjbo4zqfgOMPr2exJ
         V3HiUeudM4gxZrsugfih2lDdr0gAo+VloQDaLHTNplOi++w3FO2llv66Fm9Gj1B4fcE/
         cGOHMA1b9lxY1+KsQhqN3vQqY1O+aftjvjiZ13IQ3J0maXuczq4OSTnNQjT5gPyv7WXK
         vklg==
X-Gm-Message-State: AOJu0YzW3lusMubxksomQ6fRBPHMTE/Malxl85tBDNWtiCMZmIjc/Wx8
	pb6cVpQCYhKCFqLm2Mgxe5Q4QOQ5CkYK/D69xo01PWz/2TzrVHpVWn7SUkd4lo8LLjhtXNluhOh
	AmTbRemtKx11tXLrZ4hlbxCo08L8vjim8YzS32EB5lHbEGlsSDWx34XIaRgKqVEvJ89auD35eit
	DGfWxy2swYNHdiy6Qt7LGra/C3TTbKqMSWL14FU6o/10d8IDbyng==
X-Gm-Gg: ASbGncu7AOGGPe25LSqVifltP+f4lYqM+emA4Q6HUUGv1Nq2BZLmgsC61zjKXV129Uk
	Gp7Uu1uQTkjj8a2RScVNw29rldkEGHf40r8XmwafUaP+3BDVwxhVKDp7/Re3zPdTaqIfxa4lXT/
	euHwPcP/zQt3KNoeNW0aEBKQ==
X-Received: by 2002:a05:651c:4105:b0:36a:c940:b039 with SMTP id 38308e7fff4ca-36d179cad73mr7992331fa.42.1758676458644;
        Tue, 23 Sep 2025 18:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcIwc6oncQrHX++NkEcewZGIxwhjn6wFssVApvlenHwrq+q10AZF2cZc3MTK+q8yfQ1aGCwx61Y0ZTMCm/Kko=
X-Received: by 2002:a05:651c:4105:b0:36a:c940:b039 with SMTP id
 38308e7fff4ca-36d179cad73mr7992271fa.42.1758676458075; Tue, 23 Sep 2025
 18:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com>
In-Reply-To: <CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 24 Sep 2025 09:14:06 +0800
X-Gm-Features: AS18NWAlu5dpqFFwFINBfadNPklqraNoEZR2k_LTuqcoyAN_IHh_IFLDQ7lSMcc
Message-ID: <CAHj4cs_rk9ODLg7516z9EfKc4tGT9w0rn=xbnCCZyNGZbFP9yA@mail.gmail.com>
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at pcpu_alloc_noprof+0x128/0xeb8 and elevator_change+0x138/0x440
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Changhui Zhong <czhong@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue still can be reproduced on the latest linux-block/for-next
with blktest block/005

On Fri, Aug 8, 2025 at 1:24=E2=80=AFPM Changhui Zhong <czhong@redhat.com> w=
rote:
>
> Hello,
>
> the following warning was triggered by 'blktests block/020' tests on
> aarch64 platform,
> please help check and let me know if you need any info/test, thanks.
>
> repo=EF=BC=9Ahttps://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-=
block.git
> branch=EF=BC=9Afor-next
> INFO: HEAD of cloned kernel=EF=BC=9A
> commit 20c74c07321713217b2f84c55dfd717729aa6111
> Merge: f1815afd0877 407728da41cd
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Aug 4 09:23:02 2025 -0600
>
>     Merge branch 'block-6.17' into for-next
>
>     * block-6.17:
>       block, bfq: Reorder struct bfq_iocq_bfqq_data
>
> dmesg log=EF=BC=9A
>
> [  670.939355] run blktests block/020 at 2025-08-07 07:10:45
> [  673.008290] restraintd[3128]: *** Current Time: Thu Aug 07 07:10:47
> 2025  Localwatchdog at: Thu Aug 07 12:00:47 2025
> [  695.875845]
> [  695.877344] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  695.883515] WARNING: possible circular locking dependency detected
> [  695.889684] 6.16.0+ #1 Not tainted
> [  695.893075] ------------------------------------------------------
> [  695.899243] check/12334 is trying to acquire lock:
> [  695.904022] ffffa1f3ed4291f0 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> pcpu_alloc_noprof+0x128/0xeb8
> [  695.912635]
> [  695.912635] but task is already holding lock:
> [  695.918455] ffff0800bee44578 (&q->elevator_lock){+.+.}-{4:4}, at:
> elevator_change+0x138/0x440
> [  695.926975]
> [  695.926975] which lock already depends on the new lock.
> [  695.926975]
> [  695.935139]
> [  695.935139] the existing dependency chain (in reverse order) is:
> [  695.942608]
> [  695.942608] -> #3 (&q->elevator_lock){+.+.}-{4:4}:
> [  695.948868]        __lock_acquire+0x4bc/0x990
> [  695.953216]        lock_acquire.part.0+0x174/0x2a8
> [  695.957997]        lock_acquire+0xa0/0x1b8
> [  695.962083]        __mutex_lock+0x158/0x1090
> [  695.966343]        mutex_lock_nested+0x2c/0x40
> [  695.970775]        elevator_change+0x138/0x440
> [  695.975208]        elv_iosched_store+0x214/0x2c0
> [  695.979814]        queue_attr_store+0x200/0x270
> [  695.984335]        sysfs_kf_write+0xcc/0x120
> [  695.988595]        kernfs_fop_write_iter+0x288/0x430
> [  695.993549]        new_sync_write+0x214/0x4d0
> [  695.997895]        vfs_write+0x440/0x5b0
> [  696.001806]        ksys_write+0xf8/0x1f0
> [  696.005718]        __arm64_sys_write+0x74/0xb0
> [  696.010151]        invoke_syscall.constprop.0+0xdc/0x1e8
> [  696.015454]        do_el0_svc+0x154/0x1d0
> [  696.019453]        el0_svc+0x54/0x180
> [  696.023105]        el0t_64_sync_handler+0xa0/0xe8
> [  696.027799]        el0t_64_sync+0x1ac/0x1b0
> [  696.031971]
> [  696.031971] -> #2 (&q->q_usage_counter(io)#6){++++}-{0:0}:
> [  696.038926]        __lock_acquire+0x4bc/0x990
> [  696.043272]        lock_acquire.part.0+0x174/0x2a8
> [  696.048052]        lock_acquire+0xa0/0x1b8
> [  696.052138]        blk_alloc_queue+0x4e8/0x608
> [  696.056571]        blk_mq_alloc_queue+0x150/0x240
> [  696.061265]        __blk_mq_alloc_disk+0x28/0x1d8
> [  696.065958]        null_add_dev+0x680/0x1188 [null_blk]
> [  696.071183]        nullb_device_power_store+0x1f4/0x340 [null_blk]
> [  696.077357]        configfs_write_iter+0x24c/0x378
> [  696.082138]        new_sync_write+0x214/0x4d0
> [  696.086484]        vfs_write+0x440/0x5b0
> [  696.090395]        ksys_write+0xf8/0x1f0
> [  696.094306]        __arm64_sys_write+0x74/0xb0
> [  696.098739]        invoke_syscall.constprop.0+0xdc/0x1e8
> [  696.104040]        do_el0_svc+0x154/0x1d0
> [  696.108039]        el0_svc+0x54/0x180
> [  696.111690]        el0t_64_sync_handler+0xa0/0xe8
> [  696.116383]        el0t_64_sync+0x1ac/0x1b0
> [  696.120555]
> [  696.120555] -> #1 (fs_reclaim){+.+.}-{0:0}:
> [  696.126206]        __lock_acquire+0x4bc/0x990
> [  696.130553]        lock_acquire.part.0+0x174/0x2a8
> [  696.135333]        lock_acquire+0xa0/0x1b8
> [  696.139420]        fs_reclaim_acquire+0x140/0x170
> [  696.144114]        __alloc_frozen_pages_noprof+0x17c/0x4f0
> [  696.149588]        __alloc_pages_noprof+0x1c/0xb0
> [  696.154281]        pcpu_alloc_pages.isra.0+0x12c/0x448
> [  696.159409]        pcpu_populate_chunk+0x4c/0x98
> [  696.164016]        pcpu_alloc_noprof+0x3b0/0xeb8
> [  696.168624]        iommu_dma_init_fq+0x148/0x690
> [  696.173231]        iommu_dma_init_domain+0x488/0x6a0
> [  696.178185]        iommu_setup_dma_ops+0x138/0x210
> [  696.182965]        bus_iommu_probe+0x1b0/0x3e8
> [  696.187398]        iommu_device_register+0x15c/0x240
> [  696.192351]        arm_smmu_device_probe+0xbe8/0x1260
> [  696.197393]        platform_probe+0xcc/0x198
> [  696.201654]        really_probe+0x188/0x800
> [  696.205826]        __driver_probe_device+0x164/0x360
> [  696.210779]        driver_probe_device+0x64/0x1a8
> [  696.215472]        __driver_attach+0x180/0x490
> [  696.219904]        bus_for_each_dev+0x104/0x1a0
> [  696.224424]        driver_attach+0x44/0x68
> [  696.228509]        bus_add_driver+0x23c/0x4e8
> [  696.232855]        driver_register+0x15c/0x3a8
> [  696.237287]        __platform_driver_register+0x64/0x98
> [  696.242502]        arm_smmu_driver_init+0x28/0x40
> [  696.247197]        do_one_initcall+0xd4/0x370
> [  696.251544]        do_initcalls+0x1b0/0x200
> [  696.255716]        kernel_init_freeable+0x280/0x2c0
> [  696.260582]        kernel_init+0x28/0x160
> [  696.264581]        ret_from_fork+0x10/0x20
> [  696.268668]
> [  696.268668] -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
> [  696.274840]        check_prev_add+0xec/0x658
> [  696.279100]        validate_chain+0x2dc/0x340
> [  696.283446]        __lock_acquire+0x4bc/0x990
> [  696.287792]        lock_acquire.part.0+0x174/0x2a8
> [  696.292572]        lock_acquire+0xa0/0x1b8
> [  696.296658]        __mutex_lock+0x158/0x1090
> [  696.300917]        _mutex_lock_killable+0x2c/0x40
> [  696.305610]        pcpu_alloc_noprof+0x128/0xeb8
> [  696.310217]        kyber_queue_data_alloc+0x150/0x580
> [  696.315258]        kyber_init_sched+0x28/0xb0
> [  696.319605]        blk_mq_init_sched+0x1f0/0x410
> [  696.324213]        elevator_switch+0x184/0x5a0
> [  696.328645]        elevator_change+0x29c/0x440
> [  696.333077]        elv_iosched_store+0x214/0x2c0
> [  696.337684]        queue_attr_store+0x200/0x270
> [  696.342204]        sysfs_kf_write+0xcc/0x120
> [  696.346463]        kernfs_fop_write_iter+0x288/0x430
> [  696.351416]        new_sync_write+0x214/0x4d0
> [  696.355761]        vfs_write+0x440/0x5b0
> [  696.359672]        ksys_write+0xf8/0x1f0
> [  696.363585]        __arm64_sys_write+0x74/0xb0
> [  696.368017]        invoke_syscall.constprop.0+0xdc/0x1e8
> [  696.373318]        do_el0_svc+0x154/0x1d0
> [  696.377317]        el0_svc+0x54/0x180
> [  696.380969]        el0t_64_sync_handler+0xa0/0xe8
> [  696.385663]        el0t_64_sync+0x1ac/0x1b0
> [  696.389835]
> [  696.389835] other info that might help us debug this:
> [  696.389835]
> [  696.397826] Chain exists of:
> [  696.397826]   pcpu_alloc_mutex --> &q->q_usage_counter(io)#6 -->
> &q->elevator_lock
> [  696.397826]
> [  696.409731]  Possible unsafe locking scenario:
> [  696.409731]
> [  696.415638]        CPU0                    CPU1
> [  696.420155]        ----                    ----
> [  696.424673]   lock(&q->elevator_lock);
> [  696.428412]                                lock(&q->q_usage_counter(io=
)#6);
> [  696.435364]                                lock(&q->elevator_lock);
> [  696.441620]   lock(pcpu_alloc_mutex);
> [  696.445272]
> [  696.445272]  *** DEADLOCK ***
> [  696.445272]
> [  696.451179] 7 locks held by check/12334:
> [  696.455091]  #0: ffff07ffed062448 (sb_writers#4){.+.+}-{0:0}, at:
> vfs_write+0x404/0x5b0
> [  696.463090]  #1: ffff0800a7d3e890 (&of->mutex#2){+.+.}-{4:4}, at:
> kernfs_fop_write_iter+0x1fc/0x430
> [  696.472131]  #2: ffff07ff9128eba0 (kn->active#107){.+.+}-{0:0}, at:
> kernfs_fop_write_iter+0x218/0x430
> [  696.481345]  #3: ffff0800c80841d8
> (&set->update_nr_hwq_lock){++++}-{4:4}, at:
> elv_iosched_store+0x18c/0x2c0
> [  696.491080]  #4: ffff0800bee43fe0
> (&q->q_usage_counter(io)#6){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x20/0x40
> [  696.501770]  #5: ffff0800bee44020
> (&q->q_usage_counter(queue)#2){+.+.}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x20/0x40
> [  696.512720]  #6: ffff0800bee44578 (&q->elevator_lock){+.+.}-{4:4},
> at: elevator_change+0x138/0x440
> [  696.521674]
> [  696.521674] stack backtrace:
> [  696.526020] CPU: 42 UID: 0 PID: 12334 Comm: check Kdump: loaded Not
> tainted 6.16.0+ #1 PREEMPT(voluntary)
> [  696.535663] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> F31n (SCP: 2.10.20220810) 09/30/2022
> [  696.544956] Call trace:
> [  696.547392]  show_stack+0x34/0x98 (C)
> [  696.551046]  dump_stack_lvl+0xa8/0xe8
> [  696.554698]  dump_stack+0x1c/0x38
> [  696.558003]  print_circular_bug+0xf0/0x100
> [  696.562089]  check_noncircular+0x174/0x188
> [  696.566175]  check_prev_add+0xec/0x658
> [  696.569915]  validate_chain+0x2dc/0x340
> [  696.573741]  __lock_acquire+0x4bc/0x990
> [  696.577566]  lock_acquire.part.0+0x174/0x2a8
> [  696.581826]  lock_acquire+0xa0/0x1b8
> [  696.585392]  __mutex_lock+0x158/0x1090
> [  696.589130]  _mutex_lock_killable+0x2c/0x40
> [  696.593303]  pcpu_alloc_noprof+0x128/0xeb8
> [  696.597390]  kyber_queue_data_alloc+0x150/0x580
> [  696.601911]  kyber_init_sched+0x28/0xb0
> [  696.605737]  blk_mq_init_sched+0x1f0/0x410
> [  696.609823]  elevator_switch+0x184/0x5a0
> [  696.613736]  elevator_change+0x29c/0x440
> [  696.617648]  elv_iosched_store+0x214/0x2c0
> [  696.621734]  queue_attr_store+0x200/0x270
> [  696.625733]  sysfs_kf_write+0xcc/0x120
> [  696.629472]  kernfs_fop_write_iter+0x288/0x430
> [  696.633904]  new_sync_write+0x214/0x4d0
> [  696.637729]  vfs_write+0x440/0x5b0
> [  696.641120]  ksys_write+0xf8/0x1f0
> [  696.644511]  __arm64_sys_write+0x74/0xb0
> [  696.648423]  invoke_syscall.constprop.0+0xdc/0x1e8
> [  696.653204]  do_el0_svc+0x154/0x1d0
> [  696.656683]  el0_svc+0x54/0x180
> [  696.659813]  el0t_64_sync_handler+0xa0/0xe8
> [  696.663986]  el0t_64_sync+0x1ac/0x1b0
> [  728.598328] null_blk: disk nullb0 created
> [  728.598344] null_blk: module loaded
>
> Best Regards,
> Changhui
>
>


--=20
Best Regards,
  Yi Zhang

