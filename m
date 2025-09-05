Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A112BEC3A
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102633; cv=none; b=ujeiINSz0gRuM8zAzKQMUp80kg+/F3e/xFGktULx985CE76aLPQetaFeu8gsGVSGdwkXSUqk03UtreMjKBSJXuzIv29aSDbm2dw4h+WgXiHWDg1zaBDTV/Ag5C3CqmbAfcnyN4yDXvDphcb9sLDmRzZz74+r9p3zjC5JSpvyCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102633; c=relaxed/simple;
	bh=+ktQU6+WfPjIPilRV975gWodePFLlU5HCgU6SFz0s6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geOv2krTd5Sh0U/uNRL9TzDe531JPlvDeW5nQN4u8KBQuo2uwlYRbbd5Wd0YC+PD8F/QUzhD56VYJj88ZnW2W2VRx+YzSpDVLuNqT8S5rSsuNdySCUUQFiporwpSm5qqlkBqIAzCIdNqyvTeybKL7wtky/t/hbYSUEb/LxUKnk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhUJQZzT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhUJQZzT"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5ed9d7e30so10314511cf.3
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757102622; x=1757707422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCmJUEgEnJ3L7tvRLxM2OU4AKUbDUR+Tr3jO51brMCc=;
        b=OhUJQZzT01Pfwth1//qs9vwzKHWNLpJCB0Skwy/YZ0q8m0BHt8zPQ2PIWd/HO0TAqp
         C62pfNw0Af+HiTWVyZDfA+hxSpFTM+vg5SDw15KuW4uM9aFZdk3bQUqJWIYxmkxjtKOF
         3VKXPm80LxJ3i+aiGV7S/mO6FnhgNlK8tMbiQs7KzeOKYj7L+CYG2tfBJ7hMwU/RpQZu
         +EsyqKs55AvLzoMkmL76fKJ4XpJfD+aIjTKZkkuMf+dcL6Bp3XlohKqObgHEwnxaiQIw
         qLGo+2rfZqiknyGzmoRvc/AjVgnSIaMCZ4S/syDo6A2wLlk9XvpfIbUCoU2km3GtC+Sj
         uPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102622; x=1757707422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCmJUEgEnJ3L7tvRLxM2OU4AKUbDUR+Tr3jO51brMCc=;
        b=Vh+WxUJD4P0pYALJj0MuBXwhexfUundXIKqKyfczdS6YI47r4pL7apJYkWZWyvuEJn
         wG6PBu4nVE8e1SxN1smehazy2Vx1DmLuStIAo3Eum5g4XYfKPi16El6t8cb4occtci4R
         n81Y/XPDeZSslh8AfxW7twxt/mDFtKTAfAsGQi8UdO9OgLT0pe2NSfiLnKYni3vrYv3P
         yQub4c47ss+zfmjt9mrb+SwmVGliGqCQ8xvmPdetFCLaOEy37m7/itroy0QM9d1blv6V
         CtgQjJN2mj1gX+WNPLGxZDaDaf0f0q/0a/9FvmP3F6Dtj7hNJzi0Vc6kzfum8hU2TGY2
         v0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVqVO+wGsIMGzNrTDd9EZQJIdKfeKZ9jZmbPnvj1BzAnaZbeswbXPlhi+WFbrUA8Bo4Oll98xVsJFw/vw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9bK7kREm3gD1/sjPB4lCrXGwRarObyv8pwedgEj64Mm9FF9T
	Am9GXWa8W39PJ3JMb0Rmv4zEzf192ReIqy6Ri/KjYt0fFSD8/tBGFqlrlbBxUsaqxa3RTIljDkC
	aRJsu+ynkV+5XLgkajoB20pgI5UeGF+/30+l8amPx
X-Gm-Gg: ASbGncs3A/ReH4RIQDhPGKplncfW/BD2V7iaoQDrpwH3/ueaMkCsJVab+toRpWNWGWz
	FRbrxm5D5M4tHDWyokDwjgbFx70ua1P0Hia7Zhx21bMQ6yPNmoP/AQ7dSBLWobpYAqRH5ARSpzW
	TcQ4WT2suowsSt9DgZxlQphWVvgOKCw1gVy2Wm7oTteF3Znr9BE2H85RPsQPDkkbVik8fuFjHfQ
	GHL4xyFsd/aiQ==
X-Google-Smtp-Source: AGHT+IEsrEzrG+/BC2PeFaA9kA0z+BsOgSLMs4T9EZIDLhlTPhAFNdOseg96/OCgqykomq3gBgqMxKYKMd4bxAt8elQ=
X-Received: by 2002:ac8:5890:0:b0:4b2:9510:79ab with SMTP id
 d75a77b69052e-4b31d80cc5emr312913721cf.13.1757102621439; Fri, 05 Sep 2025
 13:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com>
In-Reply-To: <68bb4160.050a0220.192772.0198.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Sep 2025 13:03:30 -0700
X-Gm-Features: Ac12FXy8BNCXNJDqzOIp1ctRY9gtrkYaVC6pDJAOTqXeDc1yZQccK7RS3jkiU_E
Message-ID: <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
<syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    788bc43d8330 Merge branch 'microchip-lan865x-fix-probing-=
i..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10fc4e3458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9c302bcfb26a4=
8af
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De1cd6bd8493060b=
d701d
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D136c41f0580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13bac24258000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c958eee3370d/dis=
k-788bc43d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/615040093399/vmlinu=
x-788bc43d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/91377e9f5c93/b=
zImage-788bc43d.xz
>
> The issue was bisected to:
>
> commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
> Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Date:   Tue Mar 18 09:55:48 2025 +0000
>
>     block: Make request_queue lockdep splats show up earlier
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1263c1f058=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1163c1f058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1663c1f058000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com
> Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up ea=
rlier")
>
> block nbd0: Send control failed (result -89)
> block nbd0: Request send failed, requeueing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> udevd/5878 is trying to acquire lock:
> ffff88807ba3eed8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/ne=
t/sock.h:1667 [inline]
> ffff88807ba3eed8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: inet_shutdown+0x6a/0=
x390 net/ipv4/af_inet.c:905
>
> but task is already holding lock:
> ffff888074e3b470 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_handle_cmd driver=
s/block/nbd.c:1140 [inline]
> ffff888074e3b470 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_queue_rq+0xa66/0x=
f10 drivers/block/nbd.c:1204
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #6 (&nsock->tx_lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>        nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
>        nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
>        blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2120
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c=
:307
>        blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2358
>        blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>        blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2967
>        __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
>        blk_finish_plug block/blk-core.c:1247 [inline]
>        __submit_bio+0x2d3/0x5a0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x4ab/0xb50 block/blk-core.c:751
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x599/0x830 fs/buffer.c:2447
>        filemap_read_folio+0x114/0x380 mm/filemap.c:2413
>        do_read_cache_folio+0x350/0x590 mm/filemap.c:3957
>        read_mapping_folio include/linux/pagemap.h:991 [inline]
>        read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
>        adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
>        blkdev_get_whole+0x380/0x510 block/bdev.c:748
>        bdev_open+0x31e/0xd30 block/bdev.c:957
>        blkdev_open+0x3a8/0x510 block/fops.c:691
>        do_dentry_open+0x950/0x13f0 fs/open.c:965
>        vfs_open+0x3b/0x340 fs/open.c:1095
>        do_open fs/namei.c:3887 [inline]
>        path_openat+0x2ee5/0x3830 fs/namei.c:4046
>        do_filp_open+0x1fa/0x410 fs/namei.c:4073
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1435
>        do_sys_open fs/open.c:1450 [inline]
>        __do_sys_openat fs/open.c:1466 [inline]
>        __se_sys_openat fs/open.c:1461 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1461
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #5 (&cmd->lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>        nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
>        blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2120
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c=
:307
>        blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2358
>        blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>        blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2967
>        __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
>        blk_finish_plug block/blk-core.c:1247 [inline]
>        __submit_bio+0x2d3/0x5a0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x4ab/0xb50 block/blk-core.c:751
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x599/0x830 fs/buffer.c:2447
>        filemap_read_folio+0x114/0x380 mm/filemap.c:2413
>        do_read_cache_folio+0x350/0x590 mm/filemap.c:3957
>        read_mapping_folio include/linux/pagemap.h:991 [inline]
>        read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
>        adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
>        blkdev_get_whole+0x380/0x510 block/bdev.c:748
>        bdev_open+0x31e/0xd30 block/bdev.c:957
>        blkdev_open+0x3a8/0x510 block/fops.c:691
>        do_dentry_open+0x950/0x13f0 fs/open.c:965
>        vfs_open+0x3b/0x340 fs/open.c:1095
>        do_open fs/namei.c:3887 [inline]
>        path_openat+0x2ee5/0x3830 fs/namei.c:4046
>        do_filp_open+0x1fa/0x410 fs/namei.c:4073
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1435
>        do_sys_open fs/open.c:1450 [inline]
>        __do_sys_openat fs/open.c:1466 [inline]
>        __se_sys_openat fs/open.c:1461 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1461
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #4 (set->srcu){.+.+}-{0:0}:
>        lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
>        srcu_lock_sync include/linux/srcu.h:173 [inline]
>        __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1429
>        elevator_switch+0x12b/0x640 block/elevator.c:588
>        elevator_change+0x2d4/0x450 block/elevator.c:690
>        elevator_set_default+0x186/0x260 block/elevator.c:766
>        blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:904
>        __add_disk+0x677/0xd50 block/genhd.c:528
>        add_disk_fwnode+0xfc/0x480 block/genhd.c:597
>        add_disk include/linux/blkdev.h:774 [inline]
>        nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1973
>        nbd_init+0x168/0x1f0 drivers/block/nbd.c:2680
>        do_one_initcall+0x233/0x820 init/main.c:1269
>        do_initcall_level+0x104/0x190 init/main.c:1331
>        do_initcalls+0x59/0xa0 init/main.c:1347
>        kernel_init_freeable+0x334/0x4b0 init/main.c:1579
>        kernel_init+0x1d/0x1d0 init/main.c:1469
>        ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #3 (&q->elevator_lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>        elevator_change+0x19b/0x450 block/elevator.c:688
>        elevator_set_none+0x42/0xb0 block/elevator.c:781
>        blk_mq_elv_switch_none block/blk-mq.c:5023 [inline]
>        __blk_mq_update_nr_hw_queues block/blk-mq.c:5066 [inline]
>        blk_mq_update_nr_hw_queues+0x598/0x1aa0 block/blk-mq.c:5124
>        nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
>        nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2228
>        genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>        netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg+0x219/0x270 net/socket.c:729
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2614
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
>        __sys_sendmsg net/socket.c:2700 [inline]
>        __do_sys_sendmsg net/socket.c:2705 [inline]
>        __se_sys_sendmsg net/socket.c:2703 [inline]
>        __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        blk_alloc_queue+0x538/0x620 block/blk-core.c:461
>        blk_mq_alloc_queue block/blk-mq.c:4400 [inline]
>        __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4447
>        nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1943
>        nbd_init+0x168/0x1f0 drivers/block/nbd.c:2680
>        do_one_initcall+0x233/0x820 init/main.c:1269
>        do_initcall_level+0x104/0x190 init/main.c:1331
>        do_initcalls+0x59/0xa0 init/main.c:1347
>        kernel_init_freeable+0x334/0x4b0 init/main.c:1579
>        kernel_init+0x1d/0x1d0 init/main.c:1469
>        ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
>        fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4248
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4131 [inline]
>        slab_alloc_node mm/slub.c:4209 [inline]
>        kmem_cache_alloc_node_noprof+0x47/0x3c0 mm/slub.c:4281
>        __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
>        alloc_skb include/linux/skbuff.h:1336 [inline]
>        __ip6_append_data+0x2c16/0x3f30 net/ipv6/ip6_output.c:1671
>        ip6_append_data+0x1c4/0x380 net/ipv6/ip6_output.c:1860
>        rawv6_sendmsg+0x127a/0x1820 net/ipv6/raw.c:911
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg+0x19c/0x270 net/socket.c:729
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2614
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
>        __sys_sendmsg net/socket.c:2700 [inline]
>        __do_sys_sendmsg net/socket.c:2705 [inline]
>        __se_sys_sendmsg net/socket.c:2703 [inline]
>        __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        lock_sock_nested+0x48/0x100 net/core/sock.c:3733
>        lock_sock include/net/sock.h:1667 [inline]
>        inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:905
>        nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
>        nbd_send_cmd+0x11ec/0x1ba0 drivers/block/nbd.c:799
>        nbd_handle_cmd drivers/block/nbd.c:1174 [inline]
>        nbd_queue_rq+0xcdb/0xf10 drivers/block/nbd.c:1204
>        blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2120
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c=
:307
>        blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2358
>        blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>        blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2967
>        __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
>        blk_finish_plug block/blk-core.c:1247 [inline]
>        __submit_bio+0x2d3/0x5a0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x4ab/0xb50 block/blk-core.c:751
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x599/0x830 fs/buffer.c:2447
>        filemap_read_folio+0x114/0x380 mm/filemap.c:2413
>        do_read_cache_folio+0x350/0x590 mm/filemap.c:3957
>        read_mapping_folio include/linux/pagemap.h:991 [inline]
>        read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
>        adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
>        blkdev_get_whole+0x380/0x510 block/bdev.c:748
>        bdev_open+0x31e/0xd30 block/bdev.c:957
>        blkdev_open+0x3a8/0x510 block/fops.c:691
>        do_dentry_open+0x950/0x13f0 fs/open.c:965
>        vfs_open+0x3b/0x340 fs/open.c:1095
>        do_open fs/namei.c:3887 [inline]
>        path_openat+0x2ee5/0x3830 fs/namei.c:4046
>        do_filp_open+0x1fa/0x410 fs/namei.c:4073
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1435
>        do_sys_open fs/open.c:1450 [inline]
>        __do_sys_openat fs/open.c:1466 [inline]
>        __se_sys_openat fs/open.c:1461 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1461
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
> Chain exists of:
>   sk_lock-AF_INET6 --> &cmd->lock --> &nsock->tx_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&nsock->tx_lock);
>                                lock(&cmd->lock);
>                                lock(&nsock->tx_lock);
>   lock(sk_lock-AF_INET6);
>
>  *** DEADLOCK ***
>
> 4 locks held by udevd/5878:
>  #0: ffff8880250f6358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0=
/0xd30 block/bdev.c:945
>  #1: ffff888142bf5f10 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire incl=
ude/linux/srcu.h:161 [inline]
>  #1: ffff888142bf5f10 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include=
/linux/srcu.h:253 [inline]
>  #1: ffff888142bf5f10 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x=
31f/0x4f0 block/blk-mq.c:2358
>  #2: ffff88805a2e0178 (&cmd->lock){+.+.}-{4:4}, at: nbd_queue_rq+0xc8/0xf=
10 drivers/block/nbd.c:1196
>  #3: ffff888074e3b470 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_handle_cmd d=
rivers/block/nbd.c:1140 [inline]
>  #3: ffff888074e3b470 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_queue_rq+0xa=
66/0xf10 drivers/block/nbd.c:1204
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 5878 Comm: udevd Not tainted syzkaller #0 PREEMPT(full=
)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
>  check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>  lock_sock_nested+0x48/0x100 net/core/sock.c:3733
>  lock_sock include/net/sock.h:1667 [inline]
>  inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:905
>  nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
>  nbd_send_cmd+0x11ec/0x1ba0 drivers/block/nbd.c:799
>  nbd_handle_cmd drivers/block/nbd.c:1174 [inline]
>  nbd_queue_rq+0xcdb/0xf10 drivers/block/nbd.c:1204
>  blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2120
>  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>  blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>  __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
>  blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>  blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2358
>  blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>  blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2967
>  __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
>  blk_finish_plug block/blk-core.c:1247 [inline]
>  __submit_bio+0x2d3/0x5a0 block/blk-core.c:649
>  __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>  submit_bio_noacct_nocheck+0x4ab/0xb50 block/blk-core.c:751
>  submit_bh fs/buffer.c:2829 [inline]
>  block_read_full_folio+0x599/0x830 fs/buffer.c:2447
>  filemap_read_folio+0x114/0x380 mm/filemap.c:2413
>  do_read_cache_folio+0x350/0x590 mm/filemap.c:3957
>  read_mapping_folio include/linux/pagemap.h:991 [inline]
>  read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
>  adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
>  check_partition block/partitions/core.c:141 [inline]
>  blk_add_partitions block/partitions/core.c:589 [inline]
>  bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
>  blkdev_get_whole+0x380/0x510 block/bdev.c:748
>  bdev_open+0x31e/0xd30 block/bdev.c:957
>  blkdev_open+0x3a8/0x510 block/fops.c:691
>  do_dentry_open+0x950/0x13f0 fs/open.c:965
>  vfs_open+0x3b/0x340 fs/open.c:1095
>  do_open fs/namei.c:3887 [inline]
>  path_openat+0x2ee5/0x3830 fs/namei.c:4046
>  do_filp_open+0x1fa/0x410 fs/namei.c:4073
>  do_sys_openat2+0x121/0x1c0 fs/open.c:1435
>  do_sys_open fs/open.c:1450 [inline]
>  __do_sys_openat fs/open.c:1466 [inline]
>  __se_sys_openat fs/open.c:1461 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1461
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6d8e8a7407
> Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 f=
c 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80=
 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> RSP: 002b:00007ffc70a60620 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f6d8f007880 RCX: 00007f6d8e8a7407
> RDX: 00000000000a0800 RSI: 000056300ccb64f0 RDI: ffffffffffffff9c
> RBP: 000056300cc95910 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 000056300ccc6350
> R13: 000056300cca3190 R14: 0000000000000000 R15: 000056300ccc6350
>  </TASK>
> I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 1, async page read
> I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 2, async page read
> I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 3, async page read
> I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 0, async page read
> I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 1, async page read
> I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 2, async page read
> I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 3, async page read
> I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 0, async page read
> I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio cla=
ss 2
> Buffer I/O error on dev nbd0, logical block 1, async page read
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd0: unable to read RDB block 0
>  nbd0: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd0: unable to read RDB block 0
>  nbd0: unable to read partition table
> block nbd2: Send control failed (result -89)
> block nbd2: Request send failed, requeueing
> block nbd2: Dead connection, failed to find a fallback
> block nbd2: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd2: unable to read RDB block 0
>  nbd2: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd2: unable to read RDB block 0
>  nbd2: unable to read partition table
> block nbd3: Send control failed (result -89)
> block nbd3: Request send failed, requeueing
> block nbd3: Dead connection, failed to find a fallback
> block nbd3: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd3: unable to read RDB block 0
>  nbd3: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd3: unable to read RDB block 0
>  nbd3: unable to read partition table
> block nbd4: Send control failed (result -89)
> block nbd4: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd4: unable to read RDB block 0
>  nbd4: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd4: unable to read RDB block 0
>  nbd4: unable to read partition table
> block nbd5: Send control failed (result -89)
> block nbd5: Request send failed, requeueing
> block nbd5: Dead connection, failed to find a fallback
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd5: unable to read RDB block 0
>  nbd5: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd5: unable to read RDB block 0
>  nbd5: unable to read partition table
> block nbd6: Send control failed (result -89)
> block nbd6: Request send failed, requeueing
> block nbd6: Dead connection, failed to find a fallback
> block nbd6: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd6: unable to read RDB block 0
>  nbd6: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd6: unable to read RDB block 0
>  nbd6: unable to read partition table
> block nbd7: Send control failed (result -89)
> block nbd7: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd7: unable to read RDB block 0
>  nbd7: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd7: unable to read RDB block 0
>  nbd7: unable to read partition table
> block nbd8: Send control failed (result -89)
> block nbd8: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd8: unable to read RDB block 0
>  nbd8: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd8: unable to read RDB block 0
>  nbd8: unable to read partition table
> block nbd9: Send control failed (result -32)
> block nbd9: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd9: unable to read RDB block 0
>  nbd9: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd9: unable to read RDB block 0
>  nbd9: unable to read partition table
> block nbd10: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd10: unable to read RDB block 0
>  nbd10: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd10: unable to read RDB block 0
>  nbd10: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd11: unable to read RDB block 0
>  nbd11: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd11: unable to read RDB block 0
>  nbd11: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd12: unable to read RDB block 0
>  nbd12: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd12: unable to read RDB block 0
>  nbd12: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd13: unable to read RDB block 0
>  nbd13: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd13: unable to read RDB block 0
>  nbd13: unable to read partition table
> nbd_send_cmd: 5 callbacks suppressed
> block nbd14: Send control failed (result -89)
> nbd_send_cmd: 5 callbacks suppressed
> block nbd14: Request send failed, requeueing
> block nbd14: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd14: unable to read RDB block 0
>  nbd14: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd14: unable to read RDB block 0
>  nbd14: unable to read partition table
> block nbd15: Send control failed (result -89)
> block nbd15: Request send failed, requeueing
> block nbd15: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd15: unable to read RDB block 0
>  nbd15: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd15: unable to read RDB block 0
>  nbd15: unable to read partition table
> block nbd16: Send control failed (result -89)
> block nbd16: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd16: unable to read RDB block 0
>  nbd16: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd16: unable to read RDB block 0
>  nbd16: unable to read partition table
> block nbd17: Send control failed (result -89)
> block nbd17: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd17: unable to read RDB block 0
>  nbd17: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd17: unable to read RDB block 0
>  nbd17: unable to read partition table
> block nbd18: Send control failed (result -89)
> block nbd18: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd18: unable to read RDB block 0
>  nbd18: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd18: unable to read RDB block 0
>  nbd18: unable to read partition table
> block nbd19: Send control failed (result -89)
> block nbd19: Request send failed, requeueing
> block nbd19: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd19: unable to read RDB block 0
>  nbd19: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd19: unable to read RDB block 0
>  nbd19: unable to read partition table
> block nbd20: Send control failed (result -89)
> block nbd20: Request send failed, requeueing
> block nbd20: Dead connection, failed to find a fallback
> blk_print_req_error: 2802 callbacks suppressed
> I/O error, dev nbd20, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> buffer_io_error: 2802 callbacks suppressed
> Buffer I/O error on dev nbd20, logical block 1, async page read
> I/O error, dev nbd20, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 2, async page read
> I/O error, dev nbd20, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 3, async page read
> I/O error, dev nbd20, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 0, async page read
> I/O error, dev nbd20, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 1, async page read
> I/O error, dev nbd20, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 2, async page read
> I/O error, dev nbd20, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 3, async page read
> I/O error, dev nbd20, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 0, async page read
> I/O error, dev nbd20, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio cl=
ass 2
> Buffer I/O error on dev nbd20, logical block 1, async page read
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd20: unable to read RDB block 0
>  nbd20: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd20: unable to read RDB block 0
>  nbd20: unable to read partition table
> block nbd21: Send control failed (result -89)
> block nbd21: Request send failed, requeueing
> block nbd21: Dead connection, failed to find a fallback
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd21: unable to read RDB block 0
>  nbd21: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd21: unable to read RDB block 0
>  nbd21: unable to read partition table
> block nbd22: Send control failed (result -89)
> block nbd22: Request send failed, requeueing
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd22: unable to read RDB block 0
>  nbd22: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd22: unable to read RDB block 0
>  nbd22: unable to read partition table
> block nbd23: Send control failed (result -89)
> block nbd23: Request send failed, requeueing
> block nbd23: Dead connection, failed to find a fallback
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd23: unable to read RDB block 0
>  nbd23: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd23: unable to read RDB block 0
>  nbd23: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd24: unable to read RDB block 0
>  nbd24: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd24: unable to read RDB block 0
>  nbd24: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd25: unable to read RDB block 0
>  nbd25: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd25: unable to read RDB block 0
>  nbd25: unable to read partition table
> block nbd26: Dead connection, failed to find a fallback
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd26: unable to read RDB block 0
>  nbd26: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd26: unable to read RDB block 0
>  nbd26: unable to read partition table
> block nbd27: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd27: unable to read RDB block 0
>  nbd27: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd27: unable to read RDB block 0
>  nbd27: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd28: unable to read RDB block 0
>  nbd28: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd28: unable to read RDB block 0
>  nbd28: unable to read partition table
> block nbd29: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd29: unable to read RDB block 0
>  nbd29: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd29: unable to read RDB block 0
>  nbd29: unable to read partition table
> block nbd30: shutting down sockets
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd30: unable to read RDB block 0
>  nbd30: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd30: unable to read RDB block 0
>  nbd30: unable to read partition table
> ldm_validate_partition_table(): Disk read failed.
> Dev nbd31: unable to read RDB block 0
>  nbd31: unable to read partition table
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Question to NBD maintainers.

What socket types are supposed to be supported by NBD ?

I was thinking adding a list of supported ones, assuming TCP and
stream unix are the only ones:

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0ce..87b0b78249da 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct
nbd_device *nbd, unsigned long fd,
        if (!sock)
                return NULL;

+       if (!sk_is_tcp(sock->sk) &&
+           !sk_is_stream_unix(sock->sk)) {
+               dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
should be TCP or UNIX.\n");
+               *err =3D -EINVAL;
+               sockfd_put(sock);
+               return NULL;
+       }
+
        if (sock->ops->shutdown =3D=3D sock_no_shutdown) {
                dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
shutdown callout must be supported.\n");
                *err =3D -EINVAL;
