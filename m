Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request
 V2
Date: Wed, 1 Feb 2017 22:01:26 +0000
Message-ID: <1485986472.2560.14.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
	 <1485467235.2540.14.camel@sandisk.com>
	 <e1d5f4e6-c63f-545d-710f-d4d10fa8d2e0@fb.com>
	 <1485472465.2540.19.camel@sandisk.com>
	 <e222c541-3239-104d-e0b0-40d19b012b66@fb.com>
	 <1485474426.2540.25.camel@sandisk.com>
	 <b98195e7-6e04-5a59-8b83-ce2e1c5c4e1a@fb.com>
	 <1485477510.2540.27.camel@sandisk.com>
	 <2d971693-b79d-c1b9-fb2a-f5dd04128c68@fb.com>
	 <1485479738.2540.30.camel@sandisk.com>
	 <ecca734c-7a9c-f060-9335-c2de089849c2@fb.com>
	 <37ab009a-bc2d-d2ae-a875-269ab563a430@fb.com>
	 <9cbf0ce5-ed79-0252-fd2d-34bebaafffa3@fb.com>
	 <1485535925.4267.1.camel@sandisk.com>
	 <2c696943-2a44-4f36-f0f8-0bebceb95a4a@fb.com>
	 <1485825148.2669.18.camel@sandisk.com>
	 <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
	 <1485898487.3113.7.camel@sandisk.com> <1485899692.3113.9.camel@sandisk.com>
	 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
	 <1485910862.3113.12.camel@sandisk.com>
	 <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
	 <1485967586.2560.1.camel@sandisk.com>
	 <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
In-Reply-To: <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-02-01 at 09:13 -0800, Jens Axboe wrote:
> So that's changing the elevator - did this happen while heavy IO was
> going to the drive, or was it idle?

Hello Jens,

I think I figured out what was going on:
* Test 02-mq created scsi-mq SRP paths and multipathd created dm-mq device
  nodes on top of these SRP paths.
* Test 02-sq started with removing the SRP paths and with switching the
  SCSI and DM cores from mq to sq but did not remove the dm-mq device
  nodes. When that test script next performed an SRP log in multipathd
  failed to add the single queue SCSI devices to an existing dm-mq
  device node. In other words, the dm-mq devices had queue_if_no_path
  set but did not have any paths. Hence the lockup for requests sent
  to these dm devices.

I have modified my tests scripts such that the dm device nodes from a
previous test are removed before a new test starts. Since I made that
change I haven't seen any I/O lockup. However, a new issue shows up
sporadically, an issue that I had not yet seen during any test with
a kernel tree from Linus:

[  227.613440] general protection fault: 0000 [#1] SMP
[  227.613495] Modules linked in: dm_service_time ib_srp scsi_transport_srp=
 target_core_user uio target_core_pscsi target_core_file ib_srpt target_cor=
e_iblock target_core_mod brd netconsole xt_CHECKSUM iptable_mangle ipt_MASQ=
UERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat libcrc32c nf_c=
onntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject=
_ipv4 xt_tcpudp tun bridge stp llc ebtable_filter ebtables ip6table_filter =
ip6_tables iptable_filter ip_tables x_tables af_packet ib_ipoib msr rdma_uc=
m ib_ucm ib_uverbs ib_umad rdma_cm configfs ib_cm iw_cm mlx4_ib ib_core sb_=
edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipm=
i_ssif kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmul=
ni_intel pcbc tg3 aesni_intel iTCO_wdt mlx4_core ptp iTCO_vendor_support dc=
dbas aes_x86_64 crypto_simd glue_helper pps_core cryptd pcspkr devlink ipmi=
_si libphy ipmi_devintf fjes ipmi_msghandler tpm_tis tpm_tis_core lpc_ich m=
ei_me mfd_core mei shpchp wmi tpm button hid_generic usbhid mgag200 i2c_alg=
o_bit drm_kms_helper syscopyarea sysfillrect sr_mod sysimgblt fb_sys_fops c=
drom ttm drm ehci_pci ehci_hcd usbcore usb_common sg dm_multipath dm_mod sc=
si_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[  227.613774] CPU: 3 PID: 28 Comm: ksoftirqd/3 Not tainted 4.10.0-rc5-dbg+=
 #1
[  227.613840] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.0.2 1=
1/17/2014
[  227.613893] task: ffff880172a249c0 task.stack: ffffc90001aa8000
[  227.613932] RIP: 0010:rq_completed+0x12/0x90 [dm_mod]
[  227.613965] RSP: 0018:ffffc90001aabda8 EFLAGS: 00010246
[  227.614006] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 00000000000=
00000
[  227.614043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6=
b6b6b
[  227.614074] RBP: ffffc90001aabdc0 R08: ffff8803825f4c38 R09: 00000000000=
00000
[  227.614105] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  227.614137] R13: 0000000000000000 R14: ffffffff81c05120 R15: 00000000000=
00004
[  227.614170] FS:  0000000000000000(0000) GS:ffff88046f2c0000(0000) knlGS:=
0000000000000000
[  227.614209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  227.614239] CR2: 0000557e28bc20d0 CR3: 000000038594e000 CR4: 00000000001=
406e0
[  227.614268] Call Trace:
[  227.614301]  dm_softirq_done+0xe6/0x1e0 [dm_mod]
[  227.614337]  blk_done_softirq+0x88/0xa0
[  227.614369]  __do_softirq+0xba/0x4c0
[  227.614470]  run_ksoftirqd+0x1a/0x50
[  227.614499]  smpboot_thread_fn+0x123/0x1e0
[  227.614529]  kthread+0x107/0x140
[  227.614624]  ret_from_fork+0x2e/0x40
[  227.614648] Code: ff ff 31 f6 48 89 c7 e8 cd 0e 2f e1 5d c3 90 66 2e 0f =
1f 84 00 00 00 00 00 55 48 63 f6 48 89 e5 41 55 41 89 d5 41 54 53 48 89 fb =
<4c> 8b a7 88 02 00 00 f0 ff 8c b7 50 03 00 00 e8 ba 43 ff ff 85=20
[  227.614738] RIP: rq_completed+0x12/0x90 [dm_mod] RSP: ffffc90001aabda8

(gdb) list *(rq_completed+0x12)
0xdd12 is in rq_completed (drivers/md/dm-rq.c:187).
182      * the md may be freed in dm_put() at the end of this function.
183      * Or do dm_get() before calling this function and dm_put() later.
184      */
185     static void rq_completed(struct mapped_device *md, int rw, bool run=
_queue)
186     {
187             struct request_queue *q =3D md->queue;
188             unsigned long flags;
189
190             atomic_dec(&md->pending[rw]);
191

(gdb) disas rq_completed
Dump of assembler code for function rq_completed:
   0x000000000000dd00 <+0>:     push   %rbp
   0x000000000000dd01 <+1>:     movslq %esi,%rsi
   0x000000000000dd04 <+4>:     mov    %rsp,%rbp
   0x000000000000dd07 <+7>:     push   %r13
   0x000000000000dd09 <+9>:     mov    %edx,%r13d
   0x000000000000dd0c <+12>:    push   %r12
   0x000000000000dd0e <+14>:    push   %rbx
   0x000000000000dd0f <+15>:    mov    %rdi,%rbx
   0x000000000000dd12 <+18>:    mov    0x288(%rdi),%r12
   0x000000000000dd19 <+25>:    lock decl 0x350(%rdi,%rsi,4)

So this was caused by an attempt to dereference %rdi =3D 0x6b6b6b6b6b6b6b6b=
.
Hence this is probably a use-after-free of struct mapped_device.

Bart.=
