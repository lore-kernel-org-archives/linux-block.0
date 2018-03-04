Return-Path: <linux-block-owner@vger.kernel.org>
Received: from apollo.dupie.be ([62.210.113.39]:53612 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCDTCC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 4 Mar 2018 14:02:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sun, 04 Mar 2018 20:01:58 +0100
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org
Subject: Re: vgdisplay hang on iSCSI session
In-Reply-To: <696a6c0c-2629-6af0-b5c2-fb5ce56d5f2a@wdc.com>
References: <b175d4715df19110064f986599ff87c4@dupond.be>
 <696a6c0c-2629-6af0-b5c2-fb5ce56d5f2a@wdc.com>
Message-ID: <860b5a2a9d02a6a44c24b69c43e81296@dupond.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

Thanks for your answer.
I'm running indeed CentOS 6 with the Virt SIG kernels. Already updated 
to 4.9.75, but recently hit the problem again.

The first PID that was in D-state (root     27157  0.0  0.0 127664  5196 
?        D    06:19   0:00  \_ vgdisplay -c --ignorelockingfailure), had 
the following stack:
# cat /proc/27157/stack
[<ffffffff813fc62f>] blk_mq_freeze_queue_wait+0x6f/0xd0
[<ffffffff813fe5be>] blk_freeze_queue+0x1e/0x30
[<ffffffff813fe5de>] blk_mq_freeze_queue+0xe/0x10
[<ffffffff815fa46e>] loop_switch+0x1e/0xd0
[<ffffffff815fb2ba>] lo_release+0x7a/0x80
[<ffffffff812a75f7>] __blkdev_put+0x1a7/0x200
[<ffffffff812a76a6>] blkdev_put+0x56/0x140
[<ffffffff812a77b4>] blkdev_close+0x24/0x30
[<ffffffff8126b7b8>] __fput+0xc8/0x240
[<ffffffff8126b9de>] ____fput+0xe/0x10
[<ffffffff810c4ab8>] task_work_run+0x68/0xa0
[<ffffffff81003546>] exit_to_usermode_loop+0xc6/0xd0
[<ffffffff81003f85>] do_syscall_64+0x185/0x240
[<ffffffff818df3aa>] entry_SYSCALL64_slow_path+0x25/0x25
[<ffffffffffffffff>] 0xffffffffffffffff

Other procs show the following:
# cat /proc/7803/stack
[<ffffffff812a782c>] __blkdev_get+0x6c/0x3f0
[<ffffffff812a7dfc>] blkdev_get+0x5c/0x1c0
[<ffffffff812a8342>] blkdev_open+0x62/0x80
[<ffffffff812669aa>] do_dentry_open+0x22a/0x340
[<ffffffff81266b11>] vfs_open+0x51/0x80
[<ffffffff81279fe5>] do_last+0x435/0x7a0
[<ffffffff8127a3d7>] path_openat+0x87/0x1c0
[<ffffffff8127a595>] do_filp_open+0x85/0xe0
[<ffffffff812681ec>] do_sys_open+0x11c/0x210
[<ffffffff8126831e>] SyS_open+0x1e/0x20
[<ffffffff81003e7a>] do_syscall_64+0x7a/0x240
[<ffffffff818df3aa>] entry_SYSCALL64_slow_path+0x25/0x25
[<ffffffffffffffff>] 0xffffffffffffffff

An strace hangs again on loop0 open:
stat("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) = 
0
open("/dev/loop0", O_RDONLY|O_DIRECT|O_NOATIME

And it seems like indeed alot is hanging on loop0:
# cat /sys/block/loop0/mq/0/queued
5957

I don't know if this gives you some more idea's where to start looking?
Or should I really try to upgrade this production machine to 4.9.15+ for 
the blk-mq debugging?

Thanks
Jean-Louis

Op 2018-02-12 17:48, schreef Bart Van Assche:
> On 02/05/18 08:01, Jean-Louis Dupond wrote:
>> We've got some "strange" issue on a Xen hypervisor with CentOS 6 and 
>> 4.9.63-29.el6.x86_6 kernel.
> 
> Hello Jean-Louis,
> 
> Since this behavior was observed with a distro kernel I think a
> support request should be submitted to the vendor of that kernel. That
> vendor will be able to tell you whether or not a fix is already
> available for what looks like a hang in the iSCSI initiator. A
> possible alternative is that you install a recent upstream kernel on
> the system (e.g. v4.15.3), reproduce the issue and provide a dump of
> the information under /sys/kernel/debug/block. Recent kernels namely
> make detailed information available under /sys/kernel/debug/block for
> blk-mq drivers about which requests are in progress. That information
> will allow to figure out in which block driver a request got stuck.
> 
> Thanks,
> 
> Bart.
