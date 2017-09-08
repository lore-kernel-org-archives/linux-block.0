Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170908003636.77349-1-gthelen@google.com>
References: <20170908003636.77349-1-gthelen@google.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 8 Sep 2017 09:24:39 +0800
Message-ID: <CACVXFVMwZkEuVXJg_ysLNYNPL5dUXO-dPcbKWGNJJc6iqsQDOQ@mail.gmail.com>
Subject: Re: [PATCH] block: tolerate tracing of NULL bio
To: Greg Thelen <gthelen@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 8, 2017 at 8:36 AM, Greg Thelen <gthelen@google.com> wrote:
> __get_request() can call trace_block_getrq() with bio=NULL which causes
> block_get_rq::TP_fast_assign() to deref a NULL pointer and panic.
>
> Syzkaller fuzzer panics with
> linux-next (1d53d908b79d7870d89063062584eead4cf83448):
>   kasan: GPF could be caused by NULL-ptr deref or user memory access
>   general protection fault: 0000 [#1] SMP KASAN
>   Modules linked in:
>   CPU: 0 PID: 2983 Comm: syzkaller401111 Not tainted 4.13.0-rc7-next-20170901+ #13
>   task: ffff8801cf1da000 task.stack: ffff8801ce440000
>   RIP: 0010:perf_trace_block_get_rq+0x697/0x970 include/trace/events/block.h:384
>   RSP: 0018:ffff8801ce4473f0 EFLAGS: 00010246
>   RAX: ffff8801cf1da000 RBX: 1ffff10039c88e84 RCX: 1ffffd1ffff84d27
>   RDX: dffffc0000000001 RSI: 1ffff1003b643e7a RDI: ffffe8ffffc26938
>   RBP: ffff8801ce447530 R08: 1ffff1003b643e6c R09: ffffe8ffffc26964
>   R10: 0000000000000002 R11: fffff91ffff84d2d R12: ffffe8ffffc1f890
>   R13: ffffe8ffffc26930 R14: ffffffff85cad9e0 R15: 0000000000000000
>   FS:  0000000002641880(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000000000043e670 CR3: 00000001d1d7a000 CR4: 00000000001406f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>     trace_block_getrq include/trace/events/block.h:423 [inline]
>     __get_request block/blk-core.c:1283 [inline]
>     get_request+0x1518/0x23b0 block/blk-core.c:1355
>     blk_old_get_request block/blk-core.c:1402 [inline]
>     blk_get_request+0x1d8/0x3c0 block/blk-core.c:1427
>     sg_scsi_ioctl+0x117/0x750 block/scsi_ioctl.c:451
>     sg_ioctl+0x192d/0x2ed0 drivers/scsi/sg.c:1070
>     vfs_ioctl fs/ioctl.c:45 [inline]
>     do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:685
>     SYSC_ioctl fs/ioctl.c:700 [inline]
>     SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
>     entry_SYSCALL_64_fastpath+0x1f/0xbe
>
> block_get_rq::TP_fast_assign() has multiple redundant ->dev assignments.
> Only one of them is NULL tolerant.  Favor the NULL tolerant one.
>
> Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  include/trace/events/block.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index f815aaaef755..1fd7ff1a46f7 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -397,7 +397,6 @@ DECLARE_EVENT_CLASS(block_get_rq,
>
>         TP_fast_assign(
>                 __entry->dev            = bio ? bio_dev(bio) : 0;
> -               __entry->dev            = bio_dev(bio);
>                 __entry->sector         = bio ? bio->bi_iter.bi_sector : 0;
>                 __entry->nr_sector      = bio ? bio_sectors(bio) : 0;
>                 blk_fill_rwbs(__entry->rwbs,
> @@ -414,7 +413,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
>  /**
>   * block_getrq - get a free request entry in queue for block IO operations
>   * @q: queue for operations
> - * @bio: pending block IO operation
> + * @bio: pending block IO operation (can be %NULL)
>   * @rw: low bit indicates a read (%0) or a write (%1)
>   *
>   * A request struct for queue @q has been allocated to handle the
> @@ -430,7 +429,7 @@ DEFINE_EVENT(block_get_rq, block_getrq,
>  /**
>   * block_sleeprq - waiting to get a free request entry in queue for block IO operation
>   * @q: queue for operation
> - * @bio: pending block IO operation
> + * @bio: pending block IO operation (can be %NULL)
>   * @rw: low bit indicates a read (%0) or a write (%1)
>   *
>   * In the case where a request struct cannot be provided for queue @q
> --
> 2.14.1.581.gf28d330327-goog
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
