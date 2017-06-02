Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60643 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBVx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2017 17:53:58 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Block device integrity support
Date: Fri, 2 Jun 2017 21:53:55 +0000
Message-ID: <1496440434.1214.23.camel@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens and Christoph,

With Jens' for-next branch (commit fe02d46ab775), if I run the following
commands:

    modprobe scsi_debug delay=3D0 dif=3D3 dix=3D-1 dev_size_mb=3D16
    mkfs.xfs /dev/disk/by-id/scsi-1Linux_scsi_debug_22000

then the output shown below appears in the kernel log. Does anyone know how
to fix this? Sorry but I'm not really familiar with the integrity code.

Thanks,

Bart.

[=A0=A0170.657016] scsi 10:0:0:0: Direct-Access=A0=A0=A0=A0=A0Linux=A0=A0=
=A0=A0scsi_debug=A0=A0=A0=A0=A0=A0=A00186 PQ: 0 ANSI: 7
[=A0=A0170.839518] sd 10:0:0:0: [sdc] Enabling DIF Type 3 protection
[=A0=A0170.839918] sd 10:0:0:0: [sdc] 32768 512-byte logical blocks: (16.8 =
MB/16.0 MiB)
[=A0=A0170.840061] sd 10:0:0:0: [sdc] Write Protect is off
[=A0=A0170.840153] sd 10:0:0:0: [sdc] Mode Sense: 73 00 10 08
[=A0=A0170.840317] sd 10:0:0:0: [sdc] Write cache: enabled, read cache: ena=
bled, supports DPO and FUA
[=A0=A0170.841439] sd 10:0:0:0: Attached scsi generic sg3 type 0
[=A0=A0170.847081] sd 10:0:0:0: [sdc] Enabling DIX T10-DIF-TYPE3-CRC protec=
tion
[=A0=A0170.847157] sd 10:0:0:0: [sdc] DIF application tag size 6
[=A0=A0170.847723] sd 10:0:0:0: [sdc] Attached SCSI disk
[=A0=A0173.404195] general protection fault: 0000 [#1] SMP
[=A0=A0173.404252] Modules linked in: scsi_debug netconsole xt_CHECKSUM ipt=
able_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 n=
f_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
nf_conntrack libcrc32c ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp l=
lc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tab=
les x_tables ib_srp scsi_transport_srp ib_ipoib
rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm configfs ib_cm iw_cm mlx4_ib af_p=
acket sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
ib_core irqbypass crct10dif_pclmul crc32_pclmul
iTCO_wdt crc32c_intel iTCO_vendor_support ghash_clmulni_intel ipmi_ssif pcb=
c aesni_intel aes_x86_64 dcdbas tg3 crypto_simd mlx4_core glue_helper ptp c=
ryptd pcspkr pps_core libphy devlink ipmi_si
ipmi_devintf ipmi_msghandler
[=A0=A0173.404556]=A0=A0mei_me tpm_tis lpc_ich mei tpm_tis_core ioatdma mfd=
_core shpchp tpm acpi_pad button dca wmi hid_generic usbhid mgag200 i2c_alg=
o_bit ehci_pci drm_kms_helper syscopyarea ehci_hcd
sysfillrect sysimgblt fb_sys_fops ttm drm sr_mod cdrom xhci_pci xhci_hcd us=
bcore usb_common sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_al=
ua autofs4 [last unloaded: scsi_debug]
[=A0=A0173.404725] CPU: 1 PID: 8379 Comm: mkfs.xfs Tainted: G=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0I=A0=A0=A0=A0=A04.12.0-rc3-dbg+ #2
[=A0=A0173.404776] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.0=
.2 11/17/2014
[=A0=A0173.404818] task: ffff8804462cb140 task.stack: ffffc90003944000
[=A0=A0173.404862] RIP: 0010:kfree+0x6a/0x280
[=A0=A0173.404904] RSP: 0018:ffffc90003947de8 EFLAGS: 00010207
[=A0=A0173.404953] RAX: ffffea0000000000 RBX: dadfe2db46463b6b RCX: 0000000=
000000fff
[=A0=A0173.405005] RDX: ffff88046ee5b3c0 RSI: 00000000ffffffff RDI: fffffff=
f81c51cc0
[=A0=A0173.405056] RBP: ffffc90003947e10 R08: 0000000000000000 R09: 0000000=
000000001
[=A0=A0173.405109] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880=
17be24dc0
[=A0=A0173.405163] R13: 036b6b6b6d1918c0 R14: 00007ffeac297300 R15: 00007ff=
eac297330
[=A0=A0173.405217] FS:=A0=A000007ff6d4c42100(0000) GS:ffff88046ee40000(0000=
) knlGS:0000000000000000
[=A0=A0173.405448] CS:=A0=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=A0=A0173.405498] CR2: 00000000016e2118 CR3: 00000003fcdce000 CR4: 0000000=
0001406e0
[=A0=A0173.405549] Call Trace:
[=A0=A0173.405597]=A0=A0bio_integrity_free+0xa8/0xb0
[=A0=A0173.405644]=A0=A0__bio_free+0x22/0x30
[=A0=A0173.405682]=A0=A0bio_free+0x16/0x60
[=A0=A0173.405726]=A0=A0bio_put+0x1d/0x30
[=A0=A0173.405763]=A0=A0blkdev_issue_flush+0x6f/0x90
[=A0=A0173.405810]=A0=A0blkdev_fsync+0x30/0x40
[=A0=A0173.405849]=A0=A0vfs_fsync_range+0x46/0xa0
[=A0=A0173.405895]=A0=A0? trace_hardirqs_on_caller+0xf9/0x190
[=A0=A0173.405944]=A0=A0do_fsync+0x38/0x60
[=A0=A0173.405989]=A0=A0SyS_fsync+0xb/0x10
[=A0=A0173.406034]=A0=A0entry_SYSCALL_64_fastpath+0x18/0xad
[=A0=A0173.406074] RIP: 0033:0x7ff6d43f1700
[=A0=A0173.406118] RSP: 002b:00007ffeac297108 EFLAGS: 00000246 ORIG_RAX: 00=
0000000000004a
[=A0=A0173.406169] RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 00007ff=
6d43f1700
[=A0=A0173.406218] RDX: 000000000065a680 RSI: 0000000000000000 RDI: 0000000=
000000004
[=A0=A0173.406259] RBP: 00007ffeac296fe4 R08: 00000000016dfa80 R09: 0000000=
0ffffff00
[=A0=A0173.406308] R10: 000000000000009d R11: 0000000000000246 R12: 0000000=
0016e0040
[=A0=A0173.406350] R13: 00000000016e0910 R14: 00007ffeac297070 R15: 0000000=
000000004
[=A0=A0173.406393] Code: 48 01 d8 0f 82 22 02 00 00 49 bd 00 00 00 80 ff 77=
 00 00 49 01 c5 48 b8 00 00 00 00 00 ea ff ff 49 c1 ed 0c 49 c1 e5 06 49 01=
 c5 <49> 8b 45 20 48 8d 50 ff a8 01 4c 0f 45 ea 49 8b
55 20 48 8d 42=A0
[=A0=A0173.406560] RIP: kfree+0x6a/0x280 RSP: ffffc90003947de8
[=A0=A0173.406605] ---[ end trace dc862dd689d8b936 ]---

(gdb) list *(bio_integrity_free+0xa8)
0xffffffff8134fad8 is in bio_integrity_free (block/bio-integrity.c:111).
106 =A0=A0=A0=A0{
107 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct bio_integrity_payload *bip =
=3D bio_integrity(bio);
108 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct bio_set *bs =3D bio->bi_pool=
;
109
110 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (bip->bip_flags & BIP_BLOCK_INTE=
GRITY)
111 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0kfree(page_=
address(bip->bip_vec->bv_page) +
112 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0bip->bip_vec->bv_offset);
113
114 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (bs && bs->bio_integrity_pool) {
115 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bvec_free(b=
s->bvec_integrity_pool, bip->bip_vec, bip->bip_slab);
