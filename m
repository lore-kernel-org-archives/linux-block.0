Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40737 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeAORym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 12:54:42 -0500
Received: by mail-ot0-f193.google.com with SMTP id d10so11324478oti.7
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2018 09:54:42 -0800 (PST)
Message-ID: <1516038879.3900.9.camel@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
From: Laurence Oberman <loberman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "Brace, Don" <don.brace@pmcs.com>
Date: Mon, 15 Jan 2018 12:54:39 -0500
In-Reply-To: <alpine.DEB.2.20.1801151842080.2143@nanos>
References: <20180115160345.2611-1-ming.lei@redhat.com>
         <alpine.DEB.2.20.1801151842080.2143@nanos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2018-01-15 at 18:43 +0100, Thomas Gleixner wrote:
> On Tue, 16 Jan 2018, Ming Lei wrote:
> > These two patches fixes IO hang issue reported by Laurence.
> > 
> > 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> > may cause one irq vector assigned to all offline CPUs, then this
> > vector
> > can't handle irq any more.
> > 
> > The 1st patch moves irq vectors spread into one function, and
> > prepares
> > for the fix done in 2nd patch.
> > 
> > The 2nd patch fixes the issue by trying to make sure online CPUs
> > assigned
> > to irq vector.
> 
> Which means it's completely undoing the intent and mechanism of
> managed
> interrupts. Not going to happen.
> 
> Which driver is that which abuses managed interrupts and does not
> keep its
> queues properly sorted on cpu hotplug?
> 
> Thanks,
> 
> 	tglx

Hello Thomas

The servers I am using are all booting off hpsa (SmartArray)
The system would hang on boot with this stack below.

So seen when booting off hpsa driver, not seen by Mike when booting off
a server not using hpsa.

Also not seen when reverting the patch I called out and reverted.

Putting that patch back into Mike/Jens combined tree and adding Ming's
patch seems to fix this issue now. I can boot.

I just did a quick sanity boot and check, not any in-depth testing
right now.

Its not code I am at all familiar with that Ming has changed to make it
work so I defer to Ming to explain in-depth


[  246.751050] INFO: task systemd-udevd:411 blocked for more than 120
seconds.
[  246.791852]       Tainted: G          I      4.15.0-
rc4.block.dm.4.16+ #1
[  246.830650] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables
this message.
[  246.874637] systemd-udevd   D    0   411    408 0x80000004
[  246.904934] Call Trace:
[  246.918191]  ? __schedule+0x28d/0x870
[  246.937643]  ? _cond_resched+0x15/0x30
[  246.958222]  schedule+0x32/0x80
[  246.975424]  async_synchronize_cookie_domain+0x8b/0x140
[  247.004452]  ? remove_wait_queue+0x60/0x60
[  247.027335]  do_init_module+0xbe/0x219
[  247.048022]  load_module+0x21d6/0x2910
[  247.069436]  ? m_show+0x1c0/0x1c0
[  247.087999]  SYSC_finit_module+0x94/0xe0
[  247.110392]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[  247.136669] RIP: 0033:0x7f84049287f9
[  247.156112] RSP: 002b:00007ffd13199ab8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  247.196883] RAX: ffffffffffffffda RBX: 000055b712b59e80 RCX:
00007f84049287f9
[  247.237989] RDX: 0000000000000000 RSI: 00007f8405245099 RDI:
0000000000000008
[  247.279105] RBP: 00007f8404bf2760 R08: 0000000000000000 R09:
000055b712b45760
[  247.320005] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000020
[  247.360625] R13: 00007f8404bf2818 R14: 0000000000000050 R15:
00007f8404bf27b8
[  247.401062] INFO: task scsi_eh_0:471 blocked for more than 120
seconds.
[  247.438161]       Tainted: G          I      4.15.0-
rc4.block.dm.4.16+ #1
[  247.476640] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables
this message.
[  247.520700] scsi_eh_0       D    0   471      2 0x80000000
[  247.551339] Call Trace:
[  247.564360]  ? __schedule+0x28d/0x870
[  247.584720]  schedule+0x32/0x80
[  247.601294]  hpsa_eh_device_reset_handler+0x68c/0x700 [hpsa]
[  247.633358]  ? remove_wait_queue+0x60/0x60
[  247.656345]  scsi_try_bus_device_reset+0x27/0x40
[  247.682424]  scsi_eh_ready_devs+0x53f/0xe20
[  247.706467]  ? __pm_runtime_resume+0x55/0x70
[  247.730327]  scsi_error_handler+0x434/0x5e0
[  247.754387]  ? __schedule+0x295/0x870
[  247.775420]  kthread+0xf5/0x130
[  247.793461]  ? scsi_eh_get_sense+0x240/0x240
[  247.818008]  ? kthread_associate_blkcg+0x90/0x90
[  247.844759]  ret_from_fork+0x1f/0x30
[  247.865440] INFO: task scsi_id:488 blocked for more than 120
seconds.
[  247.901112]       Tainted: G          I      4.15.0-
rc4.block.dm.4.16+ #1
[  247.938743] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables
this message.
[  247.981092] scsi_id         D    0   488      1 0x00000004
[  248.010535] Call Trace:
[  248.023567]  ? __schedule+0x28d/0x870
[  248.044236]  ? __switch_to+0x1f5/0x460
[  248.065776]  schedule+0x32/0x80
[  248.084238]  schedule_timeout+0x1d4/0x2f0
[  248.106184]  wait_for_completion+0x123/0x190
[  248.130759]  ? wake_up_q+0x70/0x70
[  248.150295]  flush_work+0x119/0x1a0
[  248.169238]  ? wake_up_worker+0x30/0x30
[  248.189670]  __cancel_work_timer+0x103/0x190
[  248.213751]  ? kobj_lookup+0x10b/0x160
[  248.235441]  disk_block_events+0x6f/0x90
[  248.257820]  __blkdev_get+0x6a/0x480
[  248.278770]  ? bd_acquire+0xd0/0xd0
[  248.298438]  blkdev_get+0x1a5/0x300
[  248.316587]  ? bd_acquire+0xd0/0xd0
[  248.334814]  do_dentry_open+0x202/0x320
[  248.354372]  ? security_inode_permission+0x3c/0x50
[  248.378818]  path_openat+0x537/0x12c0
[  248.397386]  ? vm_insert_page+0x1e0/0x1f0
[  248.417664]  ? vvar_fault+0x75/0x140
[  248.435811]  do_filp_open+0x91/0x100
[  248.454061]  do_sys_open+0x126/0x210
[  248.472462]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[  248.495438] RIP: 0033:0x7f39e60e1e90
[  248.513136] RSP: 002b:00007ffc4c906ba8 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[  248.550726] RAX: ffffffffffffffda RBX: 00005624aead3010 RCX:
00007f39e60e1e90
[  248.586207] RDX: 00007f39e60cc0c4 RSI: 0000000000080800 RDI:
00007ffc4c906ed0
[  248.622411] RBP: 00007ffc4c906b60 R08: 00007f39e60cc140 R09:
00007f39e60cc140
[  248.658704] R10: 000000000000001f R11: 0000000000000246 R12:
00007ffc4c906ed0
[  248.695771] R13: 000000009da9d520 R14: 0000000000000000 R15:
00007ffc4c906c28
