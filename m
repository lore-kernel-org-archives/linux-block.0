Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36575 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdHAVcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2017 17:32:39 -0400
Received: by mail-oi0-f45.google.com with SMTP id g131so27642830oic.3
        for <linux-block@vger.kernel.org>; Tue, 01 Aug 2017 14:32:39 -0700 (PDT)
MIME-Version: 1.0
From: Thomas Caputi <tcaputi@datto.com>
Date: Tue, 1 Aug 2017 17:32:38 -0400
Message-ID: <CAF2oFs9BB0qZ80GaYDk58HX0Lim7yMYRb_4G5WivTZi-9M-W=A@mail.gmail.com>
Subject: Drives Seizing Under Write Loads
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello linux-block,
My company is currently experiencing some problems with one particular
brand of HDD. The symptoms are that the drive will experience
extremely long IO wait times, extremely low IOPS, and near 100% disk
utilization (see the following output from iostat). As a side effect
of the high utilization, the drives actually heat up enough to trigger
some temperature warnings on our systems. Sometimes the drives'
performance returns to normal after a little while, but most of the
time it requires a reboot.

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           1.77    0.00    0.76   45.71    0.00   51.77

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    4.00   76.00    76.00  1156.00
30.80     3.79   94.00  924.00   50.32  12.50 100.00

Our setup is essentially as follows:
We are using Linux kernel version 4.4.0 on Ubuntu 16.04.
The system has 16GB of RAM and is not using most of it.
We have 2 failing configurations (one using a 1TB HDD, one using a 1TB
SSHD with 8 GB of flash).
The drive has a 40GB root partition running ext4.
The rest of the drive is given to a second partition, which is used as
a zpool for zfs (v0.6.5.6).

We are able to trigger the problem by generating a heavy random write
workload on ZFS for about 10 minutes. After a few minutes, the system
dumped a few warning timeouts to dmesg. The most interesting of them
was this one, which seems to indicate that the block device could not
allocate a tag for an IO:

[37805.995283] INFO: task umount:3546 blocked for more than 120 seconds.
[37805.995284]       Tainted: P           OE   4.4.0-24-generic #43-Ubuntu
[37805.995285] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[37805.995286] umount          D ffff88008c93b778     0  3546      1 0x00000000
[37805.995289]  ffff88008c93b778 ffffffff81f35000 ffff880035810dc0
ffff8801ba523700
[37805.995291]  ffff88008c93c000 ffff88021ed96d00 7fffffffffffffff
ffff88008c93b950
[37805.995293]  ffffe8ffffd80080 ffff88008c93b790 ffffffff81821b15
0000000000000000
[37805.995295] Call Trace:
[37805.995297]  [<ffffffff81821b15>] schedule+0x35/0x80
[37805.995299]  [<ffffffff81824c35>] schedule_timeout+0x1b5/0x270
[37805.995302]  [<ffffffff813bcd66>] ? blk_flush_plug_list+0xd6/0x240
[37805.995305]  [<ffffffff810f585c>] ? ktime_get+0x3c/0xb0
[37805.995307]  [<ffffffff81821044>] io_schedule_timeout+0xa4/0x110
[37805.995309]  [<ffffffff813c8a2b>] bt_get+0x14b/0x1d0
[37805.995312]  [<ffffffff810c3b80>] ? wake_atomic_t_function+0x60/0x60
[37805.995314]  [<ffffffff813c8d95>] blk_mq_get_tag+0x45/0xe0
[37805.995316]  [<ffffffff813c454b>] __blk_mq_alloc_request+0x1b/0x1f0
[37805.995318]  [<ffffffff813c64a4>] blk_mq_map_request+0x1a4/0x210
[37805.995320]  [<ffffffff813c7514>] blk_sq_make_request+0xa4/0x360
[37805.995323]  [<ffffffff813bb3d2>] generic_make_request+0xf2/0x1d0
[37805.995325]  [<ffffffff813bb526>] submit_bio+0x76/0x170
[37805.995327]  [<ffffffff8124506f>] submit_bh_wbc+0x12f/0x160
[37805.995329]  [<ffffffff81247045>]
__block_write_full_page.constprop.38+0x115/0x3a0
[37805.995331]  [<ffffffff81247630>] ? I_BDEV+0x20/0x20
[37805.995333]  [<ffffffff81247630>] ? I_BDEV+0x20/0x20
[37805.995336]  [<ffffffff81247415>] block_write_full_page+0x145/0x170
[37805.995340]  [<ffffffff81248208>] blkdev_writepage+0x18/0x20
[37805.995343]  [<ffffffff81198813>] __writepage+0x13/0x30
[37805.995346]  [<ffffffff8119930e>] write_cache_pages+0x1ee/0x510
[37805.995349]  [<ffffffff81198800>] ? wb_position_ratio+0x1f0/0x1f0
[37805.995353]  [<ffffffff81199681>] generic_writepages+0x51/0x80
[37805.995357]  [<ffffffff8119bafe>] do_writepages+0x1e/0x30
[37805.995361]  [<ffffffff8118ec46>] __filemap_fdatawrite_range+0xc6/0x100
[37805.995364]  [<ffffffff8118ed3c>] filemap_flush+0x1c/0x20
[37805.995366]  [<ffffffff81249ae6>] __sync_blockdev+0x26/0x30
[37805.995369]  [<ffffffff81240cae>] sync_filesystem+0x4e/0xa0
[37805.995372]  [<ffffffff8120ee37>] generic_shutdown_super+0x27/0x100
[37805.995374]  [<ffffffff8120f20c>] kill_block_super+0x2c/0xa0
[37805.995378]  [<ffffffff8131c4a7>] fuse_kill_sb_blk+0x47/0x50
[37805.995380]  [<ffffffff8120f363>] deactivate_locked_super+0x43/0x70
[37805.995382]  [<ffffffff8120f83c>] deactivate_super+0x5c/0x60
[37805.995384]  [<ffffffff8122d0ef>] cleanup_mnt+0x3f/0x90
[37805.995386]  [<ffffffff8122d182>] __cleanup_mnt+0x12/0x20
[37805.995389]  [<ffffffff8109eac3>] task_work_run+0x73/0x90
[37805.995392]  [<ffffffff81003242>] exit_to_usermode_loop+0xc2/0xd0
[37805.995394]  [<ffffffff81003c6e>] syscall_return_slowpath+0x4e/0x60
[37805.995397]  [<ffffffff81825d50>] int_ret_from_sys_call+0x25/0x8f

I would like to try to narrow this issue down a bit further. It seems
fairly likely that this might be an issue with the drive's firmware
(especially since we have only seen this problem with one brand of
drives). We have tried different versions of ZFS and the most recent
release (v0.7.0) seems to stop the problem from happening for several
more hours, but it hasn't completely gone away. Once the problem
occurs, the entire drive is effected (not just one of the partitions).

Is anyone aware of any bugs, issues, or fixes that may be related to
this problem? Is there a good way to narrow this down to a firmware
issue versus a kernel issue or a ZFS issue?

Thanks for any help,
Tom Caputi
