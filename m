Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/6] blk-mq: don't allocate driver tag beforehand for
 flush rq
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>
References: <20170914164213.17859-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <77beace7-6243-dbda-0c8e-245fe1a9bed9@kernel.dk>
Date: Thu, 14 Sep 2017 12:51:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170914164213.17859-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/14/2017 10:42 AM, Ming Lei wrote:
> Hi,
> 
> This patchset avoids to allocate driver tag beforehand for flush rq
> in case of I/O scheduler, then flush rq isn't treated specially
> wrt. get/put driver tag, code gets cleanup much, such as,
> reorder_tags_to_front() is removed, and we needn't to worry
> about request order in dispatch list for avoiding I/O deadlock.
> 
> 'dbench -t 30 -s -F 64' has been run on different devices(shared tag,
> multi-queue, singele queue, ...), and no issues are observed,
> even very low queue depth(1) test are run, debench still works
> well.

Gave this a quick spin on the test box, and I get tons of spewage
on booting up:

[    9.131290] WARNING: CPU: 2 PID: 337 at block/blk-mq-sched.c:274 blk_mq_sched_insert_request+0x15d/0x170
[    9.131290] Modules linked in: sd_mod igb(+) ahci libahci i2c_algo_bit libata dca nvme nvme_core
[    9.131295] CPU: 2 PID: 337 Comm: kworker/u129:1 Tainted: G        W       4.13.0+ #472
[    9.131295] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
[    9.131298] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[    9.131299] task: ffff881ff7940e00 task.stack: ffff881ff7960000
[    9.131301] RIP: 0010:blk_mq_sched_insert_request+0x15d/0x170
[    9.131301] RSP: 0018:ffff881ff79639c8 EFLAGS: 00010217
[    9.131302] RAX: ffff881feeb30000 RBX: ffff881feebd3f00 RCX: 0000000000002000
[    9.131303] RDX: ffff881ff31c1800 RSI: 0000000000000000 RDI: ffff881feebd3f00
[    9.131303] RBP: ffff881ff7963a10 R08: 0000000000000000 R09: 0000000000000008
[    9.131304] R10: 0000000000001000 R11: 0000000000000422 R12: ffff881ff348c400
[    9.131305] R13: 0000000000000000 R14: 0000000000000001 R15: ffffe8dfffe4a540
[    9.131305] FS:  0000000000000000(0000) GS:ffff881fff640000(0000) knlGS:0000000000000000
[    9.131306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.131307] CR2: 00007f5675e76b60 CR3: 0000001ff832e002 CR4: 00000000003606e0
[    9.131308] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.131308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.131308] Call Trace:
[    9.131311]  ? bio_alloc_bioset+0x179/0x1d0
[    9.131314]  blk_execute_rq_nowait+0x68/0xe0
[    9.131316]  blk_execute_rq+0x53/0x90
[    9.131318]  __nvme_submit_sync_cmd+0xa2/0xf0 [nvme_core]
[    9.131320]  nvme_identify_ns.isra.32+0x6b/0xa0 [nvme_core]
[    9.131323]  nvme_revalidate_disk+0x7c/0x130 [nvme_core]
[    9.131324]  rescan_partitions+0x80/0x350
[    9.131325]  ? rescan_partitions+0x80/0x350
[    9.131327]  ? down_write+0x1b/0x50
[    9.131331]  __blkdev_get+0x277/0x3f0
[    9.131332]  ? _raw_spin_unlock+0x9/0x20
[    9.131334]  blkdev_get+0x11e/0x320
[    9.131335]  ? bdget+0x11d/0x140
[    9.131337]  device_add_disk+0x3e0/0x430
[    9.131340]  ? __might_sleep+0x45/0x80
[    9.131342]  nvme_validate_ns+0x302/0x560 [nvme_core]
[    9.131344]  nvme_scan_work+0x7c/0x2f0 [nvme_core]
[    9.131346]  ? try_to_wake_up+0x45/0x430
[    9.131348]  process_one_work+0x18a/0x3e0
[    9.131349]  worker_thread+0x48/0x3b0
[    9.131351]  kthread+0x12a/0x140
[    9.131352]  ? process_one_work+0x3e0/0x3e0
[    9.131353]  ? kthread_create_on_node+0x40/0x40
[    9.131355]  ret_from_fork+0x22/0x30
[    9.131356] Code: c0 4c 89 fa e8 e5 97 02 00 48 8b 4d c0 84 c0 74 10 49 89 5f 08 4c 89 3b 48 89 4b 08 49 89 5c 24 18 4c 89 e7 e8 55 12 37 00 eb 93 <0f> ff e9 fd fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 49 
[    9.131374] ---[ end trace 199de228942af254 ]---

On top of that, there's a lot of spewage before that that I can't
even decipher since it's all intermingled, but it looks like a
lock imbalance issue.

This is on top of current master, fwiw.

-- 
Jens Axboe
