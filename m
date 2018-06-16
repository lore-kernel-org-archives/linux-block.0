Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:58612 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754052AbeFPKgL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jun 2018 06:36:11 -0400
Date: Sat, 16 Jun 2018 12:36:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-block@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: list_add double add in blk_mq_check_expired()
Message-ID: <20180616103605.GA28657@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

just triggered the below in a qemu guest, kernel is Linus' master from
yesterday + tip/master. It doesn't fire reliably so it could be some
transient thing of the merge window:

---

...

[    2.387633] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    2.500490] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.503122] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    2.507917] Freeing unused kernel memory: 1332K
[    2.509362] Write protecting the kernel read-only data: 16384k
[    2.511774] Freeing unused kernel memory: 2008K
[    2.514999] Freeing unused kernel memory: 956K
[    2.523429] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.485227] random: fast init done
[    7.904105] ------------[ cut here ]------------
[    7.906706] list_add double add: new=ffff88007b342180, prev=ffff88007b342180, next=ffff88007ad07060.
[    7.910001] WARNING: CPU: 7 PID: 1543 at lib/list_debug.c:31 __list_add_valid+0x67/0x70
[    7.910001] Modules linked in:
[    7.910001] CPU: 7 PID: 1543 Comm: kworker/7:1H Not tainted 4.17.0+ #7
[    7.910001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    7.910001] Workqueue: kblockd blk_mq_timeout_work
[    7.910001] RIP: 0010:__list_add_valid+0x67/0x70
[    7.910001] Code: c1 4c 89 c6 48 c7 c7 30 27 e6 81 e8 63 50 d2 ff 0f 0b 31 c0 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 27 e6 81 e8 49 50 d2 ff <0f> 0b 31 c0 c3 0f 1f 40 00 48 8b 07 48 b9 00 01 00 00 00 00 ad de 
[    7.910001] RSP: 0018:ffffc9000080fd68 EFLAGS: 00010096
[    7.910001] RAX: 0000000000000058 RBX: ffff88007ad07000 RCX: ffffffff82042488
[    7.910001] RDX: 0000000000000001 RSI: 0000000000000086 RDI: ffffffff824c2d8c
[    7.910001] RBP: ffff88007b342130 R08: ffffffff814254a0 R09: 0000000000000181
[    7.910001] R10: 0000000000aaaaaa R11: ffff88007c7056d0 R12: ffff88007b342180
[    7.910001] R13: 0000000000000282 R14: ffff88007b342180 R15: ffff88007ad07060
[    7.910001] FS:  0000000000000000(0000) GS:ffff88007d3c0000(0000) knlGS:0000000000000000
[    7.910001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.910001] CR2: 00007f58744b3a80 CR3: 0000000002009000 CR4: 00000000003406e0
[    7.910001] Call Trace:
[    7.910001]  scsi_eh_scmd_add+0xc5/0x160
[    7.910001]  scsi_times_out+0x9a/0x1a0
[    7.910001]  blk_mq_check_expired+0xf2/0x130
[    7.910001]  bt_iter+0x48/0x50
[    7.910001]  blk_mq_queue_tag_busy_iter+0x129/0x220
[    7.910001]  ? blk_mq_timeout_work+0x150/0x150
[    7.910001]  ? blk_mq_timeout_work+0x150/0x150
[    7.910001]  blk_mq_timeout_work+0x80/0x150
[    7.910001]  process_one_work+0x18c/0x3a0
[    7.910001]  worker_thread+0x30/0x3a0
[    7.910001]  ? process_one_work+0x3a0/0x3a0
[    7.910001]  kthread+0x113/0x130
[    7.910001]  ? kthread_create_worker_on_cpu+0x40/0x40
[    7.910001]  ret_from_fork+0x22/0x40
[    7.910001] ---[ end trace 0d2f1accf0e2ed60 ]---
[    7.992080] WARNING: CPU: 7 PID: 0 at kernel/rcu/tree.c:2596 rcu_process_callbacks+0x49a/0x4c0
[    7.995041] Modules linked in:
[    7.996049] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W         4.17.0+ #7
[    7.996049] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    7.996049] RIP: 0010:rcu_process_callbacks+0x49a/0x4c0
[    7.996049] Code: e9 56 fd ff ff 48 c7 83 90 00 00 00 00 00 00 00 48 8b 95 50 03 00 00 48 89 93 98 00 00 00 e9 60 fd ff ff 0f 0b e9 bb fb ff ff <0f> 0b e9 68 fd ff ff 0f 0b e9 89 fc ff ff 4c 89 ee 4c 89 e7 66 90 
[    7.996049] RSP: 0018:ffff88007d3c3f18 EFLAGS: 00010002
[    7.996049] RAX: 0000000000000000 RBX: ffff88007d3e18c0 RCX: ffff88007c505e80
[    7.996049] RDX: ffffffffffffd801 RSI: ffff88007d3c3f20 RDI: ffff88007d3e18f8
[    7.996049] RBP: ffffffff82043a80 R08: ffff88007d3e1810 R09: 0000000000000101
[    7.996049] R10: ffff88007c0ac6c0 R11: 0000000000000000 R12: ffff88007d3e18f8
[    7.996049] R13: 0000000000000246 R14: 7fffffffffffffff R15: 0000000000000202
[    7.996049] FS:  0000000000000000(0000) GS:ffff88007d3c0000(0000) knlGS:0000000000000000
[    7.996049] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.996049] CR2: 00007f58744b3a80 CR3: 0000000002009000 CR4: 00000000003406e0
[    7.996049] Call Trace:
[    7.996049]  <IRQ>
[    7.996049]  __do_softirq+0xd6/0x2dc
[    7.996049]  irq_exit+0xaf/0xc0
[    7.996049]  smp_apic_timer_interrupt+0x6c/0x150
[    7.996049]  apic_timer_interrupt+0xf/0x20
[    7.996049]  </IRQ>
[    7.996049] RIP: 0010:default_idle+0x25/0x140
[    7.996049] Code: 90 90 90 90 90 0f 1f 44 00 00 48 83 ec 18 48 89 1c 24 48 89 6c 24 08 4c 89 64 24 10 65 8b 2d a2 98 93 7e 0f 1f 44 00 00 fb f4 <65> 8b 2d 94 98 93 7e 0f 1f 44 00 00 48 8b 1c 24 48 8b 6c 24 08 4c 
[    7.996049] RSP: 0018:ffffc900003bfed0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[    7.996049] RAX: ffffffff816d5870 RBX: 0000000000000007 RCX: ffff88007d3d95c0
[    7.996049] RDX: ffffffff82043af8 RSI: ffff88007d3d95c0 RDI: 00000001dc1f3500
[    7.996049] RBP: 0000000000000007 R08: 0000000000001400 R09: 0000000000000000
[    7.996049] R10: 0000000000001400 R11: 0000000000000001 R12: 0000000000000000
[    7.996049] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    7.996049]  ? __sched_text_end+0x6/0x6
[    7.996049]  do_idle+0x18a/0x230
[    7.996049]  cpu_startup_entry+0x5f/0x70
[    7.996049]  start_secondary+0x189/0x1c0
[    7.996049]  secondary_startup_64+0xa5/0xb0
[    7.996049] ---[ end trace 0d2f1accf0e2ed61 ]---
[   10.612152] Adding 917500k swap on /dev/sda2.  Priority:-2 extents:1 across:917500k 
[   10.631761] EXT4-fs (sda1): re-mounted. Opts: (null)
[   11.505751] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   13.052771] random: dd: uninitialized urandom read (512 bytes read)
[   13.822765] 8139cp 0000:00:03.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
[   20.022242] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   20.456262] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   21.504397] random: exim4: uninitialized urandom read (120 bytes read)
[   21.506713] random: exim4: uninitialized urandom read (120 bytes read)
[   21.509112] random: exim4: uninitialized urandom read (120 bytes read)
[   30.172294] random: crng init done
[   30.173029] random: 4 urandom warning(s) missed due to ratelimiting

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
