Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mifar.in ([46.101.129.31]:50370 "EHLO mifar.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeDENXZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Apr 2018 09:23:25 -0400
Received: from mifar.in (unknown [109.204.214.187])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mifar.in", Issuer "mifar.in" (verified OK))
        by mifar.in (Postfix) with ESMTPS id 5FE9C5FEF7
        for <linux-block@vger.kernel.org>; Thu,  5 Apr 2018 16:15:19 +0300 (EEST)
Date: Thu, 5 Apr 2018 16:15:15 +0300
From: Sami Farin <hvtaifwkbgefbaei@gmail.com>
To: linux-block@vger.kernel.org
Subject: 4.15.15: BFQ stalled at blk_mq_get_tag
Message-ID: <20180405131515.3zzav2x7kp5z7uax@m.mifar.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I was using chacharand to fill 32 GB SD card (VFAT fs) (maybe 30 MiB/s)
with random data, it froze halfway.  There was 400 MiB Dirty data.
After reboot the filling operation went OK when I used kyber scheduler.
System is Fedora 27 on Core i5 2500K / 16 GiB.

sysrq: SysRq : Show Blocked State
 task                        PC stack   pid father
device poll     D    0 2811838      1 0x00000000
Call Trace:
? __schedule+0x2c2/0x910
schedule+0x2a/0x80
schedule_timeout+0x8a/0x490
? collect_expired_timers+0xa0/0xa0
msleep+0x24/0x30
usb_port_suspend+0x298/0x430 [usbcore]
usb_suspend_both+0x17d/0x200 [usbcore]
? usb_probe_interface+0x300/0x300 [usbcore]
usb_runtime_suspend+0x25/0x60 [usbcore]
__rpm_callback+0xb7/0x1f0
? usb_probe_interface+0x300/0x300 [usbcore]
rpm_callback+0x1a/0x80
? usb_probe_interface+0x300/0x300 [usbcore]
rpm_suspend+0x11e/0x660
__pm_runtime_suspend+0x36/0x60
usbdev_release+0xb3/0x120 [usbcore]
__fput+0xa3/0x1f0
task_work_run+0x82/0xa0
exit_to_usermode_loop+0x91/0xa0
do_syscall_64+0xe7/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f41101c170c
RSP: 002b:00007f410e655b80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f410e655ecb RCX: 00007f41101c170c
RDX: 0000000000000000 RSI: 00007f410e655ea0 RDI: 0000000000000007
RBP: 00007f410e655ec4 R08: 0000000000000000 R09: 00007f4100000080
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f410e655c90
R13: 00007f410e655ecb R14: 0000000000000007 R15: 00007f410e655ebb
kworker/u8:4    D    0 2978647      2 0x80000000
Workqueue: writeback wb_workfn (flush-8:80)
Call Trace:
? __schedule+0x2c2/0x910
schedule+0x2a/0x80
io_schedule+0xd/0x30
blk_mq_get_tag+0x150/0x250
? wait_woken+0x80/0x80
blk_mq_get_request+0x131/0x450
? bfq_bio_merge+0xcb/0x100
blk_mq_make_request+0x118/0x6e0
? blk_queue_enter+0x31/0x2f0
generic_make_request+0xfd/0x2a0
? submit_bio+0x67/0x140
submit_bio+0x67/0x140
? guard_bio_eod+0x78/0x150
mpage_writepages+0xa7/0xe0
? fat_add_cluster+0x60/0x60 [fat]
? do_writepages+0x37/0xc0
? fat_writepage+0x10/0x10 [fat]
do_writepages+0x37/0xc0
? reacquire_held_locks+0x8f/0x150
? writeback_sb_inodes+0xef/0x490
? __writeback_single_inode+0x5a/0x530
__writeback_single_inode+0x5a/0x530
writeback_sb_inodes+0x1ed/0x490
__writeback_inodes_wb+0x55/0xa0
wb_writeback+0x261/0x3f0
? wb_workfn+0x1fd/0x4f0
wb_workfn+0x1fd/0x4f0
process_one_work+0x206/0x560
worker_thread+0x2c/0x380
? process_one_work+0x560/0x560
kthread+0x10e/0x130
? kthread_create_on_node+0x40/0x40
ret_from_fork+0x35/0x40
kworker/0:3     D    0 2979285      2 0x80000000
Workqueue: events_freezable_power_ disk_events_workfn
Call Trace:
? __schedule+0x2c2/0x910
schedule+0x2a/0x80
io_schedule+0xd/0x30
blk_mq_get_tag+0x150/0x250
? wait_woken+0x80/0x80
blk_mq_get_request+0x131/0x450
blk_mq_alloc_request+0x58/0xb0
blk_get_request_flags+0x3b/0x150
scsi_execute+0x33/0x250
scsi_test_unit_ready+0x48/0xb0
sd_check_events+0xc8/0x170
disk_check_events+0x54/0x130
process_one_work+0x206/0x560
worker_thread+0x2c/0x380
? process_one_work+0x560/0x560
kthread+0x10e/0x130
? kthread_create_on_node+0x40/0x40
? SyS_exit+0xe/0x10
ret_from_fork+0x35/0x40
chacharand      D    0 2980742 2978974 0x80000002
Call Trace:
? __schedule+0x2c2/0x910
schedule+0x2a/0x80
io_schedule+0xd/0x30
blk_mq_get_tag+0x150/0x250
? wait_woken+0x80/0x80
blk_mq_get_request+0x131/0x450
? bfq_bio_merge+0xcb/0x100
blk_mq_make_request+0x118/0x6e0
? blk_queue_enter+0x31/0x2f0
generic_make_request+0xfd/0x2a0
? submit_bio+0x67/0x140
submit_bio+0x67/0x140
? guard_bio_eod+0x78/0x150
__mpage_writepage+0x67e/0x7a0
? clear_page_dirty_for_io+0x10f/0x240
? clear_page_dirty_for_io+0x12f/0x240
write_cache_pages+0x1ee/0x460
? clean_buffers+0x60/0x60
? fat_add_cluster+0x60/0x60 [fat]
mpage_writepages+0x68/0xe0
? fat_add_cluster+0x60/0x60 [fat]
? do_writepages+0x37/0xc0
? fat_writepage+0x10/0x10 [fat]
do_writepages+0x37/0xc0
? __filemap_fdatawrite_range+0x99/0xe0
? __filemap_fdatawrite_range+0xa6/0xe0
__filemap_fdatawrite_range+0xa6/0xe0
? sync_inode_metadata+0x2a/0x30
fat_flush_inodes+0x25/0x60 [fat]
fat_file_release+0x2a/0x40 [fat]
__fput+0xa3/0x1f0
task_work_run+0x82/0xa0
do_exit+0x29b/0xbf0
do_group_exit+0x34/0xb0
SyS_exit_group+0xb/0x10
do_syscall_64+0x62/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7fd9172b3178
RSP: 002b:00007fffe01eb248 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd9172b3178
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007fd9175b08b8 R08: 00000000000000e7 R09: ffffffffffffff80
R10: 00007fffe01eb1d0 R11: 0000000000000246 R12: 00007fd9175b08b8
R13: 00007fd9175b5d60 R14: 0000000000000000 R15: 0000000000000000
(ostnamed)      D    0 2981753      1 0x00000004
Call Trace:
? __schedule+0x2c2/0x910
? rwsem_down_write_failed+0x174/0x260
schedule+0x2a/0x80
rwsem_down_write_failed+0x179/0x260
? call_rwsem_down_write_failed+0x13/0x20
call_rwsem_down_write_failed+0x13/0x20
down_write+0x3b/0x50
? do_mount+0x434/0xdb0
do_mount+0x434/0xdb0
? SyS_statfs+0x1f/0x30
SyS_mount+0x50/0xd0
do_syscall_64+0x62/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f46fb97259a
RSP: 002b:00007fff765583a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46fb97259a
RDX: 0000000000000000 RSI: 0000556304add3e0 RDI: 0000000000000000
RBP: 00007fff76558e00 R08: 0000000000000000 R09: 0000000000000070
R10: 0000000000001027 R11: 0000000000000206 R12: 0000556304ae8a30
R13: 0000556304add3e0 R14: 0000556304a4fb40 R15: 0000000000000015
(ostnamed)      D    0 2983102      1 0x00000004
Call Trace:
? __schedule+0x2c2/0x910
? rwsem_down_write_failed+0x174/0x260
schedule+0x2a/0x80
rwsem_down_write_failed+0x179/0x260
? call_rwsem_down_write_failed+0x13/0x20
call_rwsem_down_write_failed+0x13/0x20
down_write+0x3b/0x50
? do_mount+0x434/0xdb0
do_mount+0x434/0xdb0
? SyS_statfs+0x1f/0x30
SyS_mount+0x50/0xd0
do_syscall_64+0x62/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f46fb97259a
RSP: 002b:00007fff765583a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46fb97259a
RDX: 0000000000000000 RSI: 00005563049ef570 RDI: 0000000000000000
RBP: 00007fff76558e00 R08: 0000000000000000 R09: 00000000000000e0
R10: 0000000000001027 R11: 0000000000000206 R12: 0000556304ae7700
R13: 00005563049ef570 R14: 0000556304a4fb40 R15: 0000000000000015
(ostnamed)      D    0 2984561      1 0x00000004
Call Trace:
? __schedule+0x2c2/0x910
? rwsem_down_write_failed+0x174/0x260
schedule+0x2a/0x80
rwsem_down_write_failed+0x179/0x260
? call_rwsem_down_write_failed+0x13/0x20
call_rwsem_down_write_failed+0x13/0x20
down_write+0x3b/0x50
? do_mount+0x434/0xdb0
do_mount+0x434/0xdb0
? SyS_statfs+0x1f/0x30
SyS_mount+0x50/0xd0
do_syscall_64+0x62/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f46fb97259a
RSP: 002b:00007fff765583a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46fb97259a
RDX: 0000000000000000 RSI: 0000556304addb10 RDI: 0000000000000000
RBP: 00007fff76558e00 R08: 0000000000000000 R09: 00000000000001c0
R10: 0000000000001027 R11: 0000000000000206 R12: 0000556304addd10
R13: 0000556304addb10 R14: 0000556304a4fb40 R15: 0000000000000015
(ostnamed)      D    0 2986247      1 0x00000004
Call Trace:
? __schedule+0x2c2/0x910
? rwsem_down_write_failed+0x174/0x260
schedule+0x2a/0x80
rwsem_down_write_failed+0x179/0x260
? call_rwsem_down_write_failed+0x13/0x20
call_rwsem_down_write_failed+0x13/0x20
down_write+0x3b/0x50
? do_mount+0x434/0xdb0
do_mount+0x434/0xdb0
? SyS_statfs+0x1f/0x30
SyS_mount+0x50/0xd0
do_syscall_64+0x62/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f46fb97259a
RSP: 002b:00007fff765583a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46fb97259a
RDX: 0000000000000000 RSI: 0000556304ae0670 RDI: 0000000000000000
RBP: 00007fff76558e00 R08: 0000000000000000 R09: 00000000000001c0
R10: 0000000000001027 R11: 0000000000000206 R12: 0000556304ae7700
R13: 0000556304ae0670 R14: 0000556304a4fb40 R15: 0000000000000015
(ostnamed)      D    0 2987631      1 0x00000000
Call Trace:
? __schedule+0x2c2/0x910
? rwsem_down_write_failed+0x174/0x260
schedule+0x2a/0x80
rwsem_down_write_failed+0x179/0x260
? call_rwsem_down_write_failed+0x13/0x20
call_rwsem_down_write_failed+0x13/0x20
down_write+0x3b/0x50
? do_mount+0x434/0xdb0
do_mount+0x434/0xdb0
? SyS_statfs+0x1f/0x30
SyS_mount+0x50/0xd0
do_syscall_64+0x62/0x100
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f46fb97259a
RSP: 002b:00007fff765583a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46fb97259a
RDX: 0000000000000000 RSI: 0000556304b92bc0 RDI: 0000000000000000
RBP: 00007fff76558e00 R08: 0000000000000000 R09: 00000000000000e0
R10: 0000000000001027 R11: 0000000000000206 R12: 0000556304a12370
R13: 0000556304b92bc0 R14: 0000556304a4fb40 R15: 0000000000000015
systemd[1]: systemd-hostnamed.service: Start operation timed out. Terminating.

-- 
Do what you love because life is too short for anything else.
