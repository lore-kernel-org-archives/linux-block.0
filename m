Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:34016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932851AbeCIWOg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Mar 2018 17:14:36 -0500
From: Don Brace <don.brace@microsemi.com>
To: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "Artem Bityutskiy" <artem.bityutskiy@intel.com>
Subject: Re: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue
Date: Fri, 9 Mar 2018 22:14:31 +0000
Message-ID: <8c1ace00fae2460cb58b156c9b22a7e1@microsemi.com>
References: <20180309033218.23042-1-ming.lei@redhat.com>,<20180309033218.23042-2-ming.lei@redhat.com>
In-Reply-To: <20180309033218.23042-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Thursday, March 8, 2018 7:32 PM
To: James Bottomley; Jens Axboe; Martin K . Petersen
Cc: Christoph Hellwig; linux-scsi@vger.kernel.org; linux-block@vger.kernel.=
org; Meelis Roos; Don Brace; Kashyap Desai; Laurence Oberman; Mike Snitzer;=
 Ming Lei; Hannes Reinecke; James Bottomley; Artem Bityutskiy
Subject: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue

EXTERNAL EMAIL


>From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
one msix vector can be created without any online CPU mapped, then one
command's completion may not be notified.

This patch setups mapping between cpu and reply queue according to irq
affinity info retrived by pci_irq_get_affinity(), and uses this mapping
table to choose reply queue for queuing one command.

Then the chosen reply queue has to be active, and fixes IO hang caused
by using inactive reply queue which doesn't have any online CPU mapped.

Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Don Brace <don.brace@microsemi.com>
Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs"=
)
Signed-off-by: Ming Lei <ming.lei@redhat.com>

I got the following stack trace while testing: I need to pop off the patche=
s and re-test for a baseline.


[root@cyflym ~]# [18564.263896] XFS (dm-2): _xfs_buf_find: daddr 0x28208484=
8 out of range, EOFS 0x7298000
[18564.301491] WARNING: CPU: 51 PID: 18275 at fs/xfs/xfs_buf.c:591 _xfs_buf=
_find+0x3f0/0x530 [xfs]
[18564.342614] Modules linked in: sg ip6t_rpfilter ip6t_REJECT nf_reject_ip=
v6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_conntrack_=
ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack cfg80211 rfkill ebtable_nat e=
btable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle ip6tab=
le_security ip6table_raw ip6table_filter ip6_tables iptable_mangle iptable_=
security iptable_raw iptable_filter ip_tables sb_edac x86_pkg_temp_thermal =
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmuln=
i_intel pcbc iTCO_wdt aesni_intel iTCO_vendor_support crypto_simd glue_help=
er cryptd pcspkr ipmi_si hpilo hpwdt lpc_ich ioatdma pcc_cpufreq shpchp dca=
 mfd_core wmi ipmi_msghandler acpi_power_meter uinput xfs libcrc32c mgag200=
 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
[18564.678017]  sd_mod fb_sys_fops ttm drm crc32c_intel tg3 hpsa i2c_core s=
csi_transport_sas usb_storage dm_mirror dm_region_hash dm_log dm_mod dax
[18564.739543] CPU: 51 PID: 18275 Comm: bash Not tainted 4.16.0-rc4+ #14
[18564.769923] Hardware name: HP ProLiant DL580 Gen8, BIOS P79 08/18/2016
[18564.801111] RIP: 0010:_xfs_buf_find+0x3f0/0x530 [xfs]
[18564.825121] RSP: 0018:ffff9f0aaabaf6b8 EFLAGS: 00010246
[18564.849811] RAX: 0000000000000000 RBX: ffff9f0aaabaf808 RCX: 00000000000=
00000
[18564.883604] RDX: ffff9f0aaabaf5d8 RSI: 000000000000000a RDI: ffffffffc04=
6ad77
[18564.917315] RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000000=
00021
[18564.951211] R10: 0000000000000000 R11: 000000000000000a R12: ffff8ade9c8=
8dbc0
[18564.984925] R13: ffff8ade9c88dbc0 R14: 0000000000000001 R15: ffff9f0aaab=
af808
[18565.018846] FS:  00007f423c899740(0000) GS:ffff8aee9ef80000(0000) knlGS:=
0000000000000000
[18565.057473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18565.084562] CR2: 00007ffc480f8070 CR3: 000000105b8ce006 CR4: 00000000001=
606e0
[18565.118377] Call Trace:
[18565.129851]  ? _cond_resched+0x15/0x30
[18565.147590]  xfs_buf_get_map+0x23/0x260 [xfs]
[18565.168557]  xfs_buf_read_map+0x29/0x180 [xfs]
[18565.189845]  xfs_trans_read_buf_map+0xec/0x300 [xfs]
[18565.213354]  xfs_btree_read_buf_block.constprop.36+0x77/0xd0 [xfs]
[18565.242721]  xfs_btree_lookup_get_block+0x82/0x170 [xfs]
[18565.268117]  xfs_btree_lookup+0xce/0x3c0 [xfs]
[18565.289218]  ? kmem_zone_alloc+0x95/0x100 [xfs]
[18565.310659]  xfs_free_ag_extent+0x93/0x830 [xfs]
[18565.332491]  xfs_free_extent+0xb6/0x150 [xfs]
[18565.353187]  xfs_trans_free_extent+0x4f/0x110 [xfs]
[18565.376544]  ? xfs_trans_add_item+0x50/0x80 [xfs]
[18565.399174]  xfs_extent_free_finish_item+0x21/0x30 [xfs]
[18565.424638]  xfs_defer_finish+0x13d/0x400 [xfs]
[18565.446007]  xfs_itruncate_extents+0x11d/0x2d0 [xfs]
[18565.469501]  xfs_setattr_size+0x275/0x300 [xfs]
[18565.490808]  xfs_vn_setattr+0x40/0x60 [xfs]
[18565.510577]  notify_change+0x269/0x440
[18565.529105]  do_truncate+0x72/0xc0
[18565.545982]  path_openat+0x5ed/0x1210
[18565.563916]  ? xfs_iext_lookup_extent+0x60/0x140 [xfs]
[18565.588955]  ? xfs_bmapi_read+0x158/0x330 [xfs]
[18565.611077]  do_filp_open+0x91/0x100
[18565.628643]  ? xfs_iunlock+0xb9/0x110 [xfs]
[18565.649355]  do_sys_open+0x126/0x210
[18565.666880]  do_syscall_64+0x6e/0x1a0
[18565.684795]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[18565.709158] RIP: 0033:0x7f423bf85a20
[18565.726501] RSP: 002b:00007fffa5c54288 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[18565.763111] RAX: ffffffffffffffda RBX: 0000000000d64580 RCX: 00007f423bf=
85a20
[18565.797703] RDX: 0000000000000180 RSI: 0000000000000201 RDI: 0000000000d=
64580
[18565.831962] RBP: 0000000000d706dc R08: 0000000080000000 R09: 00000000000=
00071
[18565.865923] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00023
[18565.899948] R13: 0000000000d70660 R14: 0000000000d706dc R15: 00000000000=
03b9a
[18565.933976] Code: 48 89 de ff d0 49 8b 45 00 48 85 c0 75 e5 e9 57 ff ff =
ff 48 89 c1 48 c7 c2 80 76 46 c0 48 c7 c6 20 e3 46 c0 31 c0 e8 80 7c 01 00 =
<0f> 0b 31 c0 e9 74 ff ff ff 39 ca 0f 82 56 fe ff ff 48 8b 4c 24=20
[18566.023930] ---[ end trace 8a6b31ee9f72bc69 ]---
[18566.046443] XFS (dm-2): _xfs_buf_find: daddr 0x282084848 out of range, E=
OFS 0x7298000
[18566.083672] WARNING: CPU: 52 PID: 18275 at fs/xfs/xfs_buf.c:591 _xfs_buf=
_find+0x3f0/0x530 [xfs]
[18566.125206] Modules linked in: sg ip6t_rpfilter ip6t_REJECT nf_reject_ip=
v6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_conntrack_=
ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack cfg80211 rfkill ebtable_nat e=
btable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle ip6tab=
le_security ip6table_raw ip6table_filter ip6_tables iptable_mangle iptable_=
security iptable_raw iptable_filter ip_tables sb_edac x86_pkg_temp_thermal =
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmuln=
i_intel pcbc iTCO_wdt aesni_intel iTCO_vendor_support crypto_simd glue_help=
er cryptd pcspkr ipmi_si hpilo hpwdt lpc_ich ioatdma pcc_cpufreq shpchp dca=
 mfd_core wmi ipmi_msghandler acpi_power_meter uinput xfs libcrc32c mgag200=
 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
[18566.464387]  sd_mod fb_sys_fops ttm drm crc32c_intel tg3 hpsa i2c_core s=
csi_transport_sas usb_storage dm_mirror dm_region_hash dm_log dm_mod dax
[18566.526994] CPU: 52 PID: 18275 Comm: bash Tainted: G        W        4.1=
6.0-rc4+ #14
[18566.564460] Hardware name: HP ProLiant DL580 Gen8, BIOS P79 08/18/2016
[18566.595845] RIP: 0010:_xfs_buf_find+0x3f0/0x530 [xfs]
[18566.621209] RSP: 0018:ffff9f0aaabaf6b8 EFLAGS: 00010246
[18566.648069] RAX: 0000000000000000 RBX: ffff9f0aaabaf808 RCX: 00000000000=
00000
[18566.683203] RDX: ffff9f0aaabaf5d8 RSI: 000000000000000a RDI: ffffffffc04=
6ad77
[18566.718236] RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000000=
00021
[18566.753277] R10: 0000000000000000 R11: 000000000000000a R12: ffff8ade9c8=
8dbc0
[18566.789035] R13: ffff8ade9c88dbc0 R14: 0000000000000001 R15: ffff8aee96e=
25200
[18566.823916] FS:  00007f423c899740(0000) GS:ffff8aee9efc0000(0000) knlGS:=
0000000000000000
[18566.863626] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18566.891659] CR2: 00007f581799f410 CR3: 000000105b8ce004 CR4: 00000000001=
606e0
[18566.927561] Call Trace:
[18566.940146]  ? xfs_buf_allocate_memory+0x170/0x2b3 [xfs]
[18566.966915]  xfs_buf_get_map+0x1e4/0x260 [xfs]
[18566.989523]  xfs_buf_read_map+0x29/0x180 [xfs]
[18567.011523]  xfs_trans_read_buf_map+0xec/0x300 [xfs]
[18567.035660]  xfs_btree_read_buf_block.constprop.36+0x77/0xd0 [xfs]
[18567.065705]  xfs_btree_lookup_get_block+0x82/0x170 [xfs]
[18567.091499]  xfs_btree_lookup+0xce/0x3c0 [xfs]
[18567.113115]  ? kmem_zone_alloc+0x95/0x100 [xfs]
[18567.135992]  xfs_free_ag_extent+0x93/0x830 [xfs]
[18567.158559]  xfs_free_extent+0xb6/0x150 [xfs]
[18567.180063]  xfs_trans_free_extent+0x4f/0x110 [xfs]
[18567.204174]  ? xfs_trans_add_item+0x50/0x80 [xfs]
[18567.227012]  xfs_extent_free_finish_item+0x21/0x30 [xfs]
[18567.252809]  xfs_defer_finish+0x13d/0x400 [xfs]
[18567.275123]  xfs_itruncate_extents+0x11d/0x2d0 [xfs]
[18567.300006]  xfs_setattr_size+0x275/0x300 [xfs]
[18567.322220]  xfs_vn_setattr+0x40/0x60 [xfs]
[18567.342740]  notify_change+0x269/0x440
[18567.361172]  do_truncate+0x72/0xc0
[18567.378108]  path_openat+0x5ed/0x1210
[18567.396127]  ? xfs_iext_lookup_extent+0x60/0x140 [xfs]
[18567.421433]  ? xfs_bmapi_read+0x158/0x330 [xfs]
[18567.443411]  do_filp_open+0x91/0x100
[18567.460991]  ? xfs_iunlock+0xb9/0x110 [xfs]
[18567.481726]  do_sys_open+0x126/0x210
[18567.499159]  do_syscall_64+0x6e/0x1a0
[18567.516962]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[18567.541857] RIP: 0033:0x7f423bf85a20
[18567.559489] RSP: 002b:00007fffa5c54288 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[18567.595759] RAX: ffffffffffffffda RBX: 0000000000d64580 RCX: 00007f423bf=
85a20
[18567.629888] RDX: 0000000000000180 RSI: 0000000000000201 RDI: 0000000000d=
64580
[18567.664134] RBP: 0000000000d706dc R08: 0000000080000000 R09: 00000000000=
00071
[18567.698568] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00023
[18567.732918] R13: 0000000000d70660 R14: 0000000000d706dc R15: 00000000000=
03b9a
[18567.767047] Code: 48 89 de ff d0 49 8b 45 00 48 85 c0 75 e5 e9 57 ff ff =
ff 48 89 c1 48 c7 c2 80 76 46 c0 48 c7 c6 20 e3 46 c0 31 c0 e8 80 7c 01 00 =
<0f> 0b 31 c0 e9 74 ff ff ff 39 ca 0f 82 56 fe ff ff 48 8b 4c 24=20
[18567.857544] ---[ end trace 8a6b31ee9f72bc6a ]---
[18567.879943] XFS (dm-2): xfs_do_force_shutdown(0x1) called from line 236 =
of file fs/xfs/libxfs/xfs_defer.c.  Return address =3D 00000000e063696e
[18568.011022] XFS (dm-2): I/O Error Detected. Shutting down filesystem
[18568.042302] XFS (dm-2): Please umount the filesystem and rectify the pro=
blem(s)

---
[0:0:0:0]    disk    Apricorn                  0128  /dev/sdg=20
[1:0:0:0]    storage HP       P830i            3.02  -       =20
[1:1:0:0]    disk    HP       LOGICAL VOLUME   3.02  /dev/sda=20
[2:0:0:0]    storage HP       P431             4.54  -       =20
[3:0:0:0]    storage HP       P441             6.59  -       =20
[3:1:0:0]    disk    HP       LOGICAL VOLUME   6.59  /dev/sdb=20
[3:1:0:1]    disk    HP       LOGICAL VOLUME   6.59  /dev/sdc=20
[3:1:0:2]    disk    HP       LOGICAL VOLUME   6.59  /dev/sdd=20
[3:1:0:3]    disk    HP       LOGICAL VOLUME   6.59  /dev/sde=20
[3:1:0:4]    disk    HP       LOGICAL VOLUME   6.59  /dev/sdf=20
[4:0:0:0]    storage HP       P431             4.54  -       =20
[4:0:1:0]    disk    HP       MO0800JFFCH      HPD0  /dev/sdh=20
[4:0:2:0]    disk    HP       MO0400JFFCF      HPD0  /dev/sdi=20
[4:0:3:0]    disk    HP       VO0960JFDGU      HPD0  /dev/sdj=20
[4:0:4:0]    disk    HP       MO1600JFFCK      HPD0  /dev/sdk=20
[4:0:5:0]    disk    HP       MO1600JFFCK      HPD0  /dev/sdl=20
[4:0:6:0]    disk    HP       VO0480JFDGT      HPD0  /dev/sdm=20
[4:0:7:0]    disk    HP       VO1920JFDGV      HPD0  /dev/sdn=20
[4:0:8:0]    disk    HP       MO0400JFFCF      HPD0  /dev/sdo=20
[4:0:9:0]    disk    HP       EO0200JDVFA      HPD1  /dev/sdp=20
[4:0:10:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sdq=20
[4:0:11:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sdr=20
[4:0:12:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sds=20
[4:0:13:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sdt=20
[4:0:14:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sdu=20
[4:0:15:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sdv=20
[4:0:16:0]   disk    HP       EO0200JDVFA      HPD1  /dev/sdw=20


[root@cyflym ~]# cat fio_test_5_P441_LV_devices.fio
[global]
ioengine=3Dlibaio
rw=3Drandrw
size=3D200g
bs=3D512
direct=3D1

[/dev/sdb]
iodepth=3D512

[/dev/sdc]
iodepth=3D512

[/dev/sdd]
iodepth=3D512

[/dev/sde]
iodepth=3D512

[/dev/sdf]
iodepth=3D512

[/dev/sdg]
iodepth=3D512



[root@cyflym ~]# cat fio_test_10_P431_hba_devices.fio
[global]
ioengine=3Dlibaio
rw=3Drandrw
size=3D200g
bs=3D512
direct=3D1

[/dev/sdh]
iodepth=3D512

[/dev/sdi]
iodepth=3D512

[/dev/sdj]
iodepth=3D512

[/dev/sdk]
iodepth=3D512

[/dev/sdl]
iodepth=3D512

[/dev/sdm]
iodepth=3D512

[/dev/sdn]
iodepth=3D512

[/dev/sdo]
iodepth=3D512

[/dev/sdp]
iodepth=3D512

[/dev/sdq]
iodepth=3D512

---
 drivers/scsi/hpsa.c | 73 +++++++++++++++++++++++++++++++++++++++----------=
----
 drivers/scsi/hpsa.h |  1 +
 2 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 5293e6827ce5..3a9eca163db8 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1045,11 +1045,7 @@ static void set_performant_mode(struct ctlr_info *h,=
 struct CommandList *c,
                c->busaddr |=3D 1 | (h->blockFetchTable[c->Header.SGList] <=
< 1);
                if (unlikely(!h->msix_vectors))
                        return;
-               if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
-                       c->Header.ReplyQueue =3D
-                               raw_smp_processor_id() % h->nreply_queues;
-               else
-                       c->Header.ReplyQueue =3D reply_queue % h->nreply_qu=
eues;
+               c->Header.ReplyQueue =3D reply_queue;
        }
 }

@@ -1063,10 +1059,7 @@ static void set_ioaccel1_performant_mode(struct ctlr=
_info *h,
         * Tell the controller to post the reply to the queue for this
         * processor.  This seems to give the best I/O throughput.
         */
-       if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
-               cp->ReplyQueue =3D smp_processor_id() % h->nreply_queues;
-       else
-               cp->ReplyQueue =3D reply_queue % h->nreply_queues;
+       cp->ReplyQueue =3D reply_queue;
        /*
         * Set the bits in the address sent down to include:
         *  - performant mode bit (bit 0)
@@ -1087,10 +1080,7 @@ static void set_ioaccel2_tmf_performant_mode(struct =
ctlr_info *h,
        /* Tell the controller to post the reply to the queue for this
         * processor.  This seems to give the best I/O throughput.
         */
-       if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
-               cp->reply_queue =3D smp_processor_id() % h->nreply_queues;
-       else
-               cp->reply_queue =3D reply_queue % h->nreply_queues;
+       cp->reply_queue =3D reply_queue;
        /* Set the bits in the address sent down to include:
         *  - performant mode bit not used in ioaccel mode 2
         *  - pull count (bits 0-3)
@@ -1109,10 +1099,7 @@ static void set_ioaccel2_performant_mode(struct ctlr=
_info *h,
         * Tell the controller to post the reply to the queue for this
         * processor.  This seems to give the best I/O throughput.
         */
-       if (likely(reply_queue =3D=3D DEFAULT_REPLY_QUEUE))
-               cp->reply_queue =3D smp_processor_id() % h->nreply_queues;
-       else
-               cp->reply_queue =3D reply_queue % h->nreply_queues;
+       cp->reply_queue =3D reply_queue;
        /*
         * Set the bits in the address sent down to include:
         *  - performant mode bit not used in ioaccel mode 2
@@ -1157,6 +1144,8 @@ static void __enqueue_cmd_and_start_io(struct ctlr_in=
fo *h,
 {
        dial_down_lockup_detection_during_fw_flash(h, c);
        atomic_inc(&h->commands_outstanding);
+
+       reply_queue =3D h->reply_map[raw_smp_processor_id()];
        switch (c->cmd_type) {
        case CMD_IOACCEL1:
                set_ioaccel1_performant_mode(h, c, reply_queue);
@@ -7376,6 +7365,26 @@ static void hpsa_disable_interrupt_mode(struct ctlr_=
info *h)
        h->msix_vectors =3D 0;
 }

+static void hpsa_setup_reply_map(struct ctlr_info *h)
+{
+       const struct cpumask *mask;
+       unsigned int queue, cpu;
+
+       for (queue =3D 0; queue < h->msix_vectors; queue++) {
+               mask =3D pci_irq_get_affinity(h->pdev, queue);
+               if (!mask)
+                       goto fallback;
+
+               for_each_cpu(cpu, mask)
+                       h->reply_map[cpu] =3D queue;
+       }
+       return;
+
+fallback:
+       for_each_possible_cpu(cpu)
+               h->reply_map[cpu] =3D 0;
+}
+
 /* If MSI/MSI-X is supported by the kernel we will try to enable it on
  * controllers that are capable. If not, we use legacy INTx mode.
  */
@@ -7771,6 +7780,10 @@ static int hpsa_pci_init(struct ctlr_info *h)
        err =3D hpsa_interrupt_mode(h);
        if (err)
                goto clean1;
+
+       /* setup mapping between CPU and reply queue */
+       hpsa_setup_reply_map(h);
+
        err =3D hpsa_pci_find_memory_BAR(h->pdev, &h->paddr);
        if (err)
                goto clean2;    /* intmode+region, pci */
@@ -8480,6 +8493,28 @@ static struct workqueue_struct *hpsa_create_controll=
er_wq(struct ctlr_info *h,
        return wq;
 }

+static void hpda_free_ctlr_info(struct ctlr_info *h)
+{
+       kfree(h->reply_map);
+       kfree(h);
+}
+
+static struct ctlr_info *hpda_alloc_ctlr_info(void)
+{
+       struct ctlr_info *h;
+
+       h =3D kzalloc(sizeof(*h), GFP_KERNEL);
+       if (!h)
+               return NULL;
+
+       h->reply_map =3D kzalloc(sizeof(*h->reply_map) * nr_cpu_ids, GFP_KE=
RNEL);
+       if (!h->reply_map) {
+               kfree(h);
+               return NULL;
+       }
+       return h;
+}
+
 static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id =
*ent)
 {
        int dac, rc;
@@ -8517,7 +8552,7 @@ static int hpsa_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)
         * the driver.  See comments in hpsa.h for more info.
         */
        BUILD_BUG_ON(sizeof(struct CommandList) % COMMANDLIST_ALIGNMENT);
-       h =3D kzalloc(sizeof(*h), GFP_KERNEL);
+       h =3D hpda_alloc_ctlr_info();
        if (!h) {
                dev_err(&pdev->dev, "Failed to allocate controller head\n")=
;
                return -ENOMEM;
@@ -8916,7 +8951,7 @@ static void hpsa_remove_one(struct pci_dev *pdev)
        h->lockup_detected =3D NULL;                      /* init_one 2 */
        /* (void) pci_disable_pcie_error_reporting(pdev); */    /* init_one=
 1 */

-       kfree(h);                                       /* init_one 1 */
+       hpda_free_ctlr_info(h);                         /* init_one 1 */
 }

 static int hpsa_suspend(__attribute__((unused)) struct pci_dev *pdev,
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 018f980a701c..fb9f5e7f8209 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -158,6 +158,7 @@ struct bmic_controller_parameters {
 #pragma pack()

 struct ctlr_info {
+       unsigned int *reply_map;
        int     ctlr;
        char    devname[8];
        char    *product_name;
--
2.9.5
