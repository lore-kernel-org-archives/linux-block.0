Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 30 Jan 2018 15:30:28 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: paolo.valente@linaro.org, Ivan Kozik <ivan@ludios.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bfq-iosched@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
 linus.walleij@linaro.org
Subject: Re: v4.15 and I/O hang with BFQ
In-Reply-To: <20180130081925.GA25183@ming.t460p>
References: <9ad0d544ab2b12f87f44eb4ef88e23a2@natalenko.name>
 <20180130081925.GA25183@ming.t460p>
Message-ID: <38bd4dbe280bd0934abde764fe0916cd@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

30.01.2018 09:19, Ming Lei wrote:
> Hi,
> We knew there is IO hang issue on BFQ over USB-storage wrt. blk-mq, and
> last time I found it is inside BFQ. You can try the debug patch in the
> following link[1] to see if it is same with the previous report[1][2]:
> 
> [1] https://marc.info/?l=linux-block&m=151214241518562&w=2
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=198023
> 
> If you aren't sure if they are same, please post the trace somewhere,
> then I can check if it is a new bug.

OK, first, I got 2 more stacktraces without tracing, then I've rebooted 
with your patch and checked tracing.

Before reboot, cfdisk:

===
[  266.630386] INFO: task cfdisk:437 blocked for more than 20 seconds.
[  266.640950]       Not tainted 4.15.0-pf1 #1
[  266.645131] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  266.651789] cfdisk          D    0   437    410 0x00000000
[  266.661331] Call Trace:
[  266.664517]  ? __schedule+0x35f/0x1000
[  266.668660]  ? bio_alloc_bioset+0xc7/0x1e0
[  266.672330]  ? submit_bh_wbc+0x162/0x190
[  266.678034]  schedule+0x32/0xc0
[  266.681293]  io_schedule+0x12/0x40
[  266.685230]  wait_on_page_bit+0xea/0x130
[  266.689015]  ? add_to_page_cache_lru+0xe0/0xe0
[  266.693456]  ? blkdev_writepages+0x30/0x30
[  266.695521]  do_read_cache_page+0x167/0x350
[  266.697160]  read_dev_sector+0x28/0xc0
[  266.698685]  scsi_bios_ptable+0x4e/0x120 [scsi_mod]
[  266.700156]  scsicam_bios_param+0x16/0x1a0 [scsi_mod]
[  266.701868]  sd_getgeo+0xbf/0xd0 [sd_mod]
[  266.703388]  blkdev_ioctl+0x178/0x990
[  266.704818]  block_ioctl+0x39/0x40
[  266.706381]  do_vfs_ioctl+0xa4/0x630
[  266.708584]  ? __fput+0x131/0x1e0
[  266.710184]  ? preempt_count_add+0x68/0xa0
[  266.711762]  ? _raw_spin_unlock_irq+0x1d/0x30
[  266.713304]  SyS_ioctl+0x74/0x80
[  266.714502]  ? exit_to_usermode_loop+0x39/0xa0
[  266.717352]  entry_SYSCALL_64_fastpath+0x20/0x83
[  266.718857] RIP: 0033:0x7fc482064d87
===

Blocked kworker:

===
[  389.511083] INFO: task kworker/u8:5:178 blocked for more than 20 
seconds.
[  389.516454]       Not tainted 4.15.0-pf1 #1
[  389.520091] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this
message.
[  389.524726] kworker/u8:5    D    0   178      2 0x80000000
[  389.528321] Workqueue: events_freezable_power_ disk_events_workfn
[  389.532228] Call Trace:
[  389.534909]  ? __schedule+0x35f/0x1000
[  389.541906]  ? blk_mq_sched_dispatch_requests+0x116/0x190
[  389.546561]  ? __sbitmap_get_word+0x2a/0x80
[  389.551167]  ? sbitmap_get_shallow+0x5c/0xa0
[  389.555633]  schedule+0x32/0xc0
[  389.559803]  io_schedule+0x12/0x40
[  389.564504]  blk_mq_get_tag+0x181/0x2a0
[  389.572541]  ? wait_woken+0x80/0x80
[  389.576008]  blk_mq_get_request+0xf9/0x410
[  389.579998]  blk_mq_alloc_request+0x7e/0xe0
[  389.584824]  blk_get_request_flags+0x40/0x160
[  389.588917]  scsi_execute+0x38/0x1e0 [scsi_mod]
[  389.593079]  scsi_test_unit_ready+0x5d/0xd0 [scsi_mod]
[  389.596966]  sd_check_events+0xf5/0x1a0 [sd_mod]
[  389.602558]  disk_check_events+0x69/0x150
[  389.604822]  process_one_work+0x1df/0x420
[  389.606584]  worker_thread+0x2b/0x3d0
[  389.608175]  ? process_one_work+0x420/0x420
[  389.609833]  kthread+0x113/0x130
[  389.611327]  ? kthread_create_on_node+0x70/0x70
[  389.612852]  ret_from_fork+0x35/0x40
===

After reboot, tracing info:

===
    systemd-udevd-269   [000] ...1     4.309198: 
blk_mq_do_dispatch_sched: get rq->0, 1
     kworker/0:1H-174   [000] ....     4.309380: 
blk_mq_do_dispatch_sched: not get rq, 1
     kworker/u8:2-167   [000] ....     4.309562: bfq_insert_requests: 
insert rq->0
     kworker/u8:2-167   [000] ...1     4.309563: 
blk_mq_do_dispatch_sched: get rq->0, 1
     kworker/0:1H-174   [000] ....     4.309694: 
blk_mq_do_dispatch_sched: not get rq, 1
     kworker/u8:2-167   [000] ....     4.309879: bfq_insert_requests: 
insert rq->0
     kworker/u8:2-167   [000] ...1     4.309880: 
blk_mq_do_dispatch_sched: get rq->0, 1
     kworker/0:1H-174   [000] ....     4.310001: 
blk_mq_do_dispatch_sched: not get rq, 1
    systemd-udevd-271   [000] ....     4.311033: bfq_insert_requests: 
insert rq->0
    systemd-udevd-271   [000] ...1     4.311037: 
blk_mq_do_dispatch_sched: not get rq, 1
           cfdisk-408   [000] ....    13.484220: bfq_insert_requests: 
insert rq->1
     kworker/0:1H-174   [000] ....    13.484253: 
blk_mq_do_dispatch_sched: not get rq, 1
===

Looks the same, right?

> Or Paolo should know if the issue is fixed or not in V4.15.

So, Paolo :)?

Regards,
   Oleksandr
