Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D931361
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631945; cv=none; b=Gm/xLFd+g2iTMr89YNQrQ2/mf18Uw4qTbbLbk0RSd1IQTLJXbrF+AxwgC2CYJ9PcaqmEjd0wOPzDTlelQfKCRqHrpgpTrazvryr2LuFdce/BlUmbF958BrEuyfnVT4J4ZWTZpg8FypH2xXsiG7xNu7KC3kucOZCQuT/wrJ5Hkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631945; c=relaxed/simple;
	bh=jGCUMMrSW3duY6/XtvJWMA+qDYFmPV6UiawjeEByW4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=td1V5GGhyYXKHc+6EFtAR09vyRFcK1pvo4ykyT/YlJF45Ov1h0pCwOhFR3qvTrz9TdB3/noG0oEq5htz9J1QOcH0ukwYw9J7STJKOCs0Yw+fxMszqgMFR4OhEjBuqDWl+cDtWrZq0mnapLFiC8bc6DXAxVTsjdveXPzJL4/KnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6YCzmt0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6YCzmt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754631941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsKtxtvpVtUmOOko4XLMYu9LgxZ1OAEaeIo+HAnU2ak=;
	b=U6YCzmt0Asw+mQEbZQ29MEY+wNLjH5cdAWT1/yUD9UlU3vqYTlC4r9iL0wbDkDU/Dow6bC
	ztqkMOI44z9Tov4P6m9aqXDinqeKDzEm0kKt459XKXctTSh27d5dqXPaI7WTeikOkdlP1g
	6faonRk/5ZiUiDhNYYV4r4G8qcye1+c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Kf0Tz85IN1OQXLylbczwgA-1; Fri, 08 Aug 2025 01:45:39 -0400
X-MC-Unique: Kf0Tz85IN1OQXLylbczwgA-1
X-Mimecast-MFC-AGG-ID: Kf0Tz85IN1OQXLylbczwgA_1754631938
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4225ab1829so1334408a12.0
        for <linux-block@vger.kernel.org>; Thu, 07 Aug 2025 22:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631938; x=1755236738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsKtxtvpVtUmOOko4XLMYu9LgxZ1OAEaeIo+HAnU2ak=;
        b=QDNMJH9uB4Fp2HeWqVEJf2eXyz/M2ImJ3PSLfQGriJhGlTgl5PPdgNNxme360ID90n
         n/oGKxJoBDBxBjukPXi0qLroEPLr0V/lCJLOOMHHxvaXzfK7XCgxR5m5xC2CeyhXsjSJ
         jU45zAzkPd9w/vPGdyJtMdOV4gnJWC+GKiK2g3EMrBp7bU12z7Wdz+siWvjbMX4cPQeu
         Ex7Xv4xYLZJGIHRUold3CAefEU8/fjic9zpai2eXJYPFEUyqBeBXGiLdCqKnqremFerK
         W6IYueyWPOcCPzCbBMxmk349V1B3x5+RhHbdGTC1FJTwbH59YQyj7beZm75RHj4fbhXw
         wiSA==
X-Gm-Message-State: AOJu0YwBEVJxxSS0a2w9Gqs48yZTuyRmX0HBbsFHaiuNuwo6L74luIrK
	eUji3YDkwHkoYQ9iXQVjrxobgVpPtZJps7k9csn4kSXDY+yx8d1u8OoMmI2tIaaOALBlVp5W/cS
	JjqYWN3iXPhVDchnXfVZiXRNlkc3vOiU0J2Vj7SYnG5iSeahq2lJJHcKWsiaXJjn8tPQbnbRlqL
	3fDo1lM8wMc4rk1XYEoKoXxBPUSQZem4biwTmsXZ7I5PaT3ffdO8Ac
X-Gm-Gg: ASbGncv2BmsX4tRaam5Fwlq9mbd2YaHWGyUvUW3cNmZmeGZrNcYvJtGbGlEZMSFFbqc
	vDZSQtrygyljTLY9DPnSLhwPG55+6kNCsiaymXlYqBPHSd2497vl+pUcWQF3qYFfpcupjkXL6Yz
	AVi6BB/NCP1rUaWdzcX8zFog==
X-Received: by 2002:a17:903:1b4c:b0:242:9be2:102b with SMTP id d9443c01a7336-242c19a5030mr27432675ad.0.1754631937774;
        Thu, 07 Aug 2025 22:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS1r3n7stJRdcmO4u1JP2cZGK5cGWM+uJynJL7YsotzyNH2w9TG0+WDCzJ1VFrPTuIzZ2qyxqaYbWvm6jgtQQ=
X-Received: by 2002:a17:903:1b4c:b0:242:9be2:102b with SMTP id
 d9443c01a7336-242c19a5030mr27432095ad.0.1754631937183; Thu, 07 Aug 2025
 22:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com>
In-Reply-To: <CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Fri, 8 Aug 2025 13:45:25 +0800
X-Gm-Features: Ac12FXxnTRJKFfx4nPfdSux9MPlpG7o2iRSgyXnHZGPDAevX4_DdzNMT2e07e60
Message-ID: <CAGVVp+UwEVFDvpH4DVS-gYZq8YhPMy39CpWLekKaq0OT7ojQXw@mail.gmail.com>
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at pcpu_alloc_noprof+0x128/0xeb8 and elevator_change+0x138/0x440
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

also happened on ublk testing,

dmesg log:
[ 1633.771149] Dev: ublk-loop  Engine: libaio Sched: mq-deadline
Pattern: randrw  Depth: 16 Fstype: xfs
[ 1679.077461] restraintd[1501]: *** Current Time: Thu Aug 07 11:58:26
2025  Localwatchdog at: Thu Aug 07 16:33:25 2025
[ 1726.950887]
[ 1726.952567] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1726.959479] WARNING: possible circular locking dependency detected
[ 1726.966390] 6.16.0+ #1 Tainted: G S
[ 1726.971939] ------------------------------------------------------
[ 1726.978841] bash/1709 is trying to acquire lock:
[ 1726.984000] ffffffff9e345790 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x8a3/0xd50
[ 1726.993638]
[ 1726.993638] but task is already holding lock:
[ 1727.000151] ff110001d6026f98 (&q->elevator_lock){+.+.}-{4:4}, at:
elevator_change+0x12d/0x500
[ 1727.009684]
[ 1727.009684] which lock already depends on the new lock.
[ 1727.009684]
[ 1727.018814]
[ 1727.018814] the existing dependency chain (in reverse order) is:
[ 1727.027170]
[ 1727.027170] -> #3 (&q->elevator_lock){+.+.}-{4:4}:
[ 1727.034176]        __lock_acquire+0x57c/0xbd0
[ 1727.039045]        lock_acquire.part.0+0xbd/0x260
[ 1727.044300]        __mutex_lock+0x1a9/0x1b20
[ 1727.049075]        elevator_change+0x12d/0x500
[ 1727.054037]        elv_iosched_store+0x27b/0x2f0
[ 1727.059196]        queue_attr_store+0x22f/0x2f0
[ 1727.064260]        kernfs_fop_write_iter+0x3a0/0x5a0
[ 1727.069808]        vfs_write+0x525/0xfd0
[ 1727.074192]        ksys_write+0xf9/0x1d0
[ 1727.078572]        do_syscall_64+0x94/0x8d0
[ 1727.083248]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.089474]
[ 1727.089474] -> #2 (&q->q_usage_counter(io)#9){++++}-{0:0}:
[ 1727.097259]        __lock_acquire+0x57c/0xbd0
[ 1727.102125]        lock_acquire.part.0+0xbd/0x260
[ 1727.107381]        blk_alloc_queue+0x5ca/0x710
[ 1727.112345]        blk_mq_alloc_queue+0x14b/0x230
[ 1727.117601]        __blk_mq_alloc_disk+0x18/0xd0
[ 1727.122761]        ublk_ctrl_start_dev.isra.0+0x6eb/0xdd0 [ublk_drv]
[ 1727.129862]        ublk_ctrl_uring_cmd+0x6f3/0x1390 [ublk_drv]
[ 1727.136381]        io_uring_cmd+0x18e/0x490
[ 1727.141056]        __io_issue_sqe+0xaa/0x7d0
[ 1727.145830]        io_issue_sqe+0x80/0xe20
[ 1727.150406]        io_wq_submit_work+0x2c0/0xe40
[ 1727.155563]        io_worker_handle_work+0x429/0x780
[ 1727.161110]        io_wq_worker+0x2f2/0xab0
[ 1727.165781]        ret_from_fork+0x390/0x480
[ 1727.170554]        ret_from_fork_asm+0x1a/0x30
[ 1727.175518]
[ 1727.175518] -> #1 (fs_reclaim){+.+.}-{0:0}:
[ 1727.181838]        __lock_acquire+0x57c/0xbd0
[ 1727.186704]        lock_acquire.part.0+0xbd/0x260
[ 1727.191957]        fs_reclaim_acquire+0xc9/0x110
[ 1727.197117]        __kmalloc_noprof+0xba/0x5e0
[ 1727.202083]        pcpu_alloc_chunk+0x24/0x3e0
[ 1727.207049]        pcpu_create_chunk+0x12/0x350
[ 1727.212110]        pcpu_alloc_noprof+0xaa8/0xd50
[ 1727.217269]        bts_init+0x139/0x1e0
[ 1727.221557]        do_one_initcall+0xa4/0x260
[ 1727.226424]        do_initcalls+0x1b4/0x1f0
[ 1727.231095]        kernel_init_freeable+0x4a8/0x520
[ 1727.236542]        kernel_init+0x1c/0x150
[ 1727.241022]        ret_from_fork+0x390/0x480
[ 1727.245793]        ret_from_fork_asm+0x1a/0x30
[ 1727.250758]
[ 1727.250758] -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
[ 1727.257668]        check_prev_add+0xf1/0xcd0
[ 1727.262438]        validate_chain+0x487/0x570
[ 1727.267304]        __lock_acquire+0x57c/0xbd0
[ 1727.272169]        lock_acquire.part.0+0xbd/0x260
[ 1727.277423]        __mutex_lock+0x1a9/0x1b20
[ 1727.282195]        pcpu_alloc_noprof+0x8a3/0xd50
[ 1727.287354]        kyber_queue_data_alloc+0x16d/0x610
[ 1727.292998]        kyber_init_sched+0x18/0xa0
[ 1727.297864]        blk_mq_init_sched+0x26e/0x4e0
[ 1727.303021]        elevator_switch+0x1ae/0x650
[ 1727.307986]        elevator_change+0x2db/0x500
[ 1727.312949]        elv_iosched_store+0x27b/0x2f0
[ 1727.318105]        queue_attr_store+0x22f/0x2f0
[ 1727.323168]        kernfs_fop_write_iter+0x3a0/0x5a0
[ 1727.328714]        vfs_write+0x525/0xfd0
[ 1727.333099]        ksys_write+0xf9/0x1d0
[ 1727.337479]        do_syscall_64+0x94/0x8d0
[ 1727.342150]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.348374]
[ 1727.348374] other info that might help us debug this:
[ 1727.348374]
[ 1727.357312] Chain exists of:
[ 1727.357312]   pcpu_alloc_mutex --> &q->q_usage_counter(io)#9 -->
&q->elevator_lock
[ 1727.357312]
[ 1727.370624]  Possible unsafe locking scenario:
[ 1727.370624]
[ 1727.377233]        CPU0                    CPU1
[ 1727.382293]        ----                    ----
[ 1727.387352]   lock(&q->elevator_lock);
[ 1727.391542]                                lock(&q->q_usage_counter(io)#=
9);
[ 1727.399323]                                lock(&q->elevator_lock);
[ 1727.406323]   lock(pcpu_alloc_mutex);
[ 1727.410414]
[ 1727.410414]  *** DEADLOCK ***
[ 1727.410414]
[ 1727.417014] 7 locks held by bash/1709:
[ 1727.421200]  #0: ff110001e9420448 (sb_writers#4){.+.+}-{0:0}, at:
ksys_write+0xf9/0x1d0
[ 1727.430152]  #1: ff110001d6771490 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0x260/0x5a0
[ 1727.440268]  #2: ff110001e2d41270 (kn->active#105){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x283/0x5a0
[ 1727.450579]  #3: ff11000120e161f8
(&set->update_nr_hwq_lock){.+.+}-{4:4}, at:
elv_iosched_store+0x1dc/0x2f0
[ 1727.461469]  #4: ff110001d6026a00
(&q->q_usage_counter(io)#9){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0x12/0x20
[ 1727.473417]  #5: ff110001d6026a40
(&q->q_usage_counter(queue)#6){+.+.}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0x12/0x20
[ 1727.485665]  #6: ff110001d6026f98 (&q->elevator_lock){+.+.}-{4:4},
at: elevator_change+0x12d/0x500
[ 1727.495681]
[ 1727.495681] stack backtrace:
[ 1727.500547] CPU: 3 UID: 0 PID: 1709 Comm: bash Kdump: loaded
Tainted: G S                  6.16.0+ #1 PREEMPT(voluntary)
[ 1727.500554] Tainted: [S]=3DCPU_OUT_OF_SPEC
[ 1727.500557] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[ 1727.500559] Call Trace:
[ 1727.500562]  <TASK>
[ 1727.500565]  dump_stack_lvl+0x6f/0xb0
[ 1727.500573]  print_circular_bug.cold+0x38/0x45
[ 1727.500580]  check_noncircular+0x148/0x160
[ 1727.500584]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 1727.500592]  check_prev_add+0xf1/0xcd0
[ 1727.500595]  ? alloc_chain_hlocks+0x8/0x1d0
[ 1727.500601]  ? add_chain_cache+0x12c/0x310
[ 1727.500608]  validate_chain+0x487/0x570
[ 1727.500611]  ? lock_acquire.part.0+0xbd/0x260
[ 1727.500617]  __lock_acquire+0x57c/0xbd0
[ 1727.500622]  lock_acquire.part.0+0xbd/0x260
[ 1727.500626]  ? pcpu_alloc_noprof+0x8a3/0xd50
[ 1727.500633]  ? rcu_is_watching+0x15/0xb0
[ 1727.500639]  ? lock_acquire+0x10b/0x150
[ 1727.500645]  __mutex_lock+0x1a9/0x1b20
[ 1727.500650]  ? pcpu_alloc_noprof+0x8a3/0xd50
[ 1727.500655]  ? pcpu_alloc_noprof+0x8a3/0xd50
[ 1727.500659]  ? elv_iosched_store+0x27b/0x2f0
[ 1727.500663]  ? queue_attr_store+0x22f/0x2f0
[ 1727.500668]  ? kernfs_fop_write_iter+0x3a0/0x5a0
[ 1727.500673]  ? vfs_write+0x525/0xfd0
[ 1727.500678]  ? ksys_write+0xf9/0x1d0
[ 1727.500681]  ? do_syscall_64+0x94/0x8d0
[ 1727.500685]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.500689]  ? __pfx___mutex_lock+0x10/0x10
[ 1727.500702]  ? pcpu_alloc_noprof+0x8a3/0xd50
[ 1727.500707]  pcpu_alloc_noprof+0x8a3/0xd50
[ 1727.500715]  ? kasan_save_track+0x14/0x30
[ 1727.500720]  kyber_queue_data_alloc+0x16d/0x610
[ 1727.500724]  ? debug_mutex_init+0x37/0x70
[ 1727.500731]  kyber_init_sched+0x18/0xa0
[ 1727.500735]  blk_mq_init_sched+0x26e/0x4e0
[ 1727.500741]  ? __pfx_blk_mq_exit_sched+0x10/0x10
[ 1727.500746]  ? __pfx_blk_mq_init_sched+0x10/0x10
[ 1727.500754]  elevator_switch+0x1ae/0x650
[ 1727.500759]  elevator_change+0x2db/0x500
[ 1727.500766]  elv_iosched_store+0x27b/0x2f0
[ 1727.500771]  ? __pfx_elv_iosched_store+0x10/0x10
[ 1727.500777]  ? kernfs_fop_write_iter+0x260/0x5a0
[ 1727.500782]  ? kernfs_fop_write_iter+0x260/0x5a0
[ 1727.500789]  ? rcu_is_watching+0x15/0xb0
[ 1727.500795]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1727.500799]  queue_attr_store+0x22f/0x2f0
[ 1727.500805]  ? __pfx_queue_attr_store+0x10/0x10
[ 1727.500811]  ? __lock_acquire+0x57c/0xbd0
[ 1727.500817]  ? find_held_lock+0x32/0x90
[ 1727.500822]  ? local_clock_noinstr+0xd/0xe0
[ 1727.500827]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 1727.500833]  ? sysfs_file_kobj+0xb3/0x1c0
[ 1727.500837]  ? sysfs_file_kobj+0xbd/0x1c0
[ 1727.500842]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1727.500846]  kernfs_fop_write_iter+0x3a0/0x5a0
[ 1727.500853]  vfs_write+0x525/0xfd0
[ 1727.500860]  ? __pfx_vfs_write+0x10/0x10
[ 1727.500869]  ? local_clock_noinstr+0xd/0xe0
[ 1727.500874]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 1727.500879]  ksys_write+0xf9/0x1d0
[ 1727.500883]  ? __pfx_ksys_write+0x10/0x10
[ 1727.500887]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.500893]  do_syscall_64+0x94/0x8d0
[ 1727.500906]  ? fput_close+0x156/0x1c0
[ 1727.500912]  ? __pfx_fput_close+0x10/0x10
[ 1727.500919]  ? filp_close+0x1d/0x30
[ 1727.500923]  ? do_dup2+0x296/0x500
[ 1727.500927]  ? lockdep_hardirqs_on+0x78/0x100
[ 1727.500934]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.500938]  ? lockdep_hardirqs_on+0x78/0x100
[ 1727.500942]  ? do_syscall_64+0x139/0x8d0
[ 1727.500947]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.500951]  ? lockdep_hardirqs_on+0x78/0x100
[ 1727.500955]  ? do_syscall_64+0x139/0x8d0
[ 1727.500959]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.500962]  ? lockdep_hardirqs_on+0x78/0x100
[ 1727.500967]  ? do_syscall_64+0x139/0x8d0
[ 1727.500972]  ? exc_page_fault+0x78/0xf0
[ 1727.500978]  ? rcu_is_watching+0x15/0xb0
[ 1727.500983]  ? clear_bhb_loop+0x50/0xa0
[ 1727.500989]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1727.500992] RIP: 0033:0x7f10fec4e894
[ 1727.500997] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 d8 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 1727.501001] RSP: 002b:00007ffcb8b9d868 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1727.501007] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f10fec=
4e894
[ 1727.501010] RDX: 0000000000000006 RSI: 000055ecf55e8f40 RDI: 00000000000=
00001
[ 1727.501013] RBP: 000055ecf55e8f40 R08: 0000000000000073 R09: 00000000fff=
fffff
[ 1727.501016] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00006
[ 1727.501018] R13: 00007f10fed255c0 R14: 0000000000000006 R15: 00007f10fed=
22f00
[ 1727.501027]  </TASK>

On Fri, Aug 8, 2025 at 1:23=E2=80=AFPM Changhui Zhong <czhong@redhat.com> w=
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

