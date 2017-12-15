Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:11942 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbdLOH7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Dec 2017 02:59:11 -0500
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <1513201983.2413.11.camel@sandisk.com>
CC: "mauricfo@linux.vnet.ibm.com" <mauricfo@linux.vnet.ibm.com>,
        "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <ceb3a7fc-83cb-dbc5-4bc6-c8f2c089640f@hisilicon.com>
Date: Fri, 15 Dec 2017 15:58:51 +0800
MIME-Version: 1.0
In-Reply-To: <1513201983.2413.11.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

在 2017/12/14 5:53, Bart Van Assche 写道:
> On Wed, 2017-11-29 at 10:57 +0800, chenxiang (M) wrote:
>> I applied this v2 patchset to kernel 4.15-rc1, running fio on a SATA
>> disk, then disable the disk with sysfs interface
>> (echo 0 > /sys/class/sas_phy/phy-1:0:1/enable), and find system is hung.
>> But with v1 patch, it doesn't has this issue.
> Hello chenxiang,
>
> Would it be possible to repeat your test with v2 of this series and Martin's
> for-4.16 SCSI tree merged into your kernel test tree? Martin's tree is available
> at https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/log/?h=4.16/scsi-queue.
> The following patch in that tree fixes a race condition that sometimes caused
> the SCSI error handler not to be woken up:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=4.16/scsi-queue&id=3bd6f43f5cb3714f70c591514f344389df593501

Hi Bart, sorry to reply this email late, and i just noticed this email 
after John's remind yesterday.
I tested v2 of this series based on Martin's for-4.16 SCSI tree which 
branch error handler issue "scsi: core: Ensure that the
SCSI error handler gets woken up" is merged. And system is still hung 
after repeat my testcase.
Log is as follows:

estuary:/$ fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=re
ad -ioengine=psync -bs=4k -numjobs=64 -runtime=300 -group_reporting 
-name=mytes
t
mytest: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, iodepth=1
...
fio-2.1.11
Starting 64 threads
[   45.794460] random: crng init done
[   54.369720] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=1 
task=ffff8017cf471400 CQ hdr: 0x1103 0x1 0x0 0x0 Error info: 0x0 0x200 
0x0 0x0
[   54.382869] sas: smp_execute_task_sg: task to dev 500e004aaaaaaa1f 
response: 0x0 status 0x2
[   54.391339] sas: broadcast received: 0
[   54.395092] sas: REVALIDATING DOMAIN on port 0, pid:2022
[   54.400879] sas: Expander phy change count has changed
[   54.406191] sas: ex 500e004aaaaaaa1f phy1 originated BROADCAST(CHANGE)
[   54.415052] sas: done REVALIDATING DOMAIN on port 0, pid:2022, res 0x0
[   54.422057] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[   54.427248] sd 0:0:1:0: [sdb] Synchronize Cache(10) failed: Result: 
hostbyte=0x04 driverbyte=0x00
fio: pid=2786, err=5/file:engines[   54.436147] sd 0:0:1:0: [sdb] 
Stopping disk
/sync.c:67, func=xfer, error=Inpu[   54.443187] sd 0:0:1:0: [sdb] 
Start/Stop Unit failed: Result: hostbyte=0x04 driverbyte=0x00
t/output error
fio: pid=2772, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2729, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2727, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2787, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2740, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2775, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2774, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2768, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2754, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2732, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2756, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2738, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
[  249.291697] INFO: task kworker/u128:1:2021 blocked for more than 120 
seconds.(1),R(11),X(1),R(3),X(1),R(1),X(2),R(10),X(2),R(3)] [50.5% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 03m:20s]
[  249.298836]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.304316] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.312138] kworker/u128:1  D    0  2021      2 0x00000020
[  249.317632] Workqueue: HISI0162:01_event_q sas_port_event_worker
[  249.323634] Call trace:
[  249.326077]  __switch_to+0xa0/0xb4
[  249.329475]  __schedule+0x1c4/0x704
[  249.332955]  schedule+0x34/0x94
[  249.336090]  schedule_timeout+0x1b8/0x358
[  249.340092]  wait_for_common+0xfc/0x1b0
[  249.343920]  wait_for_completion+0x14/0x1c
[  249.348011]  flush_workqueue+0xfc/0x424
[  249.351840]  sas_porte_broadcast_rcvd+0x5c/0x68
[  249.356363]  sas_port_event_worker+0x24/0x38
[  249.360626]  process_one_work+0x128/0x2cc
[  249.364627]  worker_thread+0x14c/0x408
[  249.368369]  kthread+0xfc/0x128
[  249.371499]  ret_from_fork+0x10/0x18
[  249.375068] INFO: task kworker/u128:2:2022 blocked for more than 120 
seconds.
[  249.382194]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.387671] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.395492] kworker/u128:2  D    0  2022      2 0x00000020
[  249.400973] Workqueue: HISI0162:01_disco_q sas_revalidate_domain
[  249.406972] Call trace:
[  249.409412]  __switch_to+0xa0/0xb4
[  249.412806]  __schedule+0x1c4/0x704
[  249.416287]  schedule+0x34/0x94
[  249.419422]  blk_mq_freeze_queue_wait+0x4c/0x9c
[  249.423945]  blk_freeze_queue+0x1c/0x28
[  249.427779]  blk_cleanup_queue+0x68/0xf8
[  249.431694]  __scsi_remove_device+0x5c/0x118
[  249.435956]  scsi_remove_device+0x28/0x3c
[  249.439957]  scsi_remove_target+0x194/0x1d0
[  249.444133]  sas_rphy_remove+0x60/0x64
[  249.447875]  sas_rphy_delete+0x14/0x28
[  249.451612]  sas_destruct_devices+0x74/0xa8
[  249.455787]  sas_revalidate_domain+0x58/0xe4
[  249.460049]  process_one_work+0x128/0x2cc
[  249.464051]  worker_thread+0x14c/0x408
[  249.467792]  kthread+0xfc/0x128
[  249.470922]  ret_from_fork+0x10/0x18
[  249.474494] INFO: task fio:2728 blocked for more than 120 seconds.
[  249.480665]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.486140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.493960] fio             D    0  2728   2706 0x00000000
[  249.499439] Call trace:
[  249.501878]  __switch_to+0xa0/0xb4
[  249.505272]  __schedule+0x1c4/0x704
[  249.508753]  schedule+0x34/0x94
[  249.511887]  io_schedule+0x14/0x30
[  249.515280]  __blkdev_direct_IO_simple+0x158/0x290
[  249.520063]  blkdev_direct_IO+0x36c/0x378
[  249.524066]  generic_file_read_iter+0xa0/0x7f4
[  249.528501]  blkdev_read_iter+0x44/0x54
[  249.532331]  __vfs_read+0xc8/0x11c
[  249.535725]  vfs_read+0x80/0x134
[  249.538941]  SyS_pread64+0x74/0x8c
[  249.542335]  el0_svc_naked+0x20/0x24
[  249.545902] INFO: task fio:2730 blocked for more than 120 seconds.
[  249.552074]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.557551] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.565372] fio             D    0  2730   2706 0x00000000
[  249.570851] Call trace:
[  249.573291]  __switch_to+0xa0/0xb4
[  249.576684]  __schedule+0x1c4/0x704
[  249.580165]  schedule+0x34/0x94
[  249.583295]  io_schedule+0x14/0x30
[  249.586689]  __blkdev_direct_IO_simple+0x158/0x290
[  249.591471]  blkdev_direct_IO+0x36c/0x378
[  249.595473]  generic_file_read_iter+0xa0/0x7f4
[  249.599909]  blkdev_read_iter+0x44/0x54
[  249.603737]  __vfs_read+0xc8/0x11c
[  249.607127]  vfs_read+0x80/0x134
[  249.610347]  SyS_pread64+0x74/0x8c
[  249.613741]  el0_svc_naked+0x20/0x24
[  249.617308] INFO: task fio:2731 blocked for more than 120 seconds.
[  249.623479]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.628955] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.636775] fio             D    0  2731   2706 0x00000000
[  249.642253] Call trace:
[  249.644692]  __switch_to+0xa0/0xb4
[  249.648086]  __schedule+0x1c4/0x704
[  249.651562]  schedule+0x34/0x94
[  249.654695]  io_schedule+0x14/0x30
[  249.658090]  __blkdev_direct_IO_simple+0x158/0x290
[  249.662872]  blkdev_direct_IO+0x36c/0x378
[  249.666874]  generic_file_read_iter+0xa0/0x7f4
[  249.671310]  blkdev_read_iter+0x44/0x54
[  249.675139]  __vfs_read+0xc8/0x11c
[  249.678534]  vfs_read+0x80/0x134
[  249.681755]  SyS_pread64+0x74/0x8c
[  249.685149]  el0_svc_naked+0x20/0x24
[  249.688716] INFO: task fio:2733 blocked for more than 120 seconds.
[  249.694887]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.700363] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.708184] fio             D    0  2733   2706 0x00000000
[  249.713662] Call trace:
[  249.716101]  __switch_to+0xa0/0xb4
[  249.719491]  __schedule+0x1c4/0x704
[  249.722971]  schedule+0x34/0x94
[  249.726105]  io_schedule+0x14/0x30
[  249.729498]  __blkdev_direct_IO_simple+0x158/0x290
[  249.734281]  blkdev_direct_IO+0x36c/0x378
[  249.738282]  generic_file_read_iter+0xa0/0x7f4
[  249.742718]  blkdev_read_iter+0x44/0x54
[  249.746546]  __vfs_read+0xc8/0x11c
[  249.749940]  vfs_read+0x80/0x134
[  249.753161]  SyS_pread64+0x74/0x8c
[  249.756555]  el0_svc_naked+0x20/0x24
[  249.760123] INFO: task fio:2734 blocked for more than 120 seconds.
[  249.766293]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.771769] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.779590] fio             D    0  2734   2706 0x00000000
[  249.785070] Call trace:
[  249.787506]  __switch_to+0xa0/0xb4
[  249.790899]  __schedule+0x1c4/0x704
[  249.794380]  schedule+0x34/0x94
[  249.797513]  io_schedule+0x14/0x30
Jobs: 51 (f=51): [X(1),R(1),X(1),[  249.800909] 
__blkdev_direct_IO_simple+0x158/0x290
R(2),X(1),R(5),X(1),R(1),X(1),R(1[  249.808552] blkdev_direct_IO+0x36c/0x378
3),X(1),R(1),X(1),R(11),X(1),R(3[  249.815409] 
generic_file_read_iter+0xa0/0x7f4
),X(1),R(1),X(2),R(10),X(2),R(3)[  249.822615] blkdev_read_iter+0x44/0x54
] [50.7% done] [0KB/0KB/0KB /s] [  249.829213] __vfs_read+0xc8/0x11c
[  249.835377]  vfs_read+0x80/0x134
[  249.840933]  SyS_pread64+0x74/0x8c
[  249.844327]  el0_svc_naked+0x20/0x24
[  249.847894] INFO: task fio:2735 blocked for more than 120 seconds.
[  249.854065]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.859541] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.867361] fio             D    0  2735   2706 0x00000000
[  249.872839] Call trace:
[  249.875275]  __switch_to+0xa0/0xb4
[  249.878670]  __schedule+0x1c4/0x704
[  249.882150]  schedule+0x34/0x94
[  249.885283]  io_schedule+0x14/0x30
[  249.888678]  __blkdev_direct_IO_simple+0x158/0x290
[  249.893460]  blkdev_direct_IO+0x36c/0x378
[  249.897462]  generic_file_read_iter+0xa0/0x7f4
[  249.901898]  blkdev_read_iter+0x44/0x54
[  249.905726]  __vfs_read+0xc8/0x11c
[  249.909119]  vfs_read+0x80/0x134
[  249.912339]  SyS_pread64+0x74/0x8c
[  249.915733]  el0_svc_naked+0x20/0x24
[  249.919297] INFO: task fio:2736 blocked for more than 120 seconds.
[  249.925468]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  249.930944] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.938764] fio             D    0  2736   2706 0x00000000
[  249.944242] Call trace:
[  249.946677]  __switch_to+0xa0/0xb4
[  249.950071]  __schedule+0x1c4/0x704
[  249.953551]  schedule+0x34/0x94
[  249.956684]  io_schedule+0x14/0x30
[  249.960078]  __blkdev_direct_IO_simple+0x158/0x290
[  249.964861]  blkdev_direct_IO+0x36c/0x378
[  249.968863]  generic_file_read_iter+0xa0/0x7f4
[  249.973298]  blkdev_read_iter+0x44/0x54
[  249.977127]  __vfs_read+0xc8/0x11c
[  249.980521]  vfs_read+0x80/0x134
[  249.983741]  SyS_pread64+0x74/0x8c
[  249.987131]  el0_svc_naked+0x20/0x24
[  249.990698] INFO: task fio:2737 blocked for more than 120 seconds.
[  249.996869]       Not tainted 4.15.0-rc1-00045-ga9c054d #1
[  250.002345] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  250.010165] fio             D    0  2737   2706 0x00000000
[  250.015643] Call trace:
[  250.018078]  __switch_to+0xa0/0xb4
[  250.021472]  __schedule+0x1c4/0x704
[  250.024952]  schedule+0x34/0x94
[  250.028086]  io_schedule+0x14/0x30
[  250.031476]  __blkdev_direct_IO_simple+0x158/0x290
[  250.036258]  blkdev_direct_IO+0x36c/0x378
[  250.040260]  generic_file_read_iter+0xa0/0x7f4
[  250.044696]  blkdev_read_iter+0x44/0x54
[  250.048523]  __vfs_read+0xc8/0x11c
[  250.051917]  vfs_read+0x80/0x134
[  250.055133]  SyS_pread64+0x74/0x8c
[  250.058526]  el0_svc_naked+0x20/0x24
[  318.975633] WARNING: CPU: 9 PID: 0 at kernel/rcu/tree.c:2792 
rcu_process_callbacks+0x3e4/0x3f43),X(1),R(1),X(2),R(10),X(2),R(3)] 
[67.8% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta 02m:10s]
[  318.984231] Modules linked in:
[  318.987276] CPU: 9 PID: 0 Comm: swapper/9 Not tainted 
4.15.0-rc1-00045-ga9c054d #1
[  318.994831] Hardware name: Huawei D05/D05, BIOS Hisilicon D05 IT17 
Nemo 2.0 RC0 11/29/2017
[  319.003080] task: ffff8017d63c4880 task.stack: ffff0000097a0000
[  319.008986] pstate: 20000085 (nzCv daIf -PAN -UAO)
[  319.013764] pc : rcu_process_callbacks+0x3e4/0x3f4
[  319.018543] lr : rcu_process_callbacks+0x204/0x3f4
[  319.023319] sp : ffff00000804be30
[  319.026621] x29: ffff00000804be30 x28: 0000000000000000
[  319.031922] x27: 0000000000000784 x26: ffff00000804be90
[  319.037222] x25: ffff8017fbf642b8 x24: ffff000009233000
[  319.042523] x23: ffff0000090919c0 x22: ffff00000920bd20
[  319.047822] x21: ffff000009252000 x20: ffff00000924ef80
[  319.053122] x19: ffff8017fbf64280 x18: 0000000000000007
[  319.058422] x17: 000000000000000e x16: 0000000000000001
[  319.063722] x15: 0000000000000019 x14: 0000000000000033
[  319.069022] x13: 000000000000004c x12: 0000000000000068
[  319.074322] x11: 0000000000000000 x10: 0000000000000a80
[  319.079622] x9 : 0000000000005e79 x8 : 0000000044042000
[  319.084921] x7 : 0000000000210d00 x6 : 0000000000000000
[  319.090221] x5 : 0000000000000029 x4 : 0000000000000004
[  319.095520] x3 : 0000000000000000 x2 : 0000000000002710
[  319.100820] x1 : 0000000000000001 x0 : 0000000000000000
[  319.106120] Call trace:
[  319.108555]  rcu_process_callbacks+0x3e4/0x3f4
[  319.112987]  __do_softirq+0x10c/0x208
[  319.116638]  irq_exit+0xa8/0xb4
[  319.119767]  __handle_domain_irq+0x8c/0xf0
[  319.123849]  gic_handle_irq+0xd4/0x184
[  319.127585]  el1_irq+0xb0/0x128
[  319.130714]  arch_cpu_idle+0x14/0x20
[  319.134280]  default_idle_call+0x18/0x2c
[  319.138190]  do_idle+0x168/0x1d0
[  319.141406]  cpu_startup_entry+0x1c/0x24
[  319.145316]  secondary_start_kernel+0x11c/0x128
[  319.149832] ---[ end trace 2158876af600f163 ]---
>
> Thanks,
>
> Bart.
