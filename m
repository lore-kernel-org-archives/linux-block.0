Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D798BA36
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431365; cv=none; b=cAv/W3duTjbWIEYMxrELvvfpIWiGP2sXHc9vKjtyKc2znWCsaYH5chvRYtrb3i14wg9dwWbATxlAfrAANQQxlrAtuuyBRAflGcL+8C5toRJUL3Lcj9TzxFYgfwVQR08eWm997sqyK3X5PYkhsfY6HLpElaS73A5NhNQn08/EYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431365; c=relaxed/simple;
	bh=/yEWpiCOOaVnFn2hjpzZmSJFWwTu61AymMKdbr/Axs8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Hk7daZwNNV5Rg3cKIYJApaAxPNAkrT8SQMFEN0XgNFJ8yUpi5NdfcnQa0bxm2mJSFDsos0RXVRZcnotrbUa7WDq6LPYbxlJlyQOkt1qweI00/rWGxvncG8TTaA+fSYK6X4F9bYSbi46Q66fEfgJp3Z8HwlAsmQu/lflJqBSRm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKsNQaJg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKsNQaJg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753431360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UpFk5wqajn4fQk3g02KNJ6sy5dgaJIJ/A7jGvLz/f0Q=;
	b=UKsNQaJgPi4ZJHojxFsJXMJC9qAID9gIMDYpMKU9Plh4ZiTZpqg7MyKm35abNtxkwVol36
	UL8K4+VjrY6S66DxV//JPTKBJUBIUHgxcTYGUFFpPQZGzvypI1oy0HhXFsqjpwdGssPNN3
	mLtrj5Ox83WOf557ydqJpNvBAG86QEw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Cc-sOHT1OPGzlZzh96rUSQ-1; Fri, 25 Jul 2025 04:15:58 -0400
X-MC-Unique: Cc-sOHT1OPGzlZzh96rUSQ-1
X-Mimecast-MFC-AGG-ID: Cc-sOHT1OPGzlZzh96rUSQ_1753431357
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32b4ef4055fso11697621fa.0
        for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 01:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431355; x=1754036155;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpFk5wqajn4fQk3g02KNJ6sy5dgaJIJ/A7jGvLz/f0Q=;
        b=TGmrem/tHAdz/Thi7RgJuf4B5/+Q6/5o+LHVN/q9mRe1wohLtaKn3q31rSnrvkoFtX
         Vb9v2yB21kz4dFJOAG2sEV+eincpkQ+ZzbrN8Lje8Wbn2vK3MeUuJkzyQThoEJkuL2zT
         nwSRMVp38moH1+FugoxiANSzkjeTmaY8bjmG3VbMezv1vaXr02JlyIAQWT17xTyseFG2
         RlvYZOkRdBcsNf46TzEVqpsNmUbKbr/4k1PRsYOtqC9zTBDQfC9M0botKQe8qmKk5hId
         FdsX4/OeF5mPtY5rrRyz6v2tzZdY9zmX2T/ND4qF/Fjtmj5PG7Ocvtz0M0Rs97nW+5nT
         t0Gw==
X-Gm-Message-State: AOJu0YwFOjTXhVATGp8vgPwfLXcSmmKXt+HfnikDGGDkAqMTcT79+vVN
	CftlmamyuJUvX673CGckjTXjfEMCV5Dgogy1Oe1ztiP37tQlJIKHxyILqgnXELmgbtX2xgZOnam
	VjMGRtIG3g+2rJRJUVk3Pz7Ih63zY+D7QzYsjTE6kLecnlD58gHLvuNfzpYPImEfe1vPMD7NI/u
	BSjiGMwk+I0K+orMVMwLumYLozSRx+JqcLraLXRJq9rY6hpqTusw==
X-Gm-Gg: ASbGncsU0KhHAqhAa5YTAM17P//e7q4PM90NkJufzgsFWCBP3yecn1AVmAhGVZQLk9P
	f7+MaZfIJ8IdNN7pgNCVPkc/gjIFfwsmNMNcuQRcSeJ22MunfGUKoz/DPMT0wWeIJ28UY6FXiAS
	lxXmfSNG4eKJzPPW/6SW9q4g==
X-Received: by 2002:a05:651c:12cb:b0:32c:bc69:e926 with SMTP id 38308e7fff4ca-331ee6027c7mr2220311fa.7.1753431355053;
        Fri, 25 Jul 2025 01:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrwljb83PHnkCk14gzFvwh4reUysUr3dkCrgugr+u8xTvmcwk9+mUSYQ8jV5n7NOspZVuK1OPoiPIsyjhLMvI=
X-Received: by 2002:a05:651c:12cb:b0:32c:bc69:e926 with SMTP id
 38308e7fff4ca-331ee6027c7mr2220241fa.7.1753431354460; Fri, 25 Jul 2025
 01:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 25 Jul 2025 16:15:41 +0800
X-Gm-Features: Ac12FXxf9IU7n-l6S8CQ_-HjwzVox6ARXZBtrTj6p_z9U4MIpHFKCzaXAcSPc1Y
Message-ID: <CAHj4cs9Umx=Qz-=Hmwp1foi4=bi4xV7RhKUndpcW=EMAzsQEUw@mail.gmail.com>
Subject: [bug report] blktests nvme/062 triggered possible circular locking at
 at: __kmalloc_cache_noprof+0x5e/0x4d0 and do_tcp_setsockopt+0x3d5/0x1ef0
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"

Hi

The following issue was triggered by blktests nvme/tcp nvme/062,
please help check it and let me know if you need any info/testing for
it, thanks.

nvme_trtype=tcp ./check nvme/062
nvme/062 (tr=tcp) (Create TLS-encrypted connections)         [failed]
    runtime  12.555s  ...  12.458s
    something found in dmesg:
    [ 1929.587774] run blktests nvme/062 at 2025-07-25 03:55:33
    [ 1930.595625] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
    [ 1930.731983] nvmet: Allow non-TLS connections while TLS1.3 is enabled
    [ 1930.788815] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
    [ 1931.204968] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
    [ 1931.251769] nvme nvme0: creating 48 I/O queues.
    [ 1931.395504] nvme nvme0: mapped 48/0/0 default/read/poll queues.
    [ 1931.602875] nvme nvme0: new ctrl: NQN "blktests-subsystem-1",
addr 127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
    [ 1932.393251] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

    ...
    (See '/root/blktests/results/nodev_tr_tcp/nvme/062.dmesg' for the
entire message)
[ 1929.587774] run blktests nvme/062 at 2025-07-25 03:55:33
[ 1930.595625] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1930.731983] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[ 1930.788815] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1931.204968] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1931.251769] nvme nvme0: creating 48 I/O queues.
[ 1931.395504] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[ 1931.602875] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1932.393251] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

[ 1933.232619] ======================================================
[ 1933.238806] WARNING: possible circular locking dependency detected
[ 1933.244990] 6.16.0-rc7+ #1 Not tainted
[ 1933.248743] ------------------------------------------------------
[ 1933.254923] tlshd/2605 is trying to acquire lock:
[ 1933.259629] ffffffff9ae53a00 (fs_reclaim){+.+.}-{0:0}, at:
__kmalloc_cache_noprof+0x5e/0x4d0
[ 1933.268078]
               but task is already holding lock:
[ 1933.273921] ffff88820fb48278 (sk_lock-AF_INET-NVME){+.+.}-{0:0},
at: do_tcp_setsockopt+0x3d5/0x1ef0
[ 1933.282983]
               which lock already depends on the new lock.

[ 1933.291156]
               the existing dependency chain (in reverse order) is:
[ 1933.298632]
               -> #4 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[ 1933.305166]        __lock_acquire+0x56a/0xbe0
[ 1933.309526]        lock_acquire.part.0+0xc8/0x270
[ 1933.314231]        lock_sock_nested+0x36/0xf0
[ 1933.318590]        tcp_sendmsg+0x20/0x50
[ 1933.322517]        sock_sendmsg+0x2f3/0x410
[ 1933.326701]        nvme_tcp_try_send_cmd_pdu+0x57f/0xbc0 [nvme_tcp]
[ 1933.332976]        nvme_tcp_try_send+0x1b3/0x9c0 [nvme_tcp]
[ 1933.338556]        nvme_tcp_queue_rq+0x43d/0x6c0 [nvme_tcp]
[ 1933.344138]        blk_mq_dispatch_rq_list+0x382/0x1480
[ 1933.349365]        __blk_mq_sched_dispatch_requests+0x1a8/0x4a0
[ 1933.355292]        blk_mq_sched_dispatch_requests+0xac/0x150
[ 1933.360950]        blk_mq_run_work_fn+0x12b/0x2c0
[ 1933.365655]        process_one_work+0x87a/0x14d0
[ 1933.370274]        worker_thread+0x5f2/0xfd0
[ 1933.374546]        kthread+0x3b0/0x770
[ 1933.378299]        ret_from_fork+0x3ef/0x510
[ 1933.382572]        ret_from_fork_asm+0x1a/0x30
[ 1933.387018]
               -> #3 (set->srcu){.+.+}-{0:0}:
[ 1933.392599]        __lock_acquire+0x56a/0xbe0
[ 1933.396957]        lock_sync.part.0+0x72/0xe0
[ 1933.401316]        __synchronize_srcu+0x98/0x2b0
[ 1933.405936]        elevator_switch+0x2a4/0x630
[ 1933.410389]        elevator_change+0x209/0x380
[ 1933.414834]        elevator_set_none+0x85/0xc0
[ 1933.419280]        blk_unregister_queue+0x142/0x2c0
[ 1933.424160]        __del_gendisk+0x263/0xa20
[ 1933.428432]        del_gendisk+0x106/0x190
[ 1933.432532]        nvme_ns_remove+0x32a/0x900 [nvme_core]
[ 1933.437955]        nvme_remove_namespaces+0x267/0x3b0 [nvme_core]
[ 1933.444074]        nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[ 1933.449846]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[ 1933.455964]        nvme_sysfs_delete+0x9a/0xc0 [nvme_core]
[ 1933.461474]        kernfs_fop_write_iter+0x39b/0x5a0
[ 1933.466439]        vfs_write+0x524/0xe70
[ 1933.470367]        ksys_write+0xff/0x200
[ 1933.474293]        do_syscall_64+0x98/0x3c0
[ 1933.478485]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1933.484058]
               -> #2 (&q->elevator_lock){+.+.}-{4:4}:
[ 1933.490333]        __lock_acquire+0x56a/0xbe0
[ 1933.494693]        lock_acquire.part.0+0xc8/0x270
[ 1933.499397]        __mutex_lock+0x1b2/0x1b70
[ 1933.503669]        elevator_change+0xb6/0x380
[ 1933.508030]        elv_iosched_store+0x24a/0x2c0
[ 1933.512646]        queue_attr_store+0x238/0x340
[ 1933.517179]        kernfs_fop_write_iter+0x39b/0x5a0
[ 1933.522145]        vfs_write+0x524/0xe70
[ 1933.526071]        ksys_write+0xff/0x200
[ 1933.529996]        do_syscall_64+0x98/0x3c0
[ 1933.534183]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1933.539755]
               -> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
[ 1933.546547]        __lock_acquire+0x56a/0xbe0
[ 1933.550906]        lock_acquire.part.0+0xc8/0x270
[ 1933.555613]        blk_alloc_queue+0x5cd/0x720
[ 1933.560058]        blk_mq_alloc_queue+0x14d/0x260
[ 1933.564765]        scsi_alloc_sdev+0x862/0xc90
[ 1933.569219]        scsi_probe_and_add_lun+0x4be/0xc10
[ 1933.574270]        __scsi_scan_target+0x18b/0x3b0
[ 1933.578976]        scsi_scan_channel+0xee/0x180
[ 1933.583508]        scsi_scan_host_selected+0x1fd/0x2c0
[ 1933.588649]        do_scan_async+0x42/0x450
[ 1933.592841]        async_run_entry_fn+0x94/0x540
[ 1933.597461]        process_one_work+0x87a/0x14d0
[ 1933.602080]        worker_thread+0x5f2/0xfd0
[ 1933.606352]        kthread+0x3b0/0x770
[ 1933.610103]        ret_from_fork+0x3ef/0x510
[ 1933.614375]        ret_from_fork_asm+0x1a/0x30
[ 1933.618822]
               -> #0 (fs_reclaim){+.+.}-{0:0}:
[ 1933.624489]        check_prev_add+0xe1/0xcf0
[ 1933.628763]        validate_chain+0x4cf/0x740
[ 1933.633121]        __lock_acquire+0x56a/0xbe0
[ 1933.637481]        lock_acquire.part.0+0xc8/0x270
[ 1933.642187]        fs_reclaim_acquire+0xd9/0x130
[ 1933.646814]        __kmalloc_cache_noprof+0x5e/0x4d0
[ 1933.651779]        __request_module+0x246/0x5d0
[ 1933.656310]        __tcp_ulp_find_autoload+0x1ce/0x310
[ 1933.661450]        tcp_set_ulp+0x38/0x2a0
[ 1933.665464]        do_tcp_setsockopt+0x3e5/0x1ef0
[ 1933.670169]        do_sock_setsockopt+0x157/0x380
[ 1933.674873]        __sys_setsockopt+0xe5/0x160
[ 1933.679321]        __x64_sys_setsockopt+0xbd/0x190
[ 1933.684112]        do_syscall_64+0x98/0x3c0
[ 1933.688297]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1933.693870]
               other info that might help us debug this:

[ 1933.701868] Chain exists of:
                 fs_reclaim --> set->srcu --> sk_lock-AF_INET-NVME

[ 1933.712127]  Possible unsafe locking scenario:

[ 1933.718048]        CPU0                    CPU1
[ 1933.722579]        ----                    ----
[ 1933.727112]   lock(sk_lock-AF_INET-NVME);
[ 1933.731123]                                lock(set->srcu);
[ 1933.736696]                                lock(sk_lock-AF_INET-NVME);
[ 1933.743223]   lock(fs_reclaim);
[ 1933.746367]
                *** DEADLOCK ***

[ 1933.752287] 1 lock held by tlshd/2605:
[ 1933.756038]  #0: ffff88820fb48278
(sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: do_tcp_setsockopt+0x3d5/0x1ef0
[ 1933.765519]
               stack backtrace:
[ 1933.769881] CPU: 32 UID: 0 PID: 2605 Comm: tlshd Not tainted
6.16.0-rc7+ #1 PREEMPT(lazy)
[ 1933.769887] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.22.2 09/12/2024
[ 1933.769889] Call Trace:
[ 1933.769892]  <TASK>
[ 1933.769895]  dump_stack_lvl+0x84/0xd0
[ 1933.769903]  print_circular_bug.cold+0x38/0x46
[ 1933.769910]  check_noncircular+0x14a/0x170
[ 1933.769919]  check_prev_add+0xe1/0xcf0
[ 1933.769926]  validate_chain+0x4cf/0x740
[ 1933.769934]  __lock_acquire+0x56a/0xbe0
[ 1933.769940]  lock_acquire.part.0+0xc8/0x270
[ 1933.769944]  ? __kmalloc_cache_noprof+0x5e/0x4d0
[ 1933.769950]  ? rcu_is_watching+0x15/0xe0
[ 1933.769955]  ? __kmalloc_cache_noprof+0x5e/0x4d0
[ 1933.769958]  ? lock_acquire+0xf7/0x140
[ 1933.769963]  fs_reclaim_acquire+0xd9/0x130
[ 1933.769967]  ? __kmalloc_cache_noprof+0x5e/0x4d0
[ 1933.769971]  __kmalloc_cache_noprof+0x5e/0x4d0
[ 1933.769975]  ? mark_held_locks+0x40/0x70
[ 1933.769978]  ? __request_module+0x246/0x5d0
[ 1933.769983]  ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
[ 1933.769986]  ? trace_hardirqs_on+0x18/0x150
[ 1933.769994]  ? __request_module+0x246/0x5d0
[ 1933.769998]  __request_module+0x246/0x5d0
[ 1933.770003]  ? __pfx___request_module+0x10/0x10
[ 1933.770015]  ? __lock_release.isra.0+0x1cb/0x340
[ 1933.770020]  ? __tcp_ulp_find_autoload+0x1ad/0x310
[ 1933.770025]  __tcp_ulp_find_autoload+0x1ce/0x310
[ 1933.770030]  tcp_set_ulp+0x38/0x2a0
[ 1933.770034]  ? __local_bh_enable_ip+0xaf/0x170
[ 1933.770039]  do_tcp_setsockopt+0x3e5/0x1ef0
[ 1933.770044]  ? __pfx_do_tcp_setsockopt+0x10/0x10
[ 1933.770048]  ? page_table_check_set+0x272/0x520
[ 1933.770055]  ? __page_table_check_ptes_set+0x202/0x3b0
[ 1933.770060]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
[ 1933.770068]  ? find_held_lock+0x2b/0x80
[ 1933.770076]  do_sock_setsockopt+0x157/0x380
[ 1933.770081]  ? __pfx_do_sock_setsockopt+0x10/0x10
[ 1933.770084]  ? filemap_map_pages+0x5e7/0xe50
[ 1933.770096]  __sys_setsockopt+0xe5/0x160
[ 1933.770103]  __x64_sys_setsockopt+0xbd/0x190
[ 1933.770107]  ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
[ 1933.770110]  ? lockdep_hardirqs_on+0x8c/0x130
[ 1933.770115]  ? do_syscall_64+0x5c/0x3c0
[ 1933.770119]  do_syscall_64+0x98/0x3c0
[ 1933.770122]  ? rcu_is_watching+0x15/0xe0
[ 1933.770128]  ? rcu_read_unlock+0x17/0x60
[ 1933.770134]  ? rcu_read_unlock+0x1c/0x60
[ 1933.770137]  ? do_read_fault+0x2f0/0x8d0
[ 1933.770143]  ? __lock_release.isra.0+0x1cb/0x340
[ 1933.770148]  ? do_fault+0x441/0x810
[ 1933.770154]  ? handle_pte_fault+0x43e/0x740
[ 1933.770157]  ? __lock_acquire+0x56a/0xbe0
[ 1933.770161]  ? __pfx_handle_pte_fault+0x10/0x10
[ 1933.770166]  ? __pfx_pmd_val+0x10/0x10
[ 1933.770173]  ? __handle_mm_fault+0xa85/0xfc0
[ 1933.770178]  ? __lock_acquire+0x56a/0xbe0
[ 1933.770185]  ? find_held_lock+0x2b/0x80
[ 1933.770189]  ? __lock_release.isra.0+0x1cb/0x340
[ 1933.770193]  ? count_memcg_events+0x2d2/0x4d0
[ 1933.770200]  ? __lock_release.isra.0+0x1cb/0x340
[ 1933.770206]  ? do_user_addr_fault+0x4b1/0xa60
[ 1933.770216]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1933.770220] RIP: 0033:0x7efdbf3ad2ae
[ 1933.770224] Code: 55 48 63 c9 48 63 ff 45 89 c9 48 89 e5 48 83 ec
08 6a 2c e8 34 83 f7 ff c9 c3 66 90 f3 0f 1e fa 49 89 ca b8 36 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b
15 19
[ 1933.770228] RSP: 002b:00007ffc484274c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000036
[ 1933.770232] RAX: ffffffffffffffda RBX: 000055bbbe68bd30 RCX: 00007efdbf3ad2ae
[ 1933.770235] RDX: 000000000000001f RSI: 0000000000000006 RDI: 0000000000000005
[ 1933.770237] RBP: 00007ffc48427520 R08: 0000000000000004 R09: 0000000000000070
[ 1933.770239] R10: 000055bb84d6fd94 R11: 0000000000000202 R12: 000055bbbe699c50
[ 1933.770242] R13: 00007ffc484274e4 R14: 00007ffc48427570 R15: 00007ffc48427570
[ 1933.770251]  </TASK>
[ 1934.154700] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349,
TLS.
[ 1934.188204] nvme nvme0: creating 48 I/O queues.
[ 1935.858783] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[ 1936.037048] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1936.466806] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1937.085812] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1937.177592] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1937.425838] nvme_tcp: queue 0: failed to receive icresp, error -104
[ 1939.615899] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349,
TLS.
[ 1939.650045] nvme nvme0: creating 48 I/O queues.
[ 1940.929671] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[ 1941.099232] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1941.531299] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"


-- 
Best Regards,
  Yi Zhang

