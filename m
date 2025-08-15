Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1938317715
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297690; cv=none; b=ds95MgS7n21bKmW+WGqFwxH6lIZugTnta574cmbtasUlQwiUNwp3FbXgtqzo3pqLfboS22JbVJCgD/M0gHjUGtcuyVprnPvPwx/5FmY2p4bnm8ExEqMEk8VBIWewCOn7oxn6fiS2vROCkkrOBwI/Wranq9r5DjkwwOKJHFLcz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297690; c=relaxed/simple;
	bh=UzeawIIHT2/CyTjmsgwXDb21hcAXETcz4dMtct2D+vA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SyrJ/f0kpW0OCrjrjsMMhry8OWUjWmD5M3zj0EmQMpqG4pG72DwhiFEU/f3AMT3T1LYSQmGFa7l0alm86vaD498rLxBCXfcGnY7aD+ctudJ5RezFQLCeaVh41+BzMxpMzv5M96TRFn6eKhwWRWz4sTpZWlNjjh/RogsVKI2Da6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432d9d5c1so241257639f.1
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 15:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755297688; x=1755902488;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LT9kBGvBeeBBy7IzZ8MGcmk1lckKGfmtQ4lBj5ETMLo=;
        b=QV8Ku1k/ohWDD9FOWx3VMZMjqL/cCj0jBHzCkLHjnRm8Y4BA9RmyX2DXmMSHM8DgXv
         y7FePVxWge+cx4GmeE9NlT45coonVMPcypS4VyYevbZNbYt1OteamJzLuNjjhmVtwTmb
         kaxIaabH+VD+gI9QC7Ob9R1hDH8Gj8g48hkW+qZ+xWKfbPwYoQq2pdUsQkVG5sbdgxM5
         B8KVATd1khsPMQRfKA8Z3mS0eToZAGVJ3+0U90z3i5wckkEXRCAXn9tcPiJH2Ahx0ucY
         f/fFM2bCeQW41rHukauOepyD98voZPzKBJW54iUyCx9gJUMJdy8db7gIU8mOulZPHtQo
         eFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtqhrHDoGcin1gO6osjln9N//L2C8KZENPViRmy/dXhplzU1Nb5UAbUDg+bC+vF2MQnfiWj6Wo4K7w4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNse5RsEvvMpzKKzsDO6aovLqQI4rnOsF6+Wn3fGXoTRSAST5G
	RFWSuY/bi9OPeE5QVt5WEnGjYY1YUI6Aw2JOUZGk/M5w4I7wOm+PPcDAgydZW72nplFdKXtYgQb
	Vs+kuf4IJEQbUpI67pejYevWWcT1cH8Ph9YQ3u/1QAAZk7vg7NEyWkilNAQs=
X-Google-Smtp-Source: AGHT+IFjG4f3Nwc3g4mj7qDs0rTaBZbWoJLSnxrS4yHKkuwBdIbKumbT7dCJr+g6KLZ4qcqnMh1OI+FK5WMP7fncyQ3fjG121LQO
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:3e5:4b2e:3b08 with SMTP id
 e9e14a558f8ab-3e5837f0554mr18426055ab.5.1755297688210; Fri, 15 Aug 2025
 15:41:28 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:41:28 -0700
In-Reply-To: <67bb2945.050a0220.bbfd1.0027.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689fb798.050a0220.e29e5.0029.GAE@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in sync_bdevs (3)
From: syzbot <syzbot+97bc0b256218ed6df337@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d65af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
dashboard link: https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142793a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcbdbc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68e3ffeee4c1/disk-931e46dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3cc40de4a0c3/vmlinux-931e46dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aed3e4f6a518/bzImage-931e46dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97bc0b256218ed6df337@syzkaller.appspotmail.com

INFO: task syz-executor297:5890 blocked for more than 143 seconds.
      Not tainted 6.17.0-rc1-next-20250814-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor297 state:D stack:28168 pid:5890  tgid:5890  ppid:5887   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1360 kernel/locking/mutex.c:760
 sync_bdevs+0x1ac/0x340 block/bdev.c:1288
 ksys_sync+0xb9/0x150 fs/sync.c:105
 __ia32_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd97a9d2959
RSP: 002b:00007ffd0221b4d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd97a9d2959
RDX: 00007fd97a9d1b90 RSI: 0000000000000012 RDI: 00007fd97aa1b03b
RBP: 000000000002219f R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd0221b4ec
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 53 e8 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 1a 25 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8e207d80 EFLAGS: 000002c6
RAX: 302944256c608e00 RBX: ffffffff8196d368 RCX: 302944256c608e00
RDX: 0000000000000001 RSI: ffffffff8c04d960 RDI: ffffffff8196d368
RBP: ffffffff8e207eb8 R08: ffff8880b8632f9b R09: 1ffff110170c65f3
R10: dffffc0000000000 R11: ffffed10170c65f4 R12: ffffffff8fe4db30
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1c52a40
FS:  0000000000000000(0000) GS:ffff8881257d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005595b06bc168 CR3: 000000000e336000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 rest_init+0x2de/0x300 init/main.c:756
 start_kernel+0x3a9/0x410 init/main.c:1109
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x147
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
