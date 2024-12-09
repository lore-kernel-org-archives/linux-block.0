Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13341714D3
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771960; cv=none; b=TNl5TIPZbjznrMs+8XcM2o5FnfMtnFV41YAbEtFW94wJ8axMq1srEwqPhlQKRNBKc+ets+/PfC69CSsrlOx1fx3D7DyYH9va9p7GTGRECPPTYaY4jsHc3zaeigY45FCfNHhfwgb8Rr3w8L/y3Ud7XsJriaLFqjXPkH5oD/e2T70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771960; c=relaxed/simple;
	bh=N38Fkbwg9qaJGf0cuU/ek7sBYk2FS1t9Y9jzvpmL3o4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sLdrq9z3hEKXZPqJF61MoiopgA8LgE5t5nD5BO90m6KE6gxNDLtE1+m4Bh1Kch/3T2uNdyP9hOGJJQ+tIx4ot7z0cGlcVuHRMtdp2/669Ui5B907+VB1nf93fAdbdZcHXrDI4lr6+G93Lvm/YRcSk3z7emP67HbOQIvQdORAPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8419946e077so859948139f.2
        for <linux-block@vger.kernel.org>; Mon, 09 Dec 2024 11:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733771958; x=1734376758;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wft2Tg1XA04274PBVQs7lPyFDzeawcuLc/VvBPMb08U=;
        b=wzJzWOcsuk2VO4OQ62Nhdjt94TojgQbrEy8vvQ6TzGHxCfd9ar+d91HH6BqaoSisq1
         n6My60g0o6biauiliyXGNBBcMfBg1hQfRflx3KkMtKm6FS2PqK6zVkFb4G+Zupx57hiJ
         obI2jXvfyTHN7gTkYeJf/OybVAI8HCBO7PUpirwxZbe8/1yM9utDnhvtlsF8eCt0XNBO
         rS+QyVnEMSn8EebdkXrJa3LcR44/ybtreN3OYNwq1XxmR3jNlze54Ewq9TSn1eguZcpL
         8negsiclU7+2DgOWUHIcjSpqTYpRdVkgZ/kOVlq4DN/L3g39S94xYqDPj3m8XnxV5irw
         SCxw==
X-Forwarded-Encrypted: i=1; AJvYcCUNyiWJymPTLwgVZfxZ01bjAesGbirp1xcdjpDBowlVK157E4h6stPIdQBKTkgoquiw8deHxMZOqYlHkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8UaNnoUE9nLnO0HHfZu0QnDVTBuGv8uPsIRlfIcSsltyv2mN
	Ja+WQW7aR3CviI2GcBEIciacfsrA5+HLPSaamPw6ts9/sBBhD643YSoG50pKPKI1F+63MHh9yVF
	dmUeIEN0cMGKu3fLLe/WKHx6vh/l7bWVzgQYHtyQ6ACHPOxA5L4TmNZM=
X-Google-Smtp-Source: AGHT+IGzOOxlnjW9n79nWfN3VSTgBHZ+l37/QWJum3TWsAZcJaw2WYfAAx+DwgU55dKOii16g2hRUXnIQYgCf1pVdk3DtufSxa8R
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3cd:b0:843:ec18:82e2 with SMTP id
 ca18e2360f4ac-844b519864fmr228805039f.8.1733771957897; Mon, 09 Dec 2024
 11:19:17 -0800 (PST)
Date: Mon, 09 Dec 2024 11:19:17 -0800
In-Reply-To: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675742b5.050a0220.2477f.0054.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
From: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
To: axboe@kernel.dk, boqun.feng@gmail.com, hdanton@sina.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fac04efc5c79 Linux 6.13-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=100313e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=696fb014d05da3a3
dashboard link: https://syzkaller.appspot.com/bug?extid=5218c85078236fc46227
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147528f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d219b605f6a9/disk-fac04efc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06776a2c689e/vmlinux-fac04efc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ab42bd03182/Image-fac04efc.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c3180abcd8eb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5218c85078236fc46227@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-gfac04efc5c79 #0 Not tainted
------------------------------------------------------
syz.0.15/6643 is trying to acquire lock:
ffff0000c9f19de8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: bio_queue_enter block/blk.h:79 [inline]
ffff0000c9f19de8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_submit_bio+0x11c8/0x2070 block/blk-mq.c:3092

but task is already holding lock:
ffff0000e7fcc0b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x144/0x1bc fs/hfsplus/bfind.c:28

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&tree->tree_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x218/0x28f4 kernel/locking/mutex.c:585
       __mutex_lock kernel/locking/mutex.c:735 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:787
       hfsplus_find_init+0x144/0x1bc fs/hfsplus/bfind.c:28
       hfsplus_cat_write_inode+0x1a4/0xd48 fs/hfsplus/inode.c:589
       hfsplus_write_inode+0x15c/0x4dc fs/hfsplus/super.c:161
       write_inode fs/fs-writeback.c:1525 [inline]
       __writeback_single_inode+0x5a0/0x15a4 fs/fs-writeback.c:1745
       writeback_single_inode+0x18c/0x554 fs/fs-writeback.c:1801
       sync_inode_metadata+0xc4/0x12c fs/fs-writeback.c:2871
       hfsplus_file_fsync+0xe4/0x4c8 fs/hfsplus/inode.c:316
       vfs_fsync_range fs/sync.c:187 [inline]
       vfs_fsync+0x154/0x18c fs/sync.c:201
       __loop_update_dio+0x248/0x420 drivers/block/loop.c:204
       loop_set_status+0x538/0x7f4 drivers/block/loop.c:1289
       lo_ioctl+0xf10/0x1c48
       blkdev_ioctl+0x3a8/0xa8c block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #1 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       hfsplus_file_fsync+0xd8/0x4c8 fs/hfsplus/inode.c:311
       vfs_fsync_range fs/sync.c:187 [inline]
       vfs_fsync+0x154/0x18c fs/sync.c:201
       __loop_update_dio+0x248/0x420 drivers/block/loop.c:204
       loop_set_status+0x538/0x7f4 drivers/block/loop.c:1289
       lo_ioctl+0xf10/0x1c48
       blkdev_ioctl+0x3a8/0xa8c block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #0 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x34f0/0x7904 kernel/locking/lockdep.c:5226
       lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
       __bio_queue_enter+0x4dc/0x5b0 block/blk-core.c:361
       bio_queue_enter block/blk.h:79 [inline]
       blk_mq_submit_bio+0x11c8/0x2070 block/blk-mq.c:3092
       __submit_bio+0x1a0/0x4f8 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x3bc/0xcbc block/blk-core.c:739
       submit_bio_noacct+0xc6c/0x166c block/blk-core.c:868
       submit_bio+0x374/0x564 block/blk-core.c:910
       submit_bh_wbc+0x3f8/0x4c8 fs/buffer.c:2814
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x7ac/0x914 fs/buffer.c:2446
       hfsplus_read_folio+0x28/0x38 fs/hfsplus/inode.c:28
       filemap_read_folio+0x108/0x318 mm/filemap.c:2366
       do_read_cache_folio+0x368/0x5c0 mm/filemap.c:3826
       do_read_cache_page mm/filemap.c:3892 [inline]
       read_cache_page+0x6c/0x15c mm/filemap.c:3901
       read_mapping_page include/linux/pagemap.h:1005 [inline]
       __hfs_bnode_create+0x3dc/0x6d4 fs/hfsplus/bnode.c:440
       hfsplus_bnode_find+0x200/0xe60 fs/hfsplus/bnode.c:486
       hfsplus_brec_find+0x134/0x4a0 fs/hfsplus/bfind.c:172
       hfsplus_brec_read+0x38/0x128 fs/hfsplus/bfind.c:211
       hfsplus_find_cat+0x140/0x4a0 fs/hfsplus/catalog.c:202
       hfsplus_iget+0x34c/0x584 fs/hfsplus/super.c:83
       hfsplus_fill_super+0xa5c/0x16f8 fs/hfsplus/super.c:504
       get_tree_bdev_flags+0x38c/0x494 fs/super.c:1636
       get_tree_bdev+0x2c/0x3c fs/super.c:1659
       hfsplus_get_tree+0x28/0x38 fs/hfsplus/super.c:640
       vfs_get_tree+0x90/0x28c fs/super.c:1814
       do_new_mount+0x278/0x900 fs/namespace.c:3507
       path_mount+0x590/0xe04 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount fs/namespace.c:4034 [inline]
       __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

other info that might help us debug this:

Chain exists of:
  &q->q_usage_counter(io)#17 --> &sb->s_type->i_mutex_key#20 --> &tree->tree_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock);
                               lock(&sb->s_type->i_mutex_key#20);
                               lock(&tree->tree_lock);
  rlock(&q->q_usage_counter(io)#17);

 *** DEADLOCK ***

2 locks held by syz.0.15/6643:
 #0: ffff0000e90420e0 (&type->s_umount_key#51/1){+.+.}-{4:4}, at: alloc_super+0x1b0/0x834 fs/super.c:344
 #1: ffff0000e7fcc0b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x144/0x1bc fs/hfsplus/bfind.c:28

stack backtrace:
CPU: 0 UID: 0 PID: 6643 Comm: syz.0.15 Not tainted 6.13.0-rc2-syzkaller-gfac04efc5c79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:484 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x154/0x1c0 kernel/locking/lockdep.c:2074
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x34f0/0x7904 kernel/locking/lockdep.c:5226
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5849
 __bio_queue_enter+0x4dc/0x5b0 block/blk-core.c:361
 bio_queue_enter block/blk.h:79 [inline]
 blk_mq_submit_bio+0x11c8/0x2070 block/blk-mq.c:3092
 __submit_bio+0x1a0/0x4f8 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x3bc/0xcbc block/blk-core.c:739
 submit_bio_noacct+0xc6c/0x166c block/blk-core.c:868
 submit_bio+0x374/0x564 block/blk-core.c:910
 submit_bh_wbc+0x3f8/0x4c8 fs/buffer.c:2814
 submit_bh fs/buffer.c:2819 [inline]
 block_read_full_folio+0x7ac/0x914 fs/buffer.c:2446
 hfsplus_read_folio+0x28/0x38 fs/hfsplus/inode.c:28
 filemap_read_folio+0x108/0x318 mm/filemap.c:2366
 do_read_cache_folio+0x368/0x5c0 mm/filemap.c:3826
 do_read_cache_page mm/filemap.c:3892 [inline]
 read_cache_page+0x6c/0x15c mm/filemap.c:3901
 read_mapping_page include/linux/pagemap.h:1005 [inline]
 __hfs_bnode_create+0x3dc/0x6d4 fs/hfsplus/bnode.c:440
 hfsplus_bnode_find+0x200/0xe60 fs/hfsplus/bnode.c:486
 hfsplus_brec_find+0x134/0x4a0 fs/hfsplus/bfind.c:172
 hfsplus_brec_read+0x38/0x128 fs/hfsplus/bfind.c:211
 hfsplus_find_cat+0x140/0x4a0 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x34c/0x584 fs/hfsplus/super.c:83
 hfsplus_fill_super+0xa5c/0x16f8 fs/hfsplus/super.c:504
 get_tree_bdev_flags+0x38c/0x494 fs/super.c:1636
 get_tree_bdev+0x2c/0x3c fs/super.c:1659
 hfsplus_get_tree+0x28/0x38 fs/hfsplus/super.c:640
 vfs_get_tree+0x90/0x28c fs/super.c:1814
 do_new_mount+0x278/0x900 fs/namespace.c:3507
 path_mount+0x590/0xe04 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
syz.0.15: attempt to access beyond end of device
loop0: rw=0, sector=208, nr_sectors = 2 limit=3
Buffer I/O error on dev loop0, logical block 104, async page read
syz.0.15: attempt to access beyond end of device
loop0: rw=0, sector=210, nr_sectors = 2 limit=3
Buffer I/O error on dev loop0, logical block 105, async page read
syz.0.15: attempt to access beyond end of device
loop0: rw=0, sector=212, nr_sectors = 2 limit=3
Buffer I/O error on dev loop0, logical block 106, async page read
hfsplus: failed to load root directory


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
