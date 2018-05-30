Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937267AbeE3Izr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 May 2018 04:55:47 -0400
Subject: Re: [bug report] IO blocked after offline CPU during fio on nvme SSD
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
References: <2141262833.4696624.1527666518271.JavaMail.zimbra@redhat.com>
 <301499928.4697040.1527666816023.JavaMail.zimbra@redhat.com>
 <CACVXFVMTruqEWuntv=Y9jxh8F=kDcfe-0gJv=e_TYYeNEy1JSQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <a3b6e17b-f0b8-4604-7acf-34870039c5a7@redhat.com>
Date: Wed, 30 May 2018 16:55:41 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVMTruqEWuntv=Y9jxh8F=kDcfe-0gJv=e_TYYeNEy1JSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks for the update, will have a try after Keith update v4 fix. :)


On 05/30/2018 04:29 PM, Ming Lei wrote:
> On Wed, May 30, 2018 at 3:53 PM, Yi Zhang <yi.zhang@redhat.com> wrote:
>> Hi
>> I found this issue during my NVMe test on 4.17.0-rc7, here is the reproducer and dmesg log, let me know if you need more info, thanks.
>>
>> Reproduce steps:
>> #!/bin/bash
>> set -x
>> fio -filename=/dev/nvme0n1p1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -direct=1 -runtime=120 -size=-group_reporting -name=mytest -numjobs=60 &
>> sleep 10
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>> echo 0 > /sys/devices/system/cpu/cpu2/online
>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>
>> dmesg log:
>> [  153.402709] IRQ 82: no longer affine to CPU1
>> [  153.408596] smpboot: CPU 1 is now offline
>> [  153.426422] IRQ 86: no longer affine to CPU2
>> [  153.431204] IRQ 89: no longer affine to CPU2
>> [  153.437054] smpboot: CPU 2 is now offline
>> [  153.682095] IRQ 83: no longer affine to CPU3
>> [  153.686866] IRQ 85: no longer affine to CPU3
>> [  153.692712] smpboot: CPU 3 is now offline
>> [  183.847661] nvme nvme0: I/O 417 QID 2 timeout, completion polled
>> [  183.854410] nvme nvme0: I/O 251 QID 7 timeout, completion polled
>> [  183.861133] nvme nvme0: I/O 252 QID 7 timeout, completion polled
>> [  183.867851] nvme nvme0: I/O 253 QID 7 timeout, aborting
>> [  183.873699] nvme nvme0: I/O 254 QID 7 timeout, aborting
>> [  183.879530] nvme nvme0: Abort status: 0x0
>> [  183.884017] nvme nvme0: I/O 255 QID 7 timeout, aborting
>> [  183.889847] nvme nvme0: Abort status: 0x0
>> [  183.894338] nvme nvme0: I/O 495 QID 8 timeout, completion polled
>> [  183.901033] nvme nvme0: Abort status: 0x0
>> [  183.905520] nvme nvme0: I/O 496 QID 8 timeout, aborting
>> [  183.911359] nvme nvme0: I/O 497 QID 8 timeout, aborting
>> [  183.917190] nvme nvme0: Abort status: 0x0
>> [  183.921677] nvme nvme0: I/O 498 QID 8 timeout, aborting
>> [  183.927506] nvme nvme0: Abort status: 0x0
>> [  183.931994] nvme nvme0: I/O 499 QID 8 timeout, aborting
>> [  183.937825] nvme nvme0: Abort status: 0x0
>> [  183.942311] nvme nvme0: I/O 500 QID 8 timeout, aborting
>> [  183.948141] nvme nvme0: Abort status: 0x0
>> [  183.952637] nvme nvme0: Abort status: 0x0
>> [  214.057408] nvme nvme0: I/O 253 QID 7 timeout, reset controller
>> [  216.422702] nvme nvme0: I/O 254 QID 7 timeout, disable controller
>> [  216.438524] nvme nvme0: I/O 255 QID 7 timeout, disable controller
>> [  216.453428] nvme nvme0: I/O 496 QID 8 timeout, disable controller
>> [  216.469426] nvme nvme0: I/O 497 QID 8 timeout, disable controller
>> [  216.484435] nvme nvme0: I/O 498 QID 8 timeout, disable controller
>> [  216.496417] nvme nvme0: I/O 499 QID 8 timeout, disable controller
>> [  216.511418] nvme nvme0: I/O 500 QID 8 timeout, disable controller
>> [  249.830165] nvme nvme0: I/O 253 QID 7 timeout, completion polled
>> [  249.836901] nvme nvme0: I/O 254 QID 7 timeout, disable controller
>> [  249.858307] nvme nvme0: I/O 255 QID 7 timeout, disable controller
>> [  249.874172] nvme nvme0: I/O 496 QID 8 timeout, disable controller
>> [  249.887164] nvme nvme0: I/O 497 QID 8 timeout, disable controller
>> [  249.903175] nvme nvme0: I/O 498 QID 8 timeout, disable controller
>> [  249.918171] nvme nvme0: I/O 499 QID 8 timeout, disable controller
>> [  249.934172] nvme nvme0: I/O 500 QID 8 timeout, disable controller
>> [  369.695234] INFO: task kworker/u25:8:472 blocked for more than 120 seconds.
>> [  369.703012]       Not tainted 4.17.0-rc7 #1
>> [  369.707687] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  369.716433] kworker/u25:8   D    0   472      2 0x80000000
>> [  369.716443] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>> [  369.716445] Call Trace:
>> [  369.719189]  ? __schedule+0x290/0x870
>> [  369.723280]  schedule+0x32/0x80
>> [  369.726791]  blk_mq_freeze_queue_wait+0x46/0xb0
>> [  369.731853]  ? remove_wait_queue+0x60/0x60
>> [  369.736435]  nvme_wait_freeze+0x2e/0x50 [nvme_core]
>> [  369.741876]  nvme_reset_work+0x819/0xd83 [nvme]
>> [  369.746942]  ? __switch_to+0xa8/0x4f0
>> [  369.751035]  process_one_work+0x158/0x360
>> [  369.755513]  worker_thread+0x47/0x3e0
>> [  369.759604]  kthread+0xf8/0x130
>> [  369.763114]  ? max_active_store+0x80/0x80
>> [  369.767590]  ? kthread_bind+0x10/0x10
>> [  369.771673]  ret_from_fork+0x35/0x40
>> [  369.775687] INFO: task fio:1826 blocked for more than 120 seconds.
>> [  369.782588]       Not tainted 4.17.0-rc7 #1
>> [  369.787259] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  369.796002] fio             D    0  1826      1 0x00000080
>> [  369.796004] Call Trace:
>> [  369.798736]  ? __schedule+0x290/0x870
>> [  369.802826]  schedule+0x32/0x80
>> [  369.806338]  io_schedule+0x12/0x40
>> [  369.810139]  __blkdev_direct_IO_simple+0x1d3/0x310
>> [  369.815493]  ? bdput+0x10/0x10
>> [  369.818905]  blkdev_direct_IO+0x38e/0x3f0
>> [  369.823383]  ? __blkdev_direct_IO_simple+0x254/0x310
>> [  369.828929]  generic_file_direct_write+0xcc/0x170
>> [  369.834187]  __generic_file_write_iter+0xb7/0x1c0
>> [  369.839441]  blkdev_write_iter+0x9b/0x120
>> [  369.843923]  __vfs_write+0x100/0x180
>> [  369.847917]  vfs_write+0xad/0x1a0
>> [  369.851622]  ? __audit_syscall_exit+0x213/0x330
>> [  369.856682]  ksys_pwrite64+0x62/0x90
>> [  369.860677]  do_syscall_64+0x5b/0x180
>> [  369.864769]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  369.870411] RIP: 0033:0x7f42e0955073
>> [  369.874403] RSP: 002b:00007f42ba189b60 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
>> [  369.882856] RAX: ffffffffffffffda RBX: 00007f429c00cd40 RCX: 00007f42e0955073
>> [  369.890823] RDX: 0000000000008c00 RSI: 00007f429c001000 RDI: 000000000000001f
>> [  369.898791] RBP: 00007f42bf195000 R08: 00000000001fc000 R09: 0000000000000007
>> [  369.906757] R10: 0000005bb1581800 R11: 0000000000000293 R12: 0000000000000001
>> [  369.914726] R13: 0000000000008c00 R14: 00007f429c00cd68 R15: 00007f42bf195008
>> [  369.922696] INFO: task fio:1827 blocked for more than 120 seconds.
>> [  369.929597]       Not tainted 4.17.0-rc7 #1
>> [  369.934275] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  369.943018] fio             D    0  1827      1 0x00000080
>> [  369.943020] Call Trace:
>> [  369.945753]  ? __schedule+0x290/0x870
>> [  369.949844]  schedule+0x32/0x80
>> [  369.953355]  blk_queue_enter+0xea/0x1c0
>> [  369.957641]  ? remove_wait_queue+0x60/0x60
>> [  369.962216]  generic_make_request+0x45/0x390
>> [  369.966988]  ? iov_iter_get_pages+0xbe/0x2c0
>> [  369.971759]  ? __schedule+0x298/0x870
>> [  369.975849]  submit_bio+0x6e/0x130
>> [  369.979652]  ? bio_iov_iter_get_pages+0xdd/0x110
>> [  369.984809]  __blkdev_direct_IO_simple+0x183/0x310
>> [  369.990162]  ? bdput+0x10/0x10
>> [  369.993575]  blkdev_direct_IO+0x38e/0x3f0
>> [  369.998054]  ? common_interrupt+0xa/0xf
>> [  370.002340]  generic_file_direct_write+0xcc/0x170
>> [  370.007595]  __generic_file_write_iter+0xb7/0x1c0
>> [  370.012849]  blkdev_write_iter+0x9b/0x120
>> [  370.017330]  __vfs_write+0x100/0x180
>> [  370.021325]  vfs_write+0xad/0x1a0
>> [  370.025029]  ? __audit_syscall_exit+0x213/0x330
>> [  370.030089]  ksys_pwrite64+0x62/0x90
>> [  370.034082]  do_syscall_64+0x5b/0x180
>> [  370.038173]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  370.043816] RIP: 0033:0x7f42e0955073
>> [  370.047806] RSP: 002b:00007f42ba98ab60 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
>> [  370.056260] RAX: ffffffffffffffda RBX: 00007f429400cd40 RCX: 00007f42e0955073
>> [  370.064229] RDX: 0000000000006400 RSI: 00007f4294001000 RDI: 000000000000002c
>> [  370.072197] RBP: 00007f42bf1add40 R08: 0000000003e00000 R09: 0000000000000005
>> [  370.080164] R10: 00000030c362a400 R11: 0000000000000293 R12: 0000000000000001
>> [  370.088132] R13: 0000000000006400 R14: 00007f429400cd68 R15: 00007f42bf1add48
>>
> That is exactly the issue triggered by block/011, and I guess Keith is
> working V4 fix:
>
> http://lists.infradead.org/pipermail/linux-nvme/2018-May/017813.html
>
>
> Thanks,
> Ming Lei
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
