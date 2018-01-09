Return-Path: <ming.lei@redhat.com>
Date: Tue, 9 Jan 2018 23:48:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: fix kernel oops in blk_mq_tag_idle()
Message-ID: <20180109154824.GD4356@ming.t460p>
References: <20180109132829.31479-1-ming.lei@redhat.com>
 <20180109152954.GA5512@kernel.dk>
 <29e4933f-4955-ebe2-567c-0bc21025a2e7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29e4933f-4955-ebe2-567c-0bc21025a2e7@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 09, 2018 at 08:38:55AM -0700, Jens Axboe wrote:
> On 1/9/18 8:29 AM, Jens Axboe wrote:
> > On Tue, Jan 09 2018, Ming Lei wrote:
> >> HW queues may be unmapped in some cases, such as blk_mq_update_nr_hw_queues(),
> >> then we need to check it before calling blk_mq_tag_idle(), otherwise
> >> the following kernel oops can be triggered, so fix it by checking if
> >> the hw queue is unmapped since it doesn't make sense to idle the tags
> >> any more after hw queues are unmapped.
> > 
> > Seems cleaner to just move the mapped check to the idling function,
> > especially since we already have the same check in the other spot where
> > we call the idling.
> 
> Ho hum, I guess that requires shuffling some code/includes to
> actually do that. I'll just apply yours as-is.

Yes, that need to move blk_mq_hw_queue_mapped() into blk-mq-tag.h
since the two headers are included by each other, seem some cleanup
are needed for headers.

Thanks,
Ming
