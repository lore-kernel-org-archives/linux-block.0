Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Chinner <dchinner@redhat.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
 Matthew Wilcox <willy@infradead.org>
References: <20181018131817.11813-1-ming.lei@redhat.com>
 <20181018131817.11813-2-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
Date: Thu, 18 Oct 2018 08:27:28 -0600
MIME-Version: 1.0
In-Reply-To: <20181018131817.11813-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/18 7:18 AM, Ming Lei wrote:
> Now we only check if DMA IO buffer is aligned to queue_dma_alignment()
> for pass-through request, and it isn't done for normal IO request.
> 
> Given the check has to be done on each bvec, it isn't efficient to add the
> check in generic_make_request_checks().
> 
> This patch addes one WARN in blk_queue_split() for capturing this issue.

I don't want to do this, because then we are forever doomed to
have something that fully loops a bio at submission time. I
absolutely hate the splitting we have and the need for it,
hopefully it can go away for a subset of IOs at some point.

In many ways, this seems to be somewhat of a made-up problem, I don't
recall a single bug report for something like this over decades of
working with the IO stack. 512b alignment restrictions for DMA seems
absolutely insane. I know people claim they exist, but clearly that
isn't a hard requirement or we would have been boned years ago.

-- 
Jens Axboe
