Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB721C84C4
	for <linux-block@vger.kernel.org>; Sat, 14 Jun 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749922052; cv=none; b=i6R3oPLU0aZxEMDwVZchuJTaWHuvoY8UxeFZrYtZatqEUmoWYyjyzcfnScQ6oshxlFuI+Eyv1lb206jtqJkXKqYBanh14ZAmLNnLzcK6RgDsweV2Qb43QcMxkfgRbMDDyxNuyDRA6dRNxH1hn7nltctSPx9njR3rAFVV7foDHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749922052; c=relaxed/simple;
	bh=OMV+dj18jJuR59ozeFXeVREZP5IeqWoSo3IVpvbsY5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F46hazktnqE95AajGq23X7fgPxLHjY1x83+CUZb8JjyPlYbJJM6rWLuwoWJn6hZ8EopYdgbSjxaa4bLGrFP7MfiASwXmM8+E5HelOdOTTPUw5IVoent6L/xPWulnd2mYDuCQ3aCsL8hM/ORu838MGJ7jq6ISapurdd3w5Grv7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86d126265baso292926739f.0
        for <linux-block@vger.kernel.org>; Sat, 14 Jun 2025 10:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749922049; x=1750526849;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxQK89TiP52wIVVgAlIDZlErZzGp2qYEW4rabAFXJbI=;
        b=YSS0vBFjm44jfjurkNagLSA8J+mg62Jr7lJdwe8XKGmn5SkKTFo3qqt9xmk+T01vjE
         Ba1KDG5JYtmahPyPM9wr3JgkXFMh3OEBIjwwa9qhsFQGAR7IiMPkFuMSIOswBw+YZYg7
         RLFc2rK+Mcm04k71UC/c40ocRz6tKiZus5uW53RI7CiJHU2Y2CtPJRDf09U+jJpYBPhX
         EVySOBmTHSrngfnndD80srytH8+RKv5KJs0QsCmiu5cT+hLxTxPEKiNENgl4gn2La5cg
         ixP04ZXVs70iJnLbHoKLH6001UMHmgiWmL0PZ0R98g/TLsCQYZvWIEkC4oq1UNS4FzTo
         akNg==
X-Forwarded-Encrypted: i=1; AJvYcCX+O36tLRHVscSGtS9ffjiwBf5UiBMpTKNBF8w7mvIKuGcWaHdIwNuE3jkov2WCPobyBxpwuCPl5qHLcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQ4qfCeoBOmsIGyAxCKPg6xFCvjUnC2SXB/aX/XgFj7pbz7Tk
	nVnqGUesZAJKAU4skFCclkpZJg/719XTV7gdKG+9jlj0Tx1zc6g7O3evl7I73bmEtaRF5S8YNSf
	VC55LTnoIpYtbMd6ZcAKYSHRwofpge3XvX+Brecri+y10B8c7bGodGYASXBo=
X-Google-Smtp-Source: AGHT+IFfkrbvL5AxMNCVMPBQzvcO3UUWBTuXuCQUOeRwmsLZFYW/I8KL4fnDlCAntNCUvbDb/szV/lgVQfjH29uZxuy4qr+8Y8My
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b70e:0:b0:3dd:bfba:ff9c with SMTP id
 e9e14a558f8ab-3de07d686f0mr29705265ab.11.1749922049441; Sat, 14 Jun 2025
 10:27:29 -0700 (PDT)
Date: Sat, 14 Jun 2025 10:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684db101.a00a0220.279073.0020.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in pcpu_alloc_noprof (2)
From: syzbot <syzbot+91771b3fb86ec2dd7227@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f09079bd04a9 Merge tag 'powerpc-6.16-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127be9d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e24211089078d6c6
dashboard link: https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c9260c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11decd70580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f09079bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef68cb3d29a3/vmlinux-f09079bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1cc9431b9a15/bzImage-f09079bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91771b3fb86ec2dd7227@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc1-syzkaller-00003-gf09079bd04a9 #0 Not tainted
------------------------------------------------------
syz-executor187/5931 is trying to acquire lock:
ffffffff8e72fa68 (pcpu_alloc_mutex){+.+.}-{4:4}, at: pcpu_alloc_noprof+0xb4c/0x1470 mm/percpu.c:1782

but task is already holding lock:
ffff888027d9c520 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave block/blk-mq.c:205 [inline]
ffff888027d9c520 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4993 [inline]
ffff888027d9c520 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_update_nr_hw_queues+0x275/0xcb0 block/blk-mq.c:5043

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x175/0x290 block/blk-mq.c:4396
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4443
       nbd_dev_add+0x4a0/0xbc0 drivers/block/nbd.c:1933
       nbd_init+0x181/0x320 drivers/block/nbd.c:2670
       do_one_initcall+0x120/0x6e0 init/main.c:1273
       do_initcall_level init/main.c:1335 [inline]
       do_initcalls init/main.c:1351 [inline]
       do_basic_setup init/main.c:1370 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1583
       kernel_init+0x1c/0x2b0 init/main.c:1473
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4045 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4059
       might_alloc include/linux/sched/mm.h:318 [inline]
       prepare_alloc_pages+0x162/0x610 mm/page_alloc.c:4727
       __alloc_frozen_pages_noprof+0x18b/0x23f0 mm/page_alloc.c:4948
       __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:4993
       __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
       alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
       pcpu_alloc_pages mm/percpu-vm.c:95 [inline]
       pcpu_populate_chunk+0x110/0xb00 mm/percpu-vm.c:285
       pcpu_alloc_noprof+0x86a/0x1470 mm/percpu.c:1870
       iommu_dma_init_fq_percpu drivers/iommu/dma-iommu.c:320 [inline]
       iommu_dma_init_fq+0x202/0x8a0 drivers/iommu/dma-iommu.c:346
       iommu_dma_init_domain drivers/iommu/dma-iommu.c:709 [inline]
       iommu_setup_dma_ops+0x1336/0x1700 drivers/iommu/dma-iommu.c:2106
       bus_iommu_probe+0x23e/0x530 drivers/iommu/iommu.c:1911
       iommu_device_register+0x1af/0x280 drivers/iommu/iommu.c:277
       intel_iommu_init+0x25e7/0x3780 drivers/iommu/intel/iommu.c:3143
       pci_iommu_init+0x2e/0x90 arch/x86/kernel/pci-dma.c:174
       do_one_initcall+0x120/0x6e0 init/main.c:1273
       do_initcall_level init/main.c:1335 [inline]
       do_initcalls init/main.c:1351 [inline]
       do_basic_setup init/main.c:1370 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1583
       kernel_init+0x1c/0x2b0 init/main.c:1473
       ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       pcpu_alloc_noprof+0xb4c/0x1470 mm/percpu.c:1782
       init_alloc_hint lib/sbitmap.c:16 [inline]
       sbitmap_init_node+0x2fd/0x770 lib/sbitmap.c:126
       sbitmap_queue_init_node+0x41/0x560 lib/sbitmap.c:438
       bt_alloc block/blk-mq-tag.c:542 [inline]
       blk_mq_init_tags+0x12d/0x2b0 block/blk-mq-tag.c:565
       blk_mq_alloc_rq_map block/blk-mq.c:3538 [inline]
       blk_mq_alloc_map_and_rqs+0x237/0xf60 block/blk-mq.c:4094
       __blk_mq_alloc_map_and_rqs block/blk-mq.c:4116 [inline]
       __blk_mq_alloc_map_and_rqs+0x128/0x1f0 block/blk-mq.c:4107
       blk_mq_realloc_tag_set_tags block/blk-mq.c:4755 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:4995 [inline]
       blk_mq_update_nr_hw_queues+0x4ab/0xcb0 block/blk-mq.c:5043
       nbd_start_device+0x172/0xcd0 drivers/block/nbd.c:1476
       nbd_genl_connect+0x120e/0x1c20 drivers/block/nbd.c:2201
       genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg net/socket.c:727 [inline]
       ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
       __sys_sendmsg+0x16d/0x220 net/socket.c:2652
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  pcpu_alloc_mutex --> fs_reclaim --> &q->q_usage_counter(io)#49

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#49);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#49);
  lock(pcpu_alloc_mutex);

 *** DEADLOCK ***

7 locks held by syz-executor187/5931:
 #0: ffffffff903f1390 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff903f1448 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff903f1448 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff903f1448 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff903f1448 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x577/0x800 net/netlink/genetlink.c:1209
 #2: ffff888027e74230 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_genl_connect+0xa1a/0x1c20 drivers/block/nbd.c:2111
 #3: ffff888027e74188 (&set->update_nr_hwq_lock){++++}-{4:4}, at: blk_mq_update_nr_hw_queues+0x32/0xcb0 block/blk-mq.c:5041
 #4: ffff888027e740d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x45/0xcb0 block/blk-mq.c:5042
 #5: ffff888027d9c520 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave block/blk-mq.c:205 [inline]
 #5: ffff888027d9c520 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4993 [inline]
 #5: ffff888027d9c520 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_update_nr_hw_queues+0x275/0xcb0 block/blk-mq.c:5043
 #6: ffff888027d9c558 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave block/blk-mq.c:205 [inline]
 #6: ffff888027d9c558 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4993 [inline]
 #6: ffff888027d9c558 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_update_nr_hw_queues+0x275/0xcb0 block/blk-mq.c:5043

stack backtrace:
CPU: 0 UID: 0 PID: 5931 Comm: syz-executor187 Not tainted 6.16.0-rc1-syzkaller-00003-gf09079bd04a9 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
 pcpu_alloc_noprof+0xb4c/0x1470 mm/percpu.c:1782
 init_alloc_hint lib/sbitmap.c:16 [inline]
 sbitmap_init_node+0x2fd/0x770 lib/sbitmap.c:126
 sbitmap_queue_init_node+0x41/0x560 lib/sbitmap.c:438
 bt_alloc block/blk-mq-tag.c:542 [inline]
 blk_mq_init_tags+0x12d/0x2b0 block/blk-mq-tag.c:565
 blk_mq_alloc_rq_map block/blk-mq.c:3538 [inline]
 blk_mq_alloc_map_and_rqs+0x237/0xf60 block/blk-mq.c:4094
 __blk_mq_alloc_map_and_rqs block/blk-mq.c:4116 [inline]
 __blk_mq_alloc_map_and_rqs+0x128/0x1f0 block/blk-mq.c:4107
 blk_mq_realloc_tag_set_tags block/blk-mq.c:4755 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4995 [inline]
 blk_mq_update_nr_hw_queues+0x4ab/0xcb0 block/blk-mq.c:5043
 nbd_start_device+0x172/0xcd0 drivers/block/nbd.c:1476
 nbd_genl_connect+0x120e/0x1c20 drivers/block/nbd.c:2201
 genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf950b9499
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9e5881a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff9e588378 RCX: 00007fbf950b9499
RDX: 0000000000000040 RSI: 0000200000000980 RDI: 0000000000000003
RBP: 00007fbf9512c610 R08: 0000000000000005 R09: 00007fff9e588378
R10: 000000000000000c R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff9e588368 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
nbd0: detected capacity change from 0 to 2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
