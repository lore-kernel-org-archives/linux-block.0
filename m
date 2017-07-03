Subject: Re: [PATCH] blk-mq-sched: fix performance regression of mq-deadline
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20170703123714.23138-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <747c006e-f565-56b6-4710-967523dce7aa@fb.com>
Date: Mon, 3 Jul 2017 16:53:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170703123714.23138-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/03/2017 06:37 AM, Ming Lei wrote:
> When mq-deadline is taken, IOPS of sequential read and
> seqential write is observed more than 20% drop on sata(scsi-mq)
> devices, compared with using 'none' scheduler.
> 
> The reason is that the default nr_requests for scheduler is
> too big for small queuedepth devices, and latency is increased
> much.
> 
> Since the principle of taking 256 requests for mq scheduler
> is based on 128 queue depth, this patch changes into
> double size of min(hw queue_depth, 128).

That's somewhat odd, but it's a better default than some random
value. I'll apply it, thanks Ming.

-- 
Jens Axboe
