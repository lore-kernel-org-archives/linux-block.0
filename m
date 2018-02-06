Return-Path: <efault@gmx.de>
Message-ID: <1517918234.25841.31.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  linux-block <linux-block@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>, Alban Browaeys <alban.browaeys@gmail.com>,
 ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it, Serena
 Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 12:57:14 +0100
In-Reply-To: <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
	 <1517903761.9843.12.camel@gmx.de>
	 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-06 at 10:38 +0100, Paolo Valente wrote:
>=20
> Hi Mike,
> as you can imagine, I didn't get any failure in my pre-submission
> tests on this patch.  In addition, it is not that easy to link this
> patch, which just adds some internal bfq housekeeping in case of a
> requeue, with a corruption of external lists for general I/O
> management.
>=20
> In this respect, as Oleksandr comments point out, by switching from
> cfq to bfq, you switch between much more than two schedulers.  Anyway,
> who knows ...

Not me. =A0Box seems to be fairly sure that it is bfq.  Twice again box
went belly up on me in fairly short order with bfq, but seemed fine
with deadline.  I'm currently running deadline again, and box again
seems solid, thought I won't say _is_ solid until it's been happily
trundling along with deadline for a quite a bit longer.

I was ssh'd in during the last episode, got this out.  I should be
getting crash dumps, but seems kdump is only working intermittently
atm. =A0I did get one earlier, but 3 of 4 times not. =A0Hohum.

[  484.179292] BUG: unable to handle kernel paging request at ffffffffa0817=
000
[  484.179436] IP: __trace_note_message+0x1f/0xd0
[  484.179576] PGD 1e0c067 P4D 1e0c067 PUD 1e0d063 PMD 3faff2067 PTE 0
[  484.179719] Oops: 0000 [#1] SMP PTI
[  484.179861] Dumping ftrace buffer:
[  484.180011]    (ftrace buffer empty)
[  484.180138] Modules linked in: fuse(E) ebtable_filter(E) ebtables(E) af_=
packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) nf_conn=
track_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) xt_tcpudp(E) iptable_filter(E=
) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) n=
f_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_connt=
rack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_c=
p437(E) intel_rapl(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_c=
odec_hdmi(E) coretemp(E) kvm_intel(E) snd_hda_codec_realtek(E) kvm(E) snd_h=
da_codec_generic(E) snd_hda_intel(E) snd_hda_codec(E) sr_mod(E) snd_hwdep(E=
) cdrom(E) joydev(E) snd_hda_core(E) snd_pcm(E) snd_timer(E) irqbypass(E) s=
nd(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) r8169(E)
[  484.180740]  iTCO_wdt(E) ghash_clmulni_intel(E) mii(E) iTCO_vendor_suppo=
rt(E) pcbc(E) aesni_intel(E) soundcore(E) aes_x86_64(E) shpchp(E) crypto_si=
md(E) lpc_ich(E) glue_helper(E) i2c_i801(E) mei_me(E) mfd_core(E) mei(E) cr=
yptd(E) intel_smartconnect(E) pcspkr(E) fan(E) thermal(E) nfsd(E) auth_rpcg=
ss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) hid_logitech_hidpp(E) hid_logi=
tech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E)=
 i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(=
E) fb_sys_fops(E) ahci(E) xhci_pci(E) ehci_pci(E) libahci(E) ttm(E) ehci_hc=
d(E) xhci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod(E) v=
fat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E) vir=
tio(E) ext4(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E)
[  484.181421]  dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) sc=
si_mod(E) efivarfs(E) autofs4(E)
[  484.181583] CPU: 3 PID: 500 Comm: kworker/3:1H Tainted: G            E  =
  4.15.0.ge237f98-master #609
[  484.181746] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  484.181910] Workqueue: kblockd blk_mq_requeue_work
[  484.182076] RIP: 0010:__trace_note_message+0x1f/0xd0
[  484.182250] RSP: 0018:ffff8803f45bfc20 EFLAGS: 00010282
[  484.182436] RAX: 0000000000000000 RBX: ffffffffa0817000 RCX: 00000000fff=
f8803
[  484.182622] RDX: ffffffff81bf514d RSI: 0000000000000000 RDI: ffffffffa08=
17000
[  484.182810] RBP: ffff8803f45bfc80 R08: 0000000000000041 R09: ffff8803f69=
cc5d0
[  484.182998] R10: ffff8803f80b47d0 R11: 0000000000001000 R12: ffff8803f45=
e8000
[  484.183185] R13: 000000000000000d R14: 0000000000000000 R15: ffff8803fba=
112c0
[  484.183372] FS:  0000000000000000(0000) GS:ffff88041ecc0000(0000) knlGS:=
0000000000000000
[  484.183561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  484.183747] CR2: ffffffffa0817000 CR3: 0000000001e0a006 CR4: 00000000001=
606e0
[  484.183934] Call Trace:
[  484.184122]  bfq_put_queue+0xd3/0xe0
[  484.184305]  bfq_finish_requeue_request+0x72/0x350
[  484.184493]  __blk_mq_requeue_request+0x8f/0x120
[  484.184678]  blk_mq_dispatch_rq_list+0x342/0x550
[  484.184866]  ? kyber_dispatch_request+0xd0/0xd0
[  484.185053]  blk_mq_sched_dispatch_requests+0xf7/0x180
[  484.185238]  __blk_mq_run_hw_queue+0x58/0xd0
[  484.185429]  __blk_mq_delay_run_hw_queue+0x99/0xa0
[  484.185614]  blk_mq_run_hw_queue+0x54/0xf0
[  484.185805]  blk_mq_run_hw_queues+0x4b/0x60
[  484.185994]  blk_mq_requeue_work+0x13a/0x150
[  484.186192]  process_one_work+0x147/0x350
[  484.186383]  worker_thread+0x47/0x3e0
[  484.186572]  kthread+0xf8/0x130
[  484.186760]  ? rescuer_thread+0x360/0x360
[  484.186948]  ? kthread_stop+0x120/0x120
[  484.187137]  ret_from_fork+0x35/0x40
[  484.187321] Code: ff 48 89 44 24 10 e9 58 fd ff ff 90 55 48 89 e5 41 55 =
41 54 53 48 89 fb 48 83 ec 48 48 89 4c 24 30 4c 89 44 24 38 4c 89 4c 24 40 =
<83> 3f 02 0f 85 87 00 00 00 f6 43 21 04 75 0b 48 83 c4 48 5b 41=20
[  484.187525] RIP: __trace_note_message+0x1f/0xd0 RSP: ffff8803f45bfc20
[  484.187727] CR2: ffffffffa0817000
