Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FA1F7580;
	Mon,  5 May 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442257; cv=none; b=C/dvYaZvS+Sg/pOk9+hnhPNI7m6FTssrMSnVxrEwgJGv4/V/pN3ziHBseaZq1jNY7fyoXKJkLza1B/KsMxG/OtcV69bNjRsTW8lElo0ZYfVRzboC+6N8W40ReHH6Xb7EY+lcscv7AvSSCp6ItjBJEjB/DeXXQg4Rjh78czncV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442257; c=relaxed/simple;
	bh=OadpNniwh9U1HU2o/5b6wsoaUE8vTuQIe4cjw+qCToc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gsY37sYNZqzlnWzYGv1y0hhUSHbuWp0MuTrLWom6tuk4OBrk7SJe1FNUAA+RtKPN7KUpwMCLP9MkO0gcxMDEwdgk5LehewBe87OMbL479ea+GzU3+EpIAUy/SeqNQM5Y5Ci5i+UeErCBUypXWr4fs060CRHVDTNujD0IGZvJjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0UFpoFc; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0UFpoFc"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7306482f958so2790549a34.0;
        Mon, 05 May 2025 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746442254; x=1747047054; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z2HYf6C5msKU0LievF4dPNUD54sRQqBRtv3P+JbzPI=;
        b=Q0UFpoFcaddR4TFftxiCf+UqnNowfwSEx/C0YKkDx+z3PluIzQdQCIaiW6c8tsrj4P
         lSNTfo1iP7qZvf6iDDuxEbpRheFS/ZCH4kp+ts8ni9mzbvOcq4p/apT7NXbfwTMgzu6x
         qfdR+1NUl9I1gLgJ+vdGskJiHq/ryUn/ru8l8liEQbE+EwTciEVLHeH/rCc4TUMwo07g
         OxrjdD12ax4clbiiHKIA4cpf3OkhCR7zyltQkutRrafBt2Pr+AnfsdRPCody68rr3dwa
         lbdi0JoykSrDsDr+IWt6+vz5pcch3qETaL4YZSwb2LJpn9XJmnC7kn+UUtd212WINT81
         ttGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746442254; x=1747047054;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z2HYf6C5msKU0LievF4dPNUD54sRQqBRtv3P+JbzPI=;
        b=GfmJy2PBXAXU0kntDRZO1EIVJtAUrFLsFBtOYn41jurAIAUVPEw3RugqyBUhAVe1uO
         ksp+9ZSUfLPNhPjgkFB2hZoQN3kVcPF7eEKjMqSaUs90j6tgfDoxeFxlPXzd1yv1ly90
         vw8pJmojtszQ0WlkhcrKdhCGHKh5Az6BkOALLSqt5sXnPDafRSp4ek8xgbWbbeS2jI/r
         XHz15FLM7HSqw1FfF8QfBC2+m07xt7YyncDzUy+WuThfX0+U+nvumUuYAFlVTeh6QhVN
         rqU37XKFKiD6OoLCB92Mp0kZKG9CMUhV8PfdX/6+1GuN3n0sN9TEJD/pvWPQOKws4fTY
         s+5g==
X-Forwarded-Encrypted: i=1; AJvYcCWlSMHOgSeYdO74cIAdahS5jA1YB6PyXz4SqiR9aR5XdrCLexpsfXryBUHTgHY7HYmamyPyIQ7+H9LL24ga@vger.kernel.org, AJvYcCXnVpY9uNs9RaNE/9go4WHPGy2Xn8OTTrk0NGqmKCoFrOIMLY9dvLmzUElWHr+D5b6geSM9zm0oKX4bZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR24M8Xk38X8AmT0XUfxdiJQhmOBwHhafdG9ipiWpxZPJHgMvG
	JaUo7sZbRsqOMdAU247SEzlwzfacddWnEO0OYHg2y7MGzFNQIep2Xbzi1pAzWQL1e7U8XT0RzcD
	szYqfkHs2LPJ7jWgInUH7gWwas3Q=
X-Gm-Gg: ASbGncvFdpb1ik25YzbMkUSIE5LaobUW4nGNc3J+wx66VrOotiriX7uwRhSEIy+XpkB
	XpM+MvPvRP5IDxDefEfn9zSC8iFQz+uZniLsP0y8KSDQj/kfKYv1akT/9pkPxqtdYv9WjQs/LVV
	YHLuYiMY3I3hZE2RUrwKZq
X-Google-Smtp-Source: AGHT+IE/GsPX1uW2/avIU5l39TViYkPVD2RbkI77lsDNz+M+/jSD/4I1UQBTJcDlIiQ7uZGOeV3KSOiXB9gbnW1XjrY=
X-Received: by 2002:a05:6830:7009:b0:72b:823c:8f66 with SMTP id
 46e09a7af769-731ead9b055mr4683607a34.9.1746442253915; Mon, 05 May 2025
 03:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMM3L+9_eGiDxjyhr4s2cW-2m+nntqgA49JS_eN9TEwog@mail.gmail.com>
In-Reply-To: <CABXGCsMM3L+9_eGiDxjyhr4s2cW-2m+nntqgA49JS_eN9TEwog@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 5 May 2025 15:50:43 +0500
X-Gm-Features: ATxdqUEDRfHj5CF5Cko89BVpqkr1pQ-so0LyxPW_jQ9LQ7uj3oMqkUJLmSOJ5zo
Message-ID: <CABXGCsPpaHg6AuAErqwGAVrsoXbxKvVTdu1HRqYy94BwKNvyVA@mail.gmail.com>
Subject: Re: 6.15-rc1/regression/bisected - commit ffa1e7ada456 introduced
 circular locking dependency at udev-worker
To: homas.hellstrom@linux.intel.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 8:57=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> In the new 6.15 release cycle, I spotted a new possible circular
> locking dependency in the kernel log, which was never before.
>
> [   19.601251] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   19.601252] WARNING: possible circular locking dependency detected
> [   19.601254] 6.15.0-rc1 #4 Tainted: G        W    L
> [   19.601257] ------------------------------------------------------
> [   19.601258] (udev-worker)/1069 is trying to acquire lock:
> [   19.601260] ffff888188934578 (&q->elevator_lock){+.+.}-{4:4}, at:
> elv_iosched_store+0x17c/0x4e0
> [   19.601272]
>                but task is already holding lock:
> [   19.601273] ffff888188933fe0
> (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x20
> [   19.601283]
>                which lock already depends on the new lock.
>
> [   19.601284]
>                the existing dependency chain (in reverse order) is:
> [   19.601285]
>                -> #2 (&q->q_usage_counter(io)#5){++++}-{0:0}:
> [   19.601290]        __lock_acquire+0x551/0xbb0
> [   19.601294]        lock_acquire.part.0+0xc8/0x270
> [   19.601296]        blk_alloc_queue+0x5ca/0x710
> [   19.601298]        blk_mq_alloc_queue+0x152/0x240
> [   19.601299]        scsi_alloc_sdev+0x85c/0xc90
> [   19.601302]        scsi_probe_and_add_lun+0x4d6/0xbd0
> [   19.601303]        __scsi_scan_target+0x18d/0x3b0
> [   19.601305]        scsi_scan_channel+0xfa/0x1a0
> [   19.601306]        scsi_scan_host_selected+0x1ff/0x2b0
> [   19.601308]        do_scan_async+0x42/0x450
> [   19.601309]        async_run_entry_fn+0x97/0x4f0
> [   19.601311]        process_one_work+0x88d/0x14b0
> [   19.601313]        worker_thread+0x5f3/0xfe0
> [   19.601314]        kthread+0x3b1/0x770
> [   19.601316]        ret_from_fork+0x31/0x70
> [   19.601318]        ret_from_fork_asm+0x1a/0x30
> [   19.601320]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [   19.601322]        __lock_acquire+0x551/0xbb0
> [   19.601324]        lock_acquire.part.0+0xc8/0x270
> [   19.601326]        fs_reclaim_acquire+0xc9/0x110
> [   19.601327]        kmem_cache_alloc_noprof+0x56/0x4d0
> [   19.601329]        __kernfs_new_node+0xcb/0x780
> [   19.601331]        kernfs_new_node+0xef/0x1b0
> [   19.601332]        kernfs_create_dir_ns+0x2b/0x150
> [   19.601334]        sysfs_create_dir_ns+0x130/0x280
> [   19.601335]        kobject_add_internal+0x272/0x800
> [   19.601337]        kobject_add+0x135/0x1a0
> [   19.601339]        elv_register_queue+0xbb/0x220
> [   19.601340]        blk_register_queue+0x31e/0x480
> [   19.601341]        add_disk_fwnode+0x716/0x1030
> [   19.601343]        sd_probe+0x887/0xe30
> [   19.601346]        really_probe+0x1e0/0x8a0
> [   19.601348]        __driver_probe_device+0x18c/0x370
> [   19.601349]        driver_probe_device+0x4a/0x120
> [   19.601350]        __device_attach_driver+0x162/0x270
> [   19.601351]        bus_for_each_drv+0x114/0x1a0
> [   19.601353]        __device_attach_async_helper+0x19e/0x240
> [   19.601354]        async_run_entry_fn+0x97/0x4f0
> [   19.601355]        process_one_work+0x88d/0x14b0
> [   19.601357]        worker_thread+0x5f3/0xfe0
> [   19.601358]        kthread+0x3b1/0x770
> [   19.601360]        ret_from_fork+0x31/0x70
> [   19.601361]        ret_from_fork_asm+0x1a/0x30
> [   19.601362]
>                -> #0 (&q->elevator_lock){+.+.}-{4:4}:
> [   19.601364]        check_prev_add+0xf1/0xcd0
> [   19.601366]        validate_chain+0x463/0x590
> [   19.601367]        __lock_acquire+0x551/0xbb0
> [   19.601368]        lock_acquire.part.0+0xc8/0x270
> [   19.601370]        __mutex_lock+0x1a9/0x1a70
> [   19.601371]        elv_iosched_store+0x17c/0x4e0
> [   19.601373]        queue_attr_store+0x237/0x300
> [   19.601374]        kernfs_fop_write_iter+0x3a0/0x5a0
> [   19.601376]        vfs_write+0x5f8/0xe90
> [   19.601378]        ksys_write+0xf9/0x1c0
> [   19.601379]        do_syscall_64+0x97/0x190
> [   19.601382]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   19.601383]
>                other info that might help us debug this:
>
> [   19.601384] Chain exists of:
>                  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter=
(io)#5
>
> [   19.601387]  Possible unsafe locking scenario:
>
> [   19.601387]        CPU0                    CPU1
> [   19.601388]        ----                    ----
> [   19.601388]   lock(&q->q_usage_counter(io)#5);
> [   19.601389]                                lock(fs_reclaim);
> [   19.601391]                                lock(&q->q_usage_counter(io=
)#5);
> [   19.601392]   lock(&q->elevator_lock);
> [   19.601393]
>                 *** DEADLOCK ***
>
> [   19.601393] 5 locks held by (udev-worker)/1069:
> [   19.601394]  #0: ffff8881144a2450 (sb_writers#4){.+.+}-{0:0}, at:
> ksys_write+0xf9/0x1c0
> [   19.601399]  #1: ffff88819d1f6090 (&of->mutex#2){+.+.}-{4:4}, at:
> kernfs_fop_write_iter+0x260/0x5a0
> [   19.601402]  #2: ffff888191d42d98 (kn->active#102){.+.+}-{0:0}, at:
> kernfs_fop_write_iter+0x283/0x5a0
> [   19.601406]  #3: ffff888188933fe0
> (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x20
> [   19.601410]  #4: ffff888188934020
> (&q->q_usage_counter(queue)#5){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x20
> [   19.601413]
>                stack backtrace:
> [   19.601415] CPU: 3 UID: 0 PID: 1069 Comm: (udev-worker) Tainted: G
>       W    L      6.15.0-rc1 #4 PREEMPT(lazy)
> [   19.601418] Tainted: [W]=3DWARN, [L]=3DSOFTLOCKUP
> [   19.601419] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 3222 03/05/2025
> [   19.601421] Call Trace:
> [   19.601422]  <TASK>
> [   19.601423]  dump_stack_lvl+0x84/0xd0
> [   19.601426]  print_circular_bug.cold+0x38/0x45
> [   19.601428]  check_noncircular+0x148/0x160
> [   19.601431]  check_prev_add+0xf1/0xcd0
> [   19.601433]  validate_chain+0x463/0x590
> [   19.601435]  __lock_acquire+0x551/0xbb0
> [   19.601437]  ? finish_task_switch.isra.0+0x1c5/0x880
> [   19.601439]  lock_acquire.part.0+0xc8/0x270
> [   19.601441]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601442]  ? rcu_is_watching+0x12/0xc0
> [   19.601444]  ? lock_acquire+0xee/0x130
> [   19.601446]  __mutex_lock+0x1a9/0x1a70
> [   19.601447]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601449]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601450]  ? mark_held_locks+0x40/0x70
> [   19.601451]  ? __raw_spin_unlock_irqrestore+0x5d/0x80
> [   19.601453]  ? __pfx___mutex_lock+0x10/0x10
> [   19.601454]  ? __raw_spin_unlock_irqrestore+0x46/0x80
> [   19.601456]  ? blk_mq_freeze_queue_wait+0x15e/0x170
> [   19.601458]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   19.601459]  ? lock_acquire+0xee/0x130
> [   19.601461]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601462]  elv_iosched_store+0x17c/0x4e0
> [   19.601464]  ? __pfx_elv_iosched_store+0x10/0x10
> [   19.601465]  ? kernfs_fop_write_iter+0x260/0x5a0
> [   19.601467]  ? kernfs_fop_write_iter+0x260/0x5a0
> [   19.601469]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   19.601470]  queue_attr_store+0x237/0x300
> [   19.601472]  ? __pfx_queue_attr_store+0x10/0x10
> [   19.601474]  ? __lock_acquire+0x551/0xbb0
> [   19.601476]  ? local_clock_noinstr+0xd/0x100
> [   19.601479]  ? __lock_release.isra.0+0x1a8/0x2f0
> [   19.601481]  ? sysfs_file_kobj+0xb3/0x1c0
> [   19.601483]  ? sysfs_file_kobj+0xbd/0x1c0
> [   19.601485]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   19.601487]  kernfs_fop_write_iter+0x3a0/0x5a0
> [   19.601489]  vfs_write+0x5f8/0xe90
> [   19.601491]  ? __pfx_vfs_write+0x10/0x10
> [   19.601494]  ? __lock_release.isra.0+0x1a8/0x2f0
> [   19.601496]  ksys_write+0xf9/0x1c0
> [   19.601498]  ? __pfx_ksys_write+0x10/0x10
> [   19.601501]  do_syscall_64+0x97/0x190
> [   19.601502]  ? __pfx_sched_clock_cpu+0x10/0x10
> [   19.601505]  ? irqentry_exit_to_user_mode+0xa2/0x290
> [   19.601506]  ? rcu_is_watching+0x12/0xc0
> [   19.601508]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   19.601509] RIP: 0033:0x7f2b95e7d406
> [   19.601514] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
> 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
> 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
> ec 08
> [   19.601515] RSP: 002b:00007ffe6800fe20 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [   19.601517] RAX: ffffffffffffffda RBX: 000055a2dbb57460 RCX: 00007f2b9=
5e7d406
> [   19.601518] RDX: 0000000000000003 RSI: 00007ffe68010170 RDI: 000000000=
0000013
> [   19.601519] RBP: 00007ffe6800fe40 R08: 0000000000000000 R09: 000000000=
0000000
> [   19.601520] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000003
> [   19.601521] R13: 0000000000000003 R14: 00007ffe68010170 R15: 00007ffe6=
8010170
> [   19.601527]  </TASK>
>
> Git bisect find this commit:
>
> commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
> Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Date:   Tue Mar 18 10:55:48 2025 +0100
>
>     block: Make request_queue lockdep splats show up earlier
>
>     In recent kernels, there are lockdep splats around the
>     struct request_queue::io_lockdep_map, similar to [1], but they
>     typically don't show up until reclaim with writeback happens.
>
>     Having multiple kernel versions released with a known risc of kernel
>     deadlock during reclaim writeback should IMHO be addressed and
>     backported to -stable with the highest priority.
>
>     In order to have these lockdep splats show up earlier,
>     preferrably during system initialization, prime the
>     struct request_queue::io_lockdep_map as GFP_KERNEL reclaim-
>     tainted. This will instead lead to lockdep splats looking similar
>     to [2], but without the need for reclaim + writeback
>     happening.
>
>     [1]:
>     [  189.762244] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     [  189.762432] WARNING: possible circular locking dependency detected
>     [  189.762441] 6.14.0-rc6-xe+ #6 Tainted: G     U
>     [  189.762450] ------------------------------------------------------
>     [  189.762459] kswapd0/119 is trying to acquire lock:
>     [  189.762467] ffff888110ceb710
> (&q->q_usage_counter(io)#26){++++}-{0:0}, at: __submit_bio+0x76/0x230
>     [  189.762485]
>                    but task is already holding lock:
>     [  189.762494] ffffffff834c97c0 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0xbe/0xb00
>     [  189.762507]
>                    which lock already depends on the new lock.
>
>     [  189.762519]
>                    the existing dependency chain (in reverse order) is:
>     [  189.762529]
>                    -> #2 (fs_reclaim){+.+.}-{0:0}:
>     [  189.762540]        fs_reclaim_acquire+0xc5/0x100
>     [  189.762548]        kmem_cache_alloc_lru_noprof+0x4a/0x480
>     [  189.762558]        alloc_inode+0xaa/0xe0
>     [  189.762566]        iget_locked+0x157/0x330
>     [  189.762573]        kernfs_get_inode+0x1b/0x110
>     [  189.762582]        kernfs_get_tree+0x1b0/0x2e0
>     [  189.762590]        sysfs_get_tree+0x1f/0x60
>     [  189.762597]        vfs_get_tree+0x2a/0xf0
>     [  189.762605]        path_mount+0x4cd/0xc00
>     [  189.762613]        __x64_sys_mount+0x119/0x150
>     [  189.762621]        x64_sys_call+0x14f2/0x2310
>     [  189.762630]        do_syscall_64+0x91/0x180
>     [  189.762637]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [  189.762647]
>                    -> #1 (&root->kernfs_rwsem){++++}-{3:3}:
>     [  189.762659]        down_write+0x3e/0xf0
>     [  189.762667]        kernfs_remove+0x32/0x60
>     [  189.762676]        sysfs_remove_dir+0x4f/0x60
>     [  189.762685]        __kobject_del+0x33/0xa0
>     [  189.762709]        kobject_del+0x13/0x30
>     [  189.762716]        elv_unregister_queue+0x52/0x80
>     [  189.762725]        elevator_switch+0x68/0x360
>     [  189.762733]        elv_iosched_store+0x14b/0x1b0
>     [  189.762756]        queue_attr_store+0x181/0x1e0
>     [  189.762765]        sysfs_kf_write+0x49/0x80
>     [  189.762773]        kernfs_fop_write_iter+0x17d/0x250
>     [  189.762781]        vfs_write+0x281/0x540
>     [  189.762790]        ksys_write+0x72/0xf0
>     [  189.762798]        __x64_sys_write+0x19/0x30
>     [  189.762807]        x64_sys_call+0x2a3/0x2310
>     [  189.762815]        do_syscall_64+0x91/0x180
>     [  189.762823]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [  189.762833]
>                    -> #0 (&q->q_usage_counter(io)#26){++++}-{0:0}:
>     [  189.762845]        __lock_acquire+0x1525/0x2760
>     [  189.762854]        lock_acquire+0xca/0x310
>     [  189.762861]        blk_mq_submit_bio+0x8a2/0xba0
>     [  189.762870]        __submit_bio+0x76/0x230
>     [  189.762878]        submit_bio_noacct_nocheck+0x323/0x430
>     [  189.762888]        submit_bio_noacct+0x2cc/0x620
>     [  189.762896]        submit_bio+0x38/0x110
>     [  189.762904]        __swap_writepage+0xf5/0x380
>     [  189.762912]        swap_writepage+0x3c7/0x600
>     [  189.762920]        shmem_writepage+0x3da/0x4f0
>     [  189.762929]        pageout+0x13f/0x310
>     [  189.762937]        shrink_folio_list+0x61c/0xf60
>     [  189.763261]        evict_folios+0x378/0xcd0
>     [  189.763584]        try_to_shrink_lruvec+0x1b0/0x360
>     [  189.763946]        shrink_one+0x10e/0x200
>     [  189.764266]        shrink_node+0xc02/0x1490
>     [  189.764586]        balance_pgdat+0x563/0xb00
>     [  189.764934]        kswapd+0x1e8/0x430
>     [  189.765249]        kthread+0x10b/0x260
>     [  189.765559]        ret_from_fork+0x44/0x70
>     [  189.765889]        ret_from_fork_asm+0x1a/0x30
>     [  189.766198]
>                    other info that might help us debug this:
>
>     [  189.767089] Chain exists of:
>                      &q->q_usage_counter(io)#26 -->
> &root->kernfs_rwsem --> fs_reclaim
>
>     [  189.767971]  Possible unsafe locking scenario:
>
>     [  189.768555]        CPU0                    CPU1
>     [  189.768849]        ----                    ----
>     [  189.769136]   lock(fs_reclaim);
>     [  189.769421]                                lock(&root->kernfs_rwse=
m);
>     [  189.769714]                                lock(fs_reclaim);
>     [  189.770016]   rlock(&q->q_usage_counter(io)#26);
>     [  189.770305]
>                     *** DEADLOCK ***
>
>     [  189.771167] 1 lock held by kswapd0/119:
>     [  189.771453]  #0: ffffffff834c97c0 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0xbe/0xb00
>     [  189.771770]
>                    stack backtrace:
>     [  189.772351] CPU: 4 UID: 0 PID: 119 Comm: kswapd0 Tainted: G
> U             6.14.0-rc6-xe+ #6
>     [  189.772353] Tainted: [U]=3DUSER
>     [  189.772354] Hardware name: ASUS System Product Name/PRIME
> B560M-A AC, BIOS 2001 02/01/2023
>     [  189.772354] Call Trace:
>     [  189.772355]  <TASK>
>     [  189.772356]  dump_stack_lvl+0x6e/0xa0
>     [  189.772359]  dump_stack+0x10/0x18
>     [  189.772360]  print_circular_bug.cold+0x17a/0x1b7
>     [  189.772363]  check_noncircular+0x13a/0x150
>     [  189.772365]  ? __pfx_stack_trace_consume_entry+0x10/0x10
>     [  189.772368]  __lock_acquire+0x1525/0x2760
>     [  189.772368]  ? ret_from_fork_asm+0x1a/0x30
>     [  189.772371]  lock_acquire+0xca/0x310
>     [  189.772372]  ? __submit_bio+0x76/0x230
>     [  189.772375]  ? lock_release+0xd5/0x2c0
>     [  189.772376]  blk_mq_submit_bio+0x8a2/0xba0
>     [  189.772378]  ? __submit_bio+0x76/0x230
>     [  189.772380]  __submit_bio+0x76/0x230
>     [  189.772382]  ? trace_hardirqs_on+0x1e/0xe0
>     [  189.772384]  submit_bio_noacct_nocheck+0x323/0x430
>     [  189.772386]  ? submit_bio_noacct_nocheck+0x323/0x430
>     [  189.772387]  ? __might_sleep+0x58/0xa0
>     [  189.772390]  submit_bio_noacct+0x2cc/0x620
>     [  189.772391]  ? count_memcg_events+0x68/0x90
>     [  189.772393]  submit_bio+0x38/0x110
>     [  189.772395]  __swap_writepage+0xf5/0x380
>     [  189.772396]  swap_writepage+0x3c7/0x600
>     [  189.772397]  shmem_writepage+0x3da/0x4f0
>     [  189.772401]  pageout+0x13f/0x310
>     [  189.772406]  shrink_folio_list+0x61c/0xf60
>     [  189.772409]  ? isolate_folios+0xe80/0x16b0
>     [  189.772410]  ? mark_held_locks+0x46/0x90
>     [  189.772412]  evict_folios+0x378/0xcd0
>     [  189.772414]  ? evict_folios+0x34a/0xcd0
>     [  189.772415]  ? lock_is_held_type+0xa3/0x130
>     [  189.772417]  try_to_shrink_lruvec+0x1b0/0x360
>     [  189.772420]  shrink_one+0x10e/0x200
>     [  189.772421]  shrink_node+0xc02/0x1490
>     [  189.772423]  ? shrink_node+0xa08/0x1490
>     [  189.772424]  ? shrink_node+0xbd8/0x1490
>     [  189.772425]  ? mem_cgroup_iter+0x366/0x480
>     [  189.772427]  balance_pgdat+0x563/0xb00
>     [  189.772428]  ? balance_pgdat+0x563/0xb00
>     [  189.772430]  ? trace_hardirqs_on+0x1e/0xe0
>     [  189.772431]  ? finish_task_switch.isra.0+0xcb/0x330
>     [  189.772433]  ? __switch_to_asm+0x33/0x70
>     [  189.772437]  kswapd+0x1e8/0x430
>     [  189.772438]  ? __pfx_autoremove_wake_function+0x10/0x10
>     [  189.772440]  ? __pfx_kswapd+0x10/0x10
>     [  189.772441]  kthread+0x10b/0x260
>     [  189.772443]  ? __pfx_kthread+0x10/0x10
>     [  189.772444]  ret_from_fork+0x44/0x70
>     [  189.772446]  ? __pfx_kthread+0x10/0x10
>     [  189.772447]  ret_from_fork_asm+0x1a/0x30
>     [  189.772450]  </TASK>
>
>     [2]:
>     [    8.760253] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     [    8.760254] WARNING: possible circular locking dependency detected
>     [    8.760255] 6.14.0-rc6-xe+ #7 Tainted: G     U
>     [    8.760256] ------------------------------------------------------
>     [    8.760257] (udev-worker)/674 is trying to acquire lock:
>     [    8.760259] ffff888100e39148 (&root->kernfs_rwsem){++++}-{3:3},
> at: kernfs_remove+0x32/0x60
>     [    8.760265]
>                    but task is already holding lock:
>     [    8.760266] ffff888110dc7680
> (&q->q_usage_counter(io)#27){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x30
>     [    8.760272]
>                    which lock already depends on the new lock.
>
>     [    8.760272]
>                    the existing dependency chain (in reverse order) is:
>     [    8.760273]
>                    -> #2 (&q->q_usage_counter(io)#27){++++}-{0:0}:
>     [    8.760276]        blk_alloc_queue+0x30a/0x350
>     [    8.760279]        blk_mq_alloc_queue+0x6b/0xe0
>     [    8.760281]        scsi_alloc_sdev+0x276/0x3c0
>     [    8.760284]        scsi_probe_and_add_lun+0x22a/0x440
>     [    8.760286]        __scsi_scan_target+0x109/0x230
>     [    8.760288]        scsi_scan_channel+0x65/0xc0
>     [    8.760290]        scsi_scan_host_selected+0xff/0x140
>     [    8.760292]        do_scsi_scan_host+0xa7/0xc0
>     [    8.760293]        do_scan_async+0x1c/0x160
>     [    8.760295]        async_run_entry_fn+0x32/0x150
>     [    8.760299]        process_one_work+0x224/0x5f0
>     [    8.760302]        worker_thread+0x1d4/0x3e0
>     [    8.760304]        kthread+0x10b/0x260
>     [    8.760306]        ret_from_fork+0x44/0x70
>     [    8.760309]        ret_from_fork_asm+0x1a/0x30
>     [    8.760312]
>                    -> #1 (fs_reclaim){+.+.}-{0:0}:
>     [    8.760315]        fs_reclaim_acquire+0xc5/0x100
>     [    8.760317]        kmem_cache_alloc_lru_noprof+0x4a/0x480
>     [    8.760319]        alloc_inode+0xaa/0xe0
>     [    8.760322]        iget_locked+0x157/0x330
>     [    8.760323]        kernfs_get_inode+0x1b/0x110
>     [    8.760325]        kernfs_get_tree+0x1b0/0x2e0
>     [    8.760327]        sysfs_get_tree+0x1f/0x60
>     [    8.760329]        vfs_get_tree+0x2a/0xf0
>     [    8.760332]        path_mount+0x4cd/0xc00
>     [    8.760334]        __x64_sys_mount+0x119/0x150
>     [    8.760336]        x64_sys_call+0x14f2/0x2310
>     [    8.760338]        do_syscall_64+0x91/0x180
>     [    8.760340]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [    8.760342]
>                    -> #0 (&root->kernfs_rwsem){++++}-{3:3}:
>     [    8.760345]        __lock_acquire+0x1525/0x2760
>     [    8.760347]        lock_acquire+0xca/0x310
>     [    8.760348]        down_write+0x3e/0xf0
>     [    8.760350]        kernfs_remove+0x32/0x60
>     [    8.760351]        sysfs_remove_dir+0x4f/0x60
>     [    8.760353]        __kobject_del+0x33/0xa0
>     [    8.760355]        kobject_del+0x13/0x30
>     [    8.760356]        elv_unregister_queue+0x52/0x80
>     [    8.760358]        elevator_switch+0x68/0x360
>     [    8.760360]        elv_iosched_store+0x14b/0x1b0
>     [    8.760362]        queue_attr_store+0x181/0x1e0
>     [    8.760364]        sysfs_kf_write+0x49/0x80
>     [    8.760366]        kernfs_fop_write_iter+0x17d/0x250
>     [    8.760367]        vfs_write+0x281/0x540
>     [    8.760370]        ksys_write+0x72/0xf0
>     [    8.760372]        __x64_sys_write+0x19/0x30
>     [    8.760374]        x64_sys_call+0x2a3/0x2310
>     [    8.760376]        do_syscall_64+0x91/0x180
>     [    8.760377]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [    8.760380]
>                    other info that might help us debug this:
>
>     [    8.760380] Chain exists of:
>                      &root->kernfs_rwsem --> fs_reclaim -->
> &q->q_usage_counter(io)#27
>
>     [    8.760384]  Possible unsafe locking scenario:
>
>     [    8.760384]        CPU0                    CPU1
>     [    8.760385]        ----                    ----
>     [    8.760385]   lock(&q->q_usage_counter(io)#27);
>     [    8.760387]                                lock(fs_reclaim);
>     [    8.760388]
> lock(&q->q_usage_counter(io)#27);
>     [    8.760390]   lock(&root->kernfs_rwsem);
>     [    8.760391]
>                     *** DEADLOCK ***
>
>     [    8.760391] 6 locks held by (udev-worker)/674:
>     [    8.760392]  #0: ffff8881209ac420 (sb_writers#4){.+.+}-{0:0},
> at: ksys_write+0x72/0xf0
>     [    8.760398]  #1: ffff88810c80f488 (&of->mutex#2){+.+.}-{3:3},
> at: kernfs_fop_write_iter+0x136/0x250
>     [    8.760402]  #2: ffff888125d1d330 (kn->active#101){.+.+}-{0:0},
> at: kernfs_fop_write_iter+0x13f/0x250
>     [    8.760406]  #3: ffff888110dc7bb0 (&q->sysfs_lock){+.+.}-{3:3},
> at: queue_attr_store+0x148/0x1e0
>     [    8.760411]  #4: ffff888110dc7680
> (&q->q_usage_counter(io)#27){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x30
>     [    8.760416]  #5: ffff888110dc76b8
> (&q->q_usage_counter(queue)#27){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x30
>     [    8.760421]
>                    stack backtrace:
>     [    8.760422] CPU: 7 UID: 0 PID: 674 Comm: (udev-worker) Tainted:
> G     U             6.14.0-rc6-xe+ #7
>     [    8.760424] Tainted: [U]=3DUSER
>     [    8.760425] Hardware name: ASUS System Product Name/PRIME
> B560M-A AC, BIOS 2001 02/01/2023
>     [    8.760426] Call Trace:
>     [    8.760427]  <TASK>
>     [    8.760428]  dump_stack_lvl+0x6e/0xa0
>     [    8.760431]  dump_stack+0x10/0x18
>     [    8.760433]  print_circular_bug.cold+0x17a/0x1b7
>     [    8.760437]  check_noncircular+0x13a/0x150
>     [    8.760441]  ? save_trace+0x54/0x360
>     [    8.760445]  __lock_acquire+0x1525/0x2760
>     [    8.760446]  ? irqentry_exit+0x3a/0xb0
>     [    8.760448]  ? sysvec_apic_timer_interrupt+0x57/0xc0
>     [    8.760452]  lock_acquire+0xca/0x310
>     [    8.760453]  ? kernfs_remove+0x32/0x60
>     [    8.760457]  down_write+0x3e/0xf0
>     [    8.760459]  ? kernfs_remove+0x32/0x60
>     [    8.760460]  kernfs_remove+0x32/0x60
>     [    8.760462]  sysfs_remove_dir+0x4f/0x60
>     [    8.760464]  __kobject_del+0x33/0xa0
>     [    8.760466]  kobject_del+0x13/0x30
>     [    8.760467]  elv_unregister_queue+0x52/0x80
>     [    8.760470]  elevator_switch+0x68/0x360
>     [    8.760472]  elv_iosched_store+0x14b/0x1b0
>     [    8.760475]  queue_attr_store+0x181/0x1e0
>     [    8.760479]  ? lock_acquire+0xca/0x310
>     [    8.760480]  ? kernfs_fop_write_iter+0x13f/0x250
>     [    8.760482]  ? lock_is_held_type+0xa3/0x130
>     [    8.760485]  sysfs_kf_write+0x49/0x80
>     [    8.760487]  kernfs_fop_write_iter+0x17d/0x250
>     [    8.760489]  vfs_write+0x281/0x540
>     [    8.760494]  ksys_write+0x72/0xf0
>     [    8.760497]  __x64_sys_write+0x19/0x30
>     [    8.760499]  x64_sys_call+0x2a3/0x2310
>     [    8.760502]  do_syscall_64+0x91/0x180
>     [    8.760504]  ? trace_hardirqs_off+0x5d/0xe0
>     [    8.760506]  ? handle_softirqs+0x479/0x4d0
>     [    8.760508]  ? hrtimer_interrupt+0x13f/0x280
>     [    8.760511]  ? irqentry_exit_to_user_mode+0x8b/0x260
>     [    8.760513]  ? clear_bhb_loop+0x15/0x70
>     [    8.760515]  ? clear_bhb_loop+0x15/0x70
>     [    8.760516]  ? clear_bhb_loop+0x15/0x70
>     [    8.760518]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     [    8.760520] RIP: 0033:0x7aa3bf2f5504
>     [    8.760522] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f
> 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 8b 10 00 00 74 13 b8 01 00
> 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec
> 20 48 89
>     [    8.760523] RSP: 002b:00007ffc1e3697d8 EFLAGS: 00000202
> ORIG_RAX: 0000000000000001
>     [    8.760526] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007aa3bf2f5504
>     [    8.760527] RDX: 0000000000000003 RSI: 00007ffc1e369ae0 RDI:
> 000000000000001c
>     [    8.760528] RBP: 00007ffc1e369800 R08: 00007aa3bf3f51c8 R09:
> 00007ffc1e3698b0
>     [    8.760528] R10: 0000000000000000 R11: 0000000000000202 R12:
> 0000000000000003
>     [    8.760529] R13: 00007ffc1e369ae0 R14: 0000613ccf21f2f0 R15:
> 00007aa3bf3f4e80
>     [    8.760533]  </TASK>
>
>     v2:
>     - Update a code comment to increase readability (Ming Lei).
>
>     Cc: Jens Axboe <axboe@kernel.dk>
>     Cc: linux-block@vger.kernel.org
>     Cc: linux-kernel@vger.kernel.org
>     Cc: Ming Lei <ming.lei@redhat.com>
>     Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m>
>     Reviewed-by: Ming Lei <ming.lei@redhat.com>
>     Link: https://lore.kernel.org/r/20250318095548.5187-1-thomas.hellstro=
m@linux.intel.com
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> Of course I checked revert of commit ffa1e7ada456
> And I can confirm that without ffa1e7ada456 this new circular locking
> dependency is not happening.
>
> My machine spec: https://linux-hardware.org/?probe=3D619658e7cf
> And I attached below my build config and full kernel log.
>
> Thomas, can you look please?

Excuse me, there's very little time left before the 6.15 release.
Perhaps it's time to address this regression?

--=20
Best Regards,
Mike Gavrilov.
