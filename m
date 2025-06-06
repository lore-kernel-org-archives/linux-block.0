Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48D4A0A
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749181074; cv=none; b=UEAf7uh8tg0O+ShZ46auLxVkXO/LQp/yeiNrjasMaVpQQkeokrwbqGKDEOv6YApQK1HUtsakhC/xm8DEJ908EKexEXL56Rr7Tsym/OBq+QlIoR+gYwY4j1H7LUtGuczHXqx+XiX4Gv3tmVcDR2a387+2spECRVPzWKzWL7GJIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749181074; c=relaxed/simple;
	bh=9v/ohZdNPGb+rH+0FHEqyVQ1vp73YhNFTeyHTqhhbKU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jKQoN5K39KI2WsJ43P8lVnFg2tRNDFGDmK8YPH0wW8hebhYGJdavKuXHcZ5al7FyL/GQ5Kc8kWZwQdYYsCJL/Cc/iyv8QBGaNfQzhylVdSeXiCveZfQ5gwtBPf+/ZBXIgTQ2lJhHaWPPpQKs9MNGWavxIL5YCcCphGV7zL2Ue04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NODGwZ/A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NODGwZ/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749181071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MZ6CSTem0sCjOhlxkkRJl4t0cacF+EyNk4yrXqUCF10=;
	b=NODGwZ/AitTUXh0s6X7Rgninr/67I1i384YvY/vBYFO/h0aD1AS7FR090xx6T7Aapo1yqD
	eIhoaOCOOuWkuRHLcUZx7iClAQoeviz7VrG9/uLInsQTG4cXsW+QFyQ7/GgTgt6Sc8SEdy
	KT8PH+4UM9t3OvFfOnV5yRP9jtZax3E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-7AV5yp0RPaiqu3dH1hntZg-1; Thu, 05 Jun 2025 23:37:49 -0400
X-MC-Unique: 7AV5yp0RPaiqu3dH1hntZg-1
X-Mimecast-MFC-AGG-ID: 7AV5yp0RPaiqu3dH1hntZg_1749181068
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5532a0fd5f7so1438868e87.0
        for <linux-block@vger.kernel.org>; Thu, 05 Jun 2025 20:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749181068; x=1749785868;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZ6CSTem0sCjOhlxkkRJl4t0cacF+EyNk4yrXqUCF10=;
        b=Man345J7Plp7Y5hemIAls3FO1hl6mvBRGfVZIMxpeIJlFYj8BoKzTjtLKvDJ1vQE10
         Mw6hsCktYdx3QP8xyvLKMU2q7xcuVvrHPT8Zi2y9iuYWdDscnZOXbZrioQwZ4WISSAZw
         KGZMxaJCNl/TFknVkvRjR2a6jPHiwx60LMokOT7lWtgjKXMuyPHiTa6V61ictxRpyChq
         Kg7ijIKt+9EBONMyEkg7RggOV1uhd4YEaF52JqLmJGfIlcjjmtHiIfnaPugxy0ubLjwR
         yUl/U06S2e6hstpaKklEF8BOryqKDTVLA2ob2DFjkn84KzNISETd+QykkEwJn3GgCLGi
         DZwA==
X-Forwarded-Encrypted: i=1; AJvYcCWBABWoDEFYaOasgQLhHfowdsZez9fqFTv2VnWgzevosmkMw/t+SHwrnLWC9XXbZ0rPZn8TcpiQb2LZXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7C/gpVW+l1lm2NL6wKj3CR6t4yi2+MGyNMQaI1cM99lpJWoxW
	wrdM/PTygtrDukyGCxuJ5oXTfNtzACWnvyDthwTo1GWzEk93C0wZudPA7NC1KHzh3hk+04n6QFV
	EdPCw/7s/gikTrkZKs0koYvob756P1yY6dO7poLziK1ifYPndFoC9A3AWQ7GWjxKSxogfVr50CC
	H4rigFII1DKcF6rdkQglEZMjooRj+xr0WgPLPGvwUYry68W7I7+0BF
X-Gm-Gg: ASbGncvX6eFxRr8iFAdodhJABpbZWNLI37uvKe2SoSeg9dY5z9iKl2Sc5KvXpw2TuzW
	uJG0XO1y5HKTaHM7Cx/dDc6ufvGMty2cRIyB5WabCYixuC2k05V24ZfDO3zzzdVuaI53Co8+v2b
	KiRkC2
X-Received: by 2002:a05:6512:3f2a:b0:553:243c:c1d3 with SMTP id 2adb3069b0e04-5535d92b33bmr1726513e87.18.1749181067416;
        Thu, 05 Jun 2025 20:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9YhpW4K1aVI+bFseGfGqbWwGUYteIhsDlhD1rqrjfIFs8lkamhjn6ygV6VctDKcbYQQD8jdypHhKBkCWmOiM=
X-Received: by 2002:a05:6512:3f2a:b0:553:243c:c1d3 with SMTP id
 2adb3069b0e04-5535d92b33bmr1726509e87.18.1749181066919; Thu, 05 Jun 2025
 20:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 6 Jun 2025 11:37:34 +0800
X-Gm-Features: AX0GCFvcz9u6n-0kerfEbXTq_4LyFqlSM-KQBhKax9isyE7oeZeMBEXy68QWoMI
Message-ID: <CAHj4cs8mJ+R_GmQm9R8ebResKAWUE8kF5+_WVg0v8zndmqd6BQ@mail.gmail.com>
Subject: [bug report] WARNING: possible circular locking dependency detected
 at: touch_wq_lockdep_map+0x7a/0x180 and bdev_release+0x133/0x610
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

The following WARNING was triggered by blktests nvme/fc nvme/014,
please help check it and let me know if you need any info/test,
thanks.

commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
'block-6.16' into for-next

[ 6203.657359] run blktests nvme/014 at 2025-06-05 20:49:29
[ 6204.661032] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 6205.826954] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 6205.838787] (NULL device *): {0:0} Association created
[ 6205.845842] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 6205.912304] nvme nvme0: NVME-FC{0}: controller connect complete
[ 6205.912437] nvme nvme0: NVME-FC{0}: new ctrl: NQN
"blktests-subsystem-1", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 6374.182936] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 6374.709525] (NULL device *): {0:0} Association deleted
[ 6375.647745] (NULL device *): {0:0} Association freed
[ 6375.648091] (NULL device *): Disconnect LS failed: No Association

[ 6375.963270] ======================================================
[ 6375.964019] WARNING: possible circular locking dependency detected
[ 6375.964892] 6.15.0+ #2 Tainted: G        W
[ 6375.965212] ------------------------------------------------------
[ 6375.965937] systemd-udevd/1345 is trying to acquire lock:
[ 6375.966238] ffff888886bd9d58 ((wq_completion)kblockd){+.+.}-{0:0},
at: touch_wq_lockdep_map+0x7a/0x180
[ 6375.966758]
               but task is already holding lock:
[ 6375.967466] ffff8888f1db1398 (&disk->open_mutex){+.+.}-{4:4}, at:
bdev_release+0x133/0x610
[ 6375.967909]
               which lock already depends on the new lock.

[ 6375.968342]
               the existing dependency chain (in reverse order) is:
[ 6375.969095]
               -> #2 (&disk->open_mutex){+.+.}-{4:4}:
[ 6375.969819]        __lock_acquire+0x57c/0xbd0
[ 6375.970481]        lock_acquire.part.0+0xbd/0x260
[ 6375.971112]        __mutex_lock+0x1ac/0x13e0
[ 6375.971763]        nvme_partition_scan_work+0x8a/0x120 [nvme_core]
[ 6375.972546]        process_one_work+0xd8b/0x1320
[ 6375.973180]        worker_thread+0x5f3/0xfe0
[ 6375.973798]        kthread+0x3b4/0x770
[ 6375.974001]        ret_from_fork+0x393/0x480
[ 6375.974618]        ret_from_fork_asm+0x1a/0x30
[ 6375.975232]
               -> #1
((work_completion)(&head->partition_scan_work)){+.+.}-{0:0}:
[ 6375.976058]        __lock_acquire+0x57c/0xbd0
[ 6375.976886]        lock_acquire.part.0+0xbd/0x260
[ 6375.977569]        process_one_work+0xd58/0x1320
[ 6375.978223]        worker_thread+0x5f3/0xfe0
[ 6375.979045]        kthread+0x3b4/0x770
[ 6375.979266]        ret_from_fork+0x393/0x480
[ 6375.980058]        ret_from_fork_asm+0x1a/0x30
[ 6375.980979]
               -> #0 ((wq_completion)kblockd){+.+.}-{0:0}:
[ 6375.981347]        check_prev_add+0xf1/0xcd0
[ 6375.982015]        validate_chain+0x487/0x570
[ 6375.982684]        __lock_acquire+0x57c/0xbd0
[ 6375.983486]        lock_acquire.part.0+0xbd/0x260
[ 6375.984127]        touch_wq_lockdep_map+0x93/0x180
[ 6375.984768]        start_flush_work+0x4b8/0x9a0
[ 6375.985434]        __flush_work+0xc4/0x1b0
[ 6375.985663]        nvme_mpath_put_disk+0x4f/0xa0 [nvme_core]
[ 6375.986552]        nvme_free_ns_head+0x23/0x160 [nvme_core]
[ 6375.986903]        bdev_release+0x3be/0x610
[ 6375.987152]        blkdev_release+0x11/0x20
[ 6375.987368]        __fput+0x372/0xaa0
[ 6375.987585]        task_work_run+0x11b/0x200
[ 6375.988226]        do_exit+0x5ee/0xee0
[ 6375.988458]        do_group_exit+0xbc/0x250
[ 6375.988673]        get_signal+0x11e8/0x15a0
[ 6375.988892]        arch_do_signal_or_restart+0x88/0x2e0
[ 6375.989201]        exit_to_user_mode_loop+0x96/0x150
[ 6375.989478]        do_syscall_64+0x1f7/0x8d0
[ 6375.990104]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 6375.990397]
               other info that might help us debug this:

[ 6376.013165] Chain exists of:
                 (wq_completion)kblockd -->
(work_completion)(&head->partition_scan_work) --> &disk->open_mutex

[ 6376.101737]  Possible unsafe locking scenario:

[ 6376.142114]        CPU0                    CPU1
[ 6376.174820]        ----                    ----
[ 6376.207831]   lock(&disk->open_mutex);
[ 6376.236250]
lock((work_completion)(&head->partition_scan_work));
[ 6376.291674]                                lock(&disk->open_mutex);
[ 6376.334181]   lock((wq_completion)kblockd);
[ 6376.364966]
                *** DEADLOCK ***

[ 6376.405228] 2 locks held by systemd-udevd/1345:
[ 6376.438233]  #0: ffff8888f1db1398 (&disk->open_mutex){+.+.}-{4:4},
at: bdev_release+0x133/0x610
[ 6376.491497]  #1: ffffffffacb33f80 (rcu_read_lock){....}-{1:3}, at:
start_flush_work+0x34/0x9a0
[ 6376.492457]
               stack backtrace:
[ 6376.493107] CPU: 18 UID: 0 PID: 1345 Comm: systemd-udevd Tainted: G
       W           6.15.0+ #2 PREEMPT(lazy)
[ 6376.493116] Tainted: [W]=WARN
[ 6376.493118] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
Gen9, BIOS P89 10/05/2016
[ 6376.493122] Call Trace:
[ 6376.493125]  <TASK>
[ 6376.493130]  dump_stack_lvl+0x6f/0xb0
[ 6376.493140]  print_circular_bug.cold+0x38/0x45
[ 6376.493148]  check_noncircular+0x148/0x160
[ 6376.493158]  check_prev_add+0xf1/0xcd0
[ 6376.493163]  ? alloc_chain_hlocks+0x13e/0x1d0
[ 6376.493168]  ? add_chain_cache+0x12c/0x310
[ 6376.493173]  validate_chain+0x487/0x570
[ 6376.493181]  __lock_acquire+0x57c/0xbd0
[ 6376.493188]  lock_acquire.part.0+0xbd/0x260
[ 6376.493193]  ? touch_wq_lockdep_map+0x7a/0x180
[ 6376.493199]  ? rcu_is_watching+0x15/0xb0
[ 6376.493208]  ? lock_acquire+0x10b/0x150
[ 6376.493214]  ? touch_wq_lockdep_map+0x7a/0x180
[ 6376.493218]  touch_wq_lockdep_map+0x93/0x180
[ 6376.493221]  ? touch_wq_lockdep_map+0x7a/0x180
[ 6376.493225]  ? start_flush_work+0x3e9/0x9a0
[ 6376.493231]  start_flush_work+0x4b8/0x9a0
[ 6376.493238]  __flush_work+0xc4/0x1b0
[ 6376.493244]  ? __pfx___flush_work+0x10/0x10
[ 6376.493250]  ? __pfx_wq_barrier_func+0x10/0x10
[ 6376.493264]  ? __pfx___might_resched+0x10/0x10
[ 6376.493272]  ? queue_work_on+0x90/0xf0
[ 6376.493277]  ? lockdep_hardirqs_on+0x78/0x100
[ 6376.493285]  nvme_mpath_put_disk+0x4f/0xa0 [nvme_core]
[ 6376.493321]  nvme_free_ns_head+0x23/0x160 [nvme_core]
[ 6376.493352]  bdev_release+0x3be/0x610
[ 6376.493359]  blkdev_release+0x11/0x20
[ 6376.493363]  __fput+0x372/0xaa0
[ 6376.493372]  task_work_run+0x11b/0x200
[ 6376.493378]  ? __pfx_task_work_run+0x10/0x10
[ 6376.493384]  ? do_exit+0x5e9/0xee0
[ 6376.493390]  do_exit+0x5ee/0xee0
[ 6376.493395]  ? __pfx_do_exit+0x10/0x10
[ 6376.493399]  ? __pfx_proc_coredump_connector+0x10/0x10
[ 6376.493409]  do_group_exit+0xbc/0x250
[ 6376.493415]  get_signal+0x11e8/0x15a0
[ 6376.493425]  ? __pfx_blkdev_common_ioctl+0x10/0x10
[ 6376.493431]  ? __pfx_get_signal+0x10/0x10
[ 6376.493436]  ? ioctl_has_perm.constprop.0.isra.0+0x31c/0x500
[ 6376.493445]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 6376.493450]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[ 6376.493456]  arch_do_signal_or_restart+0x88/0x2e0
[ 6376.493462]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[ 6376.493473]  exit_to_user_mode_loop+0x96/0x150
[ 6376.493479]  do_syscall_64+0x1f7/0x8d0
[ 6376.493484]  ? find_held_lock+0x32/0x90
[ 6376.493492]  ? local_clock_noinstr+0xd/0xe0
[ 6376.493497]  ? __lock_release.isra.0+0x1a4/0x2c0
[ 6376.493503]  ? exc_page_fault+0x78/0xf0
[ 6376.493509]  ? rcu_is_watching+0x15/0xb0
[ 6376.493518]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 6376.493523] RIP: 0033:0x7f361af285ff
[ 6376.493528] Code: Unable to access opcode bytes at 0x7f361af285d5.
[ 6376.493531] RSP: 002b:00007fff694dbfe0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 6376.493536] RAX: 0000000000000000 RBX: 000000000000000e RCX: 00007f361af285ff
[ 6376.493540] RDX: 0000000000000000 RSI: 000000000000125f RDI: 000000000000000e
[ 6376.493543] RBP: 000000000000000e R08: 0000000000000069 R09: 00000000fffffffe
[ 6376.493546] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff694dc0b0
[ 6376.493549] R13: 00007fff694dc080 R14: 000055738fa16950 R15: 0000000000000000
[ 6376.493558]  </TASK>

-- 
Best Regards,
  Yi Zhang

