Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150F23DEB6
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837958; cv=none; b=mTZS/MygTBfjIdVdYtIE9uRoDk6JBQVMNW4IcGaH9Yz647uCxu4Tu4yroSGWxgLQcOjxra4zMZtOoI8bdyscPQdg116SUblITvARm+468LUgpI2uM6zj6BgBFE4jAflI5P2qLkvKdZpwQ9oJJ4PmZLNxqRz1XAh67jmyKVic2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837958; c=relaxed/simple;
	bh=4v2Xf3pygzNXdvUbzXy4zrek+SGtK8iOLtBgc9/MyWc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FE0GCZo+HaZifyAB31G9O/UpsvZZyxlk7DQXBgBSB5O7OgGZsSfbqQ7KfxOOQm8CgO8i7k/LtEk4c++qxcUrkWq9DlNggsjnFdokkEyQaf6mAw/pgwAoSFDc6U/Sc/2oTP5g+yW99DHSx7PzF1ys1ijtvQeqPzehrhPGdAnMG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDNzcbO/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDNzcbO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733837954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Fb5lPB8hivzQAUGcocq99emW+CP5xarsAgb9x6DzjM8=;
	b=dDNzcbO/oYAm7t09BOamWss+2XWJHYMwSMMFugT17plBBsa6UxZhlRJj2YtVnXjvviMx7p
	cBxp6k/7W7YOv8JINvXMY7bnJH76Y3bv81dVxzQ2HxeqNeJT1MSeLeZNnTa8ONnfcOxa0w
	QGay9JkUMotVLPUd7yKq1vI0u6DN3Ps=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-IognBXdyMd-4l2H3GEVAIw-1; Tue, 10 Dec 2024 08:39:13 -0500
X-MC-Unique: IognBXdyMd-4l2H3GEVAIw-1
X-Mimecast-MFC-AGG-ID: IognBXdyMd-4l2H3GEVAIw
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3023b212f2bso2738281fa.0
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 05:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837950; x=1734442750;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fb5lPB8hivzQAUGcocq99emW+CP5xarsAgb9x6DzjM8=;
        b=hPTOjnmPlnwSpZUAVG21UIXVpgidzunSmp7FQBwsWzpYtx2gjb2rWJSEDyGk55KW8X
         eX2qo4vXjhcq6OQ1WWhWquS9e3KYWpiv3BkKAEaeChhovY9evaKP1oQEoTdGtUhSsjUR
         JXHx2z9Qtrmfe9q2SAQeQIpeorh2JB4lb7LnQcmIGrfsC1RuHvR3hATnQUkK/+VvAMvO
         fxm15lFBZ4j+7S1U9ZCFSxI+SQpZKvvxgIeU+I7kZdm9rBuFuBTWSwYkF+EjreP+Z6o1
         VV1NRKiezs26Rlsgfb6Ue0RmSCE2qtrn0QqR+ahZwJeIxof0evPMsG9YORBJrFRcpnfY
         uR6A==
X-Gm-Message-State: AOJu0Yxgh+Prf6Ijmg+YHNE7vUcNIQ37wlYUht7T31LbZ0KwoLUWn2fl
	71sXgeHc4mKkZWpGpGPgnCe1lLsixGclm1MlfgDOapr6MtRhq5I4pZLVRJ5XHjg4NwSORlFOEp5
	Zp5xGyxULrJOGFYt20TUzxL+GulhSmbtIO4WKdY1sce3yctLeh5lveyW1xGcmxmYzm05TImkt6z
	grgjdoDS+E777g3tc/2OjSj/29dxegYMBd1TXfQnaMq60cfOR8
X-Gm-Gg: ASbGncv3l5gqLIekVWZ0SUBpL6FNdDYR3LR7CYFLsRumPtK+hQ6kh3IEDRRbStk+pF1
	Y69jr29yDsZgFo7XhA73yE2aN6Ehm8v/bjo+5
X-Received: by 2002:a2e:9ec7:0:b0:302:336a:84e5 with SMTP id 38308e7fff4ca-302336a8566mr8082461fa.39.1733837949950;
        Tue, 10 Dec 2024 05:39:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETMKcoXN4Vi3StY5cSMc0otZVrcyX9zVUwtYDMIRJxslKxfsluW3sAZ6ZAMQqzDnh9++DJLz1og0IZndKLh3w=
X-Received: by 2002:a2e:9ec7:0:b0:302:336a:84e5 with SMTP id
 38308e7fff4ca-302336a8566mr8082361fa.39.1733837948995; Tue, 10 Dec 2024
 05:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 10 Dec 2024 21:38:57 +0800
Message-ID: <CAHj4cs81UJeO-9gBHxO4qGjozLyhFnYJ6_YuG2sD8-TqJgEu5A@mail.gmail.com>
Subject: [bug report] WARNING: possible circular locking dependency detected
 at blk_mq_submit_bio+0x43d/0x18d0 and xfs_create+0x31f/0x8c0 [xfs]
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello
I found this circular locking dependency issue from v6.13-rc1 with
blktests nvme/012, please help check it, thanks.

[ 9908.538638] run blktests nvme/012 at 2024-12-04 08:49:38
[ 9908.965251] loop0: detected capacity change from 0 to 2097152
[ 9909.086611] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 9909.689505] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 9909.697002] nvme nvme3: creating 16 I/O queues.
[ 9909.744794] nvme nvme3: new ctrl: "blktests-subsystem-1"
[ 9911.067192] XFS (nvme3n1): Mounting V5 Filesystem
d2ab7427-0950-4ac1-94fb-8f885179f74c
[ 9911.118718] XFS (nvme3n1): Ending clean mount

[ 9911.483147] ======================================================
[ 9911.489334] WARNING: possible circular locking dependency detected
[ 9911.495514] 6.13.0-rc1 #1 Not tainted
[ 9911.499186] ------------------------------------------------------
[ 9911.505367] fio/50910 is trying to acquire lock:
[ 9911.509994] ffff8881eb87e9b0
(&q->q_usage_counter(io)#31){++++}-{0:0}, at:
blk_mq_submit_bio+0x43d/0x18d0
[ 9911.519588]
               but task is already holding lock:
[ 9911.525421] ffff88812b4d3920 (&xfs_dir_ilock_class/5){+.+.}-{4:4},
at: xfs_create+0x31f/0x8c0 [xfs]
[ 9911.534841]
               which lock already depends on the new lock.

[ 9911.543021]
               the existing dependency chain (in reverse order) is:
[ 9911.550500]
               -> #5 (&xfs_dir_ilock_class/5){+.+.}-{4:4}:
[ 9911.557218]        __lock_acquire+0xc94/0x1cf0
[ 9911.561670]        lock_acquire+0x177/0x3e0
[ 9911.565857]        down_write_nested+0x9c/0x230
[ 9911.570398]        xfs_create+0x31f/0x8c0 [xfs]
[ 9911.575236]        xfs_generic_create+0x50e/0x680 [xfs]
[ 9911.580763]        lookup_open.isra.0+0xec7/0x1700
[ 9911.585566]        open_last_lookups+0x699/0x1380
[ 9911.590279]        path_openat+0x169/0x640
[ 9911.594389]        do_filp_open+0x1d4/0x420
[ 9911.598582]        do_sys_openat2+0x122/0x160
[ 9911.602948]        __x64_sys_openat+0x11f/0x1e0
[ 9911.607482]        do_syscall_64+0x8c/0x180
[ 9911.611678]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9911.617258]
               -> #4 (sb_internal){.+.+}-{0:0}:
[ 9911.623023]        __lock_acquire+0xc94/0x1cf0
[ 9911.627476]        lock_acquire+0x177/0x3e0
[ 9911.631671]        xfs_trans_alloc+0x37e/0x6b0 [xfs]
[ 9911.636938]        xfs_vn_update_time+0x121/0x310 [xfs]
[ 9911.642470]        touch_atime+0x2d5/0x470
[ 9911.646578]        xfs_file_mmap+0x21f/0x4e0 [xfs]
[ 9911.651674]        __mmap_new_vma+0x394/0x1050
[ 9911.656127]        __mmap_region+0x768/0x1040
[ 9911.660494]        do_mmap+0x9a6/0xff0
[ 9911.664248]        vm_mmap_pgoff+0x16d/0x2e0
[ 9911.668527]        ksys_mmap_pgoff+0x2e8/0x450
[ 9911.672974]        do_syscall_64+0x8c/0x180
[ 9911.677169]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9911.682751]
               -> #3 (&mm->mmap_lock){++++}-{4:4}:
[ 9911.688775]        __lock_acquire+0xc94/0x1cf0
[ 9911.693227]        lock_acquire+0x177/0x3e0
[ 9911.697412]        __might_fault+0xef/0x170
[ 9911.701598]        _copy_to_user+0x1e/0x80
[ 9911.705708]        relay_file_read+0x14c/0x880
[ 9911.710162]        full_proxy_read+0xdf/0x1b0
[ 9911.714529]        vfs_read+0x169/0xc30
[ 9911.718369]        ksys_read+0xf4/0x1d0
[ 9911.722208]        do_syscall_64+0x8c/0x180
[ 9911.726403]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9911.731976]
               -> #2 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
[ 9911.739046]        __lock_acquire+0xc94/0x1cf0
[ 9911.743494]        lock_acquire+0x177/0x3e0
[ 9911.747686]        down_write+0x98/0x220
[ 9911.751614]        start_creating.part.0+0x83/0x2f0
[ 9911.756502]        debugfs_create_dir+0x42/0x560
[ 9911.761128]        nvmf_get_address+0x13f/0x490 [nvme_fabrics]
[ 9911.766971]        scsi_add_lun+0x1662/0x1ed0
[ 9911.771339]        scsi_probe_and_add_lun+0x2ab/0xb50
[ 9911.776401]        __scsi_scan_target+0x18e/0x3d0
[ 9911.781115]        scsi_scan_channel+0xf6/0x180
[ 9911.785655]        scsi_scan_host_selected+0x1ff/0x2e0
[ 9911.790794]        do_scan_async+0x3f/0x490
[ 9911.794981]        async_run_entry_fn+0x96/0x4f0
[ 9911.799608]        process_one_work+0xe64/0x16a0
[ 9911.804236]        worker_thread+0x588/0xce0
[ 9911.808517]        kthread+0x2f6/0x3e0
[ 9911.812279]        ret_from_fork+0x30/0x70
[ 9911.816387]        ret_from_fork_asm+0x1a/0x30
[ 9911.820841]
               -> #1 (&q->limits_lock){+.+.}-{4:4}:
[ 9911.826952]        __lock_acquire+0xc94/0x1cf0
[ 9911.831405]        lock_acquire+0x177/0x3e0
[ 9911.835591]        __mutex_lock+0x17c/0x1570
[ 9911.839875]        nvme_update_ns_info_block+0x45f/0x1fc0 [nvme_core]
[ 9911.846356]        nvme_update_ns_info+0x1d9/0xbb0 [nvme_core]
[ 9911.852214]        nvme_alloc_ns+0x4b2/0x1690 [nvme_core]
[ 9911.857640]        nvme_scan_ns+0x362/0x4c0 [nvme_core]
[ 9911.862891]        async_run_entry_fn+0x96/0x4f0
[ 9911.867519]        process_one_work+0xe64/0x16a0
[ 9911.872146]        worker_thread+0x588/0xce0
[ 9911.876419]        kthread+0x2f6/0x3e0
[ 9911.880172]        ret_from_fork+0x30/0x70
[ 9911.884281]        ret_from_fork_asm+0x1a/0x30
[ 9911.888733]
               -> #0 (&q->q_usage_counter(io)#31){++++}-{0:0}:
[ 9911.895797]        check_prev_add+0x1b7/0x2360
[ 9911.900252]        validate_chain+0xa42/0xe00
[ 9911.904619]        __lock_acquire+0xc94/0x1cf0
[ 9911.909065]        lock_acquire+0x177/0x3e0
[ 9911.913250]        bio_queue_enter+0x228/0x360
[ 9911.917705]        blk_mq_submit_bio+0x43d/0x18d0
[ 9911.922420]        __submit_bio+0x191/0x460
[ 9911.926615]        submit_bio_noacct_nocheck+0x4a5/0x650
[ 9911.931935]        xfs_buf_ioapply_map+0x412/0x5d0 [xfs]
[ 9911.937553]        _xfs_buf_ioapply+0x34c/0x650 [xfs]
[ 9911.942907]        __xfs_buf_submit+0x1c4/0x540 [xfs]
[ 9911.948255]        xfs_buf_read_map+0x2ec/0x8c0 [xfs]
[ 9911.953602]        xfs_trans_read_buf_map+0x440/0x890 [xfs]
[ 9911.959478]        xfs_btree_read_buf_block+0x219/0x5a0 [xfs]
[ 9911.965517]        xfs_btree_lookup_get_block.part.0+0x133/0x790 [xfs]
[ 9911.972331]        xfs_btree_lookup+0x47f/0x12b0 [xfs]
[ 9911.977754]        xfs_dialloc_ag_finobt_near+0x1a6/0x7d0 [xfs]
[ 9911.983979]        xfs_dialloc_ag+0x579/0x7c0 [xfs]
[ 9911.989151]        xfs_dialloc+0x915/0xe00 [xfs]
[ 9911.994066]        xfs_create+0x332/0x8c0 [xfs]
[ 9911.998900]        xfs_generic_create+0x50e/0x680 [xfs]
[ 9912.004429]        lookup_open.isra.0+0xec7/0x1700
[ 9912.009222]        open_last_lookups+0x699/0x1380
[ 9912.013930]        path_openat+0x169/0x640
[ 9912.018036]        do_filp_open+0x1d4/0x420
[ 9912.022232]        do_sys_openat2+0x122/0x160
[ 9912.026599]        __x64_sys_openat+0x11f/0x1e0
[ 9912.031142]        do_syscall_64+0x8c/0x180
[ 9912.035336]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9912.040918]
               other info that might help us debug this:

[ 9912.048923] Chain exists of:
                 &q->q_usage_counter(io)#31 --> sb_internal -->
&xfs_dir_ilock_class/5

[ 9912.060945]  Possible unsafe locking scenario:

[ 9912.066863]        CPU0                    CPU1
[ 9912.071396]        ----                    ----
[ 9912.075930]   lock(&xfs_dir_ilock_class/5);
[ 9912.080131]                                lock(sb_internal);
[ 9912.085886]                                lock(&xfs_dir_ilock_class/5);
[ 9912.092594]   rlock(&q->q_usage_counter(io)#31);
[ 9912.097230]
                *** DEADLOCK ***

[ 9912.103151] 4 locks held by fio/50910:
[ 9912.106912]  #0: ffff88831fdb4430 (sb_writers#15){.+.+}-{0:0}, at:
open_last_lookups+0xd06/0x1380
[ 9912.115804]  #1: ffff88812b4d3b58
(&inode->i_sb->s_type->i_mutex_dir_key){++++}-{4:4}, at:
open_last_lookups+0x622/0x1380
[ 9912.126775]  #2: ffff88831fdb4650 (sb_internal){.+.+}-{0:0}, at:
xfs_trans_alloc_icreate+0xa4/0x1a0 [xfs]
[ 9912.136665]  #3: ffff88812b4d3920
(&xfs_dir_ilock_class/5){+.+.}-{4:4}, at: xfs_create+0x31f/0x8c0 [xfs]
[ 9912.146464]
               stack backtrace:
[ 9912.150826] CPU: 6 UID: 0 PID: 50910 Comm: fio Not tainted 6.13.0-rc1 #1
[ 9912.157531] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.15.2 04/02/2024
[ 9912.165184] Call Trace:
[ 9912.167638]  <TASK>
[ 9912.169752]  dump_stack_lvl+0x7e/0xc0
[ 9912.173428]  print_circular_bug+0x1b7/0x240
[ 9912.177627]  check_noncircular+0x2f6/0x3e0
[ 9912.181734]  ? __pfx_check_noncircular+0x10/0x10
[ 9912.186358]  ? srso_return_thunk+0x5/0x5f
[ 9912.190377]  ? find_held_lock+0x33/0x120
[ 9912.194313]  ? srso_return_thunk+0x5/0x5f
[ 9912.198339]  ? __lock_acquired+0x228/0x800
[ 9912.202443]  ? __pfx___lock_release+0x10/0x10
[ 9912.206809]  ? srso_return_thunk+0x5/0x5f
[ 9912.210840]  check_prev_add+0x1b7/0x2360
[ 9912.214783]  validate_chain+0xa42/0xe00
[ 9912.218641]  ? __pfx_validate_chain+0x10/0x10
[ 9912.223008]  ? srso_return_thunk+0x5/0x5f
[ 9912.227026]  ? mark_lock.part.0+0x77/0x880
[ 9912.231136]  __lock_acquire+0xc94/0x1cf0
[ 9912.235078]  ? icmp6_match+0x5f/0x410
[ 9912.238752]  ? rcu_is_watching+0x11/0xb0
[ 9912.242689]  ? srso_return_thunk+0x5/0x5f
[ 9912.246713]  lock_acquire+0x177/0x3e0
[ 9912.250385]  ? blk_mq_submit_bio+0x43d/0x18d0
[ 9912.254758]  ? __pfx_lock_acquire+0x10/0x10
[ 9912.258947]  ? __pfx___lock_release+0x10/0x10
[ 9912.263319]  ? validate_chain+0x148/0xe00
[ 9912.267339]  ? srso_return_thunk+0x5/0x5f
[ 9912.271358]  ? rcu_is_watching+0x11/0xb0
[ 9912.275300]  bio_queue_enter+0x228/0x360
[ 9912.279236]  ? blk_mq_submit_bio+0x43d/0x18d0
[ 9912.283604]  blk_mq_submit_bio+0x43d/0x18d0
[ 9912.287803]  ? srso_return_thunk+0x5/0x5f
[ 9912.291818]  ? __lock_acquire+0xc94/0x1cf0
[ 9912.295927]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[ 9912.300558]  ? icmp6_match+0x5f/0x410
[ 9912.304229]  ? rcu_is_watching+0x11/0xb0
[ 9912.308163]  ? srso_return_thunk+0x5/0x5f
[ 9912.312178]  ? srso_return_thunk+0x5/0x5f
[ 9912.316198]  ? find_held_lock+0x33/0x120
[ 9912.320132]  ? local_clock_noinstr+0x9/0xc0
[ 9912.324333]  __submit_bio+0x191/0x460
[ 9912.328001]  ? blkg_tryget_closest+0x546/0xbb0
[ 9912.332457]  ? __pfx___submit_bio+0x10/0x10
[ 9912.336655]  ? srso_return_thunk+0x5/0x5f
[ 9912.340671]  ? mark_held_locks+0xa5/0xf0
[ 9912.344605]  ? srso_return_thunk+0x5/0x5f
[ 9912.348620]  ? ktime_get+0x166/0x1e0
[ 9912.352206]  ? srso_return_thunk+0x5/0x5f
[ 9912.356233]  ? submit_bio_noacct_nocheck+0x4a5/0x650
[ 9912.361201]  ? srso_return_thunk+0x5/0x5f
[ 9912.365223]  submit_bio_noacct_nocheck+0x4a5/0x650
[ 9912.370028]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[ 9912.375349]  ? srso_return_thunk+0x5/0x5f
[ 9912.379366]  ? submit_bio_noacct+0xa16/0x1990
[ 9912.383741]  xfs_buf_ioapply_map+0x412/0x5d0 [xfs]
[ 9912.388857]  ? _raw_spin_unlock+0x29/0x50
[ 9912.392882]  _xfs_buf_ioapply+0x34c/0x650 [xfs]
[ 9912.397714]  ? __pfx_xfs_buf_find_insert.constprop.0+0x10/0x10 [xfs]
[ 9912.404377]  ? __pfx__xfs_buf_ioapply+0x10/0x10 [xfs]
[ 9912.409738]  ? __pfx_xfs_buf_get_map+0x10/0x10 [xfs]
[ 9912.415005]  ? srso_return_thunk+0x5/0x5f
[ 9912.419023]  ? rcu_is_watching+0x11/0xb0
[ 9912.422952]  ? srso_return_thunk+0x5/0x5f
[ 9912.426974]  __xfs_buf_submit+0x1c4/0x540 [xfs]
[ 9912.431813]  xfs_buf_read_map+0x2ec/0x8c0 [xfs]
[ 9912.436646]  ? xfs_btree_read_buf_block+0x219/0x5a0 [xfs]
[ 9912.442357]  ? __pfx_xfs_buf_read_map+0x10/0x10 [xfs]
[ 9912.447708]  ? srso_return_thunk+0x5/0x5f
[ 9912.451732]  xfs_trans_read_buf_map+0x440/0x890 [xfs]
[ 9912.457088]  ? xfs_btree_read_buf_block+0x219/0x5a0 [xfs]
[ 9912.462793]  ? __pfx_xfs_trans_read_buf_map+0x10/0x10 [xfs]
[ 9912.468675]  ? rcu_is_watching+0x11/0xb0
[ 9912.472610]  ? srso_return_thunk+0x5/0x5f
[ 9912.476636]  xfs_btree_read_buf_block+0x219/0x5a0 [xfs]
[ 9912.482174]  ? __pfx___lock_release+0x10/0x10
[ 9912.486537]  ? __pfx_xfs_btree_read_buf_block+0x10/0x10 [xfs]
[ 9912.492577]  ? validate_chain+0x148/0xe00
[ 9912.496599]  ? rcu_is_watching+0x11/0xb0
[ 9912.500539]  xfs_btree_lookup_get_block.part.0+0x133/0x790 [xfs]
[ 9912.506831]  ? srso_return_thunk+0x5/0x5f
[ 9912.510852]  ? mark_lock.part.0+0x77/0x880
[ 9912.514964]  ? __pfx_xfs_btree_lookup_get_block.part.0+0x10/0x10 [xfs]
[ 9912.521778]  ? srso_return_thunk+0x5/0x5f
[ 9912.525795]  ? __lock_acquire+0xc94/0x1cf0
[ 9912.529911]  xfs_btree_lookup+0x47f/0x12b0 [xfs]
[ 9912.534816]  ? rcu_is_watching+0x11/0xb0
[ 9912.538757]  ? srso_return_thunk+0x5/0x5f
[ 9912.542775]  ? srso_return_thunk+0x5/0x5f
[ 9912.546795]  ? __pfx_xfs_btree_lookup+0x10/0x10 [xfs]
[ 9912.552140]  ? __lock_acquired+0x228/0x800
[ 9912.556255]  ? mark_lock.part.0+0x77/0x880
[ 9912.560361]  ? srso_return_thunk+0x5/0x5f
[ 9912.564377]  ? mark_held_locks+0xa5/0xf0
[ 9912.568310]  ? srso_return_thunk+0x5/0x5f
[ 9912.572327]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[ 9912.577298]  ? srso_return_thunk+0x5/0x5f
[ 9912.581318]  xfs_dialloc_ag_finobt_near+0x1a6/0x7d0 [xfs]
[ 9912.587016]  ? rcu_is_watching+0x11/0xb0
[ 9912.590951]  ? __pfx_xfs_dialloc_ag_finobt_near+0x10/0x10 [xfs]
[ 9912.597165]  ? srso_return_thunk+0x5/0x5f
[ 9912.601183]  ? rcu_is_watching+0x11/0xb0
[ 9912.605109]  ? srso_return_thunk+0x5/0x5f
[ 9912.609132]  ? trace_xfs_group_hold+0x17e/0x200 [xfs]
[ 9912.614482]  ? srso_return_thunk+0x5/0x5f
[ 9912.618500]  ? xfs_group_hold+0x6b/0x100 [xfs]
[ 9912.623225]  ? srso_return_thunk+0x5/0x5f
[ 9912.627249]  xfs_dialloc_ag+0x579/0x7c0 [xfs]
[ 9912.631911]  ? srso_return_thunk+0x5/0x5f
[ 9912.635928]  ? rcu_is_watching+0x11/0xb0
[ 9912.639866]  ? __pfx_xfs_dialloc_ag+0x10/0x10 [xfs]
[ 9912.645063]  ? srso_return_thunk+0x5/0x5f
[ 9912.649084]  ? xfs_ialloc_read_agi+0x11c/0x4a0 [xfs]
[ 9912.654349]  ? __pfx_xfs_ialloc_read_agi+0x10/0x10 [xfs]
[ 9912.659961]  ? xfs_group_grab+0xde/0x1a0 [xfs]
[ 9912.664692]  ? srso_return_thunk+0x5/0x5f
[ 9912.668718]  xfs_dialloc+0x915/0xe00 [xfs]
[ 9912.673123]  ? xfs_create+0x31f/0x8c0 [xfs]
[ 9912.677618]  ? __pfx_xfs_dialloc+0x10/0x10 [xfs]
[ 9912.682542]  ? srso_return_thunk+0x5/0x5f
[ 9912.686558]  ? __pfx_down_write_nested+0x10/0x10
[ 9912.691185]  ? srso_return_thunk+0x5/0x5f
[ 9912.695206]  ? trace_xfs_ilock+0x191/0x220 [xfs]
[ 9912.700136]  xfs_create+0x332/0x8c0 [xfs]
[ 9912.704448]  ? __pfx_xfs_create+0x10/0x10 [xfs]
[ 9912.709273]  ? get_cached_acl+0x26a/0x390
[ 9912.713298]  ? get_cached_acl+0x274/0x390
[ 9912.717318]  ? __pfx_get_cached_acl+0x10/0x10
[ 9912.721691]  ? srso_return_thunk+0x5/0x5f
[ 9912.725712]  ? posix_acl_create+0x2ab/0x450
[ 9912.729910]  xfs_generic_create+0x50e/0x680 [xfs]
[ 9912.734919]  ? __pfx_xfs_generic_create+0x10/0x10 [xfs]
[ 9912.740446]  ? may_create+0x29d/0x320
[ 9912.744123]  ? __pfx_may_create+0x10/0x10
[ 9912.748143]  ? __pfx_selinux_inode_permission+0x10/0x10
[ 9912.753380]  ? from_kgid+0x84/0xc0
[ 9912.756799]  lookup_open.isra.0+0xec7/0x1700
[ 9912.761089]  ? __pfx_lookup_open.isra.0+0x10/0x10
[ 9912.765810]  ? rcu_is_watching+0x11/0xb0
[ 9912.769758]  ? __pfx_down_write+0x10/0x10
[ 9912.773775]  ? srso_return_thunk+0x5/0x5f
[ 9912.777786]  ? mnt_get_write_access+0x1a7/0x290
[ 9912.782338]  open_last_lookups+0x699/0x1380
[ 9912.786541]  path_openat+0x169/0x640
[ 9912.790135]  ? __pfx_path_openat+0x10/0x10
[ 9912.794238]  ? srso_return_thunk+0x5/0x5f
[ 9912.798257]  ? __lock_acquire+0xc94/0x1cf0
[ 9912.802376]  do_filp_open+0x1d4/0x420
[ 9912.806053]  ? __pfx_do_filp_open+0x10/0x10
[ 9912.810243]  ? find_held_lock+0x33/0x120
[ 9912.814180]  ? srso_return_thunk+0x5/0x5f
[ 9912.818215]  ? srso_return_thunk+0x5/0x5f
[ 9912.822228]  ? rcu_is_watching+0x11/0xb0
[ 9912.826161]  ? do_raw_spin_unlock+0x55/0x1f0
[ 9912.830438]  ? srso_return_thunk+0x5/0x5f
[ 9912.834457]  ? _raw_spin_unlock+0x29/0x50
[ 9912.838480]  ? srso_return_thunk+0x5/0x5f
[ 9912.842499]  ? alloc_fd+0x25f/0x480
[ 9912.846000]  do_sys_openat2+0x122/0x160
[ 9912.849849]  ? srso_return_thunk+0x5/0x5f
[ 9912.853873]  ? __pfx_do_sys_openat2+0x10/0x10
[ 9912.858243]  ? __pfx___lock_acquired+0x10/0x10
[ 9912.862701]  __x64_sys_openat+0x11f/0x1e0
[ 9912.866724]  ? __pfx___x64_sys_openat+0x10/0x10
[ 9912.871273]  ? srso_return_thunk+0x5/0x5f
[ 9912.875295]  ? syscall_trace_enter+0x140/0x260
[ 9912.879752]  do_syscall_64+0x8c/0x180
[ 9912.883422]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
[ 9912.888832]  ? srso_return_thunk+0x5/0x5f
[ 9912.892854]  ? srso_return_thunk+0x5/0x5f
[ 9912.896874]  ? srso_return_thunk+0x5/0x5f
[ 9912.900900]  ? kasan_quarantine_put+0x109/0x220
[ 9912.905444]  ? srso_return_thunk+0x5/0x5f
[ 9912.909458]  ? lockdep_hardirqs_on+0x78/0x100
[ 9912.913825]  ? srso_return_thunk+0x5/0x5f
[ 9912.917848]  ? srso_return_thunk+0x5/0x5f
[ 9912.921868]  ? kmem_cache_free+0x1be/0x5c0
[ 9912.925976]  ? do_unlinkat+0x107/0x5f0
[ 9912.929741]  ? srso_return_thunk+0x5/0x5f
[ 9912.933759]  ? do_unlinkat+0x107/0x5f0
[ 9912.937519]  ? srso_return_thunk+0x5/0x5f
[ 9912.941540]  ? __pfx_do_unlinkat+0x10/0x10
[ 9912.945648]  ? srso_return_thunk+0x5/0x5f
[ 9912.949679]  ? srso_return_thunk+0x5/0x5f
[ 9912.953697]  ? rcu_is_watching+0x11/0xb0
[ 9912.957629]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[ 9912.962772]  ? do_syscall_64+0x98/0x180
[ 9912.966619]  ? srso_return_thunk+0x5/0x5f
[ 9912.970632]  ? lockdep_hardirqs_on+0x78/0x100
[ 9912.974992]  ? srso_return_thunk+0x5/0x5f
[ 9912.979013]  ? do_syscall_64+0x98/0x180
[ 9912.982864]  ? __pfx___lock_release+0x10/0x10
[ 9912.987229]  ? srso_return_thunk+0x5/0x5f
[ 9912.991240]  ? __up_read+0x1fd/0x750
[ 9912.994823]  ? srso_return_thunk+0x5/0x5f
[ 9912.998845]  ? srso_return_thunk+0x5/0x5f
[ 9913.002863]  ? rcu_is_watching+0x11/0xb0
[ 9913.006803]  ? do_user_addr_fault+0x4a2/0xb60
[ 9913.011176]  ? srso_return_thunk+0x5/0x5f
[ 9913.015200]  ? srso_return_thunk+0x5/0x5f
[ 9913.019216]  ? rcu_is_watching+0x11/0xb0
[ 9913.023145]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[ 9913.028296]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9913.033351] RIP: 0033:0x7f1adc6fd884
[ 9913.036940] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 f6 88 f8 ff
44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 48 89 f8 ff
8b 44
[ 9913.055693] RSP: 002b:00007ffe542c3bd0 EFLAGS: 00000293 ORIG_RAX:
0000000000000101
[ 9913.063270] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1adc6fd884
[ 9913.070410] RDX: 0000000000000041 RSI: 00007f1adb6132b0 RDI: 00000000ffffff9c
[ 9913.077551] RBP: 00007f1adb6132b0 R08: 0000000000000000 R09: 0000000000000000
[ 9913.084682] R10: 00000000000001a4 R11: 0000000000000293 R12: 0000000000000041
[ 9913.091817] R13: 0000000000000000 R14: 00007f1adb613110 R15: 0000000039900000
[ 9913.098972]  </TASK>
[10136.543070] XFS (nvme3n1): Unmounting Filesystem
d2ab7427-0950-4ac1-94fb-8f885179f74c
[10136.735552] nvme nvme3: Removing ctrl: NQN "blktests-subsystem-1"



-- 
Best Regards,
  Yi Zhang

