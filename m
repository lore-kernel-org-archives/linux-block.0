Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D5C4332F
	for <linux-block@archiver.kernel.org>; Thu,  2 Nov 2023 15:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjKBPBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjKBPBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Nov 2023 11:01:45 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 08:01:38 PDT
Received: from mail.flyingcircus.io (mail.flyingcircus.io [IPv6:2a02:238:f030:102::1064])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1811B
        for <linux-block@vger.kernel.org>; Thu,  2 Nov 2023 08:01:38 -0700 (PDT)
From:   Christian Theune <ct@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
        s=mail; t=1698936856;
        bh=HdXjuFDV8s5hD+WloDCoPcT4i4ktAoVnOHYyA7SRG+o=;
        h=From:Subject:Date:Cc:To;
        b=OcFJOXhJmsvcbY0OyF/zRxlGpObefPqohE7PXdpMPwBQlJzVsIvFsVXg1ahD9ipo1
         DT5oZNcTgpMrsDem+RHumKSQE2zZJouy7mEuS1jKUSOtdJWfxSYky2gg1w8F/q07zt
         xCyXSPzYfEzXTTcVnrIqfN0ZtHMe2WbaNpEcRk7k=
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: [REGRESSION] Backport? RIP: 0010:throtl_trim_slice+0xc6/0x320 caused
 kernel panic 
Message-Id: <F5E0BC95-9883-4E8E-83A6-CD9962B7E90C@flyingcircus.io>
Date:   Thu, 2 Nov 2023 15:53:56 +0100
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        ming.lei@redhat.com
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I hope i=E2=80=99m not jumping the gun, but I guess I=E2=80=99d be =
interested in a backport to said issue =E2=80=A6 ;)

We=E2=80=99re running on 6.1.55/57 and this has started breaking for us =
after we updated from 6.1.51.

The issue seems to be well-described and already fixed in
=
https://lkml.kernel.org/linux-block/e1d7c106-ea6f-922f-971f-691e7e0faf9d@h=
uaweicloud.com/T/
but I can=E2=80=99t post to that thread easily and it seems backporting =
isn=E2=80=99t on the radar as of now.

The errors we have seen (multiple times by now) are:

[90152.012696] divide error: 0000 [#1] PREEMPT SMP PTI
[90152.013534] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.57 #1-NixOS
[90152.014465] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[90152.016103] RIP: 0010:throtl_trim_slice+0xe1/0x340
[90152.016809] Code: 89 c8 48 f7 f6 48 29 d1 48 89 cd 74 98 41 0f b6 f5 =
48 89 df 89 34 24 e8 ad fa ff ff 8b 34 24 b9 e8 03 00 00 48 89 df 48 f7 =
e5 <48> f7 f1 49 03 84 24 f8 01 00 00 49 89 c7 e8 8c ea ff ff be ff ff
[90152.019454] RSP: 0018:ffffaca040003d70 EFLAGS: 00010887
[90152.020217] RAX: fffffffffffff574 RBX: ffff9f1bf124f000 RCX: =
00000000000003e8
[90152.021293] RDX: 0000000000000a8b RSI: 0000000000000001 RDI: =
ffff9f1bf124f000
[90152.022324] RBP: 0000000000000a8c R08: ffff9f1b83e23c00 R09: =
ffff9f1b83e67030
[90152.023363] R10: ffff9f1b85765010 R11: ffff9f1b83e67060 R12: =
ffff9f1bf124f008
[90152.024386] R13: 0000000000000001 R14: 0000000000000001 R15: =
ffff9f1b85765008
[90152.025409] FS: 0000000000000000(0000) GS:ffff9f1bfdc00000(0000) =
knlGS:0000000000000000
[90152.026560] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[90152.027407] CR2: 00007f4874f38638 CR3: 000000006e9ee004 CR4: =
00000000001706f0
[90152.028439] Call Trace:
[90152.028831] <IRQ>
[90152.029165] ? __die_body.cold+0x1a/0x1f
[90152.029738] ? die+0x2a/0x50
[90152.030175] ? do_trap+0xc5/0x110
[90152.030668] ? throtl_trim_slice+0xe1/0x340
[90152.031290] ? do_error_trap+0x6a/0x90
[90152.031838] ? throtl_trim_slice+0xe1/0x340
[90152.032463] ? exc_divide_error+0x34/0x50
[90152.033060] ? throtl_trim_slice+0xe1/0x340
[90152.033664] ? asm_exc_divide_error+0x16/0x20
[90152.034314] ? throtl_trim_slice+0xe1/0x340
[90152.034918] ? enqueue_entity+0x195/0x4c0
[90152.035509] tg_dispatch_one_bio+0x1f7/0x370
[90152.036137] throtl_pending_timer_fn+0x1ee/0x510
[90152.036805] ? tg_update_disptime+0x130/0x130
[90152.037467] ? tg_update_disptime+0x130/0x130
[90152.038107] call_timer_fn+0x27/0x130
[90152.038642] __run_timers+0x21c/0x2a0
[90152.039185] run_timer_softirq+0x2b/0x50
[90152.039756] __do_softirq+0xf0/0x2fe
[90152.040288] __irq_exit_rcu+0xc4/0x130
[90152.040836] sysvec_apic_timer_interrupt+0x9e/0xc0
[90152.041535] </IRQ>
[90152.041852] <TASK>
[90152.042179] asm_sysvec_apic_timer_interrupt+0x16/0x20
[90152.042918] RIP: 0010:native_safe_halt+0xb/0x10
[90152.043587] Code: 02 00 3e 80 48 02 20 48 8b 00 a8 08 75 bf e9 7b ff =
ff ff cc cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 69 69 47 00 fb =
f4 <c3> cc cc cc cc eb 07 0f 00 2d 59 69 47 00 f4 c3 cc cc cc cc cc 0f
[90152.046237] RSP: 0018:ffffffff8e803e90 EFLAGS: 00000296
[90152.046999] RAX: ffffffff8db932f0 RBX: ffffffff8e81aa40 RCX: =
0000000000000000
[90152.048026] RDX: 0000000000000001 RSI: ffffffff8e2ca669 RDI: =
ffffffff8e2d6977
[90152.049046] RBP: 0000000000000000 R08: 000001c16d552fdc R09: =
0000000000000000
[90152.050080] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[90152.051100] R13: 0000000000000000 R14: ffffffff8e81a118 R15: =
0000000000000000
[90152.052145] ? __sched_text_end+0x6/0x6
[90152.052711] default_idle+0xa/0x10
[90152.053218] default_idle_call+0x36/0xf0
[90152.053794] do_idle+0x210/0x270
[90152.054292] cpu_startup_entry+0x26/0x30
[90152.054860] rest_init+0xcc/0xd0
[90152.055345] arch_call_rest_init+0xa/0x14
[90152.055934] start_kernel+0x6f0/0x719
[90152.056477] secondary_startup_64_no_verify+0xe5/0xeb
[90152.057214] </TASK>
[90152.057555] Modules linked in: tls intel_rapl_msr intel_rapl_common =
crc32_pclmul polyval_clmulni polyval_generic gf128mul =
ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel libaes =
crypto_simd cryptd rapl nft_chain_nat bochs drm_vram_helper =
drm_ttm_helper ttm ip6_tables drm_kms_helper joydev xt_conntrack =
mousedev fb_sys_fops intel_agp syscopyarea intel_gtt psmouse sysfillrect =
sysimgblt ata_generic agpgart input_leds pata_acpi evdev i2c_piix4 =
ip6t_rpfilter ipt_rpfilter xt_pkttype led_class xt_LOG nf_log_syslog =
ip6t_REJECT nf_reject_ipv6 floppy ipt_REJECT nf_reject_ipv4 =
tiny_power_button button xt_tcpudp nft_compat mac_hid serio_raw =
nf_tables nfnetlink tcp_bbr sch_fq_codel nf_nat_ftp nf_conntrack_ftp =
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 loop tun tap drm =
macvlan bridge fuse stp llc backlight i2c_core efi_pstore configfs =
dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 xfs libcrc32c =
crc32c_generic ata_piix libata atkbd libps2 vivaldi_fmap =
crct10dif_pclmul
[90152.057673] crct10dif_common crc32c_intel i8042 rtc_cmos serio dm_mod =
dax bfq i6300esb watchdog virtio_scsi scsi_mod scsi_common virtio_rng =
rng_core virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev =
virtio_net net_failover failover virtio_console virtio_blk virtio =
virtio_ring
[90152.076458] ---[ end trace 0000000000000000 ]---
[90152.077136] RIP: 0010:throtl_trim_slice+0xe1/0x340
[90152.077845] Code: 89 c8 48 f7 f6 48 29 d1 48 89 cd 74 98 41 0f b6 f5 =
48 89 df 89 34 24 e8 ad fa ff ff 8b 34 24 b9 e8 03 00 00 48 89 df 48 f7 =
e5 <48> f7 f1 49 03 84 24 f8 01 00 00 49 89 c7 e8 8c ea ff ff be ff ff
[90152.080549] RSP: 0018:ffffaca040003d70 EFLAGS: 00010887
[90152.081307] RAX: fffffffffffff574 RBX: ffff9f1bf124f000 RCX: =
00000000000003e8
[90152.082338] RDX: 0000000000000a8b RSI: 0000000000000001 RDI: =
ffff9f1bf124f000
[90152.083371] RBP: 0000000000000a8c R08: ffff9f1b83e23c00 R09: =
ffff9f1b83e67030
[90152.084399] R10: ffff9f1b85765010 R11: ffff9f1b83e67060 R12: =
ffff9f1bf124f008
[90152.085441] R13: 0000000000000001 R14: 0000000000000001 R15: =
ffff9f1b85765008
[90152.086469] FS: 0000000000000000(0000) GS:ffff9f1bfdc00000(0000) =
knlGS:0000000000000000
[90152.087835] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[90152.088681] CR2: 00007f4874f38638 CR3: 000000006e9ee004 CR4: =
00000000001706f0
[90152.089708] Kernel panic - not syncing: Fatal exception in interrupt
[90152.090682] Kernel Offset: 0xc200000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[90152.092197] Rebooting in 1 seconds..


and=20

[1755541.782316] CPU: 0 PID: 14 Comm: ksoftirqd/0 Not tainted 6.1.55 =
#1-NixOS
[1755541.782868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[1755541.783796] RIP: 0010:throtl_trim_slice+0xe1/0x340
[1755541.784212] Code: 89 c8 48 f7 f6 48 29 d1 48 89 cd 74 98 41 0f b6 =
f5 48 89 df 89 34 24 e8 ad fa ff ff 8b 34 24 b9 e8 03 00 00 48 89 df 48 =
f7 e5 <48> f7 f1 49 03 84 24 f8 01 00 00 49 89 c
7 e8 8c ea ff ff be ff ff
[1755541.785689] RSP: 0018:ffffb7ccc007bc70 EFLAGS: 00010887
[1755541.786134] RAX: fffffffffffff3e4 RBX: ffff8b6207540000 RCX: =
00000000000003e8
[1755541.786719] RDX: 0000000000000c1b RSI: 0000000000000000 RDI: =
ffff8b6207540000
[1755541.787306] RBP: 0000000000000c1c R08: ffff8b6201e1d800 R09: =
ffff8b6201e56830
[1755541.787891] R10: ffff8b620757b010 R11: ffff8b6201e56860 R12: =
ffff8b6207540000
[1755541.788476] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffff8b620757b000
[1755541.789066] FS: 0000000000000000(0000) GS:ffff8b623bc00000(0000) =
knlGS:0000000000000000
[1755541.789721] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1755541.790200] CR2: 00007f70c5f4a008 CR3: 000000010b70a000 CR4: =
00000000000006f0
[1755541.790782] Call Trace:
[1755541.791012] <TASK>
[1755541.791208] ? __die_body.cold+0x1a/0x1f
[1755541.791544] ? die+0x2a/0x50
[1755541.791799] ? do_trap+0xc5/0x110
[1755541.792090] ? throtl_trim_slice+0xe1/0x340
[1755541.792444] ? do_error_trap+0x6a/0x90
[1755541.792762] ? throtl_trim_slice+0xe1/0x340
[1755541.793120] ? exc_divide_error+0x34/0x50
[1755541.793459] ? throtl_trim_slice+0xe1/0x340
[1755541.793812] ? asm_exc_divide_error+0x16/0x20
[1755541.794191] ? throtl_trim_slice+0xe1/0x340
[1755541.794546] tg_dispatch_one_bio+0x1f7/0x370
[1755541.794907] throtl_pending_timer_fn+0x18c/0x510
[1755541.795305] ? tg_update_disptime+0x130/0x130
[1755541.795662] ? tg_update_disptime+0x130/0x130
[1755541.796036] call_timer_fn+0x27/0x130
[1755541.796350] __run_timers+0x21c/0x2a0
[1755541.796662] run_timer_softirq+0x2b/0x50
[1755541.796998] __do_softirq+0xf0/0x2fe
[1755541.797311] ? sort_range+0x20/0x20
[1755541.797602] run_ksoftirqd+0x34/0x40
[1755541.797900] smpboot_thread_fn+0x188/0x220
[1755541.798271] kthread+0xe9/0x110
[1755541.798551] ? kthread_complete_and_exit+0x20/0x20
[1755541.798949] ret_from_fork+0x22/0x30
[1755541.799266] </TASK>
[1755541.799468] Modules linked in: tls rpcsec_gss_krb5 auth_rpcgss =
nfsv4 dns_resolver nfs lockd grace fscache sunrpc bochs drm_vram_helper =
drm_ttm_helper ttm nft_chain_nat ip6_tables drm_kms_helper fb_sys_fops =
xt_conntrack syscopyarea ata_generic sysfillrect pata_acpi sysimgblt =
intel_agp i2c_piix4 intel_gtt agpgart ip6t_rpfilter ipt_rpfilter =
xt_pkttype xt_LOG nf_log_syslog ip6t_REJECT nf_reject_ipv6 ipt_REJECT =
nf_reject_ipv4 xt_tcpudp input_leds tiny_power_button evdev joydev =
led_class mousedev nft_compat floppy button psmouse mac_hid serio_raw =
nf_tables nfnetlink tcp_bbr sch_fq_codel nf_nat_ftp nf_conntrack_ftp =
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 loop tun tap macvlan =
drm bridge stp llc backlight i2c_core fuse efi_pstore configfs dmi_sysfs =
qemu_fw_cfg ip_tables x_tables autofs4 xfs libcrc32c crc32c_generic =
ata_piix libata atkbd libps2 vivaldi_fmap i8042 rtc_cmos serio dm_mod =
dax bfq i6300esb watchdog virtio_scsi scsi_mod scsi_common virtio_rng =
rng_core virtio_pci
[1755541.799597] virtio_pci_legacy_dev virtio_pci_modern_dev virtio_net =
net_failover failover virtio_console virtio_blk virtio virtio_ring
[1755541.807332] ---[ end trace 0000000000000000 ]---
[1755541.807718] RIP: 0010:throtl_trim_slice+0xe1/0x340
[1755541.808124] Code: 89 c8 48 f7 f6 48 29 d1 48 89 cd 74 98 41 0f b6 =
f5 48 89 df 89 34 24 e8 ad fa ff ff 8b 34 24 b9 e8 03 00 00 48 89 df 48 =
f7 e5 <48> f7 f1 49 03 84 24 f8 01 00 00 49 89 c
7 e8 8c ea ff ff be ff ff
[1755541.809603] RSP: 0018:ffffb7ccc007bc70 EFLAGS: 00010887
[1755541.810039] RAX: fffffffffffff3e4 RBX: ffff8b6207540000 RCX: =
00000000000003e8
[1755541.810623] RDX: 0000000000000c1b RSI: 0000000000000000 RDI: =
ffff8b6207540000
[1755541.811223] RBP: 0000000000000c1c R08: ffff8b6201e1d800 R09: =
ffff8b6201e56830
[1755541.811805] R10: ffff8b620757b010 R11: ffff8b6201e56860 R12: =
ffff8b6207540000
[1755541.812390] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffff8b620757b000
[1755541.812974] FS: 0000000000000000(0000) GS:ffff8b623bc00000(0000) =
knlGS:0000000000000000
[1755541.813637] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1755541.814113] CR2: 00007f70c5f4a008 CR3: 000000010b70a000 CR4: =
00000000000006f0
[1755541.814691] Kernel panic - not syncing: Fatal exception in =
interrupt
[1755541.815239] Kernel Offset: 0x32400000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[1755541.816100] Rebooting in 1 seconds..

Backports to LTS where applicable (6.1 for us) would be appreciated.

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

#regzbot introduced: v6.1.51..v6.1.55

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

