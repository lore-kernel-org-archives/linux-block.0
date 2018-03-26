Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752537AbeCZVZ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2QLPQIc026011
        for <linux-block@vger.kernel.org>; Mon, 26 Mar 2018 17:25:59 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gy48sk4j5-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 26 Mar 2018 17:25:58 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <joserz@linux.vnet.ibm.com>;
        Mon, 26 Mar 2018 15:25:58 -0600
Date: Mon, 26 Mar 2018 18:25:50 -0300
From: joserz@linux.vnet.ibm.com
To: linux-block@vger.kernel.org
Cc: hch@lst.de
Subject: blk-mq and CPU hotplug error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <20180326212550.GC4100@pacoca>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello everyone!

I'm running Ubuntu 18.04 (4.15.0-12-generic) in KVM/QEMU (powerpc64le).
Everything looks good until I try to hotplug CPUs in my VM. As soon as I
do that I get the following error in my VM dmesg:

[  763.629425] WARNING: CPU: 34 PID: 2276 at /build/linux-zBVy54/linux-4.15.0/block/blk-mq.c:1211 __blk_mq_run_hw_queue+0xf0/0x140
...
[  763.629497] CPU: 34 PID: 2276 Comm: kworker/34:1H Not tainted 4.15.0-12-generic #13-Ubuntu
[  763.629501] Workqueue: kblockd blk_mq_run_work_fn

See that blk-mq complains about CPU 34. This CPU is one of the
hotplugged CPUs.

Looking at mq/0/cpu_list, I see the my new CPUs aren't in that list:

# cat /sys/block/vda/mq/0/cpu_list
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31

But the real problem comes after it, if I try to run any command that
performs intensive IO operations, like:

# dd if=/dev/random of=test.img bs=1M count=100

I start to get errors like:

[  967.661543] INFO: task kworker/u128:3:454 blocked for more than 120 seconds.
[  967.661656]       Tainted: G        W        4.15.0-12-generic #13-Ubuntu
[  967.661705] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  967.661762] kworker/u128:3  D    0   454      2 0x00000800
[  967.661802] Workqueue: writeback wb_workfn (flush-252:0)
[  967.661805] Call Trace:
[  967.661808] [c000000267e5f1d0] [0000002200000000] 0x2200000000 (unreliable)
[  967.661813] [c000000267e5f3a0] [c00000000001c220] __switch_to+0x2a0/0x4d0
[  967.661823] [c000000267e5f400] [c000000000d035e4] __schedule+0x2a4/0xaf0
[  967.661825] [c000000267e5f4d0] [c000000000d03e70] schedule+0x40/0xc0
[  967.661834] [c000000267e5f4f0] [c00000000014f77c] io_schedule+0x2c/0x50
[  967.661838] [c000000267e5f520] [c0000000002d810c] __lock_page+0x14c/0x1c0
[  967.661842] [c000000267e5f5c0] [c0000000004c9288] mpage_prepare_extent_to_map+0x2c8/0x3d0
[  967.661844] [c000000267e5f6c0] [c0000000004d16bc] ext4_writepages+0x49c/0xfd0
[  967.661847] [c000000267e5f870] [c0000000002f1a9c] do_writepages+0x4c/0x130
[  967.661849] [c000000267e5f8e0] [c00000000041a370] __writeback_single_inode+0x70/0x570
[  967.661852] [c000000267e5f940] [c00000000041af0c] writeback_sb_inodes+0x26c/0x5d0
[  967.661854] [c000000267e5fa50] [c00000000041b308] __writeback_inodes_wb+0x98/0x110
[  967.661856] [c000000267e5fab0] [c00000000041b72c] wb_writeback+0x29c/0x460
[  967.661859] [c000000267e5fb80] [c00000000041c38c] wb_workfn+0x1ec/0x600
[  967.661862] [c000000267e5fc90] [c000000000131538] process_one_work+0x298/0x5a0
[  967.661864] [c000000267e5fd20] [c0000000001318d8] worker_thread+0x98/0x630
[  967.661866] [c000000267e5fdc0] [c00000000013a508] kthread+0x1a8/0x1b0
[  967.661869] [c000000267e5fe30] [c00000000000b528] ret_from_kernel_thread+0x5c/0xb4
[  967.661872] INFO: task jbd2/vda2-8:579 blocked for more than 120 seconds.
[  967.661924]       Tainted: G        W        4.15.0-12-generic #13-Ubuntu
[  967.661973] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  967.662035] jbd2/vda2-8     D    0   579      2 0x00000800
[  967.662037] Call Trace:
...snip

Which leads to an unresponsive VM that forces me to reboot it. After
searching the internet I changed the IO scheduler:

# cat /sys/block/vda/queue/scheduler
[none]

# modprobe bfq
# echo bfq > /sys/block/vda/queue/scheduler

# cat /sys/block/vda/queue/scheduler
[bfq] none

which seems to be enough (it still throws that WARNING, but no
hung_task_timeout_secs so far).

Now I'm not sure on how to attack the problem. At first I thought that
CPU hotplug IRQ should also update the cpu_list but now I think that the
problem could be in the queue, maybe it should give up scheduling tasks
on the failing CPU and try another one. What do you people think?

Any suggestion on how to debug it is welcome as well.

Thank you!

Jose R. Ziviani
