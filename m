Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32802 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdC0VpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 17:45:05 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: v4.11-rc blk-mq lockup?
Date: Mon, 27 Mar 2017 21:44:52 +0000
Message-ID: <1490651076.7897.11.camel@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens,

If I leave the srp-test software running for a few minutes using the
following command:

# while ~bart/software/infiniband/srp-test/run_tests -d -r 30; do :; done

then after some time the following complaint appears for multiple
kworkers:

INFO: task kworker/9:0:65 blocked for more than 480 seconds.
=A0=A0=A0=A0=A0=A0Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0I=A0=A0=A0=A0=A04=
.11.0-rc4-dbg+ #5
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/9:0=A0=A0=A0=A0=A0D=A0=A0=A0=A00=A0=A0=A0=A065=A0=A0=A0=A0=A0=A02 0=
x00000000
Workqueue: dio/dm-0 dio_aio_complete_work
Call Trace:
=A0__schedule+0x3df/0xc10
=A0schedule+0x38/0x90
=A0rwsem_down_write_failed+0x2c4/0x4c0
=A0call_rwsem_down_write_failed+0x17/0x30
=A0down_write+0x5a/0x70
=A0__generic_file_fsync+0x43/0x90
=A0ext4_sync_file+0x2d0/0x550
=A0vfs_fsync_range+0x46/0xa0
=A0dio_complete+0x181/0x1b0
=A0dio_aio_complete_work+0x17/0x20
=A0process_one_work+0x208/0x6a0
=A0worker_thread+0x49/0x4a0
=A0kthread+0x107/0x140
=A0ret_from_fork+0x2e/0x40

I had not yet observed this behavior with kernel v4.10 or older. If this
happens and I check the queue state with the following script:

#!/bin/bash

cd /sys/class/block || exit $?
for dev in *; do
=A0=A0=A0=A0if [ -e "$dev/mq" ]; then
	echo "$dev"
	for f in "$dev"/mq/*/{pending,*/rq_list}; do
	=A0=A0=A0=A0[ -e "$f" ] || continue
	=A0=A0=A0=A0if { read -r line1 && read -r line2; } <"$f"; then
		echo "$f"
		echo "$line1 $line2" >/dev/null
		head -n 9 "$f"
	=A0=A0=A0=A0fi
	done
	(
	=A0=A0=A0=A0cd /sys/kernel/debug/block >&/dev/null &&
	=A0=A0=A0=A0for d in "$dev"/mq/*; do
		[ ! -d "$d" ] && continue
		grep -q '^busy=3D0$' "$d/tags" && continue
	=A0=A0=A0=A0=A0=A0=A0=A0for f in "$d"/{dispatch,tags*,cpu*/rq_list}; do
		=A0=A0=A0=A0[ -e "$f" ] && grep -aH '' "$f"
		done
	=A0=A0=A0=A0done
	)
=A0=A0=A0=A0fi
done

then the following output appears:

sda
sdb
sdc
sdd
sdd/mq/3/dispatch:ffff880401655d00 {.cmd_flags=3D0xca01, .rq_flags=3D0x2040=
, .tag=3D59, .internal_tag=3D-1}
sdd/mq/3/tags:nr_tags=3D62
sdd/mq/3/tags:nr_reserved_tags=3D0
sdd/mq/3/tags:active_queues=3D0
sdd/mq/3/tags:
sdd/mq/3/tags:bitmap_tags:
sdd/mq/3/tags:depth=3D62
sdd/mq/3/tags:busy=3D31
sdd/mq/3/tags:bits_per_word=3D8
sdd/mq/3/tags:map_nr=3D8
sdd/mq/3/tags:alloc_hint=3D{23, 23, 52, 1, 55, 29, 17, 22, 34, 48, 25, 49, =
37, 43, 58, 25, 6, 20, 50, 14, 55, 7, 21, 17, 26, 36, 43, 43, 4, 6, 3, 47}
sdd/mq/3/tags:wake_batch=3D7
sdd/mq/3/tags:wake_index=3D0
sdd/mq/3/tags:ws=3D{
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sdd/mq/3/tags:}
sdd/mq/3/tags:round_robin=3D0
sdd/mq/3/tags_bitmap:00000000: ffff ff1f 0000 0018
sdd/mq/3/cpu5/rq_list:ffff880401657440 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D60, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba0000 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D0, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba1740 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D1, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba2e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D2, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba45c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D3, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba5d00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D4, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba7440 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D5, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037aba8b80 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D6, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037abaa2c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D7, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037ababa00 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D8, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037abad140 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D9, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88037abae880 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D10, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff880369900000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D11, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff880369901740 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D12, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff880369902e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D13, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8803699045c0 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D14, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff880369905d00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D15, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff880369907440 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D16, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff880369908b80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D17, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88036990a2c0 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D18, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88036990ba00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D19, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88036990d140 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D20, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff88036990e880 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D21, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b0000 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D22, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b1740 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D23, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b2e80 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D24, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b45c0 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D25, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b5d00 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D26, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b7440 {.cmd_flags=3D0xca01, .rq_flags=3D0x=
2040, .tag=3D27, .internal_tag=3D-1}
sdd/mq/3/cpu5/rq_list:ffff8804001b8b80 {.cmd_flags=3D0x7a01, .rq_flags=3D0x=
2040, .tag=3D28, .internal_tag=3D-1}
sde
sde/mq/3/tags:nr_tags=3D62
sde/mq/3/tags:nr_reserved_tags=3D0
sde/mq/3/tags:active_queues=3D0
sde/mq/3/tags:
sde/mq/3/tags:bitmap_tags:
sde/mq/3/tags:depth=3D62
sde/mq/3/tags:busy=3D31
sde/mq/3/tags:bits_per_word=3D8
sde/mq/3/tags:map_nr=3D8
sde/mq/3/tags:alloc_hint=3D{23, 23, 52, 1, 55, 29, 17, 22, 34, 48, 25, 49, =
37, 43, 58, 25, 6, 20, 50, 14, 55, 7, 21, 17, 26, 36, 43, 43, 4, 6, 3, 47}
sde/mq/3/tags:wake_batch=3D7
sde/mq/3/tags:wake_index=3D0
sde/mq/3/tags:ws=3D{
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:	{.wait_cnt=3D7, .wait=3Dinactive},
sde/mq/3/tags:}
sde/mq/3/tags:round_robin=3D0
sde/mq/3/tags_bitmap:00000000: ffff ff1f 0000 0018
sdf
sdg
sdh
sdi
sdj
sr0

I am using the "none" scheduler:

# cat /sys/class/block/sdd/queue/scheduler =A0
[none]=A0
# cat /sys/class/block/sde/queue/scheduler =A0=A0
[none]

What is remarkable is that I see pending requests for the sd* devices
but not for any dm* device and also that the number of busy requests (31)
is exactly half of the queue depth (62). Could this indicate that the
block layer stopped processing these blk-mq queues?

If this happens and I run the following command to trigger SRP logout:

# for p in /sys/class/srp_remote_ports/*; do echo 1 >$p/delete;=A0done

then the test that was running finishes, reports that removing the
multipath device failed and echo w >/proc/sysrq-trigger produces the
following output:

sysrq: SysRq : Show Blocked State
=A0 task=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0PC stack=A0=A0=A0pid father
systemd-udevd=A0=A0=A0D=A0=A0=A0=A00 14490=A0=A0=A0=A0508 0x00000106
Call Trace:
=A0__schedule+0x3df/0xc10
=A0schedule+0x38/0x90
=A0io_schedule+0x11/0x40
=A0__lock_page+0x10c/0x140
=A0truncate_inode_pages_range+0x45d/0x780
=A0truncate_inode_pages+0x10/0x20
=A0kill_bdev+0x30/0x40
=A0__blkdev_put+0x71/0x220
=A0blkdev_put+0x49/0x170
=A0blkdev_close+0x20/0x30
=A0__fput+0xe8/0x1f0
=A0____fput+0x9/0x10
=A0task_work_run+0x80/0xb0
=A0do_exit+0x30c/0xc70
=A0do_group_exit+0x4b/0xc0
=A0get_signal+0x2c2/0x930
=A0do_signal+0x23/0x670
=A0exit_to_usermode_loop+0x5d/0xa0
=A0do_syscall_64+0xd5/0x140
=A0entry_SYSCALL64_slow_path+0x25/0x25

Does this indicate that truncate_inode_pages_range() is waiting
because a block layer queue got stuck?

The kernel tree I used in my tests is the result of merging the
following commits:
* commit 3dca2c2f3d3b=A0from git://git.kernel.dk/linux-block.git
  ("Merge branch 'for-4.12/block' into for-next")
* commit f88ab0c4b481 from git://git.kernel.org/pub/scm/linux/kernel/git/mk=
p/scsi.git
  ("scsi: libsas: fix ata xfer length")
* commit ad0376eb1483 from git://git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux.git
  ("Merge tag 'edac_for_4.11_2' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/bp/bp")

Please let me know if you need more information.

Thanks,

Bart.=
