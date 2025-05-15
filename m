Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037F4B1E4F
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747281930; cv=none; b=aaZ+rLsH6C2/QS8eO07xYQ16Xa+Q5uyMNtYmMbdtsF8V/C7uoZ6roeZRXlYqYJ06mCupUsn5QzaSyydYAucSVMhdN24mu2Fsa0MqgXOwAHsNLUllUnpXarBRYGXGkdOryMtLvdUPbIX5fPZZfCeMBoo6ZAzwM7aJCQzh9wF9dV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747281930; c=relaxed/simple;
	bh=WbaOjFqUgJEb48qtEbQ5iH6fpJ6aQ4/fjv+Msg5IOg4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jm6y9YH3xeMZEebDK3c+WWvfOtWUJ7oNHM/kSgmFGJV9bUes//7GL1U8Ce5/RssHWX+NmjHLjimrvw3FGMKA7bW8gsCQgQpLzdLyZZo8k4wPpZ2KCIF/sfybRtYqq3afETuHSxZG6dsuu0PGYsB0UjPhZG5QC6n8CJBSaKyTwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d81bc9b763so8221245ab.0
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 21:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747281927; x=1747886727;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0bvqXSA1MWlQ0Tx3Jf5kQuYB868wAHWrRS3Kaz/YCg=;
        b=NU+szsH3GCefkXGpQbHkWPhQ7JS7RUy9VCLqXzUMoiwN7kNq+M1D09wGlPJNZwqFlw
         XnXlZVl+S8ssGUtkJwGWIUzPpvmOOaEiMXJORpdr+uSV/bxY6G9pCfpz3ZLS0w+vXcnm
         wUET37IAAiRa62EiRIoQxfB4c599Hn2g+AEyfHwI6Et2VootT8myb7TQQ60gAQu7/MYp
         VtTCeKgxf8M1dUUW6qeDsUs636YkrPXQNFOF7gmcqHGQ1Se/N4tyDCKV7NcmiOy1DK8z
         Msxg/TjmlPF1HFHRleSv82OwXBeNbZVH9oN0o21avLSFPOKser49KyK6A2UK/ImQM+cC
         HTgw==
X-Forwarded-Encrypted: i=1; AJvYcCWTcfPX2D3wjlr8d2Vprn7eOOEV52hAZxIKnNVYRRR5k4zuVKWGbQ29jbruHYlbsYo20jJrWMMAPXIWyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRrWDc5Q7kowWjzGHjwMN+an/YhrRbF96LO1j0h246oo+cGEns
	bwu1uKa7bxA19VLqu6ql/5OmP8hjXdNIEQ+0ZJMRw08Ob/D9Fylyg6m+g+7IRrJZC8ykkTjl31Y
	iohK5qOGdI7X0cxfhPLbw4e5tvhT0vrSQs/fmCawgjkdFccr8YT6JkSM=
X-Google-Smtp-Source: AGHT+IEQomtYcnnBJIZkcRc9OIMIxUoG7c54+xqdEXfZ+RPlMV4LGkSmmNCctNYX0JZdKfesrvteFQdXHiDOkXiemRU4yb1kLGJm
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8d:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3db6f79a2demr72468195ab.2.1747281927482; Wed, 14 May 2025
 21:05:27 -0700 (PDT)
Date: Wed, 14 May 2025 21:05:27 -0700
In-Reply-To: <00000000000035b2ce06197bd027@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68256807.a00a0220.104b28.0018.GAE@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_open
From: syzbot <syzbot+5c6179f2c4f1e111df11@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f35e33144ae x86/its: Fix build errors when CONFIG_MODULES=n
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10639af4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc44e21a0b824ef8
dashboard link: https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c4e70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166c2f68580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0143554b1db5/disk-9f35e331.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccf3a30abae2/vmlinux-9f35e331.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e205d989271/bzImage-9f35e331.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c6179f2c4f1e111df11@syzkaller.appspotmail.com

INFO: task udevd:5194 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00052-g9f35e33144ae #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:24824 pid:5194  tgid:5194  ppid:1      task_flags:0x400140 flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:746
 bdev_open+0xe0/0xd30 block/bdev.c:945
 blkdev_open+0x3a8/0x510 block/fops.c:652
 do_dentry_open+0xdf3/0x1970 fs/open.c:956
 vfs_open+0x3b/0x340 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4039
 do_filp_open+0x1fa/0x410 fs/namei.c:4066
 do_sys_openat2+0x121/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdfe28a7407
RSP: 002b:00007ffefe105d00 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fdfe2f55880 RCX: 00007fdfe28a7407
RDX: 00000000000a0800 RSI: 000056326f6fe3e0 RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 000056324ea0e100 R14: 0000000000000000 R15: 00007ffefe105f90
 </TASK>
INFO: task syz-executor268:5876 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00052-g9f35e33144ae #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor268 state:D stack:27096 pid:5876  tgid:5872  ppid:5852   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:746
 bdev_release+0x1a9/0x650 block/bdev.c:1128
 blkdev_release+0x15/0x20 block/fops.c:660
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 ptrace_notify+0x281/0x2c0 kernel/signal.c:2520
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc2/0x1d0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare+0x6f/0xe0 kernel/entry/common.c:200
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x12/0x120 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f6252f929
RSP: 002b:00007f4f624e5218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f4f625b7328 RCX: 00007f4f6252f929
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007f4f625b7320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4f6258435c
R13: 64626e2f7665642f R14: 0000200000000040 R15: 0000000080000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
2 locks held by kworker/u8:3/53:
 #0: ffff8880b8839b58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
 #1: ffff8880b8823b08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x318/0x6d0 kernel/sched/psi.c:975
1 lock held by udevd/5194:
 #0: ffff888024977358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:945
2 locks held by getty/5587:
 #0: ffff8880303d60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002ffe2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by udevd/5861:
 #0: ffff888024977358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:945
1 lock held by syz-executor268/5876:
 #0: ffff888024977358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x1a9/0x650 block/bdev.c:1128

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc6-syzkaller-00052-g9f35e33144ae #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
NMI backtrace for cpu 0 skipped: idling at tif_test_bit include/linux/thread_info.h:192 [inline]
NMI backtrace for cpu 0 skipped: idling at tif_need_resched include/linux/thread_info.h:208 [inline]
NMI backtrace for cpu 0 skipped: idling at current_clr_polling_and_test include/linux/sched/idle.h:79 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle_call+0x1b/0xb0 kernel/sched/idle.c:111


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
