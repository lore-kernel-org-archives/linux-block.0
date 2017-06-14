Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/6] block: Avoid that blk_exit_rl() triggers a
 use-after-free
To: Bart Van Assche <bart.vanassche@sandisk.com>,
 Ross Zwisler <zwisler@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, stable@vger.kernel.org
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
 <20170531214350.31157-2-bart.vanassche@sandisk.com>
 <CAOxpaSVwuO6kRQN4aNELVTzfWbJORUNZh=E5xBRgvuC0wajptA@mail.gmail.com>
 <3eef2937-86bc-958a-99b5-96a67836d3d3@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c098cc8e-a029-28f3-c8ae-665959ea115b@kernel.dk>
Date: Wed, 14 Jun 2017 13:28:33 -0600
MIME-Version: 1.0
In-Reply-To: <3eef2937-86bc-958a-99b5-96a67836d3d3@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 09:19 AM, Bart Van Assche wrote:
> Subject: [PATCH] block: Fix a blk_exit_rl() regression
> 
> Avoid that the following complaint is reported:
> 
>  BUG: sleeping function called from invalid context at kernel/workqueue.c:2790
>  in_atomic(): 1, irqs_disabled(): 0, pid: 41, name: rcuop/3
>  1 lock held by rcuop/3/41:
>   #0:  (rcu_callback){......}, at: [<ffffffff8111f9a2>] rcu_nocb_kthread+0x282/0x500
>  Call Trace:
>   dump_stack+0x86/0xcf
>   ___might_sleep+0x174/0x260
>   __might_sleep+0x4a/0x80
>   flush_work+0x7e/0x2e0
>   __cancel_work_timer+0x143/0x1c0
>   cancel_work_sync+0x10/0x20
>   blk_throtl_exit+0x25/0x60
>   blkcg_exit_queue+0x35/0x40
>   blk_release_queue+0x42/0x130
>   kobject_put+0xa9/0x190

I added this, but the above is really a horrible changelog. It doesn't
say how the problem is fixed. I added some verbiage to that effect.

-- 
Jens Axboe
