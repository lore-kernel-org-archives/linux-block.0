Subject: Re: [PATCH v3 1/2] blk-mq: use sbq wait queues instead of restart for
 driver tags
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <ff44cc50b198ea38b4040fd66e8301249d6be69b.1487789478.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <1ce50e5e-14a9-e9ab-1fd9-d1e4d1df0773@fb.com>
Date: Thu, 23 Feb 2017 11:56:22 -0700
MIME-Version: 1.0
In-Reply-To: <ff44cc50b198ea38b4040fd66e8301249d6be69b.1487789478.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 11:58 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 50e1dab86aa2 ("blk-mq-sched: fix starvation for multiple hardware
> queues and shared tags") fixed one starvation issue for shared tags.
> However, we can still get into a situation where we fail to allocate a
> tag because all tags are allocated but we don't have any pending
> requests on any hardware queue.
> 
> One solution for this would be to restart all queues that share a tag
> map, but that really sucks. Ideally, we could just block and wait for a
> tag, but that isn't always possible from blk_mq_dispatch_rq_list().
> 
> However, we can still use the struct sbitmap_queue wait queues with a
> custom callback instead of blocking. This has a few benefits:
> 
> 1. It avoids iterating over all hardware queues when completing an I/O,
>    which the current restart code has to do.
> 2. It benefits from the existing rolling wakeup code.
> 3. It avoids punting to another thread just to have it block.

Applied 1-2, thanks Omar.

-- 
Jens Axboe
