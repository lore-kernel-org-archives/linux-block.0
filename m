Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F73D69
	for <linux-block@vger.kernel.org>; Fri, 27 Dec 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735302447; cv=none; b=V+sqMEUOwuWjwsMjLkqDEyKAqImkEarA52LD2RSLsXQWLba4TJjMCX9uf94ZoKbk3eEvM0bULfht4F3txumcrBHKgomRES5D9whLBTqJluBRY5xldKXUYibFvJU+Q0Bl7/4rYA892J5SdaxQjcq11hqGOkMj5pBtTV3jHiNE37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735302447; c=relaxed/simple;
	bh=m3U7k3v2mIemjb2G5EmuZHo2mVVPsYQp5O5BNptJdHY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OaGyZWnExwDpkWUtbQycPabUS/XovTbO6dK0aBCSSnNfEfYEyehq+fMiFn6RL4YE1a4+JfTtu7/cEev4JcIGav37ktqRgJD1H1/5m69jk1YniAlOTHgV5Vk2CHKZlRULse1DnTeJbZj9knHCGU4pm8S8U7tduB2Dnjr4O8jhBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so145635995ab.2
        for <linux-block@vger.kernel.org>; Fri, 27 Dec 2024 04:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735302444; x=1735907244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spltwMUIFe8Famr83y9R3wIi+3K/L4lBJfPgQRazC0c=;
        b=equ5FXxO6a9Y04mFiXgeRGBv4Zc+UeZK2ndifrmuV+YTVLagHlu+c5Adcb0NC4IwSQ
         RbnFB0EqOu6cjmyF0/jDCl+XAv6H6J0HKpl9OzI0sjraflSN2/iQQXjYbXASMlyLHAuQ
         zOdR/ZQiwtR5zKRQBtfGyFVF1LDxu9x7YTWGFqtKDK5AHih8KzvtcvBXkdodkmhdans6
         ER020layP98pfXqvN5yvlyGz/i7drROR7N1qRl28BLhxid++3UZYaZOq7YnZoBNXHzvD
         9cO7sRsrBgd7sIcvqNZXe7AJcsUO1amJlgWeZEN1saE0oXasqSIec6SVmasMNmJAiW7C
         Mzug==
X-Forwarded-Encrypted: i=1; AJvYcCU4TzHpWp+zBKPS1xKzE9WClKVwG1gQyK+uAAguT0CbUkhiIKqnTUNuKPmo/zgVZ2qCUIB3JMdxOisaQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8Mx0OuiRRcMa2kja0OwaVeIg84sJxuklkQIAu546p5vlwsWi
	ExG2nOMctG8Jj7am/CpKvsz3IBCImOW+rjtl0F2XZEg5j9VypYv4+lfAT2s6rOM9RW1qIfOut9h
	UroFQx63GLZWb0B8A7SpT50SNq6H+fZqrwmGPIibsolfwYgqTYGD/UdU=
X-Google-Smtp-Source: AGHT+IHymlpaRP0NceLkUiGJ8Wj3zpLukpul+oeatv2VonFCO8q/OwN8oTHlEwAMcXHHro7j6yjsO7hVF4lPs2kp8exQcH1AyXuk
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3c2d277f709mr207156365ab.7.1735302444780; Fri, 27 Dec 2024
 04:27:24 -0800 (PST)
Date: Fri, 27 Dec 2024 04:27:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676e9d2c.050a0220.226966.0099.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in queue_attr_store
From: syzbot <syzbot+460404a158b0ed7b101c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1572c2f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=460404a158b0ed7b101c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1d66e09941d/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa24ea0a81d/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d9c0b1e880a/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+460404a158b0ed7b101c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0 Not tainted
------------------------------------------------------
syz.0.10692/28990 is trying to acquire lock:
ffff888025545de0 (&q->sysfs_lock){+.+.}-{4:4}, at: queue_attr_store+0xe2/0x170 block/blk-sysfs.c:710

but task is already holding lock:
ffff8880255458b0 (&q->q_usage_counter(io)#10){++++}-{0:0}, at: queue_attr_store+0xd8/0x170 block/blk-sysfs.c:709

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&q->q_usage_counter(io)#10){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       __submit_bio+0x49c/0x540 block/blk-core.c:630
       __submit_bio_noacct block/blk-core.c:678 [inline]
       submit_bio_noacct_nocheck+0x892/0xd70 block/blk-core.c:741
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       mpage_bio_submit_read fs/mpage.c:75 [inline]
       mpage_readahead+0x41d/0x590 fs/mpage.c:377
       read_pages+0x1a8/0xdc0 mm/readahead.c:160
       page_cache_ra_unbounded+0x3dc/0x750 mm/readahead.c:295
       do_page_cache_ra mm/readahead.c:325 [inline]
       page_cache_ra_order+0x8f2/0xc80 mm/readahead.c:524
       page_cache_sync_ra+0x4b4/0x9c0 mm/readahead.c:612
       page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
       filemap_get_pages+0xd7b/0x1be0 mm/filemap.c:2546
       filemap_splice_read+0x5cc/0xd00 mm/filemap.c:2922
       do_splice_read fs/splice.c:985 [inline]
       do_splice_read+0x282/0x370 fs/splice.c:959
       splice_file_to_pipe+0x109/0x120 fs/splice.c:1295
       do_sendfile+0x3fd/0xe30 fs/read_write.c:1369
       __do_sys_sendfile64 fs/read_write.c:1424 [inline]
       __se_sys_sendfile64 fs/read_write.c:1410 [inline]
       __x64_sys_sendfile64+0x1da/0x220 fs/read_write.c:1410
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (mapping.invalidate_lock#2){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x2e0/0x2820 mm/filemap.c:3332
       __do_fault+0x10a/0x490 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing+0xebd/0x3e00 mm/memory.c:3979
       handle_pte_fault mm/memory.c:5801 [inline]
       __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x8d9/0x3b50 mm/gup.c:1494
       populate_vma_page_range+0x27f/0x3a0 mm/gup.c:1932
       __mm_populate+0x1d6/0x380 mm/gup.c:2035
       mm_populate include/linux/mm.h:3396 [inline]
       vm_mmap_pgoff+0x293/0x360 mm/util.c:585
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6751 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6744
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
       sg_ioctl+0x7a3/0x26b0 drivers/scsi/sg.c:1156
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_register_queue+0x13c/0x4f0 block/blk-sysfs.c:774
       add_disk_fwnode+0x785/0x1300 block/genhd.c:493
       add_disk include/linux/blkdev.h:753 [inline]
       brd_alloc.isra.0+0x50a/0x7c0 drivers/block/brd.c:401
       brd_init+0x12b/0x1d0 drivers/block/brd.c:481
       do_one_initcall+0x128/0x630 init/main.c:1266
       do_initcall_level init/main.c:1328 [inline]
       do_initcalls init/main.c:1344 [inline]
       do_basic_setup init/main.c:1363 [inline]
       kernel_init_freeable+0x58f/0x8b0 init/main.c:1577
       kernel_init+0x1c/0x2b0 init/main.c:1466
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->sysfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       queue_attr_store+0xe2/0x170 block/blk-sysfs.c:710
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0x5ae/0x1150 fs/read_write.c:679
       ksys_write+0x12b/0x250 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->sysfs_lock --> mapping.invalidate_lock#2 --> &q->q_usage_counter(io)#10

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#10);
                               lock(mapping.invalidate_lock#2);
                               lock(&q->q_usage_counter(io)#10);
  lock(&q->sysfs_lock);

 *** DEADLOCK ***

6 locks held by syz.0.10692/28990:
 #0: ffff888034909978 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88803584c420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888060eec088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #3: ffff888142bf6878 (kn->active#462){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #4: ffff8880255458b0 (&q->q_usage_counter(io)#10){++++}-{0:0}, at: queue_attr_store+0xd8/0x170 block/blk-sysfs.c:709
 #5: ffff8880255458e8 (&q->q_usage_counter(queue)#58){+.+.}-{0:0}, at: queue_attr_store+0xd8/0x170 block/blk-sysfs.c:709

stack backtrace:
CPU: 0 UID: 0 PID: 28990 Comm: syz.0.10692 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
 queue_attr_store+0xe2/0x170 block/blk-sysfs.c:710
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60d2585d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60d344c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f60d2775fa0 RCX: 00007f60d2585d29
RDX: 000000000000fdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f60d2601aa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f60d2775fa0 R15: 00007ffd41a4b118
 </TASK>


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
