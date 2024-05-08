Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19F130A59
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196445; cv=none; b=p46jLKulmL7dwfMWH/IypABTLGcnhm6RGK44PyI3oeTVXgxKvWdD0TKKmbx5kym7GQ08E43ftFiumBbvgZR7qvelTcFlKMDCa3PXW3TL5K2kqCztiSP7RRjuayX1WQ5W3bC92KhdKYwX2yYkeMnE6b8XyzmQZsZ9nSgGOt9/T7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196445; c=relaxed/simple;
	bh=HJpzTdMCVdEZFSiHR6umN3cO1okuqHzm9lLSHnG8aYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ulm09/mSqFi+AClN9gbPkPLA9isBDUkCSe1gSM9MXpde9B5yRAQjn/wsDLZaLV960F9g8BgWO6E4k1MWiP6boVDa3h52impMGB8JO1MHr1DcsdWu38CRDMVlfJ3Ykzc4rY5LmoUGuQ9Bl5pcQ6txXS11sLoYB6WKI9y6t527tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e186a8af8bso1339439f.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 12:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196440; x=1715801240;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBfW+AIKtLhVHOkEsZYl3vg6cBAAN4KRc3aPghR0JDI=;
        b=hOgmEyn9ZGsnDJ2dPNWkAGSYuM6q/Oh9X9NiT2ZjgZZrJOUeSiJYcyNAKrgYpI/S2W
         dpzudTh1RRgRPMdqVf6VSS6qZFWeVNM20pBC6F6cgd8AqJAa8xHP75ldVXSvF1bJK4Yy
         go0I5NlGgXpLyNJhRWSRuay3JSIFXZEPJD72D40aSikNhH6ipDYvsl6Sn6n4pWNkq5g1
         9hR6wynYc87iG+EpYpUyklTZUdyBtWCdGsTDZf+JNbUDMkf/+KZ2EvoJB3/FDGqJUOH6
         pxk4id1npYZYAsjPyQLSBCIpHtHe6Mm+jg2p5HQvo2OXZlMuGs3jKZb8nuUPKGj/sKcB
         XQBg==
X-Forwarded-Encrypted: i=1; AJvYcCVcJlXJQQJMsfg482zQH/1W+WJdEHnwtV3rpf7s3YIVMvHvmtbdca/iL2wc+5o3FJx3T8CjJKZspOkiM746PDeEWec3HvAYgCzY7/U=
X-Gm-Message-State: AOJu0YyHAUJDgGWRgoe+yNPtc9lzjSs9TyYpJKYwziB8W3NZJFZ8MbkI
	8QaRF0nh1oEwqyc9u6efJikOLUpk0VodGE7vB1VXsO6B7IkwJUPfA5KkU7+S01zuIB11UUJXJB+
	CUNmNq7k5P3++8x7WrjyUXi4YCMD38r2cChTm5SO1bgLd/++xqBGxwaw=
X-Google-Smtp-Source: AGHT+IH/Fz6fHxNW2dllBFBT+ZLXC7sNKQw7Lm6d1RcynlczPojFio5sRE77EDXNAifgrxQ6PLG1J6S+FyUn5ledgPGzSvLqIZJp
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2389:b0:488:7bb2:c9f6 with SMTP id
 8926c6da1cb9f-488fdd4e6ecmr239082173.3.1715196440466; Wed, 08 May 2024
 12:27:20 -0700 (PDT)
Date: Wed, 08 May 2024 12:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008de5720617f64aae@google.com>
Subject: [syzbot] [block?] [usb?] INFO: rcu detected stall in aoecmd_cfg (2)
From: syzbot <syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com>
To: axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1276b22f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=1e6e0b916b211bee1bd6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15661898980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a5d1f180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-.... } 2645 jiffies s: 869 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
yealink 3-1:36.0: unexpected response 0
NMI backtrace for cpu 1
CPU: 1 PID: 45 Comm: kworker/1:1 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x0/0x90 kernel/kcov.c:310
Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 4c 8b 04 24 65 48 8b 0c 25 00 d5 03 00 65 8b 05 30 ba
RSP: 0018:ffffc90000a16fa8 EFLAGS: 00000046
RAX: ffffffff8b831214 RBX: 00000000000b31d2 RCX: ffff88801b6c0000
RDX: 0000000000010103 RSI: 00000000000b31d2 RDI: 0000000005f5e0ff
RBP: ffffc90000a170f0 R08: ffffffff8b8364ea R09: 0000000000000000
R10: ffffc90000a17060 R11: fffff52000142e0f R12: 00000000ffff0a00
R13: dffffc0000000000 R14: ffffc90000a17060 R15: ffffc90000a17447
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdfebaf00c CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 put_dec+0x21/0xe0 lib/vsprintf.c:292
 number+0x337/0xf90 lib/vsprintf.c:511
 vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
 sprintf+0xda/0x120 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1327 [inline]
 info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1353
 record_print_text kernel/printk/printk.c:1402 [inline]
 printk_get_next_message+0x6da/0xbe0 kernel/printk/printk.c:2855
 console_emit_next_record kernel/printk/printk.c:2895 [inline]
 console_flush_all+0x410/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4942
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4953
 _dev_err+0x122/0x170 drivers/base/core.c:5008
 urb_irq_callback+0x3b7/0x5b0 drivers/input/misc/yealink.c:433
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_switch+0x8/0x120 kernel/kcov.c:317
Code: cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 <41> 54 53 4c 8b 16 48 8b 46 08 48 83 c0 f8 48 c1 c0 3d 48 83 f8 02
RSP: 0018:ffffc90000a18430 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88801b6c0000
RDX: ffffffff903b5974 RSI: ffffffff8e1a1290 RDI: 0000000000000002
RBP: ffffffff903b5979 R08: 0000000000000005 R09: ffffffff8140e71e
R10: 0000000000000008 R11: ffff88801b6c0000 R12: ffffffff903b5978
R13: dffffc0000000000 R14: ffffc90000a18570 R15: 1ffff920001430a4
 unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4043
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1308 [inline]
 new_skb drivers/block/aoe/aoecmd.c:66 [inline]
 aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:427 [inline]
 aoecmd_cfg+0x2d3/0xa30 drivers/block/aoe/aoecmd.c:1362
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0xaad/0xfd0 kernel/printk/printk.c:3000
Code: ff ff e8 56 bb 1f 00 90 0f 0b 90 e9 d8 f8 ff ff e8 48 bb 1f 00 e8 63 92 13 0a 4d 85 f6 74 b6 e8 39 bb 1f 00 fb 48 8b 44 24 70 <42> 0f b6 04 38 84 c0 48 8b 7c 24 30 0f 85 22 02 00 00 0f b6 1f 31
RSP: 0018:ffffc90000b56600 EFLAGS: 00000293
RAX: 1ffff9200016ad0c RBX: 0000000000000000 RCX: ffff88801b6c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000b567b0 R08: ffffffff81765a44 R09: 1ffffffff25f54be
R10: dffffc0000000000 R11: fffffbfff25f54bf R12: ffffffff8eb21498
R13: ffffffff8eb21440 R14: 0000000000000200 R15: dffffc0000000000
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4942
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4953
 _dev_err+0x122/0x170 drivers/base/core.c:5008
 usb_probe+0xf41/0x1340 drivers/input/misc/yealink.c:910
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:656
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1028
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3712
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
 really_probe+0x2b8/0xad0 drivers/base/dd.c:656
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1028
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3712
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2652
 hub_port_connect drivers/usb/core/hub.c:5522 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5662 [inline]
 port_event drivers/usb/core/hub.c:5822 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5904
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 6.706 msecs
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq_callback - urb status -71
yealink 3-1:36.0: unexpected response 0
yealink 3-1:36.0: urb_ctl_callback - urb status -71
yealink 3-1:36.0: urb_irq

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
