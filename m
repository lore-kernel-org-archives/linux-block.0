Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 06 Feb 2018 15:07:10 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark
 Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 'Paolo
 Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Alban Browaeys
 <alban.browaeys@gmail.com>, ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <1517924768.25841.32.camel@gmx.de>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <77124223e6116350a5184a5199850304@natalenko.name>
 <1517924768.25841.32.camel@gmx.de>
Message-ID: <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

06.02.2018 14:46, Mike Galbraith wrote:
>> Sorry for the noise, but just to make it clear, are we talking about
>> "deadline" or "mq-deadline" now?
> 
> mq-deadline.

Okay, I've spent a little bit more time on stressing the VM with BFQ + 
this patch enabled, and managed to get it crashed relatively easy just 
by traversing through all the files in the /usr and reading them. 3 
stacktraces from different boots are below:

===
[   33.147909] BUG: unable to handle kernel NULL pointer dereference at  
          (null)
[   33.156874] IP: blk_flush_complete_seq+0x20a/0x300
[   33.160400] PGD 0 P4D 0
[   33.162682] Oops: 0002 [#1] PREEMPT SMP PTI
[   33.166091] Modules linked in: crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel pcbc nls_iso8859_1 nls_cp437 aesni_intel vfat 
aes_x86_64 crypto_simd fat glue_helper cryptd bochs_drm ttm iTCO_wdt 
drm_kms_helper iTCO_vendor_support ppdev psmouse drm input_leds 
led_class syscopyarea intel_agp parport_pc joydev parport evdev rtc_cmos 
mousedev intel_gtt mac_hid i2c_i801 sysfillrect lpc_ich sysimgblt 
agpgart fb_sys_fops qemu_fw_cfg sch_fq_codel ip_tables x_tables 
hid_generic usbhid hid xfs libcrc32c crc32c_generic dm_mod raid10 md_mod 
sr_mod cdrom sd_mod uhci_hcd ahci libahci xhci_pci serio_raw atkbd 
libata ehci_pci virtio_net libps2 xhci_hcd ehci_hcd crc32c_intel 
scsi_mod virtio_pci usbcore virtio_ring usb_common virtio i8042 serio
[   33.226238] CPU: 0 PID: 0 Comm: BFS/0 Not tainted 4.15.0-pf2 #1
[   33.232823] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[   33.245062] RIP: 0010:blk_flush_complete_seq+0x20a/0x300
[   33.247781] RSP: 0018:ffff88001f803ed0 EFLAGS: 00010086
[   33.250184] RAX: ffff8800199b5e00 RBX: ffff8800199b5de0 RCX: 
ffff8800197f72a8
[   33.253220] RDX: 0000000000000000 RSI: ffff8800199b5e10 RDI: 
ffff8800197f7200
[   33.257429] RBP: ffff8800194090a0 R08: ffff8800199b5df0 R09: 
0000000000000000
[   33.260756] R10: ffff88001df2b600 R11: ffff88001f803ce8 R12: 
0000000000000000
[   33.268840] R13: ffff8800199b5e30 R14: 0000000000000046 R15: 
ffff8800199b5de0
[   33.272722] FS:  0000000000000000(0000) GS:ffff88001f800000(0000) 
knlGS:0000000000000000
[   33.276798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.278981] CR2: 0000000000000000 CR3: 0000000004008003 CR4: 
00000000003606f0
[   33.282078] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   33.285566] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   33.289322] Call Trace:
[   33.291094]  <IRQ>
[   33.294208]  mq_flush_data_end_io+0xb3/0xf0
[   33.301226]  scsi_end_request+0x90/0x1e0 [scsi_mod]
[   33.303660]  scsi_io_completion+0x237/0x650 [scsi_mod]
[   33.306833]  flush_smp_call_function_queue+0x7c/0xf0
[   33.311369]  smp_call_function_single_interrupt+0x32/0xf0
[   33.314245]  call_function_single_interrupt+0xa2/0xb0
[   33.316755]  </IRQ>
[   33.318365] RIP: 0010:native_safe_halt+0x2/0x10
[   33.321988] RSP: 0018:ffffffff82003ea0 EFLAGS: 00000202 ORIG_RAX: 
ffffffffffffff04
[   33.324995] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   33.334532] RDX: 0000000000000000 RSI: ffffffff81e43850 RDI: 
ffffffff81e43a9d
[   33.336643] RBP: ffffffff82128080 R08: 0000000e7441b6ce R09: 
ffff88001a4c2c00
[   33.339282] R10: 0000000000000000 R11: ffff88001bceb7f0 R12: 
ffffffff81ea5c92
[   33.344597] R13: 0000000000000000 R14: 0000000000000000 R15: 
000000001e07cd69
[   33.346526]  default_idle+0x18/0x130
[   33.347929]  do_idle+0x167/0x1d0
[   33.349201]  cpu_startup_entry+0x6f/0x80
[   33.350553]  start_kernel+0x4c2/0x4e2
[   33.351822]  secondary_startup_64+0xa5/0xb0
[   33.354470] Code: 39 d0 0f 84 8f 00 00 00 48 8b 97 b0 00 00 00 49 c1 
e0 04 45 31 e4 48 8b b7 a8 00 00 00 49 01 d8 48 8d 8f a8 00 00 00 48 89 
56 08 <48> 89 32 49 8b 50 18 49 89 48 18 48 89 87 a8 00 00 00 48 89 97
[   33.364997] RIP: blk_flush_complete_seq+0x20a/0x300 RSP: 
ffff88001f803ed0
[   33.366759] CR2: 0000000000000000
[   33.367921] ---[ end trace 5179c1a9cbc4eaa2 ]---
[   33.369413] Kernel panic - not syncing: Fatal exception in interrupt
[   33.372089] Kernel Offset: disabled
[   33.374413] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt
===

===
[   30.937747] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000028
[   30.940984] IP: bfq_put_queue+0x10b/0x130
[   30.941609] PGD 0 P4D 0
[   30.941976] Oops: 0000 [#1] PREEMPT SMP PTI
[   30.942560] Modules linked in: crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel nls_iso8859_1 bochs_drm pcbc nls_cp437 vfat ttm 
aesni_intel fat aes_x86_64 crypto_simd glue_helper cryptd drm_kms_helper 
iTCO_wdt drm ppdev iTCO_vendor_support input_leds psmouse led_class 
intel_agp parport_pc joydev mousedev intel_gtt syscopyarea parport 
rtc_cmos evdev sysfillrect sysimgblt agpgart fb_sys_fops i2c_i801 
mac_hid qemu_fw_cfg lpc_ich sch_fq_codel ip_tables x_tables xfs 
libcrc32c crc32c_generic dm_mod raid10 md_mod hid_generic usbhid hid 
sr_mod cdrom sd_mod uhci_hcd ahci libahci serio_raw virtio_net xhci_pci 
ehci_pci atkbd libata libps2 xhci_hcd virtio_pci ehci_hcd virtio_ring 
crc32c_intel scsi_mod usbcore i8042 usb_common virtio serio
[   30.955195] CPU: 2 PID: 181 Comm: kworker/2:1H Not tainted 4.15.0-pf2 
#1
[   30.956649] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[   30.958404] Workqueue: kblockd blk_mq_requeue_work
[   30.959128] RIP: 0010:bfq_put_queue+0x10b/0x130
[   30.960330] RSP: 0018:ffffc90000617c98 EFLAGS: 00010282
[   30.961574] RAX: 0000000000000000 RBX: ffff88001d537210 RCX: 
00000000ffffffff
[   30.962990] RDX: 0000000000000000 RSI: ffff880018a300d8 RDI: 
ffff88001d537240
[   30.964114] RBP: 0000000018a300a8 R08: 0000000000000041 R09: 
ffff88001d537210
[   30.965449] R10: 0000000000432a7f R11: 000000000002000b R12: 
ffff88001d537240
[   30.966798] R13: ffff88001941d6d9 R14: 0000000000000041 R15: 
00000000ffffffff
[   30.969154] FS:  0000000000000000(0000) GS:ffff88001f900000(0000) 
knlGS:0000000000000000
[   30.972781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.974310] CR2: 0000000000000028 CR3: 0000000004008004 CR4: 
00000000003606e0
[   30.975544] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   30.976963] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   30.980515] Call Trace:
[   30.981893]  bfq_finish_requeue_request+0x54/0x380
[   30.983499]  __blk_mq_requeue_request+0x5c/0x140
[   30.988010]  blk_mq_dispatch_rq_list+0x1b4/0x4c0
[   30.989621]  ? __switch_to_asm+0x34/0x70
[   30.991699]  ? __switch_to_asm+0x40/0x70
[   30.994801]  ? stub_ptregs_64+0x11/0x30
[   30.996506]  blk_mq_sched_dispatch_requests+0x105/0x190
[   30.998842]  __blk_mq_run_hw_queue+0x80/0x90
[   31.002840]  __blk_mq_delay_run_hw_queue+0x92/0xe0
[   31.004873]  blk_mq_run_hw_queue+0x25/0x90
[   31.006766]  blk_mq_run_hw_queues+0x3a/0x50
[   31.008725]  blk_mq_requeue_work+0x116/0x140
[   31.011034]  process_one_work+0x1df/0x420
[   31.012841]  worker_thread+0x2b/0x3d0
[   31.014371]  ? process_one_work+0x420/0x420
[   31.016165]  kthread+0x113/0x130
[   31.018432]  ? kthread_create_on_node+0x70/0x70
[   31.020638]  ? do_group_exit+0x33/0xa0
[   31.022188]  ret_from_fork+0x35/0x40
[   31.024845] Code: c1 e8 06 83 e0 01 48 83 f8 01 45 19 f6 e8 be 3b 00 
00 41 83 e6 ee 48 89 c7 41 83 c6 53 e8 8e 3b 00 00 49 89 d9 45 89 f0 44 
89 f9 <48> 8b 70 28 48 c7 c2 12 be e5 81 55 4c 89 ef e8 11 0f e0 ff 8b
[   31.037915] RIP: bfq_put_queue+0x10b/0x130 RSP: ffffc90000617c98
[   31.040346] CR2: 0000000000000028
[   31.042889] ---[ end trace 11f85b2ea2b00253 ]---
[   31.046478] note: kworker/2:1H[181] exited with preempt_count 1
===

===
[   48.629969] BUG: unable to handle kernel NULL pointer dereference at  
          (null)
[   48.632678] IP: blk_flush_complete_seq+0x20a/0x300
[   48.637504] PGD 0 P4D 0
[   48.639647] Oops: 0002 [#1] PREEMPT SMP PTI
[   48.641496] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel 
aes_x86_64 crypto_simd glue_helper bochs_drm cryptd ttm ppdev 
drm_kms_helper iTCO_wdt iTCO_vendor_support input_leds led_class 
intel_agp psmouse joydev drm intel_gtt parport_pc mousedev syscopyarea 
sysfillrect sysimgblt evdev fb_sys_fops parport lpc_ich agpgart mac_hid 
i2c_i801 qemu_fw_cfg rtc_cmos sch_fq_codel ip_tables x_tables xfs 
libcrc32c crc32c_generic dm_mod raid10 hid_generic md_mod usbhid hid 
sr_mod cdrom sd_mod uhci_hcd ahci xhci_pci libahci serio_raw ehci_pci 
atkbd xhci_hcd ehci_hcd virtio_net libps2 libata crc32c_intel scsi_mod 
virtio_pci usbcore virtio_ring usb_common virtio i8042 serio
[   48.663536] CPU: 3 PID: 175 Comm: kworker/3:1H Not tainted 4.15.0-pf2 
#1
[   48.668487] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[   48.672290] Workqueue: kblockd blk_mq_run_work_fn
[   48.674271] RIP: 0010:blk_flush_complete_seq+0x20a/0x300
[   48.676939] RSP: 0000:ffff88001f983ed0 EFLAGS: 00010086
[   48.679617] RAX: ffff88001d721b60 RBX: ffff88001d721b40 RCX: 
ffff8800192f26a8
[   48.681937] RDX: 0000000000000000 RSI: ffff88001d721b70 RDI: 
ffff8800192f2600
[   48.684117] RBP: ffff88001da3a140 R08: ffff88001d721b50 R09: 
0000000000000000
[   48.688197] R10: ffff8800176fdb00 R11: 0000000000000040 R12: 
0000000000000000
[   48.690628] R13: ffff88001d721b90 R14: 0000000000000046 R15: 
ffff88001d721b40
[   48.693943] FS:  0000000000000000(0000) GS:ffff88001f980000(0000) 
knlGS:0000000000000000
[   48.698935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.701592] CR2: 0000000000000000 CR3: 0000000004008002 CR4: 
00000000003606e0
[   48.703861] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   48.705994] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   48.708165] Call Trace:
[   48.709827]  <IRQ>
[   48.712631]  mq_flush_data_end_io+0xb3/0xf0
[   48.714419]  scsi_end_request+0x90/0x1e0 [scsi_mod]
[   48.717553]  scsi_io_completion+0x237/0x650 [scsi_mod]
[   48.721822]  flush_smp_call_function_queue+0x7c/0xf0
[   48.726672]  smp_call_function_single_interrupt+0x32/0xf0
[   48.733743]  call_function_single_interrupt+0xa2/0xb0
[   48.737194]  </IRQ>
[   48.738656] RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x40
[   48.741128] RSP: 0000:ffffc900005e3d30 EFLAGS: 00000293 ORIG_RAX: 
ffffffffffffff04
[   48.745138] RAX: 0000000000000001 RBX: ffff88001d640000 RCX: 
0000000000000012
[   48.747764] RDX: 0000000000040000 RSI: 0000000000000293 RDI: 
0000000000000293
[   48.752698] RBP: 0000000000000293 R08: ffffffffffffffff R09: 
0000000000000090
[   48.755910] R10: 0000000000432a3f R11: 000000000002000b R12: 
0000000000000000
[   48.760517] R13: ffff8800199ef800 R14: ffff880018d29948 R15: 
ffff8800199ef800
[   48.771214]  ata_scsi_queuecmd+0xa0/0x210 [libata]
[   48.774631]  scsi_dispatch_cmd+0xe8/0x260 [scsi_mod]
[   48.777489]  scsi_queue_rq+0x4cf/0x560 [scsi_mod]
[   48.782246]  blk_mq_dispatch_rq_list+0x8f/0x4c0
[   48.787614]  blk_mq_sched_dispatch_requests+0x105/0x190
[   48.790303]  __blk_mq_run_hw_queue+0x80/0x90
[   48.795313]  process_one_work+0x1df/0x420
[   48.798006]  worker_thread+0x2b/0x3d0
[   48.801376]  ? process_one_work+0x420/0x420
[   48.804226]  kthread+0x113/0x130
[   48.806674]  ? kthread_create_on_node+0x70/0x70
[   48.809640]  ret_from_fork+0x35/0x40
[   48.812834] Code: 39 d0 0f 84 8f 00 00 00 48 8b 97 b0 00 00 00 49 c1 
e0 04 45 31 e4 48 8b b7 a8 00 00 00 49 01 d8 48 8d 8f a8 00 00 00 48 89 
56 08 <48> 89 32 49 8b 50 18 49 89 48 18 48 89 87 a8 00 00 00 48 89 97
[   48.822452] RIP: blk_flush_complete_seq+0x20a/0x300 RSP: 
ffff88001f983ed0
[   48.824908] CR2: 0000000000000000
[   48.830677] ---[ end trace 4e5ef1b3dcbb32c5 ]---
[   48.833655] Kernel panic - not syncing: Fatal exception in interrupt
[   48.836166] Kernel Offset: disabled
[   48.837150] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt
===

Revoking my Tested-by tag (:.
