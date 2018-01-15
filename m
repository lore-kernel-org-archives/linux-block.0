Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932393AbeAOPZQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 10:25:16 -0500
Date: Mon, 15 Jan 2018 10:25:01 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alasdair G Kergon <agk@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de
Subject: 4.16 genirq change prevents HP servers from booting [was: Re:
 linux-next: Signed-off-by missing for commit in the device-mapper tree]
Message-ID: <20180115152501.GA24239@redhat.com>
References: <20180116002736.4d464214@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180116002736.4d464214@canb.auug.org.au>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 15 2018 at  8:27am -0500,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commit
> 
>   34e1467da673 ("Revert "genirq/affinity: assign vectors to all possible CPUs"")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Reverts are commits as well.

Right, I'm aware.  I staged the tree that made some HP servers finally
work with the latest linux-block 4.16 changes.  Without thinking about
the broader implications.  Anyway, I'll drop the revert from
linux-dm.git's 'for-next'.

Because I'm confident others will hunt down the irq issues.

I think Ming was looking to grab the queue mapping info and CPU related
info from the affected server.

> Though I do note it actually has a reasonable commit message, thanks.

Semi-reasonable.  Lacks detail.  The issue is that over the weekend
Laurence found linux-block.git commit 84676c1f21e8ff54befe98 prevents
some HP servers from booting.  They'd hang when trying to initialize
their HPSA controller's devices, e.g.:

[  246.751050] INFO: task systemd-udevd:411 blocked for more than 120
seconds.
[  246.791852]       Tainted: G          I      4.15.0-rc4.block.dm.4.16+ #1
[  246.830650] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[  246.874637] systemd-udevd   D    0   411    408 0x80000004
[  246.904934] Call Trace:
[  246.918191]  ? __schedule+0x28d/0x870
[  246.937643]  ? _cond_resched+0x15/0x30
[  246.958222]  schedule+0x32/0x80
[  246.975424]  async_synchronize_cookie_domain+0x8b/0x140
[  247.004452]  ? remove_wait_queue+0x60/0x60
[  247.027335]  do_init_module+0xbe/0x219
[  247.048022]  load_module+0x21d6/0x2910
[  247.069436]  ? m_show+0x1c0/0x1c0
[  247.087999]  SYSC_finit_module+0x94/0xe0
[  247.110392]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[  247.136669] RIP: 0033:0x7f84049287f9
[  247.156112] RSP: 002b:00007ffd13199ab8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  247.196883] RAX: ffffffffffffffda RBX: 000055b712b59e80 RCX:
00007f84049287f9
[  247.237989] RDX: 0000000000000000 RSI: 00007f8405245099 RDI:
0000000000000008
[  247.279105] RBP: 00007f8404bf2760 R08: 0000000000000000 R09:
000055b712b45760
[  247.320005] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000020
[  247.360625] R13: 00007f8404bf2818 R14: 0000000000000050 R15:
00007f8404bf27b8
[  247.401062] INFO: task scsi_eh_0:471 blocked for more than 120 seconds.
[  247.438161]       Tainted: G          I      4.15.0-rc4.block.dm.4.16+ #1
[  247.476640] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[  247.520700] scsi_eh_0       D    0   471      2 0x80000000
[  247.551339] Call Trace:
[  247.564360]  ? __schedule+0x28d/0x870
[  247.584720]  schedule+0x32/0x80
[  247.601294]  hpsa_eh_device_reset_handler+0x68c/0x700 [hpsa]
[  247.633358]  ? remove_wait_queue+0x60/0x60
[  247.656345]  scsi_try_bus_device_reset+0x27/0x40
[  247.682424]  scsi_eh_ready_devs+0x53f/0xe20
[  247.706467]  ? __pm_runtime_resume+0x55/0x70
[  247.730327]  scsi_error_handler+0x434/0x5e0
[  247.754387]  ? __schedule+0x295/0x870
[  247.775420]  kthread+0xf5/0x130
[  247.793461]  ? scsi_eh_get_sense+0x240/0x240
[  247.818008]  ? kthread_associate_blkcg+0x90/0x90
[  247.844759]  ret_from_fork+0x1f/0x30
[  247.865440] INFO: task scsi_id:488 blocked for more than 120 seconds.
[  247.901112]       Tainted: G          I      4.15.0-rc4.block.dm.4.16+ #1
[  247.938743] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[  247.981092] scsi_id         D    0   488      1 0x00000004
[  248.010535] Call Trace:
[  248.023567]  ? __schedule+0x28d/0x870
[  248.044236]  ? __switch_to+0x1f5/0x460
[  248.065776]  schedule+0x32/0x80
[  248.084238]  schedule_timeout+0x1d4/0x2f0
[  248.106184]  wait_for_completion+0x123/0x190
[  248.130759]  ? wake_up_q+0x70/0x70
[  248.150295]  flush_work+0x119/0x1a0
[  248.169238]  ? wake_up_worker+0x30/0x30
[  248.189670]  __cancel_work_timer+0x103/0x190
[  248.213751]  ? kobj_lookup+0x10b/0x160
[  248.235441]  disk_block_events+0x6f/0x90
[  248.257820]  __blkdev_get+0x6a/0x480
[  248.278770]  ? bd_acquire+0xd0/0xd0
[  248.298438]  blkdev_get+0x1a5/0x300
[  248.316587]  ? bd_acquire+0xd0/0xd0
[  248.334814]  do_dentry_open+0x202/0x320
[  248.354372]  ? security_inode_permission+0x3c/0x50
[  248.378818]  path_openat+0x537/0x12c0
[  248.397386]  ? vm_insert_page+0x1e0/0x1f0
[  248.417664]  ? vvar_fault+0x75/0x140
[  248.435811]  do_filp_open+0x91/0x100
[  248.454061]  do_sys_open+0x126/0x210
[  248.472462]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[  248.495438] RIP: 0033:0x7f39e60e1e90
[  248.513136] RSP: 002b:00007ffc4c906ba8 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[  248.550726] RAX: ffffffffffffffda RBX: 00005624aead3010 RCX:
00007f39e60e1e90
[  248.586207] RDX: 00007f39e60cc0c4 RSI: 0000000000080800 RDI:
00007ffc4c906ed0
[  248.622411] RBP: 00007ffc4c906b60 R08: 00007f39e60cc140 R09:
00007f39e60cc140
[  248.658704] R10: 000000000000001f R11: 0000000000000246 R12:
00007ffc4c906ed0
[  248.695771] R13: 000000009da9d520 R14: 0000000000000000 R15:
00007ffc4c906c28
