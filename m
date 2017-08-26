Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Subject: kernel panic in generic_make_request() in block/blk-core.c
Message-ID: <b1c7bf39-bf44-6912-4bda-e8c6c8eb251f@linux.intel.com>
Date: Fri, 25 Aug 2017 17:03:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi All,

I am trying to use the latest (4.13-rc6) kernel in my android device 
(Intel APL SOC, running Android O). But sometimes, during the boot 
process, when MMC partition is getting mounted, I hit the following 
kernel panic. Its not 100% reproducible. But I hit it twice in 10 
cycles. Copied the dmesg log for your reference.

After my initial analysis I found that the panic happens in 
generic_make_request(struct bio *bio) function in block/bio-core.c. To 
be exact, its happening when q->make_request_fn pointer becomes NULL.

2194                         ret = q->make_request_fn(q, bio);

I am wondering whether any of you came across such issue.  Please let me 
know your comments.

jmp 0x00100000 (setup @0x14430910)
[    0.262030] ACPI Error: Method parse/execution failed \_SB.PCI0.I2C4.HDAC._CRS, AE_AML_NO_R)
[    0.262030] ACPI Error: Method execution failed \_SB.PCI0.I2C4.HDAC._CRS, AE_AML_NO_RESOURC)
[    0.291237] ACPI Error: Method parse/execution failed \_SB.PCI0.I2C4.HDAC._CRS, AE_AML_NO_R)
[    0.291618] ACPI Error: Method execution failed \_SB.PCI0.I2C4.HDAC._CRS, AE_AML_NO_RESOURC)
[    0.299845] dmi: Firmware registration failed.
[    0.355993] intel_punit_ipc intel_punit_ipc: can't request region for resource [mem 0x00000]
[    0.356507] intel_punit_ipc intel_punit_ipc: can't request region for resource [mem 0x00000]
[    0.356782] intel_punit_ipc intel_punit_ipc: can't request region for resource [mem 0x00000]
[    0.357092] intel_punit_ipc intel_punit_ipc: can't request region for resource [mem 0x00000]
[    0.376350] i915 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x07c
[    0.784294] intel_powerclamp: CPU does not support MWAIT
[    0.792623] BUG: sleeping function called from invalid context at /var/work/CodeBase/androi8
[    0.807057] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[    0.814466] Preemption disabled at:
[    0.822490] genirq: Setting trigger mode 3 for irq 348 failed (intel_gpio_irq_type+0x0/0x13)
[    0.833719] dmi-sysfs: dmi entry is absent.
[    0.841197] sth 0-sth: stm_register_device failed
[    0.858540] device-mapper: table: 253:0: verity: Data device lookup failed
[    0.866429] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    0.875181] IP:           (null)
[    0.878784] PGD 0
[    0.878785] P4D 0
[    0.881027]
[    0.884925] Oops: 0010 [#1] PREEMPT SMP
[    0.889206] Modules linked in:
[    0.892621] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G     U  W       4.13.0-rc6-quilt-2e5dc01
[    0.902446] task: ffff8c1676a06040 task.stack: ffffad7180010000
[    0.909054] RIP: 0010:          (null)
[    0.913239] RSP: 0000:ffffad7180013a30 EFLAGS: 00010246
[    0.915596] mmc1: new HS400 MMC card at address 0001
[    0.915787] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
[    0.915858] mmcblk1boot0: mmc1:0001 R1J56L partition 1 4.00 MiB
[    0.915925] mmcblk1boot1: mmc1:0001 R1J56L partition 2 4.00 MiB
[    0.915995] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
[    0.918195]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19
[    0.958453] RAX: 0000000000000000 RBX: ffff8c16749f1cc0 RCX: 0000000000000000
[    0.966429] RDX: 0000000000000000 RSI: ffff8c16749f1cc0 RDI: ffff8c16749c3370
[    0.974404] RBP: ffffad7180013a88 R08: 0000000000000001 R09: ffff8c16749f1d30
[    0.982372] R10: fffffc51c9d34d40 R11: ffff8c16754c72c0 R12: ffff8c16749c3370
[    0.990334] R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000000
[    0.998308] FS:  0000000000000000(0000) GS:ffff8c167fc80000(0000) knlGS:0000000000000000
[    1.007354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.013771] CR2: 0000000000000000 CR3: 000000019a212000 CR4: 00000000003406e0
[    1.021757] Call Trace:
[    1.024499]  ? generic_make_request+0x122/0x320
[    1.029565]  submit_bio+0x73/0x160
[    1.033363]  submit_bh_wbc.isra.44+0x113/0x140
[    1.038323]  __bread_gfp+0x67/0x120
[    1.042207]  ext4_fill_super+0x184/0x3880
[    1.046684]  ? vsnprintf+0x201/0x490
[    1.050676]  ? set_bdev_super+0x30/0x30
[    1.054958]  ? snprintf+0x43/0x60
[    1.058656]  mount_bdev+0x17d/0x1b0
[    1.062548]  ? ext4_calculate_overhead+0x430/0x430
[    1.067905]  ext4_mount+0x15/0x20
[    1.071603]  mount_fs+0x153/0x180
[    1.075302]  vfs_kern_mount+0x90/0x180
[    1.079488]  do_mount+0x1e0/0xd00
[    1.083189]  ? _copy_from_user+0x60/0xb0
[    1.087570]  ? memdup_user+0x53/0x80
[    1.091562]  SyS_mount+0x94/0xd0
[    1.095166]  mount_block_root+0x105/0x2c4
[    1.099641]  mount_root+0x6d/0x71
[    1.103340]  prepare_namespace+0x172/0x19f
[    1.107911]  kernel_init_freeable+0x21f/0x243
[    1.112774]  ? rest_init+0xd0/0xd0
[    1.116569]  kernel_init+0xe/0x100
[    1.120364]  ret_from_fork+0x27/0x40
[    1.124347] Code:  Bad RIP value.
[    1.128051] RIP:           (null) RSP: ffffad7180013a30
[    1.133879] CR2: 0000000000000000
[    1.137579] ---[ end trace b3d4f4f1eb2bcb37 ]---
[    1.141014] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    1.153684] Kernel panic - not syncing: Fatal exception
[    1.159540] reboot: panic mode set: p,w
[    1.163821] Kernel Offset: 0x10000000 from 0xffffffff81000000 (relocation range: 0xffffffff)
[    1.175871] trusty-log panic notifier - trusty version 14:01:21 Aug 24 2017
[    1.179503] Rebooting in 10 seconds..



-- 

Sathyanarayanan Kuppuswamy
Linux kernel developer
