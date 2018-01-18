Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: don't dispatch request in
 blk_mq_request_direct_issue if queue is busy
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org
References: <20180118040659.20202-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5f7edaad-6541-4e9d-996c-db982fa283a9@kernel.dk>
Date: Wed, 17 Jan 2018 21:39:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180118040659.20202-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/17/18 9:06 PM, Ming Lei wrote:
> If we run into blk_mq_request_direct_issue(), when queue is busy, we
> don't want to dispatch this request into hctx->dispatch_list, and
> what we need to do is to return the queue busy info to caller, so
> that caller can deal with it well.

Thanks for fixing this up, applied.

-- 
Jens Axboe
