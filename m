Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: don't leak preempt counter/q_usage_counter
 when allocating rq failed
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <minlei@redhat.com>
References: <20170802000145.5996-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ffe9c3f6-0d27-052b-04b6-c717ed10e5e4@kernel.dk>
Date: Wed, 2 Aug 2017 08:24:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170802000145.5996-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/01/2017 06:01 PM, Ming Lei wrote:
> From: Ming Lei <minlei@redhat.com>
> 
> When blk_mq_get_request() failed, preempt counter isn't
> released, and blk_mq_make_request() doesn't release the counter
> too.
> 
> This patch fixes the issue, and makes sure that preempt counter
> is only held if rq is allocated successfully. The same policy is
> applied on .q_usage_counter too.

Thanks, applied for this series.

-- 
Jens Axboe
