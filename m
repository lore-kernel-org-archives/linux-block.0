Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <4871d3cc-769e-b65a-8c05-bfaf6e6fdc69@I-love.SAKURA.ne.jp>
References: <000000000000f961390571457196@google.com> <4871d3cc-769e-b65a-8c05-bfaf6e6fdc69@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 2 Nov 2018 20:24:05 +0100
Message-ID: <CACT4Y+Y0OjxACZNKpKpaJRjAAdwjozkR9PEti6Y+KhO4pRev+A@mail.gmail.com>
Subject: Re: INFO: task hung in lo_release
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+a4e4a2663a21c3c3c2b1@syzkaller.appspotmail.com>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 4:28 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/07/18 21:46, syzbot wrote:
>> Showing all locks held in the system:
>> 1 lock held by khungtaskd/902:
>>  #0: 000000004f60bbd2 (rcu_read_lock){....}, at: debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
>> 1 lock held by rsyslogd/4455:
>>  #0: 0000000086a2d206 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200 fs/file.c:766
>> 2 locks held by getty/4545:
>>  #0: 00000000ece833eb (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000536bed00 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4546:
>>  #0: 00000000180e8f60 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 000000008efac671 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4547:
>>  #0: 00000000ca308631 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 000000007c05fef3 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4548:
>>  #0: 000000009d93809c (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 000000004c489ffa (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4549:
>>  #0: 00000000ec3b322c (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000107aeb96 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4550:
>>  #0: 000000006d1a7b96 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000564c003d (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4551:
>>  #0: 000000003cba543a (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000149a289b (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by syz-executor6/4597:
>>  #0: 0000000033676c6d (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0xc2/0x830 fs/block_dev.c:1780
>>  #1: 00000000127b5bfb (loop_index_mutex){+.+.}, at: lo_release+0x1f/0x1f0 drivers/block/loop.c:1675
>> 2 locks held by blkid/18494:
>>  #0: 000000000efc6462 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>>  #1: 00000000127b5bfb (loop_index_mutex){+.+.}, at: lo_open+0x1b/0xb0 drivers/block/loop.c:1632
>> 1 lock held by syz-executor5/18515:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor1/18498:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor3/18521:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 2 locks held by syz-executor3/18522:
>>  #0: 00000000399ff791 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>>  #1: 00000000127b5bfb (loop_index_mutex){+.+.}, at: lo_open+0x1b/0xb0 drivers/block/loop.c:1632
>> 1 lock held by syz-executor4/18506:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor0/18508:
>> 1 lock held by syz-executor7/18507:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor2/18514:
>>  #0: 000000000efc6462 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>> 1 lock held by blkid/18513:
>>  #0: 0000000033676c6d (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>> 1 lock held by blkid/18520:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_probe+0x82/0x1d0 drivers/block/loop.c:1979
>> 1 lock held by blkid/18524:
>>  #0: 00000000399ff791 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>
> Dmitry, it is impossible to check what these lock holders are doing without dump of these threads
> (they are not always TASK_UNINTERRUPTIBLE waiters; e.g. PID=18508 is TASK_RUNNING with a lock held).

I know. One day I will hopefully get to implementing dump collection...

> Jens, when can we start testing "[PATCH v3] block/loop: Serialize ioctl operations." ?

Was that merged? If we have a potential fix, merging it may be the
simplest way to address it without debugging.
I see that this "[v4] block/loop: Serialize ioctl operations." still
has "State: New":
https://patchwork.kernel.org/patch/10612217/
