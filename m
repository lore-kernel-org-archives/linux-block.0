Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36395 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeAPN2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 08:28:40 -0500
Received: by mail-qt0-f196.google.com with SMTP id a16so18200228qtj.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2018 05:28:40 -0800 (PST)
Message-ID: <1516109317.9574.1.camel@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
From: Laurence Oberman <loberman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>,
        "Brace, Don" <don.brace@pmcs.com>
Date: Tue, 16 Jan 2018 08:28:37 -0500
In-Reply-To: <alpine.DEB.2.20.1801161223500.1823@nanos>
References: <20180115160345.2611-1-ming.lei@redhat.com>
         <20180115174036.GA20191@infradead.org> <20180116013043.GA3213@ming.t460p>
         <alpine.DEB.2.20.1801161223500.1823@nanos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-01-16 at 12:25 +0100, Thomas Gleixner wrote:
> On Tue, 16 Jan 2018, Ming Lei wrote:
> 
> > On Mon, Jan 15, 2018 at 09:40:36AM -0800, Christoph Hellwig wrote:
> > > On Tue, Jan 16, 2018 at 12:03:43AM +0800, Ming Lei wrote:
> > > > Hi,
> > > > 
> > > > These two patches fixes IO hang issue reported by Laurence.
> > > > 
> > > > 84676c1f21 ("genirq/affinity: assign vectors to all possible
> > > > CPUs")
> > > > may cause one irq vector assigned to all offline CPUs, then
> > > > this vector
> > > > can't handle irq any more.
> > > 
> > > Well, that very much was the intention of managed
> > > interrupts.  Why
> > > does the device raise an interrupt for a queue that has no online
> > > cpu assigned to it?
> > 
> > It is because of irq_create_affinity_masks().
> 
> That still does not answer the question. If the interrupt for a queue
> is
> assigned to an offline CPU, then the queue should not be used and
> never
> raise an interrupt. That's how managed interrupts have been designed.
> 
> Thanks,
> 
> 	tglx
> 
> 
> 
> 

I captured a full boot log for this issue for Microsemi, I will send it
to Don Brace.
I enabled all the HPSA debug and here is snippet

[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.15.0-
rc4.noming+ root=/dev/mapper/rhel_ibclient-root ro crashkernel=512M@64M
 rd.lvm.lv=rhel_ibclient/root rd.lvm.lv=rhel_ibclient/swap
log_buf_len=54M console=ttyS1,115200n8 scsi_mod.use_blk_mq=y
dm_mod.use_blk_mq=y
[    0.000000] Memory: 7834908K/1002852K available (8397K kernel code,
3012K rwdata, 3660K rodata, 2184K init, 15344K bss, 2356808K reserved,
0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32,
Nodes=2
[    0.000000] ftrace: allocating 33084 entries in 130 pages
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to
nr_cpu_ids=32.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16,
nr_cpu_ids=32
[    0.000000] NR_IRQS: 524544, nr_irqs: 1088, preallocated irqs: 16
..
..
    0.190147] smp: Brought up 2 nodes, 16 CPUs
[    0.192006] smpboot: Max logical packages: 4
[    0.193007] smpboot: Total of 16 processors activated (76776.33
BogoMIPS)
[    0.940640] node 0 initialised, 10803218 pages in 743ms
[    1.005449] node 1 initialised, 11812066 pages in 807ms
..
..
[    7.440896] hpsa 0000:05:00.0: can't disable ASPM; OS doesn't have
ASPM control
[    7.442071] hpsa 0000:05:00.0: Logical aborts not supported
[    7.442075] hpsa 0000:05:00.0: HP SSD Smart Path aborts not
supported
[    7.442164] hpsa 0000:05:00.0: Controller Configuration information
[    7.442167] hpsa 0000:05:00.0: ------------------------------------
[    7.442173] hpsa 0000:05:00.0:    Signature = CISS
[    7.442177] hpsa 0000:05:00.0:    Spec Number = 3
[    7.442182] hpsa 0000:05:00.0:    Transport methods supported =
0x7a000007
[    7.442186] hpsa 0000:05:00.0:    Transport methods active = 0x3
[    7.442190] hpsa 0000:05:00.0:    Requested transport Method = 0x2
[    7.442194] hpsa 0000:05:00.0:    Coalesce Interrupt Delay = 0x0
[    7.442198] hpsa 0000:05:00.0:    Coalesce Interrupt Count = 0x1
[    7.442202] hpsa 0000:05:00.0:    Max outstanding commands = 1024
[    7.442206] hpsa 0000:05:00.0:    Bus Types = 0x200000
[    7.442220] hpsa 0000:05:00.0:    Server Name = 2M21220149
[    7.442224] hpsa 0000:05:00.0:    Heartbeat Counter = 0xd23
[    7.442224] 
[    7.442224] 
..
..
  246.751135] INFO: task systemd-udevd:413 blocked for more than 120
seconds.
[  246.788008]       Tainted: G          I      4.15.0-rc4.noming+ #1
[  246.822380] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.865594] systemd-udevd   D    0   413    411 0x80000004
[  246.895519] Call Trace:
[  246.909713]  ? __schedule+0x340/0xc20
[  246.930236]  schedule+0x32/0x80
[  246.947905]  schedule_timeout+0x23d/0x450
[  246.970047]  ? find_held_lock+0x2d/0x90
[  246.991774]  ? wait_for_completion_io+0x108/0x170
[  247.018172]  io_schedule_timeout+0x19/0x40
[  247.041208]  wait_for_completion_io+0x110/0x170
[  247.067326]  ? wake_up_q+0x70/0x70
[  247.086801]  hpsa_scsi_do_simple_cmd+0xc6/0x100 [hpsa]
[  247.114315]  hpsa_scsi_do_simple_cmd_with_retry+0xb7/0x1c0 [hpsa]
[  247.146629]  hpsa_scsi_do_inquiry+0x73/0xd0 [hpsa]
[  247.174118]  hpsa_init_one+0x12cb/0x1a59 [hpsa]
[  247.199851]  ? __pm_runtime_resume+0x55/0x70
[  247.224527]  local_pci_probe+0x3f/0xa0
[  247.246034]  pci_device_probe+0x146/0x1b0
[  247.268413]  driver_probe_device+0x2b3/0x4a0
[  247.291868]  __driver_attach+0xda/0xe0
[  247.313370]  ? driver_probe_device+0x4a0/0x4a0
[  247.338399]  bus_for_each_dev+0x6a/0xb0
[  247.359912]  bus_add_driver+0x41/0x260
[  247.380244]  driver_register+0x5b/0xd0
[  247.400811]  ? 0xffffffffc016b000
[  247.418819]  hpsa_init+0x38/0x1000 [hpsa]
[  247.440763]  ? 0xffffffffc016b000
[  247.459451]  do_one_initcall+0x4d/0x19c
[  247.480539]  ? do_init_module+0x22/0x220
[  247.502575]  ? rcu_read_lock_sched_held+0x64/0x70
[  247.529549]  ? kmem_cache_alloc_trace+0x1f7/0x260
[  247.556204]  ? do_init_module+0x22/0x220
[  247.578633]  do_init_module+0x5a/0x220
[  247.600322]  load_module+0x21e8/0x2a50
[  247.621648]  ? __symbol_put+0x60/0x60
[  247.642796]  SYSC_finit_module+0x94/0xe0
[  247.665336]  entry_SYSCALL_64_fastpath+0x1f/0x96
[  247.691751] RIP: 0033:0x7fc63d6527f9
[  247.712308] RSP: 002b:00007ffdf1659ba8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  247.755272] RAX: ffffffffffffffda RBX: 0000556b524c5f70 RCX:
00007fc63d6527f9
[  247.795779] RDX: 0000000000000000 RSI: 00007fc63df6f099 RDI:
0000000000000008
[  247.836413] RBP: 00007fc63df6f099 R08: 0000000000000000 R09:
0000556b524be760
[  247.876395] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000000
[  247.917597] R13: 0000556b524c5f10 R14: 0000000000020000 R15:
0000000000000000
[  247.957272] 
[  247.957272] Showing all locks held in the system:
[  247.992019] 1 lock held by khungtaskd/118:
[  248.015019]  #0:  (tasklist_lock){.+.+}, at: [<000000004ef3538d>]
debug_show_all_locks+0x39/0x1b0
[  248.064600] 2 locks held by systemd-udevd/413:
[  248.090031]  #0:  (&dev->mutex){....}, at: [<000000002a395ec8>]
__driver_attach+0x4a/0xe0
[  248.136620]  #1:  (&dev->mutex){....}, at: [<00000000d9def23c>]
__driver_attach+0x58/0xe0
[  248.183245] 
[  248.191675] =============================================
[  248.191675] 
[  314.825134] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  315.368421] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  315.894373] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  316.418385] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  316.944461] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  317.466708] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  317.994380] dracut-initqueue[437]: Warning: dracut-initqueue timeout
- starti
