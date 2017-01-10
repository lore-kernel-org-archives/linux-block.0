Return-Path: <wangyijing@huawei.com>
From: Yijing Wang <wangyijing@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <miaoxie@huawei.com>, <fangwei1@huawei.com>,
        <sreekanth.reddy@broadcom.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] block: Don't register a registered bdi device
Date: Tue, 10 Jan 2017 16:08:19 +0800
Message-ID: <1484035699-12807-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This issue is same as Sreekanth Reddy's report bug,
link:https://patchwork.kernel.org/patch/9394471/
so I quoted the calltrace Sreekanth Reddy's report.

Observing below kernel panic while creating second raid disk
on LSI SAS3008 HBA card.
[  +0.000055] ------------[ cut here ]------------
[  +0.000007] WARNING: CPU: 2 PID: 281 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x62/0x80
[  +0.000002] sysfs: cannot create duplicate filename '/devices/virtual/bdi/8:32'
[  +0.000001] Modules linked in: mptctl mptbase xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat  nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables intel_rapl sb_edac edac_core x86_pkg_temp_pclmul joydev ghash_clmulni_intel iTCO_wdt ipmi_ssif mei_me pcspkr mei iTCO_vendor_support ipmi_si i2c_i801 lpc_ich mfd_corema acpi_pad wmi acpi_power_meter nfsd auth_rpcgss nfs_acl lockd grace binfmt_misc sunrpc xfs libcrc32c ast i2c_algo_bit drm_kore raid_class nvme_core scsi_transport_sas dca
[  +0.000067] CPU: 2 PID: 281 Comm: kworker/u49:5 Not tainted 4.9.0-rc2 #1
[  +0.000002] Hardware name: Supermicro SYS-2028U-TNRT+/X10DRU-i+, BIOS 1.1 07/22/2015
[  +0.000005] Workqueue: events_unbound async_run_entry_fn
[  +0.000004] Call Trace:
[  +0.000009]  [<ffffffff813ca51e>] dump_stack+0x63/0x85
[  +0.000005]  [<ffffffff810a5bfb>] __warn+0xcb/0xf0
[  +0.000004]  [<ffffffff810a5c7f>] warn_slowpath_fmt+0x5f/0x80
[  +0.000006]  [<ffffffff812bf17f>] ? kernfs_path_from_node+0x4f/0x60
[  +0.000002]  [<ffffffff812c2942>] sysfs_warn_dup+0x62/0x80
[  +0.000002]  [<ffffffff812c2a27>] sysfs_create_dir_ns+0x77/0x90
[  +0.000004]  [<ffffffff813ccef9>] kobject_add_internal+0x99/0x330
[  +0.000003]  [<ffffffff813d6efb>] ? vsnprintf+0x35b/0x4c0
[  +0.000003]  [<ffffffff813cd6f5>] kobject_add+0x75/0xd0
[  +0.000006]  [<ffffffff81514e43>] ? device_private_init+0x23/0x70
[  +0.000007]  [<ffffffff817cb652>] ? mutex_lock+0x12/0x30
[  +0.000003]  [<ffffffff81514fa9>] device_add+0x119/0x670
[  +0.000004]  [<ffffffff815156f0>] device_create_groups_vargs+0xe0/0xf0
[  +0.000003]  [<ffffffff8151571c>] device_create_vargs+0x1c/0x20
[  +0.000006]  [<ffffffff811d712c>] bdi_register+0x8c/0x180
[  +0.000003]  [<ffffffff811d7506>] bdi_register_owner+0x36/0x60
[  +0.000006]  [<ffffffff813ad778>] device_add_disk+0x168/0x480
[  +0.000005]  [<ffffffff81524891>] ? update_autosuspend+0x51/0x60
[  +0.000005]  [<ffffffff81557770>] sd_probe_async+0x110/0x1c0
[  +0.000002]  [<ffffffff810c8a49>] async_run_entry_fn+0x39/0x140
[  +0.000003]  [<ffffffff810bfa5f>] process_one_work+0x15f/0x430
[  +0.000002]  [<ffffffff810bfd7e>] worker_thread+0x4e/0x490
[  +0.000002]  [<ffffffff810bfd30>] ? process_one_work+0x430/0x430
[  +0.000003]  [<ffffffff810c55a9>] kthread+0xd9/0xf0
[  +0.000003]  [<ffffffff810c54d0>] ? kthread_park+0x60/0x60
[  +0.000003]  [<ffffffff817ce595>] ret_from_fork+0x25/0x30
[  +0.000002] ------------[ cut here ]------------
[  +0.000004] WARNING: CPU: 2 PID: 281 at lib/kobject.c:240 kobject_add_internal+0x2bd/0x330
[  +0.000001] kobject_add_internal failed for 8:32 with -EEXIST, don't try to register things with the same name in the same
[  +0.000001] Modules linked in: mptctl mptbase xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat  nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables intel_rapl sb_edac edac_core x86_pkg_temp_pclmul joydev ghash_clmulni_intel iTCO_wdt ipmi_ssif mei_me pcspkr mei iTCO_vendor_support ipmi_si i2c_i801 lpc_ich mfd_corema acpi_pad wmi acpi_power_meter nfsd auth_rpcgss nfs_acl lockd grace binfmt_misc sunrpc xfs libcrc32c ast i2c_algo_bit drm_kore raid_class nvme_core scsi_transport_sas dca
[  +0.000043] CPU: 2 PID: 281 Comm: kworker/u49:5 Tainted: G        W       4.9.0-rc2 #1
[  +0.000001] Hardware name: Supermicro SYS-2028U-TNRT+/X10DRU-i+, BIOS 1.1 07/22/2015
[  +0.000002] Workqueue: events_unbound async_run_entry_fn
[  +0.000003] Call Trace:
[  +0.000003]  [<ffffffff813ca51e>] dump_stack+0x63/0x85
[  +0.000003]  [<ffffffff810a5bfb>] __warn+0xcb/0xf0
[  +0.000004]  [<ffffffff810a5c7f>] warn_slowpath_fmt+0x5f/0x80
[  +0.000002]  [<ffffffff812c294a>] ? sysfs_warn_dup+0x6a/0x80
[  +0.000003]  [<ffffffff813cd11d>] kobject_add_internal+0x2bd/0x330
[  +0.000003]  [<ffffffff813d6efb>] ? vsnprintf+0x35b/0x4c0
[  +0.000003]  [<ffffffff813cd6f5>] kobject_add+0x75/0xd0
[  +0.000003]  [<ffffffff81514e43>] ? device_private_init+0x23/0x70
[  +0.000004]  [<ffffffff817cb652>] ? mutex_lock+0x12/0x30
[  +0.000002]  [<ffffffff81514fa9>] device_add+0x119/0x670
[  +0.000004]  [<ffffffff815156f0>] device_create_groups_vargs+0xe0/0xf0
[  +0.000003]  [<ffffffff8151571c>] device_create_vargs+0x1c/0x20
[  +0.000003]  [<ffffffff811d712c>] bdi_register+0x8c/0x180
[  +0.000003]  [<ffffffff811d7506>] bdi_register_owner+0x36/0x60
[  +0.000004]  [<ffffffff813ad778>] device_add_disk+0x168/0x480
[  +0.000003]  [<ffffffff81524891>] ? update_autosuspend+0x51/0x60
[  +0.000002]  [<ffffffff81557770>] sd_probe_async+0x110/0x1c0
[  +0.000002]  [<ffffffff810c8a49>] async_run_entry_fn+0x39/0x140
[  +0.000002]  [<ffffffff810bfa5f>] process_one_work+0x15f/0x430
[  +0.000002]  [<ffffffff810bfd7e>] worker_thread+0x4e/0x490
[  +0.000002]  [<ffffffff810bfd30>] ? process_one_work+0x430/0x430
[  +0.000003]  [<ffffffff810c55a9>] kthread+0xd9/0xf0
[  +0.000003]  [<ffffffff810c54d0>] ? kthread_park+0x60/0x60
[  +0.000003]  [<ffffffff817ce595>] ret_from_fork+0x25/0x30
[  +0.000949] BUG: unable to handle kernel
[  +0.005263] NULL pointer dereference
[  +0.002853] IP: [<ffffffff812c2c64>] sysfs_do_create_link_sd.isra.2+0x34/0xb0
[  +0.008584] PGD 0

[  +0.006115] Oops: 0000 [#1] SMP
[  +0.004531] Modules linked in: mptctl mptbase xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat  nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables intel_rapl sb_edac edac_core x86_pkg_temp_pclmul joydev ghash_clmulni_intel iTCO_wdt ipmi_ssif mei_me pcspkr mei iTCO_vendor_support ipmi_si i2c_i801 lpc_ich mfd_corema acpi_pad wmi acpi_power_meter nfsd auth_rpcgss nfs_acl lockd grace binfmt_misc sunrpc xfs libcrc32c ast i2c_algo_bit drm_kore raid_class nvme_core scsi_transport_sas dca
[  +0.080566] CPU: 17 PID: 281 Comm: kworker/u49:5 Tainted: G        W       4.9.0-rc2 #1
[  +0.009472] Hardware name: Supermicro SYS-2028U-TNRT+/X10DRU-i+, BIOS 1.1 07/22/2015
[  +0.009169] Workqueue: events_unbound async_run_entry_fn
[  +0.007340] RIP: 0010:[<ffffffff812c2c64>]  [<ffffffff812c2c64>] sysfs_do_create_link_sd.isra.2+0x34/0xb0
[  +0.010294] Call Trace:
[  +0.005269]  [<ffffffff812c2d05>] sysfs_create_link+0x25/0x40
[  +0.008568]  [<ffffffff813ad80c>] device_add_disk+0x1fc/0x480
[  +0.008551]  [<ffffffff81557770>] sd_probe_async+0x110/0x1c0
[  +0.008456]  [<ffffffff810c8a49>] async_run_entry_fn+0x39/0x140
[  +0.010021]  [<ffffffff810bfa5f>] process_one_work+0x15f/0x430
[  +0.009623]  [<ffffffff810bfd7e>] worker_thread+0x4e/0x490
[  +0.007422]  [<ffffffff810bfd30>] ? process_one_work+0x430/0x430
[  +0.008728]  [<ffffffff810c55a9>] kthread+0xd9/0xf0
[  +0.007578]  [<ffffffff810c54d0>] ? kthread_park+0x60/0x60
[  +0.006816]  [<ffffffff817ce595>] ret_from_fork+0x25/0x30
[  +0.006814] Code: 75 48 85 ff 74 70 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fe 53 48 c7 c7 90 74 01 82 48 89 f3 41 89 cc  c5 ff ff c6 05 15 48 d5
[  +0.022853] RIP  [<ffffffff812c2c64>] sysfs_do_create_link_sd.isra.2+0x34/0xb0
[  +0.008679]  RSP <ffffc90019c3fd10>
[  +0.006129] BUG: unable to handle kernel

While create the first raid disk, we hide first raid disk's PD devices
(remove sdx device), but leave the bdi device in kernel, we won't call
bdi_unregister() in del_gendisk, we will do it when we cleanup request
queue. Then we cancal the raid, and create second raid disk based same
disks, then kernel try to probe the sdx device and register the bdi device
again in device_add_disk(), then the warning calltrace dump, bcause the
bdi device already exist in kernel.

This patch check the bdi device state before register a new bdi device to
avoid register a registered bdi device again.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 block/genhd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index fcd6d4f..2c2f95e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -614,7 +614,10 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 
 	/* Register BDI before referencing it from bdev */
 	bdi = &disk->queue->backing_dev_info;
-	bdi_register_owner(bdi, disk_to_dev(disk));
+	spin_lock_bh(&bdi->wb.work_lock);
+	if (!test_bit(WB_registered, &bdi->wb.state))
+		bdi_register_owner(bdi, disk_to_dev(disk));
+	spin_unlock_bh(&bdi->wb.work_lock);
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-- 
2.5.0
