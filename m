Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E603016E5
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014569; cv=pass; b=FX8xfT6w/o0zUasE7jEjzs+2XCG0PbFtXJxba4CNlRuNzuSk+/e7wg39JcKX+nUzPeZnfw8T5jY/lR0EVdX+knn+ZvMWFg9dj16bcEqrXb28oAoaDUbla0CO6/wiZyEp2pdgy/sv+Y1nMPhrGyAlFLsTfjkaWwqIAlyPw8VyP0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014569; c=relaxed/simple;
	bh=t24YPz/T0zfhXMB1yxsE97XXC0iTPcEq7qHh0jPL/uc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DGvVVnf7JIlq+DsCEyjs83HrLX6Y2/qAjc220eZ53/0+9UXIopqtwG2Bysk5kioCaQKFp0o2fGv2NQzLCpqdRt6x4aM9glnTwNfSnqgjQbwsPbkdw5wxmCZvH5XBwmwUSVkscityL1SR8407ecPzCZm7UqdFGknSdYdH3EHfwIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjwR65dK; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjwR65dK"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-89476eaaf16so41040366d6.1
        for <linux-block@vger.kernel.org>; Sun, 01 Feb 2026 22:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770014567; cv=none;
        d=google.com; s=arc-20240605;
        b=EG718avu+aomnASNPIPkIi4EPfdnoDZb9j0P8HNXqBafAUMkkupub+MuM73CA8Jjwn
         a4ZxOCbeQ5BUOdTH+alkXHRYq8HycgwtR6mLksuxTAhiVwpyAGIkMZI56LR651QhuxjQ
         HcIVWTtG8VaywzKlQB3YsPUQxdTPRzj3nh9x6m1zPtqzjlKHFwrU9pg50oSmId0vnlwb
         RJDjsShCGl8XIeQLpbqubIcJzmPrO5EQiWp9ITv+GJ6WfEjkUPrCuDGiytlNTcwtUzkm
         mfa2UxLSctIX39wHAig4Ax5KTf1vu6r+gmIqVzTA5sLKlT0W5Q7GAykN1VgajjBvwtHy
         AjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Dg/ienCweJDlMRjx6UMytKgzk66zcVFRJD/KuaphDY8=;
        fh=DAk8Madh57biCIErzYQqNvhDUYiOE8ZUA2eESVWYLIc=;
        b=RghX9MKjS2sGKnVe31s0/9UOQultomBiN/LwYeOK7APtFlWdYt7jmrJbuhlS7ka+cb
         fQyP5vdHgEu54HJroq4sa2WOv/tIPU1rqQV8Qp4arxtnofkyMu/VvqmvyCuCFEchia1U
         NyTM01bzZ8A5lqriCJQ7X0zycPkAutacfJhOY70jcT0Sgg+X5XC8tZ6QpJacuJQIvJAP
         NhCirpcaqudIYAiLiz8w5ltuqvRe1H15A3d5ARvly5eIrML1uKeoew1m6ahU9h7yaOy6
         +dxyqeEkSL+oCCvitYNCapfzAwjt/0MWM+Q+BLWxNs65NJLOWmf1FK9iFsSic43X65xa
         UmHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770014567; x=1770619367; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dg/ienCweJDlMRjx6UMytKgzk66zcVFRJD/KuaphDY8=;
        b=WjwR65dKw0yQR9x1ZqnAXVd7e7PIyosThMeZv0bH4rBLS3xdj9LtRuYEh5lF+HHppo
         U4BdVeVfUKgI81+w4OaKIo7P3uBEUgLuRieJuGIcnapeU2NrS0JeAraiQMS57EqyXLs9
         mGDX3co/6VcBF7zmlZzXXygONPhPsOf6YB5Uxd5IKsMJ53je7flXH6OpFwaKqp6FOPPm
         RGToqa20eV8/pIxe1xDV/o/k9Dg0dgP2Fcg6py7yhjw67AOnP0RCEogbtetXfbhGMwDC
         MPYJf649TD7moSYXvPUhhUmmMzs9wSTP1jaaaqGwCquKqkdtfC7ufQOQXwJRWg6KWqeo
         /D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770014567; x=1770619367;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dg/ienCweJDlMRjx6UMytKgzk66zcVFRJD/KuaphDY8=;
        b=TZfVY7Cst8nlDzn6xDHdvEPgG/Bo9v9JQwrezlq9EMZdsCMD8gYzmNMFllhl5gFRrU
         un2ox4VRWQMUCJqFuDpXwR+FmARf1LySFwJbRL+F+V6Jmjwg/2Zk/fE0IH8ZMFWnXyqg
         c/frdho/fMbfwJtBWz5n2Vi53qF8Rf2FxZM1t7KJPFxmml7AKu5K6uGxXJ/TeE7FgDgZ
         mXVS4ha0EVSNPMHqZgXqj5/PlpHyvDmLOhJuwOVe9nZnj3XvbxWOl4v8T42BRQT9FiZL
         jbECNmE99MCocsmPVJLfP2yb77AGDsNWbr+EBJzvqpuPoZoda6pqL91TE04R3xoxymk9
         zQvA==
X-Forwarded-Encrypted: i=1; AJvYcCV9UGyGp3edas6EIM7VkaESWQrRG4pz8gRQOPOZ5pokUKZNSIi2+d0LCxOOVD2G3ujKyMVv+9UvTdtiJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweSTKOOYSs2Pg7oUvi/Z4culI486t3PAS9LU24zUDz3PhuAn0q
	XpvSkURLsxlMxA7bbQX62bwpS5YZZRhGzOs7IN2pEHF6sgDYeLQ3CiqTXLpjNGPYN5LGu4TtUOv
	2Es3mkN9DEH6lHk/k4p27XqF7Bk8d0i0=
X-Gm-Gg: AZuq6aJUrs1lIfcEJeNsawx4dmOLwEVFcCIiznr8Jyt4zkFc8DzpGIz+VN7S8wcvtqZ
	cKGaS6X0ZuResu4TbcocXTDv4v8SjX7pXoDdSaYLewK6J16/rWkGgmQ+vKs+EXFkX/PzEpoTxka
	R09K/bA0RNJ31wHYhhtDMRqm9bWMBW9cphumbZuY9aiizyi23qZdlsHbOrCbv/RsEffr2uNTHlr
	Qu5wEvuefP7zs70bS4CGwdJtQMsMCDy7O0dbDB9AUG6+zfgm4fxNaM3P+AxQlmS5nZZ4bKFOWkO
	mg6r3/atxeKzu/MngVD+YndIozUSa6o6q/VO
X-Received: by 2002:ad4:5c63:0:b0:894:2c12:aed9 with SMTP id
 6a1803df08f44-894e9f268ccmr148346216d6.5.1770014566966; Sun, 01 Feb 2026
 22:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Date: Mon, 2 Feb 2026 14:42:36 +0800
X-Gm-Features: AZwV_Qgf-Xzj5ie7BslfiQRjH13YI5DA0bSt2ATqF1PV2vf9jSaAzrpedF4kHKE
Message-ID: <CAHPqNmyQn46RzhO4Axn7HMNJ5P84LFOe4S8OY9s0QuWNkN6k4A@mail.gmail.com>
Subject: [Kernel Bug] possible deadlock in set_capacity_and_notify
To: syzkaller@googlegroups.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. possible
deadlock in set_capacity_and_notify. Details are as follows.

Kernel commit: v6.12.11
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

======================================================
WARNING: possible circular locking dependency detected
6.12.11 #1 Not tainted
------------------------------------------------------
kworker/u15:5/211011 is trying to acquire lock:
ffffffff8e14aee0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc
include/linux/sched/mm.h:318 [inline]
ffffffff8e14aee0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook
mm/slub.c:4058 [inline]
ffffffff8e14aee0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node
mm/slub.c:4136 [inline]
ffffffff8e14aee0 (fs_reclaim){+.+.}-{0:0}, at:
kmem_cache_alloc_node_noprof+0x57/0x310 mm/slub.c:4208

but task is already holding lock:
ffffffff90213728 (uevent_sock_mutex){+.+.}-{4:4}, at:
uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
ffffffff90213728 (uevent_sock_mutex){+.+.}-{4:4}, at:
kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
ffffffff90213728 (uevent_sock_mutex){+.+.}-{4:4}, at:
kobject_uevent_env+0xb21/0x1860 lib/kobject_uevent.c:608

which lock already depends on the new lock.

...

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &q->q_usage_counter(io)#69 --> uevent_sock_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(uevent_sock_mutex);
                               lock(&q->q_usage_counter(io)#69);
                               lock(uevent_sock_mutex);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by kworker/u15:5/211011:
 #0: ffff888091b33948 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90006587d80 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88809649c078 (&hdev->lock){+.+.}-{4:4}, at:
hci_conn_complete_evt+0xbd/0x1580 net/bluetooth/hci_event.c:3076
 #3: ffffffff90213728 (uevent_sock_mutex){+.+.}-{4:4}, at:
uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 #3: ffffffff90213728 (uevent_sock_mutex){+.+.}-{4:4}, at:
kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 #3: ffffffff90213728 (uevent_sock_mutex){+.+.}-{4:4}, at:
kobject_uevent_env+0xb21/0x1860 lib/kobject_uevent.c:608

stack backtrace:
CPU: 1 UID: 0 PID: 211011 Comm: kworker/u15:5 Not tainted 6.12.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
 fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3867
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4058 [inline]
 slab_alloc_node mm/slub.c:4136 [inline]
 kmem_cache_alloc_node_noprof+0x57/0x310 mm/slub.c:4208
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1322 [inline]
 alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xc8f/0x1860 lib/kobject_uevent.c:608
 device_add+0x10e0/0x1a70 drivers/base/core.c:3646
 hci_conn_add_sysfs+0x17e/0x230 net/bluetooth/hci_sysfs.c:48
 hci_conn_complete_evt+0x505/0x1580 net/bluetooth/hci_event.c:3147
 hci_event_func net/bluetooth/hci_event.c:7474 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7526
 hci_rx_work+0x2c6/0x1650 net/bluetooth/hci_core.c:4030
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

https://drive.google.com/file/d/17HbDTI_iPjA72SkV5MnO-_w7IQZ9HIHW/view?usp=drive_link

https://drive.google.com/file/d/1LCQXLXGZSnRKePz0E_1nztMXbnpKtxAO/view?usp=drive_link
