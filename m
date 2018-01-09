Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: fix kernel oops in blk_mq_tag_idle()
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20180109132829.31479-1-ming.lei@redhat.com>
 <20180109152954.GA5512@kernel.dk>
Message-ID: <29e4933f-4955-ebe2-567c-0bc21025a2e7@kernel.dk>
Date: Tue, 9 Jan 2018 08:38:55 -0700
MIME-Version: 1.0
In-Reply-To: <20180109152954.GA5512@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 8:29 AM, Jens Axboe wrote:
> On Tue, Jan 09 2018, Ming Lei wrote:
>> HW queues may be unmapped in some cases, such as blk_mq_update_nr_hw_queues(),
>> then we need to check it before calling blk_mq_tag_idle(), otherwise
>> the following kernel oops can be triggered, so fix it by checking if
>> the hw queue is unmapped since it doesn't make sense to idle the tags
>> any more after hw queues are unmapped.
> 
> Seems cleaner to just move the mapped check to the idling function,
> especially since we already have the same check in the other spot where
> we call the idling.

Ho hum, I guess that requires shuffling some code/includes to
actually do that. I'll just apply yours as-is.

-- 
Jens Axboe
