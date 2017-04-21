Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix preempt count imbalance
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170421175842.9208-1-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b4e336ce-2f8f-ae8b-4086-ce949f31ded5@kernel.dk>
Date: Fri, 21 Apr 2017 11:59:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170421175842.9208-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/21/2017 11:58 AM, Bart Van Assche wrote:
> Avoid that the following kernel bug gets triggered:
> 
> BUG: sleeping function called from invalid context at ./include/linux/buffer_head.h:349
> in_atomic(): 1, irqs_disabled(): 0, pid: 8019, name: find
> CPU: 10 PID: 8019 Comm: find Tainted: G        W I     4.11.0-rc4-dbg+ #2
> Call Trace:
>  dump_stack+0x68/0x93
>  ___might_sleep+0x16e/0x230
>  __might_sleep+0x4a/0x80
>  __ext4_get_inode_loc+0x1e0/0x4e0
>  ext4_iget+0x70/0xbc0
>  ext4_iget_normal+0x2f/0x40
>  ext4_lookup+0xb6/0x1f0
>  lookup_slow+0x104/0x1e0
>  walk_component+0x19a/0x330
>  path_lookupat+0x4b/0x100
>  filename_lookup+0x9a/0x110
>  user_path_at_empty+0x36/0x40
>  vfs_statx+0x67/0xc0
>  SYSC_newfstatat+0x20/0x40
>  SyS_newfstatat+0xe/0x10
>  entry_SYSCALL_64_fastpath+0x18/0xad
> 
> Fixes: b00c53e8f411 ("blk-mq: fix schedule-while-atomic with scheduler attached")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4130c7730d6d..f5d24a94ae68 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1631,6 +1631,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
>  		blk_mq_put_ctx(data.ctx);
>  		blk_mq_run_hw_queue(data.hctx, true);
> +	} else {
> +		blk_mq_put_ctx(data.ctx);
>  	}
>  
>  	return cookie;

Good catch! Thanks Bart, will add.

-- 
Jens Axboe
