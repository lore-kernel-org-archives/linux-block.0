Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391F35675A
	for <linux-block@vger.kernel.org>; Sat,  1 Aug 2026 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543872; cv=none; b=Ps2o4wre5mQpi7oQurRTrlfh8vR3TgN22kg5gsC11TA1Y3/eIf29Eiz3beE2ylGCO6MMpbMGWDU0qyFrZTDTSK1cWG5dOo9UbvzrKRpmh40za1jMT+wkDXH3J8p4aTQv9KaL2E6b+1+Od01a/2kfTcpEHzXF+EoSsdYaCjxJolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543872; c=relaxed/simple;
	bh=Jm4C9eVzYuv16vfPGCDDQrJ1YLAJqJrglveQILuUms4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oaozEe20NG+nyEFYSfgMyyk5uf5Zg5g2PmtWjJrTEDvif+5t+OMYoTvZ/BiI99Gjd2JpH55gF7sOjhSFmAJpw/G/ZZNyMh7seVxZDLadf7+Am4EIcJS+JMJ5Lm1OcDnkhrAnFcR9d9bTz7LFrq9q//BHawTZUHqEpGMS3+ZxHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49ab6a82cd5so1866484b6e.2
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 17:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785543869; x=1786148669;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXu+HIbdRObJDsHG03Ki649MFVi2v8Dtik0IqjR6sN8=;
        b=Pgu7oF8k3m8YglbylbKfjmlPaqvgR/pCm2y69JONOQdKB2qo5gnQnNSXyqV/8sYj9F
         BaOrKVmUesLLXtmfmS1TveWltVThxceH/qJnawtiBdyWmQBI74on9FqmdEknTgkFweYa
         UxDLbZfMcJ/1FeqOQPOEEpTcvZJ0L5ZEz5DE9Ot1IZ23FuKX0KTIVWBoV60Uy0ym58EB
         g/vrhU09m5TuKmcx1b0/lWEoidFR/CIUt/G3jofNsdzd5z0NOdzJ79JLrcrmeTfG14sK
         vpsI8Qnf9FSuTXF45GTrLuQVD80flARre0Ok0e9UNJ0Dp+f+GWT4TlwjpPjh24oyLk9b
         W76g==
X-Forwarded-Encrypted: i=1; AHgh+RqPvjH7zIXOYzuMMxLwFZ9ODcIq6LL+PuCdgGfNOmytzM1NiDw7K1yWNi8U9xZDlnGgw/iX6V9BOnc1UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo69G64zZscFgrVkmbax/mQ42HIuqvkoT8IEzA3692r42nM/ye
	xdE89fe+R2Hhb+l0WLrsYkR6WTfl+SmvNsnQj+w9hF6h29Q3XeEXuJ9oXbthA/syndQSeMcRt9a
	UV7dDRiuHAgA/urHVRFx3yWRYGaCNjzQ6NfByTBOkFmrWkp8+iBuOfg0y7VE=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:244f:b0:4a4:9e18:607a with SMTP id
 5614622812f47-4af5e3d7eeemr3701046b6e.21.1785543869549; Fri, 31 Jul 2026
 17:24:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:24:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d3cbd.6ce73036.24301b.000d.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_probe_dev
From: syzbot <syzbot+68e1f51046d68329940f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62cc90241548 Merge tag 'mm-hotfixes-stable-2026-07-27-14-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1715249e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7079b368dcec295
dashboard link: https://syzkaller.appspot.com/bug?extid=68e1f51046d68329940f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d08b858b4e9/disk-62cc9024.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85154cc68abb/vmlinux-62cc9024.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7121b8e9e61/bzImage-62cc9024.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68e1f51046d68329940f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.9.2723/18830 is trying to acquire lock:
ffffffff8f793ce0 (major_names_lock){+.+.}-{4:4}, at: blk_probe_dev+0x28/0x1e0 block/genhd.c:877

but task is already holding lock:
ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: mddev_lock drivers/md/md.h:714 [inline]
ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: mddev_suspend_and_lock drivers/md/md.h:1012 [inline]
ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: mddev_suspend_and_lock drivers/md/md.h:1004 [inline]
ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: md_ioctl+0x112d/0x36b0 drivers/md/md.c:8378

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mddev->reconfig_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       mddev_lock_nointr drivers/md/md.h:735 [inline]
       md_start_sync+0x79/0xbe0 drivers/md/md.c:10190
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 ((work_completion)(&mddev->sync_work)){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       process_one_work+0x98e/0x1940 kernel/workqueue.c:3298
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 ((wq_completion)md_misc){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       touch_wq_lockdep_map+0xad/0x1c0 kernel/workqueue.c:4037
       __flush_workqueue+0x131/0x1200 kernel/workqueue.c:4079
       md_alloc+0x30/0x10a0 drivers/md/md.c:6313
       md_alloc_and_put drivers/md/md.c:6402 [inline]
       md_probe drivers/md/md.c:6418 [inline]
       md_probe+0x73/0xf0 drivers/md/md.c:6413
       blk_probe_dev+0x149/0x1e0 block/genhd.c:880
       blk_request_module+0x16/0xc0 block/genhd.c:893
       blkdev_get_no_open+0x9b/0xf0 block/bdev.c:828
       blkdev_open+0x141/0x4f0 block/fops.c:663
       do_dentry_open+0x6ab/0x14d0 fs/open.c:947
       vfs_open+0x82/0x3f0 fs/open.c:1052
       do_open fs/namei.c:4700 [inline]
       path_openat+0x2873/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (major_names_lock){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       blk_probe_dev+0x28/0x1e0 block/genhd.c:877
       blk_request_module+0x16/0xc0 block/genhd.c:893
       blkdev_get_no_open+0x9b/0xf0 block/bdev.c:828
       bdev_file_open_by_dev block/bdev.c:1049 [inline]
       bdev_file_open_by_dev+0x70/0x210 block/bdev.c:1037
       md_import_device+0x120/0x360 drivers/md/md.c:3845
       md_add_new_disk+0xcc0/0x1820 drivers/md/md.c:7530
       md_ioctl+0x2b28/0x36b0 drivers/md/md.c:8476
       blkdev_ioctl+0x5ad/0x6f0 block/ioctl.c:797
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  major_names_lock --> (work_completion)(&mddev->sync_work) --> &mddev->reconfig_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mddev->reconfig_mutex);
                               lock((work_completion)(&mddev->sync_work));
                               lock(&mddev->reconfig_mutex);
  lock(major_names_lock);

 *** DEADLOCK ***

1 lock held by syz.9.2723/18830:
 #0: ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: mddev_lock drivers/md/md.h:714 [inline]
 #0: ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: mddev_suspend_and_lock drivers/md/md.h:1012 [inline]
 #0: ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: mddev_suspend_and_lock drivers/md/md.h:1004 [inline]
 #0: ffff888050068358 (&mddev->reconfig_mutex){+.+.}-{4:4}, at: md_ioctl+0x112d/0x36b0 drivers/md/md.c:8378

stack backtrace:
CPU: 0 UID: 0 PID: 18830 Comm: syz.9.2723 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 blk_probe_dev+0x28/0x1e0 block/genhd.c:877
 blk_request_module+0x16/0xc0 block/genhd.c:893
 blkdev_get_no_open+0x9b/0xf0 block/bdev.c:828
 bdev_file_open_by_dev block/bdev.c:1049 [inline]
 bdev_file_open_by_dev+0x70/0x210 block/bdev.c:1037
 md_import_device+0x120/0x360 drivers/md/md.c:3845
 md_add_new_disk+0xcc0/0x1820 drivers/md/md.c:7530
 md_ioctl+0x2b28/0x36b0 drivers/md/md.c:8476
 blkdev_ioctl+0x5ad/0x6f0 block/ioctl.c:797
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1dea79de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1deb6b0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1deaa26180 RCX: 00007f1dea79de99
RDX: 0000200000001600 RSI: 0000000040140921 RDI: 000000000000000c
RBP: 00007f1dea833eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1deaa26218 R14: 00007f1deaa26180 R15: 00007ffcbbaa0f18
 </TASK>
md: could not open device unknown-block(0,0).
md: md_import_device returned -6


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
