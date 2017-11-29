Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:2186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751377AbdK2C5Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Nov 2017 21:57:25 -0500
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
CC: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
Date: Wed, 29 Nov 2017 10:57:06 +0800
MIME-Version: 1.0
In-Reply-To: <20171127124147.GA16095@ming.t460p>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

在 2017/11/27 20:41, Ming Lei 写道:
> On Thu, Nov 23, 2017 at 12:47:58PM +0800, Ming Lei wrote:
>> Hi Jens,
>>
>> The 1st patch runs queue in blk_freeze_queue_start() for fixing one
>> regression by 055f6e18e08f("block: Make q_usage_counter also track legacy
>> requests").
>>
>> The 2nd patch drians blkcg part of request_queue for both blk-mq and
>> legacy, which can be a fix on blk-mq's queue cleanup.
>>
>> V2:
>> 	- follow Bart's suggestion to use run queue instead of drain queue
>> 	- drians blkcg part of request_queue for blk-mq
>>
> Hi Jens,
>
> Without this patchset, IO hang can be triggered in Mauricio's disk
> pull test, and this IO hang won't happen any more after this patchset
> is applied.
>
> So could you make it in V4.15 if you are fine with the two patches?

Hi Lei Ming,

I applied this v2 patchset to kernel 4.15-rc1, running fio on a SATA 
disk, then disable the disk with sysfs interface
(echo 0 > /sys/class/sas_phy/phy-1:0:1/enable), and find system is hung. 
But with v1 patch, it doesn't
has this issue. Please have a check.

Log of the issue is as follows:

estuary:/$ fio -filename=/dev/sdb1 -direct=1 -iodepth 1 -thread -rw=re
ad -ioengine=psync -bs=4k -numjobs=64 -runtime=300 -group_reporting 
-name=mytest
mytest: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, iodepth=1
...
fio-2.1.11
Starting 64 threads
[  112.362950] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=1 
task=ffff801fc3e5e580 CQ hdr: 0x1103 0x1 0x0 0x0 Error info: 0x0 0x200 
0x0 0x0
[  112.376108] sas: smp_execute_task_sg: task to dev 500e004aaaaaaa1f 
response: 0x0 status 0x2
[  112.384597] sas: broadcast received: 0
[  112.388357] sas: REVALIDATING DOMAIN on port 0, pid:2032
[  112.394136] sas: Expander phy change count has changed
[  112.399501] sas: ex 500e004aaaaaaa1f phy1 originated BROADCAST(CHANGE)
[  112.408321] sas: done REVALIDATING DOMAIN on port 0, pid:2032, res 0x0
[  112.415524] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
fio: pid=2781, err=5/file:engines/[  112.420876] sd 0:0:1:0: [sdb] 
Synchronize Cache(10) failed: Result: hostbyte=0x04 driverbyte=0x00
sync.c:67, func=xfer, error=Input/[  112.432688] sd 0:0:1:0: [sdb] 
Stopping disk
output error
fio: pid=2784, err=[  112.439696] sd 0:0:1:0: [sdb] Start/Stop Unit 
failed: Result: hostbyte=0x04 driverbyte=0x00
5/file:engines/sync.c:67, func=xfer, error=Input/output error
fio: pid=2817, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2792, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2777, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2782, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2814, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2819, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2776, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2815, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2791, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2796, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2799, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2803, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2816, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2778, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2820, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2807, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2769, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2822, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2783, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2821, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2809, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2811, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2804, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2808, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2824, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2786, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2766, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2794, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2774, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2802, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2810, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2826, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2829, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
fio: pid=2767, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
[  144.890733] sas: Enter sas_scsi_recover_host busy: 3 failed: 3
[  144.896570] sas: trying to find task 0xffff8017ca664300
[  144.901794] sas: sas_scsi_find_task: aborting task 0xffff8017ca664300
[  144.908261] hisi_sas_v2_hw HISI0162:01: internal task abort: task to 
dev 500e004aaaaaaa01 task=ffff8017cfb4db00 resp: 0x0 sts 0x8
[  144.954984] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=66 
task=ffff8017d0130a80 CQ hdr: 0x101b 0x20042 0x0 0x0 Error info: 0x8000 
0x0 0x0 0x0
[  144.968627] hisi_sas_v2_hw HISI0162:01: abort tmf: task to dev 
500e004aaaaaaa01 resp: 0x0 status 0x87
[  145.012914] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=66 
task=ffff8017d0130a80 CQ hdr: 0x101b 0x20042 0x0 0x0 Error info: 0x8000 
0x0 0x0 0x0
[  145.026568] hisi_sas_v2_hw HISI0162:01: abort tmf: task to dev 
500e004aaaaaaa01 resp: 0x0 status 0x87
[  145.070853] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=66 
task=ffff8017d0130a80 CQ hdr: 0x101b 0x20042 0x0 0x0 Error info: 0x8000 
0x0 0x0 0x0
[  145.084496] hisi_sas_v2_hw HISI0162:01: abort tmf: task to dev 
500e004aaaaaaa01 resp: 0x0 status 0x87
[  145.093712] hisi_sas_v2_hw HISI0162:01: abort tmf: executing internal 
task failed!
[  145.101279] hisi_sas_v2_hw HISI0162:01: ata disk reset failed
[  145.107021] hisi_sas_v2_hw HISI0162:01: abort task: rc=5
[  145.112330] sas: sas_scsi_find_task: task 0xffff8017ca664300 is done
[  145.118678] sas: sas_eh_handle_sas_errors: task 0xffff8017ca664300 is 
done
[  145.125550] sas: trying to find task 0xffff8017ce1bf900
[  145.130771] sas: sas_scsi_find_task: aborting task 0xffff8017ce1bf900
[  145.137208] sas: sas_scsi_find_task: task 0xffff8017ce1bf900 is done
[  145.143557] sas: sas_eh_handle_sas_errors: task 0xffff8017ce1bf900 is 
done
[  145.150429] sas: trying to find task 0xffff8017ca45cd80
[  145.155648] sas: sas_scsi_find_task: aborting task 0xffff8017ca45cd80
[  145.162101] hisi_sas_v2_hw HISI0162:01: internal task abort: task to 
dev 500e004aaaaaaa01 task=ffff8017d0130a80 resp: 0x0 sts 0x0
[  145.208816] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=66 
task=ffff8017d0130a80 CQ hdr: 0x101b 0x20042 0x0 0x0 Error info: 0x8000 
0x0 0x0 0x0
[  145.222458] hisi_sas_v2_hw HISI0162:01: abort tmf: task to dev 
500e004aaaaaaa01 resp: 0x0 status 0x87
[  145.266741] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=66 
task=ffff8017d0130a80 CQ hdr: 0x101b 0x20042 0x0 0x0 Error info: 0x8000 
0x0 0x0 0x0
[  145.280383] hisi_sas_v2_hw HISI0162:01: abort tmf: task to dev 
500e004aaaaaaa01 resp: 0x0 status 0x87
[  145.324666] hisi_sas_v2_hw HISI0162:01: erroneous completion iptt=66 
task=ffff8017d0130a80 CQ hdr: 0x101b 0x20042 0x0 0x0 Error info: 0x8000 
0x0 0x0 0x0
[  145.338309] hisi_sas_v2_hw HISI0162:01: abort tmf: task to dev 
500e004aaaaaaa01 resp: 0x0 status 0x87
[  145.347524] hisi_sas_v2_hw HISI0162:01: abort tmf: executing internal 
task failed!
[  145.355091] hisi_sas_v2_hw HISI0162:01: ata disk reset failed
[  145.360832] hisi_sas_v2_hw HISI0162:01: abort task: rc=5
[  145.366140] sas: sas_scsi_find_task: querying task 0xffff8017ca45cd80
[  145.372575] sas: sas_scsi_find_task: task 0xffff8017ca45cd80 failed 
to abort
[  145.379619] sas: task 0xffff8017ca45cd80 is not at LU: I_T recover
[  145.385794] sas: I_T nexus reset for dev 500e004aaaaaaa01
[  145.391205] hisi_sas_v2_hw HISI0162:01: internal task abort: task to 
dev 500e004aaaaaaa01 task=ffff8017d0130a80 resp: 0x0 sts 0x0
[  147.438724] sas: I_T 500e004aaaaaaa01 recovered
[  147.443255] sas: ata1: end_device-0:0:1: cmd error handler
[  147.448755] sas: ata1: end_device-0:0:1: dev error handler
[  147.448762] sas: ata2: end_device-0:0:4: dev error handler
[  147.448768] sas: ata3: end_device-0:0:7: dev error handler
[  147.448779] sas: ata4: end_device-0:0:9: dev error handler
[  147.448781] sas: ata5: end_device-0:0:10: dev error handler
[  147.476262] ata1.00: exception Emask 0x0 SAct 0xe0000 SErr 0x0 action 
0x6 frozen
[  147.483664] ata1.00: failed command: READ FPDMA QUEUED
[  147.488802] ata1.00: cmd 60/08:00:88:5a:01/00:00:00:00:00/40 tag 18 
ncq dma 4096 in
[  147.488802]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  147.503834] ata1.00: status: { DRDY }
[  147.507492] ata1.00: failed command: READ FPDMA QUEUED
[  147.512628] ata1.00: cmd 60/08:00:78:5a:01/00:00:00:00:00/40 tag 19 
ncq dma 4096 in
[  147.512628]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  147.527657] ata1.00: status: { DRDY }
[  147.531319] ata1: hard resetting link
[  147.534977] sas: ata1: end_device-0:0:1: Unable to reset ata device?
[  147.698866] sas: ata: ex 500e004aaaaaaa1f phy01:U:A attached: 
0000000000000000 (no device)
[  148.546838] sas: ata1: end_device-0:0:1: reset failed (errno=-19)
[  148.552933] ata1: reset failed (errno=-19), retrying in 9 secs
[  157.678707] ata1: hard resetting link
[  157.682358] sas: ata1: end_device-0:0:1: Unable to reset ata device?
[  158.686836] sas: ata1: end_device-0:0:1: reset failed (errno=-19)
[  158.692927] ata1: reset failed (errno=-19), retrying in 9 secs
[  167.918703] ata1: hard resetting link
[  167.922354] sas: ata1: end_device-0:0:1: Unable to reset ata device?
[  168.926838] sas: ata1: end_device-0:0:1: reset failed (errno=-19)
[  168.932929] ata1: reset failed (errno=-19), retrying in 34 secs
[  204.270708] ata1: hard resetting link
[  204.274359] sas: ata1: end_device-0:0:1: Unable to reset ata device?
[  205.278855] sas: ata1: end_device-0:0:1: reset failed (errno=-19)
[  205.284947] ata1: reset failed, giving up
[  205.288961] ata1.00: disabled
[  205.291946] WARNING: CPU: 0 PID: 2197 at drivers/ata/libata-eh.c:4039 
ata_eh_finish+0xb4/0xcc
[  205.300457] Modules linked in:
[  205.303504] CPU: 0 PID: 2197 Comm: kworker/u129:11 Not tainted 
4.15.0-rc1-g35c43a4-dirty #585
[  205.312016] Hardware name: Huawei D05/D05, BIOS Hisilicon D05 UEFI 
Nemo 1.8 RC0 08/31/2017
[  205.320269] Workqueue: events_unbound async_run_entry_fn
[  205.325571] task: ffff8017d53d3200 task.stack: ffff000019b68000
[  205.331479] pstate: 60000005 (nZCv daif -PAN -UAO)
[  205.336258] pc : ata_eh_finish+0xb4/0xcc
[  205.340169] lr : ata_eh_finish+0xb0/0xcc
[  205.344080] sp : ffff000019b6bbf0
[  205.347383] x29: ffff000019b6bbf0 x28: ffff8017d2aea520
[  205.352686] x27: ffff8017d2aea598 x26: ffff8017d2aec2e8
[  205.357990] x25: 0000000000000000 x24: ffff8017d2aec000
[  205.363293] x23: 0000000000000001 x22: ffff0000086ca090
[  205.368597] x21: ffff8017d2ae8000 x20: ffff8017d2ae9f80
[  205.373900] x19: ffff8017d2ae9f80 x18: 0000000000000007
[  205.379204] x17: 000000000000000e x16: 0000000000000001
[  205.384507] x15: 0000000000000007 x14: 0000000000000000
[  205.389811] x13: 0000000000000000 x12: ffffffffffffffff
[  205.395114] x11: 0000000000000000 x10: 0000000000000006
[  205.400418] x9 : 0000000000000006 x8 : 000000000000059c
[  205.405721] x7 : ffff0000086ca844 x6 : 0000000008000002
[  205.411025] x5 : ffff8017ca80f560 x4 : ffff8017d2aec1c0
[  205.416328] x3 : ffff8017ca80f5b0 x2 : ffff8017cf5761b0
[  205.421632] x1 : 0000000000000000 x0 : 0000000000000001
[  205.426936] Call trace:
[  205.429371]  ata_eh_finish+0xb4/0xcc
[  205.432935]  ata_do_eh+0xac/0xbc
[  205.436151]  ata_std_error_handler+0x3c/0x80
[  205.440410]  ata_scsi_port_error_handler+0x468/0x65c
[  205.445364]  async_sas_ata_eh+0x48/0x70
[  205.449189]  async_run_entry_fn+0x48/0x130
[  205.453274]  process_one_work+0x1a8/0x39c
[  205.457273]  worker_thread+0x14c/0x408
[  205.461010]  kthread+0x12c/0x158
[  205.464227]  ret_from_fork+0x10/0x18
[  205.467791] ---[ end trace cebfc3ab091dd523 ]---
[  205.472438] scsi 0:0:1:0: [sdb] tag#1 UNKNOWN(0x2003) Result: 
hostbyte=0x00 driverbyte=0x08
[  205.480786] scsi 0:0:1:0: [sdb] tag#1 Sense Key : 0x2 [current]
[  205.486794] scsi 0:0:1:0: [sdb] tag#1 ASC=0x4 ASCQ=0x21
[  205.492103] scsi 0:0:1:0: [sdb] tag#1 CDB: opcode=0x88 88 00 00 00 00 
00 00 01 5a 88 00 00 00 08 00 00
[  205.501409] print_req_error: I/O error, dev sdb, sector 88712
[  205.507167] scsi 0:0:1:0: [sdb] tag#2 UNKNOWN(0x2003) Result: 
hostbyte=0x00 driverbyte=0x08
fio: pid=2801, err=5/file:engines[  205.515521] scsi 0:0:1:0: [sdb] 
tag#2 Sense Key : 0x2 [current]
/sync.c:67, func=xfer, error=Inpu[  205.524405] scsi 0:0:1:0: [sdb] 
tag#2 ASC=0x4 ASCQ=0x21
t/output error
[  205.532619] scsi 0:0:1:0: [sdb] tag#2 CDB: opcode=0x88 88 00 00 00 00 
00 00 01 5a 78 00 00 00 08 00 00
[  205.543240] print_req_error: I/O error, dev sdb, sector 88696
[  205.549001] ata1: EH complete
fio: pid=2779, err=5/file:engines[  205.551988] scsi 0:0:1:0: [sdb] 
tag#0 UNKNOWN(0x2003) Result: hostbyte=0x05 driverbyte=0x00
/sync.c:67, func=xfer, error=Inpu[  205.563191] scsi 0:0:1:0: [sdb] 
tag#0 CDB: opcode=0x88 88 00 00 00 00 00 00 01 5a 88 00 00 00 08 00 00
t/output error
[  205.575340] print_req_error: I/O error, dev sdb, sector 88712
[  205.582484] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 3 
tries: 1
fio: pid=2805, err=5/file:engines/sync.c:67, func=xfer, 
error=Input/output error
[  249.326782] INFO: task kworker/u128:1:2032 blocked for more than 120 
seconds.
[  249.333925]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.340885] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.348716] kworker/u128:1  D    0  2032      2 0x00000020
[  249.354212] Workqueue: HISI0162:01_disco_q sas_revalidate_domain
[  249.360217] Call trace:
[  249.362656]  __switch_to+0x98/0xb4
[  249.366059]  __schedule+0x22c/0x888
[  249.369543]  schedule+0x34/0x94
[  249.372685]  blk_mq_freeze_queue_wait+0x4c/0x9c
[  249.377211]  blk_freeze_queue+0x1c/0x28
[  249.381049]  blk_cleanup_queue+0xb8/0x234
[  249.385057]  __scsi_remove_device+0x60/0x120
[  249.389323]  scsi_remove_device+0x2c/0x40
[  249.393329]  scsi_remove_target+0x184/0x1c0
[  249.397508]  sas_rphy_remove+0x60/0x64
[  249.401253]  sas_rphy_delete+0x14/0x28
[  249.404998]  sas_destruct_devices+0x70/0xa4
[  249.409177]  sas_revalidate_domain+0x5c/0xe8
[  249.413445]  process_one_work+0x1a8/0x39c
[  249.417455]  worker_thread+0x14c/0x408
[  249.421200]  kthread+0x12c/0x158
[  249.424424]  ret_from_fork+0x10/0x18
[  249.427996] INFO: task kworker/u128:2:2033 blocked for more than 120 
seconds.
[  249.435125]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.442081] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.449905] kworker/u128:2  D    0  2033      2 0x00000020
[  249.455395] Workqueue: HISI0162:01_event_q sas_port_event_worker
[  249.461400] Call trace:
[  249.463845]  __switch_to+0x98/0xb4
[  249.467245]  __schedule+0x22c/0x888
[  249.470730]  schedule+0x34/0x94
[  249.473862]  schedule_timeout+0x1dc/0x37c
[  249.477869]  wait_for_common+0x138/0x1f0
[  249.481789]  wait_for_completion+0x14/0x1c
[  249.485882]  flush_workqueue+0x118/0x444
[  249.489801]  sas_porte_broadcast_rcvd+0x5c/0x68
[  249.494331]  sas_port_event_worker+0x24/0x38
[  249.498598]  process_one_work+0x1a8/0x39c
[  249.502605]  worker_thread+0x14c/0x408
[  249.506352]  kthread+0x12c/0x158
[  249.509576]  ret_from_fork+0x10/0x18
[  249.513155] INFO: task fio:2768 blocked for more than 120 seconds.
[  249.519331]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.526288] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.534113] fio             D    0  2768   2745 0x00000000
[  249.539596] Call trace:
[  249.542033]  __switch_to+0x98/0xb4
[  249.545433]  __schedule+0x22c/0x888
[  249.548917]  schedule+0x34/0x94
[  249.552061]  io_schedule+0x14/0x30
[  249.555463]  __blkdev_direct_IO_simple+0x158/0x290
[  249.560250]  blkdev_direct_IO+0x36c/0x378
[  249.564261]  generic_file_read_iter+0xa0/0x7f4
[  249.568703]  blkdev_read_iter+0x44/0x54
[  249.572537]  __vfs_read+0xc8/0x11c
[  249.575936]  vfs_read+0x80/0x134
[  249.579162]  SyS_pread64+0x74/0x8c
[  249.582552]  el0_svc_naked+0x20/0x24
[  249.586127] INFO: task fio:2770 blocked for more than 120 seconds.
[  249.592302]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.599261] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.607086] fio             D    0  2770   2745 0x00000000
[  249.612570] Call trace:
[  249.615014]  __switch_to+0x98/0xb4
[  249.618406]  __schedule+0x22c/0x888
[  249.621892]  schedule+0x34/0x94
[  249.625031]  io_schedule+0x14/0x30
[  249.628429]  __blkdev_direct_IO_simple+0x158/0x290
[  249.633217]  blkdev_direct_IO+0x36c/0x378
[  249.637225]  generic_file_read_iter+0xa0/0x7f4
[  249.641665]  blkdev_read_iter+0x44/0x54
[  249.645499]  __vfs_read+0xc8/0x11c
[  249.648897]  vfs_read+0x80/0x134
[  249.652120]  SyS_pread64+0x74/0x8c
[  249.655520]  el0_svc_naked+0x20/0x24
[  249.659092] INFO: task fio:2771 blocked for more than 120 seconds.
[  249.665268]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.672225] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.680050] fio             D    0  2771   2745 0x00000000
[  249.685535] Call trace:
[  249.687979]  __switch_to+0x98/0xb4
[  249.691378]  __schedule+0x22c/0x888
[  249.694864]  schedule+0x34/0x94
[  249.697995]  io_schedule+0x14/0x30
[  249.701394]  __blkdev_direct_IO_simple+0x158/0x290
[  249.706182]  blkdev_direct_IO+0x36c/0x378
[  249.710187]  generic_file_read_iter+0xa0/0x7f4
[  249.714627]  blkdev_read_iter+0x44/0x54
[  249.718460]  __vfs_read+0xc8/0x11c
[  249.721859]  vfs_read+0x80/0x134
[  249.725084]  SyS_pread64+0x74/0x8c
[  249.728482]  el0_svc_naked+0x20/0x24
[  249.732055] INFO: task fio:2772 blocked for more than 120 seconds.
[  249.738230]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.745187] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.753016] fio             D    0  2772   2745 0x00000000
[  249.758502] Call trace:
[  249.760946]  __switch_to+0x98/0xb4
[  249.764343]  __schedule+0x22c/0x888
[  249.767829]  schedule+0x34/0x94
[  249.770968]  io_schedule+0x14/0x30
[  249.774358]  __blkdev_direct_IO_simple+0x158/0x290
[  249.779146]  blkdev_direct_IO+0x36c/0x378
[  249.783153]  generic_file_read_iter+0xa0/0x7f4
[  249.787593]  blkdev_read_iter+0x44/0x54
[  249.791426]  __vfs_read+0xc8/0x11c
[  249.794825]  vfs_read+0x80/0x134
[  249.798042]  SyS_pread64+0x74/0x8c
[  249.801441]  el0_svc_naked+0x20/0x24
[  249.805013] INFO: task fio:2773 blocked for more than 120 seconds.
[  249.811189]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.818146] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.825972] fio             D    0  2773   2745 0x00000000
[  249.831456] Call trace:
[  249.833892]  __switch_to+0x98/0xb4
[  249.837291]  __schedule+0x22c/0x888
[  249.840780]  schedule+0x34/0x94
[  249.843919]  io_schedule+0x14/0x30
[  249.847318]  __blkdev_direct_IO_simple+0x158/0x290
[  249.852106]  blkdev_direct_IO+0x36c/0x378
[  249.856113]  generic_file_read_iter+0xa0/0x7f4
[  249.860553]  blkdev_read_iter+0x44/0x54
[  249.864386]  __vfs_read+0xc8/0x11c
[  249.867785]  vfs_read+0x80/0x134
[  249.871010]  SyS_pread64+0x74/0x8c
[  249.874401]  el0_svc_naked+0x20/0x24
[  249.877971] INFO: task fio:2775 blocked for more than 120 seconds.
[  249.884148]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  249.891105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  249.898930] fio             D    0  2775   2745 0x00000000
[  249.904413] Call trace:
[  249.906860]  __switch_to+0x98/0xb4
[  249.910251]  __schedule+0x22c/0x888
[  249.913737]  schedule+0x34/0x94
[  249.916873]  io_schedule+0x14/0x30
[  249.920273]  __blkdev_direct_IO_simple+0x158/0x290
[  249.925060]  blkdev_direct_IO+0x36c/0x378
[  249.929068]  generic_file_read_iter+0xa0/0x7f4
[  249.933506]  blkdev_read_iter+0x44/0x54
[  249.937339]  __vfs_read+0xc8/0x11c
[  249.940738]  vfs_read+0x80/0x134
[  249.943963]  SyS_pread64+0x74/0x8c
[  249.947362]  el0_svc_naked+0x20/0x24
Jobs: 25 (f=25): [X(2),R(1),X(1),[  249.950935] INFO: task fio:2780 
blocked for more than 120 seconds.
R(4),X(1),R(1),X(4),R(1),X(4),R(1[  249.959975]       Tainted: G        
W        4.15.0-rc1-g35c43a4-dirty #585
),X(1),R(4),X(2),R(1),X(1),R(1),[  249.969784] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
X(1),R(2),X(1),R(1),X(5),R(1),X([  249.980376] fio             D 0  
2780   2745 0x00000000
5),R(2),X(4),R(1),X(4),R(1),X(1)[  249.988623] Call trace:
,R(1),X(1),R(2),X(1)] [12.0% don[  249.993834] __switch_to+0x98/0xb4
e] [0KB/0KB/0KB /s] [0/0/0 iops][  249.999998] __schedule+0x22c/0x888
[  250.006249]  schedule+0x34/0x94
[  250.010677]  io_schedule+0x14/0x30
[  250.014074]  __blkdev_direct_IO_simple+0x158/0x290
[  250.018860]  blkdev_direct_IO+0x36c/0x378
[  250.022865]  generic_file_read_iter+0xa0/0x7f4
[  250.027303]  blkdev_read_iter+0x44/0x54
[  250.031134]  __vfs_read+0xc8/0x11c
[  250.034525]  vfs_read+0x80/0x134
[  250.037748]  SyS_pread64+0x74/0x8c
[  250.041145]  el0_svc_naked+0x20/0x24
[  250.044715] INFO: task fio:2785 blocked for more than 120 seconds.
[  250.050889]       Tainted: G        W 4.15.0-rc1-g35c43a4-dirty #585
[  250.057845] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  250.065668] fio             D    0  2785   2745 0x00000000
[  250.071151] Call trace:
[  250.073587]  __switch_to+0x98/0xb4
[  250.076985]  __schedule+0x22c/0x888
[  250.080468]  schedule+0x34/0x94
[  250.083604]  io_schedule+0x14/0x30
[  250.087001]  __blkdev_direct_IO_simple+0x158/0x290
[  250.091787]  blkdev_direct_IO+0x36c/0x378
[  250.095794]  generic_file_read_iter+0xa0/0x7f4
[  250.100233]  blkdev_read_iter+0x44/0x54
[  250.104064]  __vfs_read+0xc8/0x11c
[  250.107461]  vfs_read+0x80/0x134
[  250.110678]  SyS_pread64+0x74/0x8c
[  250.114075]  el0_svc_naked+0x20/0x24

>
> Thanks,
> Ming
>
> .
>
