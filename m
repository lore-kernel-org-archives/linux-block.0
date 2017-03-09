Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <20170309052538.GB17010@yexl-desktop>
References: <20170304014005.23773-1-tahsin@google.com> <20170309052538.GB17010@yexl-desktop>
From: Tahsin Erdogan <tahsin@google.com>
Date: Wed, 8 Mar 2017 23:59:03 -0800
Message-ID: <CAAeU0aO1FXuPFkWMmY5sPBPUGnvORpxp5HisyFQktt3+_khJ-g@mail.gmail.com>
Subject: Re: [lkp-robot] [blkcg] ad63af3cb7: BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, lkp@01.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

This is a good catch!

I will post a v5 of the patch shortly to the other email thread.

On Wed, Mar 8, 2017 at 9:25 PM, kernel test robot <xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed the following commit:
>
> commit: ad63af3cb70378a7f780dbef2387a6d13e53a6c9 ("blkcg: allocate struct blkcg_gq outside request queue spinlock")
> url: https://github.com/0day-ci/linux/commits/Tahsin-Erdogan/blkcg-allocate-struct-blkcg_gq-outside-request-queue-spinlock/20170307-030921
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -m 512M
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +----------------------------------------------------------------+------------+------------+
> |                                                                | 3695539290 | ad63af3cb7 |
> +----------------------------------------------------------------+------------+------------+
> | boot_successes                                                 | 12         | 12         |
> | boot_failures                                                  | 8          | 20         |
> | BUG:kernel_hang_in_test_stage                                  | 8          |            |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h | 0          | 20         |
> +----------------------------------------------------------------+------------+------------+
>
>
>
> [   23.511528] BUG: sleeping function called from invalid context at mm/slab.h:408
> [   23.543085] in_atomic(): 1, irqs_disabled(): 0, pid: 130, name: udevd
> [   23.563283] CPU: 0 PID: 130 Comm: udevd Not tainted 4.10.0-rc7-00236-gad63af3 #1
> [   23.592056] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
> [   23.625535] Call Trace:
> [   23.638139]  dump_stack+0x63/0x8a
> [   23.652227]  ___might_sleep+0xd3/0x120
> [   23.667071]  __might_sleep+0x4a/0x80
> [   23.681760]  kmem_cache_alloc_node_trace+0x1d6/0x1f0
> [   23.699087]  blkg_alloc+0x4b/0x230
> [   23.713446]  blkg_lookup_create+0x3dc/0x610
> [   23.729228]  ? blkg_alloc+0x158/0x230
> [   23.744066]  blkcg_init_queue+0x62/0x100
> [   23.759658]  blk_alloc_queue_node+0x25a/0x2c0
> [   23.775866]  ? set_fdc+0x130/0x130 [floppy]
> [   23.791487]  blk_init_queue_node+0x20/0x60
> [   23.807233]  blk_init_queue+0x13/0x20
> [   23.822104]  floppy_module_init+0x234/0xee2 [floppy]
> [   23.838763]  ? vunmap_page_range+0x221/0x390
> [   23.853604]  ? set_cmos+0x68/0x68 [floppy]
> [   23.868345]  do_one_initcall+0x43/0x180
> [   23.883582]  ? __might_sleep+0x4a/0x80
> [   23.898621]  ? kmem_cache_alloc_trace+0x163/0x1b0
> [   23.915435]  do_init_module+0x5f/0x1f8
> [   23.930273]  load_module+0x149e/0x1b10
> [   23.945372]  ? __symbol_put+0x40/0x40
> [   23.960025]  ? kernel_read_file+0x1a3/0x1c0
> [   23.975740]  ? kernel_read_file_from_fd+0x49/0x80
> [   23.992559]  SYSC_finit_module+0xbc/0xf0
> [   24.007991]  SyS_finit_module+0xe/0x10
> [   24.022920]  entry_SYSCALL_64_fastpath+0x1a/0xa9
> [   24.039327] RIP: 0033:0x7f9380e1f4a9
> [   24.053934] RSP: 002b:00007ffc09ff8698 EFLAGS: 00000202 ORIG_RAX: 0000000000000139
> [   24.082614] RAX: ffffffffffffffda RBX: 0000000000a64c20 RCX: 00007f9380e1f4a9
> [   24.103686] RDX: 0000000000000000 RSI: 00007f93810eb0aa RDI: 0000000000000007
> [   24.124749] RBP: 00007ffc09ff8690 R08: 0000000000000000 R09: 0000000000a63490
> [   24.146260] R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000a64c20
> [   24.167489] R13: 0000000000000000 R14: 0000000000a5a2f0 R15: 0000000000a63490
> [   24.191631] parport_pc 00:04: reported by Plug and Play ACPI
> [   24.254724] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
> [   24.344624] libata version 3.00 loaded.
> [   24.355991] ata_piix 0000:00:01.1: version 2.13
> [   24.380594] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [   24.454024] scsi host0: ata_piix
> [   24.460472] scsi host1: ata_piix
> [   24.460962] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14
> [   24.460985] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15
> [   24.483223] Error: Driver 'pcspkr' is already registered, aborting...
> [   24.640449] ata2.01: NODEV after polling detection
> [   24.643436] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [   24.649435] ata2.00: configured for MWDMA2
> [   24.653487] BUG: sleeping function called from invalid context at mm/slab.h:408
> [   24.653510] in_atomic(): 1, irqs_disabled(): 0, pid: 5, name: kworker/u2:0
> [   24.653515] CPU: 0 PID: 5 Comm: kworker/u2:0 Tainted: G        W       4.10.0-rc7-00236-gad63af3 #1
> [   24.653518] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
> [   24.653548] Workqueue: events_unbound async_run_entry_fn
> [   24.653551] Call Trace:
> [   24.653584]  dump_stack+0x63/0x8a
> [   24.653609]  ___might_sleep+0xd3/0x120
> [   24.653611]  __might_sleep+0x4a/0x80
> [   24.653616]  kmem_cache_alloc_node_trace+0x1d6/0x1f0
> [   24.653643]  blkg_alloc+0x4b/0x230
> [   24.653647]  blkg_lookup_create+0x3dc/0x610
> [   24.653670]  ? blkg_alloc+0x158/0x230
> [   24.653674]  blkcg_init_queue+0x62/0x100
> [   24.653678]  blk_alloc_queue_node+0x25a/0x2c0
> [   24.653706]  scsi_alloc_queue+0x1e/0xf0
> [   24.653709]  scsi_alloc_sdev+0x1d3/0x300
> [   24.653712]  scsi_probe_and_add_lun+0x99d/0xe70
> [   24.653738]  ? rpm_resume+0x1a6/0x6e0
> [   24.653742]  ? __pm_runtime_resume+0x5b/0x90
> [   24.653745]  __scsi_add_device+0xff/0x110
> [   24.653876]  ata_scsi_scan_host+0xa3/0x1d0 [libata]
> [   24.653937]  async_port_probe+0x43/0x60 [libata]
> [   24.653941]  async_run_entry_fn+0x39/0x170
> [   24.653966]  process_one_work+0x1a3/0x480
> [   24.653970]  ? try_to_del_timer_sync+0x4b/0x60
> [   24.653973]  worker_thread+0x4e/0x4d0
> [   24.653997]  kthread+0x10c/0x140
> [   24.654000]  ? process_one_work+0x480/0x480
> [   24.654003]  ? kthread_create_on_node+0x40/0x40
> [   24.654028]  ret_from_fork+0x2c/0x40
> [   24.656370] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [   24.745810] ppdev: user-space parallel port driver
> [   24.849575] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [   24.849599] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   24.854112] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [   25.653532] BUG: sleeping function called from invalid context at mm/slab.h:408
> [   25.653536] in_atomic(): 1, irqs_disabled(): 0, pid: 130, name: udevd
> [   25.653542] CPU: 0 PID: 130 Comm: udevd Tainted: G        W       4.10.0-rc7-00236-gad63af3 #1
> [   25.653564] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
> [   25.653566] Call Trace:
> [   25.653603]  dump_stack+0x63/0x8a
> [   25.653630]  ___might_sleep+0xd3/0x120
> [   25.653634]  __might_sleep+0x4a/0x80
> [   25.653639]  kmem_cache_alloc_node_trace+0x1d6/0x1f0
> [   25.653666]  blkg_alloc+0x4b/0x230
> [   25.653671]  blkg_lookup_create+0x3dc/0x610
> [   25.653695]  ? blkg_alloc+0x158/0x230
> [   25.653701]  blkcg_init_queue+0x62/0x100
> [   25.653726]  blk_alloc_queue_node+0x25a/0x2c0
> [   25.653760]  ? set_fdc+0x130/0x130 [floppy]
> [   25.653802]  blk_init_queue_node+0x20/0x60
> [   25.653827]  blk_init_queue+0x13/0x20
> [   25.653856]  floppy_module_init+0x234/0xee2 [floppy]
> [   25.653861]  ? vunmap_page_range+0x221/0x390
> [   25.653889]  ? set_cmos+0x68/0x68 [floppy]
> [   25.653895]  do_one_initcall+0x43/0x180
> [   25.653898]  ? __might_sleep+0x4a/0x80
> [   25.653923]  ? kmem_cache_alloc_trace+0x163/0x1b0
> [   25.653932]  do_init_module+0x5f/0x1f8
> [   25.653960]  load_module+0x149e/0x1b10
> [   25.653964]  ? __symbol_put+0x40/0x40
> [   25.653990]  ? kernel_read_file+0x1a3/0x1c0
> [   25.653995]  ? kernel_read_file_from_fd+0x49/0x80
> [   25.654020]  SYSC_finit_module+0xbc/0xf0
> [   25.654025]  SyS_finit_module+0xe/0x10
> [   25.654054]  entry_SYSCALL_64_fastpath+0x1a/0xa9
> [   25.654058] RIP: 0033:0x7f9380e1f4a9
> [   25.654060] RSP: 002b:00007ffc09ff8698 EFLAGS: 00000202 ORIG_RAX: 0000000000000139
> [   25.654085] RAX: ffffffffffffffda RBX: 0000000000a64c20 RCX: 00007f9380e1f4a9
> [   25.654088] RDX: 0000000000000000 RSI: 00007f93810eb0aa RDI: 0000000000000007
> [   25.654090] RBP: 00007ffc09ff8690 R08: 0000000000000000 R09: 0000000000a63490
> [   25.654092] R10: 0000000000000007 R11: 0000000000000202 R12: 0000000000a64c20
> [   25.654115] R13: 0000000000000000 R14: 0000000000a5a2f0 R15: 0000000000a63490
> [   25.669580] Floppy drive(s): fd0 is 2.88M AMI BIOS
> [   25.691745] FDC 0 is a S82078B
> [   26.450439] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
>
>
> To reproduce:
>
>         git clone git://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script  # job-script is attached in this email
>
>
>
> Thanks,
> Xiaolong
