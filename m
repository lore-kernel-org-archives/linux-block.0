Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3A1F0984
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020084; cv=none; b=V6iAxE1S4LvnpvVd08zzXYA4L1k7Mh19TKkxDnAKIW/XHoby9XYprzd1LF5fTYaRydyE3d4SFqhXKTVhxJjnoiAiSs8HI+OqqLRG7pqN5J5sqzZQKdU4pv4NIhljdOYKF4nqudcz4H6z34jHT3rhcWeMGt/hMEyhxnr0H5z1QH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020084; c=relaxed/simple;
	bh=24O3CcT0LfyKdrOdA4i8Hg/9Hetu6fVclDnFh2mo1q8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CRlVL4p0s+3MDu/GiSw9PdyLd74zbT4rTO6wjwVcSkc3Tb6+aSKfhMqzrMY9JNmcDkijOWPgjkWmyiGV8fOrjOBWVNPxVgfKSu7h97UrmhBmfwPoM4oLAGLTgVjvWSZFA2Uqxhil2zGD3uP9R3mPOwj7q97C08NLKUkDzEdBlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5bHAxuO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5bHAxuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746020080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=XtkX5ciXmCWGRTkxJ4lqAU3W2T400Yqz/DXSH8nzKOY=;
	b=O5bHAxuOtf2I9YdZT+0reT2QqZlSRsNIQMjGA8hUGwLzrcWw4Ent5+GXFTpKplsf0O7S2o
	Ztj1dBvpMqgIlcaNv+cvsZu790THVISwVDU3jutlyQ3AZR8olC9+uw/r41CuffNEfnRB8/
	0KLcuROwfZx78WjnPkTWoSVlamW0aDk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-5QyTUlk_OAexPOjGy8XSpg-1; Wed, 30 Apr 2025 09:34:39 -0400
X-MC-Unique: 5QyTUlk_OAexPOjGy8XSpg-1
X-Mimecast-MFC-AGG-ID: 5QyTUlk_OAexPOjGy8XSpg_1746020078
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30c4cbc324bso36891111fa.1
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746020076; x=1746624876;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtkX5ciXmCWGRTkxJ4lqAU3W2T400Yqz/DXSH8nzKOY=;
        b=B6+ZEZWsL2N/WT4QLdt+3GPOeVn5kvY9ewB6sPxDf1u/5TigwSh0dzLx/RhLgijhoL
         Vm8yqpxp3owT+S/E3lqsoXANlzExsytyT4N1zkm3HFZq1rdw8YATMsMnjDkdM1ZrpvHk
         +rKbRmTr7xuNeHS+cv1xY6Vk/7h3HRQcOVYSUczWQB42kn+BX0KnbxPxuMr3jDzD1eti
         plsWLyI1EW7RDDhHkXKH3HgCxysJY0/vMMgsUfGSYtPm5hEqERyiNC+omLXedzxHhcUE
         b+woTHxIBKJgESRUCVwOOGdpVxIUHaBTMa2nTF/ZnvxhpHnxpZxST7ReqV4PzdbGQODg
         e6SQ==
X-Gm-Message-State: AOJu0YwPwYN/mvoyx5KEMILWamdNw4BInddxC3OKUK1bVf8gOrJQ2/OZ
	jJC7NGjBRu021lb6+ghopnZ1MirEecwKNGfTTdf8Al1dt4SrDKlBMOEydSUA9wUiGyd0LuMem09
	ygRO8Jr/8mgEtXMK89KhPbtoL68Ta2aydF4oMvgXL0jqd3Ts4a7MZ16BX7pw4ulBAGhst/TKxTf
	Nu87i3rn4ed3uww205TAupE4HQdqVNNu+ngD/XGQ48UazDTLzmDuo=
X-Gm-Gg: ASbGncv96M2CEchzGjYoF3j3zoATioxKlGMuqZQz2JNLMWgfUhU5Ycq5dPsSyZvrETz
	8ctRzSJIGJ50fAyDuTIuCDUj9EBiviWBnvvfiY1E3iq1Eln8z1Rc2TH1jHe31rq2u5juC0A==
X-Received: by 2002:a05:651c:2221:b0:30b:c96a:750 with SMTP id 38308e7fff4ca-31e69a2cb73mr11748641fa.1.1746020076520;
        Wed, 30 Apr 2025 06:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN6q/i/Ws90z3KqD28hdBNeyH3uNC6c7HivnSdxiN2YEj/u9quOiBQpEZszxFl5pFSLGCSljZ2R+M0CdGVU/c=
X-Received: by 2002:a05:651c:2221:b0:30b:c96a:750 with SMTP id
 38308e7fff4ca-31e69a2cb73mr11748511fa.1.1746020075932; Wed, 30 Apr 2025
 06:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 30 Apr 2025 21:34:24 +0800
X-Gm-Features: ATxdqUEdsNKUvLGogY8Iu_Noys78aLtsNvW6HMSDyzPlJQEdp2t3kbnjLlR27bY
Message-ID: <CAHj4cs8ZO-vBCJOiDvZJv_1mF3WC14i+GY2gwpSycSqYFh6urA@mail.gmail.com>
Subject: [bug report] WARNING: possible circular locking dependency detected
 at elv_iosched_store+0x194/0x530 and blk_mq_freeze_queue_nomemsave+0xe/0x20
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi
I found this warning with blktests block/005 on upstream kernel
6.15.0-rc4, please help check it and let me know if you need any
info/test, thanks.

[  942.528228] run blktests block/005 at 2025-04-29 14:22:12
[  943.169303]
[  943.170811] ======================================================
[  943.176990] WARNING: possible circular locking dependency detected
[  943.183172] 6.15.0-rc4 #1 Not tainted
[  943.186845] ------------------------------------------------------
[  943.193022] check/13135 is trying to acquire lock:
[  943.197817] ffff888119e53018 (&q->elevator_lock){+.+.}-{4:4}, at:
elv_iosched_store+0x194/0x530
[  943.206536]
[  943.206536] but task is already holding lock:
[  943.212366] ffff888119e52a90
(&q->q_usage_counter(io)#10){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0xe/0x20
[  943.222645]
[  943.222645] which lock already depends on the new lock.
[  943.222645]
[  943.230817]
[  943.230817] the existing dependency chain (in reverse order) is:
[  943.238296]
[  943.238296] -> #2 (&q->q_usage_counter(io)#10){++++}-{0:0}:
[  943.245361]        __lock_acquire+0x573/0xc00
[  943.249729]        lock_acquire.part.0+0xb6/0x240
[  943.254441]        blk_alloc_queue+0x5c5/0x710
[  943.258890]        blk_mq_alloc_queue+0x14c/0x230
[  943.263604]        __blk_mq_alloc_disk+0x15/0xd0
[  943.268224]        nvme_alloc_ns+0x208/0x1690 [nvme_core]
[  943.273649]        nvme_scan_ns+0x360/0x4b0 [nvme_core]
[  943.278900]        async_run_entry_fn+0x96/0x4f0
[  943.283527]        process_one_work+0x8cd/0x1950
[  943.288155]        worker_thread+0x58d/0xcf0
[  943.292429]        kthread+0x3d8/0x7a0
[  943.296188]        ret_from_fork+0x30/0x70
[  943.300288]        ret_from_fork_asm+0x1a/0x30
[  943.304743]
[  943.304743] -> #1 (fs_reclaim){+.+.}-{0:0}:
[  943.310418]        __lock_acquire+0x573/0xc00
[  943.314779]        lock_acquire.part.0+0xb6/0x240
[  943.319492]        fs_reclaim_acquire+0x103/0x150
[  943.324207]        kmem_cache_alloc_noprof+0x4f/0x4c0
[  943.329259]        __kernfs_new_node+0xcb/0x7a0
[  943.333791]        kernfs_new_node+0xef/0x1e0
[  943.338153]        kernfs_create_dir_ns+0x27/0x150
[  943.342954]        sysfs_create_dir_ns+0x11c/0x260
[  943.347755]        kobject_add_internal+0x272/0x890
[  943.352643]        kobject_add+0x11f/0x1f0
[  943.356750]        elv_register_queue+0xb7/0x220
[  943.361368]        blk_register_queue+0x347/0x4e0
[  943.366074]        add_disk_fwnode+0x795/0x10c0
[  943.370609]        sd_probe+0x826/0xdb0 [sd_mod]
[  943.375247]        really_probe+0x1e3/0x920
[  943.379438]        __driver_probe_device+0x18a/0x3d0
[  943.384403]        driver_probe_device+0x49/0x120
[  943.389110]        __driver_attach_async_helper+0x102/0x260
[  943.394682]        async_run_entry_fn+0x96/0x4f0
[  943.399303]        process_one_work+0x8cd/0x1950
[  943.403931]        worker_thread+0x58d/0xcf0
[  943.408213]        kthread+0x3d8/0x7a0
[  943.411972]        ret_from_fork+0x30/0x70
[  943.416073]        ret_from_fork_asm+0x1a/0x30
[  943.420527]
[  943.420527] -> #0 (&q->elevator_lock){+.+.}-{4:4}:
[  943.426809]        check_prev_add+0xf1/0xce0
[  943.431092]        validate_chain+0x470/0x580
[  943.435457]        __lock_acquire+0x573/0xc00
[  943.439817]        lock_acquire.part.0+0xb6/0x240
[  943.444523]        __mutex_lock+0x17b/0x1690
[  943.448805]        elv_iosched_store+0x194/0x530
[  943.453423]        queue_attr_store+0x232/0x2f0
[  943.457955]        kernfs_fop_write_iter+0x357/0x530
[  943.462922]        vfs_write+0x9bc/0xf60
[  943.466858]        ksys_write+0xf3/0x1d0
[  943.470791]        do_syscall_64+0x8c/0x180
[  943.474985]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  943.480559]
[  943.480559] other info that might help us debug this:
[  943.480559]
[  943.488557] Chain exists of:
[  943.488557]   &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#10
[  943.488557]
[  943.500050]  Possible unsafe locking scenario:
[  943.500050]
[  943.505968]        CPU0                    CPU1
[  943.510500]        ----                    ----
[  943.515032]   lock(&q->q_usage_counter(io)#10);
[  943.519574]                                lock(fs_reclaim);
[  943.525241]                                lock(&q->q_usage_counter(io)#10);
[  943.532296]   lock(&q->elevator_lock);
[  943.536058]
[  943.536058]  *** DEADLOCK ***
[  943.536058]
[  943.541977] 5 locks held by check/13135:
[  943.545905]  #0: ffff88827c452440 (sb_writers#4){.+.+}-{0:0}, at:
ksys_write+0xf3/0x1d0
[  943.553928]  #1: ffff88825891f090 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0x216/0x530
[  943.562993]  #2: ffff888171c18e90 (kn->active#85){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x239/0x530
[  943.572146]  #3: ffff888119e52a90
(&q->q_usage_counter(io)#10){++++}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0xe/0x20
[  943.582857]  #4: ffff888119e52ad0
(&q->q_usage_counter(queue)#10){+.+.}-{0:0}, at:
blk_mq_freeze_queue_nomemsave+0xe/0x20
[  943.593829]
[  943.593829] stack backtrace:
[  943.598189] CPU: 7 UID: 0 PID: 13135 Comm: check Not tainted
6.15.0-rc4 #1 PREEMPT(voluntary)
[  943.598195] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/2024
[  943.598199] Call Trace:
[  943.598203]  <TASK>
[  943.598207]  dump_stack_lvl+0x7e/0xc0
[  943.598215]  print_circular_bug+0xdc/0xf0
[  943.598224]  check_noncircular+0x131/0x150
[  943.598229]  ? __lock_acquire+0x573/0xc00
[  943.598244]  check_prev_add+0xf1/0xce0
[  943.598249]  ? srso_return_thunk+0x5/0x5f
[  943.598254]  ? add_chain_cache+0x111/0x320
[  943.598263]  validate_chain+0x470/0x580
[  943.598269]  ? srso_return_thunk+0x5/0x5f
[  943.598279]  __lock_acquire+0x573/0xc00
[  943.598291]  lock_acquire.part.0+0xb6/0x240
[  943.598298]  ? elv_iosched_store+0x194/0x530
[  943.598306]  ? srso_return_thunk+0x5/0x5f
[  943.598310]  ? rcu_is_watching+0x11/0xb0
[  943.598317]  ? srso_return_thunk+0x5/0x5f
[  943.598321]  ? lock_acquire+0x10e/0x160
[  943.598330]  __mutex_lock+0x17b/0x1690
[  943.598336]  ? elv_iosched_store+0x194/0x530
[  943.598340]  ? srso_return_thunk+0x5/0x5f
[  943.598344]  ? local_clock_noinstr+0x9/0xc0
[  943.598352]  ? __lock_release+0x1a2/0x2c0
[  943.598356]  ? elv_iosched_store+0x194/0x530
[  943.598363]  ? srso_return_thunk+0x5/0x5f
[  943.598367]  ? mark_held_locks+0x50/0x80
[  943.598375]  ? __pfx___mutex_lock+0x10/0x10
[  943.598381]  ? srso_return_thunk+0x5/0x5f
[  943.598384]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[  943.598394]  ? blk_mq_freeze_queue_wait+0x126/0x130
[  943.598399]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[  943.598407]  ? __pfx_autoremove_wake_function+0x10/0x10
[  943.598422]  ? elv_iosched_store+0x194/0x530
[  943.598426]  elv_iosched_store+0x194/0x530
[  943.598434]  ? __pfx_elv_iosched_store+0x10/0x10
[  943.598441]  ? srso_return_thunk+0x5/0x5f
[  943.598445]  ? rcu_is_watching+0x11/0xb0
[  943.598450]  ? srso_return_thunk+0x5/0x5f
[  943.598459]  queue_attr_store+0x232/0x2f0
[  943.598467]  ? __pfx_queue_attr_store+0x10/0x10
[  943.598477]  ? srso_return_thunk+0x5/0x5f
[  943.598482]  ? srso_return_thunk+0x5/0x5f
[  943.598486]  ? find_held_lock+0x32/0x90
[  943.598491]  ? local_clock_noinstr+0x9/0xc0
[  943.598497]  ? srso_return_thunk+0x5/0x5f
[  943.598501]  ? __lock_release+0x1a2/0x2c0
[  943.598509]  ? sysfs_file_kobj+0xb5/0x1c0
[  943.598516]  ? srso_return_thunk+0x5/0x5f
[  943.598522]  ? srso_return_thunk+0x5/0x5f
[  943.598525]  ? sysfs_file_kobj+0xbf/0x1c0
[  943.598531]  ? srso_return_thunk+0x5/0x5f
[  943.598539]  ? __pfx_sysfs_kf_write+0x10/0x10
[  943.598544]  kernfs_fop_write_iter+0x357/0x530
[  943.598554]  vfs_write+0x9bc/0xf60
[  943.598560]  ? __lock_acquire+0x573/0xc00
[  943.598568]  ? __pfx_vfs_write+0x10/0x10
[  943.598577]  ? __print_lock_name+0xa2/0x100
[  943.598588]  ? find_held_lock+0x32/0x90
[  943.598593]  ? local_clock_noinstr+0x9/0xc0
[  943.598599]  ? srso_return_thunk+0x5/0x5f
[  943.598608]  ksys_write+0xf3/0x1d0
[  943.598614]  ? __pfx_ksys_write+0x10/0x10
[  943.598618]  ? srso_return_thunk+0x5/0x5f
[  943.598632]  do_syscall_64+0x8c/0x180
[  943.598641]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  943.598646] RIP: 0033:0x7fc1f3efdf77
[  943.598651] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
74 24
[  943.598655] RSP: 002b:00007fff8b39da28 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  943.598661] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fc1f3efdf77
[  943.598664] RDX: 0000000000000006 RSI: 00005597f8e81690 RDI: 0000000000000001
[  943.598667] RBP: 00005597f8e81690 R08: 0000000000000000 R09: 00007fc1f3fb0d40
[  943.598670] R10: 00007fc1f3fb0c40 R11: 0000000000000246 R12: 0000000000000006
[  943.598673] R13: 00007fc1f3ffa780 R14: 0000000000000006 R15: 00007fc1f3ff59e0
[  943.598691]  </TASK>


-- 
Best Regards,
  Yi Zhang

