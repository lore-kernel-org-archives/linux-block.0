Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD172617
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764051117; cv=none; b=l6eDEj/G7u0hgk/XVaEibAiQ37tCt0+lU8Z16a6DIwG0gC8nLF6OePtkoGsH47X6Bm7mspPea7cLRaOJEeMHCjtdcI1dQg7sjT9NZsujOfl8SLzE0l1LaMWoG6en5bJsA1yi9hgyWMpT/8ka5nmS3N1I9HDfm4L2t1IFztzdIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764051117; c=relaxed/simple;
	bh=kOkNIvN1eBDyIIR5UFAea374YA3imceJmrR1WhA8m1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iaxm/0y+MC7wR5tu8icBIfmQNl0IumtXhtTcg0XSJVR0iE7FOTEl40qDVeYMseZzaV3d+7TM01J8Yuny4q2jsFWi6/yLFi33f+EcdZdNZOKojJkmCu39cKb0ldEbO3Ox20FFv/fnPf7ABSQzAUiEVOpfvv5GCu4mZBlzhTDD8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJsgLfNk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJsgLfNk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bd610f4425fso3142228a12.3
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 22:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764051115; x=1764655915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkiTJ64envQtQwGCvlmHEL0Yi2p9cJmBWIu/uym8Nb0=;
        b=iJsgLfNkPRCiZ7xAeOR6Xgev8emy/xcPrtOa0YNTjds+SG3pEloZpvP29BJV0IQPys
         xn7YV2l3UayG3ccTfpm9JtNU88ynwumONK+G2NjFvMUbraaEaONoyOlM0iAaXx1cj8cv
         van/nOkXRdHbrQ4wyNhmP75aIFA8Picv8Pla4Pc8T4kXbKk69W7e1u3atfUFWZodgh2/
         hhMOUzBgcAo0oX0zzX7h8YIOfWJcn/FPWoRlG+xf0OC637NPSn/dLX3fL99y5BM2Fagu
         hGZm8M7y9LrHM8mbOwT9v7xQBnEFnWQfZ/Ij7o9SOMQFW8w1p4YDe49VrrzxNkhkr6oQ
         h3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764051115; x=1764655915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkiTJ64envQtQwGCvlmHEL0Yi2p9cJmBWIu/uym8Nb0=;
        b=Eg0R1JTQZKOs0tBpoTvdAQagcJ/hHoHPknwrOj1B2BrKEj+2dirQH+rp0yRUs/BYbC
         289N8hbOm6pKr33k3g07eKsIRDJhj9uMHaHEjGm/MmbkCVqsBtS5BcF9dfV0/bihPF3a
         ytjBr+T+GDhz/fXa4fd1CYItO/HEiKlclA7TdDmaxiNtlSPqU7NskqGN4CVq5WRChn/K
         2C4zN/hk+X41Nz6Pt4i5YYYYkVeg1UPFixnn8/7NyBDh9p8HzIr8AXIrbaFNXAoLzfzB
         2yPrw92a5DCjEdPOb8yia0TtvGPHnn3aiv2cvIbcWNDd3cg3VyeqZiDVR9wxZwS7WvGA
         M43g==
X-Forwarded-Encrypted: i=1; AJvYcCWxQd8Mz/boArNejQjsPSlYiUw4Aj6vRqHB8yzslImfcFLjjgbPpbxKJG1r9XnAnt/Xyv8xU86REzTLZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMbNMO3kL8mcSEsku+Xi9R9tlWAoBhQGBVOkJsEBthjFbEMXW
	9JcXocQoYu1nZrPaYa0uaqCTLoqAOUT2JQb5E/TeCFU5q0Wzp+4H9Umw
X-Gm-Gg: ASbGncuByfEQb7fR74pU2YxK/nKZ+VuP7gWK8snC0yBtotARI8dz5TJEgjm5Fa8d7+s
	gHToqTgKMXLa26V5SCyqycCgMQ78qoDO2lIEnfoU2ODJlxdfTgGOCheCgYdX+Mx4T16LccoEjX+
	at08fqMewcMNfCxbuAShl8NqFFVKDL7oPPTPaa/6I1ktImOiRQEgRb70RDP9/M2HXlH1nkRaYcM
	Rjsov+E7/LN+XYm5i6GbqRQ37Nh35ldjc05tIKnpQOqPjHShd2kn04+soO8q8cYIAsPEKPKIQZ0
	Zom/LYs4KoocO7yFsaU/j0RIdR3WxUv4qrmdCFKopY6K3upy0BitsoPPTGmF0CZUn/7Yc37qHnt
	n4hV+AOEIOQpb5BOP6oy406HecEkpsBZB9tVzI7Ub/9W0zQFFLVDV5Fud1VOzDXq5O6zkDZAtxB
	X0/ze6KZRazCoVQ0LMtslx2xDgj+V/Yf56UUCQZgoaPkQdJBs=
X-Google-Smtp-Source: AGHT+IEhyBGYmBqcMW4mCIOa0l9IPFgJCvx68Vx8io7PP2ETpWasHPA9ziuU7ZPIs+Pc1UjjkblQng==
X-Received: by 2002:a05:7300:f14d:b0:2a4:3592:c5f7 with SMTP id 5a478bee46e88-2a941564d39mr723067eec.8.1764051114978;
        Mon, 24 Nov 2025 22:11:54 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5b122dsm59099476eec.5.2025.11.24.22.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 22:11:54 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	hare@suse.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	dlemoal@kernel.org,
	wagi@kernel.org,
	mpatocka@redhat.com,
	yukuai3@huawei.com,
	xni@redhat.com,
	linan122@huawei.com,
	bmarzins@redhat.com,
	john.g.garry@oracle.com,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Date: Mon, 24 Nov 2025 22:11:42 -0800
Message-Id: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_disconnect() calls tcp_send_active_reset() with gfp_any(), which
returns GFP_KERNEL in process context. This can trigger a circular
locking dependency when called during block device teardown that
involves network-backed storage.

The deadlock scenario occurs with storage configurations like MD RAID
over NVMeOF TCP when tearing down the block device:

CPU0 (mdadm --stop /dev/mdX):          CPU1 (NVMe I/O submission):
================================       ===========================
del_gendisk()
  blk_unregister_queue()
    elevator_set_none()
      elevator_switch()
        __synchronize_srcu()
          [holds set->srcu]
          [waits for operations]
                                       nvme_tcp_queue_rq()
                                         nvme_tcp_try_send()
                                           tcp_sendmsg()
                                             lock_sock_nested()
                                               [holds sk_lock-AF_INET-NVME]
                                               [can wait for set->srcu]

    [cleanup triggers NVMe disconnect]
    nvme_tcp_teardown_io_queues()
      nvme_tcp_free_queue()
        sock_release()
          __sock_release()
            tcp_close()
              lock_sock_nested()
                [holds sk_lock-AF_INET-NVME]
                __tcp_close()
                  tcp_disconnect()
                    tcp_send_active_reset()
                      alloc_skb(gfp_any())
                        [GFP_KERNEL in process context]
                        kmem_cache_alloc_node()
                          fs_reclaim_acquire()
                            [can trigger writeback]
                            [needs block layer]
                            [waits for set->srcu]
                            *** DEADLOCK ***

blktests ./check md/001:

[   95.764798] run blktests md/001 at 2025-11-24 21:13:10
[   96.020965] brd: module loaded
[   96.098934] Key type psk registered
[   96.237974] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   96.244988] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   96.286775] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   96.290980] nvme nvme0: creating 48 I/O queues.
[   96.304554] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[   96.322530] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   96.414331] md: async del_gendisk mode will be removed in future, please upgrade to mdadm-4.5+
[   96.414427] block device autoloading is deprecated and will be removed.
[   96.473347] md/raid1:md127: active with 1 out of 2 mirrors
[   96.474602] md127: detected capacity change from 0 to 2093056
[   96.665424] md127: detected capacity change from 2093056 to 0
[   96.665433] md: md127 stopped.
[   96.694365] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   96.708310] block nvme0n1: no available path - failing I/O
[   96.708379] block nvme0n1: no available path - failing I/O
[   96.708414] block nvme0n1: no available path - failing I/O
[   96.708734] block nvme0n1: no available path - failing I/O
[   96.708745] block nvme0n1: no available path - failing I/O
[   96.708761] block nvme0n1: no available path - failing I/O

[   96.812432] ======================================================
[   96.816828] WARNING: possible circular locking dependency detected
[   96.821054] 6.18.0-rc6lblk-fnext+ #7 Tainted: G                 N
[   96.825312] ------------------------------------------------------
[   96.830181] nvme/2595 is trying to acquire lock:
[   96.833374] ffffffff82e487e0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x5a/0x770
[   96.839640]
               but task is already holding lock:
[   96.843657] ffff88810c503358 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_close+0x15/0x80
[   96.849247]
               which lock already depends on the new lock.

[   96.854869]
               the existing dependency chain (in reverse order) is:
[   96.860473]
               -> #4 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[   96.865028]        lock_sock_nested+0x2e/0x70
[   96.868084]        tcp_sendmsg+0x1a/0x40
[   96.870833]        sock_sendmsg+0xed/0x110
[   96.873677]        nvme_tcp_try_send_cmd_pdu+0x13e/0x260 [nvme_tcp]
[   96.878007]        nvme_tcp_try_send+0xb3/0x330 [nvme_tcp]
[   96.881344]        nvme_tcp_queue_rq+0x342/0x3d0 [nvme_tcp]
[   96.884399]        blk_mq_dispatch_rq_list+0x29a/0x800
[   96.887237]        __blk_mq_sched_dispatch_requests+0x3de/0x5f0
[   96.891116]        blk_mq_sched_dispatch_requests+0x29/0x70
[   96.894166]        blk_mq_run_work_fn+0x76/0x1b0
[   96.896710]        process_one_work+0x211/0x630
[   96.899162]        worker_thread+0x184/0x330
[   96.901503]        kthread+0x10d/0x250
[   96.903570]        ret_from_fork+0x29a/0x300
[   96.905888]        ret_from_fork_asm+0x1a/0x30
[   96.908186]
               -> #3 (set->srcu){.+.+}-{0:0}:
[   96.910188]        __synchronize_srcu+0x49/0x170
[   96.911882]        elevator_switch+0xc9/0x330
[   96.913459]        elevator_change+0x133/0x1b0
[   96.915079]        elevator_set_none+0x3b/0x80
[   96.916714]        blk_unregister_queue+0xb0/0x120
[   96.918450]        __del_gendisk+0x14e/0x3c0
[   96.920700]        del_gendisk+0x75/0xa0
[   96.922098]        nvme_ns_remove+0xf2/0x230 [nvme_core]
[   96.924044]        nvme_remove_namespaces+0xf2/0x150 [nvme_core]
[   96.926220]        nvme_do_delete_ctrl+0x71/0x90 [nvme_core]
[   96.928310]        nvme_delete_ctrl_sync+0x3b/0x50 [nvme_core]
[   96.930429]        nvme_sysfs_delete+0x34/0x40 [nvme_core]
[   96.932450]        kernfs_fop_write_iter+0x16d/0x220
[   96.934271]        vfs_write+0x37b/0x520
[   96.935746]        ksys_write+0x67/0xe0
[   96.937141]        do_syscall_64+0x76/0xa60
[   96.938645]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   96.940628]
               -> #2 (&q->elevator_lock){+.+.}-{4:4}:
[   96.942903]        __mutex_lock+0xa2/0x1150
[   96.944434]        elevator_change+0x9b/0x1b0
[   96.946046]        elv_iosched_store+0x116/0x190
[   96.947746]        kernfs_fop_write_iter+0x16d/0x220
[   96.949524]        vfs_write+0x37b/0x520
[   96.951506]        ksys_write+0x67/0xe0
[   96.952934]        do_syscall_64+0x76/0xa60
[   96.954457]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   96.956489]
               -> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
[   96.959011]        blk_alloc_queue+0x30e/0x350
[   96.960664]        blk_mq_alloc_queue+0x61/0xd0
[   96.962293]        scsi_alloc_sdev+0x2a0/0x3e0
[   96.963954]        scsi_probe_and_add_lun+0x1bd/0x430
[   96.965782]        __scsi_add_device+0x109/0x120
[   96.967461]        ata_scsi_scan_host+0x97/0x1c0
[   96.969198]        async_run_entry_fn+0x30/0x130
[   96.970903]        process_one_work+0x211/0x630
[   96.972577]        worker_thread+0x184/0x330
[   96.974097]        kthread+0x10d/0x250
[   96.975448]        ret_from_fork+0x29a/0x300
[   96.977050]        ret_from_fork_asm+0x1a/0x30
[   96.978705]
               -> #0 (fs_reclaim){+.+.}-{0:0}:
[   96.981265]        __lock_acquire+0x1468/0x2210
[   96.982950]        lock_acquire+0xd3/0x2f0
[   96.984445]        fs_reclaim_acquire+0x99/0xd0
[   96.986141]        kmem_cache_alloc_node_noprof+0x5a/0x770
[   96.988171]        __alloc_skb+0x15f/0x190
[   96.989681]        tcp_send_active_reset+0x3f/0x1e0
[   96.991248]        tcp_disconnect+0x551/0x770
[   96.992851]        __tcp_close+0x2c7/0x520
[   96.994327]        tcp_close+0x20/0x80
[   96.995727]        inet_release+0x34/0x60
[   96.997168]        __sock_release+0x3d/0xc0
[   96.998688]        sock_close+0x14/0x20
[   97.000058]        __fput+0xf1/0x2c0
[   97.001388]        task_work_run+0x58/0x90
[   97.002922]        exit_to_user_mode_loop+0x12c/0x150
[   97.004720]        do_syscall_64+0x2a0/0xa60
[   97.006256]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.008279]
               other info that might help us debug this:

[   97.011827] Chain exists of:
                 fs_reclaim --> set->srcu --> sk_lock-AF_INET-NVME

[   97.015506]  Possible unsafe locking scenario:

[   97.017718]        CPU0                    CPU1
[   97.019363]        ----                    ----
[   97.020984]   lock(sk_lock-AF_INET-NVME);
[   97.022399]                                lock(set->srcu);
[   97.024415]                                lock(sk_lock-AF_INET-NVME);
[   97.026798]   lock(fs_reclaim);
[   97.027927]
                *** DEADLOCK ***

[   97.030010] 2 locks held by nvme/2595:
[   97.031353]  #0: ffff88810047b388 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x30/0xc0
[   97.034820]  #1: ffff88810c503358 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_close+0x15/0x80
[   97.037806]
               stack backtrace:
[   97.039367] CPU: 2 UID: 0 PID: 2595 Comm: nvme Tainted: G                 N  6.18.0-rc6lblk-fnext+ #7 PREEMPT(voluntary)
[   97.039370] Tainted: [N]=TEST
[   97.039371] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   97.039372] Call Trace:
[   97.039374]  <TASK>
[   97.039375]  dump_stack_lvl+0x75/0xb0
[   97.039379]  print_circular_bug+0x26a/0x330
[   97.039381]  check_noncircular+0x12f/0x150
[   97.039385]  __lock_acquire+0x1468/0x2210
[   97.039388]  lock_acquire+0xd3/0x2f0
[   97.039390]  ? kmem_cache_alloc_node_noprof+0x5a/0x770
[   97.039393]  fs_reclaim_acquire+0x99/0xd0
[   97.039395]  ? kmem_cache_alloc_node_noprof+0x5a/0x770
[   97.039396]  kmem_cache_alloc_node_noprof+0x5a/0x770
[   97.039397]  ? __alloc_skb+0x15f/0x190
[   97.039400]  ? __alloc_skb+0x15f/0x190
[   97.039401]  __alloc_skb+0x15f/0x190
[   97.039403]  tcp_send_active_reset+0x3f/0x1e0
[   97.039405]  tcp_disconnect+0x551/0x770
[   97.039407]  __tcp_close+0x2c7/0x520
[   97.039408]  tcp_close+0x20/0x80
[   97.039410]  inet_release+0x34/0x60
[   97.039412]  __sock_release+0x3d/0xc0
[   97.039413]  sock_close+0x14/0x20
[   97.039414]  __fput+0xf1/0x2c0
[   97.039416]  task_work_run+0x58/0x90
[   97.039418]  exit_to_user_mode_loop+0x12c/0x150
[   97.039420]  do_syscall_64+0x2a0/0xa60
[   97.039422]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.039423] RIP: 0033:0x7f869032e317
[   97.039425] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   97.039430] RSP: 002b:00007fff7ceb31c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   97.039432] RAX: 0000000000000001 RBX: 00007fff7ceb44bd RCX: 00007f869032e317
[   97.039433] RDX: 0000000000000001 RSI: 00007f869044c719 RDI: 0000000000000003
[   97.039433] RBP: 0000000000000003 R08: 0000000017c8a850 R09: 00007f86903c44e0
[   97.039434] R10: 00007f8690252130 R11: 0000000000000246 R12: 00007f869044c719
[   97.039435] R13: 0000000017c8a4c0 R14: 0000000017c8a4c0 R15: 0000000017c8b680
[   97.039438]  </TASK>
[   97.263257] brd: module unloaded

Fix this by using GFP_ATOMIC instead of gfp_any() in tcp_disconnect().
This matches the existing pattern in __tcp_close() which already uses
GFP_ATOMIC when calling tcp_send_active_reset() (tcp.c:3246).
gfp_any() only considers softirq vs process context, but doesn't
account for lock context where sleeping is unsafe.

The issue was discovered with blktests md/001, which creates an MD RAID1
array with internal bitmap over NVMe-TCP, then stops the array. This
triggers the block device removal -> elevator cleanup -> network teardown
path that exposes the circular dependency.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

Hi,

Full disclosure: I'm not an expert in this area, if there is a better
solution, I'll be happy to try that.

-ck

---
 net/ipv4/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a18aeca7ab0..9fd01a8b90b5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3363,14 +3363,15 @@ int tcp_disconnect(struct sock *sk, int flags)
 	} else if (unlikely(tp->repair)) {
 		WRITE_ONCE(sk->sk_err, ECONNABORTED);
 	} else if (tcp_need_reset(old_state)) {
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_STATE);
+		/* Use GFP_ATOMIC since we're holding sk_lock */
+		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_TCP_STATE);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (tp->snd_nxt != tp->write_seq &&
 		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(),
+		tcp_send_active_reset(sk, GFP_ATOMIC,
 				      SK_RST_REASON_TCP_DISCONNECT_WITH_DATA);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
-- 
2.40.0

