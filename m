Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27B800
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654672; cv=none; b=AibnDS0TnxBkX5OtpNu2SIwNNAZBVkrtwAE6VUBtrc2sIha5swRCpjiCiDD4takx3S10GnTbnNspNvB4SIn8WOJa0pvbC9BcD5hntFzD+lHMQdvKC3NfSsr4oKHQER0zbOyK7vWuyTH4u8txfaN7AF7qrUDWWxsf5qg8xTFOCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654672; c=relaxed/simple;
	bh=oBDeDg9DvASP/Ehu2M6/Yjti3M0gZpCDCrjWwDNbE9M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Bg1AXkJrTcyYIOijBmYTj9RuPZBkTedM36akJ/Qjtpl9DOUC6OZrdmKo95uWkBOeNe16bgTTjhFCo8VP/pcy8sr5WYtNbMkjrulJT6moWwvAAHKWeaK0wyIiKpBYRsO6ltIXWs3aqrw7XiGgOlae59wKLg2RyCnhOEI/rw9Avdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WydNlhlU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WydNlhlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734654668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=L+LCXh4mGI9j9aG9yPHNHPVkmlFeSLIcOEApLbO+Mcw=;
	b=WydNlhlUlAtuqzDwC1qFQaieKFm80lW5STPmW9CHJ9x5Aa0vZgYAbsWg7t/vqoQzKO0TUt
	aYmY/0uFSy/wEv//X0Q2sdeE1zZ1A7rAS7kduAttanDgTWBsiPlpESLYdifWn+Gke89iUT
	TcQpc9VR6zhMSK36Q2hdwaBdDPoHDY8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-kb7oRaz4NsORk3wRI4oYHA-1; Thu, 19 Dec 2024 19:31:07 -0500
X-MC-Unique: kb7oRaz4NsORk3wRI4oYHA-1
X-Mimecast-MFC-AGG-ID: kb7oRaz4NsORk3wRI4oYHA
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3003190ec72so7532191fa.2
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 16:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734654665; x=1735259465;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+LCXh4mGI9j9aG9yPHNHPVkmlFeSLIcOEApLbO+Mcw=;
        b=rEbSwfstUcovPzadsm+54HWyvgKS2kVqZxKN4QPZgC+VmaajfMC8HsbNFYlTt3bViK
         z23ApKxRu6qLxapgv3N4bd15BiCyGXUjSOlLBaZUrQGHAnmOCw66U/sxXNAY/va5juP/
         yBFVGBf68iOiGj/B0M3hTZaL8p5Q5C9PbbJzRgw11jcOYqfNABYY6t/pWuOjVGbMNTQd
         0RjKogxZxhTCRTBPA9FlAHlz/zH5lYDQER2H9kx13t/DEFMbCtzHMdvv1JNpaIF/6lJJ
         OVu7L77uua854aZ+vGJbnKENOqytjMpkFM+RrfMEc91ezvxSoEaVXehfTJUh+Bjcgbwb
         t/dw==
X-Gm-Message-State: AOJu0YylQyrrBRFaqQB90Wt6nMH1KizhjbBRIOkilEHZVPqBeO/zqfX6
	VQ6D8MrO/apK09qDOcWPQNc8WFwGRMIa4nTN5xoXB5dsylT4utR0vxRoGGXQodunHysYEEUKB+N
	SS2r2Fto6YKit92AHoPJURNN4Oy0QvDR0q4b9y+5f9T5uZibIsTZVrNpuiN+thP/J8JABjSxvUA
	N3HyeWg53f4gvLhpEnCqTFT3bnD1h/5HKL+30qdqElOE3q19Lr
X-Gm-Gg: ASbGncup3drn+p6WQAz6G55lRZoxNNZhDa14jy0lHTh2RFVfBwLcM2K56J438viEdQl
	67KJQ0bVGjazbx19NUO6YmpUKTjiVsqR6uzdrpAg=
X-Received: by 2002:a2e:b887:0:b0:302:29a5:6e01 with SMTP id 38308e7fff4ca-3046851976cmr2917151fa.2.1734654664821;
        Thu, 19 Dec 2024 16:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA+uHC6pKxwm674yF4Ht+AQGcBHI/LjCYIIoJwdKTvz2WsLcYs6Q+sVCw8Th9KYWKOug5g+YOa7z09ocCHA88=
X-Received: by 2002:a2e:b887:0:b0:302:29a5:6e01 with SMTP id
 38308e7fff4ca-3046851976cmr2917031fa.2.1734654664100; Thu, 19 Dec 2024
 16:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 20 Dec 2024 08:30:52 +0800
Message-ID: <CAHj4cs_RU-tzrtn+F8kXBP+4zCH_mA1pqzwAL8oWNGZiLxXHLQ@mail.gmail.com>
Subject: [bug report] WARNING: possible circular locking dependency detected
 at blk_unregister_queue+0x9c/0x290 and sd_remove+0x85/0x130 [sd_mod]
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

I reproduced this issue on 6.13.0-rc3 with blktests block/032, and
latest linux-block/for-next also has this issue,
please help check it and let me know if you need any info/test for it, thanks.

[ 8522.205802] run blktests block/032 at 2024-12-19 17:50:39
[ 8522.686638] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[ 8522.714725] scsi 10:0:0:0: Power-on or device reset occurred
[ 8525.172661] XFS (sde): Block device removal (0x20) detected at
fs_bdev_mark_dead+0x7e/0xb0 (fs/xfs/xfs_super.c:1184).  Shutting down
filesystem.
[ 8525.187369] XFS (sde): Please unmount the filesystem and rectify
the problem(s)
[ 8525.208802]
[ 8525.210316] ======================================================
[ 8525.216502] WARNING: possible circular locking dependency detected
[ 8525.222689] 6.13.0-rc3+ #1 Not tainted
[ 8525.226443] ------------------------------------------------------
[ 8525.232630] check/29929 is trying to acquire lock:
[ 8525.237431] ffff8882aa0d6f38 (&q->sysfs_lock){+.+.}-{4:4}, at:
blk_unregister_queue+0x9c/0x290
[ 8525.246070]
[ 8525.246070] but task is already holding lock:
[ 8525.251903] ffff8882aa0d69f0
(&q->q_usage_counter(queue)#11){++++}-{0:0}, at: sd_remove+0x85/0x130
[sd_mod]
[ 8525.261681]
[ 8525.261681] which lock already depends on the new lock.
[ 8525.261681]
[ 8525.269862]
[ 8525.269862] the existing dependency chain (in reverse order) is:
[ 8525.277341]
[ 8525.277341] -> #2 (&q->q_usage_counter(queue)#11){++++}-{0:0}:
[ 8525.284672]        __lock_acquire+0xc94/0x1cf0
[ 8525.289126]        lock_acquire+0x177/0x3e0
[ 8525.293322]        blk_queue_enter+0x391/0x4b0
[ 8525.297774]        blk_mq_alloc_request+0x499/0x8c0
[ 8525.302663]        scsi_execute_cmd+0x10d/0x6d0
[ 8525.307204]        read_capacity_16+0x1ad/0xb90 [sd_mod]
[ 8525.312525]        sd_read_capacity+0x4c3/0x9d0 [sd_mod]
[ 8525.317847]        sd_revalidate_disk.isra.0+0xa98/0x2240 [sd_mod]
[ 8525.324035]        sd_probe+0x6e3/0xdb0 [sd_mod]
[ 8525.328661]        really_probe+0x1e3/0x920
[ 8525.332856]        __driver_probe_device+0x18a/0x3d0
[ 8525.337833]        driver_probe_device+0x49/0x120
[ 8525.342545]        __device_attach_driver+0x15e/0x270
[ 8525.347607]        bus_for_each_drv+0x106/0x190
[ 8525.352149]        __device_attach_async_helper+0x19a/0x240
[ 8525.357731]        async_run_entry_fn+0x96/0x4f0
[ 8525.362356]        process_one_work+0xe64/0x16a0
[ 8525.366985]        worker_thread+0x588/0xce0
[ 8525.371266]        kthread+0x2f6/0x3e0
[ 8525.375027]        ret_from_fork+0x30/0x70
[ 8525.379135]        ret_from_fork_asm+0x1a/0x30
[ 8525.383591]
[ 8525.383591] -> #1 (&q->limits_lock){+.+.}-{4:4}:
[ 8525.389699]        __lock_acquire+0xc94/0x1cf0
[ 8525.394145]        lock_acquire+0x177/0x3e0
[ 8525.398341]        __mutex_lock+0x17c/0x1570
[ 8525.402620]        __blk_mq_update_nr_hw_queues+0x98f/0xe80
[ 8525.408202]        blk_mq_update_nr_hw_queues+0x29/0x40
[ 8525.413430]        sdebug_change_qdepth+0x112/0x170 [scsi_debug]
[ 8525.419470]        scsi_debug_bus_reset+0x156/0x1a0 [scsi_debug]
[ 8525.425494]        configfs_write_iter+0x2b4/0x480
[ 8525.430295]        vfs_write+0x9b8/0xf60
[ 8525.434228]        ksys_write+0xf4/0x1d0
[ 8525.438164]        do_syscall_64+0x8c/0x180
[ 8525.442357]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 8525.447939]
[ 8525.447939] -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
[ 8525.453960]        check_prev_add+0x1b7/0x2360
[ 8525.458406]        validate_chain+0xa42/0xe00
[ 8525.462767]        __lock_acquire+0xc94/0x1cf0
[ 8525.467221]        lock_acquire+0x177/0x3e0
[ 8525.471416]        __mutex_lock+0x17c/0x1570
[ 8525.475697]        blk_unregister_queue+0x9c/0x290
[ 8525.480497]        del_gendisk+0x25a/0xa10
[ 8525.484606]        sd_remove+0x85/0x130 [sd_mod]
[ 8525.489233]        device_release_driver_internal+0x36d/0x530
[ 8525.494989]        bus_remove_device+0x1ed/0x3f0
[ 8525.499617]        device_del+0x33b/0x8c0
[ 8525.503637]        __scsi_remove_device+0x26b/0x330
[ 8525.508525]        sdev_store_delete+0x83/0x120
[ 8525.513057]        kernfs_fop_write_iter+0x355/0x520
[ 8525.518032]        vfs_write+0x9b8/0xf60
[ 8525.521967]        ksys_write+0xf4/0x1d0
[ 8525.525903]        do_syscall_64+0x8c/0x180
[ 8525.530096]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 8525.535676]
[ 8525.535676] other info that might help us debug this:
[ 8525.535676]
[ 8525.543675] Chain exists of:
[ 8525.543675]   &q->sysfs_lock --> &q->limits_lock -->
&q->q_usage_counter(queue)#11
[ 8525.543675]
[ 8525.555601]  Possible unsafe locking scenario:
[ 8525.555601]
[ 8525.561520]        CPU0                    CPU1
[ 8525.566052]        ----                    ----
[ 8525.570586]   lock(&q->q_usage_counter(queue)#11);
[ 8525.575395]                                lock(&q->limits_lock);
[ 8525.581496]
lock(&q->q_usage_counter(queue)#11);
[ 8525.588820]   lock(&q->sysfs_lock);
[ 8525.592322]
[ 8525.592322]  *** DEADLOCK ***
[ 8525.592322]
[ 8525.598241] 5 locks held by check/29929:
[ 8525.602173]  #0: ffff88833cdc2440 (sb_writers#4){.+.+}-{0:0}, at:
ksys_write+0xf4/0x1d0
[ 8525.610201]  #1: ffff888140bb9c90 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0x214/0x520
[ 8525.619264]  #2: ffff8882e7e100f0 (&shost->scan_mutex){+.+.}-{4:4},
at: sdev_store_delete+0x7b/0x120
[ 8525.628417]  #3: ffff8881aa1d63a0 (&dev->mutex){....}-{4:4}, at:
device_release_driver_internal+0x8d/0x530
[ 8525.638087]  #4: ffff8882aa0d69f0
(&q->q_usage_counter(queue)#11){++++}-{0:0}, at: sd_remove+0x85/0x130
[sd_mod]
[ 8525.648290]
[ 8525.648290] stack backtrace:
[ 8525.652657] CPU: 7 UID: 0 PID: 29929 Comm: check Not tainted 6.13.0-rc3+ #1
[ 8525.659625] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.15.2 04/02/2024
[ 8525.667288] Call Trace:
[ 8525.669747]  <TASK>
[ 8525.671854]  dump_stack_lvl+0x7e/0xc0
[ 8525.675529]  print_circular_bug+0x1b7/0x240
[ 8525.679729]  check_noncircular+0x2f6/0x3e0
[ 8525.683830]  ? __pfx___lock_release+0x10/0x10
[ 8525.688199]  ? sd_remove+0x84/0x130 [sd_mod]
[ 8525.692484]  ? __pfx_check_noncircular+0x10/0x10
[ 8525.697109]  ? srso_return_thunk+0x5/0x5f
[ 8525.701128]  ? rcu_is_watching+0x11/0xb0
[ 8525.705068]  ? srso_return_thunk+0x5/0x5f
[ 8525.709086]  ? srso_return_thunk+0x5/0x5f
[ 8525.713106]  ? is_bpf_text_address+0x6d/0x100
[ 8525.717473]  ? srso_return_thunk+0x5/0x5f
[ 8525.721494]  ? alloc_chain_hlocks+0x16/0x530
[ 8525.725781]  check_prev_add+0x1b7/0x2360
[ 8525.729718]  validate_chain+0xa42/0xe00
[ 8525.733576]  ? __pfx_validate_chain+0x10/0x10
[ 8525.737944]  ? srso_return_thunk+0x5/0x5f
[ 8525.741963]  ? mark_lock.part.0+0x77/0x880
[ 8525.746072]  __lock_acquire+0xc94/0x1cf0
[ 8525.750015]  ? rcu_is_watching+0x11/0xb0
[ 8525.753942]  ? srso_return_thunk+0x5/0x5f
[ 8525.757967]  lock_acquire+0x177/0x3e0
[ 8525.761638]  ? blk_unregister_queue+0x9c/0x290
[ 8525.766097]  ? __pfx_lock_acquire+0x10/0x10
[ 8525.770287]  ? __debug_check_no_obj_freed+0x253/0x520
[ 8525.775351]  ? srso_return_thunk+0x5/0x5f
[ 8525.779373]  ? srso_return_thunk+0x5/0x5f
[ 8525.783396]  __mutex_lock+0x17c/0x1570
[ 8525.787150]  ? blk_unregister_queue+0x9c/0x290
[ 8525.791597]  ? kasan_quarantine_put+0x109/0x220
[ 8525.796139]  ? blk_unregister_queue+0x9c/0x290
[ 8525.800597]  ? srso_return_thunk+0x5/0x5f
[ 8525.804613]  ? kfree+0x14f/0x4d0
[ 8525.807857]  ? __pfx___mutex_lock+0x10/0x10
[ 8525.812057]  ? srso_return_thunk+0x5/0x5f
[ 8525.816071]  ? kobject_put+0x51/0xd0
[ 8525.819660]  ? srso_return_thunk+0x5/0x5f
[ 8525.823679]  ? bdi_unregister+0x423/0x590
[ 8525.827703]  ? __pfx_bdi_unregister+0x10/0x10
[ 8525.832070]  ? srso_return_thunk+0x5/0x5f
[ 8525.836091]  ? srso_return_thunk+0x5/0x5f
[ 8525.840118]  ? blk_unregister_queue+0x9c/0x290
[ 8525.844565]  blk_unregister_queue+0x9c/0x290
[ 8525.848842]  del_gendisk+0x25a/0xa10
[ 8525.852434]  ? __pfx_del_gendisk+0x10/0x10
[ 8525.856533]  ? srso_return_thunk+0x5/0x5f
[ 8525.860548]  ? srso_return_thunk+0x5/0x5f
[ 8525.864568]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[ 8525.869543]  ? srso_return_thunk+0x5/0x5f
[ 8525.873564]  ? __pm_runtime_resume+0x7d/0x110
[ 8525.877938]  sd_remove+0x85/0x130 [sd_mod]
[ 8525.882052]  device_release_driver_internal+0x36d/0x530
[ 8525.887285]  ? klist_put+0xf3/0x170
[ 8525.890789]  bus_remove_device+0x1ed/0x3f0
[ 8525.894892]  ? srso_return_thunk+0x5/0x5f
[ 8525.898917]  device_del+0x33b/0x8c0
[ 8525.902417]  ? srso_return_thunk+0x5/0x5f
[ 8525.906437]  ? __pfx_device_del+0x10/0x10
[ 8525.910457]  ? kobject_cleanup+0x116/0x360
[ 8525.914574]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 8525.918940]  __scsi_remove_device+0x26b/0x330
[ 8525.923303]  sdev_store_delete+0x83/0x120
[ 8525.927327]  kernfs_fop_write_iter+0x355/0x520
[ 8525.931783]  vfs_write+0x9b8/0xf60
[ 8525.935194]  ? rcu_is_watching+0x11/0xb0
[ 8525.939126]  ? srso_return_thunk+0x5/0x5f
[ 8525.943148]  ? __pfx_vfs_write+0x10/0x10
[ 8525.947080]  ? find_held_lock+0x33/0x120
[ 8525.951020]  ? srso_return_thunk+0x5/0x5f
[ 8525.955036]  ? __lock_release+0x486/0x960
[ 8525.959057]  ? srso_return_thunk+0x5/0x5f
[ 8525.963072]  ? srso_return_thunk+0x5/0x5f
[ 8525.967098]  ksys_write+0xf4/0x1d0
[ 8525.970508]  ? __pfx_ksys_write+0x10/0x10
[ 8525.974528]  ? srso_return_thunk+0x5/0x5f
[ 8525.978561]  do_syscall_64+0x8c/0x180
[ 8525.982235]  ? srso_return_thunk+0x5/0x5f
[ 8525.986252]  ? rcu_is_watching+0x11/0xb0
[ 8525.990193]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[ 8525.995340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 8526.000396] RIP: 0033:0x7fb4f1cfdf37
[ 8526.003976] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
74 24
[ 8526.022731] RSP: 002b:00007ffef1a75378 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 8526.030303] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb4f1cfdf37
[ 8526.037438] RDX: 0000000000000002 RSI: 000055a404610530 RDI: 0000000000000001
[ 8526.044579] RBP: 000055a404610530 R08: 0000000000000000 R09: 00007fb4f1db0d40
[ 8526.051712] R10: 00007fb4f1db0c40 R11: 0000000000000246 R12: 0000000000000002
[ 8526.058850] R13: 00007fb4f1dfa780 R14: 0000000000000002 R15: 00007fb4f1df59e0
[ 8526.066001]  </TASK>
[ 8526.108474] sd 10:0:0:0: [sde] Synchronizing SCSI cache
[ 8528.221579] XFS (sde): Unmounting Filesystem
a9cf1eb5-042f-458f-87dc-e9b0dcd4fbbe




-- 
Best Regards,
  Yi Zhang

