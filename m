Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BA1AF0CE
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081383; cv=none; b=SB/GbKw2EwHUuMQa20lRJ0vvNx4VYO0It1Tue2MVV/NtmJaxU13gOdj4RqhGoV+C1pYggAfrPi4Vos1XmuoCAcVwlRiqHraDoxqvpASml5WSi9LwnFF4gmZ6oFKv9+YKJOC/bZ3RjPxhxpAAAWAnKdU82p/R06ULIiccx/OJeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081383; c=relaxed/simple;
	bh=ip1aOB37s918xwl2NQg/BamkEw469vTL6a+KngxUEDQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nQQo7CoXXGp9v/fpGBI4OE+jaY7GGj4DhIro1BiR0jUH3IoTWtRgF1a/hu0JX9h1yBUCF3HOLrn5ogLPft8YmSz+aYSvqnvF6PJO70n9uz8c7XqPnqm0ZhKS1QwYyqzpyvuJX+/9QE6CcQ0I4ElQMMdRDD6/+sXx2CqeOaDSkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so25577535ab.2
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 01:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734081381; x=1734686181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkQu65Oe2VrGr/EpzjzCmzNfFTy9Q2nYTevEyzM7mbo=;
        b=tmtsZGMyW9FgGpK1kuwcmM6XtaAHu8dLgZ/QKGZ0GbRtep3O/cXS9uP3PHsJChJFP+
         tgagwsV/3/+PZOdXYY6ukq0XphJ8l3o18fF5QOQfUxIXq7x2N3PxmY/wQv1kfH2FnUY4
         tgARQGi0dl/4QW3lgTEOMH4abWAWeiy1qL/jjGF0LVaC+u7IBEMDOYLHJRBwogoGwJEP
         2Zys20TwPCZadArtoS0XytoNR32n9K6BwOfTaEbeMahx0UZ7suXtyeRsGjrHXaUJzuX/
         EpFxkNwlZPVVIxUrKAIqEkx8auRPclTephOJvdBmQv6yMEJjqbAj1a/4VdAIEjbn0YFi
         /UOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv6uZKTaq/he7RCCFJMTc40evksJ9zyvfop7ycq9gkwf1FeVB8tUnV5ewlpoRggdzPUKLUhtyLEvBipQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36ORkIq9YG2i7Wtp6bjNdOAV3pc2o+QUK61Yj/z8Ig8d7wrPQ
	0XS/4ADea03hiV+X6Rc1akCRTXFadQ4hWCTJM+jEDMZFW/TbHFEAgQbwmHVTTYZ+4A1v6KpDK2A
	wfi+ObhfPwQVnuymEBRSaNyf/erXa2vwsMXYpV9PTtKGVmMnBw5STrug=
X-Google-Smtp-Source: AGHT+IExhJm+UsGvGT0jkX6/MScYpP4m33bTT558AQtzk2asTxFwMnoVUlTgE2w+pLERmXQl2RxqeHV2GA0veI07pDtO8m0P/3j/
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3aff5397321mr18401995ab.7.1734081381111; Fri, 13 Dec 2024
 01:16:21 -0800 (PST)
Date: Fri, 13 Dec 2024 01:16:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bfb65.050a0220.1a2d0d.0006.GAE@google.com>
Subject: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work
From: syzbot <syzbot+6b0df248918b92c33e6a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7503345ac5f5 Merge tag 'block-6.13-20241207' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15220c0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=6b0df248918b92c33e6a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7503345a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e95a2b302e11/vmlinux-7503345a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e78c0c786fb3/bzImage-7503345a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b0df248918b92c33e6a@syzkaller.appspotmail.com

Bluetooth: hci0: command tx timeout
block nbd0: Receive control failed (result -32)
block nbd0: shutting down sockets
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
BUG: KASAN: slab-use-after-free in recv_work+0x2280/0x25c0 drivers/block/nbd.c:961
Write of size 4 at addr ffff88803e947e78 by task kworker/u5:2/5301

CPU: 0 UID: 0 PID: 5301 Comm: kworker/u5:2 Not tainted 6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: nbd0-recv recv_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
 recv_work+0x2280/0x25c0 drivers/block/nbd.c:961
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5314:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 nbd_alloc_and_init_config+0x88/0x260 drivers/block/nbd.c:1596
 nbd_genl_connect+0xcba/0x1c80 drivers/block/nbd.c:2059
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5301:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 nbd_config_put+0x67d/0x7e0 drivers/block/nbd.c:1386
 recv_work+0x226a/0x25c0 drivers/block/nbd.c:960
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88803e947e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 120 bytes inside of
 freed 256-byte region [ffff88803e947e00, ffff88803e947f00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3e947
ksm flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac41b40 ffffea0000fb95c0 dead000000000003
raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 17751892312, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_noprof+0x2ee/0x4d0 mm/slub.c:4289
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
 v4l2_ctrl_new+0x910/0x1910 drivers/media/v4l2-core/v4l2-ctrls-core.c:1931
 v4l2_ctrl_new_std+0x449/0x5b0 drivers/media/v4l2-core/v4l2-ctrls-core.c:2068
 handler_new_ref+0x1fe/0x940 drivers/media/v4l2-core/v4l2-ctrls-core.c:1689
 v4l2_ctrl_add_handler+0x1a1/0x290 drivers/media/v4l2-core/v4l2-ctrls-core.c:2212
 vivid_create_controls+0x37dd/0x4140 drivers/media/test-drivers/vivid/vivid-ctrls.c:2030
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1931 [inline]
 vivid_probe+0x48ba/0x7cf0 drivers/media/test-drivers/vivid/vivid-core.c:2093
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803e947d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803e947d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803e947e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88803e947e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803e947f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
