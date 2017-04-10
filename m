Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63314 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdDJXGT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 19:06:19 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: for-next branch and mq-deadline
Date: Mon, 10 Apr 2017 23:06:00 +0000
Message-ID: <1491865559.4199.24.camel@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens and Omar,

A few minutes ago I ran into the following issue with a kernel based on the
block for-next branch (commit 602c7aa1f2fa), mq-deadline scheduler as defau=
lt
scheduler and running the srp-test software with scheduler none. This test
involves switching from the mq-deadline scheduler to "none" before every te=
st
starts. From the logs it looks like this crash was triggered while removing
block devices. The last output produced by the test script was:

Running test /home/bart/software/infiniband/srp-test/tests/03 ...
Test large transfer sizes with cmd_sg_entries=3D255
Using /dev/disk/by-id/dm-uuid-mpath-3600140572616d6469736b31000000000 -> ..=
/../dm-1
SRP LUN /sys/class/scsi_device/10:0:0:0 / sdc: removing /dev/dm-1:=A0[ test=
 script hangs ]

>From the netconsole output:

[ 2325.133052] general protection fault: 0000 [#1] SMP
[ 2325.133100] Modules linked in: ib_srp scsi_transport_srp dm_service_time=
 target_core_user uio target_core_pscsi target_core_file ib_srpt target_cor=
e_iblock target_core_mod brd netconsole
xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_na=
t nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_connt=
rack libcrc32c ipt_REJECT nf_reject_ipv4 xt_tcpudp
tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptab=
le_filter ip_tables x_tables ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad af_=
packet =A0
rdma_cm configfs ib_cm iw_cm mlx4_ib ib_core msr sb_edac edac_core x86_pkg_=
temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm irqbypass cr=
ct10dif_pclmul crc32_pclmul crc32c_intel mlx4_core
ghash_clmulni_intel tg3 pcbc ptp pps_core aesni_intel devlink=A0iTCO_wdt li=
bphy iTCO_vendor_support aes_x86_64 ioatdma crypto_simd ipmi_si lpc_ich mei=
_me dcdbas glue_helper mei shpchp dca mfd_core
cryptd ipmi_devintf pcspkr ipmi_msghandler tpm_tis tpm_tis_core tpm wmi but=
ton acpi_pad hid_generic usbhid ehci_pci ehci_hcd mgag200 i2c_algo_bit drm_=
kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops ttm drm sr_mod cdrom xhci_pci xhci_hcd usbcore usb_common sg dm=
_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4 [last unloa=
ded: scsi_transport_srp]
[ 2325.133403] CPU: 6 PID: 163 Comm: kworker/6:1H Tainted: G =A0=A0=A0=A0=
=A0=A0=A0=A0=A0I =A0=A0=A0=A04.11.0-rc6-dbg+ #1
[ 2325.133480] Workqueue: kblockd blk_mq_run_work_fn
[ 2325.133509] task: ffff88017b183140 task.stack: ffffc90003034000
[ 2325.133547] RIP: 0010:__lock_acquire+0xfe/0x1280
[ 2325.133577] RSP: 0018:ffffc90003037c10 EFLAGS: 00010002
[ 2325.133613] RAX: 6b6b6b6b6b6b6b6b RBX: 0000000000000001 RCX: 00000000000=
00000
[ 2325.133648] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 2325.133682] RBP: ffffc90003037cc0 R08: 0000000000000001 R09: 00000000000=
00000
[ 2325.133718] R10: 0000000000000000 R11: ffffffff8134d909 R12: ffff8803726=
fbc50
[ 2325.133753] R13: ffff88017b183140 R14: 0000000000000001 R15: 00000000000=
00000
[ 2325.133936] FS: =A00000000000000000(0000) GS:ffff88046ef80000(0000) knlG=
S:0000000000000000
[ 2325.133974] CS: =A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2325.134013] CR2: 00007f6d4214cf90 CR3: 000000032341c000 CR4: 00000000001=
406e0
[ 2325.134047] Call Trace:
[ 2325.134086] =A0lock_acquire+0xd5/0x1c0
[ 2325.134197] =A0_raw_spin_lock+0x2a/0x40
[ 2325.134261] =A0dd_dispatch_request+0x29/0x1e0
[ 2325.134292] =A0blk_mq_sched_dispatch_requests+0x139/0x190
[ 2325.134328] =A0__blk_mq_run_hw_queue+0x12d/0x1c0
[ 2325.134360] =A0blk_mq_run_work_fn+0xd/0x10
[ 2325.134392] =A0process_one_work+0x206/0x6a0
[ 2325.134429] =A0worker_thread+0x49/0x4a0
[ 2325.134465] =A0kthread+0x107/0x140
[ 2325.134579] =A0ret_from_fork+0x2e/0x40
[ 2325.134616] Code: 8d 62 f8 c3 49 81 3c 24 80 f4 e5 81 41 be 00 00 00 00 =
45 0f 45 f0 83 fe 01 77 89 89 f0 49 8b 44 c4 08 48 85 c0 0f 84 79 ff ff ff =
<f0> ff 80 98 01 00 00 8b 15 ed e3 9e 01 45 8b 85
d8 07 00 00 85 =A0
[ 2325.134723] RIP: __lock_acquire+0xfe/0x1280 RSP: ffffc90003037c10
[ 2325.142207] ---[ end trace 0a93cb11fc868acd ]---
[ 2325.185765] BUG: sleeping function called from invalid context at ./incl=
ude/linux/percpu-rwsem.h:33
[ 2325.185805] in_atomic(): 1, irqs_disabled(): 1, pid: 163, name: kworker/=
6:1H
[ 2325.185837] INFO: lockdep is turned off.
[ 2325.186078] irq event stamp: 1927795
[ 2325.186111] hardirqs last =A0enabled at (1927795): [<ffffffff81680347>] =
_raw_spin_unlock_irq+0x27/0x40
[ 2325.186141] hardirqs last disabled at (1927794): [<ffffffff8168010e>] _r=
aw_spin_lock_irq+0xe/0x40
[ 2325.186177] softirqs last =A0enabled at (1927064): [<ffffffff8106dd2c>] =
__do_softirq+0x37c/0x4c0
[ 2325.186207] softirqs last disabled at (1927011): [<ffffffff8106dffe>] ir=
q_exit+0xbe/0xd0

(gdb) list *(dd_dispatch_request+0x29)
0xffffffff8134d909 is in dd_dispatch_request (block/mq-deadline.c:199).
194 =A0=A0=A0=A0=A0* deadline_dispatch_requests selects the best request ac=
cording to
195 =A0=A0=A0=A0=A0* read/write expire, fifo_batch, etc
196 =A0=A0=A0=A0=A0*/
197 =A0=A0=A0=A0static struct request *__dd_dispatch_request(struct blk_mq_=
hw_ctx *hctx)
198 =A0=A0=A0=A0{
199 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct deadline_data *dd =3D hctx->=
queue->elevator->elevator_data;
200 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct request *rq;
201 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bool reads, writes;
202 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int data_dir;
203

Bart.=
