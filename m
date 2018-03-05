Return-Path: <linux-block-owner@vger.kernel.org>
Received: from apollo.dupie.be ([62.210.113.39]:60692 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933075AbeCEJoP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Mar 2018 04:44:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 05 Mar 2018 10:44:13 +0100
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: linux-block@vger.kernel.org
Subject: Re: vgdisplay hang on iSCSI session
In-Reply-To: <1520191591.3413.1.camel@wdc.com>
References: <b175d4715df19110064f986599ff87c4@dupond.be>
 <696a6c0c-2629-6af0-b5c2-fb5ce56d5f2a@wdc.com>
 <860b5a2a9d02a6a44c24b69c43e81296@dupond.be>
 <1520191591.3413.1.camel@wdc.com>
Message-ID: <29c9d7bc9c3317045fe426b95acde577@dupond.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

Maby a long shot, but could it be fixed by 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/drivers/block/loop.c?h=v4.9.86&id=56bc086358cac1a2949783646eabd57447b9d672 
?
Or shouldn't that fix such kind of issues?

It seems like some kind of race condition, cause it happens so random 
and not on a specific action.

Thanks
Jean-Louis

Op 2018-03-04 20:26, schreef Bart Van Assche:
> On Sun, 2018-03-04 at 20:01 +0100, Jean-Louis Dupond wrote:
>> I'm running indeed CentOS 6 with the Virt SIG kernels. Already updated
>> to 4.9.75, but recently hit the problem again.
>> 
>> The first PID that was in D-state (root     27157  0.0  0.0 127664  
>> 5196
>> ?        D    06:19   0:00  \_ vgdisplay -c --ignorelockingfailure), 
>> had
>> the following stack:
>> # cat /proc/27157/stack
>> [<ffffffff813fc62f>] blk_mq_freeze_queue_wait+0x6f/0xd0
>> [<ffffffff813fe5be>] blk_freeze_queue+0x1e/0x30
>> [<ffffffff813fe5de>] blk_mq_freeze_queue+0xe/0x10
>> [<ffffffff815fa46e>] loop_switch+0x1e/0xd0
>> [<ffffffff815fb2ba>] lo_release+0x7a/0x80
>> [<ffffffff812a75f7>] __blkdev_put+0x1a7/0x200
>> [<ffffffff812a76a6>] blkdev_put+0x56/0x140
>> [<ffffffff812a77b4>] blkdev_close+0x24/0x30
>> [<ffffffff8126b7b8>] __fput+0xc8/0x240
>> [<ffffffff8126b9de>] ____fput+0xe/0x10
>> [<ffffffff810c4ab8>] task_work_run+0x68/0xa0
>> [<ffffffff81003546>] exit_to_usermode_loop+0xc6/0xd0
>> [<ffffffff81003f85>] do_syscall_64+0x185/0x240
>> [<ffffffff818df3aa>] entry_SYSCALL64_slow_path+0x25/0x25
>> [<ffffffffffffffff>] 0xffffffffffffffff
>> 
>> Other procs show the following:
>> # cat /proc/7803/stack
>> [<ffffffff812a782c>] __blkdev_get+0x6c/0x3f0
>> [<ffffffff812a7dfc>] blkdev_get+0x5c/0x1c0
>> [<ffffffff812a8342>] blkdev_open+0x62/0x80
>> [<ffffffff812669aa>] do_dentry_open+0x22a/0x340
>> [<ffffffff81266b11>] vfs_open+0x51/0x80
>> [<ffffffff81279fe5>] do_last+0x435/0x7a0
>> [<ffffffff8127a3d7>] path_openat+0x87/0x1c0
>> [<ffffffff8127a595>] do_filp_open+0x85/0xe0
>> [<ffffffff812681ec>] do_sys_open+0x11c/0x210
>> [<ffffffff8126831e>] SyS_open+0x1e/0x20
>> [<ffffffff81003e7a>] do_syscall_64+0x7a/0x240
>> [<ffffffff818df3aa>] entry_SYSCALL64_slow_path+0x25/0x25
>> [<ffffffffffffffff>] 0xffffffffffffffff
>> 
>> An strace hangs again on loop0 open:
>> stat("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) 
>> =
>> 0
>> open("/dev/loop0", O_RDONLY|O_DIRECT|O_NOATIME
>> 
>> And it seems like indeed alot is hanging on loop0:
>> # cat /sys/block/loop0/mq/0/queued
>> 5957
> 
> Hello Jean-Louis,
> 
> Is the system still in this state? If so, can you provide the output of 
> the
> following command (as an attachment):
> 
> find /sys/kernel/debug/block/ -type f \! \( -name poll_stat -o -name
> dispatched -o -name merged -o -name completed \)
> 
> Thanks,
> 
> Bart.
