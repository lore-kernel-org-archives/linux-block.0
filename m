Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16484501F59
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560613; cv=none; b=NuKWaMTwCQfx6HlIm2zZhJ6WBD0olTBooi1PFWaBd45rjQM3sHg1qCnTLNh9GyGgGbudvCrDOaaFyO12k4RIiYV8FmuofwkFks42YpUVUmrSv5zkbZ7h34xJUCfOZPgdZo6v3C4eCwSLm1p5DCY1VprHubxh2ft5bWdxgF5wrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560613; c=relaxed/simple;
	bh=blQx9O2GljPiDvE4oHqZaB4Q9lTVaxFla5bbqWs8PaQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d693149TnaLmUn0bWECmBSJch50RWV9F1GWhFRs+sWSNNib0WDCgMc/H9Xb/nFslk8XIBo9P3kgzzI1ieFuqTrgc4CqgqJotposDJ5KCD82urCIzgAWktLRmKAnE+kInhkC04ivD4tRpM1LZJyIC5xRRhLaPEIi8H/Smx2ZVfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b128c3af4bso149685eaf.0
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 15:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560608; x=1789165408;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxZDoFRvVAvGWSm+Ntioz7anQi0nXepD82NI5Zzbt8s=;
        b=rVx057GfEhAGEEY1eAHibQs+rT0+LpMH0UgBr3N9/Oe5vaHtKgP2nKQm/dmeq9gWF6
         7DpogFNIJJABRxuZD0I0CofvA+A3iNVzGbaRBQWeRoTfUByzDm2fHwx1/tXcrQrOOsbn
         CA0JweIGuaBNU34/ktSjLY5JUrco6xe1tkodPDUQQhpspkbx7+9Ge3epqFlmb+HhGMfV
         2LTXoLf2ob6LhrnqLeSSCbCn2EcfAAuVxcG/gfRV1G9mzepT5T/yfTrVHyc3DbKt4utd
         PCnKYlyU3BNdyxblHMAjI1TZHVMLm01KeP/NEEZBsr0rejV5+lMLf8ZFEoJnJVVcGk9x
         OpRw==
X-Gm-Message-State: AFuF++m4yzsVikeOUB8uK07VIYdI/Ee70ViOozQLZAIfMGjwImiFp4LA
	3Yx4ae3dUCGVQ5L0s/qyycs2lAtQWwWsp7dMOo3AO43lSxEeRkMWeRTkR5i8+dPaHXvTRYex2WZ
	kuAIUMCjGCSh5McRvYN9wCgULaTlwxNwDw5hGrp1OTPPRqOrxaUjo2YN/PAfPEA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:820:b0:6b7:8396:f3c1 with SMTP id
 006d021491bc7-6b78396f863mr3577644eaf.35.1788560608197; Fri, 04 Sep 2026
 15:23:28 -0700 (PDT)
Date: Fri, 04 Sep 2026 15:23:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9b44e0.a5e650b3.363816.0002.GAE@google.com>
Subject: [syzbot] [block?] BUG: sleeping function called from invalid context
 in null_insert_page
From: syzbot <syzbot+95fdab36405e5ffdb680@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17b7e779580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=95fdab36405e5ffdb680
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/disk-f1b8fa82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmlinux-f1b8fa82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396/Image-f1b8fa82.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95fdab36405e5ffdb680@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 8414, name: syz.7.670
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
1 lock held by syz.7.670/8414:
 #0: ffff800088d271a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff800088d271a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff800088d271a0 (rcu_read_lock){....}-{1:3}, at: blk_mq_dispatch_queue_requests+0x110/0x6d4 block/blk-mq.c:2872
CPU: 0 UID: 0 PID: 8414 Comm: syz.7.670 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x354/0x4c0 kernel/sched/core.c:9197
 __might_sleep+0x84/0xdc kernel/sched/core.c:9126
 might_alloc include/linux/sched/mm.h:323 [inline]
 slab_pre_alloc_hook mm/slub.c:4537 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __kmalloc_cache_noprof+0x88/0x5ec mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 null_alloc_page drivers/block/null_blk/main.c:870 [inline]
 null_insert_page+0x94/0x4e8 drivers/block/null_blk/main.c:1019
 copy_to_nullb drivers/block/null_blk/main.c:1157 [inline]
 null_transfer drivers/block/null_blk/main.c:1271 [inline]
 null_handle_data_transfer drivers/block/null_blk/main.c:1300 [inline]
 null_handle_memory_backed+0x474/0x9d8 drivers/block/null_blk/main.c:1380
 null_process_cmd+0x118/0x1b0 drivers/block/null_blk/main.c:1434
 null_handle_cmd drivers/block/null_blk/main.c:1457 [inline]
 null_queue_rq+0x788/0xa88 drivers/block/null_blk/main.c:1703
 null_queue_rqs+0x108/0x204 drivers/block/null_blk/main.c:1717
 __blk_mq_flush_list block/blk-mq.c:2827 [inline]
 blk_mq_dispatch_queue_requests+0x33c/0x6d4 block/blk-mq.c:2872
 blk_mq_flush_plug_list+0x37c/0x494 block/blk-mq.c:2960
 __blk_flush_plug+0x364/0x440 block/blk-core.c:1266
 blk_finish_plug+0x68/0x90 block/blk-core.c:1293
 blkdev_writepages+0x128/0x184 block/fops.c:486
 do_writepages+0x284/0x47c mm/page-writeback.c:2571
 filemap_writeback+0x230/0x2bc mm/filemap.c:387
 filemap_fdatawrite_range mm/filemap.c:412 [inline]
 filemap_write_and_wait_range+0x90/0x114 mm/filemap.c:684
 filemap_write_and_wait include/linux/pagemap.h:65 [inline]
 sync_blockdev block/bdev.c:276 [inline]
 bdev_release+0x114/0x328 block/bdev.c:1129
 blkdev_release+0x20/0x34 block/fops.c:680
 __fput+0x338/0x74c fs/file_table.c:512
 fput_close_sync+0x10c/0x278 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __arm64_sys_close+0x80/0x110 fs/open.c:1496
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590


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
