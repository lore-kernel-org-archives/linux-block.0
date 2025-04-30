Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15135189BAC
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011611; cv=none; b=DOFIu1Uf9COK+ICq8hq0lQlEMH+bCRE2QvhqIniu9UWikAWMjCrD157PnRWhFuAYG4HYO91a0ZB/Lkxdhf6CfiisEXIdvRd2rifhjLZ1wquVsajC18d0KDtYvUdCG3UJbp4eixLOZbmW4EnfUFWaTmzYGKnPFmMKq+Sf8Co82WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011611; c=relaxed/simple;
	bh=7o/CxZP/N8ZSqvn8N3K3S0RUZitG2gHajDvOhwaxzdI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JgRBfCiKhcI1WgtURnbQMcjnrb66nHGTHYxrYpvfQ17A65FRdabadDF6rrC8NmywYaJaTI5MSeqWqAvGXv6tBTILBOkGE3XHEE4auDSnmq47ZC6hgsDSbpwayHWkGBR4TpTwRJT6JIMvvpY7Ev8Aftd/7PPtXfsykT3jKqIPokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d817cf6e72so8412915ab.1
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746011608; x=1746616408;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4tFTE7S+oJNfUjSbzXi16zgOo2NXGKra0fxBiOGOos=;
        b=cSJr1hkHbkTnorAVds427ITaylSOfqSwLfjAKg0+xswivFkupmZOjI9HlfCmElhdRP
         s4oo/uPDHsNrEsuZB/uUlFRMMi+98RUlH/iRG/8ggM0jD98W3uIrQlGzmqSa7NUNt26v
         L7iNYETbdThmo+/LkSDLx/DS7qaRNCXHQ1B1dYeHcK9GVC1FC78wlaLq0TkBxABx4id7
         W3ahknOV5auRGvcb6D51YFH15b9Cptt4A7AHTK7/9Wr/78GUA77z2RVRjMqTs6Hy3UdE
         B8/xUV0uIZCSyfewK0OpANsWZL9HQgBy4vl9OP5CGICf3ENGo2XMAbUlh4MLHNhMScC+
         tZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1c19kTtEG6+LDKYIojbfr1anTBZhlhhbWM9SXhAa6yo3ZnefTGsAE6JCKOXpe25eSCEYHiP+T66cz8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpGpEUtgmSZrxJaGbh27z5UdmUdy8TfmubDDjj7dt1UebdULD
	A6TAGLFK4zXJR3+Orli4+XSkJ0xlCLiSSFa1RN1Ce2cYbr9Bpe+PvZwOnmjdAlq2dxYsAViD+Iq
	++wTHCHLO/o8XHEKtEfftUm+/0jwdd7RepvhzNRiKrjUsa80BqUcCTy8=
X-Google-Smtp-Source: AGHT+IFq0fTKEAo05M7bjn02yl3wFLn4FDRAJQZEvWt1pahJqNfnEXi390z3NwPAt4eOeqp10am/5F8TsjKUv+wlpZ1smqikgnIH
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de6:b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d96792b52cmr17833805ab.5.1746011608267; Wed, 30 Apr 2025
 04:13:28 -0700 (PDT)
Date: Wed, 30 Apr 2025 04:13:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681205d8.050a0220.16fb2c.000e.GAE@google.com>
Subject: [syzbot] [block?] BUG: soft lockup in aoecmd_cfg (3)
From: syzbot <syzbot+5dfe55156cc098033526@syzkaller.appspotmail.com>
To: axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    38d976c32d85 selftests/bpf: Fix kmem_cache iterator draining
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e7f368580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=5dfe55156cc098033526
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9911045e375/disk-38d976c3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c30c3293b442/vmlinux-38d976c3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b50c11bd537d/bzImage-38d976c3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5dfe55156cc098033526@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 119s! [syz.4.1024:9411]
Modules linked in:
irq event stamp: 10871561
hardirqs last  enabled at (10871560): [<ffffffff8b55e3c4>] irqentry_exit+0x74/0x90 kernel/entry/common.c:357
hardirqs last disabled at (10871561): [<ffffffff8b55cdbe>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (10548774): [<ffffffff8185c3fa>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (10548774): [<ffffffff8185c3fa>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (10548774): [<ffffffff8185c3fa>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
softirqs last disabled at (10548777): [<ffffffff8185c3fa>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (10548777): [<ffffffff8185c3fa>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (10548777): [<ffffffff8185c3fa>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
CPU: 1 UID: 0 PID: 9411 Comm: syz.4.1024 Not tainted 6.15.0-rc4-syzkaller-g38d976c32d85 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:stack_trace_consume_entry+0x0/0x280 kernel/stacktrace.c:83
Code: 75 0e 48 8d 65 f0 5b 41 5e 5d c3 cc cc cc cc cc e8 05 2c a9 09 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 41 57 41 56 41 55 41 54 53 48 83 ec 18 48 ba 00 00
RSP: 0018:ffffc90000a085a0 EFLAGS: 00000282
RAX: ffffffff8221818c RBX: ffffc90000a08660 RCX: 4bee8df37e445700
RDX: 0000000000000001 RSI: ffffffff8221818c RDI: ffffc90000a08660
RBP: ffffc90000a08630 R08: ffffc90000a08117 R09: 0000000000000000
R10: ffffc90000a08108 R11: ffffffff81acaa70 R12: ffff88803261bc00
R13: ffff888061515040 R14: ffffffff81acaa70 R15: ffffc90000a085a8
FS:  00007f3a0d4116c0(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8808600218 CR3: 000000006bb3e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 arch_stack_walk+0x10d/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4262
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:577
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 new_skb+0x2f/0x2b0 drivers/block/aoe/aoecmd.c:66
 aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:430 [inline]
 aoecmd_cfg+0x28b/0x7c0 drivers/block/aoe/aoecmd.c:1370
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:7090
Code: 24 20 f6 44 24 21 02 74 0c 90 0f 0b 48 f7 03 08 00 00 00 74 64 bf 01 00 00 00 e8 eb c3 39 f6 e8 86 43 70 f6 fb bf 01 00 00 00 <e8> 4b ab ff ff 48 c7 44 24 40 00 00 00 00 9c 8f 44 24 40 8b 44 24
RSP: 0018:ffffc90004f36f60 EFLAGS: 00000286
RAX: 4bee8df37e445700 RBX: 0000000000000000 RCX: 4bee8df37e445700
RDX: 0000000000000007 RSI: ffffffff8d749fcc RDI: 0000000000000001
RBP: ffffc90004f37000 R08: ffffffff8f7ed377 R09: 1ffffffff1efda6e
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920009e6dec
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:qlink_to_object mm/kasan/quarantine.c:140 [inline]
RIP: 0010:qlink_free mm/kasan/quarantine.c:145 [inline]
RIP: 0010:qlist_free_all+0x70/0x140 mm/kasan/quarantine.c:179
Code: 8b 4c 28 08 f6 c1 01 0f 85 ad 00 00 00 4c 01 e8 66 90 0f b6 48 33 c1 e1 18 81 f9 00 00 00 f5 48 0f 45 c5 4c 8b 60 08 49 8b 1f <49> 63 84 24 c0 00 00 00 49 29 c7 4c 89 e7 4c 89 fe e8 9a e5 ff ff
RSP: 0018:ffffc90004f370c8 EFLAGS: 00000246
RAX: ffffea0001e59b80 RBX: ffff888028ca6700 RCX: 00000000f5000000
RDX: ffffc9000fad9000 RSI: 000000000000d491 RDI: 000000000000d492
RBP: 0000000000000000 R08: 0000000000000026 R09: ffff888028814d40
R10: 0000000000000000 R11: fffffbfff1efda6f R12: ffff888140408a00
R13: ffffea0000000000 R14: 0000000000000000 R15: ffff88807966ebf8
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4262
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:658
 alloc_skb_fclone include/linux/skbuff.h:1390 [inline]
 tcp_stream_alloc_skb+0x3d/0x340 net/ipv4/tcp.c:894
 tcp_connect+0x1087/0x46f0 net/ipv4/tcp_output.c:4139
 tcp_v4_connect+0x104f/0x1980 net/ipv4/tcp_ipv4.c:343
 __inet_stream_connect+0x295/0xf10 net/ipv4/af_inet.c:677
 tcp_sendmsg_fastopen+0x3a7/0x5e0 net/ipv4/tcp.c:1047
 tcp_sendmsg_locked+0x4a34/0x5030 net/ipv4/tcp.c:1099
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1366
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a0c58e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3a0d411038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3a0c7b5fa0 RCX: 00007f3a0c58e969
RDX: 0000000030004081 RSI: 0000200000000080 RDI: 0000000000000005
RBP: 00007f3a0c610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3a0c7b5fa0 R15: 00007ffe110954f8
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9416 Comm: syz.0.1025 Not tainted 6.15.0-rc4-syzkaller-g38d976c32d85 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:245 [inline]
RIP: 0010:__lock_acquire+0x882/0xd20 kernel/locking/lockdep.c:5231
Code: 00 0f 85 3e 02 00 00 48 83 7c 24 10 00 0f 84 c4 01 00 00 41 8b 47 f8 25 ff 1f 00 00 48 0f a3 05 34 bf de 11 0f 83 62 01 00 00 <48> 69 c0 c8 00 00 00 48 8d 80 e0 d6 1d 93 e9 8f 01 00 00 e8 f6 e3
RSP: 0018:ffffc90000006ee0 EFLAGS: 00000003
RAX: 0000000000000007 RBX: 0000000000000006 RCX: 000000006fd66277
RDX: 000000001044ffbd RSI: 0000000050405a8b RDI: ffff88805778bc00
RBP: ffff88805778c6f0 R08: 0000000000000000 R09: 0000000000080000
R10: 0000000000000000 R11: ffffffff81ae757e R12: 0000000000004055
R13: 18ff7db76fd66277 R14: 0000000000004055 R15: ffff88805778c7e0
FS:  0000000000000000(0000) GS:ffff8881260cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f08c26e56e8 CR3: 000000006698a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 seqcount_lockdep_reader_access+0xc9/0x1c0 include/linux/seqlock.h:72
 ktime_get+0x3e/0x1f0 kernel/time/timekeeping.c:750
 clockevents_program_event+0xea/0x360 kernel/time/clockevents.c:326
 hrtimer_interrupt+0x620/0xaa0 kernel/time/hrtimer.c:1900
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
RIP: 0010:rcu_is_watching+0x10/0xb0 kernel/rcu/tree.c:736
Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 65 ff 05 20 5a ce 10 <e8> 7b 0b af 09 89 c3 83 f8 08 73 65 49 bf 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90000007350 EFLAGS: 00000203
RAX: 0000000000000000 RBX: ffffffff817199f5 RCX: ffffe8ffff602820
RDX: ffffffff817199f5 RSI: ffffffff8bc1cdc0 RDI: ffffffff8bc1cd80
RBP: dffffc0000000000 R08: ffffc90004f8fed0 R09: 0000000000000000
R10: ffffc900000074f8 R11: fffff52000000ea1 R12: ffffc90004f8fee0
R13: ffffffff817199f5 R14: ffffffff8df3b860 R15: ffffffff8df3b860
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x4b/0x3e0 kernel/locking/lockdep.c:5877
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4262
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:577
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:668
 __netdev_alloc_skb+0x108/0x970 net/core/skbuff.c:732
 netdev_alloc_skb include/linux/skbuff.h:3413 [inline]
 dev_alloc_skb include/linux/skbuff.h:3426 [inline]
 __ieee80211_beacon_get+0xe32/0x1630 net/mac80211/tx.c:5475
 ieee80211_beacon_get_tim+0xb4/0x2b0 net/mac80211/tx.c:5597
 ieee80211_beacon_get include/net/mac80211.h:5648 [inline]
 mac80211_hwsim_beacon_tx+0x3d2/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2313
 __iterate_interfaces+0x2a8/0x590 net/mac80211/util.c:761
 ieee80211_iterate_active_interfaces_atomic+0xdb/0x180 net/mac80211/util.c:797
 mac80211_hwsim_beacon+0xbb/0x1c0 drivers/net/wireless/virtual/mac80211_hwsim.c:2347
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x529/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:folio_test_anon include/linux/page-flags.h:725 [inline]
RIP: 0010:mm_counter include/linux/mm.h:2744 [inline]
RIP: 0010:zap_present_folio_ptes mm/memory.c:1511 [inline]
RIP: 0010:zap_present_ptes mm/memory.c:1586 [inline]
RIP: 0010:do_zap_pte_range mm/memory.c:1687 [inline]
RIP: 0010:zap_pte_range mm/memory.c:1731 [inline]
RIP: 0010:zap_pmd_range mm/memory.c:1823 [inline]
RIP: 0010:zap_pud_range mm/memory.c:1852 [inline]
RIP: 0010:zap_p4d_range mm/memory.c:1873 [inline]
RIP: 0010:unmap_page_range+0x15c0/0x4210 mm/memory.c:1894
Code: e0 20 0f 85 c8 00 00 00 e8 ad 0e b7 ff 4d 89 e5 4c 8b a4 24 98 00 00 00 42 80 3c 2b 00 74 08 4c 89 f7 e8 83 ff 18 00 49 8b 1e <48> 89 de 48 83 e6 01 31 ff e8 62 13 b7 ff 48 83 e3 01 0f 85 03 01
RSP: 0018:ffffc90004f8f420 EFLAGS: 00000246
RAX: ffffffff8208b023 RBX: 0000000000000000 RCX: ffff88805778bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004f8f6b0 R08: ffff88801d04b1df R09: 1ffff11003a0963b
R10: dffffc0000000000 R11: ffffed1003a0963c R12: ffffea000163c140
R13: dffffc0000000000 R14: ffffea000163c158 R15: 0400000000000000
 unmap_vmas+0x25d/0x3c0 mm/memory.c:1984
 exit_mmap+0x245/0xba0 mm/mmap.c:1284
 __mmput+0x118/0x420 kernel/fork.c:1379
 exit_mm+0x1da/0x2c0 kernel/exit.c:589
 do_exit+0x859/0x2550 kernel/exit.c:940
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x95/0x780 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x8b/0x120 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f970778e969
Code: Unable to access opcode bytes at 0x7f970778e93f.
RSP: 002b:00007f97055f60e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f97079b5fa8 RCX: 00007f970778e969
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f97079b5fac
RBP: 00007f97079b5fa0 R08: 7fffffffffffffff R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 00007f97079b5fac
R13: 0000000000000000 R14: 00007fff12ae59c0 R15: 00007fff12ae5aa8
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
