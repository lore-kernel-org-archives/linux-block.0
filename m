Return-Path: <SRS0=Aqm6=3J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5683C2D0DB
	for <linux-block@archiver.kernel.org>; Mon, 20 Jan 2020 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C28821835
	for <linux-block@archiver.kernel.org>; Mon, 20 Jan 2020 13:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATNXk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:23:40 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgATNXj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 08:23:39 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C3E00B05742047101E33;
        Mon, 20 Jan 2020 13:23:36 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 20 Jan 2020 13:23:36 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 13:23:36 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
Message-ID: <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
Date:   Mon, 20 Jan 2020 13:23:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/01/2020 17:00, John Garry wrote:
> On 15/01/2020 11:44, Ming Lei wrote:
>> Hi,
>>
>> Thomas mentioned:
>>      "
>>       That was the constraint of managed interrupts from the very 
>> beginning:
>>        The driver/subsystem has to quiesce the interrupt line and the 
>> associated
>>        queue _before_ it gets shutdown in CPU unplug and not fiddle 
>> with it
>>        until it's restarted by the core when the CPU is plugged in again.
>>      "
>>
>> But no drivers or blk-mq do that before one hctx becomes inactive(all
>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>
>> This patchset tries to address the issue by two stages:
>>
>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>
>> - mark the hctx as internal stopped, and drain all in-flight requests
>> if the hctx is going to be dead.
>>
>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx 
>> becomes dead
>>
>> - steal bios from the request, and resubmit them via 
>> generic_make_request(),
>> then these IO will be mapped to other live hctx for dispatch
>>
>> Please comment & review, thanks!
>>
>> V5:
>>     - rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
>>     - re-factor code for re-submit requests in cpu dead hotplug handler
>>     - address requeue corner case
>>
>> V4:
>>     - resubmit IOs in dispatch list in case that this hctx is dead
>>
>> V3:
>>     - re-organize patch 2 & 3 a bit for addressing Hannes's comment
>>     - fix patch 4 for avoiding potential deadlock, as found by Hannes
>>
>> V2:
>>     - patch4 & patch 5 in V1 have been merged to block tree, so remove
>>       them
>>     - address comments from John Garry and Minwoo
>>
>>

Hi Ming,

Colleague Xiang Chen found this:

Starting 40 processes
Jobs: 40 (f=40)
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [8.3% done] 
[2899MB/0KB/0KB /s] [742K/0/0 iops] [eta 00m:33s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [11.1% done] 
[2892MB/0KB/0KB /s] [740K/0/0 iops] [eta 00m:32s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [13.9% done] 
[2887MB/0KB/0KB /s] [739K/0/0 iops] [eta 00m:31s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [16.7% done] 
[2850MB/0KB/0KB /s] [730K/0/0 iops] [eta 00m:30s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [19.4% done] 
[2834MB/0KB/0KB /s] [726K/0/0 iops] [eta 00m:29s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [22.2% done] 
[2827MB/0KB/0KB /s] [724K/0/0 iops] [eta 00m:28s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [25.0% done] 
[2804MB/0KB/0KB /s] [718K/0/0 iops] [eta 00m:27s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [27.8% done] 
[2783MB/0KB/0KB /s] [713K/0/0 iops] [eta 00m:26s]
[  112.990292] CPU16: shutdown
[  112.993113] psci: CPU16 killed (polled 0 ms)
[  113.029429] CPU15: shutdown
[  113.032245] psci: CPU15 killed (polled 0 ms)
[  113.073649] CPU14: shutdown
[  113.076461] psci: CPU14 killed (polled 0 ms)
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR[  113.121258] CPU13: 
shutdown
RRRRRRRRRR] [30.[  113.124247] psci: CPU13 killed (polled 0 ms)
6% done] [2772MB/0KB/0KB /s] [710K/0/0 iops] [eta 00m:25s]
[  113.177108] IRQ 600: no longer affine to CPU12
[  113.183185] CPU12: shutdown
[  113.186001] psci: CPU12 killed (polled 0 ms)
[  113.242555] CPU11: shutdown
[  113.245368] psci: CPU11 killed (polled 0 ms)
[  113.302598] CPU10: shutdown
[  113.305420] psci: CPU10 killed (polled 0 ms)
[  113.365757] CPU9: shutdown
[  113.368489] psci: CPU9 killed (polled 0 ms)
[  113.611904] IRQ 599: no longer affine to CPU8
[  113.620611] CPU8: shutdown
[  113.623340] psci: CPU8 killed (polled 0 ms)
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [33.3% done] 
[2765MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:24s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [36.1% done] 
[2767MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:23s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [38.9% done] 
[2771MB/0KB/0KB /s] [709K/0/0 iops] [eta 00m:22s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [41.7% done] 
[2780MB/0KB/0KB /s] [712K/0/0 iops] [eta 00m:21s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [44.4% done] 
[2731MB/0KB/0KB /s] [699K/0/0 iops] [eta 00m:20s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [47.2% done] 
[2757MB/0KB/0KB /s] [706K/0/0 iops] [eta 00m:19s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [50.0% done] 
[2764MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:18s]
[  120.762141] ------------[ cut here ]------------
[  120.766760] WARNING: CPU: 0 PID: 10 at block/blk.h:299 
generic_make_request_checks+0x480/0x4e8
[  120.775348] Modules linked in:
[  120.778397] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.5.0-

Then this:

1158048319d:18h:40m:34s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049605d:23h:03m:30s]
[  141.915198] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  141.921280] rcu: 	96-...0: (4 GPs behind) idle=af6/0/0x1 
softirq=90/90 fqs=2626
[  141.928658] rcu: 	99-...0: (2 GPs behind) 
idle=b82/1/0x4000000000000000 softirq=82/82 fqs=2627
[  141.937339] 	(detected by 17, t=5254 jiffies, g=3925, q=545)
[  141.942985] Task dump for CPU 96:
[  141.946292] swapper/96      R  running task        0     0      1 
0x0000002a
[  141.953321] Call trace:
[  141.955763]  __switch_to+0xbc/0x218
[  141.959244]  0x0
[  141.961079] Task dump for CPU 99:
[  141.964385] kworker/99:1H   R  running task        0  3473      2 
0x0000022a
[  141.971417] Workqueue: kblockd blk_mq_run_work_fn
[  141.976109] Call trace:
[  141.978550]  __switch_to+0xbc/0x218
[  141.982029]  blk_mq_run_work_fn+0x1c/0x28
[  141.986027]  process_one_work+0x1e0/0x358
[  141.990025]  worker_thread+0x40/0x488
[  141.993678]  kthread+0x118/0x120
[  141.996897]  ret_from_fork+0x10/0x18


Fuller log at bottom.

We're basing the patchset on v5.5-rc6:
https://github.com/hisilicon/kernel-dev/tree/private-topic-sas-5.5-mq-debug-improve-cpu-hotplug-v5 
(we have not tested my latest patch there, but I doubt that this is the 
problem).

Not sure if something missing which is in -next.

Cheers,
John



  uptime:	0 days, 0 hours
Usage on /:	8%		Swap usage:	0.0%
IP Addresses:	192.168.1.164

Euler:~ # export TMOUT=0
Euler:~ # fdisk -l | grep sd | wc -l
7
Euler:~ # ps -aux | grep irqbalance
root       3307  0.0  0.0 106076  1796 ttyS0    S+   05:58   0:00 grep 
--color=auto irqbalance
Euler:~ # echo 15 > /proc/sys/kernel/printk
Euler:~ #
Euler:~ #
Euler:~ # ./hotplug_sas_d06.sh
Looping ... number 0
Creat 4k_read_depth2048_fiotest file sucessfully
cp: cannot stat â€˜liba*â€™: No such file or directory
chmod: cannot access â€˜fioâ€™: No such file or directory
job1: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=2048
...
job1: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=2048
...
job1: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=2048
...
job1: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=2048
...
fio-2.1.10
Starting 40 processes
Jobs: 40 (f=40)
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [8.3% done] 
[2899MB/0KB/0KB /s] [742K/0/0 iops] [eta 00m:33s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [11.1% done] 
[2892MB/0KB/0KB /s] [740K/0/0 iops] [eta 00m:32s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [13.9% done] 
[2887MB/0KB/0KB /s] [739K/0/0 iops] [eta 00m:31s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [16.7% done] 
[2850MB/0KB/0KB /s] [730K/0/0 iops] [eta 00m:30s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [19.4% done] 
[2834MB/0KB/0KB /s] [726K/0/0 iops] [eta 00m:29s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [22.2% done] 
[2827MB/0KB/0KB /s] [724K/0/0 iops] [eta 00m:28s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [25.0% done] 
[2804MB/0KB/0KB /s] [718K/0/0 iops] [eta 00m:27s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [27.8% done] 
[2783MB/0KB/0KB /s] [713K/0/0 iops] [eta 00m:26s]
[  112.990292] CPU16: shutdown
[  112.993113] psci: CPU16 killed (polled 0 ms)
[  113.029429] CPU15: shutdown
[  113.032245] psci: CPU15 killed (polled 0 ms)
[  113.073649] CPU14: shutdown
[  113.076461] psci: CPU14 killed (polled 0 ms)
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR[  113.121258] CPU13: 
shutdown
RRRRRRRRRR] [30.[  113.124247] psci: CPU13 killed (polled 0 ms)
6% done] [2772MB/0KB/0KB /s] [710K/0/0 iops] [eta 00m:25s]
[  113.177108] IRQ 600: no longer affine to CPU12
[  113.183185] CPU12: shutdown
[  113.186001] psci: CPU12 killed (polled 0 ms)
[  113.242555] CPU11: shutdown
[  113.245368] psci: CPU11 killed (polled 0 ms)
[  113.302598] CPU10: shutdown
[  113.305420] psci: CPU10 killed (polled 0 ms)
[  113.365757] CPU9: shutdown
[  113.368489] psci: CPU9 killed (polled 0 ms)
[  113.611904] IRQ 599: no longer affine to CPU8
[  113.620611] CPU8: shutdown
[  113.623340] psci: CPU8 killed (polled 0 ms)
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [33.3% done] 
[2765MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:24s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [36.1% done] 
[2767MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:23s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [38.9% done] 
[2771MB/0KB/0KB /s] [709K/0/0 iops] [eta 00m:22s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [41.7% done] 
[2780MB/0KB/0KB /s] [712K/0/0 iops] [eta 00m:21s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [44.4% done] 
[2731MB/0KB/0KB /s] [699K/0/0 iops] [eta 00m:20s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [47.2% done] 
[2757MB/0KB/0KB /s] [706K/0/0 iops] [eta 00m:19s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [50.0% done] 
[2764MB/0KB/0KB /s] [708K/0/0 iops] [eta 00m:18s]
[  120.762141] ------------[ cut here ]------------
[  120.766760] WARNING: CPU: 0 PID: 10 at block/blk.h:299 
generic_make_request_checks+0x480/0x4e8
[  120.775348] Modules linked in:
[  120.778397] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 
5.5.0-rc6-31756-gdddc331 #333
[  120.786282] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V3.B160.02 01/15/2020
[  120.795129] pstate: 80c00089 (Nzcv daIf +PAN +UAO)
[  120.799907] pc : generic_make_request_checks+0x480/0x4e8
[  120.805205] lr : generic_make_request_checks+0x48/0x4e8
[  120.810415] sp : ffff80001052b700
[  120.813720] x29: ffff80001052b700 x28: 0000000000000dd0
[  120.819017] x27: ffff00277b6c0d00 x26: ffff00277863ea18
[  120.824313] x25: 0000000000000000 x24: ffff00277b6c0d6c
[  120.829612] x23: 0000000000000008 x22: ffff0027d66c7800
[  120.834909] x21: ffff2027c7133790 x20: ffffc8fcee7c9000
[  120.840205] x19: ffff00277863ea18 x18: 000000000000000e
[  120.845502] x17: 0000000000000007 x16: 0000000000000001
[  120.850801] x15: 0000000000000019 x14: 0000000000000033
[  120.856098] x13: 0000000000000001 x12: 00000000015cd30a
[  120.861394] x11: 0000000000000001 x10: 0000000000000040
[  120.866692] x9 : ffffc8fcee7df550 x8 : ffffc8fcee3fb018
[  120.871990] x7 : ffff0027d2010010 x6 : 00000006711b402b
[  120.877287] x5 : 00000000000000c0 x4 : 0000000000000006
[  120.882585] x3 : ffffffffffffffff x2 : 00000000ffffffff
[  120.887882] x1 : 0000000000000080 x0 : 0000000000000080
[  120.893181] Call trace:
[  120.895621]  generic_make_request_checks+0x480/0x4e8
[  120.900571]  generic_make_request+0x2c/0x320
[  120.904832]  blk_mq_hctx_deactivate+0x1a0/0x2e8
[  120.909352]  __blk_mq_delay_run_hw_queue+0x220/0x230
[  120.914303]  blk_mq_run_hw_queue+0xa0/0x110
[  120.918475]  blk_mq_run_hw_queues+0x48/0x70
[  120.922649]  scsi_end_request+0x1d8/0x230
[  120.926648]  scsi_io_completion+0x70/0x520
[  120.930735]  scsi_finish_command+0xe0/0xf0
[  120.934822]  scsi_softirq_done+0x80/0x190
[  120.938821]  blk_mq_complete_request+0xc4/0x160
[  120.943339]  scsi_mq_done+0x70/0xc8
[  120.946821]  ata_scsi_qc_complete+0xa0/0x3f0
[  120.951081]  __ata_qc_complete+0xa4/0x150
[  120.955079]  ata_qc_complete+0xe8/0x200
[  120.958906]  sas_ata_task_done+0x194/0x2d0
[  120.962992]  cq_tasklet_v3_hw+0x12c/0x5e8
[  120.966991]  tasklet_action_common.isra.15+0x11c/0x190
[  120.972115]  tasklet_action+0x24/0x30
[  120.975767]  efi_header_end+0x114/0x234
[  120.979592]  run_ksoftirqd+0x38/0x48
[  120.983159]  smpboot_thread_fn+0x16c/0x270
[  120.987245]  kthread+0x118/0x120
[  120.990465]  ret_from_fork+0x10/0x18
[  120.994031] ---[ end trace 0125724e2f3f2476 ]---
[  120.998643] ------------[ cut here ]------------
[  121.003250] WARNING: CPU: 0 PID: 10 at block/blk-mq.c:1365 
__blk_mq_run_hw_queue+0xdc/0x128
[  121.011576] Modules linked in:
[  121.014623] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W 
    5.5.0-rc6-31756-gdddc331 #333
[  121.023902] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V3.B160.02 01/15/2020
[  121.032749] pstate: 00c00089 (nzcv daIf +PAN +UAO)
[  121.037526] pc : __blk_mq_run_hw_queue+0xdc/0x128
[  121.042217] lr : __blk_mq_delay_run_hw_queue+0x1ac/0x230
[  121.047515] sp : ffff80001052b540
[  121.050820] x29: ffff80001052b540 x28: 0000000000000dd0
[  121.056118] x27: ffff00277b6c0d00 x26: ffff00277863ea18
[  121.061416] x25: 000000000000000c x24: 000000000000000a
[  121.066714] x23: 0000000000000001 x22: 0000000000000000
[  121.072012] x21: ffffc8fcee7c9000 x20: 0000000000000000
[  121.077310] x19: ffff0027cb7f8000 x18: 000000000000000e
[  121.082608] x17: 0000000000000007 x16: 0000000000000001
[  121.087905] x15: 0000000000000019 x14: 0000000000000033
[  121.093203] x13: 0000000000000001 x12: 00000000015cd30a
[  121.098501] x11: 0000000000000001 x10: 0000000000000040
[  121.103799] x9 : 00000000ffff4840 x8 : ffffc8fcee3fb018
[  121.109097] x7 : ffffc8fcee7c98e8 x6 : 0000000000000000
[  121.114395] x5 : ffffc8fcee7c98c8 x4 : 0000000000000000
[  121.119692] x3 : 0000000000000000 x2 : ffffc8fcee7c98c8
[  121.124990] x1 : 00000000000000ff x0 : 0000000000000103
[  121.130288] Call trace:
[  121.132729]  __blk_mq_run_hw_queue+0xdc/0x128
[  121.137073]  __blk_mq_delay_run_hw_queue+0x1ac/0x230
[  121.142025]  blk_mq_run_hw_queue+0xa0/0x110
[  121.146196]  blk_mq_request_bypass_insert+0x54/0x68
[  121.151060]  __blk_mq_try_issue_directly+0x60/0x208
[  121.155926]  blk_mq_try_issue_directly+0x50/0xb8
[  121.160529]  blk_mq_make_request+0x3d0/0x420
[  121.164787]  generic_make_request+0xf4/0x320
[  121.169046]  blk_mq_hctx_deactivate+0x1a0/0x2e8
[  121.173566]  __blk_mq_delay_run_hw_queue+0x220/0x230
[  121.178517]  blk_mq_run_hw_queue+0xa0/0x110
[  121.182688]  blk_mq_run_hw_queues+0x48/0x70
[  121.186860]  scsi_end_request+0x1d8/0x230
[  121.190858]  scsi_io_completion+0x70/0x520
[  121.194944]  scsi_finish_command+0xe0/0xf0
[  121.199029]  scsi_softirq_done+0x80/0x190
[  121.203027]  blk_mq_complete_request+0xc4/0x160
[  121.207545]  scsi_mq_done+0x70/0xc8
[  121.211024]  ata_scsi_qc_complete+0xa0/0x3f0
[  121.215283]  __ata_qc_complete+0xa4/0x150
[  121.219281]  ata_qc_complete+0xe8/0x200
[  121.223106]  sas_ata_task_done+0x194/0x2d0
[  121.227191]  cq_tasklet_v3_hw+0x12c/0x5e8
[  121.231190]  tasklet_action_common.isra.15+0x11c/0x190
[  121.236312]  tasklet_action+0x24/0x30
[  121.239965]  efi_header_end+0x114/0x234
[  121.243790]  run_ksoftirqd+0x38/0x48
[  121.247356]  smpboot_thread_fn+0x16c/0x270
[  121.251441]  kthread+0x118/0x120
[  121.254661]  ret_from_fork+0x10/0x18
[  121.258226] ---[ end trace 0125724e2f3f2477 ]---
[  121.267999] BUG: scheduling while atomic: ksoftirqd/0/10/0x00000103
[  121.274248] Modules linked in:
[  121.277295] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W 
    5.5.0-rc6-31756-gdddc331 #333
[  121.286574] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V3.B160.02 01/15/2020
[  121.295420] Call trace:
[  121.297861]  dump_backtrace+0x0/0x1a0
[  121.301513]  show_stack+0x14/0x20
[  121.304822]  dump_stack+0xbc/0x104
[  121.308216]  __schedule_bug+0x50/0x70
[  121.311869]  __schedule+0x534/0x598
[  121.315349]  schedule+0x74/0x100
[  121.318569]  io_schedule+0x18/0x98
[  121.321963]  blk_mq_get_tag+0x150/0x300
[  121.325789]  blk_mq_get_request+0x120/0x3a8
[  121.329961]  blk_mq_make_request+0xf8/0x420
[  121.334134]  generic_make_request+0xf4/0x320
[  121.338392]  blk_mq_hctx_deactivate+0x1a0/0x2e8
[  121.342910]  __blk_mq_delay_run_hw_queue+0x220/0x230
[  121.347861]  blk_mq_run_hw_queue+0xa0/0x110
[  121.352034]  blk_mq_run_hw_queues+0x48/0x70
[  121.356205]  scsi_end_request+0x1d8/0x230
[  121.360204]  scsi_io_completion+0x70/0x520
[  121.364289]  scsi_finish_command+0xe0/0xf0
[  121.368373]  scsi_softirq_done+0x80/0x190
[  121.372372]  blk_mq_complete_request+0xc4/0x160
[  121.376891]  scsi_mq_done+0x70/0xc8
[  121.380371]  ata_scsi_qc_complete+0xa0/0x3f0
[  121.384629]  __ata_qc_complete+0xa4/0x150
[  121.388629]  ata_qc_complete+0xe8/0x200
[  121.392453]  sas_ata_task_done+0x194/0x2d0
[  121.396540]  cq_tasklet_v3_hw+0x12c/0x5e8
[  121.400540]  tasklet_action_common.isra.15+0x11c/0x190
[  121.405664]  tasklet_action+0x24/0x30
[  121.409316]  efi_header_end+0x114/0x234
[  121.413141]  run_ksoftirqd+0x38/0x48
[  121.416706]  smpboot_thread_fn+0x16c/0x270
[  121.420792]  kthread+0x118/0x120
[  121.424013]  ret_from_fork+0x10/0x18
Jobs: 40 (f=40):[  121.427627] NOHZ: local_softirq_pending 2c2
  [RRRRRRRRRRRRRR[  121.433311] NOHZ: local_softirq_pending 40
RRRRRRRRRRRRRRRR[  121.438658] NOHZ: local_softirq_pending 40
RRRRRRRRRR] [52.[  121.444103] NOHZ: local_softirq_pending 40
8% done] [1676MB[  121.449564] NOHZ: local_softirq_pending 40
/0KB/0KB /s] [42[  121.455028] NOHZ: local_softirq_pending 40
9K/0/0 iops] [et[  121.460491] NOHZ: local_softirq_pending 40
a 00m:17s]
[  121.465948] NOHZ: local_softirq_pending 40
[  121.470963] NOHZ: local_softirq_pending 40
[  121.475055] NOHZ: local_softirq_pending 40
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [55.6% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:16s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [58.3% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:15s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [61.1% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:14s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [63.9% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:13s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [66.7% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:12s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [69.4% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:11s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [72.2% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:10s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [75.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:09s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [77.8% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:08s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [80.6% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:07s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [83.3% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:06s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [86.1% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:05s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [88.9% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:04s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [91.7% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:03s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [94.4% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:02s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [97.2% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:01s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [100.0% 
done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta 00m:00s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047033d:14h:17m:38s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048319d:18h:40m:34s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049605d:23h:03m:30s]
[  141.915198] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  141.921280] rcu: 	96-...0: (4 GPs behind) idle=af6/0/0x1 
softirq=90/90 fqs=2626
[  141.928658] rcu: 	99-...0: (2 GPs behind) 
idle=b82/1/0x4000000000000000 softirq=82/82 fqs=2627
[  141.937339] 	(detected by 17, t=5254 jiffies, g=3925, q=545)
[  141.942985] Task dump for CPU 96:
[  141.946292] swapper/96      R  running task        0     0      1 
0x0000002a
[  141.953321] Call trace:
[  141.955763]  __switch_to+0xbc/0x218
[  141.959244]  0x0
[  141.961079] Task dump for CPU 99:
[  141.964385] kworker/99:1H   R  running task        0  3473      2 
0x0000022a
[  141.971417] Workqueue: kblockd blk_mq_run_work_fn
[  141.976109] Call trace:
[  141.978550]  __switch_to+0xbc/0x218
[  141.982029]  blk_mq_run_work_fn+0x1c/0x28
[  141.986027]  process_one_work+0x1e0/0x358
[  141.990025]  worker_thread+0x40/0x488
[  141.993678]  kthread+0x118/0x120
[  141.996897]  ret_from_fork+0x10/0x18
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158042478d:14h:26m:49s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158043549d:01h:15m:55s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158044619d:12h:05m:01s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158045689d:22h:54m:06s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158046760d:09h:43m:12s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047830d:20h:32m:18s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048901d:07h:21m:24s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049971d:18h:10m:30s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048794d:00h:27m:52s]
[  151.263502] softirq: huh, entered softirq 6 TASKLET 000000002aed33dd 
with preempt_count 00000100, exited with fffffffe?
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049816d:15h:16m:18s]
[  151.312427] sas: Enter sas_scsi_recover_host busy: 192 failed: 192
[  151.318613] sas: trying to find task 0x00000000294f58ee
[  151.323830] sas: sas_scsi_find_task: aborting task 0x00000000294f58ee
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158045974d:14h:49m:07s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158046897d:22h:56m:49s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047821d:07h:04m:31s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048744d:15h:12m:13s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158046537d:10h:31m:29s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158050141d:20h:12m:10s]
[  157.407215] hisi_sas_v3_hw 0000:74:02.0: internal task abort: timeout 
and not done.
[  157.414855] hisi_sas_v3_hw 0000:74:02.0: abort task: internal abort 
failed
[  157.421720] hisi_sas_v3_hw 0000:74:02.0: abort task: rc=-5
[  157.427202] sas: sas_scsi_find_task: querying task 0x00000000294f58ee
[  157.433634] sas: sas_scsi_find_task: task 0x00000000294f58ee failed 
to abort
[  157.440670] sas: task 0x00000000294f58ee is not at LU: I_T recover
[  157.446841] sas: I_T nexus reset for dev 500e004aaaaaaa02
[  157.452239] hisi_sas_v3_hw 0000:74:02.0: internal task abort: 
executing internal task failed: -22
[  157.461095] hisi_sas_v3_hw 0000:74:02.0: I_T nexus reset: internal 
abort (-22)
[  157.468310] hisi_sas_v3_hw 0000:74:02.0: internal task abort: 
executing internal task failed: -22
[  157.477170] hisi_sas_v3_hw 0000:74:02.0: lu_reset: internal abort failed
[  157.483866] hisi_sas_v3_hw 0000:74:02.0: lu_reset: for device[3]:rc= -22
[  157.490558] hisi_sas_v3_hw 0000:74:02.0: internal task abort: 
executing internal task failed: -22
[  157.499417] hisi_sas_v3_hw 0000:74:02.0: I_T nexus reset: internal 
abort (-22)
[  157.506627] sas: clear nexus ha
[  157.516706] hisi_sas_v3_hw 0000:74:02.0: controller resetting...
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047356d:20h:42m:24s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048189d:11h:12m:35s]
[  159.318030] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=11
[  159.324114] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=11
[  159.330195] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=11
[  159.336274] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=11
[  159.342354] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=11
[  159.348433] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=11
[  159.354513] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=11
[  159.360593] hisi_sas_v3_hw 0000:74:02.0: phyup: phy7 link_rate=11
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049022d:01h:42m:46s]
[  160.349201] hisi_sas_v3_hw 0000:74:02.0: controller reset complete
[  160.349208] sas: broadcast received: 0
[  160.355378] hisi_sas_v3_hw 0000:74:02.0: dump count exceeded!
[  160.359138] sas: REVALIDATING DOMAIN on port 0, pid:937
[  160.370508] sas: ex 500e004aaaaaaa1f phy01 change count has changed
[  160.376993] sas: ex 500e004aaaaaaa1f phy01 originated BROADCAST(CHANGE)
[  160.383603] sas: ex 500e004aaaaaaa1f rediscovering phy01
[  160.389117] sas: ex 500e004aaaaaaa1f phy01:U:5 attached: 
0000000000000000 (no device)
[  160.398068] sas: ex 500e004aaaaaaa1f phy16 originated BROADCAST(CHANGE)
[  160.404676] sas: ex 500e004aaaaaaa1f rediscovering phy16, part of a 
wide port with phy17
[  160.412978] sas: ex 500e004aaaaaaa1f phy16 broadcast flutter
[  160.418751] sas: ex 500e004aaaaaaa1f phy17 originated BROADCAST(CHANGE)
[  160.425358] sas: ex 500e004aaaaaaa1f rediscovering phy17, part of a 
wide port with phy16
[  160.433638] sas: ex 500e004aaaaaaa1f phy17 broadcast flutter
[  160.439421] sas: ex 500e004aaaaaaa1f phy18 originated BROADCAST(CHANGE)
[  160.446030] sas: ex 500e004aaaaaaa1f rediscovering phy18, part of a 
wide port with phy16
[  160.454316] sas: ex 500e004aaaaaaa1f phy18 broadcast flutter
[  160.460105] sas: ex 500e004aaaaaaa1f phy19 originated BROADCAST(CHANGE)
[  160.466712] sas: ex 500e004aaaaaaa1f rediscovering phy19, part of a 
wide port with phy16
[  160.475022] sas: ex 500e004aaaaaaa1f phy19 broadcast flutter
[  160.480801] sas: ex 500e004aaaaaaa1f phy20 originated BROADCAST(CHANGE)
[  160.487410] sas: ex 500e004aaaaaaa1f rediscovering phy20, part of a 
wide port with phy16
[  160.495692] sas: ex 500e004aaaaaaa1f phy20 broadcast flutter
[  160.501421] sas: ex 500e004aaaaaaa1f phy21 originated BROADCAST(CHANGE)
[  160.508029] sas: ex 500e004aaaaaaa1f rediscovering phy21, part of a 
wide port with phy16
[  160.516309] sas: ex 500e004aaaaaaa1f phy21 broadcast flutter
[  160.522048] sas: ex 500e004aaaaaaa1f phy22 originated BROADCAST(CHANGE)
[  160.528653] sas: ex 500e004aaaaaaa1f rediscovering phy22, part of a 
wide port with phy16
[  160.536975] sas: ex 500e004aaaaaaa1f phy22 broadcast flutter
[  160.542699] sas: ex 500e004aaaaaaa1f phy23 originated BROADCAST(CHANGE)
[  160.549307] sas: ex 500e004aaaaaaa1f rediscovering phy23, part of a 
wide port with phy16
[  160.557591] sas: ex 500e004aaaaaaa1f phy23 broadcast flutter
[  160.563318] sas: done REVALIDATING DOMAIN on port 0, pid:937, res 0x0
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049854d:16h:12m:57s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048255d:18h:40m:08s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158050345d:15h:15m:03s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049839d:22h:28m:25s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158046025d:15h:04m:58s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158046744d:14h:10m:15s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047614d:11h:05m:16s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049100d:12h:27m:26s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048901d:11h:26m:07s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049620d:10h:31m:24s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158050339d:09h:36m:41s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049314d:16h:14m:45s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047401d:22h:42m:56s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048059d:06h:48m:09s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158048716d:14h:53m:22s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049373d:22h:58m:36s]
[  176.479216] sas: clear nexus ha succeeded
[  176.483220] sas: --- Exit sas_eh_handle_sas_errors -- clear_q
[  176.488980] sas: ata2: end_device-0:0:4: cmd error handler
[  176.494464] sas: ata1: end_device-0:0:2: cmd error handler
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158050031d:07h:03m:49s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049507d:04h:34m:56s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158050077d:05h:12m:47s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049104d:11h:12m:35s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049724d:15h:20m:48s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158050344d:19h:29m:01s]
[  182.751214] hisi_sas_v3_hw 0000:74:02.0: internal task abort: timeout 
and not done.
[  182.751217] hisi_sas_v3_hw 0000:74:02.0: dump count exceeded!
[  182.758857] hisi_sas_v3_hw 0000:74:02.0: lu_reset: internal abort failed
[  182.758858] hisi_sas_v3_hw 0000:74:02.0: lu_reset: for device[4]:rc= -5
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158047857d:06h:57m:44s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049091d:00h:22m:57s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [0.0% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 1158049020d:21h:38m:22s]
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR

> 
>>
>> Ming Lei (6):
>>    blk-mq: add new state of BLK_MQ_S_INACTIVE
>>    blk-mq: prepare for draining IO when hctx's all CPUs are offline
>>    blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>>    blk-mq: re-submit IO in case that hctx is inactive
>>    blk-mq: handle requests dispatched from IO scheduler in case of
>>      inactive hctx
>>    block: deactivate hctx when all its CPUs are offline when running
>>      queue
>>
>>   block/blk-mq-debugfs.c     |   2 +
>>   block/blk-mq-tag.c         |   2 +-
>>   block/blk-mq-tag.h         |   2 +
>>   block/blk-mq.c             | 172 +++++++++++++++++++++++++++++++------
>>   block/blk-mq.h             |   3 +-
>>   drivers/block/loop.c       |   2 +-
>>   drivers/md/dm-rq.c         |   2 +-
>>   include/linux/blk-mq.h     |   6 ++
>>   include/linux/cpuhotplug.h |   1 +
>>   9 files changed, 163 insertions(+), 29 deletions(-)
>>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Keith Busch <keith.busch@intel.com>
>>
> 
> .

