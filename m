Return-Path: <zwisler@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3eef2937-86bc-958a-99b5-96a67836d3d3@sandisk.com>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
 <20170531214350.31157-2-bart.vanassche@sandisk.com> <CAOxpaSVwuO6kRQN4aNELVTzfWbJORUNZh=E5xBRgvuC0wajptA@mail.gmail.com>
 <3eef2937-86bc-958a-99b5-96a67836d3d3@sandisk.com>
From: Ross Zwisler <zwisler@gmail.com>
Date: Wed, 14 Jun 2017 12:04:26 -0600
Message-ID: <CAOxpaSWss0nEvRu9R-u2DzqTwUBU2VefvJLwJZTio+X8Hnjdqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] block: Avoid that blk_exit_rl() triggers a use-after-free
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 9:19 AM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> On 06/13/17 10:54, Ross Zwisler wrote:
>> This commit is causing the following kernel BUG for me when I shut
>> down my systems:
>>
>>   BUG: sleeping function called from invalid context at kernel/workqueue.c:2790
>>   in_atomic(): 1, irqs_disabled(): 0, pid: 41, name: rcuop/3
>
> Thanks Ross for the testing and for the report. Can you check whether
> the patch below is sufficient to fix this?
>
>
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
>
> Reported-by: Ross Zwisler <zwisler@gmail.com>
> Fixes: commit b425e5049258 ("block: Avoid that blk_exit_rl() triggers a use-after-free")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Ross Zwisler <zwisler@gmail.com>

Yep, this solves the issue for me, thanks!

Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
