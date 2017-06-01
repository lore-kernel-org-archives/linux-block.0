Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/6] block: Avoid that blk_exit_rl() triggers a
 use-after-free
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, stable@vger.kernel.org
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
 <20170531214350.31157-2-bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <79a9edff-ba7d-81c1-1afc-b0f8809e094c@kernel.dk>
Date: Thu, 1 Jun 2017 12:09:08 -0700
MIME-Version: 1.0
In-Reply-To: <20170531214350.31157-2-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/31/2017 02:43 PM, Bart Van Assche wrote:
> Since the introduction of .init_rq_fn() and .exit_rq_fn() it is
> essential that the memory allocated for struct request_queue
> stays around until all blk_exit_rl() calls have finished. Hence
> make blk_init_rl() take a reference on struct request_queue.
> 
> This patch fixes the following crash:
> 
> general protection fault: 0000 [#2] SMP
> CPU: 3 PID: 28 Comm: ksoftirqd/3 Tainted: G      D         4.12.0-rc2-dbg+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> task: ffff88013a108040 task.stack: ffffc9000071c000
> RIP: 0010:free_request_size+0x1a/0x30
> RSP: 0018:ffffc9000071fd38 EFLAGS: 00010202
> RAX: 6b6b6b6b6b6b6b6b RBX: ffff880067362a88 RCX: 0000000000000003
> RDX: ffff880067464178 RSI: ffff880067362a88 RDI: ffff880135ea4418
> RBP: ffffc9000071fd40 R08: 0000000000000000 R09: 0000000100180009
> R10: ffffc9000071fd38 R11: ffffffff81110800 R12: ffff88006752d3d8
> R13: ffff88006752d3d8 R14: ffff88013a108040 R15: 000000000000000a
> FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa8ec1edb00 CR3: 0000000138ee8000 CR4: 00000000001406e0
> Call Trace:
>  mempool_destroy.part.10+0x21/0x40
>  mempool_destroy+0xe/0x10
>  blk_exit_rl+0x12/0x20
>  blkg_free+0x4d/0xa0
>  __blkg_release_rcu+0x59/0x170
>  rcu_process_callbacks+0x260/0x4e0
>  __do_softirq+0x116/0x250
>  smpboot_thread_fn+0x123/0x1e0
>  kthread+0x109/0x140
>  ret_from_fork+0x31/0x40
> 
> Fixes: commit e9c787e65c0c ("scsi: allocate scsi_cmnd structures as part of struct request")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org> # v4.11+

Added this one for 4.12.

-- 
Jens Axboe
