Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26543 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754030AbdECUdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 16:33:50 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Crash in function called from __blkg_release_rcu()
Date: Wed, 3 May 2017 20:33:47 +0000
Message-ID: <1493843625.3901.36.camel@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Tejun and Christoph,

While testing a series of SCSI target patches I ran into the following
crash in the initiator call stack after I requested the iSCSI initiator
code to log out:

general protection fault: 0000 [#1] SMP
Modules linked in: target_core_user uio target_core_iblock target_core_file=
 iscsi_target_mod target_core_mod brd netconsole configfs crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel
aes_x86_64 crypto_simd cryptd glue_helper serio_raw virtio_rng virtio_ballo=
on virtio_console i2c_piix4 acpi_cpufreq button iscsi_tcp libiscsi_tcp libi=
scsi scsi_transport_iscsi ext4 jbd2 mbcache
virtio_blk virtio_net drm_kms_helper syscopyarea sysfillrect sysimgblt fb_s=
ys_fops psmouse ttm virtio_pci drm floppy
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.11.0-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.=
qemu-project.org 04/01/2014
task: ffff88013a088040 task.stack: ffffc900006bc000
RIP: 0010:free_request_size+0x1a/0x30
RSP: 0018:ffffc900006bfd38 EFLAGS: 00010202
RAX: 6b6b6b6b6b6b6b6b RBX: ffff880067f6ba78 RCX: 0000000000000003
RDX: ffff880068574008 RSI: ffff880067f6ba78 RDI: ffff88013036db98
RBP: ffffc900006bfd40 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900006bfd38 R11: 0000000000000000 R12: ffff880067b837e8
R13: ffff880067b837e8 R14: ffff880067b83c00 R15: ffff88013a088040
FS:=A0=A00000000000000000(0000) GS:ffff88013fc80000(0000) knlGS:00000000000=
00000
CS:=A0=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f88a81d135c CR3: 0000000131bfd000 CR4: 00000000001406e0
Call Trace:
=A0mempool_destroy.part.10+0x21/0x40
=A0mempool_destroy+0xe/0x10
=A0blk_exit_rl+0x12/0x20
=A0blkg_free+0x57/0xb0
=A0__blkg_release_rcu+0x59/0x190
=A0rcu_process_callbacks+0x258/0x5e0
=A0__do_softirq+0x116/0x270
=A0run_ksoftirqd+0x20/0x60
=A0smpboot_thread_fn+0x123/0x1e0
=A0kthread+0x109/0x140
=A0ret_from_fork+0x31/0x40
Code: 01 48 89 e5 e8 38 03 f0 ff 5d c3 66 0f 1f 44 00 00 55 48 89 e5 53 48 =
8b 86 40 01 00 00 48 89 fb 48 85 c0 74 08 48 89 f7 48 89 de <ff> d0 48 89 d=
f e8 2c 14 f0 ff 5b 5d c3 66 0f 1f 84 00 00 00 00=A0
RIP: free_request_size+0x1a/0x30 RSP: ffffc900006bfd38

(gdb) disas free_request_size =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
Dump of assembler code for function free_request_size:
=A0=A0=A00xffffffff81296c70 <+0>: =A0=A0=A0=A0push =A0=A0%rbp
=A0=A0=A00xffffffff81296c71 <+1>: =A0=A0=A0=A0mov =A0=A0=A0%rsp,%rbp
=A0=A0=A00xffffffff81296c74 <+4>: =A0=A0=A0=A0push =A0=A0%rbx
=A0=A0=A00xffffffff81296c75 <+5>: =A0=A0=A0=A0mov =A0=A0=A00x140(%rsi),%rax
=A0=A0=A00xffffffff81296c7c <+12>: =A0=A0=A0mov =A0=A0=A0%rdi,%rbx
=A0=A0=A00xffffffff81296c7f <+15>: =A0=A0=A0test =A0=A0%rax,%rax
=A0=A0=A00xffffffff81296c82 <+18>: =A0=A0=A0je =A0=A0=A0=A00xffffffff81296c=
8c <free_request_size+28>
=A0=A0=A00xffffffff81296c84 <+20>: =A0=A0=A0mov =A0=A0=A0%rsi,%rdi
=A0=A0=A00xffffffff81296c87 <+23>: =A0=A0=A0mov =A0=A0=A0%rbx,%rsi
=A0=A0=A00xffffffff81296c8a <+26>: =A0=A0=A0callq =A0*%rax
=A0=A0=A00xffffffff81296c8c <+28>: =A0=A0=A0mov =A0=A0=A0%rbx,%rdi
=A0=A0=A00xffffffff81296c8f <+31>: =A0=A0=A0callq =A00xffffffff811980c0 <kf=
ree>
=A0=A0=A00xffffffff81296c94 <+36>: =A0=A0=A0pop =A0=A0=A0%rbx
=A0=A0=A00xffffffff81296c95 <+37>: =A0=A0=A0pop =A0=A0=A0%rbp
=A0=A0=A00xffffffff81296c96 <+38>: =A0=A0=A0retq =A0=A0=A0
End of assembler dump.

I think this means that free_request_size() was called for a request queue
after that request queue was freed. Does anyone have a proposal for how to
fix this?

See also commit 6d247d7f71d1 ("block: allow specifying size for extra
command data", January 27, 2017).

Thanks,

Bart.=
