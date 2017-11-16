Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: wake up all tasks blocked in get_request()
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>
References: <20171116000844.22159-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <add43efd-276d-1fd1-f425-01c170491c6a@kernel.dk>
Date: Wed, 15 Nov 2017 21:50:06 -0700
MIME-Version: 1.0
In-Reply-To: <20171116000844.22159-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/15/2017 05:08 PM, Ming Lei wrote:
> Once blk_set_queue_dying() is done in blk_cleanup_queue(), we call
> blk_freeze_queue() and wait for q->q_usage_counter becoming zero. But if
> there are tasks blocked in get_request(), q->q_usage_counter can never
> become zero. So we have to wake up all these tasks in blk_set_queue_dying()
> first.

Looks correct to me, since we do exclusive waits on that waitqueue.
Applied for this series.

> Fixes: 3ef28e83ab157997(block: generic request_queue reference counting)

Note that the format here is ("patch title")

-- 
Jens Axboe
