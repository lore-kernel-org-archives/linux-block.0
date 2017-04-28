Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20170428151539.25514-1-ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
Date: Fri, 28 Apr 2017 14:29:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170428151539.25514-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 09:15 AM, Ming Lei wrote:
> Hi,
> 
> This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
> allows to use hardware tag directly for IO scheduling if the queue's
> depth is big enough. In this way, we can avoid to allocate extra tags
> and request pool for IO schedule, and the schedule tag allocation/release
> can be saved in I/O submit path.

Ming, I like this approach, it's pretty clean. It'd be nice to have a
bit of performance data to back up that it's useful to add this code,
though.  Have you run anything on eg kyber on nvme that shows a
reduction in overhead when getting rid of separate scheduler tags?

-- 
Jens Axboe
