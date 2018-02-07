Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <82ffc96aacc3945861cbb708df346338@natalenko.name>
Date: Wed, 7 Feb 2018 10:08:52 +0100
Cc: Mike Galbraith <efault@gmx.de>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>,
 Ivan Kozik <ivan@ludios.org>,
 SERENA ZIVIANI <169364@studenti.unimore.it>,
 Serena Ziviani <ziviani.serena@gmail.com>,
 =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Message-Id: <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <77124223e6116350a5184a5199850304@natalenko.name>
 <1517924768.25841.32.camel@gmx.de>
 <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
 <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
 <82ffc96aacc3945861cbb708df346338@natalenko.name>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 06 feb 2018, alle ore 19:35, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi.
>=20
> 06.02.2018 15:50, Paolo Valente wrote:
>> Could you please do a
>> gdb <buildir>/block/bfq-iosched.o # or vmlinux.o if bfq is builtin
>> list *(bfq_finish_requeue_request+0x54)
>> list *(bfq_put_queue+0x10b)
>> for me?
>=20
> Fresh crashes and gdb output are given below. A side note: it is =
harder to trigger things on a slower machine, so clearly some =
timing-bounded race condition there.
>=20
> [  134.276548] BUG: unable to handle kernel NULL pointer dereference =
at           (null)
> [  134.283699] IP: blk_flush_complete_seq+0x20a/0x300
> [  134.288163] PGD 0 P4D 0
> [  134.291284] Oops: 0002 [#1] PREEMPT SMP PTI
> [  134.293842] Modules linked in: bochs_drm ttm nls_iso8859_1 =
kvm_intel nls_cp437 vfat fat drm_kms_helper kvm drm irqbypass psmouse =
iTCO_wdt ppdev iTCO_vendor_support input_leds led_class i2c_i801 =
parport_pc joydev intel_agp parport intel_gtt mousedev lpc_ich rtc_cmos =
syscopyarea evdev sysfillrect agpgart qemu_fw_cfg mac_hid sysimgblt =
fb_sys_fops sch_fq_codel ip_tables x_tables xfs dm_thin_pool =
dm_persistent_data dm_bio_prison dm_bufio libcrc32c crc32c_generic =
dm_crypt algif_skcipher af_alg dm_mod hid_generic usbhid raid10 hid =
md_mod sr_mod sd_mod cdrom uhci_hcd ehci_pci serio_raw crct10dif_pclmul =
crc32_pclmul atkbd crc32c_intel libps2 ghash_clmulni_intel pcbc xhci_pci =
xhci_hcd ehci_hcd aesni_intel aes_x86_64 crypto_simd glue_helper cryptd =
ahci libahci libata usbcore usb_common i8042 serio virtio_scsi
> [  134.340606]  scsi_mod virtio_blk virtio_net virtio_pci virtio_ring =
virtio
> [  134.345803] CPU: 0 PID: 178 Comm: kworker/0:1H Not tainted =
4.15.0-pf2 #1
> [  134.350309] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.0.0 02/06/2015
> [  134.355106] Workqueue: kblockd blk_mq_run_work_fn
> [  134.359034] RIP: 0010:blk_flush_complete_seq+0x20a/0x300
> [  134.367647] RSP: 0000:ffff88000f803ce8 EFLAGS: 00010082
> [  134.371632] RAX: ffff88000d9755c0 RBX: ffff88000d9755a0 RCX: =
ffff88000c9b39a8
> [  134.375675] RDX: 0000000000000000 RSI: ffff88000d9755d0 RDI: =
ffff88000c9b3900
> [  134.381068] RBP: ffff88000d21a990 R08: ffff88000d9755b0 R09: =
0000000000000000
> [  134.386302] R10: ffff8800058ff100 R11: 000000000002000b R12: =
0000000000000000
> [  134.396915] R13: ffff88000d9755f0 R14: 0000000000000046 R15: =
ffff88000d9755a0
> [  134.401140] FS:  0000000000000000(0000) GS:ffff88000f800000(0000) =
knlGS:0000000000000000
> [  134.407361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  134.412384] CR2: 0000000000000000 CR3: 0000000004008006 CR4: =
00000000001606f0
> [  134.416913] Call Trace:
> [  134.420251]  <IRQ>
> [  134.427731]  mq_flush_data_end_io+0xb3/0xf0
> [  134.431848]  scsi_end_request+0x90/0x1e0 [scsi_mod]
> [  134.436424]  scsi_io_completion+0x237/0x650 [scsi_mod]
> [  134.440109]  __blk_mq_complete_request+0xc4/0x150
> [  134.444517]  ? scsi_mq_get_budget+0x110/0x110 [scsi_mod]
> [  134.449603]  ata_scsi_qc_complete+0x8d/0x430 [libata]
> [  134.458487]  ata_qc_complete_multiple+0x8d/0xe0 [libata]
> [  134.461726]  ahci_handle_port_interrupt+0xc9/0x5b0 [libahci]
> [  134.466420]  ahci_handle_port_intr+0x54/0xb0 [libahci]
> [  134.470128]  ahci_single_level_irq_intr+0x3b/0x60 [libahci]
> [  134.473327]  __handle_irq_event_percpu+0x44/0x1e0
> [  134.476700]  handle_irq_event_percpu+0x30/0x70
> [  134.480227]  handle_irq_event+0x37/0x60
> [  134.490341]  handle_edge_irq+0x107/0x1c0
> [  134.492876]  handle_irq+0x1f/0x30
> [  134.495497]  do_IRQ+0x4d/0xe0
> [  134.497963]  common_interrupt+0xa2/0xa2
> [  134.500877]  </IRQ>
> [  134.503129] RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x40
> [  134.506782] RSP: 0000:ffffc90000307d30 EFLAGS: 00000293 ORIG_RAX: =
ffffffffffffffdb
> [  134.511845] RAX: 0000000000000001 RBX: ffff88000db04000 RCX: =
0000000000000008
> [  134.523019] RDX: 0000000000000100 RSI: 0000000000000293 RDI: =
0000000000000293
> [  134.527968] RBP: 0000000000000293 R08: ffffffffffffffff R09: =
0000000000000040
> [  134.532289] R10: 00000000008e66bf R11: 000000000002000b R12: =
0000000000000000
> [  134.536376] R13: ffff88000d26a000 R14: ffff88000b99ac48 R15: =
ffff88000d26a000
> [  134.541046]  ata_scsi_queuecmd+0xa0/0x210 [libata]
> [  134.544363]  scsi_dispatch_cmd+0xe8/0x260 [scsi_mod]
> [  134.552883]  scsi_queue_rq+0x4cf/0x560 [scsi_mod]
> [  134.556811]  blk_mq_dispatch_rq_list+0x8f/0x4c0
> [  134.559741]  blk_mq_sched_dispatch_requests+0x105/0x190
> [  134.563253]  __blk_mq_run_hw_queue+0x80/0x90
> [  134.565540]  process_one_work+0x1df/0x420
> [  134.568041]  worker_thread+0x2b/0x3d0
> [  134.571032]  ? process_one_work+0x420/0x420
> [  134.573964]  kthread+0x113/0x130
> [  134.584370]  ? kthread_create_on_node+0x70/0x70
> [  134.587355]  ret_from_fork+0x35/0x40
> [  134.589796] Code: 39 d0 0f 84 8f 00 00 00 48 8b 97 b0 00 00 00 49 =
c1 e0 04 45 31 e4 48 8b b7 a8 00 00 00 49 01 d8 48 8d 8f a8 00 00 00 48 =
89 56 08 <48> 89 32 49 8b 50 18 49 89 48 18 48 89 87 a8 00 00 00 48 89 =
97
> [  134.598881] RIP: blk_flush_complete_seq+0x20a/0x300 RSP: =
ffff88000f803ce8
> [  134.601812] CR2: 0000000000000000
> [  134.603728] ---[ end trace fc6d0cdf33d29717 ]---
> [  134.612349] Kernel panic - not syncing: Fatal exception in =
interrupt
> [  134.615630] Kernel Offset: disabled
> [  134.617712] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt
>=20
> (gdb) list *(blk_flush_complete_seq+0x20a)
> 0xffffffff813056ca is in blk_flush_complete_seq =
(./include/linux/compiler.h:212).
> 207     {
> 208             switch (size) {
> 209             case 1: *(volatile __u8 *)p =3D *(__u8 *)res; break;
> 210             case 2: *(volatile __u16 *)p =3D *(__u16 *)res; break;
> 211             case 4: *(volatile __u32 *)p =3D *(__u32 *)res; break;
> 212             case 8: *(volatile __u64 *)p =3D *(__u64 *)res; break;
> 213             default:
> 214                     barrier();
> 215                     __builtin_memcpy((void *)p, (const void *)res, =
size);
> 216                     barrier();
>=20
> [  231.545605] BUG: unable to handle kernel paging request at =
0000001000000028
> [  231.551962] IP: bfq_put_queue+0x10b/0x130
> [  231.556307] PGD 0 P4D 0
> [  231.558939] Oops: 0000 [#1] PREEMPT SMP PTI
> [  231.562149] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat =
kvm_intel kvm bochs_drm irqbypass ttm iTCO_wdt ppdev drm_kms_helper =
iTCO_vendor_support psmouse input_leds drm led_class joydev parport_pc =
mousedev intel_agp syscopyarea parport intel_gtt sysfillrect i2c_i801 =
evdev sysimgblt agpgart rtc_cmos qemu_fw_cfg mac_hid fb_sys_fops lpc_ich =
sch_fq_codel ip_tables x_tables xfs dm_thin_pool dm_persistent_data =
dm_bio_prison dm_bufio libcrc32c crc32c_generic dm_crypt algif_skcipher =
af_alg dm_mod hid_generic usbhid hid raid10 md_mod sr_mod cdrom sd_mod =
serio_raw atkbd libps2 uhci_hcd crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc xhci_pci aesni_intel aes_x86_64 =
ehci_pci xhci_hcd ehci_hcd ahci crypto_simd glue_helper libahci cryptd =
usbcore libata usb_common i8042 serio virtio_scsi
> [  231.608289]  scsi_mod virtio_blk virtio_net virtio_pci virtio_ring =
virtio
> [  231.613610] CPU: 0 PID: 187 Comm: kworker/0:1H Not tainted =
4.15.0-pf2 #1
> [  231.619675] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.0.0 02/06/2015
> [  231.624477] Workqueue: kblockd blk_mq_requeue_work
> [  231.628532] RIP: 0010:bfq_put_queue+0x10b/0x130
> [  231.635453] RSP: 0000:ffffc90000377c98 EFLAGS: 00010282
> [  231.638621] RAX: 0000001000000000 RBX: ffff88000cdf20f0 RCX: =
0000000000000000
> [  231.642332] RDX: 0000000000000000 RSI: ffff88000d4926d8 RDI: =
ffff88000cdf2120
> [  231.647000] RBP: 000000000d4926a8 R08: 0000000000000041 R09: =
ffff88000cdf20f0
> [  231.652682] R10: 0000000000105a7f R11: 000000000002000b R12: =
ffff88000cdf2120
> [  231.657102] R13: ffff88000e152188 R14: 0000000000000041 R15: =
0000000000000000
> [  231.661213] FS:  0000000000000000(0000) GS:ffff88000f800000(0000) =
knlGS:0000000000000000
> [  231.664746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  231.667647] CR2: 0000001000000028 CR3: 0000000004008002 CR4: =
00000000001606f0
> [  231.671475] Call Trace:
> [  231.673873]  bfq_finish_requeue_request+0x54/0x380
> [  231.676823]  __blk_mq_requeue_request+0x5c/0x140
> [  231.679465]  blk_mq_dispatch_rq_list+0x1b4/0x4c0
> [  231.681798]  blk_mq_sched_dispatch_requests+0x105/0x190
> [  231.685059]  __blk_mq_run_hw_queue+0x80/0x90
> [  231.687750]  __blk_mq_delay_run_hw_queue+0x92/0xe0
> [  231.691510]  blk_mq_run_hw_queue+0x25/0x90
> [  231.694759]  blk_mq_run_hw_queues+0x3a/0x50
> [  231.696706]  blk_mq_requeue_work+0x116/0x140
> [  231.699340]  process_one_work+0x1df/0x420
> [  231.703147]  worker_thread+0x2b/0x3d0
> [  231.705322]  ? process_one_work+0x420/0x420
> [  231.707002]  kthread+0x113/0x130
> [  231.708494]  ? kthread_create_on_node+0x70/0x70
> [  231.710209]  ? kthread_create_on_node+0x70/0x70
> [  231.712754]  ret_from_fork+0x35/0x40
> [  231.715068] Code: c1 e8 06 83 e0 01 48 83 f8 01 45 19 f6 e8 be 3b =
00 00 41 83 e6 ee 48 89 c7 41 83 c6 53 e8 8e 3b 00 00 49 89 d9 45 89 f0 =
44 89 f9 <48> 8b 70 28 48 c7 c2 3a 9a e5 81 55 4c 89 ef e8 11 1c e0 ff =
8b
> [  231.725379] RIP: bfq_put_queue+0x10b/0x130 RSP: ffffc90000377c98
> [  231.728391] CR2: 0000001000000028
> [  231.730840] ---[ end trace 03bd81aa0d2b1434 ]---
> [  231.733269] note: kworker/0:1H[187] exited with preempt_count 1
>=20
> (gdb) l *(bfq_put_queue+0x10b)
> 0xffffffff81334d1b is in bfq_put_queue (block/bfq-iosched.c:3978).
> 3973    #ifdef CONFIG_BFQ_GROUP_IOSCHED
> 3974            struct bfq_group *bfqg =3D bfqq_group(bfqq);
> 3975    #endif
> 3976
> 3977            if (bfqq->bfqd)
> 3978                    bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p =
%d",
> 3979                                 bfqq, bfqq->ref);
> 3980
> 3981            bfqq->ref--;
> 3982            if (bfqq->ref)
>=20
> (gdb) l *(bfq_finish_requeue_request+0x54)
> 0xffffffff81335294 is in bfq_finish_requeue_request =
(block/bfq-iosched.c:4804).
> 4799             * that re-insertions of requeued requests, without
> 4800             * re-preparation, can happen only for pass_through or =
at_head
> 4801             * requests (which are not re-inserted into bfq =
internal
> 4802             * queues).
> 4803             */
> 4804            rq->elv.priv[0] =3D NULL;
> 4805            rq->elv.priv[1] =3D NULL;
> 4806    }
> 4807
> 4808    /*
>=20
> [  322.939697] BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000008
> [  322.944283] IP: blk_flush_complete_seq+0x206/0x300
> [  322.947463] PGD 0 P4D 0
> [  322.950266] Oops: 0002 [#2] PREEMPT SMP PTI
> [  322.958898] Modules linked in: kvm_intel bochs_drm nls_iso8859_1 =
nls_cp437 vfat fat ttm kvm drm_kms_helper drm iTCO_wdt irqbypass psmouse =
ppdev iTCO_vendor_support input_leds led_class i2c_i801 intel_agp =
parport_pc intel_gtt joydev lpc_ich rtc_cmos agpgart evdev parport =
syscopyarea mousedev qemu_fw_cfg sysfillrect mac_hid sysimgblt =
fb_sys_fops sch_fq_codel ip_tables x_tables xfs dm_thin_pool =
dm_persistent_data dm_bio_prison dm_bufio libcrc32c crc32c_generic =
dm_crypt algif_skcipher af_alg dm_mod hid_generic usbhid hid =
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel raid10 =
pcbc md_mod sr_mod cdrom sd_mod serio_raw atkbd libps2 uhci_hcd xhci_pci =
xhci_hcd ahci ehci_pci libahci aesni_intel aes_x86_64 crypto_simd =
glue_helper ehci_hcd cryptd libata usbcore usb_common i8042 serio =
virtio_scsi
> [  323.001668]  scsi_mod virtio_blk virtio_net virtio_pci virtio_ring =
virtio
> [  323.006121] CPU: 0 PID: 215 Comm: kworker/u5:1 Tainted: G      D    =
      4.15.0-pf2 #1
> [  323.010263] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 0.0.0 02/06/2015
> [  323.021225] Workqueue: kcryptd kcryptd_crypt [dm_crypt]
> [  323.024947] RIP: 0010:blk_flush_complete_seq+0x206/0x300
> [  323.028405] RSP: 0018:ffff88000f803ed0 EFLAGS: 00010086
> [  323.032491] RAX: ffff88000cfe78b0 RBX: ffff88000cfe78a0 RCX: =
ffff88000d4d85a8
> [  323.036262] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffff88000d4d8500
> [  323.041032] RBP: ffff88000d6510a0 R08: ffff88000cfe78a0 R09: =
0000000000000000
> [  323.051518] R10: ffff88000dab4d00 R11: ffffffffc01aafb0 R12: =
0000000000000000
> [  323.055818] R13: ffff88000cfe78f0 R14: 0000000000000046 R15: =
ffff88000cfe78a0
> [  323.060965] FS:  0000000000000000(0000) GS:ffff88000f800000(0000) =
knlGS:0000000000000000
> [  323.065902] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  323.070571] CR2: 0000000000000008 CR3: 0000000004008001 CR4: =
00000000001606f0
> [  323.076591] Call Trace:
> [  323.081685]  <IRQ>
> [  323.084025]  mq_flush_data_end_io+0xb3/0xf0
> [  323.087155]  scsi_end_request+0x90/0x1e0 [scsi_mod]
> [  323.095768]  scsi_io_completion+0x237/0x650 [scsi_mod]
> [  323.099928]  flush_smp_call_function_queue+0x7c/0xf0
> [  323.104028]  smp_call_function_single_interrupt+0x32/0xf0
> [  323.114170]  call_function_single_interrupt+0xa2/0xb0
> [  323.118208]  </IRQ>
> [  323.121040] RIP: 0010:_aesni_enc4+0x178/0x190 [aesni_intel]
> [  323.124658] RSP: 0018:ffffc900004a7c40 EFLAGS: 00000293 ORIG_RAX: =
ffffffffffffff04
> [  323.128777] RAX: ffffffffc01ab208 RBX: 0000000000000180 RCX: =
0000000000000000
> [  323.133003] RDX: ffff88000daf9c80 RSI: ffff88000a2b3c80 RDI: =
ffff88000cd24260
> [  323.139211] RBP: ffffc900004a7d40 R08: ffff8800089f7718 R09: =
0000000000000010
> [  323.146930] R10: ffff88000cd24290 R11: ffffffffc01aafb0 R12: =
0000000000000080
> [  323.151758] R13: ffffffffc01c90c8 R14: ffff88000a2b3d00 R15: =
ffff88000daf9d00
> [  323.156507]  ? _aesni_enc1+0xac/0xac [aesni_intel]
> [  323.160419]  ? _aesni_dec1+0xac/0xac [aesni_intel]
> [  323.164204]  ? aesni_xts_crypt8+0x21e/0x260 [aesni_intel]
> [  323.167322]  ? glue_xts_req_128bit+0x125/0x1d0 [glue_helper]
> [  323.178383]  ? crypt_convert+0x961/0xef0 [dm_crypt]
> [  323.182089]  ? xts_decrypt+0x40/0x40 [aesni_intel]
> [  323.185825]  ? crypt_convert+0x961/0xef0 [dm_crypt]
> [  323.189438]  ? bio_alloc_bioset+0x132/0x1e0
> [  323.191926]  ? kcryptd_crypt+0x1ff/0x360 [dm_crypt]
> [  323.194998]  ? process_one_work+0x1df/0x420
> [  323.197475]  ? worker_thread+0x2b/0x3d0
> [  323.206991]  ? process_one_work+0x420/0x420
> [  323.210387]  ? kthread+0x113/0x130
> [  323.213396]  ? kthread_create_on_node+0x70/0x70
> [  323.216751]  ? ret_from_fork+0x35/0x40
> [  323.220815] Code: 48 8b 10 48 39 d0 0f 84 8f 00 00 00 48 8b 97 b0 =
00 00 00 49 c1 e0 04 45 31 e4 48 8b b7 a8 00 00 00 49 01 d8 48 8d 8f a8 =
00 00 00 <48> 89 56 08 48 89 32 49 8b 50 18 49 89 48 18 48 89 87 a8 00 =
00
> [  323.233543] RIP: blk_flush_complete_seq+0x206/0x300 RSP: =
ffff88000f803ed0
> [  323.238885] CR2: 0000000000000008
> [  323.241673] ---[ end trace 2ec7b63c3a4a4a02 ]---
> [  323.245006] Kernel panic - not syncing: Fatal exception in =
interrupt
> [  323.248858] Kernel Offset: disabled
> [  323.250753] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt
>=20
> (gdb) l *(blk_flush_complete_seq+0x206)
> 0xffffffff813056c6 is in blk_flush_complete_seq =
(./include/linux/list.h:105).
> 100      * This is only for internal list manipulation where we know
> 101      * the prev/next entries already!
> 102      */
> 103     static inline void __list_del(struct list_head * prev, struct =
list_head * next)
> 104     {
> 105             next->prev =3D prev;
> 106             WRITE_ONCE(prev->next, next);
> 107     }
> 108
> 109     /**


Thank you very much Oleksandr, and Holger, for your listings,
I've managed to make a crash happen, unfortunately only after a lot of
time and I/O.  Unfortunately, the crash happened for one of the call
chains not including bfq.  If you guys have found a way to get these
crashes more or less easily, then I think I'll need your help here.
The first piece of information I need is whether this failure happens
even without "BFQ hierarchical scheduling support".  If it does, then
the area of investigation narrows a little.  So, could you please
retry after disabling hierarchical support?

Thanks,
Paolo
