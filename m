Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: don't leak preempt counter/q_usage_counter when
 allocating rq failed
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <minlei@redhat.com>
References: <20170714084136.24850-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <224ed7ac-d864-c989-5a79-418fa3068825@kernel.dk>
Date: Tue, 1 Aug 2017 09:18:23 -0600
MIME-Version: 1.0
In-Reply-To: <20170714084136.24850-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/14/2017 02:41 AM, Ming Lei wrote:
> From: Ming Lei <minlei@redhat.com>
> 
> When blk_mq_get_request() failed, preempt counter isn't
> released, and blk_mq_make_request() doesn't release the counter
> too.
> 
> This patch fixes the issue, and makes sure that preempt counter
> is only held if rq is allocated successfully. The same policy is
> applied on .q_usage_counter too.

Can you replace the 'get_cpu' bool with just a ctx, and change
the logic to put it if set? I think that would be cleaner to read,
generally I hate bool 'do_something' variables that are set. It's
much cleaner to have:

if (likely(!data->ctx))
	data->ctx = local_ctx = blk_mq_get_ctx(q);

and have the put case be

if (local_ctx)
	blk_mq_put_ctx(local_ctx);

Either that, or at least just have blk_mq_get_request() do:

drop_ctx = data->ctx == NULL;

instead. The 'get_cpu' naming is confusing, we're worried about dropping
the sw queue here, the fact that it's related to get/put_cpu() need not
bubble up here.

-- 
Jens Axboe
