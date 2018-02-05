Return-Path: <linux-block-owner@vger.kernel.org>
Received: from apollo.dupie.be ([62.210.113.39]:56288 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752925AbeBEQHN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Feb 2018 11:07:13 -0500
Received: from roundcube.dupie.be (apollo.dupie.be [62.210.113.39])
        by apollo.dupie.be (Postfix) with ESMTPSA id 7607933C01C7
        for <linux-block@vger.kernel.org>; Mon,  5 Feb 2018 17:01:02 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 05 Feb 2018 17:01:02 +0100
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: linux-block@vger.kernel.org
Subject: vgdisplay hang on iSCSI session
Message-ID: <b175d4715df19110064f986599ff87c4@dupond.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi All,

We've got some "strange" issue on a Xen hypervisor with CentOS 6 and 
4.9.63-29.el6.x86_6 kernel.
The system has a local raid + is connected with 2 iscsi sessions to 3 
disks with multipath (6 blockdevs in total).

We've noticed that vgdisplay was hanging, and the kernel was printing 
the following message:
Feb  3 09:43:27 srv01 kernel: [3074775.157416] INFO: task 
vgdisplay:27430 blocked for more than 120 seconds.
Feb  3 09:43:27 srv01 kernel: [3074775.157507]       Not tainted 
4.9.63-29.el6.x86_64 #1
Feb  3 09:43:27 srv01 kernel: [3074775.157541] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb  3 09:43:27 srv01 kernel: [3074775.157591] vgdisplay       D    0 
27430  27429 0x00000080
Feb  3 09:43:27 srv01 kernel: [3074775.157599]  ffff880263017800 
0000000000000000 ffff880244bdc540 ffff88026cd08380
Feb  3 09:43:27 srv01 kernel: [3074775.157613]  ffff88027de59880 
ffffc90063effba8 ffffffff818daab0 ffffc90063effbb8
Feb  3 09:43:27 srv01 kernel: [3074775.157616]  ffffffff81114992 
ffffc90063effba8 ffffffff818def5f ffffc90063effb78
Feb  3 09:43:27 srv01 kernel: [3074775.157620] Call Trace:
Feb  3 09:43:27 srv01 kernel: [3074775.157638]  [<ffffffff818daab0>] ? 
__schedule+0x230/0x530
Feb  3 09:43:27 srv01 kernel: [3074775.157644]  [<ffffffff81114992>] ? 
__call_rcu+0x132/0x220
Feb  3 09:43:27 srv01 kernel: [3074775.157648]  [<ffffffff818def5f>] ? 
_raw_spin_lock_irqsave+0x1f/0x50
Feb  3 09:43:27 srv01 kernel: [3074775.157655]  [<ffffffff818dae9a>] 
schedule+0x3a/0xa0
Feb  3 09:43:27 srv01 kernel: [3074775.157658]  [<ffffffff81114aed>] ? 
call_rcu_sched+0x1d/0x20
Feb  3 09:43:27 srv01 kernel: [3074775.157668]  [<ffffffff813fc89f>] 
blk_mq_freeze_queue_wait+0x6f/0xd0
Feb  3 09:43:27 srv01 kernel: [3074775.157676]  [<ffffffff810ede80>] ? 
woken_wake_function+0x20/0x20
Feb  3 09:43:27 srv01 kernel: [3074775.157679]  [<ffffffff818dec86>] ? 
_raw_spin_unlock_irqrestore+0x16/0x20
Feb  3 09:43:27 srv01 kernel: [3074775.157685]  [<ffffffff8143b053>] ? 
percpu_ref_kill_and_confirm+0x63/0xd0
Feb  3 09:43:27 srv01 kernel: [3074775.157688]  [<ffffffff813fe77c>] ? 
blk_mq_run_hw_queues+0x4c/0x90
Feb  3 09:43:27 srv01 kernel: [3074775.157691]  [<ffffffff813fe82e>] 
blk_freeze_queue+0x1e/0x30
Feb  3 09:43:27 srv01 kernel: [3074775.157694]  [<ffffffff813fe84e>] 
blk_mq_freeze_queue+0xe/0x10
Feb  3 09:43:27 srv01 kernel: [3074775.157700]  [<ffffffff815fa62e>] 
loop_switch+0x1e/0xd0
Feb  3 09:43:27 srv01 kernel: [3074775.157703]  [<ffffffff815fb47a>] 
lo_release+0x7a/0x80
Feb  3 09:43:27 srv01 kernel: [3074775.157712]  [<ffffffff812a7927>] 
__blkdev_put+0x1a7/0x200
Feb  3 09:43:27 srv01 kernel: [3074775.157734]  [<ffffffff8123ddd8>] ? 
cache_free_debugcheck+0x188/0x240
Feb  3 09:43:27 srv01 kernel: [3074775.157738]  [<ffffffff812a79d6>] 
blkdev_put+0x56/0x140
Feb  3 09:43:27 srv01 kernel: [3074775.157742]  [<ffffffff812a7ae4>] 
blkdev_close+0x24/0x30
Feb  3 09:43:27 srv01 kernel: [3074775.157750]  [<ffffffff8126baf8>] 
__fput+0xc8/0x240
Feb  3 09:43:27 srv01 kernel: [3074775.157753]  [<ffffffff8126bd1e>] 
____fput+0xe/0x10
Feb  3 09:43:27 srv01 kernel: [3074775.157760]  [<ffffffff810c5398>] 
task_work_run+0x68/0xa0
Feb  3 09:43:27 srv01 kernel: [3074775.157767]  [<ffffffff81003546>] 
exit_to_usermode_loop+0xc6/0xd0
Feb  3 09:43:27 srv01 kernel: [3074775.157770]  [<ffffffff81003f85>] 
do_syscall_64+0x185/0x240
Feb  3 09:43:27 srv01 kernel: [3074775.157774]  [<ffffffff818df22b>] 
entry_SYSCALL64_slow_path+0x25/0x25


Now if I did an strace -f vgdisplay, it did hang on the following call:
stat("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) = 
0
open("/dev/loop0", O_RDONLY|O_DIRECT|O_NOATIME

And did hang there forever.

multipath -l didn't show any issues on the paths!
But multipath -ll did hang on the following syscall:
close(8)                                = 0
close(9)                                = 0
close(10)                               = 0
fcntl(11, F_GETFL)                      = 0xc000 (flags 
O_RDONLY|O_DIRECT|O_LARGEFILE)
fcntl(11, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
io_destroy(139682352197632

Also I tried to rescan the blockdevs via "echo 1 > 
/sys/block/sdx/device/rescan", and they all worked, except sdf ... 
(which is one of the iscsi blockdevs).
But the VM's using the storage, were still online! So I/O was not dead.

Ofcourse, sdf was the enabled (not active) device member of the 
multipath dev:
size=5.0T features='4 queue_if_no_path pg_init_retries 50 
retain_attached_hw_handle' hwhandler='1 rdac' wp=rw
|-+- policy='round-robin 0' prio=14 status=active
| `- 12:0:0:3 sdg 8:96 active ready running
`-+- policy='round-robin 0' prio=9 status=enabled
   `- 11:0:0:3 sdf 8:80 active ready running


Also I see 1 kworker was in D-state:
root     13820  0.0  0.0      0     0 ?        D    Feb03   0:03  \_ 
[kworker/1:2]

Next to the tons of vgdisplay calls:
root     27430  0.0  0.0 127528  5000 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     28349  0.0  0.0 127528  5152 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     28868  0.0  0.0 127528  5160 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     29398  0.0  0.0 127528  4896 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     29708  0.0  0.0 127528  4960 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     30223  0.0  0.0 127528  5108 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     30529  0.0  0.0 127528  4916 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     30831  0.0  0.0 127528  4988 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure
root     31344  0.0  0.0 127528  4976 ?        D    Feb03   0:00  \_ 
vgdisplay -c --ignorelockingfailure


I already upgraded to 4.9.75-30.el6.x86_64, but its ofcourse essential 
to know what causes this issue.
It was fine for +1 month before this happend by the way!

Any idea's on this?

Thanks
Jean-Louis
