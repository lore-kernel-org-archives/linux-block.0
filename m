Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: nvmf regression with mq-deadline
To: Jens Axboe <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <8384a5c8-c8e6-4e46-65d6-208b802f6957@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34fb43d6-37e7-feb3-73c6-63140993ba7c@grimberg.me>
Date: Mon, 27 Feb 2017 15:31:44 +0200
MIME-Version: 1.0
In-Reply-To: <8384a5c8-c8e6-4e46-65d6-208b802f6957@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

> Hey Jens,
>
> I'm getting a regression in nvme-rdma/nvme-loop with for-linus [1]
> with a small script to trigger it.
>
> The reason seems to be that the sched_tags does not take into account
> the tag_set reserved tags.
>
> This solves it for me, any objections on this?
> --
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 98c7b061781e..46ca965fff5c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -454,7 +454,8 @@ int blk_mq_sched_setup(struct request_queue *q)
>          */
>         ret = 0;
>         queue_for_each_hw_ctx(q, hctx, i) {
> -               hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
> q->nr_requests, 0);
> +               hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
> +                               q->nr_requests, set->reserved_tags);
>                 if (!hctx->sched_tags) {
>                         ret = -ENOMEM;
>                         break;
> --

Now I'm getting a NULL deref with nvme-rdma [1].

For some reason blk_mq_tag_to_rq() is returning NULL on
tag 0x0 which is io queue connect.

I'll try to see where this is coming from.
This does not happen with loop though...

--
[   30.431889] nvme nvme0: creating 2 I/O queues.
[   30.465458] nvme nvme0: tag 0x0 on QP 0x84 not found
[   36.060168] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000030
[   36.063277] IP: bt_iter+0x31/0x50
[   36.064088] PGD 0

[   36.064088] Oops: 0000 [#1] SMP
[   36.064088] Modules linked in: nvme_rdma nvme_fabrics nvme_core 
mlx5_ib ppdev kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper 
cryptd i2c_piix4 joydev input_leds serio_raw parport_pc parport mac_hid 
ib_iser rdma_cm iw_cm ib_cm ib_core configfs iscsi_tcp libiscsi_tcp 
libiscsi sunrpc scsi_transport_iscsi autofs4 cirrus ttm drm_kms_helper 
syscopyarea sysfillrect mlx5_core sysimgblt fb_sys_fops psmouse drm 
floppy ptp pata_acpi pps_core
[   36.064088] CPU: 0 PID: 186 Comm: kworker/0:1H Not tainted 4.10.0+ #115
[   36.064088] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   36.064088] Workqueue: kblockd blk_mq_timeout_work
[   36.064088] task: ffff95f6393a0080 task.stack: ffffb826803ac000
[   36.064088] RIP: 0010:bt_iter+0x31/0x50
[   36.064088] RSP: 0018:ffffb826803afda0 EFLAGS: 00010202
[   36.064088] RAX: ffffb826803afdd0 RBX: ffff95f63c036800 RCX: 
0000000000000001
[   36.064088] RDX: ffff95f635ff0798 RSI: 0000000000000000 RDI: 
ffff95f63c036800
[   36.064088] RBP: ffffb826803afe18 R08: 0000000000000000 R09: 
0000000000000001
[   36.064088] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[   36.064088] R13: ffff95f635d7c240 R14: 0000000000000000 R15: 
ffff95f63c47ff00
[   36.064088] FS:  0000000000000000(0000) GS:ffff95f63fc00000(0000) 
knlGS:0000000000000000
[   36.064088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.064088] CR2: 0000000000000030 CR3: 000000003c8db000 CR4: 
00000000003406f0
[   36.064088] Call Trace:
[   36.064088]  ? blk_mq_queue_tag_busy_iter+0x191/0x1d0
[   36.064088]  ? blk_mq_rq_timed_out+0x70/0x70
[   36.064088]  ? blk_mq_rq_timed_out+0x70/0x70
[   36.064088]  blk_mq_timeout_work+0xba/0x160
[   36.064088]  process_one_work+0x16b/0x480
[   36.064088]  worker_thread+0x4b/0x500
[   36.064088]  kthread+0x101/0x140
[   36.064088]  ? process_one_work+0x480/0x480
[   36.064088]  ? kthread_create_on_node+0x40/0x40
[   36.064088]  ret_from_fork+0x2c/0x40
[   36.064088] Code: 89 d0 48 8b 3a 0f b6 48 18 48 8b 97 08 01 00 00 84 
c9 75 03 03 72 04 48 8b 92 80 00 00 00 89 f6 48 8b 34 f2 48 8b 97 98 00 
00 00 <48> 39 56 30 74 06 b8 01 00 00 00 c3 55 48 8b 50 10 48 89 e5 ff
[   36.064088] RIP: bt_iter+0x31/0x50 RSP: ffffb826803afda0
[   36.064088] CR2: 0000000000000030
[   36.064088] ---[ end trace 469df54df5f3cd87 ]---
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
