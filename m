Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375512E1DC
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357432; cv=none; b=Vohi9IUGLVnljOvGFHqOPftYQLcMsVbtEeoVw8T9lJgf7SE+05e9I6iLwb9yABaxmkYgyXQlbb5I9QfsnTJxFu6E3VGDwodlMKvbj5kKxmy0X6VVPJ87SUSdhmNZ4UMDgfWYX0o860Ba8nGk69rkv8nd90+BHmPvsBVI1cQ+4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357432; c=relaxed/simple;
	bh=XAwwFxuRPmGpR9OgpYBfNCYENrXvwtp+pz8WfKq9zlA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k2z0xUQJRAmcun5amCRBZBCvNEn4rNftyRjlc62o+daCNR6rKmhR6I8L4NDithp3jLHviZeJvbCLKzALz6mlDMHqEjaaTZOgHj5uupqFkIoExQ3jkTvEtkCzvksxy6fqlydglmdBTR6OLmhBo7vqaOiU2xSuGyS1DmzkEuf+31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4b2d1eb484aso2677906b6e.2
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 17:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357429; x=1787962229;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c1hS2S/aDqJKduIpkYajditUXY7vqt9gPb/Kq0P9YPg=;
        b=spWmKX5HTp+L8f5pGSLylypbCNF3dWE6A9txegYSxvmqbzmrYhyModE36pSDct2Dfz
         1PdklvNp9gOyFRbKxtLtAEm5kfgy85k5ccIdVn01Z4nxMvk90dpcnVKtjx0ut5yI1zeh
         JhiinpCS5xZHfnUYfX8srczBuQYDBPcaAvmjddrZzqB7+jQEjX4+xE2EmMgPneiY+mA5
         TA7sBQb5O5KtbJz4+2xAE2uJXSKeXP2LEf11GEP9A4wle6B/J4sOHG4MPfnrg3PTNhDN
         fBF7Se7In0oIm5nleL09nslqxRuw3Vfy10RLKcJgmnYbb8+QiWROngLlf05MOw3gL8jL
         SV8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrMWcH4JhZ1JdUeJl7nomNaq8OBm2PzT0k9aqqX1AlEkQKE4I/eGnb9i+Xq4H6ylA8JNXHejff/9UBcUQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nyi2l/QQz6KvSGKiGnzK6ML9EUlWOmMt184fkfFIxHrwkTsRdb
	cZpEmpn/tO539x1R/fS6R9zzbh8M8o6ftCMYikNl3Yzbqs7oMp6e5XmI0a0l5Us+hjObMCGxtu5
	jtEX8UDv0Dyeoidui+jZBhTTqoO9UCs9zdLOz04wnFYzdDO9yVlWQl2oOK+I=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5142:b0:4b2:8da1:3be4 with SMTP id
 5614622812f47-4b2ef25eb99mr11944086b6e.9.1787357429238; Fri, 21 Aug 2026
 17:10:29 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a88e8f5.91706f20.16b6e3.02ab.GAE@google.com>
Subject: [syzbot] [block?] INFO: rcu detected stall in blkdev_common_ioctl (4)
From: syzbot <syzbot+9d041b75d7063b71360d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24ef02f934ee net: page_pool: fix UAF in __page_pool_releas..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=108b3a79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca5f2f2c4197664
dashboard link: https://syzkaller.appspot.com/bug?extid=9d041b75d7063b71360d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149dd69e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17063949580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a991674b71f/disk-24ef02f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67041713f1b8/vmlinux-24ef02f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/670139f0d1da/bzImage-24ef02f9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d041b75d7063b71360d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=1e8c/1/0x4000000000000000 softirq=16934/16934 fqs=1
rcu: 	(detected by 0, t=10505 jiffies, g=16269, q=1004 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4979 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:check_region_inline mm/kasan/generic.c:185 [inline]
RIP: 0010:kasan_check_range+0x20/0x2c0 mm/kasan/generic.c:200
Code: 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 55 41 57 41 56 41 55 41 54 53 b0 01 48 85 f6 0f 84 ae 01 00 00 4c 8d 04 37 49 39 f8 <0f> 82 36 02 00 00 49 b9 00 00 00 00 00 80 ff ff eb 0d cc cc cc 49
RSP: 0018:ffffc90000a08d00 EFLAGS: 00000002
RAX: 1ffff1100ef95601 RBX: 0000000000000010 RCX: ffffffff8bce3acf
RDX: 0000000000000001 RSI: 0000000000000010 RDI: ffff888077cab308
RBP: 0000000000000000 R08: ffff888077cab318 R09: 1ffffffff20af1e6
R10: dffffc0000000000 R11: fffffbfff20af1e7 R12: 1ffff110170e5060
R13: ffff888077cab300 R14: ffff888077cab308 R15: ffff8880b8728358
FS:  00007feea5050880(0000) GS:ffff888125049000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558c1f44e8 CR3: 000000007e048000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
 rb_link_node include/linux/rbtree.h:96 [inline]
 __rb_add include/linux/rbtree.h:238 [inline]
 rb_add_linked include/linux/rbtree.h:281 [inline]
 timerqueue_linked_add+0x23f/0x2e0 lib/timerqueue.c:96
 enqueue_hrtimer+0x18e/0x2c0 kernel/time/hrtimer.c:1117
 __run_hrtimer kernel/time/hrtimer.c:2048 [inline]
 __hrtimer_run_queues+0x4ce/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:blkdev_common_ioctl+0x1cb1/0x3250 block/ioctl.c:712
Code: 8b 7c 24 10 66 c7 47 0c f8 f8 e9 0e f8 ff ff e8 15 c3 10 fd 41 bc ff ff ff ff 48 8b 7c 24 10 66 c7 47 10 f8 f8 e9 f3 f7 ff ff <e8> fa c2 10 fd 48 8b 5c 24 18 48 83 c3 10 48 89 d8 48 c1 e8 03 42
RSP: 0018:ffffc9000202fac0 EFLAGS: 00000246
RAX: ffffffff84b62dc6 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807f680000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000202fdf0 R08: ffff8880238950b3 R09: 1ffff11004712a16
R10: dffffc0000000000 R11: ffffed1004712a17 R12: 0000000000000009
R13: dffffc0000000000 R14: ffff8880238950b0 R15: fffff52000405f60
 blkdev_ioctl+0x528/0x740 block/ioctl.c:791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feea491d378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007ffcb96a5f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000055a9cc3c2180 RCX: 00007feea491d378
RDX: 0000000000000000 RSI: 000000000000125f RDI: 000000000000000c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 000055a9ade72100 R14: 0000000000000000 R15: 00007ffcb96a6160
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffies! g16269 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=3345
rcu: rcu_preempt kthread starved for 10500 jiffies! g16269 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27496 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2123
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2325
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
