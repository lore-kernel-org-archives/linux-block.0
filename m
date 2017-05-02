Subject: Re: [PATCH] block: don't call blk_mq_quiesce_queue() after queue is
 freezed
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20170501232802.27219-1-ming.lei@redhat.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <6d3f0b46-1980-aa0a-04c7-7ac91d4a785b@fb.com>
Date: Tue, 2 May 2017 11:33:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170501232802.27219-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/01/2017 05:28 PM, Ming Lei wrote:
> After queue is freezed, no request in this queue can be in use
> at all, so there can't be any .queue_rq() is running on this queue.
> It isn't necessary to call blk_mq_quiesce_queue() any more, so
> remove it in both elevator_switch_mq() and blk_mq_update_nr_requests().

Added, thanks Ming.

-- 
Jens Axboe
