Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:33383 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbdAZVtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 16:49:19 -0500
Received: by mail-yb0-f175.google.com with SMTP id w194so161962148ybe.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 13:49:19 -0800 (PST)
MIME-Version: 1.0
From: Cheyenne Wills <cheyenne.wills@gmail.com>
Date: Thu, 26 Jan 2017 14:49:18 -0700
Message-ID: <CAHpsFVcKqJsUyT-4dNQ7EQV=v65QMvwiKd0cz9LxKhs0evuvHA@mail.gmail.com>
Subject: blocked task timeout with high IO load across multiple luns (using btrfs)
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Opened a bug -> https://bugzilla.kernel.org/show_bug.cgi?id=193331


tried multiple linux levels (4.4.21, 4.7, 4.9.5) (gentoo-sources).
Have been testing using the 4.9.5-gentoo sources kernel.


Might possible be a btrfs issue, but in an IRC chat with one of the
gentoo linux-kernel folks, they suggested starting here.


I have a reproducible IO hang when I do a btrfs scrub on a 4.5TB
filesystem with 15 luns.


Initial problem occurred during a filesystem backup.


Can recreate using btrfs scrub on the filesystem (takes just a few
minutes to hang on a freshly booted system).


System is a guest under xen, using xen-blkfront (which uses blk_mq).


Problem wasn't present on a 4.0.5 kernel level.


Backtraces are showing a consistent pattern around
blk_flush_plug_list. (above bugzilla has the entire output of all the
blocked tasks).


Let me know if there is more information needed.
=============================================


INFO: task btrfs:3268 blocked for more than 120 seconds.
Tainted: G W 4.9.5-gentoo #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
btrfs D 0 3268 1 0x00000000
ffff88045d840000 000000000000dacd ffff8804644381c0 ffff88045612d3c0
ffff8804663d8218 ffffc90001b7f5d8 ffffffff8178c976 0000000000000246
ffffe8ff00000002 ffff8804663d8218 0000000000000000 ffff88045612d3c0
Call Trace:
[<ffffffff8178c976>] ? __schedule+0x2f6/0x830
[<ffffffff8178cee1>] schedule+0x31/0x80
[<ffffffff81791156>] schedule_timeout+0x1f6/0x340
[<ffffffff814368e0>] ? blk_mq_flush_plug_list+0x120/0x130
[<ffffffff8142b4d9>] ? blk_flush_plug_list+0xc9/0x280
[<ffffffff8178c645>] io_schedule_timeout+0x65/0xa0
[<ffffffff81436ff7>] bt_get.isra.13+0x107/0x1a0
[<ffffffff810c9434>] ? sched_clock_cpu+0x84/0xa0
[<ffffffff810dd5b0>] ? wake_up_bit+0x30/0x30
[<ffffffff81437162>] blk_mq_get_tag+0x22/0x90
[<ffffffff81432edb>] __blk_mq_alloc_request+0x1b/0x220
[<ffffffff8143341b>] blk_mq_map_request+0x10b/0x1b0
[<ffffffff81433310>] ? blk_mq_stop_hw_queues+0x40/0x40
[<ffffffff81435f05>] blk_sq_make_request+0x95/0x280
[<ffffffff814294fc>] ? blk_queue_enter+0x9c/0x280
[<ffffffff8142947c>] ? blk_queue_enter+0x1c/0x280
[<ffffffff814298ab>] generic_make_request+0xcb/0x180
[<ffffffff814299b7>] submit_bio+0x57/0x110
[<ffffffff813c3d2d>] scrub_submit+0x2d/0x40
[<ffffffff813c3f8e>] scrub_add_page_to_rd_bio+0x24e/0x270
[<ffffffff810e988d>] ? trace_hardirqs_on+0xd/0x10
[<ffffffff813c54d7>] scrub_pages+0x1e7/0x400
[<ffffffff810e988d>] ? trace_hardirqs_on+0xd/0x10
[<ffffffff813c2768>] ? scrub_find_csum+0x138/0x150
[<ffffffff813c6d4b>] scrub_stripe+0x7fb/0x1170
[<ffffffff810c9434>] ? sched_clock_cpu+0x84/0xa0
[<ffffffff813c77cd>] scrub_chunk+0x10d/0x160
[<ffffffff813c7ac4>] scrub_enumerate_chunks+0x2a4/0x640
[<ffffffff813c99d5>] btrfs_scrub_dev+0x205/0x630
[<ffffffff810fd7fd>] ? rcu_read_lock_sched_held+0x5d/0x70
[<ffffffff811b8d03>] ? mnt_want_write_file+0x23/0x50
[<ffffffff813a2a63>] btrfs_ioctl+0x1b43/0x2700
[<ffffffff810c9434>] ? sched_clock_cpu+0x84/0xa0
[<ffffffff810c9347>] ? sched_clock_local+0x17/0x80
[<ffffffff810e5f52>] ? __lock_is_held+0x52/0x70
[<ffffffff811a890c>] do_vfs_ioctl+0x8c/0x6a0
[<ffffffff811b5371>] ? __fget+0x101/0x1f0
[<ffffffff811b5270>] ? expand_files+0x2a0/0x2a0
[<ffffffff811a8f5c>] SyS_ioctl+0x3c/0x70
[<ffffffff817928c1>] entry_SYSCALL_64_fastpath+0x1f/0xc2


Showing all locks held in the system:
3 locks held by kworker/u128:0/6:
#0: ("%s-%s""btrfs", name){.+.+.+}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#1: ((&work->normal_work)){+.+.+.}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#2: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813cb2ff>]
reada_start_machine_worker+0xaf/0x3a0
3 locks held by kworker/dying/29:
#0: (&acct->lock#2){+.+.+.}, at: [<ffffffff8111fffc>] acct_process+0xfc/0x2b0
#1: (sb_writers#3){.+.+.+}, at: [<ffffffff8111f7dc>] do_acct_process+0x4bc/0x540
#2: (&sb->s_type->i_mutex_key#6){+.+.+.}, at: [<ffffffff8137dfa0>]
btrfs_file_write_iter+0x60/0x5f0
3 locks held by kworker/u128:1/33:
#0: ("%s-%s""btrfs", name){.+.+.+}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#1: ((&work->normal_work)){+.+.+.}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#2: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813cb2ff>]
reada_start_machine_worker+0xaf/0x3a0
3 locks held by kworker/u128:3/127:
#0: ("%s-%s""btrfs", name){.+.+.+}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#1: ((&work->normal_work)){+.+.+.}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#2: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813cb2ff>]
reada_start_machine_worker+0xaf/0x3a0
2 locks held by khungtaskd/303:
#0: (rcu_read_lock){......}, at: [<ffffffff81133d80>] watchdog+0xa0/0x470
#1: (tasklist_lock){.+.+..}, at: [<ffffffff810e77cf>]
debug_show_all_locks+0x3f/0x1b0
3 locks held by btrfs-transacti/1164:
#0: (&fs_info->transaction_kthread_mutex){+.+...}, at:
[<ffffffff813609d4>] transaction_kthread+0x54/0x1e0
#1: (&fs_info->reloc_mutex){+.+...}, at: [<ffffffff81366172>]
btrfs_commit_transaction.part.25+0x352/0xa00
#2: (&fs_info->tree_log_mutex){+.+...}, at: [<ffffffff81366203>]
btrfs_commit_transaction.part.25+0x3e3/0xa00
1 lock held by btrfs-transacti/1740:
#0: (&fs_info->transaction_kthread_mutex){+.+...}, at:
[<ffffffff813609d4>] transaction_kthread+0x54/0x1e0
3 locks held by kworker/u128:5/2842:
#0: ("%s-%s""btrfs", name){.+.+.+}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#1: ((&work->normal_work)){+.+.+.}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#2: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813cb2ff>]
reada_start_machine_worker+0xaf/0x3a0
1 lock held by btrfs/3268:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3269:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3270:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3271:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3272:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3273:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3274:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3275:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3276:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3277:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3278:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3279:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3280:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3281:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3282:
#0: (sb_writers#3){.+.+.+}, at: [<ffffffff811b8d03>]
mnt_want_write_file+0x23/0x50
1 lock held by btrfs/3283:
#0: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813ca0db>]
btrfs_scrub_progress+0x2b/0x150
3 locks held by kworker/u128:6/3284:
#0: ("%s-%s""btrfs", name){.+.+.+}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#1: ((&work->normal_work)){+.+.+.}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#2: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813cb2ff>]
reada_start_machine_worker+0xaf/0x3a0
3 locks held by kworker/u128:10/3288:
#0: ("%s-%s""btrfs", name){.+.+.+}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#1: ((&work->normal_work)){+.+.+.}, at: [<ffffffff810b4021>]
process_one_work+0x141/0x410
#2: (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffff813cb2ff>]
reada_start_machine_worker+0xaf/0x3a0
1 lock held by ps/3303:
#0: (&acct->lock#2){+.+.+.}, at: [<ffffffff8111fffc>] acct_process+0xfc/0x2b0
1 lock held by grep/3304:
#0: (&acct->lock#2){+.+.+.}, at: [<ffffffff8111fffc>] acct_process+0xfc/0x2b0


=============================================
