Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24470 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdHAJDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2017 05:03:05 -0400
From: Ethan Zhao <ethan.zhao@oracle.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ethan.kernel@gmail.com, Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH] sysfs: replace WARN() with pr_debug in sysfs_remove_group()
Date: Tue,  1 Aug 2017 17:02:25 +0900
Message-Id: <1501574545-15691-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is no enough error handling in block device adding/registration
path, for example,

device_add_disk()
  blk_register_queue()

When kernel returns from device_add_disk(), no return value to tell
us it was successful or not --- that suggests it would always succeed,
and according to this assumption, then during block device removal/
unregistration steps,

sd_remove()
  del_gendisk()
    blk_unregister_queue()

dpm_sysfs_remove(), blk_trace_remove_sysfs() will be called blindly,
though there is likely no 'trace' 'power' sysfs groups there because
actually blk_register_queue()/device_add() failed somewhere. thus
causes WARN flood emitted from sysfs_remove_group() as following triggered
by unloading fnic driver:

 modprobe -rv fnic

[  122.081398] WARNING: CPU: 14 PID: 11709 at fs/sysfs/group.c:224
	sysfs_remove_group+0x9c/0xa0()
[  122.081399] sysfs group 'trace' not found for kobject 'sdb'
[  122.081424] CPU: 14 PID: 11709 Comm: modprobe Tainted: G        W
	4.1.12.x86_64 #2
[  122.081425] Hardware name: Cisco Systems Inc UCSBXXxx
[  122.081425]  0000000000000286 00000000d03792ff ffff881037823ad8 
	ffffffff8173605d
[  122.081427]  ffff881037823b30 ffffffff81a2b9bc ffff881037823b18 
	ffffffff810862aa
[  122.081428]  ffff88103974a000 0000000000000000 ffffffff81ba4080 
	ffff882037d45080
[  122.081430] Call Trace:
[  122.081432]  [<ffffffff8173605d>] dump_stack+0x63/0x81
[  122.081434]  [<ffffffff810862aa>] warn_slowpath_common+0x8a/0xc0
[  122.081435]  [<ffffffff81086335>] warn_slowpath_fmt+0x55/0x70
[  122.081437]  [<ffffffff8129321c>] ? kernfs_find_and_get_ns+0x4c/0x60
[  122.081439]  [<ffffffff81296b5c>] sysfs_remove_group+0x9c/0xa0
[  122.081441]  [<ffffffff811675a4>] blk_trace_remove_sysfs+0x14/0x20
[  122.081444]  [<ffffffff81312605>] blk_unregister_queue+0x65/0x90
[  122.081446]  [<ffffffff81320f26>] del_gendisk+0x126/0x290
[  122.081449]  [<ffffffffa0091281>] sd_remove+0x61/0xc0 [sd_mod]
[  122.081452]  [<ffffffff81492fb7>] __device_release_driver+0x87/0x120
[  122.081454]  [<ffffffff81493073>] device_release_driver+0x23/0x30
[  122.081456]  [<ffffffff814928f8>] bus_remove_device+0x108/0x180
[  122.081457]  [<ffffffff8148eca0>] device_del+0x160/0x2a0
[  122.081459]  [<ffffffff814d8feb>] __scsi_remove_device+0xcb/0xd0
[  122.081461]  [<ffffffff814d7524>] scsi_forget_host+0x64/0x70
[  122.081462]  [<ffffffff814cac0b>] scsi_remove_host+0x7b/0x130
[  122.081466]  [<ffffffffa016fc47>] fnic_remove+0x1b7/0x4a0 [fnic]
[  122.081469]  [<ffffffff8138434f>] pci_device_remove+0x3f/0xc0
[  122.081472]  [<ffffffff81492fb7>] __device_release_driver+0x87/0x120
[  122.081474]  [<ffffffff81493a38>] driver_detach+0xc8/0xd0
[  122.081478]  [<ffffffff81492c19>] bus_remove_driver+0x59/0xe0
[  122.081479]  [<ffffffff814942e0>] driver_unregister+0x30/0x70
[  122.081482]  [<ffffffff81382dba>] pci_unregister_driver+0x2a/0x80
[  122.081486]  [<ffffffffa01808cc>] fnic_cleanup_module+0x10/0x7a [fnic]
[  122.081488]  [<ffffffff8110e8ec>] SyS_delete_module+0x1ac/0x230
[  122.081490]  [<ffffffff81028666>] ? syscall_trace_leave+0xc6/0x150
[  122.081491]  [<ffffffff8173dcee>] system_call_fastpath+0x12/0x71
[  122.081502] ---[ end trace 29ba5813719045a4 ]---

WARNING: CPU: 14 PID: 11709 at fs/sysfs/group.c:224
	sysfs_remove_group+0x9c/0xa0()
[  122.095724] sysfs group 'power' not found for kobject 'target2:0:4'
[  122.095790] CPU: 14 PID: 11709 Comm: modprobe Tainted: G        W
	4.1.12.x86_64 #2
[  122.095793] Hardware name: Cisco Systems Inc UCSBXXxx
[  122.095795]  0000000000000286 00000000d03792ff ffff881037823af8 
	ffffffff8173605d
[  122.095800]  ffff881037823b50 ffffffff81a2b9bc ffff881037823b38 
	ffffffff810862aa
[  122.095803]  ffff881037823b38 0000000000000000 ffffffff81c0cf20 
	ffff881034701838
[  122.095807] Call Trace:
[  122.095814]  [<ffffffff8173605d>] dump_stack+0x63/0x81
[  122.095818]  [<ffffffff810862aa>] warn_slowpath_common+0x8a/0xc0
[  122.095822]  [<ffffffff81086335>] warn_slowpath_fmt+0x55/0x70
[  122.095827]  [<ffffffff8129321c>] ? kernfs_find_and_get_ns+0x4c/0x60
[  122.095831]  [<ffffffff81296b5c>] sysfs_remove_group+0x9c/0xa0
[  122.095839]  [<ffffffff8149b7e7>] dpm_sysfs_remove+0x57/0x60
[  122.095843]  [<ffffffff8148ebc6>] device_del+0x86/0x2a0
[  122.095847]  [<ffffffff8148e1f9>] ? device_remove_file+0x19/0x20
[  122.095854]  [<ffffffff814983ae>] attribute_container_class_device_del
	+0x1e/0x30
[  122.095858]  [<ffffffff814985c2>] transport_remove_classdev+0x52/0x60
[  122.095862]  [<ffffffff81498570>] ? transport_add_class_device+0x40/0x40
[  122.095866]  [<ffffffff81497f1c>] attribute_container_device_trigger
	+0xdc/0xf0
[  122.095870]  [<ffffffff81498525>] transport_remove_device+0x15/0x20
[  122.095875]  [<ffffffff814d4df5>] scsi_target_reap_ref_release+0x25/0x40
[  122.095879]  [<ffffffff814d68fc>] scsi_target_reap+0x2c/0x30
[  122.095883]  [<ffffffff814d8fa6>] __scsi_remove_device+0x86/0xd0
[  122.095887]  [<ffffffff814d7524>] scsi_forget_host+0x64/0x70
[  122.095891]  [<ffffffff814cac0b>] scsi_remove_host+0x7b/0x130
[  122.095900]  [<ffffffffa016fc47>] fnic_remove+0x1b7/0x4a0 [fnic]
[  122.095909]  [<ffffffff8138434f>] pci_device_remove+0x3f/0xc0
[  122.095915]  [<ffffffff81492fb7>] __device_release_driver+0x87/0x120
[  122.095922]  [<ffffffff81493a38>] driver_detach+0xc8/0xd0
[  122.095930]  [<ffffffff81492c19>] bus_remove_driver+0x59/0xe0
[  122.095934]  [<ffffffff814942e0>] driver_unregister+0x30/0x70
[  122.095941]  [<ffffffff81382dba>] pci_unregister_driver+0x2a/0x80
[  122.095952]  [<ffffffffa01808cc>] fnic_cleanup_module+0x10/0x7a [fnic]
[  122.095957]  [<ffffffff8110e8ec>] SyS_delete_module+0x1ac/0x230
[  122.095961]  [<ffffffff81028666>] ? syscall_trace_leave+0xc6/0x150
[  122.095966]  [<ffffffff8173dcee>] system_call_fastpath+0x12/0x71
[  122.095968] ---[ end trace 29ba5813719045a6 ]---

While, refactoring block device code seems not valuable if just
because of above noisy but not so dangerous WARN flood.

So this patch suppress the warning flood by replacing WARN() with
pr_debug() as shortcut before refactoring all related block device
code.

This issue also could be reproduced with stable v4.12 kernel.

Reported-by: Lifei Cai <lifei.cai@oracle.com>
Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
---
 Built and tested with stable v4.12
 fs/sysfs/group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 539d5f0..af09a02 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -219,8 +219,7 @@ void sysfs_remove_group(struct kobject *kobj,
 	if (grp->name) {
 		kn = kernfs_find_and_get(parent, grp->name);
 		if (!kn) {
-			WARN(!kn, KERN_WARNING
-			     "sysfs group '%s' not found for kobject '%s'\n",
+			pr_debug("sysfs group '%s' not found for kobject '%s'\n",
 			     grp->name, kobject_name(kobj));
 			return;
 		}
-- 
1.8.3.1
