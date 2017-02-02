Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdBBSdf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 13:33:35 -0500
Date: Thu, 2 Feb 2017 13:33:35 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170202183334.GB26910@redhat.com>
References: <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
 <1485898487.3113.7.camel@sandisk.com>
 <1485899692.3113.9.camel@sandisk.com>
 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
 <1485910862.3113.12.camel@sandisk.com>
 <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
 <1485967586.2560.1.camel@sandisk.com>
 <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
 <1485986472.2560.14.camel@sandisk.com>
 <1486056424.2816.4.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486056424.2816.4.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02 2017 at 12:27pm -0500,
Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:

> On Wed, 2017-02-01 at 22:01 +0000, Bart Van Assche wrote:
> > However, a new issue shows up sporadically, an issue that I had not yet seen
> > during any test with a kernel tree from Linus:
> >
> > [  227.613440] general protection fault: 0000 [#1] SMP
> > [  227.613495] Modules linked in: dm_service_time ib_srp scsi_transport_srp target_core_user uio target_core_pscsi target_core_file ib_srpt target_core_iblock target_core_mod brd netconsole xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat libcrc32c nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables af_packet ib_ipoib msr rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm configfs ib_cm iw_cm mlx4_ib ib_core sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc tg3 aesni_intel iTCO_wdt mlx4_core ptp iTCO_vendor_support dcdbas aes_x86_64 crypto_simd glue_helper pps_core cryptd pcspkr devlink ipmi_si libphy ipmi_devintf fjes ipmi_msghandler tpm_tis tpm_tis_core lpc_ich mei_me mfd_core mei shpchp wmi tpm button hid_generic usbhid mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sr_mod sysimgblt fb_sys_fops cdrom ttm drm ehci_pci ehci_hcd usbcore usb_common sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
> > [  227.613774] CPU: 3 PID: 28 Comm: ksoftirqd/3 Not tainted 4.10.0-rc5-dbg+ #1
> > [  227.613840] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.0.2 11/17/2014
> > [  227.613893] task: ffff880172a249c0 task.stack: ffffc90001aa8000
> > [  227.613932] RIP: 0010:rq_completed+0x12/0x90 [dm_mod]
> > [  227.613965] RSP: 0018:ffffc90001aabda8 EFLAGS: 00010246
> > [  227.614006] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000000
> > [  227.614043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6b6b
> > [  227.614074] RBP: ffffc90001aabdc0 R08: ffff8803825f4c38 R09: 0000000000000000
> > [  227.614105] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [  227.614137] R13: 0000000000000000 R14: ffffffff81c05120 R15: 0000000000000004
> > [  227.614170] FS:  0000000000000000(0000) GS:ffff88046f2c0000(0000) knlGS:0000000000000000
> > [  227.614209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  227.614239] CR2: 0000557e28bc20d0 CR3: 000000038594e000 CR4: 00000000001406e0
> > [  227.614268] Call Trace:
> > [  227.614301]  dm_softirq_done+0xe6/0x1e0 [dm_mod]
> > [  227.614337]  blk_done_softirq+0x88/0xa0
> > [  227.614369]  __do_softirq+0xba/0x4c0
> > [  227.614470]  run_ksoftirqd+0x1a/0x50
> > [  227.614499]  smpboot_thread_fn+0x123/0x1e0
> > [  227.614529]  kthread+0x107/0x140
> > [  227.614624]  ret_from_fork+0x2e/0x40
> > [  227.614648] Code: ff ff 31 f6 48 89 c7 e8 cd 0e 2f e1 5d c3 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 63 f6 48 89 e5 41 55 41 89 d5 41 54 53 48 89 fb <4c> 8b a7 88 02 00 00 f0 ff 8c b7 50 03 00 00 e8 ba 43 ff ff 85 
> > [  227.614738] RIP: rq_completed+0x12/0x90 [dm_mod] RSP: ffffc90001aabda8
> > 
> > (gdb) list *(rq_completed+0x12)
> > 0xdd12 is in rq_completed (drivers/md/dm-rq.c:187).
> > 182      * the md may be freed in dm_put() at the end of this function.
> > 183      * Or do dm_get() before calling this function and dm_put() later.
> > 184      */
> > 185     static void rq_completed(struct mapped_device *md, int rw, bool run_queue)
> > 186     {
> > 187             struct request_queue *q = md->queue;
> > 188             unsigned long flags;
> > 189
> > 190             atomic_dec(&md->pending[rw]);
> > 191
> > 
> > (gdb) disas rq_completed
> > Dump of assembler code for function rq_completed:
> >    0x000000000000dd00 <+0>:     push   %rbp
> >    0x000000000000dd01 <+1>:     movslq %esi,%rsi
> >    0x000000000000dd04 <+4>:     mov    %rsp,%rbp
> >    0x000000000000dd07 <+7>:     push   %r13
> >    0x000000000000dd09 <+9>:     mov    %edx,%r13d
> >    0x000000000000dd0c <+12>:    push   %r12
> >    0x000000000000dd0e <+14>:    push   %rbx
> >    0x000000000000dd0f <+15>:    mov    %rdi,%rbx
> >    0x000000000000dd12 <+18>:    mov    0x288(%rdi),%r12
> >    0x000000000000dd19 <+25>:    lock decl 0x350(%rdi,%rsi,4)
> > 
> > So this was caused by an attempt to dereference %rdi = 0x6b6b6b6b6b6b6b6b.
> > Hence this is probably a use-after-free of struct mapped_device.
> 
> Hello Christoph and Mike,
> 
> The above crash occurs with Jens' for-next branch but not with Jens'
> for-4.11/block branch. Sorry but I think this means that the SCSI
> passthrough refactoring code is not yet ready for prime time.

I somehow missed your original report from yesterday.

I do agree that this would appear to be a use-after-free; certainly not
a fun bug to sort out.

I'll go back over hch's changes to see if I can spot anything.  But is
this testing using dm_mod.use_bk_mq=Y or are you testing old .request_fn
dm-multipath?

Mike
