Return-Path: <axboe@kernel.dk>
Subject: Re: kmemleak complaints on request queue stats (virtio)
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c1659bc3-82e1-7d05-cec7-d5a6e78bd8e5@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <401a0b33-c8ea-d71d-7a9e-3dc47c9129ef@kernel.dk>
Date: Wed, 29 Mar 2017 11:04:07 -0600
MIME-Version: 1.0
In-Reply-To: <c1659bc3-82e1-7d05-cec7-d5a6e78bd8e5@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 03/29/2017 11:02 AM, Sagi Grimberg wrote:
> Hi,
> 
> I just got the below kmemleak report. Just thought I'd send it
> out as I don't have time to look into it just now...
> 
> --
> unreferenced object 0xffff8ab236717920 (size 32):
>    comm "swapper/0", pid 1, jiffies 4294892551 (age 9966.044s)
>    hex dump (first 32 bytes):
>      20 79 71 36 b2 8a ff ff 20 79 71 36 b2 8a ff ff   yq6.... yq6....
>      00 00 00 00 ff ff ff ff e0 c1 4b 9b ff ff ff ff  ..........K.....
>    backtrace:
>      [<ffffffff9b84212a>] kmemleak_alloc+0x4a/0xa0
>      [<ffffffff9b1ff780>] kmem_cache_alloc_trace+0x110/0x230
>      [<ffffffff9b3cd74f>] blk_alloc_queue_stats+0x1f/0x40
>      [<ffffffff9b3bacd4>] blk_alloc_queue_node+0x94/0x2e0
>      [<ffffffff9b3cbdd0>] blk_mq_init_queue+0x20/0x60
>      [<ffffffff9b593665>] loop_add+0xe5/0x270
>      [<ffffffff9bfe348b>] loop_init+0x10b/0x149
>      [<ffffffff9b002193>] do_one_initcall+0x53/0x1a0
>      [<ffffffff9bf8b133>] kernel_init_freeable+0x16d/0x1f3
>      [<ffffffff9b83ed0e>] kernel_init+0xe/0x100
>      [<ffffffff9b84d27c>] ret_from_fork+0x2c/0x40
>      [<ffffffffffffffff>] 0xffffffffffffffff

You don't mention what you are running? But I'm assuming it was my 4.12
branch. If so, this is fixed in a later revision of it.  If you pull an
update, it should go away.

-- 
Jens Axboe
