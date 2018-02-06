Return-Path: <efault@gmx.de>
Message-ID: <1517890939.10232.11.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 alban.browaeys@gmail.com,  ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 05:22:19 +0100
In-Reply-To: <20180205190510.5499-2-paolo.valente@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Paolo,

I applied this to master.today, flipped udev back to bfq and took it
for a spin. =A0Unfortunately, box fairly quickly went boom under load.

[  454.739975] ------------[ cut here ]------------
[  454.739979] list_add corruption. prev->next should be next (000000005f99=
a42a), but was           (null). (prev=3D00000000fc569ec9).
[  454.739989] WARNING: CPU: 3 PID: 0 at lib/list_debug.c:28 __list_add_val=
id+0x6a/0x70
[  454.739990] Modules linked in: fuse(E) ebtable_filter(E) ebtables(E) af_=
packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) nf_conn=
track_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) xt_tcpudp(E) iptable_filter(E=
) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) n=
f_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_connt=
rack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_c=
p437(E) intel_rapl(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_c=
odec_hdmi(E) coretemp(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) =
kvm_intel(E) kvm(E) snd_hda_intel(E) snd_hda_codec(E) snd_hwdep(E) snd_hda_=
core(E) snd_pcm(E) irqbypass(E) snd_timer(E) joydev(E) crct10dif_pclmul(E) =
snd(E) r8169(E) crc32_pclmul(E) mii(E) mei_me(E) soundcore(E)
[  454.740011]  crc32c_intel(E) iTCO_wdt(E) ghash_clmulni_intel(E) iTCO_ven=
dor_support(E) pcbc(E) mei(E) lpc_ich(E) aesni_intel(E) i2c_i801(E) mfd_cor=
e(E) aes_x86_64(E) shpchp(E) intel_smartconnect(E) crypto_simd(E) glue_help=
er(E) cryptd(E) pcspkr(E) fan(E) thermal(E) nfsd(E) auth_rpcgss(E) nfs_acl(=
E) lockd(E) grace(E) sunrpc(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E) hid=
_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) w=
mi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysim=
gblt(E) fb_sys_fops(E) ahci(E) xhci_pci(E) ttm(E) libahci(E) ehci_pci(E) xh=
ci_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod=
(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E=
) virtio(E) ext4(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E)
[  454.740038]  dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) sc=
si_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[  454.740043] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G            E    4.1=
5.0.ge237f98-master #605
[  454.740044] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  454.740046] RIP: 0010:__list_add_valid+0x6a/0x70
[  454.740047] RSP: 0018:ffff88041ecc3ca8 EFLAGS: 00010096
[  454.740048] RAX: 0000000000000075 RBX: ffff8803f33fa8c0 RCX: 00000000000=
00006
[  454.740049] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff88041ec=
d5570
[  454.740050] RBP: ffff8803f596d7e0 R08: 0000000000000000 R09: 00000000000=
00368
[  454.740051] R10: 0000000000000000 R11: ffff88041ecc3a30 R12: ffff8803eb1=
c8828
[  454.740052] R13: ffff8803f33fa940 R14: ffff8803f5852600 R15: ffff8803f59=
6d810
[  454.740053] FS:  0000000000000000(0000) GS:ffff88041ecc0000(0000) knlGS:=
0000000000000000
[  454.740054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  454.740055] CR2: 00000000014d9788 CR3: 0000000001e0a006 CR4: 00000000001=
606e0
[  454.740056] Call Trace:
[  454.740058]  <IRQ>
[  454.740062]  blk_flush_complete_seq+0x2b1/0x370
[  454.740065]  flush_end_io+0x18c/0x280
[  454.740074]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[  454.740079]  scsi_io_completion+0xbb/0x5d0 [scsi_mod]
[  454.740082]  __blk_mq_complete_request+0xb7/0x180
[  454.740084]  blk_mq_complete_request+0x50/0x90
[  454.740087]  ? scsi_vpd_tpg_id+0x90/0x90 [scsi_mod]
[  454.740095]  ata_scsi_qc_complete+0x1d8/0x470 [libata]
[  454.740100]  ata_qc_complete_multiple+0x87/0xd0 [libata]
[  454.740103]  ahci_handle_port_interrupt+0xd4/0x4e0 [libahci]
[  454.740105]  ahci_handle_port_intr+0x6f/0xb0 [libahci]
[  454.740107]  ahci_single_level_irq_intr+0x3b/0x60 [libahci]
[  454.740110]  __handle_irq_event_percpu+0x40/0x1a0
[  454.740112]  handle_irq_event_percpu+0x20/0x50
[  454.740114]  handle_irq_event+0x36/0x60
[  454.740116]  handle_edge_irq+0x90/0x190
[  454.740118]  handle_irq+0x1c/0x30
[  454.740120]  do_IRQ+0x43/0xd0
[  454.740122]  common_interrupt+0xa2/0xa2
[  454.740123]  </IRQ>
[  454.740125] RIP: 0010:cpuidle_enter_state+0xec/0x250
[  454.740126] RSP: 0018:ffff880187febec0 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[  454.740127] RAX: ffff88041ece0040 RBX: ffff88041ece77e8 RCX: 00000000000=
0001f
[  454.740128] RDX: 0000000000000000 RSI: fffffffd9cb7bc38 RDI: 00000000000=
00000
[  454.740129] RBP: 0000000000000005 R08: 0000000000000006 R09: 00000000000=
0024f
[  454.740130] R10: 0000000000000205 R11: 0000000000000018 R12: 00000000000=
00003
[  454.740131] R13: 00000069e09a3c87 R14: 0000000000000003 R15: 00000069e09=
d450c
[  454.740134]  do_idle+0x16a/0x1d0
[  454.740136]  cpu_startup_entry+0x19/0x20
[  454.740138]  start_secondary+0x14e/0x190
[  454.740140]  secondary_startup_64+0xa5/0xb0
[  454.740141] Code: fe 31 c0 48 c7 c7 a0 61 bf 81 e8 12 f7 d8 ff 0f ff 31 =
c0 c3 48 89 d1 48 c7 c7 50 61 bf 81 48 89 f2 48 89 c6 31 c0 e8 f6 f6 d8 ff =
<0f> ff 31 c0 c3 90 48 8b 07 48 b9 00 01 00 00 00 00 ad de 48 8b=20
[  454.740159] ---[ end trace c2b6ab81731e93a0 ]---
[  454.740278] ------------[ cut here ]------------
[  454.740281] list_del corruption. prev->next should be 0000000056dbdea8, =
but was 00000000577efd13
[  454.740286] WARNING: CPU: 3 PID: 0 at lib/list_debug.c:53 __list_del_ent=
ry_valid+0x7c/0xa0
[  454.740287] Modules linked in: fuse(E) ebtable_filter(E) ebtables(E) af_=
packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) nf_conn=
track_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) xt_tcpudp(E) iptable_filter(E=
) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) n=
f_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_connt=
rack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_c=
p437(E) intel_rapl(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_c=
odec_hdmi(E) coretemp(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) =
kvm_intel(E) kvm(E) snd_hda_intel(E) snd_hda_codec(E) snd_hwdep(E) snd_hda_=
core(E) snd_pcm(E) irqbypass(E) snd_timer(E) joydev(E) crct10dif_pclmul(E) =
snd(E) r8169(E) crc32_pclmul(E) mii(E) mei_me(E) soundcore(E)
[  454.740302]  crc32c_intel(E) iTCO_wdt(E) ghash_clmulni_intel(E) iTCO_ven=
dor_support(E) pcbc(E) mei(E) lpc_ich(E) aesni_intel(E) i2c_i801(E) mfd_cor=
e(E) aes_x86_64(E) shpchp(E) intel_smartconnect(E) crypto_simd(E) glue_help=
er(E) cryptd(E) pcspkr(E) fan(E) thermal(E) nfsd(E) auth_rpcgss(E) nfs_acl(=
E) lockd(E) grace(E) sunrpc(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E) hid=
_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) w=
mi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysim=
gblt(E) fb_sys_fops(E) ahci(E) xhci_pci(E) ttm(E) libahci(E) ehci_pci(E) xh=
ci_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod=
(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E=
) virtio(E) ext4(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E)
[  454.740321]  dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) sc=
si_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[  454.740324] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W   E    4.1=
5.0.ge237f98-master #605
[  454.740325] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  454.740327] RIP: 0010:__list_del_entry_valid+0x7c/0xa0
[  454.740328] RSP: 0018:ffff88041ecc3cb8 EFLAGS: 00010096
[  454.740329] RAX: 0000000000000054 RBX: ffff8803f33fa8c0 RCX: 00000000000=
00006
[  454.740330] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff88041ec=
d5570
[  454.740331] RBP: ffff8803f596d7e0 R08: 0000000000000101 R09: 00000000000=
0039d
[  454.740332] R10: 0000000000000000 R11: ffff88041ecc3a40 R12: ffff8803eb1=
c8828
[  454.740333] R13: ffff8803f596d7f0 R14: 0000000000000000 R15: ffff8803f33=
fa940
[  454.740334] FS:  0000000000000000(0000) GS:ffff88041ecc0000(0000) knlGS:=
0000000000000000
[  454.740335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  454.740336] CR2: 00000000014d9788 CR3: 0000000001e0a006 CR4: 00000000001=
606e0
[  454.740337] Call Trace:
[  454.740338]  <IRQ>
[  454.740340]  blk_flush_complete_seq+0x16e/0x370
[  454.740343]  mq_flush_data_end_io+0xb0/0x110
[  454.740348]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[  454.740352]  scsi_io_completion+0x10b/0x5d0 [scsi_mod]
[  454.740354]  __blk_mq_complete_request+0xb7/0x180
[  454.740355]  blk_mq_complete_request+0x50/0x90
[  454.740359]  ? scsi_vpd_tpg_id+0x90/0x90 [scsi_mod]
[  454.740364]  ata_scsi_qc_complete+0x1d8/0x470 [libata]
[  454.740368]  ata_qc_complete_multiple+0x87/0xd0 [libata]
[  454.740371]  ahci_handle_port_interrupt+0xd4/0x4e0 [libahci]
[  454.740373]  ahci_handle_port_intr+0x6f/0xb0 [libahci]
[  454.740374]  ahci_single_level_irq_intr+0x3b/0x60 [libahci]
[  454.740377]  __handle_irq_event_percpu+0x40/0x1a0
[  454.740379]  handle_irq_event_percpu+0x20/0x50
[  454.740380]  handle_irq_event+0x36/0x60
[  454.740382]  handle_edge_irq+0x90/0x190
[  454.740383]  handle_irq+0x1c/0x30
[  454.740385]  do_IRQ+0x43/0xd0
[  454.740386]  common_interrupt+0xa2/0xa2
[  454.740387]  </IRQ>
[  454.740389] RIP: 0010:cpuidle_enter_state+0xec/0x250
[  454.740389] RSP: 0018:ffff880187febec0 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[  454.740391] RAX: ffff88041ece0040 RBX: ffff88041ece77e8 RCX: 00000000000=
0001f
[  454.740392] RDX: 0000000000000000 RSI: fffffffd9cb7bc38 RDI: 00000000000=
00000
[  454.740393] RBP: 0000000000000005 R08: 0000000000000006 R09: 00000000000=
0024f
[  454.740393] R10: 0000000000000205 R11: 0000000000000018 R12: 00000000000=
00003
[  454.740394] R13: 00000069e0a06158 R14: 0000000000000003 R15: 00000069e0a=
1e8c6
[  454.740397]  do_idle+0x16a/0x1d0
[  454.740399]  cpu_startup_entry+0x19/0x20
[  454.740400]  start_secondary+0x14e/0x190
[  454.740402]  secondary_startup_64+0xa5/0xb0
[  454.740403] Code: ff 31 c0 c3 48 89 fe 31 c0 48 c7 c7 80 62 bf 81 e8 8a =
f6 d8 ff 0f ff 31 c0 c3 48 89 fe 31 c0 48 c7 c7 40 62 bf 81 e8 74 f6 d8 ff =
<0f> ff 31 c0 c3 48 89 fe 31 c0 48 c7 c7 08 62 bf 81 e8 5e f6 d8=20
[  454.740421] ---[ end trace c2b6ab81731e93a1 ]---
[  454.740429] BUG: unable to handle kernel NULL pointer dereference at    =
       (null)
[  454.740980] IP: __list_del_entry_valid+0x25/0xa0
[  454.741509] PGD 0 P4D 0=20
[  454.742026] Oops: 0000 [#1] SMP PTI
[  454.742525] Dumping ftrace buffer:
[  454.743040]    (ftrace buffer empty)
[  454.743529] Modules linked in: fuse(E) ebtable_filter(E) ebtables(E) af_=
packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) nf_conn=
track_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) xt_tcpudp(E) iptable_filter(E=
) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) n=
f_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_connt=
rack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_c=
p437(E) intel_rapl(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_c=
odec_hdmi(E) coretemp(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) =
kvm_intel(E) kvm(E) snd_hda_intel(E) snd_hda_codec(E) snd_hwdep(E) snd_hda_=
core(E) snd_pcm(E) irqbypass(E) snd_timer(E) joydev(E) crct10dif_pclmul(E) =
snd(E) r8169(E) crc32_pclmul(E) mii(E) mei_me(E) soundcore(E)
[  454.745917]  crc32c_intel(E) iTCO_wdt(E) ghash_clmulni_intel(E) iTCO_ven=
dor_support(E) pcbc(E) mei(E) lpc_ich(E) aesni_intel(E) i2c_i801(E) mfd_cor=
e(E) aes_x86_64(E) shpchp(E) intel_smartconnect(E) crypto_simd(E) glue_help=
er(E) cryptd(E) pcspkr(E) fan(E) thermal(E) nfsd(E) auth_rpcgss(E) nfs_acl(=
E) lockd(E) grace(E) sunrpc(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E) hid=
_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) w=
mi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysim=
gblt(E) fb_sys_fops(E) ahci(E) xhci_pci(E) ttm(E) libahci(E) ehci_pci(E) xh=
ci_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod=
(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E=
) virtio(E) ext4(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E)
[  454.748901]  dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) sc=
si_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[  454.749679] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W   E    4.1=
5.0.ge237f98-master #605
[  454.750472] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  454.751273] RIP: 0010:__list_del_entry_valid+0x25/0xa0
[  454.752057] RSP: 0018:ffff88041ecc3cb8 EFLAGS: 00010007
[  454.752842] RAX: 0000000000000000 RBX: ffff8803f5852580 RCX: dead0000000=
00200
[  454.753633] RDX: 0000000000000000 RSI: ffff8803f596d7e0 RDI: ffff8803f58=
52600
[  454.754427] RBP: ffff8803f596d7e0 R08: 0000000000000004 R09: 00000000000=
00000
[  454.755220] R10: ffff8803f71583d0 R11: 0000000000001000 R12: ffff8803eb1=
c8828
[  454.756010] R13: ffff8803f596d800 R14: 0000000000000000 R15: ffff8803f58=
52600
[  454.756798] FS:  0000000000000000(0000) GS:ffff88041ecc0000(0000) knlGS:=
0000000000000000
[  454.757591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  454.758383] CR2: 0000000000000000 CR3: 0000000001e0a006 CR4: 00000000001=
606e0
[  454.759194] Call Trace:
[  454.760012]  <IRQ>
[  454.760802]  blk_flush_complete_seq+0x16e/0x370
[  454.761636]  mq_flush_data_end_io+0xb0/0x110
[  454.762488]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[  454.763295]  scsi_io_completion+0x10b/0x5d0 [scsi_mod]
[  454.764099]  __blk_mq_complete_request+0xb7/0x180
[  454.764906]  blk_mq_complete_request+0x50/0x90
[  454.765715]  ? scsi_vpd_tpg_id+0x90/0x90 [scsi_mod]
[  454.766528]  ata_scsi_qc_complete+0x1d8/0x470 [libata]
[  454.767357]  ata_qc_complete_multiple+0x87/0xd0 [libata]
[  454.768187]  ahci_handle_port_interrupt+0xd4/0x4e0 [libahci]
[  454.769001]  ahci_handle_port_intr+0x6f/0xb0 [libahci]
[  454.769812]  ahci_single_level_irq_intr+0x3b/0x60 [libahci]
[  454.770625]  __handle_irq_event_percpu+0x40/0x1a0
[  454.771437]  handle_irq_event_percpu+0x20/0x50
[  454.772248]  handle_irq_event+0x36/0x60
[  454.773053]  handle_edge_irq+0x90/0x190
[  454.773857]  handle_irq+0x1c/0x30
[  454.774660]  do_IRQ+0x43/0xd0
[  454.775460]  common_interrupt+0xa2/0xa2
[  454.776283]  </IRQ>
[  454.777075] RIP: 0010:cpuidle_enter_state+0xec/0x250
[  454.777870] RSP: 0018:ffff880187febec0 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[  454.778678] RAX: ffff88041ece0040 RBX: ffff88041ece77e8 RCX: 00000000000=
0001f
[  454.779487] RDX: 0000000000000000 RSI: fffffffd9cb7bc38 RDI: 00000000000=
00000
[  454.780299] RBP: 0000000000000005 R08: 0000000000000006 R09: 00000000000=
0024f
[  454.781110] R10: 0000000000000205 R11: 0000000000000018 R12: 00000000000=
00003
[  454.781919] R13: 00000069e0a06158 R14: 0000000000000003 R15: 00000069e0a=
1e8c6
[  454.782729]  do_idle+0x16a/0x1d0
[  454.783533]  cpu_startup_entry+0x19/0x20
[  454.784339]  start_secondary+0x14e/0x190
[  454.785146]  secondary_startup_64+0xa5/0xb0
[  454.785954] Code: 0f ff 31 c0 c3 90 48 8b 07 48 b9 00 01 00 00 00 00 ad =
de 48 8b 57 08 48 39 c8 74 26 48 b9 00 02 00 00 00 00 ad de 48 39 ca 74 5c =
<48> 8b 12 48 39 d7 75 3e 48 8b 50 08 48 39 d7 75 1f b8 01 00 00=20
[  454.786836] RIP: __list_del_entry_valid+0x25/0xa0 RSP: ffff88041ecc3cb8
[  454.787704] CR2: 0000000000000000
