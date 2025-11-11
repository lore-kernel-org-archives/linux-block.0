Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236935BDBC
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879409; cv=none; b=TxpJ1gslsweHOSFajWIuUjxLUqYcIC1a6ZlEkTFXVhlCLe9YZ+mm4kRvQVf4/Qlm0CooZcS5pFK73ZdqaeqgndtEJNMtC1v47KdFafCM2Vp3TE3ks4e+PBuVHFhTngWzFrgingamIVcwQVRnbi5P+IGUR2yo0weSjELxnR2thMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879409; c=relaxed/simple;
	bh=j+i/GLeLPEmR6E/R+k78FqFfShGTnyn5HtO+2xzH0NM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XsfkB80Q9D+KNCFl2JgbfFDSyxZL1JRaPhcgfYE2zptiw4ApYjz4bGt7SHhXVsIFundbZ+OWcChsON9Yxq4ucO0Z7boOnyI6wh3v0juTkAvjkpYHcj4BDb2Mmagx65zbMWDYfKz4ZMMtYqleQn10qRcUNWDO1cpBF1fZoOVlLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9486920a552so186393639f.3
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 08:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762879406; x=1763484206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOPWsCrCMyoDlgmrt8NzYeObZ9ZGoe4M0O3DQkimHM8=;
        b=RgSIzfldWNwl8b3mTOPcZ57v6DRVRs4/PqKjuY9/ItfMRj7Ca2+SNl2N+S95lI8Xl1
         kzOXaX2NFgGaMjBNwB+mEx8nUD5SknTH2jzaLpwzre3bN+eYxck8aWQT1DjXgfynaZNA
         Bc7+O8ffhD1KWviFJQU/7eS583BjfmkVkBy2M3r5YMyhAIaPvmWEd0G+yJFbx3i24hGH
         +lzogpDS8AYV4EQJCitS1y062oE00mQZuEarriNWM6zQiKvX+KaCuCMiawP6Fy5UKSHf
         2RZFVfcmtF91qFA6AV+QuSeA3O4mbCDlMvPhpd895xdLUJg27r51P4SYZfLMoWXNjqKf
         6HeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA0IaQUYy+QrEHuv03C2KUSIKRGpCPKpcCalnxUxWvLCSoS4DxwpiQ8feRrIYS1b7ox3iXjC6jIFGTew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDE9fD9s8jSVimuxw0sEoAOAX4lJLR/4LcjtEbmWInAMs1iN97
	cltpf9B8OGmy41aPG4aJYE6rRarABwapm9SEAfRYXKg5W3Kf1nSmX8fu+W28NCEHFpHz2RhGWbS
	1NY6WLxCkME59/LiJjipVy3Yzv5WIg4iY9JeUIwxnGAwGCHAbX8Be8g+UITk=
X-Google-Smtp-Source: AGHT+IHFmw0aBLx9trd23PHt0ZvR1ewqpoZk2eLWklFWXUVeSyFIg7OVIkbbj4ebuAgNMHTNHGoYfK+LYWsyo7tV9Ln6pGBPbWek
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350b:b0:433:74ba:8bf5 with SMTP id
 e9e14a558f8ab-43374ba8f74mr162559385ab.23.1762879406632; Tue, 11 Nov 2025
 08:43:26 -0800 (PST)
Date: Tue, 11 Nov 2025 08:43:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691367ae.a70a0220.22f260.0141.GAE@google.com>
Subject: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_startstop
From: syzbot <syzbot+774863666ef5b025c9d0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12323812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=774863666ef5b025c9d0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d880d82a810/disk-4a0c9b33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75307faea32a/vmlinux-4a0c9b33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d3f4c38a2eb/bzImage-4a0c9b33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+774863666ef5b025c9d0@syzkaller.appspotmail.com

INFO: task syz.6.3379:19656 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.6.3379      state:D stack:28776 pid:19656 tgid:19654 ppid:16553  task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 blk_trace_startstop+0xa3/0x640 kernel/trace/blktrace.c:682
 blk_trace_ioctl+0x19b/0x430 kernel/trace/blktrace.c:724
 blkdev_common_ioctl+0xdf4/0x2550 block/ioctl.c:630
 blkdev_ioctl+0x4f6/0x6d0 block/ioctl.c:699
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbcfcb8f6c9
RSP: 002b:00007fbcfdaa3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbcfcde6090 RCX: 00007fbcfcb8f6c9
RDX: 0000000000000000 RSI: 0000000000001275 RDI: 0000000000000003
RBP: 00007fbcfcc11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbcfcde6128 R14: 00007fbcfcde6090 R15: 00007fbcfcf0fa28
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3d660 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3d660 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df3d660 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5588:
 #0: ffff888032fa10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.6.3379/19655:
1 lock held by syz.6.3379/19656:
 #0: ffff888142f2b068 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_startstop+0xa3/0x640 kernel/trace/blktrace.c:682

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 19655 Comm: syz.6.3379 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
Code: c0 75 4c 83 3b 00 74 3a 48 83 c3 48 49 89 df 49 c1 ef 03 43 80 3c 37 00 74 08 48 89 df e8 4b 30 b2 00 48 8b 3b e8 b3 cf 18 00 <85> c0 74 14 43 80 3c 37 00 74 08 48 89 df e8 30 30 b2 00 48 8b 03
RSP: 0018:ffffc9000b257668 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffc9000b2576d0 RCX: 6861806b914a4f00
RDX: 0000000000000001 RSI: ffffffff8d8f46a3 RDI: ffffffff846da7ad
RBP: ffffc9000b257710 R08: ffffc9000b257dd0 R09: 0000000000000000
R10: ffffc9000b2576d8 R11: fffff5200164aedd R12: ffff888066a03c80
R13: 1ffff9200164aefc R14: dffffc0000000000 R15: 1ffff9200164aeda
FS:  00007fbcfdac46c0(0000) GS:ffff88812623b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f184bdb3ad8 CR3: 0000000043d28000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_stack_walk+0xfc/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf5/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x71/0x1f0 mm/page_owner.c:311
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 relay_destroy_buf+0x10e/0x3a0 kernel/relay.c:200
 relay_remove_buf kernel/relay.c:220 [inline]
 kref_put include/linux/kref.h:65 [inline]
 relay_close_buf kernel/relay.c:435 [inline]
 relay_open+0x734/0x920 kernel/relay.c:531
 do_blk_trace_setup+0x561/0x980 kernel/trace/blktrace.c:572
 blk_trace_setup+0x116/0x1f0 kernel/trace/blktrace.c:614
 blk_trace_ioctl+0x181/0x430 kernel/trace/blktrace.c:712
 blkdev_ioctl+0x41d/0x6d0 block/ioctl.c:694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbcfcb8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbcfdac4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbcfcde5fa0 RCX: 00007fbcfcb8f6c9
RDX: 00002000000000c0 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007fbcfcc11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbcfcde6038 R14: 00007fbcfcde5fa0 R15: 00007fbcfcf0fa28
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
