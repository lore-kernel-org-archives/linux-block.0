Return-Path: <3lO-rWwkbBQcz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvth4ivlrlyuls.kr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Wed, 26 Sep 2018 13:44:04 -0700
Message-ID: <00000000000070c1950576cc48aa@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in blk_mq_map_swqueue
From: syzbot <syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-ID: <linux-block@vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    02214bfc89c7 Merge tag 'media/v4.19-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b239c6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
dashboard link: https://syzkaller.appspot.com/bug?extid=83e8cbe702263932d9d4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1057591a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ad9f69400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a429
RDX: 0000000000000002 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000001 R09: 0000000000000032
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007f2a2bb33d80 R14: ffffffffffffffff R15: 0000000000000005
BUG: unable to handle kernel NULL pointer dereference at 0000000000000118
PGD 1cdc72067 P4D 1cdc72067 PUD 1cdeb4067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5498 Comm: syz-executor702 Not tainted 4.19.0-rc5+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cpumask_set_cpu include/linux/cpumask.h:311 [inline]
RIP: 0010:blk_mq_map_swqueue+0x29c/0xa70 block/blk-mq.c:2336
Code: 80 3c 1a 00 0f 85 fa 06 00 00 44 89 ee bf 3f 00 00 00 4d 8b 24 24 e8  
33 01 03 fe 41 83 fd 3f 0f 87 1c 05 00 00 e8 14 00 03 fe <f0> 4d 0f ab b4  
24 18 01 00 00 49 8d bc 24 74 01 00 00 48 89 fa 48
RSP: 0018:ffff8801cedaf4e0 EFLAGS: 00010293
RAX: ffff8801c4f80400 RBX: dffffc0000000000 RCX: ffffffff837be3fd
RDX: 0000000000000000 RSI: ffffffff837be40c RDI: 0000000000000005
RBP: ffff8801cedaf550 R08: ffff8801c4f80400 R09: 0000000000000000
R10: ffffed003a31dff0 R11: ffff8801d18eff83 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: ffff8801d1fd7000
FS:  00007f2a2bb34700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000118 CR3: 00000001c55c5000 CR4: 00000000001406f0
Call Trace:
  blk_mq_queue_reinit block/blk-mq.c:2675 [inline]
  __blk_mq_update_nr_hw_queues block/blk-mq.c:2994 [inline]
  blk_mq_update_nr_hw_queues+0xb2a/0xe50 block/blk-mq.c:3008
  nbd_start_device+0x1d2/0xcd0 drivers/block/nbd.c:1154
  nbd_start_device_ioctl drivers/block/nbd.c:1195 [inline]
  __nbd_ioctl drivers/block/nbd.c:1266 [inline]
  nbd_ioctl+0x6af/0xd40 drivers/block/nbd.c:1306
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x9ac/0x2010 block/ioctl.c:601
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a429
Code: e8 ac b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2a2bb33d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a429
RDX: 0000000000000002 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000001 R09: 0000000000000032
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007f2a2bb33d80 R14: ffffffffffffffff R15: 0000000000000005
Modules linked in:
CR2: 0000000000000118
---[ end trace cca4d386a05f3868 ]---
RIP: 0010:cpumask_set_cpu include/linux/cpumask.h:311 [inline]
RIP: 0010:blk_mq_map_swqueue+0x29c/0xa70 block/blk-mq.c:2336
Code: 80 3c 1a 00 0f 85 fa 06 00 00 44 89 ee bf 3f 00 00 00 4d 8b 24 24 e8  
33 01 03 fe 41 83 fd 3f 0f 87 1c 05 00 00 e8 14 00 03 fe <f0> 4d 0f ab b4  
24 18 01 00 00 49 8d bc 24 74 01 00 00 48 89 fa 48
RSP: 0018:ffff8801cedaf4e0 EFLAGS: 00010293
RAX: ffff8801c4f80400 RBX: dffffc0000000000 RCX: ffffffff837be3fd
RDX: 0000000000000000 RSI: ffffffff837be40c RDI: 0000000000000005
RBP: ffff8801cedaf550 R08: ffff8801c4f80400 R09: 0000000000000000
R10: ffffed003a31dff0 R11: ffff8801d18eff83 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: ffff8801d1fd7000
FS:  00007f2a2bb34700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000118 CR3: 00000001c55c5000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
